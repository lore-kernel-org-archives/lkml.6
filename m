Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71032081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbeKFQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:48:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbeKFQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:48:27 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gJviz-0005PT-0l; Tue, 06 Nov 2018 08:24:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gJviw-0001am-OR; Tue, 06 Nov 2018 08:24:30 +0100
Date:   Tue, 6 Nov 2018 08:24:30 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: linux-next: build warning after merge of the gpio tree
Message-ID: <20181106072430.vub6xjvyof2agj3h@pengutronix.de>
References: <20181106121502.00efbd07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181106121502.00efbd07@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 06, 2018 at 12:15:02PM +1100, Stephen Rothwell wrote:
> After merging the gpio tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/gpio/gpiolib.c:1514:12: warning: 'devm_gpio_chip_match' defined but not used [-Wunused-function]
>  static int devm_gpio_chip_match(struct device *dev, void *res, void *data)
>             ^~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   48207d7595d2 ("gpio: drop devm_gpiochip_remove()")

I noticed this, too, but didn't tell immediately because I thought I'd
have to resent this patch and then forgot as you applied yourself.

Sorry for that, the obvious resolution is to drop
devm_gpio_chip_match(). Feel free to squash that into 48207d7595d2. If
your branch is already stable I can provide a patch for that.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
