Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2802921916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbeLUQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:44:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42116 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLUQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:44:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so5163027edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV0KAnk3tQchKK12t/V41YVSjxMoTHWPpGkNXrDUEIk=;
        b=MxJZ00FpZkm2dtiQaF5HAejDTh7J1fx+5aczQjmsdZrjqMIBGme0eZaOYwiQYQBrvZ
         CZTYoqd0vsWdZ+x1JFpeBsOK1Ay/1wQzACn8d+f+ulgsXVO+bMV0UvjlHZvU4X0SQCke
         Ab6fEKyTkmYorHdeVdA8m4jHNc/u97bwaSFdv7L4SiSdT7vw13yyK4BdLa5/c5MQQea/
         4RObJ4jKQ0+iFvSGcOl7+NV8QfqvSz/0QUOcpGn7OK1kOdbeOVkaso1sqZKtK+Uhdg5a
         7D3p8eMsyCFxz9tI+OVGrpID3YVKgxhpAjE1NCYvmo9zVBEilR5QP3EEdo/1oDETdUax
         2ePw==
X-Gm-Message-State: AA+aEWZkK0a0Ho2Ka42lzQc6H+C6ynDnpEZFoNHVoer/hJ3fTzUBqjY1
        tMlL5yuthLu4yofxRKIX0EJ/5OUhvUc=
X-Google-Smtp-Source: AFSGD/Uf+Txi3nkQw0CJamXslqA/Rc+WcMJSEXZT5I0KI3IRNVx94yaYPWpvqNMKv4JT2t247kpaBA==
X-Received: by 2002:a17:906:6011:: with SMTP id o17-v6mr2553149ejj.237.1545410659933;
        Fri, 21 Dec 2018 08:44:19 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id j4sm3138649edh.69.2018.12.21.08.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:44:19 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m22so6355728wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:44:19 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr3483733wmj.14.1545410659115;
 Fri, 21 Dec 2018 08:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-2-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-2-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Dec 2018 00:44:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Message-ID: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
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

On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d5ec1a20499d..64d073cb2aee 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  {
>         /* Flush RX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +       regcache_cache_bypass(i2s->regmap, false);

IIRC the flush cache bit is self-clearing. So you likely want to mark
this register as volatile. If it is marked as volatile, then all access
to that register bypasses the cache, so the regcache_cache_bypass calls
are unneeded.

However, looking at the code, the write would seem to be ignored if the
regmap is in the cache_only state. We only set this when the bus clock
is disabled. Under such a condition, bypassing the cache and forcing a
write would be unwise, as the system either drops the write, or stalls
altogether.

>
>         /* Clear RX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>  {
>         /* Flush TX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear TX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>
>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>  {
> -       switch (reg) {
> -       case SUN4I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> +       return true;

I don't understand why this is relevant. Do you need to read back from the TX
FIFO?

If so, just drop the call-back altogether. If no callback is provided and no
rd_table is provided either, it defaults to all registers under max_register
(if max_register < 0) are readable.

However this seems like it deserves to be a separate patch (where you explain
in the commit log why it's needed).

Regards
ChenYu

>  }
>
>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
>         case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_FIFO_TX_REG:
> +       case SUN4I_I2S_FIFO_STA_REG:
>         case SUN4I_I2S_INT_STA_REG:
>         case SUN4I_I2S_RX_CNT_REG:
>         case SUN4I_I2S_TX_CNT_REG:
> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>         }
>  }
>
> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> -{
> -       switch (reg) {
> -       case SUN8I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> -}
> -
>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         if (reg == SUN8I_I2S_INT_STA_REG)
>                 return true;
>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> -               return false;
> +               return true;
>
>         return sun4i_i2s_volatile_reg(dev, reg);
>  }
> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>         .reg_defaults   = sun8i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> --
> 2.20.1
>
