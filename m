Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B532EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092220868
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8092220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeKQNjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:39:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47878 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeKQNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:39:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 202FE13F44461;
        Fri, 16 Nov 2018 19:24:02 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:23:59 -0800 (PST)
Message-Id: <20181116.192359.2155059571366826538.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: mvneta: Don't advertise 2.5G modes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
References: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 19:24:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri,  9 Nov 2018 09:17:33 +0100

> Using 2.5G speed relies on the SerDes lanes being configured
> accordingly. The lanes have to be reconfigured to switch between
> 1G and 2.5G, and for now only the bootloader does this configuration.
> 
> In the case we add a Comphy driver to handle switching the lanes
> dynamically, it's better for now to stick with supporting only 1G and
> add advertisement for 2.5G once we really are capable of handling both
> speeds without problem.
> 
> Since the interface mode is initialy taken from the DT, we want to make
> sure that adding comphy support won't break boards that don't update
> their dtb.
> 
> Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
