Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3494850-1521092010-2-1403132847646568910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, FSL_BULK_SIG 1.316,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521092010; b=QhnF4q2+x1Dhydy/TvEyYWxHN1tCVvds/29CWN/YQ8rJMMc
    zTFNNpSqkiQH8doZ/B2+18WLPuxz+EYpiJ9RVIyeJKsKW/VtPa9bgF0rQRTHhO/y
    3vfl0BXo4g7GNcoTuxqOkZfig80fz4Q+WAmczCPbEU4JBzXhQrreNG5bW/fbBiWx
    zMzwh5N+Owa62j09uXFKEzLao0TaqxrqF3DfWIwun+h/W/ZXfqXWkfg5xtgjyf++
    7qQHPPlIHyPQ0U78BUSnq97RghcbeKFDdo1Rprlp4Ru073Ac4So+VR1aBjosz8lk
    syHailDK7V9vSt8CBYh27v0ZUZgL1JPx2qP6C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521092010; bh=1+2sQ9rx5fHjWJMtZOojeyN/T9DBwNqCYYL6kN7+87A=; b=R
    /8pzr2irnCHWXuZXaqBuS7MuDycrQv1ksbgMnPQ11AVJYAi6NQp8eTqVZatUnm3V
    bckr687Kz8qF/hpHC/iDh05zFjCWgTbaBQ/LyNuK6M+1RpLQsh3QUMsbcH4+be9I
    fkg5/oEeOxv01T1AovAP0jXXbFvHlzRqpPJIdIFQegpMegqI0aYLKW4aONd/yvDp
    2wBZZp7zdyPe3CZF8gg3+0wwQvYlkhHIHC7t9w3KJXXnA1dNeTR4BexKLswGFHhf
    YkeEFrOYt1vgThfjJ3en27Ek9bQ+iqwo8Qu1na9NEaEet7Hqo3FbggirVp66XnXK
    bABBzn5tZQTEJV97WTt9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeCOFdH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 01:33:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44166 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOFc5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 01:32:57 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Thu, 15 Mar 2018 06:32:38 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux@roeck-us.net, corbet@lwn.net,
        tj@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, bp@alien8.de, mchehab@kernel.org,
        linus.walleij@linaro.org, wsa@the-dreams.de,
        dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        cyrille.pitchen@wedev4u.fr, wg@grandegger.com, mkl@pengutronix.de,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, jslaby@suse.com,
        stern@rowland.harvard.edu, b.zolnierkie@samsung.com,
        shli@kernel.org, linux-watchdog@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-raid@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/47] arch-removal: device drivers
Message-ID: <20180315063238.3303b8d1@bbrezillon>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

On Wed, 14 Mar 2018 16:35:13 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> Hi driver maintainers,
> 
> I just posted one series with the removal of eight architectures,
> see https://lkml.org/lkml/2018/3/14/505 for details, or
> https://lwn.net/Articles/748074/ for more background.
> 
> These are the device drivers that go along with them. I have already
> picked up the drivers for arch/metag/ into my tree, they were reviewed
> earlier.
> 
> Please let me know if you have any concerns with the patch, or if you
> prefer to pick up the patches in your respective trees.  I created
> the patches with 'git format-patch -D', so they will not apply without
> manually removing those files.
> 
> For anything else, I'd keep the removal patches in my asm-generic tree
> and will send a pull request for 4.17 along with the actual arch removal.
> 
>        Arnd
> 
> Arnd Bergmann
>   edac: remove tile driver
>   net: tile: remove ethernet drivers
>   net: adi: remove blackfin ethernet drivers
>   net: 8390: remove m32r specific bits
>   net: remove cris etrax ethernet driver
>   net: smsc: remove m32r specific smc91x configuration
>   raid: remove tile specific raid6 implementation
>   rtc: remove tile driver
>   rtc: remove bfin driver
>   char: remove obsolete ds1302 rtc driver
>   char: remove tile-srom.c
>   char: remove blackfin OTP driver
>   pcmcia: remove m32r drivers
>   pcmcia: remove blackfin driver
>   ASoC: remove blackfin drivers
>   video/logo: remove obsolete logo files
>   fbdev: remove blackfin drivers
>   fbdev: s1d13xxxfb: remove m32r specific hacks
>   crypto: remove blackfin CRC driver
>   media: platform: remove blackfin capture driver
>   media: platform: remove m32r specific arv driver
>   cpufreq: remove blackfin driver
>   cpufreq: remove cris specific drivers
>   gpio: remove etraxfs driver
>   pinctrl: remove adi2/blackfin drivers
>   ata: remove bf54x driver
>   input: keyboard: remove bf54x driver
>   input: misc: remove blackfin rotary driver
>   mmc: remove bfin_sdh driver
>   can: remove bfin_can driver
>   watchdog: remove bfin_wdt driver
>   mtd: maps: remove bfin-async-flash driver
>   mtd: nand: remove bf5xx_nand driver

If you don't mind, I'd like to take the mtd patches through the MTD
tree. As you've probably noticed, nand code has been moved around and
it's easier for me to carry those 2 simple changes in my tree than
creating an immutable branch.

Let me know if this is a problem.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
