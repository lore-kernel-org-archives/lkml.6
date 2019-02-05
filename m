Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D412081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBEDh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:37:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43644 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBEDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:37:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so1705096eds.10;
        Mon, 04 Feb 2019 19:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OKxFE1NGTFAuh2DcDVQJHw+R/tQXQXNrsaaQF8GQVg=;
        b=QanL/BzfSfxfDfcqEMGLZ/xVbbI79z5SbTBgDnGrLtK/XQlQLlUX1B36xsGJZ6MTyO
         6Quhez5BNtICkH13MHJEeFjMkDIgkMY13bdHMjDIS7kCfdqnFLfJuQ2GiIE8fTdVh7g8
         zJ4ILzwu7GQAU7nR9a7pAaYmtukHAFsbiFBnUJkfGTcg8T7BmxhXek5+un7QMCC/tQPY
         4gpbleAxh4Xxgz/ARLU35AqUVLMYpjKmz5HtYgiwEybRQSDM37BNO9P9OpZPVmFaknCQ
         g49WPQDpiPrb8UsoKpKtl7ptZnSSEVRrt1Nx/XjbLaF87G4FdyZMLzT3HEUcoSfTs54I
         PYag==
X-Gm-Message-State: AHQUAuaOCuxb8S+Lu5kCdC6/l09zMyiahVAMYix+WtFAnNHcsMqQGALo
        KnEF9P7WwHhw2nod0yQz99w6D8T/nL0=
X-Google-Smtp-Source: AHgI3IYBhUaf+cFX+TUzP621OqqKSYDx/RfztXd7Wg1+SrF75+1x4NvKcRliC7NqLt1WCnZWo3UwxQ==
X-Received: by 2002:a17:906:258d:: with SMTP id m13mr1809753ejb.73.1549337875315;
        Mon, 04 Feb 2019 19:37:55 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id w28sm4833664edd.38.2019.02.04.19.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 19:37:54 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id p6so2112931wmc.1;
        Mon, 04 Feb 2019 19:37:54 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr1582268wmf.99.1549337874139;
 Mon, 04 Feb 2019 19:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20181222113159.31029-1-colin.king@canonical.com>
In-Reply-To: <20181222113159.31029-1-colin.king@canonical.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 5 Feb 2019 11:37:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v6597uiPec=BPvTZgppxF2upTa_zKHq+QSbddyMGJAd7uA@mail.gmail.com>
Message-ID: <CAGb2v6597uiPec=BPvTZgppxF2upTa_zKHq+QSbddyMGJAd7uA@mail.gmail.com>
Subject: Re: [PATCH][V2][next] regulator: axp20x: check rdev is null before
 dereferencing it
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 7:32 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently rdev is dereferenced when assigning desc before rdev is null
> checked, hence there is a potential null pointer dereference on rdev.
> Fix this by null checking rdev first.
>
> Detected by CoverityScan, CID#1476031 ("Dereference before null check")
>
> Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This patch somehow fell through the cracks. Sorry about that.

Both are really false positives. Both functions are callbacks for the
regulator core to use. If you look through the core code, rdev->desc->ops
is used to check for these callbacks before they are called. rdev is always
passed in, and rdev->desc is always valid after regulator_register.

ChenYu


> ---
>
> V2: Fix 2nd occurrance of this thinko
>
> ---
>  drivers/regulator/axp20x-regulator.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 48af859fd053..0dfa4ea6bbdf 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -367,7 +367,7 @@ static const int axp209_dcdc2_ldo3_slew_rates[] = {
>  static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>  {
>         struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> -       const struct regulator_desc *desc = rdev->desc;
> +       const struct regulator_desc *desc;
>         u8 reg, mask, enable, cfg = 0xff;
>         const int *slew_rates;
>         int rate_count = 0;
> @@ -375,6 +375,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>         if (!rdev)
>                 return -EINVAL;
>
> +       desc = rdev->desc;
> +
>         switch (axp20x->variant) {
>         case AXP209_ID:
>                 if (desc->id == AXP20X_DCDC2) {
> @@ -436,11 +438,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>  static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
>  {
>         struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> -       const struct regulator_desc *desc = rdev->desc;
> +       const struct regulator_desc *desc;
>
>         if (!rdev)
>                 return -EINVAL;
>
> +       desc = rdev->desc;
> +
>         switch (axp20x->variant) {
>         case AXP209_ID:
>                 if ((desc->id == AXP20X_LDO3) &&
> --
> 2.19.1
>
