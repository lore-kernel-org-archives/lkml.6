Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B512084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Azk0MaUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfBANt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:49:29 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49365 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfBANt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:49:29 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201134927euoutp01364661e4f84d0d937a85d7c4ca9fb28d~-QaOS-lce2512825128euoutp01T
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 13:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201134927euoutp01364661e4f84d0d937a85d7c4ca9fb28d~-QaOS-lce2512825128euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549028967;
        bh=H98rDEzx0AhtIfssu+nCtmOZWdCn3y+4HBIFZLZdDeI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Azk0MaUUz3rVQPBuO00l4Vy24LgpKVg7lwyRdmxHGDH3S1lVWM4ChnT11hqmL3G8e
         6sz/3Yy7SDRgDYZMtiDtcOM98jrGqa2xoudb24lK+z9ZjXZgCMTQOlTYUvPvFyVd1I
         3KtWX7bZ2NxM1fJuMPRNjY6n5PoTMaUlVwyWVsjE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190201134926eucas1p1d48bbbc3e1aa5391a71edd8c614ffdce~-QaNUhzWL0772007720eucas1p1t;
        Fri,  1 Feb 2019 13:49:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 63.9A.04294.66E445C5; Fri,  1
        Feb 2019 13:49:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201134925eucas1p19a5a9243ee9ccd7983393ffa7e444d4a~-QaMWOPJQ0752107521eucas1p1t;
        Fri,  1 Feb 2019 13:49:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201134925eusmtrp2f5ac3ada610ca9d8346471dd1ba1c4d4~-QaMG_oyc2522025220eusmtrp26;
        Fri,  1 Feb 2019 13:49:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-7d-5c544e663c74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.2E.04128.56E445C5; Fri,  1
        Feb 2019 13:49:25 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201134924eusmtip15d7dd71b7980fb6d87f753cb48dfe7fb~-QaLcDoX_2156221562eusmtip1b;
        Fri,  1 Feb 2019 13:49:24 +0000 (GMT)
Subject: Re: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <66b886d3-37af-dc54-9dd8-c56977709e2a@partner.samsung.com>
Date:   Fri, 1 Feb 2019 14:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7ppfiExBjc/iVhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZHfg91sxbw+ixaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlbH+1gOWgvuCFUeP6DcwnuHrYuTkkBAwkXj5dxVzFyMXh5DACkaJm7veskI4Xxgl+hZs
        YYNwPjNKXJ12jQmmZdGr11Atyxklvj/6xQ7hvGWUWLZsMSNIlbBAuMSxD/MZQRIiAosZJaau
        /A3Wziwwk0mi801ZFyMHB5uAnsSOVYUgYV4BN4k9016wgNgsAioS82/3gpWLCkRIHO59xwhR
        IyhxcuYTsBpOAXuJK1O3sUOMFJe49WQ+1Hh5ieats8GukxB4yy7x4sQOZoizXSTetb1hg7CF
        JV4d38IOYctI/N85H+q1YomzHaugamok2k/ugKqxljh8/CIryM3MApoS63fpQ4QdJd68vMgE
        EpYQ4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKo1JLb0XIBaJCaxfM009gmMSrOQPDYLyTOzkDwz
        C2HvAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp7PS/4192MO76k3SIUYCDUYmH
        d8OvoBgh1sSy4srcQ4wSHMxKIrwrXEJihHhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJI
        TyxJzU5NLUgtgskycXBKNTDO6WfOLjlvZz3lUF1087b877rxaWuV725h0vwo6iP3+jf/Y0nz
        lPqSXT+9DVT3rNj2aXOCuWmcWMOUVypG6paii17W2X42n2fPIRf9766SzYmWPRIfdxdo5S17
        NXfWvF2bb78MDl3Y4r/sXG241pPy27+LXT8Fa7vb6kTLsndN3FIfaZzLd0aJpTgj0VCLuag4
        EQCwhy+QYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qpfiExBmvXcltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZHfg91sxbw+ixaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H+1gOWgvuCFUeP6Dcw
        nuHrYuTkkBAwkVj06jVzFyMXh5DAUkaJzlvTGSESYhKT9m1nh7CFJf5c62KDKHrNKLF+zntW
        kISwQLjEsQ/zwRpEBBYzSnxtrQYpYhaYySTxa9VqqLFTmCS+nwFp5+BgE9CT2LGqEKSBV8BN
        Ys+0FywgNouAisT8271MILaoQITEx6f7mCBqBCVOznwCVsMpYC9xZeo2sIuYBcwk5m1+yAxh
        i0vcejKfCcKWl2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6
        yfm5mxiBMbzt2M8tOxi73gUfYhTgYFTi4d3wKyhGiDWxrLgy9xCjBAezkgjvCpeQGCHelMTK
        qtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aXvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZ
        qakFqUUwfUwcnFINjCZz5TfNT+NxWVnjcWiRSsq5U+86pjrOvqMdl5zGWpPq0pBn/lBZ359H
        Om6r+qvAHmmDRTplD3avXPxnr1CL4uKPZlKWqQcFF6eXyAt+5Jg0f0nyQXe1xMIr6lM3MAdu
        +CK6UHexsuS2yFvvJ7Y07nm4YsGHnrK3Rn4nZ3655FthPD+Vo6YlQomlOCPRUIu5qDgRAHjw
        OeP3AgAA
X-CMS-MailID: 20190201134925eucas1p19a5a9243ee9ccd7983393ffa7e444d4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
        <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
        <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/1/19 8:40 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
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
> 
> The second patch don't implement some clocks
> for CLK_MOUT_DPLL, CLK_MOUT_ACLK_G3D.
> 
> Why do you define them?
You are right, it is a mistake.
I will remove it in v2.

Regards,
Lukasz
> 
> (snip)
> 
