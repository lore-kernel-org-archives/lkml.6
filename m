Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E219C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7DF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aI/Qv52e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7DF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756237AbeFSH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:27:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37460 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755656AbeFSH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:26:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180619072655euoutp01f6dc0b93b361bd30dc5de5837abc7f7a~5fwbJfR540714807148euoutp01Y
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180619072655euoutp01f6dc0b93b361bd30dc5de5837abc7f7a~5fwbJfR540714807148euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529393215;
        bh=NqyNa5SHRVCCoqztIXQm6J0nAndINc6HorgUWBj96cM=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=aI/Qv52eZvP7afBlSZfZHQVsoMEqjlOk/KE1sqxO1fzmYyb3m06MO16ez+X+YAeUQ
         sleeoGcyhB21nw4to+NbFzEjlsr6JZSnOkBTCCx0Z9rfJT769CAaUA9J7fDy6nRw5s
         Fay1RXStLPLlh1MlPPgjN9uNbR0Xiv6PleuqB9ZU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619072653eucas1p112324fddbd161e10b0510ebe08d0f9fe~5fwZX8iZO2633926339eucas1p1V;
        Tue, 19 Jun 2018 07:26:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 41.B1.05700.D30B82B5; Tue, 19
        Jun 2018 08:26:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q;
        Tue, 19 Jun 2018 07:26:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180619072651eusmtrp2b081b6ec0f76e9b39040c0af42a3ec89~5fwXXi66e2649726497eusmtrp2o;
        Tue, 19 Jun 2018 07:26:51 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-00-5b28b03d7dbf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.2E.04178.B30B82B5; Tue, 19
        Jun 2018 08:26:51 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180619072651eusmtip2f948f22956f6f3bedb1a55c16121e5c8~5fwW6mCSM3261632616eusmtip2V;
        Tue, 19 Jun 2018 07:26:51 +0000 (GMT)
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 19 Jun 2018 09:26:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618174216.24801-2-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7q2GzSiDdbeZ7Z4v6yH0WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxdLrF5ksWvceYbd4+fEEiwOXx5p5axg9Nq3q
        ZPPYvKTe4/MmuQCWKC6blNSczLLUIn27BK6MlT1JBQsFK753TGBsYJzJ28XIySEhYCKx4dZm
        dhBbSGAFo8Szs8xdjFxA9hdGiedvLrBDOJ8ZJU69XswI07Fq93uoquWMEgfbNzBBOO8ZJXZ1
        /2QDqRIWyJW41HecFSQhIvCKSaLt31+wJWwChhJdb7vAilgEVCUeLlsKNlZUIEZi2+UHLCA2
        r4CgxMmZT8BsTgFTiWd/toP1MgvIS2x/O4cZwhaXuPVkPthmCYFt7BKTN95jhGguk1jcf50d
        4lYXif/fFjND2MISr45vgYrLSPzfCdPczCjRPmMWO4TTwyixdc4ONogqa4nDxy8C/cABtE5T
        Yv0ufYiwo8T6hbfYQMISAnwSN94KQhzEJzFp23RmiDCvREebEES1msSs4+vg1h68cAnqHA+J
        c4dns01gVJyF5OVZSN6cheTNWQg3LGBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY
        lk7/O/5pB+PXS0mHGAU4GJV4eBs2qkcLsSaWFVfmHmKU4GBWEuHdulQjWog3JbGyKrUoP76o
        NCe1+BCjNAeLkjhvnEZdlJBAemJJanZqakFqEUyWiYNTqoFRzjwxobSKn6Hr088D6uwOV54y
        CKTqN8nuZL9ymi1YSCLYL5+RKb7WYe2zt1zTDHfNyTh5fe2tpAdyB7tCq+cdffpx2kb5REnb
        WXvUX09nf9ry492rVSrpNbb9Xuv3Jwt28BwqfJyRmTOz7N2GC3JmTRsjv/66nRzYFSP/f4uj
        yezuf925RT1KLMUZiYZazEXFiQCU1KIlRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7rWGzSiDXZfk7N4v6yH0WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+TxdLrF5ksWvceYbd4+fEEiwOXx5p5axg9Nq3q
        ZPPYvKTe4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2MlT1JBQsFK753TGBsYJzJ28XIySEhYCKxavd75i5GLg4hgaWMErO+/WeESMhI
        nJzWwAphC0v8udbFBlH0llFi5b5pTCAJYYFciUt9x1lBEiICr5gk2o9/YIGo2swocXjLNLBR
        bAKGEl1vQdo5OXgF7CS2rFwH1s0ioCrxcNlSsBpRgRiJ1Rsvs0PUCEqcnPmEBcTmFDCVePZn
        O1icWcBMYt7mh8wQtrzE9rdzoGxxiVtP5jNNYBSchaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9
        t9hQrzgxt7g0L10vOT93EyMw4rYd+7l5B+OljcGHGAU4GJV4eBs2qkcLsSaWFVfmHmKU4GBW
        EuHdulQjWog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgckgryTe0NTQ3MLS0NzY3NjMQkmc
        97xBZZSQQHpiSWp2ampBahFMHxMHp1QDYzBrv630jw83HJknHPk2cfe9ed9fzVhV8ngja8LR
        5uf64sfnc147kDd910U1+/TdZnuW/tib9+NA9gx3RckARl/GSLm5nx56KO6xX6K+s/TVW64w
        jR/NP5r/LGfUfLzYv+K37MeTNqZ/T33QbT615Y23dd+xa1ybd574o7zjXcoXiaRFt6auf6qm
        xFKckWioxVxUnAgApLBfL84CAAA=
Message-Id: <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
X-CMS-MailID: 20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f
References: <20180618174216.24801-1-krzk@kernel.org>
        <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
        <20180618174216.24801-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
> The decon, decon_tv and dsi nodes have only one child port so
> address/size mappings are not necessary.  This fixes DTC warnings like:
>
>      Warning (graph_child_address): /soc/decon@13800000/ports:
>          graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine with current Exynos DRM Decon/MIC/DSI drivers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
>   2 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a1e3194b7483..0a15ee513f5c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -321,11 +321,7 @@
>   	status = "okay";
>   
>   	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> +		port {
>   			tv_to_hdmi: endpoint {
>   				remote-endpoint = <&hdmi_to_tv>;
>   			};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 3a9b4c4b9c63..e4367fd39120 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -850,11 +850,7 @@
>   			iommu-names = "m0", "m1";
>   
>   			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +				port {
>   					decon_to_mic: endpoint {
>   						remote-endpoint =
>   							<&mic_to_decon>;
> @@ -914,11 +910,7 @@
>   			#size-cells = <0>;
>   
>   			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +				port {
>   					dsi_to_mic: endpoint {
>   						remote-endpoint = <&mic_to_dsi>;
>   					};

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

