Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3978EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25A32192D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="XjXAnwnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfBIRbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:31:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBIRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:31:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so3677375wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CwjJkWcTfhMeLygDFIS4uxc6Yk5SMG5tD0dVA9Gy5mk=;
        b=XjXAnwnET7hn5ol85H85DSc+Sp7d0d616EowqLPnzsDKQuuz1tC9HTo6kC47m0QTZm
         dSZojFCy7f8Z0XkaDDii0ekUcgURezJT8gGZ5lqqQ/E6t4tyiGJ3Q8DpwK2TNhG76xry
         sO7e5i2A+EkBnVqLNvJR0rhHmY7T9IXIOj4THYySRop7DLZHcIKfP7R/RQ1TRLW58qeW
         lJ8K2vo+jC3LNYARVk8N5GD36rMDSzmgOec/Uz1+1kOzGvaeKSS1VB3ueImDekFnssRR
         r7O7DL/Ylhy/aid8/4IaJGDMmX161B3CGfIeW2MheAzQgmC5LH+qwficDhHpuq6pdZM2
         7oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwjJkWcTfhMeLygDFIS4uxc6Yk5SMG5tD0dVA9Gy5mk=;
        b=rRNQJUQ927QLZ+iuSn3VNwFzJuuM+veFnpjmGfQRXwS+CFaoIsxd/J8VKvwmmclCkz
         tDk94tC4kcdWAISGeEubOyylxuvPrLM0SbL5SdToLDpoQJpfpacO16BWYGulPmyDiWMG
         eFnmC9rW2Ss3aAgnRsnHt6izKD5NRa/3rkeecQ5YuI7ri4/GYvDbbCyPbbqPxfZGkjdh
         kV6fze03QTxhrqAiGpsBeme15AsRBvtcMvEfSTU7EoIIv2pBmTznrnEMRHR8TVYHoq0U
         P3Bw5J1ZcNH0cbK+/qxnLnRerXU8ylfBoneuJwb0+zt5UooUuT2F7ewoTVzgwUk4DGIZ
         UNpw==
X-Gm-Message-State: AHQUAubolYHyXCjVBLqmnLrK6lxnlMaSrww8vSbnvWpLS8GtNuODgTL6
        OC9VcROki+JVrNK6St7B6K1m1A==
X-Google-Smtp-Source: AHgI3IYG92a2OopXkoV+1c+gdNVlT2T4pHl8c/kkD4M7B4jAqoC5xF4KAGD9+L0iYBTIEminXbt+tw==
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr3617949wme.82.1549733500619;
        Sat, 09 Feb 2019 09:31:40 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id y185sm5310230wmg.34.2019.02.09.09.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:31:40 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:22:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 01/16] Documentation: networking: switchdev:
 Update port parent ID section
Message-ID: <20190209172228.GH2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:33AM CET, f.fainelli@gmail.com wrote:
>Update the section about switchdev drivers having to implement a
>switchdev_port_attr_get() function to return
>SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
>commit bccb30254a4a ("net: Get rid of
>SWITCHDEV_ATTR_ID_PORT_PARENT_ID").
>
>Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> Documentation/networking/switchdev.txt | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
>index f3244d87512a..2842f63ad47b 100644
>--- a/Documentation/networking/switchdev.txt
>+++ b/Documentation/networking/switchdev.txt
>@@ -92,11 +92,11 @@ device.
> Switch ID
> ^^^^^^^^^
> 
>-The switchdev driver must implement the switchdev op switchdev_port_attr_get
>-for SWITCHDEV_ATTR_ID_PORT_PARENT_ID for each port netdev, returning the same
>-physical ID for each port of a switch.  The ID must be unique between switches
>-on the same system.  The ID does not need to be unique between switches on
>-different systems.
>+The switchdev driver must implement the net_device operation
>+ndo_get_port_parent_id for each port netdev,  returning the same physical ID

Double space. Otherwise, this looks fine.

Acked-by: Jiri Pirko <jiri@mellanox.com>


>+for each port of a switch. The ID must be unique between switches on the same
>+system. The ID does not need to be unique between switches on different
>+systems.
> 
> The switch ID is used to locate ports on a switch and to know if aggregated
> ports belong to the same switch.
>-- 
>2.17.1
>
