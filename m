Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C4B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C4B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeI1X6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:58:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeI1X6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:58:46 -0400
Received: from localhost (c-24-18-158-142.hsd1.wa.comcast.net [24.18.158.142])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4AE8D14780619;
        Fri, 28 Sep 2018 10:33:58 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:33:57 -0700 (PDT)
Message-Id: <20180928.103357.1990068599560173145.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     f.fainelli@gmail.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: b53: Fix build with B53_SRAB
 enabled and B53_SERDES=m
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180927100244.692546-1-arnd@arndb.de>
References: <20180927100244.692546-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Sep 2018 10:33:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 27 Sep 2018 12:02:38 +0200

> When B53_SERDES is a loadable module, a built-in srab driver still
> cannot reach it, so the previous fix is incomplete:
> 
> b53_srab.c:(.text+0x3f4): undefined reference to `b53_serdes_init'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe64): undefined reference to `b53_serdes_link_state'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe74): undefined reference to `b53_serdes_link_set'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xe88): undefined reference to `b53_serdes_an_restart'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea0): undefined reference to `b53_serdes_phylink_validate'
> drivers/net/dsa/b53/b53_srab.o:(.rodata+0xea4): undefined reference to `b53_serdes_config'
> 
> Add a Kconfig dependency that forces srab to also be a module
> in this case, but allow it to be built-in when serdes is
> disabled or built-in.
> 
> Fixes: 7a8c7f5c30f9 ("net: dsa: b53: Fix build with B53_SRAB enabled and not B53_SERDES")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
