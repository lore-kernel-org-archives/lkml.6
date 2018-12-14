Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7673720656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="exVl699G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeLNNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:45:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38450 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbeLNNpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:45:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so4300140lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GlndrkBzZjCVmciAqDDBHx6kfwbZc1gOvwHDalX+ngc=;
        b=exVl699GEmlm8oldWKL1LwuPt9yeIRT5y4UVH5XP6+T5T28nMeP/XJao+5u0XA7joU
         WfaoBlMsnve4VzsvzDDy/yoN3UIdKpz2etl/JsP7q1ULAZxV8EpVEihOLUGkaFrGkNVg
         eguNwf/0mx7Mr4sdng8Z9hRGHO6QpoWNMkILQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GlndrkBzZjCVmciAqDDBHx6kfwbZc1gOvwHDalX+ngc=;
        b=dwnfYbze20eG37Cj36dnldz4ozLe80eOyYaWBH84PqaqZCioAuM72fEKH0nT7uvpYc
         xO+iRtwO4bSVglCXJ+RvmUgh11cfkrsewDNFamVELp0gOKZM2a4dNzj7z8JYS2fROxVn
         09tsMip+ryFuB2jiOAkaCzkDd0yw3aBnqN7A3I9zpkZX9X4bvyKb0ek5GxG/cqo76dhG
         CLgQBxpORiEkKIgdPga79SgG6G5x15OJKDDoMZHFlH/TRPExJ5SkJ3WG6H0odzS9mjqB
         gm3Ng8sE25jf5BEEv/rao6ktnmECNlMNOb1YpKs/ne1gKiRNnF1qoA61gjaaH+aNb/Li
         xQjw==
X-Gm-Message-State: AA+aEWbQ0AoUyVWTQp/uJ894jLLCOS0xa19YVkn5CSdVXu5IcChs/cxt
        2pU2ENPwAJogWotkeOTHfIyGYbzW3azKj+Tj4Xn5+fUUMDY=
X-Google-Smtp-Source: AFSGD/U594rkXkcTByZ+SiXGYaXl6Q8sWICtaZrF4clnAgljXSvecCI4bHzfWIgMUNWYHiz4Br2/UoUu7Ny0IvncVXg=
X-Received: by 2002:a19:c801:: with SMTP id y1mr1813468lff.53.1544795131474;
 Fri, 14 Dec 2018 05:45:31 -0800 (PST)
MIME-Version: 1.0
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com> <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 14:45:18 +0100
Message-ID: <CACRpkdYYRp6Ju0zMhKGxnbnPXvFZmDJUssrLf1ad9LG4cNO2Qg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
To:     Michal.Vokac@ysoft.com
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        l.majewski@majess.pl, Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:41 PM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.c=
om> wrote:

> Output of the PWM block on i.MX SoCs is always low when the block is
> disabled. This can cause issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle =3D 0% corresponds to high level on
> the output. Now, when PWM is disabled its output instantly goes low
> which corresponds to duty cycle =3D 100%.
>
> To get a truly inverted PWM output two pinctrl states of the PWM pin
> can be used. Configure the pin to GPIO function when PWM is disabled
> and switch back to PWM function whenever non-zero duty cycle is needed.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Slightly different description of the pinctrl and pwm-gpio.

This looks good to me.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
