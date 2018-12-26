Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8832171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxaoYZfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeLZRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:24:35 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37650 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbeLZRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:24:34 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so20891066iti.2;
        Wed, 26 Dec 2018 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDoe0h9uhd83kOri/WUN/6c7QD7cprUiK4aSXchZQo0=;
        b=hxaoYZfodDjQzT8IDOhHSRCeWk4osq4qYKjWUuzgOxN8ybPslCNPo4rPpGFIRqjHfF
         1pQQxLbz3FhGZBL/p8G/4PJ6efpi6BFKHtUqZaR2JXkCumPtwxxmzWgGyQCFCW5c/eQl
         UN4AwGFBwsfi2PcRQMnkNxJpI7FJ0QUdu9jR7qmhLQrGiDTxyD2pD4J40mPpoTpZ27oF
         vVkvilrGOqHTWNNsdei8LzMSJrbF6i11L/Y10Tsu79lBCaNtDZod/IHZ8EZf3wTV8HLo
         oDGBMYgnJGonAIe7+bIsTrTbe/VBEpQp+L2KXABzS7nJWZxkbapcrC0Af9qhYLkVsSdJ
         ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDoe0h9uhd83kOri/WUN/6c7QD7cprUiK4aSXchZQo0=;
        b=fo9C5h0awDyBrAe6RNkvbp+KwbQ0Yi9JGUGrkybBFbQMCWJHFev3LIdiZlEm5m0KWB
         rfBP7pwtFkKPdgWo7xeiU3giMMlAGXI/r/b7eVs1e9fk94f9o5/yXrSop+uUrwaNqRU5
         fzzAY3J1HU9bLXrUXrIVtWJWmsqQ5tg5rSfDxyLRfgAoccfT6Z7jVQkMjWwz952Ske3i
         bxfAdmZ8zbgXDGlNCP+XEUMHAmQBQGrgspKftmyxJKaqgHnkrhjarfsiq32T2sE1QtdT
         jJFmS7fQtJlhGuQyMiPofn4EvF9Ki4Ev0d+YwsXQ1/zOl6qka3MXQJHhfLtMFrOzQ+vl
         Nl/A==
X-Gm-Message-State: AA+aEWahKq0zjRDL1PRK1dCRkFFqLavd/PWACKTNtnLa4AwvPCqXQku6
        DGahplEeSU2I6aVpZyWOpddicptF8BNS3VXrPVQ=
X-Google-Smtp-Source: AFSGD/Vn5D2EX532L9ciOLTTS1oQNGR3iRdiDmFZHJ+LJDlDQ0Rxhh1Owthvyuzdwe0o9MNnE6g+pZC/C5ASx0mLfCo=
X-Received: by 2002:a24:1aca:: with SMTP id 193mr13346521iti.150.1545845073271;
 Wed, 26 Dec 2018 09:24:33 -0800 (PST)
MIME-Version: 1.0
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Thu, 27 Dec 2018 01:24:22 +0800
Message-ID: <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viorel,

Sorry for the late response, having been on a long vacation.

The code looks pretty clean. Just some small concerns/questions below.

On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> The Audio Mixer is a on-chip functional module that allows mixing of
> two audio streams into a single audio stream.
>
> Audio Mixer datasheet is available here:
> https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++

I aimn't against the naming here, but it seems to be AUDMIX in RM?

Would it be better to align with that? It's your decision though.

> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> +=================================
> +  - compatible         : Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg                        : Offset and length of the register set for the device.
> +
> +  - clocks             : Must contain an entry for each entry in clock-names.
> +
> +  - clock-names                : Must include the "ipg" for register access.
> +
> +  - power-domains      : Must contain the phandle to the AMIX power domain node
> +
> +Device driver configuration example:
> +======================================
> +  amix: amix@59840000 {
> +    compatible = "fsl,imx8qm-amix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_amix>;
> +  };

From the description of DT and RM, I don't see how it connects to SAIs.

Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be better
to have such information in the doc.

> diff --git a/sound/soc/fsl/fsl_amix.c b/sound/soc/fsl/fsl_amix.c

+static const char
+ *width_sel[] = { "16b", "18b", "20b", "24b", "32b", },
+ *pol_sel[] = { "Positive edge", "Negative edge", },
[...]
+static const struct soc_enum fsl_amix_enum[] = {
+/* FSL_AMIX_CTR enums */
[...]
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTWIDTH_SHIFT, width_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTCKPOL_SHIFT, pol_sel),

Should we handle the width in hw_param()?

Why do we change pol here? It feels like against set_fmt().

> +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +       /* For playback the AMIX is slave, and for record is master */
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +       case SND_SOC_DAIFMT_CBS_CFS:

So it's used either for playback or capture only, not both at same time?

Thanks
Nicolin
