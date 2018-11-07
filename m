Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80199C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F0120862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilkOvlVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F0120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKHFX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:23:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40315 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKHFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:23:56 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so21279615itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4KMUeVBB2PsW2s3eUbDweq1jpGXsySqNaHA3LrsjEo=;
        b=ilkOvlVBXaVi9CSnAf3YDKBTmPO9iMiZVWX/1TXzBLJNYaXkG9Q7H0akE/H270wshs
         vOfJZ4k24ocLFgZbrlczmzBvdNwTRamOw6+zRxA4lXfbjQl6KCYFmsm/eMBlA2fBA5EY
         5TYIsvQphkKs1MmH1PyIN58AU8VfyESCYpMIuXfC9GgUnyfChRm7mzK/7vECyQ+FulCr
         N9TvQ9rWKTzKdwh9Df8WXwugQ3mXoRg9NXJXRJB2JshIHILhipJrklpLs22SPb8G7NzZ
         1u4GdDjJInIkiCboL+ww49totYp7hT3e23VZOspsDdAA5cd6Q2RzMU46pXojDagvofKK
         gT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4KMUeVBB2PsW2s3eUbDweq1jpGXsySqNaHA3LrsjEo=;
        b=iEa/+JVOmJD01qNgCE7shCDpYGCbhreg/FVGlcOEcfhVM/DhA8jH+NQK4bRC9dyPSM
         h9W26qvYnHMqqVv6/PNX2zyacX3mXdKSAkZCCClYlpgRl+JHwr+a9o7Z/+OsPkTXgUHS
         PVg9v5XxJ+kl3HDBkZiIlP2t1UKERDWhj2GZJxwZkJRjZvCi6BQsybvKyHwLl6bRzQPN
         lPEqpRaKpxQyhFE392tJcraDCZZMnfoytByoxQV2ytw8hQTs+AJb/bXZAy6BO6uVk38q
         85jb8jEQUSwzMoh2O5N/U7h4MCysHLA36zwxulu3kIAMAmAxvGsri5pEfGdD8rucKykg
         q7/A==
X-Gm-Message-State: AGRZ1gJ5DvksAiRC7nCxfbPCnFudmnc/v+7ROhi1aZEq3vCujAjW/IQo
        cA/tT3C5Rr9HbGPgEVaZwmfN8E+ulBiSfyOqn73h3A==
X-Google-Smtp-Source: AJdET5dCDidE0yqPAnp1/W3asym3xWDwdkeG29hFFkYEwObxSQWYxnVAaudvAwAc1yKwYkgWhouMCXrghzdNlP1+CqM=
X-Received: by 2002:a24:b804:: with SMTP id m4-v6mr1332566ite.72.1541620324553;
 Wed, 07 Nov 2018 11:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107134434.354795-1-tmaimon77@gmail.com> <20181107134434.354795-2-tmaimon77@gmail.com>
In-Reply-To: <20181107134434.354795-2-tmaimon77@gmail.com>
From:   Kun Yi <kunyi@google.com>
Date:   Wed, 7 Nov 2018 11:51:37 -0800
Message-ID: <CAGMNF6Vn1J3eo529zPqAHeD+CfZFUHE2T8ZJK71EA2EN=j7mnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: modify NPCM7xx pin configuration function
To:     tmaimon77@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        linux-gpio@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 5:44 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Modify GPIO direction setting in pin configuration function by using
> generic GPIO functions to set the GPIO direction instead of direct
> access to the GPIO direction register.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Kun Yi <kunyi@google.com>

Thanks for sending the patch Tomer!
> ---
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> index 7ad50d9268aa..b455209382a5 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> @@ -1799,19 +1799,12 @@ static int npcm7xx_config_set_one(struct npcm7xx_pinctrl *npcm,
>                 npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_PU, gpio);
>                 break;
>         case PIN_CONFIG_INPUT_ENABLE:
> -               if (arg) {
> -                       iowrite32(gpio, bank->base + NPCM7XX_GP_N_OEC);
> -                       npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_IEM,
> -                                     gpio);
> -               } else
> -                       npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_IEM,
> -                                     gpio);
> +               iowrite32(gpio, bank->base + NPCM7XX_GP_N_OEC);
> +               bank->direction_input(&bank->gc, pin % bank->gc.ngpio);
>                 break;
>         case PIN_CONFIG_OUTPUT:
> -               npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_IEM, gpio);
> -               iowrite32(gpio, arg ? bank->base + NPCM7XX_GP_N_DOS :
> -                         bank->base + NPCM7XX_GP_N_DOC);
>                 iowrite32(gpio, bank->base + NPCM7XX_GP_N_OES);
> +               bank->direction_output(&bank->gc, pin % bank->gc.ngpio, arg);
>                 break;
>         case PIN_CONFIG_DRIVE_PUSH_PULL:
>                 npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_OTYP, gpio);
> --
> 2.14.1
>


--
Regards,
Kun
