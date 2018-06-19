Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4ACC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBAF2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y/FUWbBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBAF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967094AbeFSRDT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:03:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36890 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966775AbeFSRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:03:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so176563plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=dQqPsypTD9rYzVNKYLlxcGBZypOJyVwz4mfiPeKAZ9w=;
        b=Y/FUWbBYe47RmwEoZLTNUvEdBwVBAwsCwMGHLTa4BKLeTrJi9IgY/f7h9GCBwYMMbw
         62VM0O7ldevZe9HGWcv8vtLOtGWkq9ncSQwMDoJ5zqALGQmQ4hckcsH8gLarmDX+mdws
         1pzivauprU3LQF+0NeKG6Zv6KpPfUZM6qWguWMMXhGzulMjUulyXZzy08i4APSLFdnc2
         t0Vmz8X+7Qt9HNzt8DCath302DI1zZLroyxamGpdBsTJz7VYbtSoUXE4vuJYbsEBHlYk
         X5tsSEOzXZUKGcOps8pBy4plb71SXKRtMUQ2l7rBBlJpkCK7xVAqVsYSUNhQSKA1+5sT
         +NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=dQqPsypTD9rYzVNKYLlxcGBZypOJyVwz4mfiPeKAZ9w=;
        b=elRoIqJFBGuLQmhd1gBrkJHQ04RJKfzaamVDjmLWUvETjvVgicwDWG8KShYWak2VKC
         abDmdAmAhJeZumJy4WBsU8jje+Z1kQXH6K3ScNUnqG0X4CxUZEGDheV5IOnkpfifZo2k
         LV7+Xy0NXbQBrIm4nKqthSeGLr4/mZG4yIZf2ENdyrMmlK1C1J3qPsBitDqO5Listt9J
         Wn7mbwgOCZLv+ojByT1zJDR911sfFiT0/J53l7QPafhnwnOkM2YRJdWBspK91/0fjOKr
         pqQjQLw29NqrSid1vqxSn3zl2XxftMNIpWVN/dug6mh9L/uJ9uFcD+hKXQG6JavvHywd
         NLAQ==
X-Gm-Message-State: APt69E1l2NZGoLSnw94jLONTB8wW/dxep2dw1Dj2G0mM6Vgr2AoN2OnJ
        oOiunqiYu/HkzFlZDn6re3fr6Q==
X-Google-Smtp-Source: ADUXVKJyXGaMx0YUhVzy7SkJXSuXghemoVJGjOzH9l/cNGzEXouxQ4yTZWyfjt8vlfnOTO5YJr/xGA==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr19332970pll.243.1529427795958;
        Tue, 19 Jun 2018 10:03:15 -0700 (PDT)
Received: from localhost ([2605:e000:151d:96f:170:3319:9294:4203])
        by smtp.gmail.com with ESMTPSA id w11-v6sm194523pfn.71.2018.06.19.10.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:03:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20180619134051.16726-2-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20180619134051.16726-1-jbrunet@baylibre.com>
 <20180619134051.16726-2-jbrunet@baylibre.com>
Message-ID: <20180619170307.33232.70445@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: qcom: drop CLK_SET_RATE_GATE from sdc clocks
Date:   Tue, 19 Jun 2018 10:03:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-06-19 06:40:50)
> the mmci driver (drivers/mmc/host/mmci.c) does the following sequence:
> * clk_prepare_enable()
> * clk_set_rate()
> =

> on SDCx_clk which is a children of SDCx_src. SDCx_src has
> CLK_SET_RATE_GATE so this sequence should not be allowed but this was not
> enforced. IOW, the flag is ignored. Dropping the flag won't change
> anything to the current behaviour of the platform.
> =

> CLK_SET_RATE_GATE is being fixed and enforced now. If the flag was kept,
> the mmci driver would receive -EBUSY when calling clk_set_rate()
> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to clk-qcom-set-rate-gate.

Thanks,
Mike

> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 3 ---
>  drivers/clk/qcom/gcc-mdm9615.c | 2 --
>  drivers/clk/qcom/gcc-msm8660.c | 5 -----
>  drivers/clk/qcom/gcc-msm8960.c | 5 -----
>  4 files changed, 15 deletions(-)
> =

> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806=
x.c
> index 28eb200d0f1e..5f61225657ab 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -1220,7 +1220,6 @@ static struct clk_rcg sdc1_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1269,7 +1268,6 @@ static struct clk_rcg sdc3_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1353,7 +1351,6 @@ static struct clk_rcg tsif_ref_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm961=
5.c
> index b99dd406e907..849046fbed6d 100644
> --- a/drivers/clk/qcom/gcc-mdm9615.c
> +++ b/drivers/clk/qcom/gcc-mdm9615.c
> @@ -947,7 +947,6 @@ static struct clk_rcg sdc1_src =3D {
>                         .parent_names =3D gcc_cxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -996,7 +995,6 @@ static struct clk_rcg sdc2_src =3D {
>                         .parent_names =3D gcc_cxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm866=
0.c
> index c347a0d44bc8..7e930e25c79f 100644
> --- a/drivers/clk/qcom/gcc-msm8660.c
> +++ b/drivers/clk/qcom/gcc-msm8660.c
> @@ -1558,7 +1558,6 @@ static struct clk_rcg sdc1_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1607,7 +1606,6 @@ static struct clk_rcg sdc2_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1656,7 +1654,6 @@ static struct clk_rcg sdc3_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1705,7 +1702,6 @@ static struct clk_rcg sdc4_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1754,7 +1750,6 @@ static struct clk_rcg sdc5_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm896=
0.c
> index eb551c75fba6..fd495e0471bb 100644
> --- a/drivers/clk/qcom/gcc-msm8960.c
> +++ b/drivers/clk/qcom/gcc-msm8960.c
> @@ -1628,7 +1628,6 @@ static struct clk_rcg sdc1_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1677,7 +1676,6 @@ static struct clk_rcg sdc2_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1726,7 +1724,6 @@ static struct clk_rcg sdc3_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1775,7 +1772,6 @@ static struct clk_rcg sdc4_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> @@ -1824,7 +1820,6 @@ static struct clk_rcg sdc5_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_RATE_GATE,
>                 },
>         }
>  };
> -- =

> 2.14.3
>=20
