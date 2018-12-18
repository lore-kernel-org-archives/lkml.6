Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3629BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB7721841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/SwwLqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeLRHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:51:17 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42957 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeLRHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:51:17 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so9425316vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRQ1Ns1Hb+fH3c6jwKhR+JIom6cyMNiXXfCsZV1TOJY=;
        b=B/SwwLqMR1ys1/6yMXoGDbABr1z/UbvXPGdjTxo5QT0gwbWSXm6KHwpxzEXUG0Nrxt
         bDXFh3nxhVz0AZhr2y/jTZIJmST5C+YpyBzy9eoxe6VGrCtl/tmQ2uOmbNpiMdXUH4S/
         5TflPRUMtmw/BSZ72AkDRJaDxskeFo/NymFXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRQ1Ns1Hb+fH3c6jwKhR+JIom6cyMNiXXfCsZV1TOJY=;
        b=gsIL0rS6qU0htXppyxAdive6auEBEMp7F/NOaus8pxUt7FKVGNg0BSLWmL9K3emlO0
         8B5hClO3Jq6WgSQnyQsSDQL9bg55W0O6pFDBfk+JQC+2MHiRdGDN6pHRp+Lx8SCzAKXW
         /60L9n3qscRZW2S57ajMa9TprvLe86AoG0mD1oLYLIYKEujhrSz81RQKsRxtgbnUyfy/
         cpdC7eH1q1gHn1fRRFYuAYcFwNDrSxKfPpJuC80eJf4tnhZRyAjhgQAslZdLCoIqAvJm
         tPp+XNJyqC+yxtLP9aUi0L2UARnOVrUbU5bG2R4KrMjhM0zAheiRzSPVUUTMzXPs0o8U
         FSfg==
X-Gm-Message-State: AA+aEWYnSBwoGj4J1ViETuv+mIMvWu9Ry57MdFX3dUx0vZivHXdtcKF6
        ue0mgOYi4CDr+priqZ4hycrb/PqXsG30r5TqCrZ7dg==
X-Google-Smtp-Source: AFSGD/XElbFRoBvsgQ4uGVZkBGdnEGibLpktw4ELUkNS6yxfBerBazjsaFIcQesblUliscxtdIc1dpNfoaguszfDCJw=
X-Received: by 2002:a67:ad02:: with SMTP id t2mr730786vsl.170.1545119476147;
 Mon, 17 Dec 2018 23:51:16 -0800 (PST)
MIME-Version: 1.0
References: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
In-Reply-To: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 18 Dec 2018 15:50:49 +0800
Message-ID: <CAFv8Nw+Ydjbob2z5=eVpL8-OpVSPyDVkCLnPTu_asuwK3rCgmw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sdm845: set jack only for a specific backend
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rohit Kumar <rohkumar@qti.qualcomm.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 6:02 PM Rohit kumar <rohitkr@codeaurora.org> wrote:
>
> Headset codec is connected over PRIMARY_MI2S interface. Call
> set_jack for codec associated with Primary Mi2s interface.
> Also, set_jack to NULL when jack is freed.
>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  sound/soc/qcom/sdm845.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 1db8ef66..6f66a58 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -158,17 +158,24 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>         return ret;
>  }
>
> +static void sdm845_jack_free(struct snd_jack *jack)
> +{
> +       struct snd_soc_component *component = jack->private_data;
> +
> +       snd_soc_component_set_jack(component, NULL, NULL);
> +}
> +
>  static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>  {
>         struct snd_soc_component *component;
> -       struct snd_soc_dai_link *dai_link = rtd->dai_link;
>         struct snd_soc_card *card = rtd->card;
> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>         struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
> -       int i, rval;
> +       struct snd_jack *jack;
> +       int rval;
>
>         if (!pdata->jack_setup) {
> -               struct snd_jack *jack;
> -
>                 rval = snd_soc_card_jack_new(card, "Headset Jack",
>                                 SND_JACK_HEADSET |
>                                 SND_JACK_HEADPHONE |
> @@ -190,16 +197,22 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>                 pdata->jack_setup = true;
>         }
>
> -       for (i = 0 ; i < dai_link->num_codecs; i++) {
> -               struct snd_soc_dai *dai = rtd->codec_dais[i];
> +       switch (cpu_dai->id) {
> +       case PRIMARY_MI2S_RX:
> +               jack  = pdata->jack.jack;
> +               component = codec_dai->component;
>
> -               component = dai->component;
> -               rval = snd_soc_component_set_jack(
> -                               component, &pdata->jack, NULL);
> +               jack->private_data = component;
> +               jack->private_free = sdm845_jack_free;
> +               rval = snd_soc_component_set_jack(component,
> +                                                 &pdata->jack, NULL);
>                 if (rval != 0 && rval != -ENOTSUPP) {
>                         dev_warn(card->dev, "Failed to set jack: %d\n", rval);
>                         return rval;
>                 }
> +               break;
> +       default:
> +               break;
>         }
>
>         return 0;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks a lot for the fix!

Reviewed-by: Cheng-Yi Chiang <cychiang@chromium.org>
Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
