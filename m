Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E56C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE02177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1QPWo5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfBCXDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 18:03:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35493 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfBCXDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 18:03:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so10705309otj.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 15:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPD+l1xaqEsWAgIbmxMqQQdeM6d4n6Jou6VFTidid7g=;
        b=m1QPWo5Zi3dEnlqMKzcGAJg0gkT0doxrz2QiiE+1U4vwUZqr2LcWTjX3z7vXWK5dkO
         fyRIn6RzwjQ6CMPwT5XWmY4Bg/0H+3R/5Vhu6wUTPmyO4jVYTC4RFXfai5/+PFTZcA4j
         nUgrUb6W2BsBfBQfmEM4V1gc6NQaEEmlWrrdwgBp84FI0mvEGLNmIhLG9yo1GREPp58o
         49CGpOwcG4qwsVYc6uocVpdcdHGse+CDZc7o/VnXZWFVfev83MXun6HzP3t5wmR9bbqd
         /FLXqOGr5mtK4oMcMEkCcrhdbPVkHes6inrXAek4AN8j0MqEnddaWirzbmRGfraSJavr
         +hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPD+l1xaqEsWAgIbmxMqQQdeM6d4n6Jou6VFTidid7g=;
        b=oBn6pCPSp6vTNRHq26IPvH3wbLwg0OdqBymxqxAFjR8dzqXwsaILi1ddSVMTj59Yv9
         ei27RFHG23sSdYxTnPRguB0Kmu7DpXez0d3Dc6WeI14+ZGd24VZK+V82Jmy4hOz81xSj
         pAzW8LdK28o7XdaX+aFTi2oZAgPNg3fL+SsP9hlFzp6j9uFnyjNU5X29nYXzpfvDIbQc
         hPHoDuOvU69PelXZSSTSMGiDiX3pJri8CGHhuywBUferrOcn1izeOdzgCO5sLMYgmXIi
         xO18IJyksRXCo6Gy+Ta0PYfrGttQ1j/F8+AEy36TZh0J2BlJBUQUxkMxUM/MODd8cYYn
         I7LQ==
X-Gm-Message-State: AJcUukd1/iEQmfkOHKmYG4Urxr0fKxjj+btyD2tx4IN6H9qX2aQ9nRUt
        15qWLDJaKjsrzNo6lzlJ4rPM4WeQYxRKGSU+j4yv6Q==
X-Google-Smtp-Source: ALg8bN4LIQ3rlEDLlpMW5rc9AapEVRJj8E4e1r1psQWe+HPzwP8qkFHnistlcqo6ub39kPZRZuxcmAvS2MSTjwgMCV0=
X-Received: by 2002:a9d:721e:: with SMTP id u30mr36550682otj.203.1549234997642;
 Sun, 03 Feb 2019 15:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20190128123542.CABAC1127D29@debutante.sirena.org.uk>
In-Reply-To: <20190128123542.CABAC1127D29@debutante.sirena.org.uk>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 3 Feb 2019 15:02:51 -0800
Message-ID: <CA+E=qVcqPhJXQdeAdWTAb4pjgEp5n05x5=HbpuKuWHi6TDaJkQ@mail.gmail.com>
Subject: Re: Applied "regulator: axp20x: fix ALDO2, DLDO2 and ELDO3
 definitions for AXP803" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mark,

Could you please apply it into your for-5.0 branch? It's a fix for a
regression and without this patch axp803 is broken in 5.0.

Regards,
Vasily

On Mon, Jan 28, 2019 at 4:35 AM Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803
>
> has been applied to the regulator tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From 252d1c20551b745f33a490892335d2b09f5d48a7 Mon Sep 17 00:00:00 2001
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Date: Fri, 25 Jan 2019 22:18:09 -0800
> Subject: [PATCH] regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for
>  AXP803
>
> Looks like refactoring didn't go well and left ALDO2, DLDO2 and ELDO3
> definitions broken for AXP803 - now they are using register address
> instead of mask. Fix it by using mask where necessary.
>
> Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 0dfa4ea6bbdf..087cadb96fab 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -723,7 +723,7 @@ static const struct regulator_desc axp803_regulators[] = {
>                  AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
>         AXP_DESC(AXP803, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
> -                AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
> +                AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
>         AXP_DESC(AXP803, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
>                  AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
> @@ -733,7 +733,7 @@ static const struct regulator_desc axp803_regulators[] = {
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
>         AXP_DESC_RANGES(AXP803, DLDO2, "dldo2", "dldoin",
>                         axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
> -                       AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
> +                       AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
>                         AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
>         AXP_DESC(AXP803, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
>                  AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
> @@ -748,7 +748,7 @@ static const struct regulator_desc axp803_regulators[] = {
>                  AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
>         AXP_DESC(AXP803, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
> -                AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
> +                AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
>         AXP_DESC(AXP803, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
>                  AXP803_FLDO1_V_OUT, AXP803_FLDO1_V_OUT_MASK,
> --
> 2.20.1
>
