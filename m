Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kJzrq1FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499FF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbeKVNrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:47:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:11567 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbeKVNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:46:59 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181122030937epoutp049c06027618771aaf0acb2514cd7fb6b1~pU4THfzKb1431914319epoutp04j;
        Thu, 22 Nov 2018 03:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181122030937epoutp049c06027618771aaf0acb2514cd7fb6b1~pU4THfzKb1431914319epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542856177;
        bh=YzzaAp76LnFpo1jaJNcPrfi0UHoYSBdudp36d9ECYx0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=kJzrq1FZqJILPsjstNxlowDXbIXD0q2JFwNoiOphNWlB0JLCiK2D646zyg/vwPx1Z
         1DZ7wtNSkSroI3Pzd7gLrQuYA3g8XNqrgjT4IOzB7CJPDEpoBrMgIsG/824sYm050D
         Ku4qXcUEJG+mLDljUR8VD18fmuutEkpI6g143hAQ=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181122030932epcas1p417dee1b267d7abdd4654447ac28a2d4c~pU4O8XAhA0531805318epcas1p4K;
        Thu, 22 Nov 2018 03:09:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.13.04057.CED16FB5; Thu, 22 Nov 2018 12:09:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181122030932epcas1p3c06ed50643bb21683b4a14f5ddfbc63f~pU4OYJ1Q41734517345epcas1p3K;
        Thu, 22 Nov 2018 03:09:32 +0000 (GMT)
X-AuditID: b6c32a36-d31ff70000000fd9-8a-5bf61deccc75
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A8.0D.03601.BED16FB5; Thu, 22 Nov
        2018 12:09:31 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK00JAWRFVLU40@mmp2.samsung.com>; Thu, 22 Nov 2018 12:09:31 +0900 (KST)
Message-id: <5BF61DEB.5010403@samsung.com>
Date:   Thu, 22 Nov 2018 12:09:31 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 6/6] arm: dts: exynos4: set opp-suspend for DMC and
 leftbus
In-reply-to: <1542823301-23563-7-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmge4b2W/RBn3LlC0ObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/S+kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCv
        ODG3uDQvXS85P9fK0MDAyBSoMCE74+tiuYLV/BVve/6yNDC+5+5i5OCQEDCRuNsh2sXIxSEk
        sINRornxAyuE851R4ui590xdjJxgRdvPL2CHSGxglPjc9pMZJMErICjxY/I9FpBJzALyEkcu
        ZYOEmQU0JV58mcQCUX8XaNDuo0wQ9VoSj5asZAexWQRUJZ6d2M8CYrMBxfe/uMEGYvMLKEpc
        /fGYEcQWFYiQ2Dn/G9hiEYHzjBJrdu5hAnGYBVqZJf592MIGsllYIFBi+oUykAZOAW+JKSu+
        gL0gIfCTXeLD9H/sEC+4SBz5uYIFwhaWeHV8CzvE/9ISl47aQtS3M0p8edEM1TyBUeLDqc1Q
        /xtLPFvYxQTxG5/Eu689rBDNvBIdbUIQJR4SrTM/sEG8fJ9RYsbW1YwTGGVnIYXSLEQozUIK
        pQWMzKsYxVILinPTU4sNC4yQY28TIzipa5ntYFx0zucQowAHoxIPr0bk12gh1sSy4srcQ4wS
        HMxKIrwXVgCFeFMSK6tSi/Lji0pzUosPMZoCA3kis5Rocj4w4+SVxBuaGhkbG1uYGJqZGhoq
        ifM+kZobLSSQnliSmp2aWpBaBNPHxMEp1cCY6BuRqPl++/KP7xcq8L6JWTX/TvevGb18Yr3/
        fT67MGwOWMIf8k9N/6B5dfS3g1fqT+i6coQynp4fc/Wq40lmyZaOM9uyyrz8dG+c+HF72Zob
        qbteTnwQ/F9BJvPYtSPR7uqWFRUZVTaLRWe9v7FkwcE31Q9i//TuN6ie0X8s7AKr3qxnZhcT
        lViKMxINtZiLihMBFDrzqwAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jQd3Xst+iDc4tsrI4uFXTYuOM9awW
        2zd+Y7WYf+Qcq0Xz4vVsFme6cy36H79mtjh/fgO7xdmmN+wWtxpkLGZN2ctksenxNVaLy7vm
        sFl87j3CaDHj/D4mi7VH7rJbLL1+kcniduMKNou7p44CzTh9idWide8Rdou21R9YLd5cuMfi
        IO6xbfc2Vo8189YwesxuuMjiMaH/E6PH4j0vmTw2repk89g/dw27x+Yl9R7/jrF7HHy3h8lj
        y9V2Fo++LasYPVas/s7u8XmTXABfFJdNSmpOZllqkb5dAlfG18VyBav5K972/GVpYHzP3cXI
        ySEhYCKx/fwC9i5GLg4hgXWMErNOvWECSfAKCEr8mHyPpYuRg4NZQF7iyKVsCFNdYsqUXIjy
        +4wSn9ousUKUa0k8WrKSHcRmEVCVeHZiPwuIzQYU3//iBhuIzS+gKHH1x2NGkDmiAhES3Scq
        QeaICJxnlDjY1wk2h1mglVniUVsWiC0s4C/x6MMcNrhlb05PBRvEKeAtMWXFF9YJjAKzkJw6
        C+HUWQinLmBkXsUomVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERjX2w5r9e1gvL8k/hCj
        AAejEg+vRuTXaCHWxLLiytxDjBIczEoivBdWAIV4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47
        FikkkJ5YkpqdmlqQWgSTZeLglGpgnJbjnSXgcPu2y9rVD9YqP9rq7ynrXrnVJqW3Y67ZxVUX
        BH5y5x/Y9O/fK5F4xZsRJznKFY2TPjL18F0MaPyz7uaGvU/knwbODym0C8qcLH6sd0uBXV6M
        9tTIBe+PL5eJ4VvzTa6+6rbTMpHzmg6fXrraHuZ8+EI6NPRkPuMKjYuLK878Wn/vvBJLcUai
        oRZzUXEiACO8v2rnAgAA
X-CMS-MailID: 20181122030932epcas1p3c06ed50643bb21683b4a14f5ddfbc63f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3@eucas1p1.samsung.com>
        <1542823301-23563-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> Mark the state for devfreq device while entring suspend/resume process.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1150000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -367,6 +368,7 @@
>  			};
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
> +				opp-suspend;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>  			opp-400000000 {
>  				opp-hz = /bits/ 64 <400000000>;
>  				opp-microvolt = <1050000>;
> +				opp-suspend;
>  			};
>  		};
>  
> @@ -520,6 +521,7 @@
>  			opp-200000000 {
>  				opp-hz = /bits/ 64 <200000000>;
>  				opp-microvolt = <1000000>;
> +				opp-suspend;
>  			};
>  		};
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
