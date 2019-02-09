Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D12C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68664214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="x4o0l+wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfBIS1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:27:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51366 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBIS1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:27:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so9485019wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Lx6peKHjz4R62UCqF23ivxwr26573IpoC+89wKcbE4=;
        b=x4o0l+wyzmXFnHiFSSmHjqiCwtYg78BGye7FoUq12TMcCxRVoLSLZSsnoNgeqVeCSg
         lTeyduwMbSycSbIbF2VG05LOvyy+dfGR5RFvg2bG3l7fuQGkRfStaFIc4tZY5DR0g9Hu
         NqY2jlF8js5wYhajzl1QkmAsg1okIVdInqouXVyUBsx/41MTqNp2Kj+KLFGqx/UBhUS0
         O5MqK7YuI4RHyN6U/rtvL3rJLHlad9u4aO951KkwFDZ8Dq9QVU2/ly3w/U2sMJzerXRE
         oq+5lhNDxuNd4u6GyIonPAjcQIEo5XVT/79DrDavi9tFNiLg4rJgTq7W6wGZjyG0eHAa
         BqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Lx6peKHjz4R62UCqF23ivxwr26573IpoC+89wKcbE4=;
        b=VI9l6HC3C/b0mIpDe+0kPFMZAyF806xKjvLEn1D2pasWOJUhtqwYMvM449mDNXujkZ
         BrqPI6+cLDdy0Cd6DgF6OYMczLwr9CcvaYpZI9dRipfTbi03rJGI6VUw39w1oCBjDBnd
         jTM8+f3KFS9lqQhQPQivpe7LG3fdRglCZs6J8HMBFz1uppaQSsHphAONShX8Y3u5oz4D
         PO+0L+SCLXaw9T1scddVGt49SpYud/RvVWWmZ54oVcMV/M0qZNwztkT4GZ8hAzU4pooc
         6BnJE5shqW6mn9x0iarW4XiPrXSBB1chyFsBOGBVOcmLSHbS4IocMDGJG7Y4PLe2Hjbt
         ViMA==
X-Gm-Message-State: AHQUAubor21GW+ruufIl+XKDY4Yn92wiiPbKna1RijcH7zIAKXgGpEQ1
        HlbWfmPTU3uUMw8FALUgHOpUxA==
X-Google-Smtp-Source: AHgI3IbA4ttiHzl6sga/HIIjdQIZkWIcDfQKgb8fcgLbywjx1YzihJ3MeIlzcBDZJok/teLoR/tBWA==
X-Received: by 2002:a1c:ca09:: with SMTP id a9mr3701731wmg.28.1549736867394;
        Sat, 09 Feb 2019 10:27:47 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id e17sm3151101wrs.79.2019.02.09.10.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:27:47 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:18:35 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 09/16] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Message-ID: <20190209181835.GP2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-10-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:41AM CET, f.fainelli@gmail.com wrote:
>In preparation for allowing switchdev enabled drivers to veto specific
>attribute settings from within the context of the caller, introduce a
>new switchdev notifier type for port attributes.
>
>Suggested-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> include/net/switchdev.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>index 96cd3e795f7f..4c5f7e5430cf 100644
>--- a/include/net/switchdev.h
>+++ b/include/net/switchdev.h
>@@ -141,6 +141,8 @@ enum switchdev_notifier_type {
> 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
> 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
> 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
>+
>+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */

This is not UAPI. You can put it next to SWITCHDEV_PORT_OBJ_ADD and
SWITCHDEV_PORT_OBJ_DEL. Up to you.

With or without that:
Acked-by: Jiri Pirko <jiri@mellanox.com>
