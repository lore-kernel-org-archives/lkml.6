Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF017C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D2120B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j8pLf+bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfBAIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:07:20 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52377 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfBAIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:07:20 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190201080716epoutp01bb73759bf955ee8bb087d6f33431007a~-Lvc7oe2I1820618206epoutp01v
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 08:07:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190201080716epoutp01bb73759bf955ee8bb087d6f33431007a~-Lvc7oe2I1820618206epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549008436;
        bh=pyxBMs6MTuw3kCIeU6zbfvPs53Vj/qIIz8fzrJrQVXA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=j8pLf+bjmiAhGLW0QQbdXVO2w14vjw7jPL7u9bVZNa1aDHUYWx07KqhxdoxrMa0IZ
         7DXpbtIqgaoT/OPXO+954tCaQSEQX31p5tvFPC9aUQHsD417yzO4r2OgUykNhg7SbZ
         8QTMNbjgY3H5p86ytiN4lWal2GGJpiN7qbMCHWpw=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190201080710epcas1p4901eaa8db027d56a8e2863170988293c~-LvXvy-ym1919719197epcas1p4h;
        Fri,  1 Feb 2019 08:07:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.63.04069.E2EF35C5; Fri,  1 Feb 2019 17:07:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201080709epcas1p13fb55c34af5e55eaa7bc0f48829bf97f~-LvXBX_y23104831048epcas1p1-;
        Fri,  1 Feb 2019 08:07:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201080709epsmtrp24f22cb47e75e1e153bf47c077990f500~-LvW-D5ND0749607496epsmtrp2S;
        Fri,  1 Feb 2019 08:07:09 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-0f-5c53fe2e3240
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.7A.03601.D2EF35C5; Fri,  1 Feb 2019 17:07:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201080709epsmtip1c9a25b67372f8f96ff2490e2e6795678~-LvWu12v52764827648epsmtip1J;
        Fri,  1 Feb 2019 08:07:09 +0000 (GMT)
Subject: Re: [PATCH v3 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <768b4147-35fb-64ad-5da8-6b348e962c70@samsung.com>
Date:   Fri, 1 Feb 2019 17:07:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmga7ev+AYg56ZahYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0+9txjtbi8aw6bxefeI4wWM87vY7JYe+Quu8XF
        U64WtxtXsFkcftPOavHv2kYWBwGP9zda2T02repk89i8pN7j4Ls9TB59W1YxenzeJBfAFpVt
        k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tZJCWWJO
        KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2Pf
        khb2gil2Fa+XHWJuYOw16WLk5JAQMJF4s3g5WxcjF4eQwA5GiRUvLjFCOJ8YJVYta2WCcL4x
        SuzfcYMRpuXziacsEIm9jBIH1r6EqnrPKPHxcgcTSJWwQKhEf/8cdpCEiMByRol9U++CDWYW
        2MsksehGD9gsNgEtif0vbrCB2PwCihJXfzwGi/MK2El8f72XHcRmEVCR6Nu8CCwuKhAhcbj3
        HVSNoMTJmU9YQGxOAW+Jh0d2gcWZBcQlbj2ZzwRhy0s0b53NDLJYQmAfu8SEhYeYIZ5wkWjd
        vJwFwhaWeHV8CzuELSXx+d1eNgi7WmLlySNsEM0djBJb9l9ghUgYS+xfOhloAwfQBk2J9bv0
        IZbxSbz72sMKEpYQ4JXoaBOCqFaWuPzgLhOELSmxuL0TaryHxIZnW5knMCrOQvLOLCQvzELy
        wiyEZQsYWVYxiqUWFOempxYbFhgjR/gmRnCi1jLfwbjhnM8hRgEORiUe3g2/gmKEWBPLiitz
        DzFKcDArifBm/QqOEeJNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wCySVxJvaGpkbGxsYWJo
        ZmpoqCTOu97BOUZIID2xJDU7NbUgtQimj4mDU6qBMfzFm40LMk8ee+ub8TNuaq9q/MIfu38U
        SBjbbw4s+ef6cLft863sJxdNvf/BZ3bZ+msKXQe2+4pnT8tVXtYdLVn8+4xccLPpvg2Pv56Y
        9CM7fmnc5v1qy3bJbRCf0uQrfXry2YIMueRNjvNS/Q8X++ybPYuxQkuyJc/ZrMPqJqeX0dL5
        TgfabymxFGckGmoxFxUnAgB7rxBw6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnK7uv+AYgz+rDCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVp87LnHanF51xw2i8+9RxgtZpzfx2Sx9shddouL
        p1wtbjeuYLM4/Kad1eLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
        JiU1J7MstUjfLoErY9+SFvaCKXYVr5cdYm5g7DXpYuTkkBAwkfh84ilLFyMXh5DAbkaJLV0r
        WSESkhLTLh5l7mLkALKFJQ4fLoaoecsosX/FD7AaYYFQif7+OewgCRGB5YwSc/8uBZvELLCX
        SWJCz2VWiJb7jBKHvk1hBGlhE9CS2P/iBhuIzS+gKHH1x2OwOK+AncT313vZQWwWARWJvs2L
        wOKiAhESH5/uY4KoEZQ4OfMJC4jNKeAt8fDILrAaZgF1iT/zLjFD2OISt57MZ4Kw5SWat85m
        nsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwxGpp
        7WA8cSL+EKMAB6MSD++GX0ExQqyJZcWVuYcYJTiYlUR4s34FxwjxpiRWVqUW5ccXleakFh9i
        lOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpgNGEQOKrZ7XXFXn3GZJZLUwUPvPu4f2n7
        jPLVR78VGn/QfXMv/9js4sMBusfm37/L8/XUwvp2jaBoc1ZJ/2mf04J8WB25uHkdrvZvPPU/
        L0j12eyG7S9z9iyJvLf8wF6/tTsnPjn5TkJuU0qd2mfxltoXnB85rhpXPgo42mshfqfpyruT
        HO4/HiixFGckGmoxFxUnAgDuebTQ1AIAAA==
X-CMS-MailID: 20190201080709epcas1p13fb55c34af5e55eaa7bc0f48829bf97f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p1ca478545c107086d427909c88d3b232e@eucas1p1.samsung.com>
        <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I reviewed this patch, the almost changes are wrong.
Frankly, I can't believe that you had tested and verified it
on real board. Please check my comments.
If I misunderstood, please let me know.

On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-clk@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 48 +++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c..3e87421 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -132,6 +132,8 @@
>  #define BPLL_LOCK		0x20010
>  #define BPLL_CON0		0x20110
>  #define SRC_CDREX		0x20200
> +#define GATE_BUS_CDREX0		0x20700
> +#define GATE_BUS_CDREX1		0x20704
>  #define DIV_CDREX0		0x20500
>  #define DIV_CDREX1		0x20504
>  #define KPLL_LOCK		0x28000
> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>  	DIV_CDREX1,
>  	SRC_KFC,
>  	DIV_KFC0,
> +	GATE_BUS_CDREX0,
> +	GATE_BUS_CDREX1,
>  };
>  
>  static const unsigned long exynos5800_clk_regs[] __initconst = {
> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>  PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>  PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_dpll_ctrl",
> +					"mout_mpll_ctrl", "ff_dout_spll2",
> +					"mout_sclk_spll"};

- mout_dpll_ctrl was not defined. This patch doesn't define it.
- mout_mpll_ctrl was not defined. ditto.
- ff_dout_spll2 was only registered when SOC is EXYNOS5800.
  It meant that ff_dout_spll2 was not registered on exynos5422 board.

It is wrong patch. You would have not checked the parent clocks
except for sclk_bpll.

Also,
In the exynos5422 datasheet, MUX_MX_MSPLL_CCORE_PHY_SEL is possible
having the six parents as following:
- sclk_bpll
- sclk_dpll
- sclk_mpll
- sclk_spll2
- sclk_spll
- sclk_epll

Why do you missing last 'sclk_epll'?


> +
>  
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>  		exynos5800_fixed_factor_clks[] __initconst = {
>  	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),

It doesn't affect the Exynos5422 because exynos5800_fixed_factor_clks[]
is registered when SOC is EXYNOS5800. Exynos5422 board cannot use this clock.

>  };
>  
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>  	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>  
> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +

Why do you modify the exynos5800_mux_clks instead of exynos5420_mux_clks
or exynos5x_mux_clks? In the coverletter this patch is for Exynos5422 board.
Did you test it?

>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),

ditto.

>  	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>  			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),

ditto.

>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>  
>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>  	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>  	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
> @@ -814,9 +825,13 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  			DIV_CDREX0, 16, 3),
>  	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
>  			DIV_CDREX0, 8, 3),
> +	DIV(0, "dout_cclk_drex1", "dout_clk2x_phy0", DIV_CDREX0, 8, 3),

Hmm. CLK_DIV_CDREX0[10:8] of DIV_CDREX0 register was already implemented
by CLK_DOUT_CCLK_DREX0. It is fault.

Also, PCLK_CORE_MEM_RATIO[10:8] of DIV_CDREX1 register was defined as following
in clock-exynos5420.c.
- DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex", DIV_CDREX1, 8, 3), 


>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>  			DIV_CDREX0, 3, 5),
>  
> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
> +	DIV(0, "dout_pclk_drex1", "dout_cclk_drex1", DIV_CDREX0, 28, 3),

dout_cclk_drex1 is wrong. It is fault.

> +
>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>  			DIV_CDREX1, 8, 3),
>  
> @@ -1170,6 +1185,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>  			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>  
>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
> +
> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 0, 0, 0),
> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 1, 0, 0),
> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>  };
>  
>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
