Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6413C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16AF21773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG/i9Xf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBCJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:57:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47010 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfBCJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:57:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so6685260qkf.13;
        Sun, 03 Feb 2019 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n1c9OJTe6zWlJvBQIDRnU7417Ms3c1tOhAyJGln3ZVc=;
        b=mG/i9Xf+ZbB0z+Nd897P9ezq5im7d4gTJLL2YgForIKkOedyiMPPoW4q3MoueetwBw
         ZZX+vD9nO11K77eYTGxSFORZofvkuAi/tQK868oLfVDM13doEc1rk135ugCJWeicNtLC
         0TJB84rHy91vAxRT7Iv9I/Oi/BDx7mF3AzZKqdbiG7cq8xyEhGSgvpJrRz4dUrEd2hTT
         bZwKm6GVdP8BG/x3fUKmy9uMHZtlYE5deestG+KY/+OWhqixmpNYXA0j+WnuggdCWPdN
         v2bwdSrXzZcsmU5OkfdbPxY3p3aZGsiwkz4t+A1GdoD8u8hXZPqplH1ia0ZXhJ29Zj30
         MyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n1c9OJTe6zWlJvBQIDRnU7417Ms3c1tOhAyJGln3ZVc=;
        b=n7dbM/Ie9WyV95fW3Ut6nT5Iqb12UhmWBWkTeV8poGpTBeZfK9iCjoY4lsGmfH9Zk2
         Kb37v4WVvR6x4oPVD2Qt2QikcbNbesKf8oqDnWmw6x/S/FRKRkpl4bez/3W7LenTI41i
         86KVs3egI1/IKXmPXLgAwrkr8WRxiHd4WXZya9FjYg9yWr6wMa71aZydzmQcE/nJchxl
         F7VYpj+vSLIuO+AYDsv5wLImaUhTB1M2b4c8h804b5a6WwvSy7gRuulvtW+WF/9eaUuM
         F9ktXTqvqJ5wHXZspZ5mfYKom59W+zIiSsH/tN10PkZYlNhf2K41kDy5I92iyef/Mg92
         bnjA==
X-Gm-Message-State: AJcUukdCwf+l0LesVWk8NZtyDTcGPs6WsQ8Pam0q10jFFHoNS3axi9W4
        Q7UbdefCdE4xhn+PwrsKr4DbFvchJMBXnkKk7V9Ci2pTQTPFpA==
X-Google-Smtp-Source: ALg8bN6SkPAV6hmn1iBYqFMK7WxbwfjERXo04c9y3pvgRPVKKr7x4ntKy9P9jvIeEpBD6bHXkD7cNTpQBjEHOUJGTrc=
X-Received: by 2002:a37:6bc1:: with SMTP id g184mr42295937qkc.236.1549187844939;
 Sun, 03 Feb 2019 01:57:24 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267@eucas1p2.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-3-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-3-git-send-email-l.luba@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 3 Feb 2019 18:56:48 +0900
Message-ID: <CAGTfZH0VOSCfp8u416S45Tv9BgNcr_O_i88x6aY68Q7a7+=o4Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I recommend that please don't send the version up patchset before
finishing the discussion.

2019=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:47, Lu=
kasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> This patch provides support for clocks needed for Dynamic Memory Controll=
er
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX an=
d
> GATE entries.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++=
++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/c=
lk-exynos5420.c
> index 34cce3c..f1a4f56 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -132,6 +132,8 @@
>  #define BPLL_LOCK              0x20010
>  #define BPLL_CON0              0x20110
>  #define SRC_CDREX              0x20200
> +#define GATE_BUS_CDREX0                0x20700
> +#define GATE_BUS_CDREX1                0x20704
>  #define DIV_CDREX0             0x20500
>  #define DIV_CDREX1             0x20504
>  #define KPLL_LOCK              0x28000
> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __init=
const =3D {
>         DIV_CDREX1,
>         SRC_KFC,
>         DIV_KFC0,
> +       GATE_BUS_CDREX0,
> +       GATE_BUS_CDREX1,
>  };
>
>  static const unsigned long exynos5800_clk_regs[] __initconst =3D {
> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p) =3D { "dout_osc_div", "mo=
ut_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)     =3D { "dout_aclk550_cam", "dout_sclk_sw" =
};
>  PNAME(mout_group15_5800_p)     =3D { "dout_osc_div", "mout_sw_aclk550_ca=
m" };
>  PNAME(mout_group16_5800_p)     =3D { "dout_osc_div", "mout_mau_epll_clk"=
 };
> +PNAME(mout_mx_mspll_ccore_phy_p) =3D { "sclk_bpll", "mout_sclk_dpll",
> +                                       "mout_sclk_mpll", "ff_dout_spll2"=
,
> +                                       "mout_sclk_spll", "mout_sclk_epll=
"};
> +

Remove unneeded extra blank line.

>
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>                 exynos5800_fixed_factor_clks[] __initconst =3D {
>         FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -       FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +       FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, =
2, 0),
>  };
>
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst =
=3D {
> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mu=
x_clks[] __initconst =3D {
>         MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2)=
,
>         MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>
> +       MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +               mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +
>         MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>         MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5=
800_p,
>                         SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -       MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +       MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>         MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>
>         MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_cl=
ks[] __initconst =3D {

The newly added clocks by this patch are supported on all Exynos5420/5422/5=
800?
I'm not sure because on the patch description, you only mentioned the
Exynos5422 without Exynos5420/Exynos5800.

As for now, I can't check the Exynos TRM because I'm in holiday until
next Wednesday. I will check them with Exynos542-/5422/5800 TRM on
next Thursday.

>
>         MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>         MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1)=
,
> -       MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +       MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, =
8, 1),
>         MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>         MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>         MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20,=
 1,
> @@ -817,6 +828,8 @@ static const struct samsung_div_clock exynos5x_div_cl=
ks[] __initconst =3D {
>         DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>                         DIV_CDREX0, 3, 5),
>
> +       DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),

Before applied this patch, on line 809, DIV_CDREX0[28:30] was already
defined with "dout_pclk_cdrex" gate clock name. Why do you redefine it
with same register/same bit with the different clock name? The clock
driver have to get only unique clock for the same register/same bit
information.

   808         /* CDREX Block */
   809         DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex",
"dout_aclk_cdrex1",
   810                         DIV_CDREX0, 28, 3),

And also, you don't use "dout_pclk_drex0" defined by you for
CLK_ACLK_PPMU_DREX* gate clock on below. Instead, you use the already
defined 'dout_pclk_cdrex' as I commented.

> +
>         DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdre=
x",
>                         DIV_CDREX1, 8, 3),
>
> @@ -1170,6 +1183,31 @@ static const struct samsung_gate_clock exynos5x_ga=
te_clks[] __initconst =3D {
>                         GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>
>         GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
> +

Add the following comment for the readability in order to sustain the
consistency of this driver.
/* CDREX Block */ or /* CDREX */

> +       GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
> +                       GATE_BUS_CDREX0, 0, 0, 0),
> +       GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
> +                       GATE_BUS_CDREX0, 1, 0, 0),
> +       GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
> +                       SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
> +
> +       GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex=
1",
> +                       GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex=
1",
> +                       GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex=
1",
> +                       GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex=
1",
> +                       GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),

You better to move the gate clock of GATE_BUS_CDREX[15:12] under the
gate clock of GATE_BUS_CDREX[29:26]
for the decending order because you defined them as the decending order.

> +
> +       GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex=
",
> +                       GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex=
",
> +                       GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex=
",
> +                       GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex=
",
> +                       GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>  };
>
>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initcon=
st =3D {
> --
> 2.7.4
>


--
Best Regards,
Chanwoo Choi
