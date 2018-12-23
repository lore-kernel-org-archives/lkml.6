Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94822C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CE52171F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405136AbeLWDQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:16:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40112 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeLWDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:16:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so7773474edr.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 19:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJ1a/RovdMq+kGU6VszUmQBpA6rs5fOk8P6blwkOLPE=;
        b=otojd9VryubReWMwXkgnjTC6pysN23xpiEl2XWaxuo0gpa3LpRW/OszLm8s0+vRvnT
         gie+62/+sYIfsOXuXn9oyvtgrkTTUBjAA5HO6z9/eiYFqShyZYgs1R6UZq2D2BKs2ZsB
         SOrgMLylTll6JIsBdp+K8zGO/LP/D/Ts3Glkvy1NE2OOnZdO6c0m4tga95oM1T9ZS+NK
         lOQc+XNRISm4yxBEqlmKhepWgt1Ap5Cxrxx9/x0bsReJm1i2rnt2KOUgWXahc2NW0mDX
         mTW+TJ1MIM3OT+h1ccC4rYDntcltSlSn4T5mg329Mk/neX61Nte+IhwS+T275N0PtsYT
         aNNA==
X-Gm-Message-State: AA+aEWYPMEZb1bYIHTGvChJDnWeybsHjW7XYQZP/oIwzlwjIhublOUhC
        ibhis3vfy79CLxWb8OB5VGdAIHJhF4E=
X-Google-Smtp-Source: AFSGD/VUvPf28hxY5nQFzbVLnPEw2LU+vbtlaabpn307Aeg9qlTtiWnThn21L2oZ4RXY3dZ1r3ZNXw==
X-Received: by 2002:a50:87d9:: with SMTP id 25mr6516237edz.259.1545535004569;
        Sat, 22 Dec 2018 19:16:44 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id o37sm8073747edc.32.2018.12.22.19.16.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 19:16:43 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id 96so8864852wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 19:16:43 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr7510916wrs.44.1545535003147;
 Sat, 22 Dec 2018 19:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com> <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
In-Reply-To: <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Dec 2018 11:16:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
Message-ID: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Code Kipper <codekipper@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 6:12 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2018-12-21 17:44, Chen-Yu Tsai wrote:
> > On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> >> to reflect this.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
> >>  1 file changed, 9 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >> index d5ec1a20499d..64d073cb2aee 100644
> >> --- a/sound/soc/sunxi/sun4i-i2s.c
> >> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> >>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush RX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> > IIRC the flush cache bit is self-clearing. So you likely want to mark
> > this register as volatile. If it is marked as volatile, then all access
> > to that register bypasses the cache, so the regcache_cache_bypass calls
> > are unneeded.
>
> I helped test this together with Marcus and when I tested with this
> register marked
> as volatile audio started to stutter, still unclear why audio starts to
> stutter.

Sounds like we're missing something. However the only other time we
update this register is to set the FIFO mode.

> Without this cache bypass the flush TX/RX bits gets cached and flush
> happens unexpectedly
> resulting in multi channel audio getting mapped to wrong speaker.

This sounds like the flush is happening after DMA transfers and/or I2S
operations have started, disrupting the order of the audio samples. I
think that might be the case since the regcache is synced sequentially,
and the FIFO control register is after the enable bits. That would imply
that the device is taken out of runtime suspend after the .start_capture
or .start_playback callbacks. Not sure if that's the case, but that would
mean the bus clocks are still off at this point, and bypassing the cache
and updating the bits is basically moot.

I think there's something else happening here, but we need to figure it
out instead of papering over it with something that "just works" but
we don't know why it works.

> Other ASoC codecs and fsl_spdif.c seems to use similar cache bypass for
> reset/flush.

fsl_spdif.c does it when forcing a soft reset, which would reset all the
registers. It then does a cache sync, restoring any values set up. That's
not what we're doing here.

> >
> > However, looking at the code, the write would seem to be ignored if the
> > regmap is in the cache_only state. We only set this when the bus clock
> > is disabled. Under such a condition, bypassing the cache and forcing a
> > write would be unwise, as the system either drops the write, or stalls
> > altogether.
> >
> >>         /* Clear RX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> >> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush TX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> >>
> >>         /* Clear TX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> >> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
> >>
> >>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >>  {
> >> -       switch (reg) {
> >> -       case SUN4I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> +       return true;
> > I don't understand why this is relevant. Do you need to read back from the TX
> > FIFO?
>
> This change was inspired by c66234cfedfc "ASoC: rockchip: i2s: fix
> playback after runtime resume" [1]
> On resume a cached sample would be written to FIFO_TX_REG unless it is
> marked volatile,
> the rockchip commit indicated that read is needed for volatile regs.
>
> [1]
> https://github.com/torvalds/linux/commit/c66234cfedfc3e6e3b62563a5f2c1562be09a35d

What about simply marking the FIFO registers as both unreadable and
unwritable, thus excluding them from the regmap? That should get rid
of any unwanted syncs. We are doing DMA transfers to/from them. Do we
need regmap access?

Either way this context should be provided in the commit log.

Regards
ChenYu

> >
> > If so, just drop the call-back altogether. If no callback is provided and no
> > rd_table is provided either, it defaults to all registers under max_register
> > (if max_register < 0) are readable.
> >
> > However this seems like it deserves to be a separate patch (where you explain
> > in the commit log why it's needed).
> >
> > Regards
> > ChenYu
> >
> >>  }
> >>
> >>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> >> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         switch (reg) {
> >>         case SUN4I_I2S_FIFO_RX_REG:
> >> +       case SUN4I_I2S_FIFO_TX_REG:
> >> +       case SUN4I_I2S_FIFO_STA_REG:
> >>         case SUN4I_I2S_INT_STA_REG:
> >>         case SUN4I_I2S_RX_CNT_REG:
> >>         case SUN4I_I2S_TX_CNT_REG:
> >> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>         }
> >>  }
> >>
> >> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >> -{
> >> -       switch (reg) {
> >> -       case SUN8I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> -}
> >> -
> >>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         if (reg == SUN8I_I2S_INT_STA_REG)
> >>                 return true;
> >>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> >> -               return false;
> >> +               return true;
> >>
> >>         return sun4i_i2s_volatile_reg(dev, reg);
> >>  }
> >> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
> >>         .reg_defaults   = sun8i_i2s_reg_defaults,
> >>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
> >>         .writeable_reg  = sun4i_i2s_wr_reg,
> >> -       .readable_reg   = sun8i_i2s_rd_reg,
> >> +       .readable_reg   = sun4i_i2s_rd_reg,
> >>         .volatile_reg   = sun8i_i2s_volatile_reg,
> >>  };
> >>
> >> --
> >> 2.20.1
> >>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> >
