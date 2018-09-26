Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A5204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3E98ykd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9A5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeIZPCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:02:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41301 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:02:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so1158826edd.8;
        Wed, 26 Sep 2018 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTCeSqjBT3qZwJM4pZfg88xjzOAMDrkM9nA3EC0uYB8=;
        b=O3E98ykdvik0MpFzgHkr+56RKYotl8CRRzY9xRwGwyDzOsGJteEW9y9unCNJ8WJKDn
         QiErtSg7pyZwtW9DPvpQVKDjF8W0O+4e8TwDoSaFRgdq3X/yv7ZlyKEeeJPXy9gz3eJD
         s/MZiU4W7ic1RgK+nIURlCGi/Voycicr4x2A0zNdKr0n3y4UTzW6VSS1vCSFBTVM8ORR
         c8eBcB8aMS/fH0+oUPauP5++qi1bsfkkcZpHlEyYv9cM2jNfPhRKwArjPh2Y7qU0zLix
         zyGv2+GDkvQL6H6z06YN8+g05lL5CVVze+i+mmxLTyHBx4v6feFq+T/R0m7mXhwPC7MQ
         Oxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fTCeSqjBT3qZwJM4pZfg88xjzOAMDrkM9nA3EC0uYB8=;
        b=KNi65vVxPBAVtiopwKyQWJjKLzNW50QGEvcwrpYhualMtj/obpqoScUvm5+aeXmTjj
         /83CVfWcA8rw+9r0OwOWYUqIQ4+97hIEUQaGF+VsSCQFIkx1UJ3Qz4ge0NsR/U2dJg93
         yXrwA1x1b2s0XT0+KbQk2MGge5b9SXjLtJv0Ey2Dqjh5wJrpmjruOupAenhB7k6kcYMI
         yNaROZqKRhZ905llIotVMvihR80p3hcQeU3W4SlstT0yIL8iY376w/q7TnBCcCwAH8ql
         GhcX5ZSjdZK/vN2Zfb9P8O1f37xrcLjejtWkmu/GybjSvqqcbpMK36svC6wNz0/6wZAm
         Pq8w==
X-Gm-Message-State: ABuFfojqUUMqIvy2YTBm8jOAHbDHMwrra+cTv5W6uk5jQUMDpbf+R4q+
        ODAN0oAJnofU/WqcMm4tTnI=
X-Google-Smtp-Source: ACcGV63J1YEuhheGM/GeDyKdPYEeJ+uODiM5Jh6fcwBqP3BI7ycj1sxeiGn74kaAKzVe4vdelKEvtQ==
X-Received: by 2002:aa7:c485:: with SMTP id m5-v6mr8109767edq.205.1537951816180;
        Wed, 26 Sep 2018 01:50:16 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id e25-v6sm7628644edd.35.2018.09.26.01.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:50:15 -0700 (PDT)
Subject: Re: [Resend PATCH 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
To:     CK Hu <ck.hu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        chunhui dai <chunhui.dai@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536155449.git.ryder.lee@mediatek.com>
 <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
 <1537925879.20118.3.camel@mtksdaap41> <1537929498.32631.16.camel@mtkswgap22>
 <1537939280.20005.19.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <67eb0b9c-f2a3-a9c4-202f-d3c64b6a2b3e@gmail.com>
Date:   Wed, 26 Sep 2018 10:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537939280.20005.19.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2018 07:21, CK Hu wrote:
> Hi, Ryder:
> 
> On Wed, 2018-09-26 at 10:38 +0800, Ryder Lee wrote:
>> On Wed, 2018-09-26 at 09:37 +0800, CK Hu wrote:
>>> Hi, Ryder:
>>>
>>> On Wed, 2018-09-05 at 22:09 +0800, Ryder Lee wrote:
>>>> Add display subsystem related device nodes for MT7623.
>>>>
>>>> Cc: CK Hu <ck.hu@mediatek.com>
>>>> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
>>>> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
>>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>>> ---
>>>> I forgot to sort nodes in my previous mail. Sorry for the inconvenience.
>>>>
>>>> This patch depends on the series: https://lkml.org/lkml/2018/9/5/223
>>>>
>>>> @Matthias,
>>>> I know you're working on broken MMSYS - just want to ask whether it's possible
>>>> to let the patch to go to your tree (if others are okay with it), and send a
>>>> fixup one for MT7623 MMSYS later?
>>>> ---
>>>>  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++++++++++
>>>>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  83 ++++++++++++
>>>>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  83 ++++++++++++
>>>>  3 files changed, 343 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
>>>> index d01bdee..fdf9078 100644
>>>> --- a/arch/arm/boot/dts/mt7623.dtsi
>>>> +++ b/arch/arm/boot/dts/mt7623.dtsi
>>>> @@ -23,6 +23,11 @@
>>>>  	#address-cells = <2>;
>>>>  	#size-cells = <2>;
>>>>  
>>>> +	aliases {
>>>> +		rdma0 = &rdma0;
>>>> +		rdma1 = &rdma1;
>>>> +	};
>>>> +
>>>>  	cpu_opp_table: opp-table {
>>>>  		compatible = "operating-points-v2";
>>>>  		opp-shared;
>>>> @@ -311,6 +316,25 @@
>>>>  		clock-names = "spi", "wrap";
>>>>  	};
>>>>  
>>>> +	mipi_tx0: mipi-dphy@10010000 {
>>>> +		compatible = "mediatek,mt7623-mipi-tx",
>>>> +			     "mediatek,mt2701-mipi-tx";
>>>> +		reg = <0 0x10010000 0 0x90>;
>>>> +		clocks = <&clk26m>;
>>>> +		clock-output-names = "mipi_tx0_pll";
>>>> +		#clock-cells = <0>;
>>>> +		#phy-cells = <0>;
>>>> +	};
>>>> +
>>>> +	cec: cec@10012000 {
>>>> +		compatible = "mediatek,mt7623-cec",
>>>> +			     "mediatek,mt8173-cec";
>>>> +		reg = <0 0x10012000 0 0xbc>;
>>>> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
>>>> +		clocks = <&infracfg CLK_INFRA_CEC>;
>>>> +		status = "disabled";
>>>> +	};
>>>> +
>>>>  	cir: cir@10013000 {
>>>>  		compatible = "mediatek,mt7623-cir";
>>>>  		reg = <0 0x10013000 0 0x1000>;
>>>> @@ -359,6 +383,18 @@
>>>>  		#clock-cells = <1>;
>>>>  	};
>>>>  
>>>> +	hdmi_phy: phy@10209100 {
>>>> +		compatible = "mediatek,mt7623-hdmi-phy",
>>>> +			     "mediatek,mt2701-hdmi-phy";
>>>> +		reg = <0 0x10209100 0 0x24>;
>>>> +		clocks = <&apmixedsys CLK_APMIXED_HDMI_REF>;
>>>> +		clock-names = "pll_ref";
>>>> +		clock-output-names = "hdmitx_dig_cts";
>>>> +		#clock-cells = <0>;
>>>> +		#phy-cells = <0>;
>>>> +		status = "disabled";
>>>> +	};
>>>> +
>>>>  	rng: rng@1020f000 {
>>>>  		compatible = "mediatek,mt7623-rng";
>>>>  		reg = <0 0x1020f000 0 0x1000>;
>>>> @@ -558,6 +594,16 @@
>>>>  		status = "disabled";
>>>>  	};
>>>>  
>>>> +	hdmiddc0: i2c@11013000 {
>>>> +		compatible = "mediatek,mt7623-hdmi-ddc",
>>>> +			     "mediatek,mt8173-hdmi-ddc";
>>>> +		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
>>>> +		reg = <0 0x11013000 0 0x1C>;
>>>> +		clocks = <&pericfg CLK_PERI_I2C3>;
>>>> +		clock-names = "ddc-i2c";
>>>> +		status = "disabled";
>>>> +	};
>>>> +
>>>>  	nor_flash: spi@11014000 {
>>>>  		compatible = "mediatek,mt7623-nor",
>>>>  			     "mediatek,mt8173-nor";
>>>> @@ -732,6 +778,84 @@
>>>>  		#clock-cells = <1>;
>>>>  	};
>>>>  
>>>> +	display_components: dispsys@14000000 {
>>>> +		compatible = "mediatek,mt7623-mmsys",
>>>
>>> Checkpatch warning:
>>>
>>> WARNING: DT compatible string "mediatek,mt7623-mmsys" appears
>>> un-documented -- check ./Documentation/devicetree/bindings/
>>> #101: FILE: arch/arm/boot/dts/mt7623.dtsi:782:
>>> +               compatible = "mediatek,mt7623-mmsys",
>>>
>>>
>>>> +			     "mediatek,mt2701-mmsys";
>>>> +		reg = <0 0x14000000 0 0x1000>;
>>>> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>>>> +	};
>>>> +
>>>> +	ovl@14007000 {
>>>> +		compatible = "mediatek,mt7623-disp-ovl",
>>>
>>> I think this is also un-documented, but I don't know why checkpatch does
>>> not show any warning.
>>>
>>> Regards,
>>> CK
>>>> +			     "mediatek,mt2701-disp-ovl";
>>>> +		reg = <0 0x14007000 0 0x1000>;
>>>> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
>>>> +		clocks = <&mmsys CLK_MM_DISP_OVL>;
>>>> +		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
>>>> +		mediatek,larb = <&larb0>;
>>>> +	};
>>>> +
>>
>> I fallback to use the MT2701's compatible string here and there, but I
>> could add a new one for MT7623.
>>
>> BTW, I've had this question for a long time - should I add a new
>> compatible for the very same IPs, or could we just use the old one in
>> DTS?
>>
>> Ryder
>>
> 
> From [1], there is a description for the multiple compatible string
> scheme:
> 
> ====
> The reasoning behind this scheme is the observation that in the majority
> of cases, a single machine_desc can support a large number of boards
> if they all use the same SoC, or same family of SoCs.  However,
> invariably there will be some exceptions where a specific board will
> require special setup code that is not useful in the generic case.
> Special cases could be handled by explicitly checking for the
> troublesome board(s) in generic setup code, but doing so very quickly
> becomes ugly and/or unmaintainable if it is more than just a couple of
> cases.
> 
> Instead, the compatible list allows a generic machine_desc to provide
> support for a wide common set of boards by specifying "less
> compatible" values in the dt_compat list.  In the example above,
> generic board support can claim compatibility with "ti,omap3" or
> "ti,omap3450".  If a bug was discovered on the original beagleboard
> that required special workaround code during early boot, then a new
> machine_desc could be added which implements the workarounds and only
> matches on "ti,omap3-beagleboard".
> ====
> 
> I don't know would there be a problem happened only in MT7623 even
> though this hardware is identical in both MT2701 and MT7623. Maybe the
> system-wide configuration would influence this driver. So the easy way
> is to add the compatible string for MT7623. If you could prove that 
> this driver would never be influenced by system-wide configuration,
> using only MT2701 compatible string is acceptable for me.
> 
> This is my opinion, but the most important is maintainer's opinion.
> 

The compatible string looks good. But you should update the binding documentation :)

Regards,
Matthias
