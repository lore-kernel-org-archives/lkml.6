Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66700C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361972080D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="NdvPhrYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBIR6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:58:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBIR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:58:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so9305094wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLrbrXTasAuON8ddeBy0wOwE+pVmIatdFXcjK6igj8Q=;
        b=NdvPhrYK5WIWkxMNlATZZnfbzTVXFGF7PMSQuRAC24AVZie5/PBsoGnQnqwB5/TkWd
         pBN4nnaB1Myup8S3ctX8Lh/Sw14121E3N7ZxHZ1n28A40FUnvbPqFRqRtlaLoQtBHg0f
         ohEjCqnngCECFUgM9iESj/EhfZTAlW8ivl1Gyy23k1fOldP8wMvO1O+JPswQUO3wHJi7
         vIYsy/d5blKQZVaWW2NYsm9c5ftzo7GIz6F0FogR67lqnDkM8VYgHn5vRYLZhBo3W98h
         kP42B5pbwf7X2QG6LhdtIdFvOQHxuwiHHbZphQwpdvnGv0wOrBfKUmfsXzXqzGsIxjVY
         3OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLrbrXTasAuON8ddeBy0wOwE+pVmIatdFXcjK6igj8Q=;
        b=eg1LJm0wYyZkoQIEx6WYDmIbuK7NcC+InPpMmkCHK5V+rObcgpAYFgK0ci5Y7GFIpn
         RuZy7pIk7g7Gg6RiCAUhq4faYcoO8orSEXkqkCV4/aUgQAHHSALc0OdwRqL8714dq4Oy
         lp70d8LZPqoUmzx3Y09t2jvDGvT1TrMcEwuHPhPd38UaOk18PyqSiZD3me2NPTSv3p6/
         T0v+how8TFhddCZ3QlUtcLYhrZEnrd+J8RfzR1Byr66+SiYj8ejSCVahzgDhPKfMeoZ5
         T9J1OAUJF70uNV84ttC5YSf9A1rLSq7Bnxf/ZDUStGCH1INsCHwSc7H4Pfv/TXxFgLYm
         FCqw==
X-Gm-Message-State: AHQUAuYTIzz0pmf0h3BRhsR21J1a/O0zAxpdWVjNPG2SPt3L17lpF2Wa
        miT7MY05XTQgbMolWD0+iOWjEw==
X-Google-Smtp-Source: AHgI3IbTgjvuN7C+/BrsH3gNCiJCwGcIS9TDkYlWesZF+uWfnumi2AHg2hE3ldGs1ehhQ5uhezwJaQ==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr6121027wrr.233.1549735083495;
        Sat, 09 Feb 2019 09:58:03 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id e196sm1636732wmg.36.2019.02.09.09.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:58:03 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:48:51 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
Message-ID: <20190209174851.GM2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-7-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:38AM CET, f.fainelli@gmail.com wrote:
>Now that all switchdev drivers have been converted to checking the
>bridge port flags during the prepare phase of the
>switchdev_port_attr_set(), we can move straight to trying to set the
>desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
