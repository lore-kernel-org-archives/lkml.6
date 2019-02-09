Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08349C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF242217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqBdcSdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBIA7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:59:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBIA7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:59:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2489310plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXr/3kPpzIgIuHUJLlIdLekuVmI2zm0OEX4JCfJR2q4=;
        b=PqBdcSdbPSCHxzXo1N3eq1oSAMWB20ekV1wykbTnxQ9iAihclh8adPmdHkVFx7mJdm
         exrLe/tPBliP1k7VkAIo3yIZDrK4/JiKp1MzdlKFCGahVLji0iSKprr11/Y321MEGIwX
         IewE7NsRV/ZZfdzfhbQah06uHSoH8EsAZ6EV1us1qTWsQ1zaZwsTIFgAiHilN54k8bai
         LnAAH3lRy9kbj2XM2J24/vy9ioc+M9Up3LmWGy9HCS4C2ZnyPNooBan25HRqbmmj4tI7
         Mq16CdEoPf1+v9Wuoiu0bA7ZF6NKAPa1CMIc5DG1OK9fTGS2n7deHJSM4bqL1cceh2DU
         oh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXr/3kPpzIgIuHUJLlIdLekuVmI2zm0OEX4JCfJR2q4=;
        b=rYKrmy1YpgBzBQJdFZRxX5lODt5TVPNXB3zxPWZnFMOPNcg9B8InclRRkEdtGeWGrR
         MMnSrS1AgFq+Y3Fh/Gr414J6L4vx+ZUswfv8hwzU1V8iJHZL2ZivJW6233m3P0xJzhmh
         1uG7ZZMuJwX+idbrKy5HqdOYcak9XI6gSFquRzdaMGkcBYQWaK50/FuJnuJmqY/KX0fP
         NYSnnaGX+PTceBh+AhvXQmkZTWzLNIJQTfQ0MQ5jvEZzeR4TA6DnaBfGOsVZGBFJu/8V
         hkJXI+V/el6oe6p9ZN0VSur/7l84iSLXigExGDAuOAq7zSFfufpfLQ0JGLeJdbF9BXzm
         eUVQ==
X-Gm-Message-State: AHQUAuYmqCHy5s/SmtzXay0ocq4DsFlXJlPuTPSUjRs/4SDZBACl1Isc
        WpupWip39TXU+IQJq66EgcyyrmTa/q4w++nSaWWWyg==
X-Google-Smtp-Source: AHgI3IbhsL6VK29ARFNCMiS9RnERQv3Cbj+w/6gDyg7ITIr1CCqF+63CMVAH9iAPBj2keEM/Y3yuxgGEvq39C3vxFks=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr25715689plb.238.1549673955533;
 Fri, 08 Feb 2019 16:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20190208045918.16799-1-natechancellor@gmail.com>
In-Reply-To: <20190208045918.16799-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Feb 2019 16:59:26 -0800
Message-ID: <CAKwvOdkrzOVoZxPcdGHa-dkKBwVBCqiYqDh9Sc+htT=7YOL2RA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary const qualifier
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> sound/soc/codecs/jz4725b.c:177:14: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
> static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
>              ^
> include/sound/soc.h:356:2: note: expanded from macro 'SOC_VALUE_ENUM_SINGLE_DECL'
>         SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
>         ^
> include/sound/soc.h:353:2: note: expanded from macro 'SOC_VALUE_ENUM_DOUBLE_DECL'
>         const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
>         ^
>
> As it points out, SOC_VALUE_ENUM_DOUBLE_DECL has the const attribute in
> its definition so remove it here.
>
> Fixes: e9d97b05a80f ("ASoC: codecs: Add jz4725b-codec driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/354
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the fix.  Looks like the struct instance declaration
already contains a const.  That's a curious (not bad, per se) pattern
that probably results in a few other instances of this warning, I'll
bet.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  sound/soc/codecs/jz4725b.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
> index e3dba92f30bd..5cc8c7ca24c6 100644
> --- a/sound/soc/codecs/jz4725b.c
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -174,12 +174,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
>         "Mic 1", "Mic 2", "Line In", "Mixer",
>  };
>  static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
> -static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
> -                                       JZ4725B_CODEC_REG_CR3,
> -                                       REG_CR3_INSEL_OFFSET,
> -                                       REG_CR3_INSEL_MASK,
> -                                       jz4725b_codec_adc_src_texts,
> -                                       jz4725b_codec_adc_src_values);
> +static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
> +                                 JZ4725B_CODEC_REG_CR3,
> +                                 REG_CR3_INSEL_OFFSET,
> +                                 REG_CR3_INSEL_MASK,
> +                                 jz4725b_codec_adc_src_texts,
> +                                 jz4725b_codec_adc_src_values);
>  static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
>                         SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
