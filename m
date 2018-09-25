Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC567C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB02214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLq7BAAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB02214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIYOne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:43:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33371 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:43:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id i10-v6so12463491qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP6fDPPAQfGNrMMjDKx9nRuA4WwUR3kEI4qEO5M51aU=;
        b=kLq7BAAMrWPRtK+75E6XM1NFC13XGztmLwrvNP4qmeK6hIiv1EGLHoW4CtHu4uYDze
         9mspVoNyQm+ue1VFVH47Udr18FEoNTesNkBZbcgO2PLeZH+KMQu+EU7hgp+ayq731h4P
         QVLMvO5TnHAO+U99H4140EGpBf0pJk56ZXvV36/pEgcJWocV8qOaQ3VmqH9wMZnwwLfj
         WfQIfiolM6CB61EiVYrpNe1LBFyb7fv2f44nMiliv5DcsYaM75+zMVjaEAYZ3bed24oO
         VtLievynRvSTDyypRIicuzX8JZH2n8uFoPDHEQVFkuEMNsDV44qn0941Tf2vfcWbdBVG
         leaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP6fDPPAQfGNrMMjDKx9nRuA4WwUR3kEI4qEO5M51aU=;
        b=JEVWGHQzY0okKSh1sFx446CWErDEQVQQaGw/KEZLqUWq73MzyoXqAIA2RJlok/Z2j6
         RCnUl80bgOAO7kU36ePro7X0teREHk3/SA2XVizi1n1Dd0N4XMIUew0qAU2HFsIJN8a4
         bOfl7wRyhOLCw947OiGZggq5mkTBUXMBNKRcaBuPExfw+sC7LeBy87gdDNZJqQ387gom
         9//54lC7J8bdhGTln1bpE7VhxXl/eO/ACmizMUBwwvB1jpvq6/Qb4eIASJkYcS0ctYmP
         M/9MFgSWwKruDCB8QmVcrlHf7TuErhAFXUwXHnQmNggvZotj/QuRH0eRi60n+ZZtBfEH
         mMrg==
X-Gm-Message-State: ABuFfogtPEyfDSHyLn8wBbbws3sKOSAQSccd1/TTtDC8SbCDnMz0ozKb
        f3rmQsWHSkFBSB3GrW1VAc4YyGPQw55AESUtweU=
X-Google-Smtp-Source: ACcGV601vr6Ja1rD8oAomgyT9L/yMH7er2ccmh73vU34t+2biwTAz7FHPJLfwoeKogjkEOzjMcB3BBtil1YDbh3sz9U=
X-Received: by 2002:aed:21ac:: with SMTP id l41-v6mr1892402qtc.293.1537864626525;
 Tue, 25 Sep 2018 01:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180925004711.99422-1-mka@chromium.org>
In-Reply-To: <20180925004711.99422-1-mka@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 11:36:55 +0300
Message-ID: <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_ops
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 3:48 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The symbols 'dummy_dma_ops' is declared with different data types by
> sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
> leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:
>
> sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
>   static const struct snd_pcm_ops dummy_dma_ops = {
>                                   ^
> ...
> arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
>   extern const struct dma_map_ops dummy_dma_ops;
>                                   ^
>
> Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

But it misses 'dma' part as I can see they are still DMA related.

snd_dummy_dma_ops ?

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/soc-utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> index e0c93496c0cd..ab44133bc0bf 100644
> --- a/sound/soc/soc-utils.c
> +++ b/sound/soc/soc-utils.c
> @@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
>         return 0;
>  }
>
> -static const struct snd_pcm_ops dummy_dma_ops = {
> +static const struct snd_pcm_ops snd_dummy_ops = {
>         .open           = dummy_dma_open,
>         .ioctl          = snd_pcm_lib_ioctl,
>  };
>
>  static const struct snd_soc_component_driver dummy_platform = {
> -       .ops = &dummy_dma_ops,
> +       .ops = &snd_dummy_ops,
>  };
>
>  static const struct snd_soc_component_driver dummy_codec = {
> --
> 2.19.0.605.g01d371f741-goog
>


-- 
With Best Regards,
Andy Shevchenko
