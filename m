Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6419FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28150217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550579984;
	bh=BfOgk1pvh6/6UAVKSeruv68KiWmbnNkQH0j/SDOVzZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UflBkri/VfUUyL9n5C0+//EPayQQYnGtvqKeAzbGEcSdnhHnWVZmNya82V1MWlLhl
	 XRv6+SyDvD5W+cVwJlyIogXAG7lF2bOWUGxbJjMfhhcBpau7jUR4dWiIxeoCQbbdmy
	 9aJcThQixWvuEg5BrVHTT93q6vcF15AyARDuU6us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfBSMjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSMjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:39:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0042821736;
        Tue, 19 Feb 2019 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550579981;
        bh=BfOgk1pvh6/6UAVKSeruv68KiWmbnNkQH0j/SDOVzZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3GFvPCf03vfxrzaMKQh0FuDZwvaJ/bX5YksvUk89hf8cxwcH2zQXrNaQK0VAf5uF
         fa9RtKHC8jUkh8lQ85OXEk9cLfy8+7em6UnICgvGBawhuDia4CWowsL8/RAwFNFCD0
         //uV5RoAGYgqErRSfwtV5eXI33rCDPOx4fR61BWA=
Date:   Tue, 19 Feb 2019 13:39:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/2] eeprom: at24: new property
Message-ID: <20190219123938.GA4867@kroah.com>
References: <20190205135934.18841-1-brgl@bgdev.pl>
 <CAMRc=MdRgmOwcaytv83pOHGYGwsskCVx3gRqaatg8sMDShmnLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdRgmOwcaytv83pOHGYGwsskCVx3gRqaatg8sMDShmnLw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:12:05PM +0100, Bartosz Golaszewski wrote:
> wt., 5 lut 2019 o 15:00 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Microchip 24aa02t EEPROM is compatible with Atmel 24c02 except that
> > it's visible on 8 i2c slave addresses. We already support such a
> > use case with hard-coded config for 'atmel,24c00'. Let's add a more
> > flexible device tree property - 'num-addresses' - to the binding
> > document and support it in the driver.
> >
> > Bartosz Golaszewski (2):
> >   dt-bindings: at24: add the 'num-addresses' property
> >   eeprom: at24: implement support for 'num-addresses' property
> >
> >  Documentation/devicetree/bindings/eeprom/at24.txt |  3 +++
> >  drivers/misc/eeprom/at24.c                        | 13 ++++++++-----
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > --
> > 2.20.1
> >
> 
> If there are no objections, I will apply these in 2 days and include
> them in the PR for v5.1.

No objections from me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
