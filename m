Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CBD23FDB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF3x0/55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CBD23FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeGFIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:22:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37130 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeGFIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:22:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so21972829oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CU8vMdT0tdTTSdlSyG2h3EYW/0h+m4Lj1SFLR5c2pm0=;
        b=SF3x0/55SUWQBo2CR6WQI6+2f1wdIP5AGvbqK1q6jnT2V+rwXQE+XB2N2eAakT2XKQ
         QkCedCa4/r3WiHWHv12E+2Uf+fDMolV5s5gnshHe4t17R/iVV39bbWYoyg9UJ3JHk0Rv
         kTKqX8yxRT2uFkmWqp4xIu4u4gmOy5nonUV9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CU8vMdT0tdTTSdlSyG2h3EYW/0h+m4Lj1SFLR5c2pm0=;
        b=j5OXOdiBGDSgpfh/qSQ7vuYCh1R0e+Uzp49G15pXS6mT9l5vyMD2Lw09e1yapFrrtg
         3pKWwjoFCpUMVeb5neEKzcPqcPx3NrgdO0G3jeBxG7/7qa0ooh/Ovv2+yZNsYw2wunJa
         HLCEa03HQFqC/qUQrjWDg6lqvQ/QWnfHbhNvwT3fQO1FLDkY1Ikmb8qDX800mVmUP72h
         D64UBISgAfA5c8UfzzpinHPjG2dezJFK2WcAw3lTtr3aMNrBp+6y/MXrkKD/k1ydYpAg
         FGTOTmQjBdVc5KZgYr6ahR3dbUOc5+FrrtV+zOWpOzSjT7xwCZ05LUirJmcmnYQON7ci
         dVoA==
X-Gm-Message-State: APt69E1L3fTb+TNmO5rpHC8GTWBf0iq3BItBYCrfU+6vkWL/nKyfIi12
        y5pZfTd70likLPavdlr88V6b32Dr1Xi3QQPlQPPQP/mjL2g=
X-Google-Smtp-Source: AAOMgpcPZRO1bWM6jHWN821wIOtXolhkVdZwwY1V0SmMlVo7I8XeCYh7Wyu1XBtUcdGexypHI4pJ6Mygbb1+F4ZchAE=
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr11162480oih.269.1530865363608;
 Fri, 06 Jul 2018 01:22:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:22:43 -0700 (PDT)
In-Reply-To: <1530271355-5608-1-git-send-email-yannick.fertre@st.com>
References: <1530271355-5608-1-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Jul 2018 10:22:43 +0200
Message-ID: <CA+M3ks5GNf6i_mFqFEganGJ7-3nY+OxGwxzX1UYbT1dkv8WtMg@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: rework reset sequence
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-29 13:22 GMT+02:00 Yannick Fertre <yannick.fertre@st.com>:
> Reset must be properly assert before deassert.
> This is important if there is an early boot splash screen
> before the kernel start up.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Applied on drm-misc-next.
Thansk,
Benjamin

> ---
>  drivers/gpu/drm/stm/ltdc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 96d20c2..8f4606d 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1130,8 +1130,11 @@ int ltdc_load(struct drm_device *ddev)
>                 }
>         }
>
> -       if (!IS_ERR(rstc))
> +       if (!IS_ERR(rstc)) {
> +               reset_control_assert(rstc);
> +               usleep_range(10, 20);
>                 reset_control_deassert(rstc);
> +       }
>
>         /* Disable interrupts */
>         reg_clear(ldev->regs, LTDC_IER,
> --
> 1.9.1
>
