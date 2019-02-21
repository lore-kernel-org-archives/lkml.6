Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6132147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="l2HwRnl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfBUKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:07:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfBUKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:07:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so15896766wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KdKQ418cC4hW5+ONG+QHC8Knc3pXZoUSBDqx6kg1BkM=;
        b=l2HwRnl5VOsdArJ2K5Vkw/h9Hn679KhlO5BJNWqhQEOzJQ7uG37Vy3H8G2q7ikAn8N
         W9IVZ/wPHEOBUo1B6vwFG7yOPnBAnMUZ3O3Y9dAjbJRAlM51cCNROtIXM5M9i9fPWbyZ
         5mBuq/tgz/18YP8esE+ZZaTPxrTve8/VYrRfxbL3HhCuNJAsPi1kM/4QNEe0kKpJT9MU
         2KdmPSkqEGQwaIBJjmKQ7n0eO0vRn8Qm0c/0EhatXa6XnyV5yZrjXsLYI3cU0XFn33zF
         EQRjwDoNCiRJZjm3JQ95UtqumPaqeyI04u3oHxKmHK0O9BKlWPbfwC2nqKMH+EQxuuQx
         OuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KdKQ418cC4hW5+ONG+QHC8Knc3pXZoUSBDqx6kg1BkM=;
        b=AkEC31qcFgpw6qtTsMN37Q/ghcH1CaWz4eK86Q3/6PD5u7fRVuLCYZZoxnxizvUl/N
         3CMgGaivJ+2Z6AfXSnSiMDtoRVGU/ENY2oIN/LPushsbt43ic1wCO2uQKCADR4UbckAN
         FaIsZIFXcMNoZbHP00iudxAcANA42R1LPCE7uXe/29Hw6ZaKjz91NRaT16qHGmkKOSG+
         yX9UuyY21iPId6aYWuug+H+AZANQFpmDV1EsuVqhEysNAszg7FS6gkgSuO+MjB/ZEUJ/
         xHY4F825lsdVfDAOvoYciotmHwxlMfN9j/3gq3VPa3pKEFXQyvIC6Q7UWfqvVpIADOOw
         BgZw==
X-Gm-Message-State: AHQUAuZcVaChUwfA45RRkAE2xV9k4BRKBLqgZMQprk9trYGyqyn0TeIE
        VTUqv54IZBDxzcPoSU90uL0ENg==
X-Google-Smtp-Source: AHgI3Iav44RrLCL7NTJcEUcKD37qHiIVLaiBQldKNl1eA7ik4OFD6GG5tkiZvRjavOrmWaT/ri88Tg==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr26150215wru.67.1550743625622;
        Thu, 21 Feb 2019 02:07:05 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id y20sm38372306wra.51.2019.02.21.02.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:07:04 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:25 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 5/8] rocker: Check Handle
 PORT_PRE_BRIDGE_FLAGS
Message-ID: <20190221095725.GH2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-6-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:23AM CET, f.fainelli@gmail.com wrote:
>In preparation for getting rid of switchdev_port_attr_get(), have rocker
>check for the bridge flags being set through switchdev_port_attr_set()
>with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
