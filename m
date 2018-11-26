Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BA120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R/Rycfh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BA120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeKZSbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:31:17 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63442 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:31:17 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181126073759epoutp04b53180970a677b1b9dc8932e2caba8df~qnHxHehr70903009030epoutp04G;
        Mon, 26 Nov 2018 07:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181126073759epoutp04b53180970a677b1b9dc8932e2caba8df~qnHxHehr70903009030epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543217879;
        bh=kQqn7kUgaulY8m32byPmtQ8k1GH0CBpMSOWho6lYeH4=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=R/Rycfh7FE2TOB7Gr8JDIMvFFMC2zYM/YJd7Tj4YL4AYSGFS2tFYChIwm+toGoZt6
         UIkoZAXcT01t4c67OLZjctAqur543Cf4SInlmMBU5zTr2Hk1b0zEK7L0FheeGlK10l
         YQVqUBLai2/aVV9u6+6Chj7BUMQLLiob9vQDWZng=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181126073756epcas1p1811bc8647d76da184295671622542ff9~qnHtkXkQK2325923259epcas1p1a;
        Mon, 26 Nov 2018 07:37:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.0B.04058.2D2ABFB5; Mon, 26 Nov 2018 16:37:54 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181126073753epcas1p374e6690302db8378534419029a3f9eab~qnHrgW94L0940309403epcas1p30;
        Mon, 26 Nov 2018 07:37:53 +0000 (GMT)
X-AuditID: b6c32a35-e1fff70000000fda-1c-5bfba2d2e892
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F6.0F.03601.1D2ABFB5; Mon, 26 Nov
        2018 16:37:53 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIS00IPYIJ5U140@mmp2.samsung.com>; Mon, 26 Nov 2018 16:37:53 +0900 (KST)
Message-id: <5BFBA2D1.8090409@samsung.com>
Date:   Mon, 26 Nov 2018 16:37:53 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Anand Moon <linux.amoon@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: Add g3d bus nodes using VDD_INT for
 Exynos542x SoC
In-reply-to: <20181123094413.1108-3-linux.amoon@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0gTcRjH++22u2mtrpX1y6jmgaCCtUtnV2gUWhxkIfpCyRfzmsdmbrex
        m5G9qMjMMrFphmGFGoa2F/6ZJlr4B51OExwtEymNwpLMyIZWZhHdeUW++zxfvs/v+fN7lIi6
        Ag1V5nAO1s4xZgINlrf3R+6J9t//makdGcOoas+ogroxPYdQPl8zRrmnxxVUoOS1gnr++C5K
        3fZ1y6jGlpcY9ezpEaqwy4NR/Z+KFNTv8RY55Xr8CxxS0fMThRjdWTWF0W7XNZRurbtAl7a5
        AL3g3pmCnsyNN7FMNmvXsJzBmp3DGROIY2n6RL0uTktGk/upfYSGYyxsApGUnBJ9NMcs9Elo
        zjDmPEFKYXie2HMw3m7Nc7Aak5V3JBCsLdts22/bzTMWPo8z7jZYLQdIrXavTjBm5Zra62pR
        W0HY2alffuwi+AKLQZAS4rHw2e1JrBgEK9V4B4ADpQWoFHwHsKHIKwTKFde7VwYxQY03Azju
        jBdZhW+ESzdfy0ULgu+CHn+uKCN4JHz0pOnvm1MAenyXFZI/CvraBuUiy/FwOOPvBiKjgt7z
        YQIVeQMeBl8sTa/oIXgG7Kz+hom8GZ8FsDKASgUCANY0nBZ5E54OWx8GZCIH4QfgwqVBRBqs
        CINNvgyJk+DAVS8m8Sb40duGSWNth/6BBLFPwQ7g4ocChRQ4AfzytFUmJcTAmdpimVR4Pfz8
        tUQhJavg1StqyULDnmv1fwfuEgae6ZM5wY6qVTuq+r+jqlU7qgGIC2xhbbzFyPKkjVz9d26w
        cpFRug5QMZrcB3AlINapnMvLmWoFc4bPt/QBqESIzSpH0c9MtSqbyT/H2q16e56Z5fuATlhx
        GRIaYrAK98059KRub0xMDBVLxulIktiqehd6L1ONGxkHm8uyNtb+L0+mDAq9CO5ExEWODTV6
        W0o8wxHJ5Wsm515OZl1PDboUuFX/ZjCNmzg+UmmIPtF9PpE+bGnRE2M/6oaXio/XNN8ErYUj
        0P3EG1E9P1s6tO1t+lycpXl9ahi4P/ux8sE9+7GyJGd4Lz9Ka12178lhUy/VbmwI0aQv6vlU
        VfnailgfV3aqkJDzJoaMQuw88wcGTD1vpwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e+xoO7FRb+jDc4e0rOYf+Qcq0X/49fM
        FufPb2C32PT4GqvFx557rBaXd81hs5hxfh+TxbqNt9gtLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZWxb
        spCtoFmx4u6fS+wNjB8kuhg5OCQETCSe3E7uYuTiEBJYxyhx7tZdpi5GTg5eAUGJH5PvsYDU
        MAvISxy5lA0SZhZQl5g0bxEzRP19RolTV3+yQNRrSZzfcgzMZhFQlXh2aR8jiM0GFN//4gYb
        iM0voChx9cdjRpCZogIREt0nKkHmiAi8ZJSY9+Q7O4jDLPCRUeLgikdgDcIC4RKbV35kgti2
        F+i6NZ/BNnAKWEl8bjrGPIFRYBaSY2chHDsLybELGJlXMUqmFhTnpucWGxUY5qWW6xUn5haX
        5qXrJefnbmIExsu2w1p9OxjvL4k/xCjAwajEw/viz69oIdbEsuLK3EOMEhzMSiK8Je2/o4V4
        UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpg1FE7fz7Qcfm2
        nS9kDQ791bzf9evhLqcIpjlZe4ImvJeZduwcO0NPb2nBDefm3jn928XmT2beIVl4fOE8Dvt9
        Z15pL5HKMPf7JTWF/Y2xC8/D5wFnojdKKXz5oTv9/rp5bx/8N9zsLPPXnnHeBzspubWapxZv
        iA3XTHiuednZ/KPzX07tiGsT9ymxFGckGmoxFxUnAgDeYkbAkwIAAA==
X-CMS-MailID: 20181126073753epcas1p374e6690302db8378534419029a3f9eab
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181123094508epcas5p4b7958b812bf0f64ca47006ced9fda279
References: <20181123094413.1108-1-linux.amoon@gmail.com>
        <CGME20181123094508epcas5p4b7958b812bf0f64ca47006ced9fda279@epcas5p4.samsung.com>
        <20181123094413.1108-3-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

CLK_DOUT_ACLK_G3D is the clock for GPU h/w and it requires the buck4_reg("vdd_g3d").

bus_wcore uses the buck3_reg("vdd_int"). bus_wcore and bus_g3d don't share the 
same voltage line. It is wrong to make 'bus_g3d' as the child of 'bus_wcore'
because of using the different regulator.

CLK_DOUT_ACLK_G3D and buck4_reg should be controlled from MALI driver 
with DEVFREQ framework. Unfortunately, MALI driver is not posted to mainline.


On 2018년 11월 23일 18:44, Anand Moon wrote:
> Add missing Netwwork on chip for g3d bus node using VDD_INI
> for Exynos542x SoC.
> 
> - CLK_DOUT_ACLK_G3D for G3D's AXI
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 57 +++++++++++++++++--
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  5 ++
>  2 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff15880761..bc7203bb1282 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1047,6 +1047,14 @@
>  			status = "disabled";
>  		};
>  
> +		bus_g3d: bus_g3d {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_DOUT_ACLK_G3D>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_g3d_opp_table>;
> +			status = "disabled";
> +		};
> +
>  		bus_jpeg: bus_jpeg {
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
> @@ -1245,7 +1253,44 @@
>  			};
>  		};
>  
> -		bus_jpeg_opp_table: opp_table11 {
> +		bus_g3d_opp_table: opp_table11 {
> +			compatible = "operating-points-v2";
> +
> +			opp@600000000 {
> +				opp-hz = /bits/ 64 <600000000>;
> +				opp-microvolt = <1025000>;
> +			};
> +			opp@543000000 {
> +				opp-hz = /bits/ 64 <543000000>;
> +				opp-microvolt = <987500>;
> +			};
> +			opp@480000000 {
> +				opp-hz = /bits/ 64 <480000000>;
> +				opp-microvolt = <950000>;
> +			};
> +			opp@420000000 {
> +				opp-hz = /bits/ 64 <420000000>;
> +				opp-microvolt = <937500>;
> +			};
> +			opp@350000000 {
> +				opp-hz = /bits/ 64 <350000000>;
> +				opp-microvolt = <900000>;
> +			};
> +			opp@266000000 {
> +				opp-hz = /bits/ 64 <266000000>;
> +				opp-microvolt = <862500>;
> +			};
> +			opp@177000000 {
> +				opp-hz = /bits/ 64 <177000000>;
> +				opp-microvolt = <862500>;
> +			};
> +			opp@100000000 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				opp-microvolt = <862500>;
> +			};
> +		};
> +
> +		bus_jpeg_opp_table: opp_table12 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> @@ -1262,7 +1307,7 @@
>  			};
>  		};
>  
> -		bus_jpeg_apb_opp_table: opp_table12 {
> +		bus_jpeg_apb_opp_table: opp_table13 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> @@ -1279,7 +1324,7 @@
>  			};
>  		};
>  
> -		bus_disp1_fimd_opp_table: opp_table13 {
> +		bus_disp1_fimd_opp_table: opp_table14 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> @@ -1290,7 +1335,7 @@
>  			};
>  		};
>  
> -		bus_disp1_opp_table: opp_table14 {
> +		bus_disp1_opp_table: opp_table15 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> @@ -1304,7 +1349,7 @@
>  			};
>  		};
>  
> -		bus_gscl_opp_table: opp_table15 {
> +		bus_gscl_opp_table: opp_table16 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> @@ -1318,7 +1363,7 @@
>  			};
>  		};
>  
> -		bus_mscl_opp_table: opp_table16 {
> +		bus_mscl_opp_table: opp_table17 {
>  			compatible = "operating-points-v2";
>  
>  			opp00 {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 2fac4baf1eb4..6e39e4594502 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -89,6 +89,11 @@
>  	status = "okay";
>  };
>  
> +&bus_g3d {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
>  &bus_jpeg {
>  	devfreq = <&bus_wcore>;
>  	status = "okay";
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
