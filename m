Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3B20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD3B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeKLBTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:19:08 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56642 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeKLBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:19:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BBEC39E784A;
        Sun, 11 Nov 2018 15:30:10 +0000 (GMT)
Date:   Sun, 11 Nov 2018 15:30:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>, oskari@lemmela.net,
        linux-gpio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Message-ID: <20181111152952.0375b969@archlinux>
In-Reply-To: <CAGb2v66mH5_J0K4ArFduvvQ2aE7mZxcyLORNPODj79-xhiKapQ@mail.gmail.com>
References: <20181023185330.10472-1-oskari@lemmela.net>
        <20181023185330.10472-5-oskari@lemmela.net>
        <20181024135633.GA342@bogus>
        <20181028154011.04efdecf@archlinux>
        <20181029130757.m5okrfvusjl5fu5m@qschulz>
        <CAGb2v65JKj_7VcEr1KuZVop85hn-3h73NrExprpmLbKZiosD5Q@mail.gmail.com>
        <20181103102153.4f0481ad@archlinux>
        <CAGb2v66mH5_J0K4ArFduvvQ2aE7mZxcyLORNPODj79-xhiKapQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 13:47:50 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Sat, Nov 3, 2018 at 6:22 PM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Wed, 31 Oct 2018 10:29:59 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> >  
> > > On Mon, Oct 29, 2018 at 9:10 PM Quentin Schulz
> > > <quentin.schulz@bootlin.com> wrote:  
> > > >
> > > > Hi Jonathan,
> > > >
> > > > On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:  
> > > > > On Wed, 24 Oct 2018 08:56:33 -0500
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > >  
> > > > > > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:  
> > > > > > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > > > > > specific compatible for it.
> > > > > > >
> > > > > > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >  
> > > > > >
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>  
> > > > >
> > > > > This doesn't seem to have any dependencies with the other patches
> > > > > so applied to the togreg branch of iio.git and pushed out as testing
> > > > > for the autobuilders to ignore.  However I am a little curious to know
> > > > > why we would add the ID and then not use it (that I can see)?
> > > > >  
> > > >
> > > > Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
> > > > discover something that is slightly different. When this happens, we
> > > > have to add a compatible to differentiate both. However, we would also
> > > > need to change the Device Tree to change the compatible. We would need
> > > > to handle the driver behaviour for both Device Trees.
> > > >
> > > > So better anticipate a possible difference so that we don't have to do
> > > > some hacks in the driver to handle the device correctly.
> > > >
> > > > As always, Chen-Yu or Maxime may know better so I'm just stating what I
> > > > seem to recall.  
> > >
> > > With Allwinner stuff (X-Powers included), sometimes the documents are
> > > incomplete or have errors. We tend to add a model-specific compatible
> > > just in case things turn out not to be so compatible, unless someone
> > > has triple-checked everything, documents and actual hardware included.
> > >
> > > However we don't actually document these, so this patch isn't strictly
> > > needed. (I suppose this might annoy the device tree binding maintainers.)
> > >
> > > ChenYu  
> > I don't think it does any harm so I'll leave it in place.  Thanks for
> > the explanations.  
> 
> It might cause a bit of confusion though. We are not targetting these
> compatibles in terms of driver support, and they should not be used
> individually. IMO dropping this patch altogether is better. In the
> device tree we would use the tuplet axp803 + axp813.
> 
OK. Dropped.

Thanks,

Jonathan

> ChenYu

