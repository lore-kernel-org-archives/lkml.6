Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED04D2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfBFKox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:44:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39672 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfBFKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:44:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so5453327edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGsdyVnsvueMd7e3go4Moqmxiho6AlTx9j/wqt5gug0=;
        b=ZjlEAlaSCXWQ/cpTN4vIkh/OGphb4KPyXlZWnCJhTKquivOGvHQ1k8Kt84QTWLHiiV
         3KywABWVvqnjuh/jOQotpJEyQRV/3Uarwv901eWwPaeN4D0VKBpqAidnA+I4HzaLXAqW
         I/PcqT+oqkznt+xXJEsPwiVFa0rxzGW/+yUhukvEAVyWZLQ5ioUEUz3NEuoDwygdOG+o
         DWW+CetjcRKi3pMtJf9ni5pCJ4HP/iMfH+n2AIM+beQ+UVcM3pA67WSk6ubz6zQxngrB
         2a6ASge5K2OSQEmZifu0xdyrEeFw6OBSNRmus6/jDU6Nhupfc/F1LleAVLftBdzs0Lj6
         2HJA==
X-Gm-Message-State: AHQUAuaft7plR3Ys+HjsMBKNzjj1qSblG8A+mTfhnxBxSMLYdm3qxrCP
        +5I13IPh26bHbpGnqju0Vjv9bnuZYVI=
X-Google-Smtp-Source: AHgI3Iam/XRt9CqjaxSrj4to3Yq7PnkxD0snmXGAnKKXQaGe4W2Ai4vn/SAUNxcsZLXZZANQf4rb8w==
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr2364294edy.165.1549449890537;
        Wed, 06 Feb 2019 02:44:50 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id p7sm3552998ejb.15.2019.02.06.02.44.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 02:44:50 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id v16so5103615wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:44:49 -0800 (PST)
X-Received: by 2002:adf:eb12:: with SMTP id s18mr7231589wrn.120.1549449889324;
 Wed, 06 Feb 2019 02:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20190128140219.4414-1-axel.lin@ingics.com>
In-Reply-To: <20190128140219.4414-1-axel.lin@ingics.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Feb 2019 18:44:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67UV51oaDXgF2ocTSYJVNhZFPf_bmDtqLDApA_YB-oqWA@mail.gmail.com>
Message-ID: <CAGb2v67UV51oaDXgF2ocTSYJVNhZFPf_bmDtqLDApA_YB-oqWA@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Fix incorrect vsel_mask settings
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:02 PM Axel Lin <axel.lin@ingics.com> wrote:
>
> Fix copy-paste mistake while converting to use defines for masks.
>
> Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though I believe the latter three have already been fixed by

    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-5.0&id=16c8a595740035c4a7ede608a60b4a59f67b76e6

Could you respin this patch on top of that commit?

ChenYu

> ---
>  drivers/regulator/axp20x-regulator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 087cadb96fab..6d081c8321a1 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -577,7 +577,7 @@ static const struct regulator_desc axp22x_regulators[] = {
>                  AXP22X_DCDC3_V_OUT, AXP22X_DCDC3_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC3_MASK),
>         AXP_DESC(AXP22X, DCDC4, "dcdc4", "vin4", 600, 1540, 20,
> -                AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT,
> +                AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC4_MASK),
>         AXP_DESC(AXP22X, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
>                  AXP22X_DCDC5_V_OUT, AXP22X_DCDC5_V_OUT_MASK,
> @@ -956,7 +956,7 @@ static const struct regulator_desc axp813_regulators[] = {
>                  AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
>         AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
> -                AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
> +                AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
>         AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
>                  AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
> @@ -966,7 +966,7 @@ static const struct regulator_desc axp813_regulators[] = {
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
>         AXP_DESC_RANGES(AXP813, DLDO2, "dldo2", "dldoin",
>                         axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
> -                       AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
> +                       AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
>                         AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
>         AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
>                  AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
> @@ -981,7 +981,7 @@ static const struct regulator_desc axp813_regulators[] = {
>                  AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
>         AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
> -                AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
> +                AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
>         /* to do / check ... */
>         AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
> --
> 2.17.1
>
