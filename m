Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC0B218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E6wEkF3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfBANDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:03:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37042 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfBANDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:03:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190201130341euoutp024fc5ea2eecf5323d3be60b4621a88761~-PyQpJrvF2763527635euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 13:03:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190201130341euoutp024fc5ea2eecf5323d3be60b4621a88761~-PyQpJrvF2763527635euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549026221;
        bh=+zJTqzw6PQyWguk9kEe8A8gQsGxIGJysum6xsEcP2G0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E6wEkF3tgeU3w0ST4P8R/sglEWePPMC16FwMLDJzTz53aNFOssinckCw7bBaLOtgq
         /US4XllXc+agin0ufRTYqtFIdOzLqpDWrYZzPF/7ZsN/RJaFy8QUof7wakdTauZ4uo
         Qph3b5Nf6YqNPQURk3FBr6kf/JN6z9ZPOmwJ8TIc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190201130340eucas1p198e5a89d1d67bc97eb8ac90e1a496b3a~-PyP2NW2P2777227772eucas1p1I;
        Fri,  1 Feb 2019 13:03:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.CA.04441.CA3445C5; Fri,  1
        Feb 2019 13:03:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201130339eucas1p2fe21475ebacb7bf7ec87743b894119c5~-PyPGd02O1967419674eucas1p2b;
        Fri,  1 Feb 2019 13:03:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201130339eusmtrp17aeebb99f00f17431a974ae18a3ca2cd~-PyO3gApa2692526925eusmtrp1M;
        Fri,  1 Feb 2019 13:03:39 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-32-5c5443acf236
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.D1.04284.BA3445C5; Fri,  1
        Feb 2019 13:03:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201130338eusmtip1df7b21c5c8cbab9ddde968aa4cd48870~-PyODx6uy0754607546eusmtip1g;
        Fri,  1 Feb 2019 13:03:38 +0000 (GMT)
Subject: Re: [PATCH v3 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <7d308300-f9e8-d93b-e3a0-5e5686ef748f@partner.samsung.com>
Date:   Fri, 1 Feb 2019 14:03:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <45e61b41-3be1-2090-6ab0-4d1743d0913c@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu2+Z99TGrqPlqcRssE3IMiJetGfGQCuh2SLopA+VHK15jWVF
        2qrV2IRhmgtKKtpgptMYOtKiTopFmuZGkRi2aWmWTpGG1eNN5H+/75zvcL8PLksqOuhZbHTs
        EV4bq45Ryhypew0/mxeX+geGLM2xOXEVmXdormv0A83lWZtpztD3ieRaWsoZ7tmZzwxn6uuk
        ua/6Hpp7YcmRcSOpVsRltjwguNvW1wzX+iSAe3W6RMbVf06muYnOCmo9Vn3pPs+oTMaLMtXd
        wkTVFbMRqUZMnjvpfY6rI/iY6Hheu2RtmGNUTY+JOfQm9Fh22SuUhIoDLiEHFvByGB/soC4h
        R1aBSxB0ZuTaxSiC0bJxmSRGEBgs+cy/k15jr91VjKA/pRpJYhCB7eM7JLpccRAYDDmMuHDD
        BQjSb40ToiDxfQJuduv/ulhWhn2hynhYPJDjzdA69oAQmcLeUNVVRIs8He+B+tQhJHlcoOnG
        W0pkB7wOah73kCKT2B1evs0jJJ4DZyuzSSmqjYHConkSbwJDoQ1J7AoDjWZ7HQ94ek1PSSzA
        sxSjTOKTkNxUZfesgvrGVlqMTOJFcMeyRBpvAOv9TlIcA3aG7kEXKYEzpN3LsI/lkHJBIbkX
        gln/nJB4BhSXXmeuImXWpF5Zk7pkTeqS9f/dfEQZkTuvEzSRvOAXyx/1FdQaQRcb6RsepzGh
        v5/t6UTjtypkaztQhzCLlFPl5WO7QhS0Ol5I0NQhYEmlm7x9fWCIQh6hTjjOa+NCtboYXqhD
        s1lK6S4/MaV3vwJHqo/wB3n+EK/9tyVYh1lJyBL90G3MqWlapfO2AL/5A3v7gw7v+FFwymx9
        tLJh6LLR3Odl+fTbZ2p3xcaJvf7lmvavWysT57am62qXBccUeFbuifdzOle4IHcs7UTOMNYF
        p7O15y4OjvqvCT/lM39m24oUIl5b8t7sNexCbEho/uDtUWts/rV9d8P3In31ljDt5WolJUSp
        /XxIraD+AwU9tidoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7qrnUNiDC4cFbPYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+Bqrxceee6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        uHjK1eJ24wo2i8Nv2lkt/l3byOIg4PH+Riu7x6ZVnWwem5fUe/RtWcXo8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G7nub2AsexlfM
        XnebsYFxuWsXIyeHhICJxINVD1i6GLk4hASWMkpcOLKGCSIhJjFp33Z2CFtY4s+1LjaIoteM
        ElN2tDODJIQFQiX6++eAFYkILGaU+NpaDVLELLCXSWJCz2VWiI6TTBKHt4G0c3CwCehJ7FhV
        CNLAK+AmcfHXPrBtLAIqEjuuL2UFsUUFIiQ+PoWI8woISpyc+YQFxOYUsJfYffQe2GJmATOJ
        eZsfQtniEreezGeCsOUlmrfOZp7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJu
        cWleul5yfu4mRmA0bzv2c/MOxksbgw8xCnAwKvHwbvgVFCPEmlhWXJl7iFGCg1lJhPeKQ0iM
        EG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDE01eSbyhqaG5haWhubG5sZmFkjjveYPKKCGB
        9MSS1OzU1ILUIpg+Jg5OqQbG4r0v98w+5TiNaWP9/9Vvv4Sf8O77l9H943vKe5+gm9Hea69K
        651ec2OWbpXT01np9+J476zc25L6w3phcFRvCot1Xn5gn9hnB7FJ2brOR3addH6d6N1z3Cba
        fbOCxn6eGAuN+w+19mxe6CSqOm2S3wHnueVPl2jcs+5J+XvXXjHDwzGgSqZUiaU4I9FQi7mo
        OBEAxFWwr/wCAAA=
X-CMS-MailID: 20190201130339eucas1p2fe21475ebacb7bf7ec87743b894119c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p1ca478545c107086d427909c88d3b232e@eucas1p1.samsung.com>
        <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
        <768b4147-35fb-64ad-5da8-6b348e962c70@samsung.com>
        <45e61b41-3be1-2090-6ab0-4d1743d0913c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/1/19 10:20 AM, Chanwoo Choi wrote:
> Hi,
> 
> There are some wrong comments by me. Sorry for confusion.
No problem.
> 
> On 19. 2. 1. 오후 5:07, Chanwoo Choi wrote:
>> Hi,
>>
>> When I reviewed this patch, the almost changes are wrong.
>> Frankly, I can't believe that you had tested and verified it
>> on real board. Please check my comments.
>> If I misunderstood, please let me know.
>>
>> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>>> This patch provides support for clocks needed for Dynamic Memory Controller
>>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>>> GATE entries.
>>>
>>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>> CC: Michael Turquette <mturquette@baylibre.com>
>>> CC: Stephen Boyd <sboyd@kernel.org>
>>> CC: Kukjin Kim <kgene@kernel.org>
>>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>>> CC: linux-samsung-soc@vger.kernel.org
>>> CC: linux-clk@vger.kernel.org
>>> CC: linux-arm-kernel@lists.infradead.org
>>> CC: linux-kernel@vger.kernel.org
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/clk/samsung/clk-exynos5420.c | 48 +++++++++++++++++++++++++++++++++---
>>>   1 file changed, 44 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>>> index 34cce3c..3e87421 100644
>>> --- a/drivers/clk/samsung/clk-exynos5420.c
>>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>>> @@ -132,6 +132,8 @@
>>>   #define BPLL_LOCK		0x20010
>>>   #define BPLL_CON0		0x20110
>>>   #define SRC_CDREX		0x20200
>>> +#define GATE_BUS_CDREX0		0x20700
>>> +#define GATE_BUS_CDREX1		0x20704
>>>   #define DIV_CDREX0		0x20500
>>>   #define DIV_CDREX1		0x20504
>>>   #define KPLL_LOCK		0x28000
>>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>>   	DIV_CDREX1,
>>>   	SRC_KFC,
>>>   	DIV_KFC0,
>>> +	GATE_BUS_CDREX0,
>>> +	GATE_BUS_CDREX1,
>>>   };
>>>   
>>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>>> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>>   PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>>>   PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>>>   PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_dpll_ctrl",
>>> +					"mout_mpll_ctrl", "ff_dout_spll2",
>>> +					"mout_sclk_spll"};
>>
>> - mout_dpll_ctrl was not defined. This patch doesn't define it.
>> - mout_mpll_ctrl was not defined. ditto.
OK, I will add them.
>> - ff_dout_spll2 was only registered when SOC is EXYNOS5800.
>>    It meant that ff_dout_spll2 was not registered on exynos5422 board.
It is registered for Exynos5422:
     fout_spll                         1        1        0   800000000 
        0     0  50000
        mout_sclk_spll                 4        4        0   800000000 
        0     0  50000
           ff_dout_spll2               2        2        0   400000000 
        0     0  50000
              mout_mx_mspll_ccore       1        1        0   400000000 
         0     0  50000

>>
>> It is wrong patch. You would have not checked the parent clocks
>> except for sclk_bpll.
>>
>> Also,
>> In the exynos5422 datasheet, MUX_MX_MSPLL_CCORE_PHY_SEL is possible
>> having the six parents as following:
>> - sclk_bpll
>> - sclk_dpll
>> - sclk_mpll
>> - sclk_spll2
>> - sclk_spll
>> - sclk_epll
>>
>> Why do you missing last 'sclk_epll'?
I will add that clock to the list of possible sources.
>>
>>
>>> +
>>>   
>>>   /* fixed rate clocks generated outside the soc */
>>>   static struct samsung_fixed_rate_clock
>>> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>>>   static const struct samsung_fixed_factor_clock
>>>   		exynos5800_fixed_factor_clks[] __initconst = {
>>>   	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>>> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>
>> It doesn't affect the Exynos5422 because exynos5800_fixed_factor_clks[]
>> is registered when SOC is EXYNOS5800. Exynos5422 board cannot use this clock.
> 
> It is my fault. Please ignore this comment.
> 
>>
>>>   };
>>>   
>>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>>   	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>>   	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>>   
>>> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>>> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>>> +
>>
>> Why do you modify the exynos5800_mux_clks instead of exynos5420_mux_clks
>> or exynos5x_mux_clks? In the coverletter this patch is for Exynos5422 board.
>> Did you test it?
> 
> It is my fault. Please ignore this comment.
> 
>>
>>>   	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>>> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>>> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>
>> ditto.
> 
> It is my fault. Please ignore this comment.
> 
>>
>>>   	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>>   			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>>> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>
>> ditto.
> 
> It is my fault. Please ignore this comment.
> 
>>
>>>   	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>>   
>>>   	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>>> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>>   
>>>   	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>>   	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>>> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>>   	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>>   	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>>   	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>>> @@ -814,9 +825,13 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>>   			DIV_CDREX0, 16, 3),
>>>   	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
>>>   			DIV_CDREX0, 8, 3),
>>> +	DIV(0, "dout_cclk_drex1", "dout_clk2x_phy0", DIV_CDREX0, 8, 3),
>>
>> Hmm. CLK_DIV_CDREX0[10:8] of DIV_CDREX0 register was already implemented
>> by CLK_DOUT_CCLK_DREX0. It is fault.
Please check my comment bellow.
>>
>> Also, PCLK_CORE_MEM_RATIO[10:8] of DIV_CDREX1 register was defined as following
>> in clock-exynos5420.c.
>> - DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex", DIV_CDREX1, 8, 3),
>>
>>
>>>   	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>>   			DIV_CDREX0, 3, 5),
>>>   
>>> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
>>> +	DIV(0, "dout_pclk_drex1", "dout_cclk_drex1", DIV_CDREX0, 28, 3),
>>
>> dout_cclk_drex1 is wrong. It is fault.
So, your suggestion is to not define the clocks:
dout_cclk_drex1, out_pclk_drex1
because they use the same register bits as:
dout_cclk_drex0, dout_pclk_drex0

I have added them to have the information in clk_summary which now shows 
the full topology:
     fout_bpll                         3        3        0   825000000 
        0     0  50000
        mout_bpll                      3        3        0   825000000 
        0     0  50000
           mout_mclk_cdrex             1        1        0   825000000 
        0     0  50000
              dout_pclk_core_mem       0        0        0   206250000 
        0     0  50000
              dout_sclk_cdrex          1        1        0   825000000 
        0     0  50000
                 clkm_phy1             0        0        0   825000000 
        0     0  50000
                 clkm_phy0             0        0        0   825000000 
        0     0  50000
                 dout_clk2x_phy0       1        1        0   825000000 
        0     0  50000
                    dout_aclk_cdrex1       1        1        0 
412500000          0     0  50000
                       aclk_ppmu_drex1_1       0        0        0 
412500000          0     0  50000
                       aclk_ppmu_drex1_0       0        0        0 
412500000          0     0  50000
                       aclk_ppmu_drex0_1       0        0        0 
412500000          0     0  50000
                       aclk_ppmu_drex0_0       0        0        0 
412500000          0     0  50000
                       dout_pclk_cdrex       3        3        0 
103125000          0     0  50000
                          pclk_ppmu_drex1_1       1        1        0 
103125000          0     0  50000
                          pclk_ppmu_drex1_0       1        1        0 
103125000          0     0  50000
                          pclk_ppmu_drex0_1       0        0        0 
103125000          0     0  50000
                          pclk_ppmu_drex0_0       1        1        0 
103125000          0     0  50000
                    dout_cclk_drex0       0        0        0 
412500000          0     0  50000
                       dout_pclk_drex0       0        0        0 
103125000          0     0  50000
                    dout_cclk_drex1       0        0        0 
412500000          0     0  50000
                       dout_pclk_drex1       0        0        0 
103125000          0     0  50000

The output is comprehensive, it also shows the speed of the
performance counters used by simpleondemand_governor in devfreq.
I was trying to keep it align with the documentation.

When I remove dout_cclk_drex1 and out_pclk_drex1, it will be working,
only the clk information would not show the full topology as is in the
documentation.
Do you prefer to remove these two clocks?

Thank you the review.

Regards,
Lukasz Luba

>>
>>> +
>>>   	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>>   			DIV_CDREX1, 8, 3),
>>>   
>>> @@ -1170,6 +1185,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>>   			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>>   
>>>   	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>>> +
>>> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>>> +			GATE_BUS_CDREX0, 0, 0, 0),
>>> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>>> +			GATE_BUS_CDREX0, 1, 0, 0),
>>> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>>> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>>> +
>>> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>>> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>>> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>>> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>>> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
>>> +
>>> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>>> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>>> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>>> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>>> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>>> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>>>   };
>>>   
>>>   static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>>>
>>
>>
> 
> 
