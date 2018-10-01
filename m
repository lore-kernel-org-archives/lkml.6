Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251842083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkfasF0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251842083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeJAKeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:34:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35305 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeJAKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:34:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so8204625pfh.2;
        Sun, 30 Sep 2018 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yyan0mW7cdfbvZ1sd6ILf4tjXnD4uICsIZaQ+1jTEGE=;
        b=XkfasF0UNw7USrMMnSZ47ClTVZj2ftxrQ6BiKj4fhCW4qrwfGXCLqYLlOt2QpQv9Dk
         PTiPKUmibAu/BnPkDqEOQznL+8l6DNA61dXjVU56shQ0HtN8dEf+rj+LJBT6rwfvHZhm
         0a6AAjdvG+ya5bhyztai5xsjm0GE7hvzwA0biuK/mEnxtBMdBzJu3fXYvWsMknQvTKFA
         cm6e2p5Z5r33tsMDp270/1q9OVEVL4RcF4IB2K6fGovCDgKwD+r43G2/v5icxGHxlOGD
         RgMihJZgITmW0So1Bw/D9pgrlmisV4WZg4wMMeD/9qowpNxk2d2truJVsfagmokVlm4u
         L+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yyan0mW7cdfbvZ1sd6ILf4tjXnD4uICsIZaQ+1jTEGE=;
        b=ZwEdSSlpmx5iF+XpsbvO9wtJ3f8jju1Eq3ijIdQgpB89Ht716+XzyVrJb+8Eb+lam6
         0KlpEXpoowxsHHtA1lVCKqOMlHbe5LYUP5diF/YRS13v3b5gcwKhgYWHdNBV81+o7SZq
         59TNmXMxYenJsHIwogP+qHvapF+Qt7mDjLuDuBCbyi3PpbRIdPwJy58kFv8INezr2M6t
         It0NzV0t7Fs6C59LKSTtmsZZ1QkEtvuXM+dLJS9ixRlrKboIxNfz3tiQ44mOcqwFRJmp
         FaPFKOi5hjuy0TMOCQ7j6hje9ItGXLRUXzGWp+H4NTcH3BYbPtfGBpHiIOU5/QIn3Ajw
         6tMQ==
X-Gm-Message-State: ABuFfoiZDbU0/TM0QHdYdGEBQcwPW8i03EZQzk8mW3Rv1FtxYLkCFexx
        ooNf3b/5AgXqkVWSrJxxQs8AybMWx6o=
X-Google-Smtp-Source: ACcGV62YE2CzZpmbDzd65T5QOGvMv0F8OP2nkmx6MiZpFRYvLpjMhSUKryapXsrmmsmc3j0CCLxwOg==
X-Received: by 2002:a62:3402:: with SMTP id b2-v6mr369443pfa.65.1538366303335;
        Sun, 30 Sep 2018 20:58:23 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u184-v6sm20909981pgd.27.2018.09.30.20.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 20:58:22 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:58:14 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20181001035739.GA17143@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus>
 <20180928093618.GA24536@Eros>
 <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:52:13PM -0500, Rob Herring wrote:
> On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > > >
> > > > > The first version of this driver issues a measuring request and polling
> > > > > for a status register in the device for measuring completes.
> > > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > > indicate that new measurement is ready. This patch adds support for
> > > > > using this mechanisim to reduce cpu cost.
> > > > >
> > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > > > Hi Song.
> > > >
> > > > Looks correct in principal but a few things to tidy up before
> > > > this is ready to apply.
> > > >
> > > > Also we have an unrelated change in here to check the devices ID.
> > > > That should be in it's own patch.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > > > ---
> > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> > >
> > > This should have been split with the complete binding in one patch
> > > rather than piecemeal driver feature by feature.
> > >
> >
> > Hi Rob,
> >
> > A few days ago when I was submitting this driver, I didn't do it very
> > well, the function of this driver is limited. I added interrupt support
> > the next day after you acked my first patch. I thought it's not polite
> > to add something after someone acked that patch, so I send the interrupt
> > support as a second patch. The first patch is merged to togreg now, but
> > this doesn't. I don't know when can I add new functions to the code that
> > just merged to togreg branch, could you offer some suggestions?
> 
> You just needed to state why you didn't add a ack. But really, just
> don't send things except as RFC until they are "done".
> 
> What to do next depends on Jonathan and whether he wants a follow-up
> patch or he will drop the first one.
> 
> > > > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > > > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > index ab9a9539fec4..40290f8dd70f 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > > > @@ -4,9 +4,21 @@ Required properties:
> > > > >   - compatible: must be "st,vl53l0x-i2c"
> > >
> > > Is there more than one interface on this device, such as SPI? If not,
> > > then '-i2c' should be dropped.
> > >
> >
> > Yes, there is a CCI(Camera Control Interface) for communication.
> 
> Isn't CCI just a subset of I2C? I should clarify my question is
> whether there's more than 1 mutually exclusive control interface (as
> many devices have control and data interfaces) where you could have 2
> different drivers. A common example are devices with I2C and SPI
> interfaces.
> 
> Rob

Hi Rob, Jonathan,

I don't know things about CCI very well, and google also tells me little
about it. Actually, I found it difficult to find a standard definition
about it. Then I dug into vl53l0x's API source code, and what I can
tell is when we use these two interfaces, the whole programming
framework is different, even though the pysical bus of them are likely
to be the same. 
Source code of CCI uses a 'msm_camera_i2c_fn_t' struct and a
'v4l2_file_operations' as hardware interfaces for controlling device,
while the i2c one just uses generic i2c bus interfaces.

This explanation is for why the file name still contains '-i2c'.

yours,
Song Qiang
