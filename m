Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70542C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBFA2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+iDvewp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfASMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:41:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34980 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfASMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:41:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so9621864qka.2;
        Sat, 19 Jan 2019 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/uirWgwK8ZsYuq5sa25pACmo5AdHQzx9AC4knaBHxjA=;
        b=Q+iDvewpONpG4yAscot8519+fdhk/9LeVCfmANBKayAyD5N+dAJbbTkomUSKJ5C8iE
         dElmJCHP4FglP9LagzLUYGrzZEE9EjmpbuCKl69qAdzDWdAf/B6nev/XLWnixjUwnR+F
         n3FNgs18adeof9r4TXkbUMWiiXe2heaaPs9KMJGzoQ7wCQo/ilbHbxgXzEd1T+EGCvVI
         JO3tv5hbArLlXS2LMsn6oXgpW8yPR7ZKxpqXKvivm19lbB/LONx+/TMeGiTm030GQzSj
         XqojXGkLydv8pCwlHflcNNUehJ1sYvwTNCb3kgDemh6njLcawNVJk6XozQ7pKFFyBvTF
         xeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/uirWgwK8ZsYuq5sa25pACmo5AdHQzx9AC4knaBHxjA=;
        b=HHQhWTCSv3MSHS13E6vDSLxByO3a6zuajOFXG5C0sdgmV/H3664UN82fawyBhoxiVy
         zrxpOqXbpLYOx3N/2PIEOqoWTzbYi4gGJ6R43QfPe1qhPXiUCSrLZ4aICrrdft84IbHl
         E1egeDmDhal9ZNFItjH1qaov5Hadc6DOJSlGy6Wtg4N+/l62IxiOE8vsCyf7fdHAsJEh
         JmyGoO3h+GuGLso+A1D2eXhNYeWqcQRYl+X8+jhhuIejON3djev8cDTlIsbRYFoe8olR
         7aI3yWH4M9JeHtGmgYx8Q/lUESJvpsqK8TgVMUgb9tKCv98ZN60slzMdgPGnIFEqt/BJ
         eU/w==
X-Gm-Message-State: AJcUukd5q3Qb6i2yC5xoXf7yFCZK3AxIb2YkyuuZM6so+jN2YZyVPwf4
        vAGRPFtfIvyr4abMnnw0TndcbVqTECCROZdCrYI=
X-Google-Smtp-Source: ALg8bN6VHvrZJqzGPCIOG1jDRcV4aZdX0RcWo2FzftcmY27K1xXEgKmWUTP2xrTNwoxrV+sXn/OgaVoTO0dgFGC0X+Q=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr18453415qki.197.1547901713589;
 Sat, 19 Jan 2019 04:41:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c@eucas1p1.samsung.com>
 <20190118131639.17578-1-k.konieczny@partner.samsung.com> <20190118131639.17578-6-k.konieczny@partner.samsung.com>
In-Reply-To: <20190118131639.17578-6-k.konieczny@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 19 Jan 2019 21:41:17 +0900
Message-ID: <CAGTfZH2sKvJ+Tq=YD2Xb1ZDV9QD0C3gEVRvxzMvRj54pU+2vHA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] clk: samsung: exynos5433: add imem clocks
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamil,

2019=EB=85=84 1=EC=9B=94 18=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:18, =
Kamil Konieczny
<k.konieczny@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Add imem clocks for exynos5433. This will enable to use crypto Slim
> Security SubSystem (in short SlimSSS) IP block.
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/c=
lk-exynos5433.c
> index 24c3360db65b..dae1c96de933 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -5467,6 +5467,35 @@ static const struct samsung_cmu_info cam1_cmu_info=
 __initconst =3D {
>         .clk_name               =3D "aclk_cam1_400",
>  };
>
> +/*
> + * Register offset definitions for CMU_IMEM
> + */
> +#define ENABLE_ACLK_IMEM_SLIMSSS               0x080c
> +#define ENABLE_PCLK_IMEM_SLIMSSS               0x0908
> +
> +static const unsigned long imem_clk_regs[] __initconst =3D {
> +       ENABLE_ACLK_IMEM_SLIMSSS,
> +       ENABLE_PCLK_IMEM_SLIMSSS,
> +};
> +
> +static const struct samsung_gate_clock imem_gate_clks[] __initconst =3D =
{
> +       /* ENABLE_ACLK_IMEM_SLIMSSS */
> +       GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
> +                       ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0=
),
> +
> +       /* ENABLE_PCLK_IMEM_SLIMSSS */
> +       GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
> +                       ENABLE_PCLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0=
),
> +};
> +
> +static const struct samsung_cmu_info imem_cmu_info __initconst =3D {
> +       .gate_clks              =3D imem_gate_clks,
> +       .nr_gate_clks           =3D ARRAY_SIZE(imem_gate_clks),
> +       .nr_clk_ids             =3D IMEM_NR_CLK,
> +       .clk_regs               =3D imem_clk_regs,
> +       .nr_clk_regs            =3D ARRAY_SIZE(imem_clk_regs),
> +       .clk_name               =3D "aclk_imem_200",
> +};
>
>  struct exynos5433_cmu_data {
>         struct samsung_clk_reg_dump *clk_save;
> @@ -5654,6 +5683,9 @@ static const struct of_device_id exynos5433_cmu_of_=
match[] =3D {
>         }, {
>                 .compatible =3D "samsung,exynos5433-cmu-mscl",
>                 .data =3D &mscl_cmu_info,
> +       }, {
> +               .compatible =3D "samsung,exynos5433-cmu-imem",
> +               .data =3D &imem_cmu_info,
>         }, {
>         },
>  };
> --
> 2.20.0
>

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
