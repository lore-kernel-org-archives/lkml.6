Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CAA208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iWInAfEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CAA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIXNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:41:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46787 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIXNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:41:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180924074105euoutp02f3c3b170f1f4d4b29968e35f5e33c39f~XRhejICx60307503075euoutp02e
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180924074105euoutp02f3c3b170f1f4d4b29968e35f5e33c39f~XRhejICx60307503075euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537774865;
        bh=E9l5RH/s7bnlj6ZQkOD8sKrxC6AroROiKW1cliNK0Nk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iWInAfEoyFVOs3EH8E1oKQQpQaJKIqFmaHvx0nig9H0SInFRT6nEK4uq7M6Kw8OfK
         +HIFw2YHs7agO4MHKJo69hpBZ66za5FPNMj/SDiVEpIB4debPqjPpj14TwU1VOuG63
         XdUXvcK4jlN/ZvAdbqS/UiCLfWIjBLHOCUNkYSWY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180924074104eucas1p1158b20e136060027c09afb0683e6d1af~XRheBJRg41298012980eucas1p1M;
        Mon, 24 Sep 2018 07:41:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B9.AD.04441.01598AB5; Mon, 24
        Sep 2018 08:41:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180924074103eucas1p1eccd62abcdeca57a95ad406869884a97~XRhczWE3m1304413044eucas1p1F;
        Mon, 24 Sep 2018 07:41:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180924074102eusmtrp246ff2c39d71d07ea759fc4337b85d298~XRhcgW9Lf1269812698eusmtrp24;
        Mon, 24 Sep 2018 07:41:02 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-07-5ba895103447
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.FD.04128.E0598AB5; Mon, 24
        Sep 2018 08:41:02 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180924074102eusmtip12d58c1d90031c3f7778338ce307a0a6c~XRhcHq81d2515725157eusmtip1j;
        Mon, 24 Sep 2018 07:41:02 +0000 (GMT)
Subject: Re: [RFT] arm64: ARM: dts: exynos: Remove double SD card detect pin
 inversion on TM2
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 24 Sep 2018 09:41:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921183014.20236-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7oCU1dEGzQc4LbYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zE5cHhsWtXJ5rF5Sb1H35ZVjB6fN8kF
        sERx2aSk5mSWpRbp2yVwZVy+MpO9YDJXxdEXjxkbGDdydDFyckgImEjc37eZvYuRi0NIYAWj
        xJvZz9kgnC+MErO27GKFcD4zSqxZcwIowwHW0j2xGiK+nFFiz6UPjBDOe0aJHSe/MYLMFRaI
        l+ho+cIEkhAROM8osf7PKrAEs0CCxITfV5lAbDYBQ4mut11sIDaLgKrEij8bWEA2iArESPze
        ZQ0S5hUQlDg58wkLiM0pYCoxe/FOJogx8hLb385hhrDFJW49mQ+2S0JgHbvEh19nGCGayyTu
        XzvFCvGoi0TX0WVMELawxKvjW9ghbBmJ/zthmpsZJdpnzGKHcHoYJbbO2cEGUWUtcfj4RVaQ
        65gFNCXW79KHCDtKzDp5ghkSLHwSN94KQhzEJzFp23SoMK9ER5sQRLWaxKzj6+DWHrxwiXkC
        o9IsJG/OQvLaLCSvzULYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgCjr97/in
        HYxfLyUdYhTgYFTi4WW4tzxaiDWxrLgy9xCjBAezkgiv2y2gEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV4+rbRoIYH0xJLU7NTUgtQimCwTB6dUA6NH9vEplgwcO3rzLX9u7PvUWxuye3uca6Xp
        ygMt4d/z43/06S5y+cxvfpZJ5tt6uyWhNvrrXxzaP2uOOiNHOiebYXhcweP1S6/V3Oxl1+5S
        2RVk9OCWfPSCi62/hef8eLFbk0H7nvMmact1Rzvu3D3yzTc23OH1cx2RqP2RXRKbX3BMznR+
        4aHEUpyRaKjFXFScCABHAKNKPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7p8U1dEG0x5bmKxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72Ny4PDYtKqTzWPzknqPvi2rGD0+b5IL
        YInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h8
        ZSZ7wWSuiqMvHjM2MG7k6GLk4JAQMJHonljdxcjFISSwlFGiY98x1i5GTqC4jMTJaQ1QtrDE
        n2tdbCC2kMBbRomG3+kgtrBAvERHyxcmkGYRgfOMEqd2LgVrYBZIkPh2/zMjxNQORonuI4/B
        utkEDCW63kJM4hWwk1g6ezeYzSKgKrHizwYWEFtUIEbi6OQWqBpBiZMzn4DFOQVMJWYv3skE
        scBMYt7mh8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hI
        rzgxt7g0L10vOT93EyMw5rYd+7llB2PXu+BDjAIcjEo8vCtuL48WYk0sK67MPcQowcGsJMLr
        dgsoxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAdJBXEm9oamhuYWlobmxubGahJM573qAy
        SkggPbEkNTs1tSC1CKaPiYNTqoHR4n/Dw5j1s/vfbOx7+5XjeGFw6Zwm4db6QzEbo7+qnEm5
        ps6wx5Vr4ZqcjXZ//7ya/OaHhrRDUsSPoI1N0+x8QovfMq+VjzO7YdAddWLWvpculn7f+h16
        YjyXcZ/6KZj6TzNWemZJbu2FeTcf5fxl7Tv8P+zQ3cQzr873Gnt9vz71xcVST7YHSizFGYmG
        WsxFxYkAXPsZYM8CAAA=
Message-Id: <20180924074103eucas1p1eccd62abcdeca57a95ad406869884a97~XRhczWE3m1304413044eucas1p1F@eucas1p1.samsung.com>
X-CMS-MailID: 20180924074103eucas1p1eccd62abcdeca57a95ad406869884a97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921183024epcas2p3bef08b81273524ec9d7afef4875bb746
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921183024epcas2p3bef08b81273524ec9d7afef4875bb746
References: <CGME20180921183024epcas2p3bef08b81273524ec9d7afef4875bb746@epcas2p3.samsung.com>
        <20180921183014.20236-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-09-21 20:30, Krzysztof Kozlowski wrote:
> The SDHCI standard, MMC host controller bindings and MMC core defines
> card detect pin as active low.  Therefore there is no point to invert it
> twice.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine on TM2 and TM2e. However I'm not sure if it makes sense to
refer to the SDHCI standard, as Exynos5433 has only DWMMC host controllers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a1e3194b7483..86d8ddc3288a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -939,8 +939,7 @@
>   	status = "okay";
>   	cap-sd-highspeed;
>   	disable-wp;
> -	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpa2 4 GPIO_ACTIVE_LOW>;
>   	card-detect-delay = <200>;
>   	samsung,dw-mshc-ciu-div = <3>;
>   	samsung,dw-mshc-sdr-timing = <0 4>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

