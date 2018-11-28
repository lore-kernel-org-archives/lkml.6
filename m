Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03251C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0A20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3Wb+jJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E0A20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeK1V6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:58:05 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35225 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeK1V6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:58:05 -0500
Received: by mail-ua1-f67.google.com with SMTP id d2so8744221ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGhghgtxjguW2pJnyy1BN0lxlDT6vR8savGXlVJYFn4=;
        b=B3Wb+jJU8jyTcYZGZApEuKNv7i1631UPelhMn0muiP9hL298DGSP5aZaBAsqYl10H+
         txa85E1JDApLnTVcz17H4qjVL11bzVWJYqSdekZO3XwhR999Xvo1zF0CJaGuh/l514LF
         a1hfA9uhET7VDGsfcedkxkxhbLM0+v71o/zq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGhghgtxjguW2pJnyy1BN0lxlDT6vR8savGXlVJYFn4=;
        b=Af4pLzpU/lyv+pMJ6aV+R5V8LwM8JVPGV5ouSqz7l01JJswDvLWTfFhm1EKFIahXGs
         TPvkjjKbc6ZQSMRwXuQxoZ6R/EVO2PrVOvq6xNvtDgPYFc6GEkI3aKrPuQELR2aaJBhL
         3TIk7DS/t9noaPNwiumps0ZMMr2Fxuex1AzytBt0g9xFLuH7UaIKcF5jAaQAXQT+Rfsv
         3lRlzhKFMfgsc7ICo0eB42swcpVdCC+bzjuu0VF7z4oSDmSGpewt3gdf59PFlEHNqiy8
         pYJxkDdY9GihnFxdrz/YUs4XZd7I51GjmlwrXIpKhwLZo4RgLu+bfOhqSKKbOt91vtbK
         G/iQ==
X-Gm-Message-State: AA+aEWb5qjiEq+/TEhDB5dM3Y4KTf5f05kZ+fl9NkR5vsCzoloOd9Unl
        ET//Z5cNvphy7wiIVlhOj18dv8xO2RRRK6LV/EryaQ==
X-Google-Smtp-Source: AFSGD/UskW12e2R52WhfYHCCJfn3pDxe/kxoLpNdBdTICXa/ixrttWxrodH1ktTw4YGe8mTq0GVBmNal+a4iZ4oB204=
X-Received: by 2002:ab0:304b:: with SMTP id x11mr14338547ual.91.1543402609060;
 Wed, 28 Nov 2018 02:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-3-cychiang@chromium.org> <4f8debc0-40f3-6195-8acb-de9ae3335671@linaro.org>
In-Reply-To: <4f8debc0-40f3-6195-8acb-de9ae3335671@linaro.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 28 Nov 2018 18:56:22 +0800
Message-ID: <CAFv8NwLQGkJttDeLhmg+LPBO222khnprVxaX2VQyi6JMHx=svw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: qcom: sdm845: Add codec related
 configuration for sdm845
To:     Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>, rohitkr@codeaurora.org,
        Dylan Reid <dgreid@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 5:32 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for the patch Jimmy,
>
Hi Srini,
Thanks for the review!
I have updated the patch series in v2.

> On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> > Set TDM time slots and DAI format for speaker codec.
> > Set DAI format and clock for headset. >
> > Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>
> Overall the patch looks good for me, but this needs to be split into two
> patches + few more minor nits!
Separated for speaker and headset in v2.
> > ---
> >   sound/soc/qcom/sdm845.c | 82 ++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 81 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> > index 43c03f8e8cdc2..d815040e98dc9 100644
> > --- a/sound/soc/qcom/sdm845.c
> > +++ b/sound/soc/qcom/sdm845.c
> > @@ -6,12 +6,15 @@
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/of_device.h>
> > +#include <sound/core.h>
> >   #include <sound/pcm.h>
> >   #include <sound/pcm_params.h>
> >   #include <sound/jack.h>
> > +#include <sound/soc.h>
> >   #include <uapi/linux/input-event-codes.h>
> >   #include "common.h"
> >   #include "qdsp6/q6afe.h"
> > +#include "../codecs/rt5663.h"
> >
> >   #define DEFAULT_SAMPLE_RATE_48K             48000
> >   #define DEFAULT_MCLK_RATE           24576000
> > @@ -34,7 +37,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
> >   {
> >       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > -     int ret = 0;
> > +     int ret = 0, j;
> >       int channels, slot_width;
> >
> >       switch (params_format(params)) {
> > @@ -81,6 +84,31 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
> >                       goto end;
> >               }
> >       }
> > +
> > +     for (j = 0; j < rtd->num_codecs; j++) {
> > +             struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
> > +
> > +             if (!strcmp(codec_dai->component->name_prefix, "Left")) {
> > +                     ret = snd_soc_dai_set_tdm_slot(
> > +                                     codec_dai, 0x30, 0x3, 8, slot_width);
>
> These constants needs some kind of defines to make the code more readable!
Fixed in v2.
>
> > +                     if (ret < 0) {
> > +                             dev_err(rtd->dev,
> > +                                     "DEV0 TDM slot err:%d\n", ret);
> > +                             return ret;
> > +                     }
> > +             }
> > +
> > +             if (!strcmp(codec_dai->component->name_prefix, "Right")) {
> > +                     ret = snd_soc_dai_set_tdm_slot(
> > +                                     codec_dai, 0xC0, 0x3, 8, slot_width);
> > +                     if (ret < 0) {
> > +                             dev_err(rtd->dev,
> > +                                     "DEV1 TDM slot err:%d\n", ret);
> > +                             return ret;
> > +                     }
> > +             }
> > +     }
> > +
> >   end:
> >       return ret;
> >   }
> > @@ -90,9 +118,26 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
> >   {
> >       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +     struct snd_soc_dai *codec_dai = rtd->codec_dai;
> >       int ret = 0;
> >
> >       switch (cpu_dai->id) {
> > +     case PRIMARY_MI2S_RX:
> > +     case PRIMARY_MI2S_TX:
> > +             /*
> > +              * Use ASRC for internal clocks, as PLL rate isn't multiple
> > +              * of BCLK.
> > +              */
> > +             rt5663_sel_asrc_clk_src(
> > +                     codec_dai->component,
> > +                     RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
> > +                     RT5663_CLK_SEL_I2S1_ASRC);
> > +             ret = snd_soc_dai_set_sysclk(codec_dai,
> > +                             RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
>
> Use DEFAULT_MCLK_RATE here.
Fixed in v2.
>
>
> > +             if (ret < 0)
> > +                     dev_err(rtd->dev,
> > +                             "snd_soc_dai_set_sysclk err = %d\n", ret);
> > +             break;
> >       case QUATERNARY_TDM_RX_0:
> >       case QUATERNARY_TDM_TX_0:
> >               ret = sdm845_tdm_snd_hw_params(substream, params);
> > @@ -155,14 +200,20 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
> >   static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> >   {
> >       unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> > +     unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
> >       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >       struct snd_soc_card *card = rtd->card;
> >       struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> >       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +     struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +
> Unnecessary New line here.
Fixed in v2.
>
> > +     int j;
> > +     int ret;
> >
> >       switch (cpu_dai->id) {
> >       case PRIMARY_MI2S_RX:
> >       case PRIMARY_MI2S_TX:
> > +             codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
> >               if (++(data->pri_mi2s_clk_count) == 1) {
> >                       snd_soc_dai_set_sysclk(cpu_dai,
> >                               Q6AFE_LPASS_CLK_ID_MCLK_1,
> > @@ -172,6 +223,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> >                               MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> >               }
> >               snd_soc_dai_set_fmt(cpu_dai, fmt);
> > +             snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
> >               break;
> >
> >       case SECONDARY_MI2S_TX:
> > @@ -190,6 +242,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> >                               Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
> >                               TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> >               }
> > +
> > +             codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
> > +
> > +             for (j = 0; j < rtd->num_codecs; j++) {
> > +                     codec_dai = rtd->codec_dais[j];
> > +
> > +                     if (!strcmp(codec_dai->component->name_prefix,
> > +                                 "Left")) {
> > +                             ret = snd_soc_dai_set_fmt(
> > +                                             codec_dai, codec_dai_fmt);
> > +                             if (ret < 0) {
> > +                                     dev_err(rtd->dev,
> > +                                             "Left TDM fmt err:%d\n", ret);
> > +                                     return ret;
> > +                             }
> > +                     }
> > +
> > +                     if (!strcmp(codec_dai->component->name_prefix,
> > +                                 "Right")) {
> > +                             ret = snd_soc_dai_set_fmt(
> > +                                             codec_dai, codec_dai_fmt);
> > +                             if (ret < 0) {
> > +                                     dev_err(rtd->dev,
> > +                                             "Right TDM slot err:%d\n", ret);
> > +                                     return ret;
> > +                             }
> > +                     }
> > +             }
> >               break;
> >
> >       default:
> >
