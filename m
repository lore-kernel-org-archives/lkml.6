Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA820859
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfBSPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:08:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:08:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so8044514edp.2;
        Tue, 19 Feb 2019 07:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFn/4GR4Bz5NDgNerN/E5Ph/9HPk+yTnw35wM0/aLec=;
        b=srroiYt07jQ9Ed5RgcLT3lVHpYnG5hRzzvcUCYs6XW/k9I7uubongUvmiQQOyubqjO
         CYoflTRs0xMP/cgU3ff0WkqzGpiKOwha9E7aOv9FnH+qrnzCDomLRTvJPbMvABPmBZRM
         Fu5KMAfWeLS4dj9r9kDTGlh/s/2dANi9bKveBmxzddb+BXGtFnxC2aXiQNuUD7n9EUmg
         p4Q3RqzsagWRzxHfJY8i99ravy/GRgKIac7b7O4sPmZ0QAnalZ5niBg69COQFgP/D5/7
         B9fB6EVMSWU5AQhSxfaJUKUhxfnonTQWhege1H8i5dojl8ny18ZJmPRvVSI1XfTuWKVM
         03Wg==
X-Gm-Message-State: AHQUAuYSnaPTzjz7jYCcn935bS1ckISr7j6BbKMuDa3G9TmAnGfjw76d
        +KgePB9orOHDrXi6Ni5dUQQBJ8FWQU0=
X-Google-Smtp-Source: AHgI3IZEn2Mh+/niRAbx8Lx8Rbiv3iHEFhgqDugf7DSjP5mw+Ls3L2Mjhvlj7jfOrvjaS9w4VyChAA==
X-Received: by 2002:a50:a932:: with SMTP id l47mr18021788edc.113.1550588878084;
        Tue, 19 Feb 2019 07:07:58 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id f1sm3779362ejl.65.2019.02.19.07.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 07:07:57 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id q187so3195073wme.5;
        Tue, 19 Feb 2019 07:07:57 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3370922wmc.116.1550588876908;
 Tue, 19 Feb 2019 07:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com> <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea> <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
 <20190219150311.yfqkr5svs6b3arjy@flea>
In-Reply-To: <20190219150311.yfqkr5svs6b3arjy@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Feb 2019 23:07:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vtTZy7yWcaQ2xKXzU1Jem7PW_hXaWZ9GjT+j0uFOt2w@mail.gmail.com>
Message-ID: <CAGb2v64vtTZy7yWcaQ2xKXzU1Jem7PW_hXaWZ9GjT+j0uFOt2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:03 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Mon, Feb 18, 2019 at 05:19:40PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > > > Add support for H5's SID controller.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > > > index 570a2e354f30..036029e90921 100644
> > > > --- a/drivers/nvmem/sunxi_sid.c
> > > > +++ b/drivers/nvmem/sunxi_sid.c
> > > > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> > > >       .size = 0x100,
> > > >  };
> > > >
> > > > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > > > +     .value_offset = 0x200,
> > > > +     .size = 0x100,
> > > > +};
> > >
> > > IIRC, there was an endianness issue on the newer SoCs, with the driver
> > > converting the data from big endian to little endian, while it's
> > > actually stored little endian in the SID.
> >
> > About that, it seems the internals are either little endian or native (same
> > as the bus). Either way the nvmem the driver currently exposes is wrong.
>
> Do you mean that it can be configured either way, or it's little
> endian and since you are running a little endian system you can't
> tell?

I can't tell. There doesn't seem to be a toggle for endianess though.

> > My idea is to keep the current one with the current name, but have it not
> > associate itself with the DT node. We then register an extra one, called
> > "sunxi-sid-native" which uses the native endian. This one will be associated
> > with the DT node, so the THS driver can consume nvmem cells.
> >
> > What do you think?
>
> I thought about this some more, and I don't think anyone really has
> used the sysfs interface for it. Since the data are in an unusable
> order (without an additional conversion at least), we would have had a
> bug report by now (just like we had when someone tried to use it for
> the thermal calibration).
>
> So maybe the easy way out is just to disable the conversion on the
> affected SoCs, and see if anyone complains?

That works. And please see my other mail about the DT nvmem cell arrangement.

ChenYu
