Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB965C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5E620844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HaiswFdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBKLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:11:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60937 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:11:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190211111151euoutp02c2a8524f1ab39a234d39650c7b696617~CStd3Xu352092220922euoutp025
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190211111151euoutp02c2a8524f1ab39a234d39650c7b696617~CStd3Xu352092220922euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549883511;
        bh=cf+AEqEQYL+doYF6XLG4RUt0bZPgSEdIft03IR9Byec=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HaiswFdVeQiKmktDD27Lrms6T4SMG05kEL8fsaRaAF5LL/twybQEdRy09zMEE4bOA
         li22yrFXqXL0H6v64AuGW1BthC7tmKjNsKB22+4l7IK7bRp0a18vTzE9xAcfl5kDR1
         j4SuXiQd8HQuPZeVMtQK0KxZxBlOjjIxfvVrMwuI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211111150eucas1p2e0a7731af19b707da399503171db8e8a~CStdDxWZ52003220032eucas1p2G;
        Mon, 11 Feb 2019 11:11:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.44.04294.578516C5; Mon, 11
        Feb 2019 11:11:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211111149eucas1p18808abac46a139345a09f7cbad14547a~CStcIyeck1214612146eucas1p1X;
        Mon, 11 Feb 2019 11:11:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211111148eusmtrp1be25754efe8952665a00d45196df983a~CStb1qsBm1901419014eusmtrp1n;
        Mon, 11 Feb 2019 11:11:48 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-4f-5c61587509fc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.44.04284.478516C5; Mon, 11
        Feb 2019 11:11:48 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211111148eusmtip1c7195532d749646aa21905c0c34c133d~CStbCO1gg1649816498eusmtip1D;
        Mon, 11 Feb 2019 11:11:47 +0000 (GMT)
Subject: Re: [PATCH v4 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     cwchoi00@gmail.com
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
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ae5a3ed8-a075-5ee4-e50a-dc4d2a9c5485@partner.samsung.com>
Date:   Mon, 11 Feb 2019 12:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH0VOSCfp8u416S45Tv9BgNcr_O_i88x6aY68Q7a7+=o4Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH+533WnPa75zQUxnbSxuayv23UdOGndlM2VA0vHhX0fW8RS6b
        LlInJUKXk7sszlg6Qpqlq6TIpaWy07RaKqKc849Y4/TW9N/n+zzf5/c83+3HU9puxp2PiI6X
        9NFipMA60Y9f/HqzJCFYDPXtSSGkrKCUIR9tXxjS3+BFrtW/YUhO71eKtLY+4MjrlG8cMfe2
        M2Q0q5shHyovs8SaXY9IQWuVityvt3Dk3asN5FPyHZbUfUtnyHh7Gb1Oo/vRkcbpnhotnM5s
        MrC6h8UndWfLTUhnNc8NZHc6rT0gRUYclvQ+/nudwltzxujYU1sSs+vaURJKWpuJHHnAK8CQ
        n0ZlIidei+8g+Hz3EasIG4LB8gZaEVYE718msVMjhdU9SGmUIKjJ6OIUMYygpctA2V0ueBt0
        VlVzdp6JZ8OTvL6JCQo/Z6DFaPgneJ7F3lBhirN71Hgj/CzpZ+xMY08o6DRN8CwcDHXZ35Hi
        0UBTYR9tZ0ccBEUXcybep7ArdPVdUyk8D1IfFU0EApzMw0BvCVLOXg+GnqpJdoGhxnJO4TnQ
        fCGLVliG1xmmyZgnIL2pYtKzBuoa3zH2mym8CEorfZRyANwarlTZy4CdoWNYo5zgDLmP8yml
        rIaM01rFvRDKs96qFJ4NJffyuHNIME4LZpwWxjgtjPH/3uuINiFXKUGOCpPkZdHSEW9ZjJIT
        osO898dEmdG/X9c83mirQJV/9tUizCNhhnpE3BuqZcTD8tGoWgQ8JcxUb9sshmrVB8SjxyR9
        zB59QqQk1yIPnhZc1ccdPu/S4jAxXjokSbGSfqqr4h3dk1CurdhP8N1Uow7ETaNC6ogH2eJZ
        6+E6LgYth2eXm73ar4Y4lA2PxBhue44NWaiFq9wv0YLq4bJgm39j7BXnwRQ3b7w9iK36rbdc
        8rjZFhAz/8Yuy9bw6pC3qw++3G318XPLze49v84ncuntn/kL4vsX7wgv0CR2jVlXtpnPDMRp
        BFoOF5cupvSy+Bc4OsEqcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7olEYkxBl/n61tsnLGe1eL6l+es
        Fs+OalvMP3KO1aL/8Wtmi/PnN7BbnG16w26x6fE1VouPPfdYLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnHxlKvF7cYVbBaH37SzWvy7tpHFQdDj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        nO//xVLQ4l/Re/gaYwNjg00XIyeHhICJxMwDDxm7GLk4hASWMkrM/3OTDSIhJjFp33Z2CFtY
        4s+1LjaIoteMEh8fHGECSQgLhErc3HcArEgEqGH7tCdgk5gFjrJKNC4/zgTRsYxJouP6YZYu
        Rg4ONgE9iR2rCkEaeAXcJD4tf8YKYrMIqErMuLkKzBYViJD4+HQfE0SNoMTJmU9YQGxOgUCJ
        2VP6wZYxC5hJzNv8kBnCFpe49WQ+E4QtL9G8dTbzBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJL
        i3PTc4sN9YoTc4tL89L1kvNzNzEC43vbsZ+bdzBe2hh8iFGAg1GJh/dDYkKMEGtiWXFl7iFG
        CQ5mJRHeUN/EGCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aevJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjKk3v1vITj45fYpg9bvd6lYBJ+YfyZ7MeSKt
        ZY9phWZla+cnK1HGDD1PvacHVvPGqLzlDxQK/abmvPHO0dyqIvZFUiXRDWxT9t3J+B48hVH4
        c5aO6aKo8xoc0VMMvdqMv+5c9WdyPKfrIWvtvosWN8NnHimUVbLW8z8+e2et3ZG82t3PUp+8
        VWIpzkg01GIuKk4EAAFagOAFAwAA
X-CMS-MailID: 20190211111149eucas1p18808abac46a139345a09f7cbad14547a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
References: <CGME20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267@eucas1p2.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-3-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0VOSCfp8u416S45Tv9BgNcr_O_i88x6aY68Q7a7+=o4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/3/19 10:56 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I recommend that please don't send the version up patchset before
> finishing the discussion.
> 
> 2019년 2월 2일 (토) 오전 2:47, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c..f1a4f56 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -132,6 +132,8 @@
>>   #define BPLL_LOCK              0x20010
>>   #define BPLL_CON0              0x20110
>>   #define SRC_CDREX              0x20200
>> +#define GATE_BUS_CDREX0                0x20700
>> +#define GATE_BUS_CDREX1                0x20704
>>   #define DIV_CDREX0             0x20500
>>   #define DIV_CDREX1             0x20504
>>   #define KPLL_LOCK              0x28000
>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>          DIV_CDREX1,
>>          SRC_KFC,
>>          DIV_KFC0,
>> +       GATE_BUS_CDREX0,
>> +       GATE_BUS_CDREX1,
>>   };
>>
>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p) = { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>   PNAME(mout_group14_5800_p)     = { "dout_aclk550_cam", "dout_sclk_sw" };
>>   PNAME(mout_group15_5800_p)     = { "dout_osc_div", "mout_sw_aclk550_cam" };
>>   PNAME(mout_group16_5800_p)     = { "dout_osc_div", "mout_mau_epll_clk" };
>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>> +                                       "mout_sclk_mpll", "ff_dout_spll2",
>> +                                       "mout_sclk_spll", "mout_sclk_epll"};
>> +
> 
> Remove unneeded extra blank line.
OK
> 
>>
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock
>> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>>   static const struct samsung_fixed_factor_clock
>>                  exynos5800_fixed_factor_clks[] __initconst = {
>>          FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>> -       FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>> +       FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>   };
>>
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>          MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>          MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>
>> +       MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>> +               mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>> +
>>          MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>> -                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>> +                       mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>          MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>                          SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>> -       MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>> +       MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>          MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>
>>          MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
> 
> The newly added clocks by this patch are supported on all Exynos5420/5422/5800?
The clocks are the same for Exynos5420/5422/5800 DMCs.

> I'm not sure because on the patch description, you only mentioned the
> Exynos5422 without Exynos5420/Exynos5800.
The driver code supports currently only Exynos5422 due to specific
timings inside, but the clocks are for all three Exynos SoCs.
It does not harm the Exynos5420/5800.
> 
> As for now, I can't check the Exynos TRM because I'm in holiday until
> next Wednesday. I will check them with Exynos542-/5422/5800 TRM on
> next Thursday.
OK, please add me to the communication thread with them. We will speed
up the process (I can test something for them if needed).
> 
>>
>>          MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>          MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>> -       MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>> +       MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>          MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>          MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>          MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>> @@ -817,6 +828,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>          DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>                          DIV_CDREX0, 3, 5),
>>
>> +       DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
> 
> Before applied this patch, on line 809, DIV_CDREX0[28:30] was already
> defined with "dout_pclk_cdrex" gate clock name.
In my previous email, I have mentioned that the same bits
(8 combinations) are controlling 3 dividers, which re-branch to 3 edges
in the clock tree named:
CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1.
It is in the Exynos5422_UM_REV0.10 documentation section:
7.9.6.7 CLK_DIV_CDREX0

They are put into one because there is a need of synchronization between
the BUS and DREXs (two external memory interfaces).
That's why it looks good in the clock information summary when an
SW engineer can see these HW assumptions.

If you disagree and would like to see only minimal clock definition
which makes the HW working, please write it on LKML.
The clock summary would not be reflecting the actual hierarchy and
someone who is looking for a specific clock details will not find it.

  Why do you redefine it
> with same register/same bit with the different clock name?
The clock is added for information purpose. I can remove it if you like,
but then the clock summary would not reflect the actual HW implementation.

> driver have to get only unique clock for the same register/same bit
> information.
True, driver gets the clocks which have exported IDs.
This one has '0' as you can see and is only for the clk_summary
information output.


The purpose of the patch with detailed clock tree related to DMC was
information, not the driver usage. That's why some clocks they did
no have IDs so drivers would not take them (without a hack).

> 
>     808         /* CDREX Block */
>     809         DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex",
> "dout_aclk_cdrex1",
>     810                         DIV_CDREX0, 28, 3),
> 
> And also, you don't use "dout_pclk_drex0" defined by you for
> CLK_ACLK_PPMU_DREX* gate clock on below. Instead, you use the already
> defined 'dout_pclk_cdrex' as I commented.
True
> 
>> +
>>          DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>                          DIV_CDREX1, 8, 3),
>>
>> @@ -1170,6 +1183,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>                          GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>
>>          GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>> +
> 
> Add the following comment for the readability in order to sustain the
> consistency of this driver.
> /* CDREX Block */ or /* CDREX */
OK
> 
>> +       GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>> +                       GATE_BUS_CDREX0, 0, 0, 0),
>> +       GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>> +                       GATE_BUS_CDREX0, 1, 0, 0),
>> +       GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>> +                       SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>> +
>> +       GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>> +                       GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>> +                       GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>> +                       GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>> +                       GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
> 
> You better to move the gate clock of GATE_BUS_CDREX[15:12] under the
> gate clock of GATE_BUS_CDREX[29:26]
> for the decending order because you defined them as the decending order.
Make sense, I will change it.

Regards,
Lukasz
> 
>> +
>> +       GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>> +                       GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>> +                       GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>> +                       GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>> +                       GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>>   };
>>
>>   static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>> --
>> 2.7.4
>>
> 
> 
> --
> Best Regards,
> Chanwoo Choi
> 
> 
