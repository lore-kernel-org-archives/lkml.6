Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABCFC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE05214DA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xVMPdRV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBISbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:31:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53108 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfBISbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:31:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so9480224wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yr8T0OftPvmj7cclVgXC3g3ec7i9ITG1oi95HtFGeUA=;
        b=xVMPdRV41wVTjgRTVgGLPvjDAodOzGZPxmufekf6OnvrgmdmsFclF/xyCjG2tBkJYz
         /hVX3HExy5GrGpCfWddHdCQdkGO5QHvq6oRkdfV7IZGQgecyi1bRHcaASnx7jRt41B5M
         29o5V9Gapgsn3hwYq38VOzE1niEKSLf524LJEzGy8YBW/oOiqVqSl4j2NDdYKjjdiBxE
         3hveg7y0y6jzYggFsgCguL3P7BGVvRBGdFV1q3eKT6aYZk7oC2MaHejbHzNf0pty0L89
         9zxTxtEUeDuXZy7FB7InzivSuOcpGhLjHvaFkaKAcQf+xjDissekcWE2flouEjECH+zK
         2MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yr8T0OftPvmj7cclVgXC3g3ec7i9ITG1oi95HtFGeUA=;
        b=nnBHjg+1ZDK7Vt9v/y1H1kE8/agxv+yzf6QP/5u/s4eoul/TiN/50rAO8tBhalPCru
         Ns32+XseLpUcEfZQgLzkRzh3XWyi0XW0LBalUm7eY+xLWJlJeAvPISrKFUaBKzo6JvHr
         65T4ciEGcyvcG6/O6AkObv+Rhcwh9UclprMt9RFwey0l4DUU6u6fPtHwAQN3jqpdQkan
         /uGEQuZANkwGc9qBqRZsm0+FCK1w2zSHdOMWEobxOaROQfMMNanoORKSvLpzXbOmjGX6
         rlK+94TJHiFz3THGJv4zfdrGEnoHxvLkz0OYsT7q8wNHVSCZHEvR1nSqsVcA0tN+JTsn
         bstQ==
X-Gm-Message-State: AHQUAuailIR8L3n8keGVTE1yZKbuuOFmeV4g1j1fW74vfYBOyWhfDM1y
        +NArz13lEKs+Ldf/jACUx9tPJg==
X-Google-Smtp-Source: AHgI3IYCpRzH711asp/DrW+Wx2S6RJ/bEsO+I4DygtBSoz3d2mi03pBpV/vomH9F+A0Cl5mwY/2RBA==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr13757602wrv.328.1549737059704;
        Sat, 09 Feb 2019 10:30:59 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id n3sm6070462wmf.46.2019.02.09.10.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:30:59 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:21:47 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 10/16] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Message-ID: <20190209182147.GQ2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-11-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-11-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:42AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting

Just "setting", no "getting".


>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare rocker to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
>rocker_port_attr_set call.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> drivers/net/ethernet/rocker/rocker_main.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
>diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
>index ff3f14504f4f..f10e4888ecff 100644
>--- a/drivers/net/ethernet/rocker/rocker_main.c
>+++ b/drivers/net/ethernet/rocker/rocker_main.c
>@@ -2811,6 +2811,24 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
> 	return notifier_from_errno(err);
> }
> 
>+static int
>+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
>+				 struct switchdev_notifier_port_attr_info
>+				 *port_attr_info)
>+{
>+	int err = -EOPNOTSUPP;
>+
>+	switch (event) {
>+	case SWITCHDEV_PORT_ATTR_SET:

Do you expect some other event to be handled in
rocker_switchdev_port_attr_event()? Because you have SWITCHDEV_PORT_ATTR_SET
selected in case here and in rocker_switchdev_blocking_event.
Perhaps you can rename rocker_switchdev_port_attr_event() to
rocker_switchdev_port_attr_set_event() and avoid this switchcase.


>+		err = rocker_port_attr_set(netdev, port_attr_info->attr,
>+					   port_attr_info->trans);
>+		break;
>+	}
>+
>+	port_attr_info->handled = true;
>+	return notifier_from_errno(err);
>+}
>+
> static int rocker_switchdev_blocking_event(struct notifier_block *unused,
> 					   unsigned long event, void *ptr)
> {
>@@ -2823,6 +2841,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
> 	case SWITCHDEV_PORT_OBJ_ADD:
> 	case SWITCHDEV_PORT_OBJ_DEL:
> 		return rocker_switchdev_port_obj_event(event, dev, ptr);
>+	case SWITCHDEV_PORT_ATTR_SET:
>+		return rocker_switchdev_port_attr_event(event, dev, ptr);
> 	}
> 
> 	return NOTIFY_DONE;
>-- 
>2.17.1
>
