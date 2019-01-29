Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42659C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E832175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c1elvF0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfA2P6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:58:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49117 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfA2P6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:58:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190129155759euoutp012f24e4581304c8badc9bfd9288d6eff8~_XOmDrfAU1569915699euoutp01u
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190129155759euoutp012f24e4581304c8badc9bfd9288d6eff8~_XOmDrfAU1569915699euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548777479;
        bh=efA1xgq/E6H2bvJ060ZQWL4+mu93Fz0joqPMVYcT+hk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c1elvF0pcQfD481UxWd+lsPqXeThn4ylVvH2AZerCuQ9B9q0BIlPSmZ2i4BSylkqw
         IcfLM1jBQ8Rj8rRP1PKZN9k/g24J/GvYyb2BpUWlY7pDW0+BxImUpw+43W7ZsnvUYP
         z7qXwWIlJZSeaG8NYKykp+Ji5bn7fpRxERbIvSJ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190129155759eucas1p2acbb97bf26d1a3625dcbd266d371a5fc~_XOlQXk1N2552225522eucas1p25;
        Tue, 29 Jan 2019 15:57:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 51.07.04294.608705C5; Tue, 29
        Jan 2019 15:57:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190129155758eucas1p13ee7f9bf17b10d104e198770fa8a9122~_XOkasFnM2320423204eucas1p1v;
        Tue, 29 Jan 2019 15:57:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190129155757eusmtrp19b9a3923bb352f53395ae36b909421fd~_XOkL_9A02822928229eusmtrp15;
        Tue, 29 Jan 2019 15:57:57 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-ab-5c507806155d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.FF.04284.508705C5; Tue, 29
        Jan 2019 15:57:57 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129155757eusmtip113b4e6905e9601c05a055ec1e1810d6c~_XOjn2lsb2108621086eusmtip1h;
        Tue, 29 Jan 2019 15:57:57 +0000 (GMT)
Subject: Re: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f41259c2-fe37-261d-2029-e4d4aecf52d6@partner.samsung.com>
Date:   Tue, 29 Jan 2019 16:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7psFQExBreW61hsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsll6/yGRxu3EFm0Xr3iPsFofftLM6
        8HismbeG0WPTqk42j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr4/2W5WwFMyUrWta0
        sDcwnhXpYuTkkBAwkTiy5DYLiC0ksIJRouWJXxcjF5D9hVGi8dIuVgjnM6PErs9r2GE6NvTe
        YoJILGeUmP71LiOE85ZRYuf1ZawgVcICIRLbV+wB6xARcJH4dLGXEcRmFjjJJNE02aSLkYOD
        TUBPYseqQpAwr4CbxONPS8BaWQRUJd69aWYGsUUFIiQO975jhKgRlDg58wnYqZwC9hKzXx1n
        gRgpLnHryXwmCFteonnrbGaQeyQEbrFLHG4+zgpxtYvEua9voT4Qlnh1fAuULSNxenIPC4Rd
        LHG2YxUbhF0j0X5yB1SNtcTh4xdZQW5mFtCUWL9LHyLsKHF+/n12kLCEAJ/EjbeCECfwSUza
        Np0ZIswr0dEmBFGtIbGl5wIThC0msXzNNPYJjEqzkDw2C8kzs5A8Mwth7wJGllWM4qmlxbnp
        qcVGeanlesWJucWleel6yfm5mxiB6er0v+NfdjDu+pN0iFGAg1GJh5chOCBGiDWxrLgy9xCj
        BAezkgiv4W//GCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
        Ug2Mnp/lDfj+2t6tskieHfvUe5L/jn973r6fztknPulZqtUru/M5+c62VqtKol7Lx516xMRm
        7Cqq+3r2Bb9b0zjbN8+xXvt947EDGz6afHiWNT/Gaorg4i8LFZ0zLHOecPJcUJBTDWZrk6us
        /SdyxfbvL6abk53MciakBb3q1Npi3nc580fxLP4CJZbijERDLeai4kQAOh0lqFMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7qsFQExBos+6ltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsll6/yGRxu3EFm0Xr3iPsFofftLM6
        8HismbeG0WPTqk42j81L6j36tqxi9Pi8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/2W5WwFMyUrWta0sDcwnhXpYuTkkBAwkdjQe4up
        i5GLQ0hgKaPEgSvn2CASYhKT9m1nh7CFJf5c62KDKHrNKPFt+h8mkISwQIjE9hV7wIpEBFwk
        Pl3sZQQpYhY4ySTR/G4SI0THFCaJrX2ngRwODjYBPYkdqwpBGngF3CQef1rCCmKzCKhKvHvT
        zAxiiwpESHx8uo8JokZQ4uTMJywgNqeAvcTsV8fBbGYBM4l5mx8yQ9jiEreezGeCsOUlmrfO
        Zp7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCcbjv2c/MO
        xksbgw8xCnAwKvHwMgQHxAixJpYVV+YeYpTgYFYS4TX87R8jxJuSWFmVWpQfX1Sak1p8iNEU
        6LmJzFKiyfnAFJJXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx
        ZuPCYycKkgU4izfMVJ65RfK0r6tWnMEu1Ub/OvXTd2oC9hnP0mKYeTasp0d3988li2ayuR1j
        3CL+Z+XjiKSHyxc99Vp89Vmh/rsr1/3vL9uwW7iiau6alreb8melND/4VsSu8tIso+KFr82N
        Hyq/vvHrFah13F4ZmcX00zMkxkRtyf623EePlFiKMxINtZiLihMBkIHJt+kCAAA=
X-CMS-MailID: 20190129155758eucas1p13ee7f9bf17b10d104e198770fa8a9122
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
        <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
        <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 1/29/19 1:54 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> This patchset don't contain the cover-letter. Please send the
> cover-letter which explains what to do on this patchset.
> 
> And is it supporting all Exynos5 for both 32bit(5420,5422)
> and 64bit(5433) or only Exynos542x(32bit)? If it only support
> the Exynos 542x series, you have to change the driver name
> from 'exynos5-dmc.c' to 'exynos5420-dmc.c' or 'exynos5422-dmc.c'
> in order to prevent the confusion according to the driver name.
I will rename the driver file to exynos5422-dmc.c and the config entry.
When the driver will get support for Exynos5433, the file name would
have to be changed again.

Regards,
Lukasz

> 
> 
> On 19. 1. 29. 오전 4:21, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>> index 355f469..1827a64 100644
>> --- a/include/dt-bindings/clock/exynos5420.h
>> +++ b/include/dt-bindings/clock/exynos5420.h
>> @@ -60,6 +60,7 @@
>>   #define CLK_MAU_EPLL		159
>>   #define CLK_SCLK_HSIC_12M	160
>>   #define CLK_SCLK_MPHY_IXTAL24	161
>> +#define CLK_SCLK_BPLL		162
>>   
>>   /* gate clocks */
>>   #define CLK_UART0		257
>> @@ -195,6 +196,16 @@
>>   #define CLK_ACLK432_CAM		518
>>   #define CLK_ACLK_FL1550_CAM	519
>>   #define CLK_ACLK550_CAM		520
>> +#define CLK_CLKM_PHY0		521
>> +#define CLK_CLKM_PHY1		522
>> +#define CLK_ACLK_PPMU_DREX0_0	523
>> +#define CLK_ACLK_PPMU_DREX0_1	524
>> +#define CLK_ACLK_PPMU_DREX1_0	525
>> +#define CLK_ACLK_PPMU_DREX1_1	526
>> +#define CLK_PCLK_PPMU_DREX0_0	527
>> +#define CLK_PCLK_PPMU_DREX0_1	528
>> +#define CLK_PCLK_PPMU_DREX1_0	529
>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>   
>>   /* mux clocks */
>>   #define CLK_MOUT_HDMI		640
>> @@ -217,6 +228,10 @@
>>   #define CLK_MOUT_EPLL		657
>>   #define CLK_MOUT_MAU_EPLL	658
>>   #define CLK_MOUT_USER_MAU_EPLL	659
>> +#define CLK_MOUT_DPLL		660
>> +#define CLK_MOUT_ACLK_G3D	661
>> +#define CLK_MOUT_SCLK_SPLL	662
>> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	663
>>   
>>   /* divider clocks */
>>   #define CLK_DOUT_PIXEL		768
>> @@ -248,8 +263,9 @@
>>   #define CLK_DOUT_CCLK_DREX0	794
>>   #define CLK_DOUT_CLK2X_PHY0	795
>>   #define CLK_DOUT_PCLK_CORE_MEM	796
>> +#define CLK_FF_DOUT_SPLL2	797
>>   
>>   /* must be greater than maximal clock id */
>> -#define CLK_NR_CLKS		797
>> +#define CLK_NR_CLKS		798
>>   
>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
>>
> 
> 
