Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEFE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QEl3yvE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfAPW3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:29:50 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45919 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbfAPW3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tUtj6epF5DgvzpzF9MzvHfabAc2wUY/RetBvPZWfBQE=;
        b=QEl3yvE3ZFrMYZu9bz5eQ9FvBSMKLd0vn4gqIuSoe4jFFR9Xw3WsXeM7KcEcVHolUtNqarIJPEQZTPtGe0Q4Zo2hF7Sfk9cmtFMbtHw/corfPQnDa7qskw/NbA1WFt8NHgsZrxl+1Ntme+yiTDJy/2FXqBXAcP4WsP52mPIEKw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjtgn-00030B-Bw; Wed, 16 Jan 2019 23:29:37 +0100
Date:   Wed, 16 Jan 2019 23:29:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Message-ID: <20190116222937.GR29244@lunn.ch>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
 <20190115230613.28334-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115230613.28334-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index b3eefe8e18fd..6178b648d08a 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -21,6 +21,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/phy.h>
> +#include <linux/platform_data/dsa.h>
>  #include <net/devlink.h>
>  #include <net/switchdev.h>

Hi Florian

Could there be one more patch at the end which removes this?  I think
it is here just as an intermediary step?

Thanks
	Andrew
