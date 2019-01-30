Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D595C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="w9+34h0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfA3JOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:14:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55079 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfA3JOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:14:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so20797234wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Luu+Ig06NuejecYK/kbFfwad08hacL7qfXGarypLpIY=;
        b=w9+34h0lUh9hdZODM8LRm2TxyEWeQCz2ZePMNSbhGM3HOCDD5kc43Vbw9xDx5ZW69k
         rmziZIK30lSmerEXDFMX+RcjTZsi1s7w0ZzJ0DltfY9Vn8IV2NFwiIerRp6cGLbWoEQv
         PqWTzNpEArnFBX/o81qJ6gv/O0iP+6VnEuT8uAl3cDxgdTHWq7Q0THKRhc2e+zh1YOI1
         Kyyag4oWxLG5DBb6gfOafYJfaHop4Whl0YPzxR5yk/emsORB+kwrphosGWDbWbySVWqg
         wcvGhDNnpA0VBLS4dQO9P8aOnLdkkyVfW4H2oiExriwNej9XYd/mHvF+PbfysYZydUMK
         GnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Luu+Ig06NuejecYK/kbFfwad08hacL7qfXGarypLpIY=;
        b=O7SvzwsmB9hVR9psPGZOOmNrOGhYKvPThiGMB4cybuaOaQkZA7MvzfLO0WDKhle/yR
         E/U6EOIA+EbgCrbEypGMHmdhnPxd6ZiN/DBKJbP9xyEIloGbbFLVC91TfHe527rgNNt3
         kXpohH236p1RljYZMUCas2ZTE7Z9psS1c0gPS1pFdtg1waOuJpvP84fhsFsPzbrUFuS3
         JrotwJUCY3B/8vJcgdtsYECdOzM3HVjFbSLgp1O3BBkAtDBIvQ4CCqgii7Sj4q0k+vJR
         rCzGVzdhWVyn23Iwd8XSyJ5a1t4Ve5X8E67SHBsWUrpjik7J8rlUgvTLfWBJ/dCrtfhG
         toaA==
X-Gm-Message-State: AJcUukfgBnf7sS0ALA1pHmebYS/i9lpmasQmmA31s62VCvsTM1ONrjfa
        KklvRFg1V55PbiIHXy58W7gJsEmkmSEjfqFXCrgVww==
X-Google-Smtp-Source: ALg8bN7QPo8dxLHR73DVUzy51xQfYrpj/kXCe1vNM/6WxEgXkQI5ppyyeJZhPoS5cIMFLlC7nEcUkviuwc6HAKAE5Ds=
X-Received: by 2002:a1c:5984:: with SMTP id n126mr23660405wmb.62.1548839655845;
 Wed, 30 Jan 2019 01:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20190130090722.24134-1-axel.lin@ingics.com> <20190130090722.24134-2-axel.lin@ingics.com>
 <CAMpxmJX9pSJ1L9NoyKY7wMGm2FCuC5KWxCZcfnTF_dGwdD9+AQ@mail.gmail.com>
In-Reply-To: <CAMpxmJX9pSJ1L9NoyKY7wMGm2FCuC5KWxCZcfnTF_dGwdD9+AQ@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 30 Jan 2019 17:14:04 +0800
Message-ID: <CAFRkauCsJdK43YttVNexcVRozKGxJ-4YLjwTWjxxkA=C5f_SAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: max77650: Convert to use regulator_enable/disable/is_enabled_regmap
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> =E6=96=BC 2019=E5=B9=B41=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:12=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> =C5=9Br., 30 sty 2019 o 10:07 Axel Lin <axel.lin@ingics.com> napisa=C5=82=
(a):
> >
> > By setting enable_reg, enable_mask, enable_val and disable_val, we can
> > use the regulator_enable/disable/is_enabled_regmap helpers. With this
> > change, then regB field can be removed from struct max77650_regulator_d=
esc.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > Hi Bartosz,
> > I don't have this h/w, please help to review and test it.
> >
> > I think the only difference is the is_enabled checking:
> > Before the patch, it returns en !=3D MAX77650_REGULATOR_DISABLED;
> > After the patch, it returns en =3D=3D MAX77650_REGULATOR_ENABLED
> > I'm not sure if this difference does matter or not.
> >
>
> NACK. I intend to support the FPS feature of the regulator module in
> the future (see a similar thing in max77620) and I will need to extend
> these callbacks as there will be more possible values here. Regmap
> generics will not be enough.
Got it, thanks for the quick review.
