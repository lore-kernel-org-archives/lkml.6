Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A420C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="eKfCkoHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfBKMiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:38:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36577 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfBKMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:38:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so173629wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VS21sFG84GLc3QRG/1Shmpp1t22LuWOgpCsdW2q5MI=;
        b=eKfCkoHJwa5rJdq3xftrKkvXc8fvfxnYDun5gP2peH2RKr58HgnLOdo/QSlwziCgQp
         y/JJ9FlCSP+4U7+p53mJt5tyJ9uUgnNIgn2rFmMXURCW62/NBHOLaCq8KLhZtIfuss0U
         L5t0KmsEOQEs9Gf0GKzSg4TCoM5vBhzOzufNGxfya490z5f2Ub9uzomzuDEGiTAjLv7/
         snBPJVk1+xaQNOuV9LgMuu81wc5047ACCbLlizZGLwtcB+2QpsNoaMM23/LkJuIdJ2rB
         yfLVmK4glcdPGTST/HafryR54Ta9NzjxBimB3noRB+zOgN4NBJjMTMx8E0gHILZV1fCX
         bzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VS21sFG84GLc3QRG/1Shmpp1t22LuWOgpCsdW2q5MI=;
        b=Hlyl5c/dnZTaJ2CFOwF9v9AE2Yt+sCssqzo2p8VKAGQTix0dSLz2EdDf0mYFZ3lPlw
         xelCBvUUzk/gdTh1jW5vO/jZNYYQX/D2t+9qB9oZBwBJxFok1QvgAg6dF17YIkvBm6ol
         89pQvtI5EwYmArTNQelLPlr29w58XpAzjyguSyviylswMbn7j/+iUPR10qNRrtIdFChw
         aEEAN73Rluxd3aFykidVo+XFiiiWTlQOr9QiRSC8ypZH6Z8/JKOkKv4Oj9oQzV1Yj7oB
         VcHwhZVPpRsdPuUDyjJm8zXcMO0MQYZrezqdTBSTQooQJIzoYrAGsThh7PNi/MZv0OfE
         iJBg==
X-Gm-Message-State: AHQUAuYkKTD7ZR1j7Y9vWiv+50q0RSB+GYslD1ylJ4ijclT5mt7wf1ju
        b7dxMnsdnfSkfp7tK8zKbaWUKA==
X-Google-Smtp-Source: AHgI3IauEcJE8ohfUn8CL1IyuVTPHVe5Iw6rHAKO5AeZlfwAp9O0uE9+zGFX/W4msyWYlZ7TVotR+w==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr28771190wrs.289.1549888729807;
        Mon, 11 Feb 2019 04:38:49 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id y24sm20762871wma.0.2019.02.11.04.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:38:49 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:29:26 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 5/9] net: mscc: ocelot: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Message-ID: <20190211122926.GH2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-6-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:03AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting
>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare ocelot to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
>ocelot_port_attr_{set,get} calls.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> drivers/net/ethernet/mscc/ocelot.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
>
>diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
>index 195306d05bcd..850a49033a30 100644
>--- a/drivers/net/ethernet/mscc/ocelot.c
>+++ b/drivers/net/ethernet/mscc/ocelot.c
>@@ -1582,6 +1582,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
> };
> EXPORT_SYMBOL(ocelot_netdevice_nb);
> 
>+static int
>+ocelot_switchdev_port_attr_event(unsigned long event,
>+		struct net_device *netdev,
>+		struct switchdev_notifier_port_attr_info *port_attr_info)
>+{
>+	int err = -EOPNOTSUPP;
>+
>+	switch (event) {
>+	case SWITCHDEV_PORT_ATTR_SET:
>+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
>+					   port_attr_info->trans);
>+		break;
>+	}
>+
>+	port_attr_info->handled = true;
>+	return notifier_from_errno(err);
>+}
>+
> static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
> 					   unsigned long event, void *ptr)
> {
>@@ -1600,6 +1618,9 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
> 						    ocelot_netdevice_dev_check,
> 						    ocelot_port_obj_del);
> 		return notifier_from_errno(err);
>+	case SWITCHDEV_PORT_ATTR_SET:
>+	case SWITCHDEV_PORT_ATTR_GET: /* fallthrough */

I think that the "fallthrough" comment should be for "ATTR_SET" case.

Anyway:
Acked-by: Jiri Pirko <jiri@mellanox.com>



>+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
> 	}
> 
> 	return NOTIFY_DONE;
>-- 
>2.19.1
>
