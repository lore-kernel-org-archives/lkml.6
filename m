Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A13C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA8120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sE8aSyij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfA3Mwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:52:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33819 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfA3Mwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:52:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190130125252euoutp018bf3eed94903c8bcc1a0c3f819d65a65~_oWQCIcZg1947219472euoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 12:52:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190130125252euoutp018bf3eed94903c8bcc1a0c3f819d65a65~_oWQCIcZg1947219472euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548852772;
        bh=IBPDM6AfRZ8UrMjyIhT1hwhllxDf2XHMgYs+F0ofQuE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sE8aSyijwmOcsW9h5Ygrgtg6lcawsviDAfAxby4JyvUZEuXrJm+Tm3IsfzstI2DaM
         6S/iIBduHENWGKJdo7Qn9Saxb01PiDEsswdl5BLPhNKO3hVLv0iEhwP+e6/rJjYyNs
         GzncHEriLInyW3nB+WGjrISh+QBbN/ZU6ue6g3yY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190130125251eucas1p16ac57d23f63860d2dfd744932695eed4~_oWPGx9qP1276312763eucas1p1z;
        Wed, 30 Jan 2019 12:52:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 20.FE.04441.32E915C5; Wed, 30
        Jan 2019 12:52:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190130125250eucas1p2394b3ec6073c04ac841e85a4c9cbcc20~_oWOROfkI1276112761eucas1p23;
        Wed, 30 Jan 2019 12:52:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190130125250eusmtrp1feef69f34f5e9f4412d5200607805f75~_oWOCP8MB2687526875eusmtrp1F;
        Wed, 30 Jan 2019 12:52:50 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-8f-5c519e232f1b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.7E.04128.22E915C5; Wed, 30
        Jan 2019 12:52:50 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190130125249eusmtip2cedfb04c24ca7a3abe86c879401bb31d~_oWNaCATz0492804928eusmtip2h;
        Wed, 30 Jan 2019 12:52:49 +0000 (GMT)
Subject: Re: [PATCH v2 6/8] DT: arm: exynos: add DMC device for exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <267bc3e3-efc1-c6a8-2a32-e298adb40cfe@partner.samsung.com>
Date:   Wed, 30 Jan 2019 13:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3auDk99rsyXiopFYEEzS+hQdpOKEURKBFGDmnVSyXnZ8ZIW
        qUXqvFSolS1RE0tbmros11XQ0TLvaSmVEE3soibqxC4YOc8k//u9z/u8fM8DH0soOqglbFhE
        jKCP0IYraTn56OWvtnWrCoM06/tvrOBr8qsovsfxheKLrG0Uf9k+SPDt7dUM33p+iOHN9ncU
        3/WkgObHs62Iz29/IeMrrX0Mf7unU8Z/SCmn+YvPrQzfOJRG7VigriisQGqzyUCrH5QmqS/V
        mpB63Lw8kDos9z8hhIfFCXqfbcfkoYbUHjrKCqcvvWxGyWgKZyA3FrAfXB2pJTOQnFXgcgT2
        C3mUNDgQDD79yEjDOIKb738ysyemu+cJaVGGICVnxHUyjOBxr4NyuhbivdBdXIecvAivgZ6p
        yRkTgYtIyEi/N/0iy9JYBRZTtNPD4T1QfP8C5ZRJvBrumPc6ZU98CBqzfyDJ4gFNN/pJJ7vh
        IKhvmSKcTGAveN9fJJN4BdQNF8yEAzzKwHCrmZBS74KW3AmZxAvhu63W1WYZNOdmkRKL0Jpu
        oiU+C2lNFpdnCzTaOmeyEdNdqp74SPJOsI/W0U4Z8HzoHfaQIsyHnEfXCUnmID1VIbm9oTar
        wxVgMZRVXGOuIKVxTjHjnDLGOWWM/98tRqQJeQmxoi5EEH0jhHiVqNWJsREhquOROjOa/mfN
        f21jFjTxJrgBYRYp3bl5BwI1CkobJyboGhCwhHIR5/tnv0bBndAmJAr6yKP62HBBbEBLWVLp
        xZ2Z9+mIAodoY4RTghAl6Ge3MtZtSTJaGb28ZsDP/YN/IZ1wsPt1TlOk7o/5maO6s2W3YXc9
        MzXJeS+92bfv29Uqy57f61I3bBdtJZZszUZr1Y7QAp9rt0bPfT0QV7JV4zmGgwxv++MDMgM+
        2ydKo34/70ouSU/s7vLvaxiILj2cZ+IWvNpsUwWPXD+5iXsYWpmZlh8oT1IpSTFU67uW0Iva
        f/szKBpjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7pK8wJjDO50KltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZHfg91sxbw+ixaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9HZdp2t4IhERd+x04wN
        jH8Fuhg5OSQETCRWrWxi7mLk4hASWMoo8fvEOVaIhJjEpH3b2SFsYYk/17rYIIpeM0rMPXua
        BSQhLOAlcWXBdkYQW0RAU+L63++sIEXMAvNZJKY8/c4C0bGMSeLspLVAGQ4ONgE9iR2rCkEa
        eAXcJBasawYLswioSizb5AUSFhWIkPj4dB8TRImgxMmZT8B2cQoESuw/85cZxGYWMJOYt/kh
        lC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L
        10vOz93ECIzhbcd+btnB2PUu+BCjAAejEg8vQ3BAjBBrYllxZe4hRgkOZiURXsPf/jFCvCmJ
        lVWpRfnxRaU5qcWHGE2BfpvILCWanA9ML3kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tS
        s1NTC1KLYPqYODilGhiv2D6bIb/kk1TmnpSdnRtn5b/93PTmxETnpde7FkbduS/wLqV8n2wj
        o2Lmhoc3+g/OSMrPLk2+8c/RbsWtbTtrXm4WUPPP5nXcY//QaHlAYf2M5pb7J9Ob+kRsWfKO
        rj5uOcfcqHh187uJn/S22v64crRO63ZHizbj0aKUT7tOTFi2922d0c7XSizFGYmGWsxFxYkA
        bXQC9vcCAAA=
X-CMS-MailID: 20190130125250eucas1p2394b3ec6073c04ac841e85a4c9cbcc20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0
References: <CGME20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0@eucas1p2.samsung.com>
        <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/30/19 10:46 AM, Krzysztof Kozlowski wrote:
> On Tue, 29 Jan 2019 at 18:55, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add description of Dynamic Memory Controller and PPMU counters.
>> They are used by exynos5422-dmc driver.
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: devicetree@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             | 69 +++++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 +++++++++
>>   2 files changed, 91 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..4d76335 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -235,6 +235,27 @@
>>                          status = "disabled";
>>                  };
>>
>> +               dmc: memory-controller@10c20000 {
>> +                       compatible = "samsung,exynos5422-dmc";
>> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
>> +                       clocks = <&clock CLK_FOUT_SPLL>,
>> +                               <&clock CLK_MOUT_SCLK_SPLL>,
>> +                               <&clock CLK_FF_DOUT_SPLL2>,
>> +                               <&clock CLK_FOUT_BPLL>, <&clock CLK_MOUT_BPLL>,
>> +                               <&clock CLK_SCLK_BPLL>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                               <&clock CLK_MOUT_MCLK_CDREX>,
>> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                               <&clock CLK_CLKM_PHY0>, <&clock CLK_CLKM_PHY1>;
>> +                       clock-names = "fout_spll", "mout_sclk_spll",
>> +                               "ff_dout_spll2", "fout_bpll", "mout_bpll",
>> +                               "sclk_bpll", "mout_mx_mspll_ccore",
>> +                               "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex",
>> +                               "dout_clk2x_phy0", "clkm_phy0", "clkm_phy1";
> 
> We misunderstood each other. I did not ask for compaction into one
> continued line but for proper indentation. Having one entry per one
> line was fine because you have really a lot of entries and it was
> making things easier to check.
> It should look like:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos54xx.dtsi?h=v4.20#n78
> 
Yes, we misunderstood each other. I will fix it in v3.
Thank you for having a look on it. I assume that the other issues
have been properly addressed.

Regards,
Lukasz

> Best regards,
> Krzysztof
> 
> 
