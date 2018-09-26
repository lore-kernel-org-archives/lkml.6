Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3573CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99622152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOvCGU0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99622152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeIZWDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:03:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36593 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeIZWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:03:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so10146941plk.3;
        Wed, 26 Sep 2018 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aSWkvMEu1uUwIqTtKLlkcl0fYZMCcaqWG1lcdFPt2FQ=;
        b=DOvCGU0EQtvhmqeExvdgY6LGT5IG2EgbNQeIqaql68sTGt9nGZ8ovSWWdQ+RCszhck
         jyp7er4kFc02W38tEZDDCdr10Qg8rfItWqTE8aLPdSgpwUbHaLkOoiU1b1OmV5ikEW1A
         jw5nboBpm+jJuVJ083XiuD5665Q6zBwcUVU3RhAqgpUpwaCWj1LR2PTHomwPq4U+Ov8B
         9NE/8f9kT/ozjkcSiw6u9ZVD5eW+yUwhFmlqUTvVZuJfyyoY1Yvj+wQUcHJKTFX7m7Vp
         rCw34cGN/m+MtQcCNo/eHqV/dUoqdsjYT6ajV4O6wRcCRe66KPvUhSeOfpz7Qv5n7Kjc
         k9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aSWkvMEu1uUwIqTtKLlkcl0fYZMCcaqWG1lcdFPt2FQ=;
        b=L3UMCU4hvNlyJwDuwfnENNfUK5ghbxjIyaKoLwiJkooJk0igYiEwUw6KxSRTfCK2S0
         qT1nuaDWoAyHL6GbO+bAUELuNF0ncDqV7hS8fnmvegSAiT1RlNLbC2e0x3fms9e+Jc2u
         mZDB2lEhJk3hNecL5/zJZhKlmZ0DFNu5RsJ+uDAhaVDB1ufjxxieqHHzgEieN+Orl/X1
         hNh2gkcjpgltTXng7U8Jsifm4l9ZZYqlYTCo9tHvXXZBUkKcv8M/nOuM24ocAGqdU9+H
         HEk+qKJXGOZr6/pFpJcdYFa0/mRvoGHKxvM5R2yyuvgNleTewCPZg7n/r8cGuTgaDOns
         rXjg==
X-Gm-Message-State: ABuFfog0C8QW2SMEyxXJlj6xCaqSqu8P69Wa+UF58NuE9Tl7h7OriVRO
        M6Gq+HvkmkItpZecPbKzO7lGmJmvKl3GnmkVr9E=
X-Google-Smtp-Source: ACcGV61AgJR1gfL3UwL6wKGNavSZ5IU2CGs7S7bWMbIZOuwm+QDSrFNgJpFEsfrMfOeWH76Zfry3YqXx7clvglmCTEw=
X-Received: by 2002:a17:902:760e:: with SMTP id k14-v6mr6764047pll.185.1537976989025;
 Wed, 26 Sep 2018 08:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180926125127.2004280-1-arnd@arndb.de>
In-Reply-To: <20180926125127.2004280-1-arnd@arndb.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 27 Sep 2018 00:49:37 +0900
Message-ID: <CAC5umygy=BBSF_v_vVNnrZ9_1LCpJW0V212yxVqmGUUF-kOOSA@mail.gmail.com>
Subject: Re: [PATCH] media: ov9650: avoid maybe-uninitialized warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        wsa+renesas@sang-engineering.com, gustavo@embeddedor.com,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8826=E6=97=A5(=E6=B0=B4) 21:51 Arnd Bergmann <arnd@arn=
db.de>:
>
> The regmap change causes multiple warnings like
>
> drivers/media/i2c/ov9650.c: In function 'ov965x_g_volatile_ctrl':
> drivers/media/i2c/ov9650.c:889:29: error: 'reg2' may be used uninitialize=
d in this function [-Werror=3Dmaybe-uninitialized]
>    exposure =3D ((reg2 & 0x3f) << 10) | (reg1 << 2) |
>               ~~~~~~~~~~~~~~~^~~~~~
>
> It is apparently hard for the compiler to see here if ov965x_read()
> returned successfully or not. Besides, we have a v4l2_dbg() statement
> that prints an uninitialized value if regmap_read() fails.
>
> Adding an 'else' clause avoids the ambiguity.
>
> Fixes: 361f3803adfe ("media: ov9650: use SCCB regmap")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

> ---
>  drivers/media/i2c/ov9650.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
> index 3c9e6798d14b..77944da31de1 100644
> --- a/drivers/media/i2c/ov9650.c
> +++ b/drivers/media/i2c/ov9650.c
> @@ -433,6 +433,8 @@ static int ov965x_read(struct ov965x *ov965x, u8 addr=
, u8 *val)
>         ret =3D regmap_read(ov965x->regmap, addr, &buf);
>         if (!ret)
>                 *val =3D buf;
> +        else
> +                *val =3D -1;
>
>         v4l2_dbg(2, debug, &ov965x->sd, "%s: 0x%02x @ 0x%02x. (%d)\n",
>                  __func__, *val, addr, ret);
> --
> 2.18.0
>
