Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EFF21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbeLURPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:15:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40232 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbeLURPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:15:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so5238932edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KHM75/LxO6Dbrl+LQVIoiBh2oQpzco7U1Zt/XhGp8E=;
        b=eEtLVAvoLRsaNxWLMDV9O7VnUPmgvkTFHbmp1TZdfgyHb0rjL3wmMNeVY8bZ2WnJGL
         Q6dABINphj2CPYoVEKaOUl7hr+zvhTOFqjs0miUwB3TH02i0Ff7PVnFYTTcRRBJ1taaI
         8Hi2NXfeaagfX+QZtqstHwkdt4u5RkiLWH73H8l0y+3k85FaJ92ZTkaBHwYHPRhcSaxC
         loiiaijcB15CkbgNFHNRKeLWWkXC0sM5FoPv/YI3Kk/viGFBeGKnEv26nLIl68nCGbkt
         i0/G0OWNWZ+rjdvf8qSdEp2tiunC21eRLqL0qkdOLJ8Jb+kVty2z32vZYRQ4xg3vVMtD
         j89w==
X-Gm-Message-State: AA+aEWYZCbZuhSmL9LJWJnFCqyPWeMfKFj7k8wa9jcnaoet3lGHtXntz
        PCl7i6PYqeA8u/EUM6zxvT7UFtxsaU0=
X-Google-Smtp-Source: AFSGD/VstnksPBKgasbieTo6fVIb7avkB/cthUd/Rr5j7akUjhyLBI4fFULl/1Hl9qzKpBpDafp+3w==
X-Received: by 2002:a17:906:198b:: with SMTP id g11-v6mr2646911ejd.166.1545412536867;
        Fri, 21 Dec 2018 09:15:36 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id g37sm7285435edb.85.2018.12.21.09.15.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:15:36 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id p4so6031941wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:15:35 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr3356702wre.120.1545412535646;
 Fri, 21 Dec 2018 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-4-codekipper@gmail.com>
 <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
In-Reply-To: <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Dec 2018 01:15:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v652h5hpujBxF5r3_g_tj2cOjULkUBhazi_5Xd6kvC2ZPw@mail.gmail.com>
Message-ID: <CAGb2v652h5hpujBxF5r3_g_tj2cOjULkUBhazi_5Xd6kvC2ZPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:48 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample for the earlier SoCs.
> >
> > Newer SoCs can also handle 32bit samples.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 80bf29e0cc86..adb988ae9ac5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >         case 16:
> >                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 break;
> > +       case 20:
> > +       case 24:
> > +       case 32:
> > +               width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported physical sample width: %d\n",
> >                         params_physical_width(params));
> > @@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                 sr = 0;
> >                 wss = 0;
> >                 break;
> > -
> > +       case 20:
> > +               sr = 1;
> > +               wss = 1;
> > +               break;
> > +       case 24:
> > +               sr = 2;
> > +               wss = 2;
> > +               break;
> > +       case 32:
> > +               sr = 4;
> > +               wss = 4;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported sample width: %d\n",
> >                         params_width(params));
> > @@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> >         return 0;
> >  }
> >
> > +#define SUN4I_FORMATS  (SNDRV_PCM_FMTBIT_S16_LE | \
> > +                        SNDRV_PCM_FMTBIT_S20_3LE | \
> > +                        SNDRV_PCM_FMTBIT_S24_LE)
>
> IIRC SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24
> are different things, in regards to how the sample is aligned in a 4 byte
> space. Have you checked that things actually work as expected? This was
> something that did not work using SNDRV_PCM_FMTBIT_S24_LE on sun4i-codec.

OK. I see the I2S driver is using FIFO mode 1, which expects the sample
to be in the lower portion of the 4 bytes. However it looks like you would
want SNDRV_PCM_FMTBIT_S20_LE (20 bits LSB justified in 4 bytes) instead of
SNDRV_PCM_FMTBIT_S20_3LE (20 bits LSB justified in 3 bytes).

ChenYu


> > +
> > +#define SUN8I_FORMATS  (SUN4I_FORMATS | \
> > +                        SNDRV_PCM_FMTBIT_S32_LE)
> > +
> >  static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >         .probe = sun4i_i2s_dai_probe,
> >         .capture = {
> > @@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .playback = {
> >                 .stream_name = "Playback",
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .ops = &sun4i_i2s_dai_ops,
> >         .symmetric_rates = 1,
> > @@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
> >         i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> >         i2s->capture_dma_data.maxburst = 8;
> >
> > +       soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> > +                              sizeof(*soc_dai), GFP_KERNEL);
> > +       if (!soc_dai) {
> > +               ret = -ENOMEM;
> > +               goto err_pm_disable;
> > +       }
> > +
> > +       if (i2s->variant->has_fmt_set_lrck_period) {
>
> This condition deserves a comment, particularly as to why you use it
> in place of having a separate quirk field to represent 32 bit support.
>
> Regards
> ChenYu
>
> > +               soc_dai->playback.formats = SUN8I_FORMATS;
> > +               soc_dai->capture.formats = SUN8I_FORMATS;
> > +       }
> > +
> >         pm_runtime_enable(&pdev->dev);
> >         if (!pm_runtime_enabled(&pdev->dev)) {
> >                 ret = sun4i_i2s_runtime_resume(&pdev->dev);
> > --
> > 2.20.1
> >
