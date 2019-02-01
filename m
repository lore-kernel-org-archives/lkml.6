Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D354C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E9920844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qeDFSGxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfBAJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:20:13 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:61208 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBAJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:20:12 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190201092009epoutp03027a34165294e8557dbe45064b1eb6d9~-MvFZITWQ0397003970epoutp034
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 09:20:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190201092009epoutp03027a34165294e8557dbe45064b1eb6d9~-MvFZITWQ0397003970epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549012809;
        bh=blPhCnUzVkLRtmJFYhgqYhcY/Fr5kOrc9kePmaT3ukk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qeDFSGxF94Ivf0144SLgvgIMVUIH0UKdaVfQK2XQkNxXdB89bU1WBq937vBtHx22h
         79+1/sNOIUecCArERKeOfVCd6B7x39E6Kma4x4y1VkZFhxg6ZZEDMMtrRlD+tJd+GT
         5a10l2gIV71yxYI3N/kswH8bduaCsYuFtHyFKm5Q=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201092006epcas1p2e326886497d3a1bdeddd1dade5e5fc22~-MvC7PWFy2279522795epcas1p29;
        Fri,  1 Feb 2019 09:20:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.D1.04173.64F045C5; Fri,  1 Feb 2019 18:20:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190201092005epcas1p334bea58f17811cdf2ce92e1f2497e9a0~-MvCXQ0Dd3120631206epcas1p3m;
        Fri,  1 Feb 2019 09:20:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201092005epsmtrp2f1905066fb0eeec93976c4740c849152~-MvCVWbGr0107901079epsmtrp2l;
        Fri,  1 Feb 2019 09:20:05 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-bc-5c540f4677ce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.4E.03971.54F045C5; Fri,  1 Feb 2019 18:20:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201092005epsmtip145ea1e931af7753c80ab7be163051e36~-MvCANYFY1963919639epsmtip1I;
        Fri,  1 Feb 2019 09:20:05 +0000 (GMT)
Subject: Re: [PATCH v3 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Organization: Samsung Electronics
Message-ID: <45e61b41-3be1-2090-6ab0-4d1743d0913c@samsung.com>
Date:   Fri, 1 Feb 2019 18:20:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <768b4147-35fb-64ad-5da8-6b348e962c70@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmnq4bf0iMwYZrQhYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0+9txjtbi8aw6bxefeI4wWM87vY7JYe+Quu8XF
        U64WtxtXsFkcftPOavHv2kYWBwGP9zda2T02repk89i8pN7j4Ls9TB59W1YxenzeJBfAFpVt
        k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tZJCWWJO
        KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PO
        0xesBSecKn5tusXawLjNvIuRk0NCwETiV38vUxcjF4eQwA5GiZVfvzBCOJ8YJfpnnGOBcL4x
        Shzb+JQJpuXpjNtsEIm9jBKXP7xgBUkICbxnlNiwMhnEFhYIlejvn8MOYrMJaEnsf3EDrEFE
        YDmjxL6pd8F2MAvsZZJYdKOHEaSKX0BR4uqPx2A2r4CdxIZbb9hAbBYBFYkH04+xgNiiAhES
        h3vfQdUISpyc+QQszilgL/HvzRUwm1lAXOLWk/lMELa8RPPW2cwQZ+9il9hxIxTCdpE4fe0i
        O4QtLPHq+BYoW0ri87u9bBB2tcTKk0fArpYQ6GCU2LL/AitEwlhi/9LJQAs4gBZoSqzfpQ+x
        i0/i3dceVpCwhACvREebEES1ssTlB3ehIScpsbi9E2q8h8SGZ1uZJzAqzkLyzSwkH8xC8sEs
        hGULGFlWMYqlFhTnpqcWGxYYIUf3JkZwktYy28G46JzPIUYBDkYlHt4Nv4JihFgTy4orcw8x
        SnAwK4nwzmYJiRHiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cAMklcSb2hqZGxsbGFiaGZq
        aKgkzrvewTlGSCA9sSQ1OzW1ILUIpo+Jg1OqgXGGgdRp8U3C6q7SL/asPqj6kiMhTsDe7r36
        dq63rW0/7aYtX/jtsOFGpwkCi1nynpw/qP6o+BDTRn4r7yVnny3UTDv0oPDRgUOTnA5wMkqU
        xjhfPf4qInpC3sXu1nIDvim5PoGXzuUrSLAoGB4p0+ariRZ9++xowK8N2TpW9UvDZ1wx7b2w
        NlGJpTgj0VCLuag4EQAo7fkk6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnK4rf0iMwetl6hYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0+9txjtbi8aw6bxefeI4wWM87vY7JYe+Quu8XF
        U64WtxtXsFkcftPOavHv2kYWBwGP9zda2T02repk89i8pN7j4Ls9TB59W1YxenzeJBfAFsVl
        k5Kak1mWWqRvl8CVcefpC9aCE04VvzbdYm1g3GbexcjJISFgIvF0xm22LkYuDiGB3YwSx3Zc
        YYdISEpMu3iUuYuRA8gWljh8uBii5i2jxL+5O1lAaoQFQiX6++eA1bMJaEnsf3EDbJCIwHJG
        ibl/l7KAOMwCe5kkJvRcZoVon8IksfzPCyaQFn4BRYmrPx4zgti8AnYSG269YQOxWQRUJB5M
        Pwa2QlQgQuLj031MEDWCEidnPgGLcwrYS/x7cwXMZhZQl/gz7xIzhC0ucevJfCYIW16ieets
        5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER6yW
        5g7Gy0viDzEKcDAq8fBu+BUUI8SaWFZcmXuIUYKDWUmEdzZLSIwQb0piZVVqUX58UWlOavEh
        RmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjHLffD827f6XrB7AUVKstWgZw2adbYvc
        cxfHrivoC1ea5jH5c+j/YIPpkzdHb/tR9aDvMeOf/ZXW+VZbLeJ9Q1NPCgavEqjwtut4UtT3
        pEr7wL2tLV0WG94qWi/YfI31Xf3SQtHHvZLTCm0s35zUe8C45lNTyWXfXfxKH7PcWtNub99m
        k7+1WImlOCPRUIu5qDgRAFZW7NvUAgAA
X-CMS-MailID: 20190201092005epcas1p334bea58f17811cdf2ce92e1f2497e9a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p1ca478545c107086d427909c88d3b232e@eucas1p1.samsung.com>
        <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
        <768b4147-35fb-64ad-5da8-6b348e962c70@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are some wrong comments by me. Sorry for confusion.

On 19. 2. 1. 오후 5:07, Chanwoo Choi wrote:
> Hi,
> 
> When I reviewed this patch, the almost changes are wrong.
> Frankly, I can't believe that you had tested and verified it
> on real board. Please check my comments.
> If I misunderstood, please let me know.
> 
> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Michael Turquette <mturquette@baylibre.com>
>> CC: Stephen Boyd <sboyd@kernel.org>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: linux-clk@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c | 48 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c..3e87421 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -132,6 +132,8 @@
>>  #define BPLL_LOCK		0x20010
>>  #define BPLL_CON0		0x20110
>>  #define SRC_CDREX		0x20200
>> +#define GATE_BUS_CDREX0		0x20700
>> +#define GATE_BUS_CDREX1		0x20704
>>  #define DIV_CDREX0		0x20500
>>  #define DIV_CDREX1		0x20504
>>  #define KPLL_LOCK		0x28000
>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>  	DIV_CDREX1,
>>  	SRC_KFC,
>>  	DIV_KFC0,
>> +	GATE_BUS_CDREX0,
>> +	GATE_BUS_CDREX1,
>>  };
>>  
>>  static const unsigned long exynos5800_clk_regs[] __initconst = {
>> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>  PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>>  PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>>  PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_dpll_ctrl",
>> +					"mout_mpll_ctrl", "ff_dout_spll2",
>> +					"mout_sclk_spll"};
> 
> - mout_dpll_ctrl was not defined. This patch doesn't define it.
> - mout_mpll_ctrl was not defined. ditto.
> - ff_dout_spll2 was only registered when SOC is EXYNOS5800.
>   It meant that ff_dout_spll2 was not registered on exynos5422 board.
> 
> It is wrong patch. You would have not checked the parent clocks
> except for sclk_bpll.
> 
> Also,
> In the exynos5422 datasheet, MUX_MX_MSPLL_CCORE_PHY_SEL is possible
> having the six parents as following:
> - sclk_bpll
> - sclk_dpll
> - sclk_mpll
> - sclk_spll2
> - sclk_spll
> - sclk_epll
> 
> Why do you missing last 'sclk_epll'?
> 
> 
>> +
>>  
>>  /* fixed rate clocks generated outside the soc */
>>  static struct samsung_fixed_rate_clock
>> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>>  static const struct samsung_fixed_factor_clock
>>  		exynos5800_fixed_factor_clks[] __initconst = {
>>  	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> 
> It doesn't affect the Exynos5422 because exynos5800_fixed_factor_clks[]
> is registered when SOC is EXYNOS5800. Exynos5422 board cannot use this clock.

It is my fault. Please ignore this comment.

> 
>>  };
>>  
>>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>  	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>  	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>  
>> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>> +
> 
> Why do you modify the exynos5800_mux_clks instead of exynos5420_mux_clks
> or exynos5x_mux_clks? In the coverletter this patch is for Exynos5422 board.
> Did you test it?

It is my fault. Please ignore this comment.

> 
>>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
> 
> ditto.

It is my fault. Please ignore this comment.

> 
>>  	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>  			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> 
> ditto.

It is my fault. Please ignore this comment.

> 
>>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>  
>>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>  
>>  	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>  	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>  	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>> @@ -814,9 +825,13 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>  			DIV_CDREX0, 16, 3),
>>  	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
>>  			DIV_CDREX0, 8, 3),
>> +	DIV(0, "dout_cclk_drex1", "dout_clk2x_phy0", DIV_CDREX0, 8, 3),
> 
> Hmm. CLK_DIV_CDREX0[10:8] of DIV_CDREX0 register was already implemented
> by CLK_DOUT_CCLK_DREX0. It is fault.
> 
> Also, PCLK_CORE_MEM_RATIO[10:8] of DIV_CDREX1 register was defined as following
> in clock-exynos5420.c.
> - DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex", DIV_CDREX1, 8, 3), 
> 
> 
>>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>  			DIV_CDREX0, 3, 5),
>>  
>> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
>> +	DIV(0, "dout_pclk_drex1", "dout_cclk_drex1", DIV_CDREX0, 28, 3),
> 
> dout_cclk_drex1 is wrong. It is fault.
> 
>> +
>>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>  			DIV_CDREX1, 8, 3),
>>  
>> @@ -1170,6 +1185,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>  			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>  
>>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>> +
>> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 0, 0, 0),
>> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 1, 0, 0),
>> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>>  };
>>  
>>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
