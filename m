Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A807214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ODcbPLeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A807214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQMzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:55:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33912 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJQMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:55:55 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017050203epoutp03aee01c1c8941e86bcb19072f6b303c82~eTMMKtAk50908509085epoutp03V;
        Wed, 17 Oct 2018 05:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017050203epoutp03aee01c1c8941e86bcb19072f6b303c82~eTMMKtAk50908509085epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539752523;
        bh=Qsul/JPKR+Mr1WrQOiaxWDAVbOhJhqAyUIXYIHZYkNg=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ODcbPLeLkYHdVtMG3CjGow0Kx5goidK2WM2ztpV+K8e0vXMJcbh+bXE3cZdkfLh+t
         ziPKE9XcmeEL2392eKOUxuGE5zvLipaQJ1/VyEYIfB5w+qD0Cvpii0hNvWRTJW8dQG
         5N0zqgbkWOjomegnTmohkstF6N9cORYKbw1SAcP4=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017050158epcas1p44d08bc1c24dada0d8c4f357e2ed98287~eTMHimf9i2403524035epcas1p4X;
        Wed, 17 Oct 2018 05:01:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.BF.04015.642C6CB5; Wed, 17 Oct 2018 14:01:58 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181017050157epcas2p1ec4292b7bfa2b53a6c67bc2f0e3fc4d6~eTMHJ8Tmf2022220222epcas2p1n;
        Wed, 17 Oct 2018 05:01:57 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-24-5bc6c2465600
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.B1.03633.542C6CB5; Wed, 17 Oct 2018 14:01:57 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGQ0010A8N9T770@mmp1.samsung.com>; Wed, 17 Oct 2018 14:01:57 +0900 (KST)
Message-id: <5BC6C245.7040407@samsung.com>
Date:   Wed, 17 Oct 2018 14:01:57 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: exynos: Move arch-timer node to
 right place
In-reply-to: <20181015123112.9379-6-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7OwtXXzPrS7vY6QIZ2uZafoaLWBaDIowKogXzoAcd7sbO
        tAwiSTDTLnbDtfJSSsGorJk2WzdmWVoq3eyClSSJGqZmNymtbafIf8/7vs/z8j3P99KE/CQV
        SRstDs5uYU0MNYmsb1ysjl3rb9Irro3T+IqzRowHzx0AuHxkNj76roTE7e2XJdjT3SHGT6+f
        prCz/ZYIX7z7RoLHOscpXOs5QeC+4QfkqjDdhfILQOdx76d0nR03KN2ntjaJrrZ6j+7QVTfQ
        jXjmpEi2ZSVlcmw6Z4/mLGnWdKMlQ8Os22RYbVAvVyhjlYk4gYm2sGZOwySvT4ldazQF3slE
        57Cm7EArheV5ZunKJLs128FFZ1p5h4bhbOkmW6ItjmfNfLYlIy7Nal6hVCji1QFialZmSeUD
        0nZnys7mAacoD1wKKwJSGsFlaPijkygCk2g59ALU8b5UIhTfAXrl7RP9Y50o/0oJAx9A7rpq
        MjiQwanox7G3AUzTBJyL7j7JCrYJuBjV+Wr+LnoD0IuuHkLgx6CDeT9DmIQL0evuQiqIqUD/
        du/LEJ4C56HnP7pBEEfAraih4lto0TToAujwwDEQLAjYKkJvbz4PKcLhFtTa4goppFCDHlZ9
        EwVJCP6m0NCtD2LBQzIqHu0kBRyO+u9flQg4CvW4rwBBsA+gL735YqEoAWiopfZvAirUc6ZI
        JLibjAobxyRB0wjKUGGBXIA69MubKnhuBKhm6CxZAma7JsTk+h+Ta0JMlYBwg+mcjTdncHy8
        TTnxAz0gdJYxa7zA2bbeDyANmDAZnNmkl4vZHD7X7AeIJphpMmNVoCVLZ3N3cXarwZ5t4ng/
        UAdSPkJERqRZA0ducRiU6niVSoXVCYkqRSIzQ/Y+qkwvhxmsg8viOBtn/6cT0dLIPFC6ZIG0
        bzv/OKH+8LAoSX/+lPGResPXHcuKZ7X4ZyivH5//MKzzkeRyTspu1yGtukz7uaDNgfMHXP1T
        Fwz6BnC/d1w/uatU2/Au1a/tqt3iWzSoqNiIP/vmpj1b4WtN3vsq8vy9Zs1yDXm0d/NC85dR
        bfFIgTIupum7tJVdnTtuYEg+k1XGEHae/QNcSOJJrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e+xgK7roWPRBn8btCw2zljPavF+WQ+j
        xbzPshaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW/y984/NYvOmqcwWLz+eYHHg
        8Vgzbw2jx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlTFh
        wQmWggP8FSffzmBqYFzH08XIySEhYCIxdd5Xti5GLg4hgZ2MEuvWvWIESfAKCEr8mHyPpYuR
        g4NZQF7iyKVskDCzgLrEpHmLmCHq7zNKXJj+nxWiXkuit+E3M4jNIqAqcetxBxuIzQYU3//i
        BpjNL6AocfXHY0aQmaICERLdJypB5ogIzGKUeN67gg1iwUUmiR/3weYIC4RKTDnYA3XcYUaJ
        5dd6wBKcArYSpxd/Y5rACNSKcOsshFtnIbl1ASPzKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0
        veT83E2MwHjZdlirfwfj4yXxhxgFOBiVeHh3iB2LFmJNLCuuzD3EKMHBrCTCm7kYKMSbklhZ
        lVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoFxr1iEUGb0Nk3dJP18
        jVqlmJC/G6b+ZHp0e+ae2avFtrjGpp3YYaD4bUfWHJ20umOf+WS/+TcFu7pwBszSNFVe+tNx
        T/FG5UcW0of/B2SGTru+a/nrlbmTFGSe1OumL7s1t+L1CZnjon3/r34sCVh4ltOpzHPO8it1
        Jwt4eQt5frO8Fe5aGXlDiaU4I9FQi7moOBEASyu6aZMCAAA=
X-CMS-MailID: 20181017050157epcas2p1ec4292b7bfa2b53a6c67bc2f0e3fc4d6
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017@eucas1p2.samsung.com>
        <20181015123112.9379-6-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> Move ARM architected timer device-tree node to the beginning of 'soc'
> node, to group it together with other ARM CPU core devices (like PMU).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 2131f12364cb..fa20eb3495b3 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -255,6 +255,18 @@
>  			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
>  		};
>  
> +		timer: timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 14
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 11
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> +				<GIC_PPI 10
> +					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
>  		chipid@10000000 {
>  			compatible = "samsung,exynos4210-chipid";
>  			reg = <0x10000000 0x100>;
> @@ -1750,17 +1762,6 @@
>  		};
>  	};
>  
> -	timer: timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 14
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 11
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
> -			<GIC_PPI 10
> -				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> -	};
>  };
>  
>  #include "exynos5433-bus.dtsi"
> 

I tested it on Exynos5433-based TM2 board. It is well working.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
