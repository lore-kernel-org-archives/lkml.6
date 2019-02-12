Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D88C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AEA2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YrAU/s3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBLGES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:04:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47326 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfBLGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:04:17 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212060413epoutp0394cc7196b070ff90423af1348098ea9c~CiKJ7Srrn1438414384epoutp03P
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:04:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212060413epoutp0394cc7196b070ff90423af1348098ea9c~CiKJ7Srrn1438414384epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549951453;
        bh=NcwarMcRZ7k9eedsov8Qy9qA4fePQYUddTr5AVA1Miw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YrAU/s3SIAAgBvxarynTNzFimsfHGLoCI+LrDZ2ZSMmu1auNPtQ4pUSRZig53ZnIe
         BfHbI1FgeB57FtqyL41ZCoafMRv4TGiwtCvOu9wVHb3pQpff79x/VDrZRPZDjkIuzU
         0JDdf0eUw2HRPfx8de9adansaz/io0CwKFOPKrrI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190212060409epcas1p385c8a16703be7a6431305e882434f02e~CiKG2l3ju2670826708epcas1p3m;
        Tue, 12 Feb 2019 06:04:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.99.04074.9D1626C5; Tue, 12 Feb 2019 15:04:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190212060409epcas1p33c92bd0e6e69ff3ea259cc65851032ad~CiKGGhx5j3097830978epcas1p3W;
        Tue, 12 Feb 2019 06:04:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212060409epsmtrp1ecba3cf255400599f63b79f46a67b0ba~CiKGCHqu92469124691epsmtrp1j;
        Tue, 12 Feb 2019 06:04:09 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-1b-5c6261d9156d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.BE.03971.8D1626C5; Tue, 12 Feb 2019 15:04:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212060408epsmtip1045dabd1fcacf8df4da05d572f1407eb~CiKFhc6Ml1821218212epsmtip1z;
        Tue, 12 Feb 2019 06:04:08 +0000 (GMT)
Subject: Re: [PATCH v4 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>, cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f8ed6d63-1513-54fa-616b-57977d4f403e@samsung.com>
Date:   Tue, 12 Feb 2019 15:04:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ae5a3ed8-a075-5ee4-e50a-dc4d2a9c5485@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmvu7NxKQYg0+vTCw2zljPavHsqLbF
        /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
        jB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0
        MDAyBSpMyM449fEaa8GBsIpl+y4zNzD2OnUxcnJICJhIzDp1k62LkYtDSGAHo8SB8+eZIJxP
        jBJTFs+CynxjlOiduY4VpqVt4xqoxF5GiX0vXzOCJIQE3jNKzDmrAGILC4RK3Nx3gB3EFhFw
        kNh58yUjSAOzwHRWiebre1lAEmwCWhL7X9xgA7H5BRQlrv54DFTEwcErYCexrysNJMwioCqx
        oPMG2BxRgQiJw73vwHbxCghKnJz5BGwMp4C7RFfXGyYQm1lAXOLWk/lQtrxE89bZzCB7JQSO
        sUu82TebHWS+hICLxOONNRDPCEu8Or6FHcKWknjZ3wZlV0usPHmEDaK3g1Fiy/4LUN8bS+xf
        OpkJZA6zgKbE+l36ELv4JN597WGFGM8r0dEmBFGtLHH5wV0mCFtSYnF7JxuE7SFx4MNG9gmM
        irOQfDMLyQezkHwwC2HZAkaWVYxiqQXFuempxYYFhsiRvYkRnLK1THcwTjnnc4hRgINRiYdX
        ITcxRog1say4MvcQowQHs5II7w//pBgh3pTEyqrUovz4otKc1OJDjKbAwJ7ILCWanA/MJ3kl
        8YamRsbGxhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqYODilGhjNHhbwlt5cIX1614E9
        m5+uln5b+G7FOQ+nJ9sr2tLFZ/sU75q1bd2f2tOrBdNOrxQIsjYvYF/85OjihzIB1oKFduFT
        rDSSbiVcve/n/uWGweOfT0zyJsZFlWqfve+07fDigyUPdXccvOnbPu2D5uPvFwRCcw/LSnlf
        mP5MyavVbGFSs2HitZhVSizFGYmGWsxFxYkAPGKGeO8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnO6NxKQYg+vzzS02zljPavHsqLbF
        /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
        jB6fN8kFsEdx2aSk5mSWpRbp2yVwZZz6eI214EBYxbJ9l5kbGHuduhg5OSQETCTaNq5h62Lk
        4hAS2M0osW5DOzNEQlJi2sWjQDYHkC0scfhwMUTNW0aJmQ+Ps4HUCAuEStzcd4AdxBYRcJDY
        efMlI4jNLDCXVeLamVoQW0jgMZPEjDv5IDabgJbE/hc3wHr5BRQlrv54zAgyn1fATmJfVxpI
        mEVAVWJB5w2wkaICERIfn+5jArF5BQQlTs58wgJicwq4S3R1vWGCWKUu8WfeJWYIW1zi1pP5
        UHF5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpec
        n7uJERy7Wpo7GC8viT/EKMDBqMTDW5GfGCPEmlhWXJl7iFGCg1lJhPeHf1KMEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYw5/7P5yr9eqzF7EiD+as7z
        YCcpXZflAVs4e8K4Z5+96T/VxSo/aJlp2rn7IlFZU2e1WRX95dhuW3VC4JGGakr8Sccz1f0B
        l/VuO1lL2f9NaBS5vvzxPhFjiRuT69dkvFgXvbw/4tgvjXNr68Vvx8+78+rI42d8hWXTvpr+
        FP+k/UlnYdYOU2MlluKMREMt5qLiRABMgD7S2QIAAA==
X-CMS-MailID: 20190212060409epcas1p33c92bd0e6e69ff3ea259cc65851032ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
References: <CGME20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267@eucas1p2.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-3-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0VOSCfp8u416S45Tv9BgNcr_O_i88x6aY68Q7a7+=o4Q@mail.gmail.com>
        <ae5a3ed8-a075-5ee4-e50a-dc4d2a9c5485@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 11. 오후 8:11, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/3/19 10:56 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> I recommend that please don't send the version up patchset before
>> finishing the discussion.
>>
>> 2019년 2월 2일 (토) 오전 2:47, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>>
>>> This patch provides support for clocks needed for Dynamic Memory Controller
>>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>>> GATE entries.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
>>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>>> index 34cce3c..f1a4f56 100644
>>> --- a/drivers/clk/samsung/clk-exynos5420.c
>>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>>> @@ -132,6 +132,8 @@
>>>   #define BPLL_LOCK              0x20010
>>>   #define BPLL_CON0              0x20110
>>>   #define SRC_CDREX              0x20200
>>> +#define GATE_BUS_CDREX0                0x20700
>>> +#define GATE_BUS_CDREX1                0x20704
>>>   #define DIV_CDREX0             0x20500
>>>   #define DIV_CDREX1             0x20504
>>>   #define KPLL_LOCK              0x28000
>>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>>          DIV_CDREX1,
>>>          SRC_KFC,
>>>          DIV_KFC0,
>>> +       GATE_BUS_CDREX0,
>>> +       GATE_BUS_CDREX1,
>>>   };
>>>
>>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>>> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p) = { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>>   PNAME(mout_group14_5800_p)     = { "dout_aclk550_cam", "dout_sclk_sw" };
>>>   PNAME(mout_group15_5800_p)     = { "dout_osc_div", "mout_sw_aclk550_cam" };
>>>   PNAME(mout_group16_5800_p)     = { "dout_osc_div", "mout_mau_epll_clk" };
>>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>>> +                                       "mout_sclk_mpll", "ff_dout_spll2",
>>> +                                       "mout_sclk_spll", "mout_sclk_epll"};
>>> +
>>
>> Remove unneeded extra blank line.
> OK
>>
>>>
>>>   /* fixed rate clocks generated outside the soc */
>>>   static struct samsung_fixed_rate_clock
>>> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>>>   static const struct samsung_fixed_factor_clock
>>>                  exynos5800_fixed_factor_clks[] __initconst = {
>>>          FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>>> -       FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>> +       FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>>   };
>>>
>>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>>          MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>>          MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>>
>>> +       MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>>> +               mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>>> +
>>>          MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>>> -                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>>> +                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>>          MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>>                          SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>>> -       MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>> +       MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>>          MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>>
>>>          MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>>> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>
>> The newly added clocks by this patch are supported on all Exynos5420/5422/5800?
> The clocks are the same for Exynos5420/5422/5800 DMCs.
> 
>> I'm not sure because on the patch description, you only mentioned the
>> Exynos5422 without Exynos5420/Exynos5800.
> The driver code supports currently only Exynos5422 due to specific
> timings inside, but the clocks are for all three Exynos SoCs.
> It does not harm the Exynos5420/5800.
>>
>> As for now, I can't check the Exynos TRM because I'm in holiday until
>> next Wednesday. I will check them with Exynos542-/5422/5800 TRM on
>> next Thursday.
> OK, please add me to the communication thread with them. We will speed
> up the process (I can test something for them if needed).
>>
>>>
>>>          MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>>          MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>>> -       MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>> +       MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>>          MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>>          MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>>          MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>>> @@ -817,6 +828,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>>          DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>>                          DIV_CDREX0, 3, 5),
>>>
>>> +       DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
>>
>> Before applied this patch, on line 809, DIV_CDREX0[28:30] was already
>> defined with "dout_pclk_cdrex" gate clock name.
> In my previous email, I have mentioned that the same bits
> (8 combinations) are controlling 3 dividers, which re-branch to 3 edges
> in the clock tree named:
> CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1.
> It is in the Exynos5422_UM_REV0.10 documentation section:
> 7.9.6.7 CLK_DIV_CDREX0

It is my missing point. I checked it on Exynos5422 TRM.
I want to develop the clocks according to H/W clock.
Please keep it without removal.

Instead,
It is very strange case. So, you need to add
the detailed comment when defining the multiple clocks
with same register/same bits. Also, in order to reduce
the confusion of this strange case, IMO you better to
define the three clocks at the nearby in this driver.
(CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1)
If they are scattered, it is difficult for understanding
why they are developed like this.

> 
> They are put into one because there is a need of synchronization between
> the BUS and DREXs (two external memory interfaces).
> That's why it looks good in the clock information summary when an
> SW engineer can see these HW assumptions.
> 
> If you disagree and would like to see only minimal clock definition
> which makes the HW working, please write it on LKML.
> The clock summary would not be reflecting the actual hierarchy and
> someone who is looking for a specific clock details will not find it.
> 
>   Why do you redefine it
>> with same register/same bit with the different clock name?
> The clock is added for information purpose. I can remove it if you like,
> but then the clock summary would not reflect the actual HW implementation.
> 
>> driver have to get only unique clock for the same register/same bit
>> information.
> True, driver gets the clocks which have exported IDs.
> This one has '0' as you can see and is only for the clk_summary
> information output.
> 
> 
> The purpose of the patch with detailed clock tree related to DMC was
> information, not the driver usage. That's why some clocks they did
> no have IDs so drivers would not take them (without a hack).
> 
>>
>>     808         /* CDREX Block */
>>     809         DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex",
>> "dout_aclk_cdrex1",
>>     810                         DIV_CDREX0, 28, 3),
>>
>> And also, you don't use "dout_pclk_drex0" defined by you for
>> CLK_ACLK_PPMU_DREX* gate clock on below. Instead, you use the already
>> defined 'dout_pclk_cdrex' as I commented.
> True
>>
>>> +
>>>          DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>>                          DIV_CDREX1, 8, 3),
>>>
>>> @@ -1170,6 +1183,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>>                          GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>>
>>>          GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>>> +
>>
>> Add the following comment for the readability in order to sustain the
>> consistency of this driver.
>> /* CDREX Block */ or /* CDREX */
> OK
>>
>>> +       GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>>> +                       GATE_BUS_CDREX0, 0, 0, 0),
>>> +       GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>>> +                       GATE_BUS_CDREX0, 1, 0, 0),
>>> +       GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>>> +                       SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>>> +
>>> +       GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>>> +                       GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>>> +                       GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>>> +                       GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>>> +                       GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
>>
>> You better to move the gate clock of GATE_BUS_CDREX[15:12] under the
>> gate clock of GATE_BUS_CDREX[29:26]
>> for the decending order because you defined them as the decending order.
> Make sense, I will change it.
> 
> Regards,
> Lukasz
>>
>>> +
>>> +       GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>>> +                       GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>>> +                       GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>>> +                       GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>>> +                       GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>>>   };
>>>
>>>   static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>>> --
>>> 2.7.4
>>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
