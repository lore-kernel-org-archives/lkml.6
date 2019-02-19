Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5803C20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="EWxaB6sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfBSKdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfBSKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so9418953wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQDyHqOvUcj4FAsXSdC/kmRv0ETWzYOwOSqV3VOHxjk=;
        b=EWxaB6svBcGce8egr76tIBw/782BQMLvjnzkjOjg4yc44l+vYRPgz7zAEd44nga+aF
         sZ4w7Ahsx+HzE7jWtnAaXvFz0lxhB/YTA2Z5i4ZDezSoBcvNXjcACED1bD8ZUW58AFc/
         sG1CeoPMFlNAXXegui3D4QqD9+mFIcpzwxx4VCQgNulNg2K51Eqt41XaDXwimO+u7mIe
         G0uYnEFZPY8aqdpqmxxJ09240qunyKMOxwyKH6tp7pgyUAoAe14osiblCaNrOd0DQtxd
         iuAlQA1lVGlYcaaQun7L7erF6Fr7EAaSxY050XkHNxrQsd7zo14Zo5jUNIApGT1xLROO
         dusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQDyHqOvUcj4FAsXSdC/kmRv0ETWzYOwOSqV3VOHxjk=;
        b=pxy9nXoC8zdyAn8WuVHRF1jQGzHmbJ/DfCCxzAdp5xcn2JIOc/UYaPpchkS8pbomH2
         jBkeja+3cEf7MPtnPddvGffcL3f16SQyo/+AHKnUekotYnHeKwGUyULY/NTRECy07MxO
         VqEFl/1fhD1r7DkoIuNlfUU/smp+cR1W/c5Zwb3DIqlzCtAVSdteJvN7zHezTQWEHwS9
         UmReLC7i/KLmi2ghml5UvG7eOyf6zOYete+CEX979OWpcL3oicc8CNyPP85e3kmz3iAq
         uUa5xEw1o7f+tjM8X8NVfBuj6SrIFKP4rNMPxSnZ298bJkR6eO6fUWl7mKK7LE0D8PK4
         3cIg==
X-Gm-Message-State: AHQUAub4egSPoGA3bXc/QlT5THJOl6HSRpPP5x46qK76IvRLt70Hd+4g
        ODzSHIs12J5QU90Gl2Aqx5q11w==
X-Google-Smtp-Source: AHgI3IaFbHVffEoKhsDwURPZP1wXsemt11fQfRTJE1wVDZnuAkTiWZnHUu4fac09lWpc4pNAwpJtBQ==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr21117866wrr.233.1550572415627;
        Tue, 19 Feb 2019 02:33:35 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id j15sm12624481wrt.1.2019.02.19.02.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 02:33:35 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:24:00 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 12/21] ethtool: provide permanent
 hardware address in GET_INFO request
Message-ID: <20190219102400.GC3080@nanopsycho>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <4e5879e36289c526dc79db37e55e5fc7d89d15fe.1550513384.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5879e36289c526dc79db37e55e5fc7d89d15fe.1550513384.git.mkubecek@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 18, 2019 at 07:22:24PM CET, mkubecek@suse.cz wrote:
>Add information about permanent hadware address of a device (as provided by
>ETHTOOL_GPERMADDR ioctl command) in GET_INFO reply if ETH_INFO_IM_PERMADDR
>flag is set in the request.
>
>There is no separate attribute for hardware address length as nla_len gives
>this information. The reply also provides address type (net_device::type).
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> Documentation/networking/ethtool-netlink.txt |  9 ++++-
> include/uapi/linux/ethtool_netlink.h         | 12 +++++-
> net/ethtool/info.c                           | 39 ++++++++++++++++++++
> 3 files changed, 58 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
>index b6999a2167e8..1e615e111262 100644
>--- a/Documentation/networking/ethtool-netlink.txt
>+++ b/Documentation/networking/ethtool-netlink.txt
>@@ -239,6 +239,9 @@ Kernel response contents:
>         ETHA_DRVINFO_FWVERSION		(string)	firmware version
>         ETHA_DRVINFO_BUSINFO		(string)	device bus address
>         ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
>+    ETHA_INFO_PERMADDR		(nested)
>+        ETHA_PERMADDR_ADDRESS		(binary)	permanent HW address

I think this is a nice example of thing that should not be exposed with
ethtool but rather via rtnetlink, alongside with the actual hw address.

[...]
