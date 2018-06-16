Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB63C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6540208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6PylhoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6540208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbeFPRtR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 13:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbeFPRtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 13:49:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D895420895;
        Sat, 16 Jun 2018 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529171355;
        bh=Xne0yNIzpZIG/KW4aSXXkC7aAskB7qqwOUBcs0NFu7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6PylhoE4HSevwrGSt47QCUhB0zSTIy9vLvwRCfMfqO6UeI1hysY4ccWpUSzy3Vwl
         pI4Hzw5wiaCV2g7yRWDdCFq0PBFqni51TMgLEc8nMQZ9ewHKtP6rfVWQmNV/JJA0Ke
         2fVCs5ovnOGNfhLLe4fFkbAMGJGrl8lkNZpuoQF4=
Date:   Sat, 16 Jun 2018 18:49:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180616184907.5831c24a@archlinux>
In-Reply-To: <CACRpkda5T-nUMoJKUUUDmC_MvQPs=ZP3W3ZwkgfpjozxtrHuoQ@mail.gmail.com>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
        <CACRpkda5T-nUMoJKUUUDmC_MvQPs=ZP3W3ZwkgfpjozxtrHuoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 10:42:35 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Jun 7, 2018 at 3:11 PM, Stefan Popa <stefan.popa@analog.com> wrote:
> 
> > + - adi,slew: Array of slewrate settings should contain 3 fields:
> > +       1: Should be either 0 or 1 in order to enable or disable slewrate.  
> 
> We have a standard binding in pin control for "slew-rate".
> 
> It doesn't have a unit today though.
> 
> > +       2: Slew rate clock:
> > +               Valid values for the slew rate update frequency [Hz]:
> > +               * 240000
> > +               * 200000
> > +               * 150000
> > +               * 128000
> > +               * 64000
> > +               * 32000
> > +               * 16000
> > +               * 8000
> > +               * 4000
> > +               * 2000
> > +               * 1000
> > +               * 512
> > +               * 256
> > +               * 128
> > +               * 64
> > +               * 16
> > +       3: Slew rate step:
> > +               Defines by how much the output value changes at each update.
> > +               Valid values for the step size LSBs:
> > +               * 4
> > +               * 12
> > +               * 64
> > +               * 120
> > +               * 256
> > +               * 500
> > +               * 1820
> > +               * 2048  
> 
> This is pretty idiomatic and just encodes the configuration fields from the
> hardware into the device tree.
> 
> The normal slew rate unit is Volts per microsecond.
> 
> I get the feeling that we could define that simply, and then calculate
> the slew rate clock and step using that to find the best match for
> a certain slew rate.
> 
> Yours,
> Linus Walleij
Agreed. A single value would be nice if possible.

J

