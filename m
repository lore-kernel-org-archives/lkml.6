Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF39C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF8B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550683419;
	bh=OSBSwVtCgR8A4XgFCpqYDru7e7KRGNRNbm9XfmdizDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sIx4MosdIXYe2JM48dBr94d3ERDXOBg1R/XQgPqpn+UHh5/Q9N5nW5Qtqug2AYGub
	 +6BVRq60MBhNAWjl3GTVOj0t+PYegDuZ1+k3QWq81rlCnoK4IYzanyW80R6TXFRUCB
	 FstyQxibmfbmvual1GDO6nGjPOZUSbJTPXnaXtQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfBTRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBTRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:23:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82EC92083E;
        Wed, 20 Feb 2019 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550683417;
        bh=OSBSwVtCgR8A4XgFCpqYDru7e7KRGNRNbm9XfmdizDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JUQESAOdCRU26G4Hs5WVWvyBJJS/YdvCcvHhKYjI3ZD4rHgzGTEyuIOB9BMoS+Bv3
         BjL/+vwroPAQx/tz0gMzIbLjn3iJjVhy5H34EadG9Np6sKpbSxqPaptwgqbQV+APNC
         i93sFQv1hT7Xg2AYvDbtNQ8kELnPq234BWPX/6ZA=
Date:   Wed, 20 Feb 2019 17:23:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     justinpopo6@gmail.com, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190220172331.40d7cbf0@archlinux>
In-Reply-To: <96ec33f3-6e58-325f-9c55-4f1a92f635f7@lechnology.com>
References: <1550030242-5241-1-git-send-email-justinpopo6@gmail.com>
        <9e0a8a08-9636-906b-08cf-d99947d6f51a@lechnology.com>
        <20190220120021.65c91b83@archlinux>
        <96ec33f3-6e58-325f-9c55-4f1a92f635f7@lechnology.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 10:48:49 -0600
David Lechner <david@lechnology.com> wrote:

> On 2/20/19 6:00 AM, Jonathan Cameron wrote:
> > On Wed, 13 Feb 2019 09:10:53 +0100
> > David Lechner <david@lechnology.com> wrote:
> >   
> >> On 2/12/19 9:57 PM, justinpopo6@gmail.com wrote:  
> >>> From: Justin Chen <justinpopo6@gmail.com>
> >>>
> >>> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> >>> pins using the GPIO chip framework.
> >>>
> >>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> >>> ---  
> >>
> >> It will be better to split this up into two patches[1]. One to replace
> >> all uses of indio_dev->mlock with the new local lock and then another to
> >> add GPIO support.
> >>
> >> How are you using/testing this patch? Do we need device tree bindings?
> >>
> >> It will also help reviewers if you add a note about what you changed in
> >> each revision of the patch when you resubmit. The usual way to do this
> >> is something like:
> >>
> >>       v3 changes:
> >>
> >>       - Fixed unlocking mutex too many times in ti_ads7950_init_gpio()
> >>
> >> It also is nice to wait a few days at least before submitting the next
> >> revision to give people some time to respond.  
> > 
> > Agreed with all comments except the endian one.
> > SPI doesn't define an endianness of data on the wire, so we may need
> > to convert to match whatever ordering the ti chip expects.
> > I would expect things to be thoroughly broken if we remove those
> > conversions - particularly as I doubt this is being tested with a
> > big endian host!
> > 
> > Jonathan  
> 
> I'm a bit confused then. I got this idea from include/linux/spi.h, which
> says:
> 
>   * In-memory data values are always in native CPU byte order, translated
>   * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
>   * for example when bits_per_word is sixteen, buffers are 2N bytes long
>   * (@len = 2N) and hold N sixteen bit words in CPU byte order.
> 
> 
> And in the most recent patches to the ti-ads7950 driver where we switched
> from 8-bit words to 16-bit words, I had to remove the calls to cpu_to_be16()
> to keep things working.
Ah, my apologies, I didn't look at this closely enough.

I was assuming we weren't in 16 bit mode here - oops.

Otherwise this wouldn't have any hope of working... Except I'm assuming it is...
hohum.

Hmm. Given the result of that cpu_to_be16 will be to swap (as almost certainly
on le system), I'm going to hazzard a guess that the ti device is expecting
little endian and we should be setting SPI_LSB_FIRST.
Which is odd because the data sheet definitely looks MSB first. Not to mention
this isn't be done elsewhere in the driver.

So only option I can fall back on is that it is being used on a be system
(hence noop) or is a forward port of an older patch for the driver that missed
your 16 bit change...

> 
> I realize that I am only using one SPI controller, so I may be making a bad
> assumption here, but it seems to me that it is up to the SPI controller to
> make sure the bits get sent over the wire in the correct order and we
> shouldn't have to worry about it here. We are implicitly telling the SPI
> controller that we need big-endian over the wire by omitting the SPI_LSB_FIRST
> flag here:
> 
> 	spi->bits_per_word = 16;
> 	spi->mode |= SPI_CS_WORD;
> 	ret = spi_setup(spi);
> 
You are entirely correct, I was too lazy and had forgotten your change to
move to 16 bits.

Jonathan

