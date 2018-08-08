Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C15C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E678421A32
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GvfBL0Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678421A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHHTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:05:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58764 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHTFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ZMAGAR5lfWa8Gmxy2bmMcvRwUzxvBj23x03HN3qcDPM=;
        b=GvfBL0Ex7V+sKbiGf4ZT87j5qeSZEqyCrROguRMSBL4uhrt0E/AtfG9ugdc9v/sZNSFEVAOO/OXCGtH8B6al0eEeO2cLu5ix/Nxnqw6APRLMl7Ms/dnDUCwH5oTuw9du2yQczzyCdfuDu2oMDFnU+49HDfLg0pG/JyhLekfiQYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fnRZ4-0007YV-AU; Wed, 08 Aug 2018 18:44:02 +0200
Date:   Wed, 8 Aug 2018 18:44:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
Message-ID: <20180808164402.GH7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808155548.s7p4xqsjywz3psrj@ninjato>
 <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 06:27:25PM +0200, Bartosz Golaszewski wrote:
> 2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> This is a follow-up to the previously rejected series[1] which partially
> >> removed the at24_platform_data structure. After further development and
> >> taking reviews into account, this series finally removes that struct
> >> completely but not without touching many different parts of the code
> >> base.
> >>
> >> Since I took over maintainership of the at24 driver I've been working
> >> towards removing at24_platform_data in favor for device properties.
> >
> > Wooha, nice work. I can't really comment on it but wondered how you want
> > to upstream it (after reviews)? Pull request of an immutable branch for
> > nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
> > it. Probably same situation for arm-soc...
> >
> 
> I initially wanted to merge small parts of it starting with v4.18, but
> there were some voices against merging APIs without users. I'm not
> sure how it should go in. There'll be a need for multiple immutable
> branches most probably...

Hi Bartosz

What this series does is show all the different parts are now
available, and can be reviewed as a whole. Once that review is
completed, merging in parts then becomes possible.

It looks like you could probably merge the nvmem, mtd and net parts
independently via there maintainers for 4.20, since i don't think
there are any dependencies. The arm-soc changes in 4.21, and the
removal of the platform data in 4.22?

     Andrew
