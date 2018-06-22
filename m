Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662DCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634D2406C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="szYLWVnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1634D2406C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeFVKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:39:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35670 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFVKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:39:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180622103912euoutp022003faa0329a66c86a8e5aaee6927db6~6dUKuH-2G1702117021euoutp02M
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:39:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180622103912euoutp022003faa0329a66c86a8e5aaee6927db6~6dUKuH-2G1702117021euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529663952;
        bh=0PFy5QxzosU1mFPQ2E5wI8/kLXaC1THIVpB7us+teVA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=szYLWVnKC0t9VOQD/9gTUDbzP1JvyEH6HIXDW08PKIRmpZ5bH0UOtwf/qa9tVRpDN
         th3Pbakhad1lYUFbJ+KjE7RZd/KNu0fu/tOqwv6yEDj83aE/uUuXItGtls63ro1BTu
         vISXN0WCZ4RA3/HfGPBZpiyz23uVtPvQgHHTJorM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180622103911eucas1p25c5afd7ac844ffb52451c7d623e11aab~6dUJb-zMb1883618836eucas1p2g;
        Fri, 22 Jun 2018 10:39:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 74.EE.05700.EC1DC2B5; Fri, 22
        Jun 2018 11:39:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180622103910eucas1p239a4f8545b3ef340fe5d0a8b954c48ac~6dUIg5f5F1882718827eucas1p2e;
        Fri, 22 Jun 2018 10:39:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180622103910eusmtrp10116a89b1c3317ffa8600ea876426d57~6dUIOzBok0643806438eusmtrp1R;
        Fri, 22 Jun 2018 10:39:10 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-b5-5b2cd1ce1572
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.BA.04183.DC1DC2B5; Fri, 22
        Jun 2018 11:39:09 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180622103909eusmtip14669b9a4db8a144708c6e3ed06f2782e~6dUHqvNN91176111761eusmtip1a;
        Fri, 22 Jun 2018 10:39:09 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] arm64: dts: exynos: add OF graph between USB-PHY
 and MUIC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Fri, 22 Jun 2018 12:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620182844.5nmlj5djbjgwy3wn@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXeujjaO8/amUTmSskxTuhxURMVgCFJfIlEolx6c5KbtOM0w
        M1NxYqZTmE5N2bxhirl5y1BJRStxUyusqEy8hWDQVCJKze0Y+e33/J/r/+UlEdEM5k4mKdIY
        pUKaLMb5aM/YL/Np87RP7BnNznm6s7IDo8cKFgl6dmMFo+tGzRj9wNCB05q5UpS2WJ4StLqs
        gaDf9NfgdKVlkEfrm/IRun30M0E3zk7z6PyBUSJUKGl73AYk1YVVmMTYqsYlQ7VthKSkqxVI
        1o2HL+Mx/OAEJjkpnVH6hcTxZSatmpdaL7q9ZJLkAK2wCDiQkDoLJ8sqiCLAJ0VUC4CD34r2
        gg0Ay83LOBesA/j72SavCJD2lgGDnNObARwx9vO4YA3APxUrmG2uE3UVDs11IjZ2przh7NZP
        zFaEUN9R2N63YC/CdxNbpg+4jVHKC85/abI3uFDRsLPUamcB5QhfVS2iNnagaFgyY+DZGKGO
        wN61GoRjN/hxsc5+BaR+EPDT82KMa06HmupNlHMaAZdmjXvsBFfHuwiOD8GJ8uI9/R7MrXqL
        cIMKAXxpaMa5RBAcGZ/GbP6R3as7+v04OQx+XanbexYhfL/myN0jhJoeLcLJAlhYIOKqPeHc
        ZDfCsRtsnNrES4FYt8+lbp8z3T5nuv976wHaCtwYFStPZFh/BZPhy0rlrEqR6BufIjeC3Z82
        sT1u7QObMzeGAUUC8QFBdMupWBEmTWcz5cMAkojYWSC/5BMrEiRIM+8wypTrSlUyww4DDxIV
        uwmunciOEVGJ0jTmJsOkMsp/WR7p4J4DDP0H63Re3rk5C7LoLO0TvGm+MFIf9MhVlXf8ltba
        VT8oi9c4pUYepTISVO+i1CGW+fsuO4rA6LvLppGw8G6pMaLWo6QssuEhXz/onUXGrmbmWbfN
        V2qi1i/mBgUE9FojS4Nfr78IdQ1kA48Jz1Xqs9VhF1SWOU/HKXF4bXWcGGVlUv+TiJKV/gU8
        YG4nZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7pnL+pEG3zaYG2xccZ6VotjbU/Y
        La5/ec5qMf/IOVaL5sXr2Swm3Z/AYnH+/AZ2i86JS9gtLu+aw2Yx4/w+JotFy1qZLdYeuctu
        sfT6RSaL1r1H2B34PNbMW8PoMbtjJqvHplWdbB77565h9+jbsorR4/MmuQC2KD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MzdM7mQoWCFU83ezR
        wDidr4uRg0NCwERi7+LcLkYuDiGBpYwS+75dZ+1i5ASKi0vsnv+WGcIWlvhzrYsNoug1o0TL
        oSNgRcIC4RL7728EKxIR0JS4/vc7K0gRs8AHFol7H44wQnS8ZJR48mwJE0gVG1DV38032UBs
        XgE7if1H2sG6WQRUJR7eWwZmiwpESDTNW8MOUSMocXLmExYQm1PAQqLv0mKwOcwC6hJ/5l1i
        hrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnp
        esn5uZsYgVG87djPLTsYu94FH2IU4GBU4uGNWKEdLcSaWFZcmXuIUYKDWUmEN9dfJ1qINyWx
        siq1KD++qDQntfgQoynQcxOZpUST84EJJq8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6Yklq
        dmpqQWoRTB8TB6dUAyPTDgMmDZ/EuZovl6Q+evb11ScfAa7FIRZlS9ZX56l1/Eti+69VGx8+
        N3xmqtCmLL6TXP36BoklUlH8Egk7TJx+qf+xmDWDccbXZ6+yLFdMP2peIDZ9SXzJlMv1ix6o
        JUYcd72tf+zu5f/20w4ZHhT5NDO+756evmDe8fotjFXbVOZ/Dz33PFKJpTgj0VCLuag4EQCF
        PScJ+AIAAA==
Message-Id: <20180622103910eucas1p239a4f8545b3ef340fe5d0a8b954c48ac~6dUIg5f5F1882718827eucas1p2e@eucas1p2.samsung.com>
X-CMS-MailID: 20180622103910eucas1p239a4f8545b3ef340fe5d0a8b954c48ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe
References: <20180515121239.18192-1-a.hajda@samsung.com>
        <CGME20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe@eucas1p1.samsung.com>
        <20180515121239.18192-3-a.hajda@samsung.com>
        <20180620182844.5nmlj5djbjgwy3wn@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.2018 20:28, Krzysztof Kozlowski wrote:
> On Tue, May 15, 2018 at 02:12:39PM +0200, Andrzej Hajda wrote:
>> OF graph describes USB data lanes between USB-PHY and respective MUIC.
>> Since graph is present and DWC driver can use it to get extcon, obsolete
>> extcon property can be removed.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
> dtc W=1 now complains with:
> ===
> Warning (graph_child_address):
> /soc/hsi2c@14d90000/max77843@66/max77843-muic/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> ===
>
> Do you plan to add more ports soon?

There could be a link between UART and MUIC, it could be beneficial for
the platform - there is no point to feed UART with data when UART output
is muxed-out by MUIC.
So I plan to investigate it but this is not on my short list :)
Alternatively one can create graphs without using it atm.

Regards
Andrzej

>
> Best regards,
> Krzysztof
>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> index 03453b822093..042e5894a138 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> @@ -868,6 +868,18 @@
>>  					};
>>  				};
>>  			};
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +					muic_to_usb: endpoint {
>> +						remote-endpoint = <&usb_to_muic>;
>> +					};
>> +				};
>> +			};
>>  		};
>>  
>>  		regulators {
>> @@ -1287,12 +1299,17 @@
>>  
>>  &usbdrd_dwc3 {
>>  	dr_mode = "otg";
>> -	extcon = <&muic>;
>>  };
>>  
>>  &usbdrd30_phy {
>>  	vbus-supply = <&safeout1_reg>;
>>  	status = "okay";
>> +
>> +	port {
>> +		usb_to_muic: endpoint {
>> +			remote-endpoint = <&muic_to_usb>;
>> +		};
>> +	};
>>  };
>>  
>>  &xxti {
>> -- 
>> 2.17.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

