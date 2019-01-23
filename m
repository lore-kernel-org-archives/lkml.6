Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8532133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+6WJkTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAWP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:27:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45358 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfAWP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:27:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so2194019ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYpHC0eFfgfiP/v5zSDaYT6m96U+a6iTQdTmvMW8q6I=;
        b=D+6WJkTR5fCtbRLAGcaLmJ53KCYTxvIqk0WAN4hqrqvuaak9DG3mfO9fydZ14YVAN9
         HnGEJx3OZnfXVqrPj2SRN2nCgR0bWaQJzhPVpSf1kaoYAHlhdm1pirYM9xCFlmaXmVgP
         HfRnJcTrEyKdqKw029R5YPcQ+Swzik4xhRezVnFTsN8Pn7PAyhZfr+zNM2lrpwCnT/yY
         cgRO9HmmKj6NxQlUCeskMQ3FtlImhtsN5LOHh36PVsJ7qf8LzrCCxbcivMuccsGe0FQN
         6y/IB2y9r8tlYv9GiTiwc0yiej69u+X+cLfSKmuALn6ZbHmzLNCn1PJWkQYGfCGjdRJi
         vtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYpHC0eFfgfiP/v5zSDaYT6m96U+a6iTQdTmvMW8q6I=;
        b=R6ycA7jiq/OWjxHYG8yiuwhlnnOO00Yu3RRfNnPitVckK7NAiOiRNiHEMRTrrhm/ye
         euo//K+/bggY4Fv9rid0nKlfY1Uh1ZYu8Rw+8XNiiWLRsroEiecEwpX7ikIaV2eHbNK2
         SCfiAUszgvf92lMWMPTaCL1EyNZ36RCOfLyWvEyRBwrZXkV2cyGsqlswZkNZ2IxYKb5h
         UwT+svg8etfmIJwgVd+GEunVoMVYnYKBFFqVlLoVHmLX0aQgT6iQDzzFkz7P6nEzzReJ
         JeX1smIzOGQtX5z+Ou7GoZjWuc/fw+Pwt84NNZVpREV+Dn+tYUw473vIrBkqruYuxwAx
         LG9Q==
X-Gm-Message-State: AJcUukfhs0wYNveQGqWeX2hakcUMnw/MDfrXXOOauUF7mTGN95jKWeUK
        vOOQhDQA10idHnL4XQ+zl1eFLksE87sVnwnXHfbTQPDe
X-Google-Smtp-Source: ALg8bN6S2adO5EraSEuvb8Y7TCZgSjjqMbNUEonAK5TKhk9TdZbK+uLw9Q+ECp8E2VL79QRgct4/wYJei9BWlAgmscU=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr1574564otk.63.1548257255993;
 Wed, 23 Jan 2019 07:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com> <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 23 Jan 2019 20:57:23 +0530
Message-ID: <CANAwSgQp2bc+HdTdX915bSUHRdZaJbXoriV7guK58G0bNwBtyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] regulator: pwm: suppress EPROBE_DEFER error message
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        boris.brezillon@free-electrons.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, 22 Jan 2019 at 00:07, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Suppress the "Failed to get PWM" error output if the actual error code
> is EPROBE_DEFER. This makes the behavior of the pwm-regulator driver
> consistent with what most other drivers do (which is: print all errors
> except EPROBE_DEFER).
>
> An example where this cleans up the kernel log are the 32-bit Amlogic
> Meson boards:
> multi_v7_defconfig has CONFIG_REGULATOR_PWM=y and CONFIG_PWM_MESON=m.
> When booting such a board (for example the Meson8b Odroid-C1) the
> following message is printed five times during boot:
>   pwm-regulator regulator-vcck: Failed to get PWM: -517
> On the sixth call the pwm-meson driver is finally loaded (as rootfs
> becomes ready) and the "VCCK" pwm-regulator comes up fine.
>
> Fixes: aa66cc6630a408 ("regulator: pwm-regulator: get voltage and duty table from dts")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/regulator/pwm-regulator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index 3f53f9134b32..7789d181ae67 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -357,7 +357,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>         drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
>         if (IS_ERR(drvdata->pwm)) {
>                 ret = PTR_ERR(drvdata->pwm);
> -               dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> +
>                 return ret;
>         }
>
> --
> 2.20.1
>
Please add my. tested on Odroid c1+

Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand

>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
