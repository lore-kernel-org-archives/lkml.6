Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6697208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6697208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeGJPaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:30:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeGJPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:30:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E08D9D1F;
        Tue, 10 Jul 2018 15:30:11 +0000 (UTC)
Date:   Tue, 10 Jul 2018 17:30:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 2/2] staging: mt7621-gpio: remove driver
Message-ID: <20180710153009.GA11605@kroah.com>
References: <20180710151915.2282622-1-arnd@arndb.de>
 <20180710151915.2282622-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710151915.2282622-2-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:18:48PM +0200, Arnd Bergmann wrote:
> The gpio-mt7621 driver has graduated out of staging and got accepted
> into the gpio tree. Since they both use the same Kconfig symbol,
> we could run into conflicts, e.g. I got this failure when the staging
> driver got enabled with the other one being unavailable but using the
> same Kconfig symbol:
> 
> drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
> drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
>   rg->chip.of_node = node;
>           ^
> drivers/gpio/gpio-mt7621.c:243:10: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
>   rg->chip.of_gpio_n_cells = 2;
>           ^
> drivers/gpio/gpio-mt7621.c:244:10: error: 'struct gpio_chip' has no member named 'of_xlate'
>   rg->chip.of_xlate = mediatek_gpio_xlate;
> 
> It would be trivial to rename the Kconfig symbol to avoid that problem,
> but there is also seems to be little value in keeping the staging driver
> around now.
> 
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is already removed in my staging-next tree and will be in the next
linux-next.

thanks,

greg k-h
