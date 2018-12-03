Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC82C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85901206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="qgGfcu39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85901206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLCWZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:25:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33341 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLCWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:25:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so8442985qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M9ELRpNt54s+D99mnW5t3T2yNzxglg6NH/jjT3CHMq4=;
        b=qgGfcu39+FXSeAWqr3bCY1gtFAie35JyU6Lr3Ru+m2avZeVOmUvCkH6TzkqIuzXZqv
         edCH9LjmLBr1iub2KeTYTUgIVs9nSpYngrQmBSCUzNHCSNDhyORWFXQeb/MM+XEyH18t
         Tg7mi89ADDsvufSwH1lliXcLlnQQ+gqB3G64hDFd2hcPdw0jOOQETF4GE5pvenO75CVi
         1ekguNimAaIQGM8SEe925X6TXkAIx8RLPrXzHJ4TeztbmTKjdt1OVDQiquGvRb/FGTMQ
         hxNnxYbR4qVumQdlQat1HP5gAgpZq45P3Hh0BsM2TbTi3iEhOK+MQseSV18Rm86m/83E
         IcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M9ELRpNt54s+D99mnW5t3T2yNzxglg6NH/jjT3CHMq4=;
        b=IC6SqXjXiXMgQNPkWikpfL4OjKoVtkiA9/mByfZqg9+TNdtxEzJXBH1DtPxX9iF9QT
         DtQuIsFMCOiROyau06saW5QUNFybi+b9PMq44zjpv6n7p6wPCqesorwWHNd0ORXG7oCH
         GTkPhRO+0IaEseUAQTeypH/L1wx35hM7PjhgH2xV+a9Za06kvbkDlvB7kofl/xu1V5f5
         5+jiksVWGMddGdkBOyl7zZmUosNSfkDOTjKL/tBHSXzIyU07PEJ3ixKJE2YGq+zt8mLX
         kuUNS6wMpdkER1HvukYkKv5G515PITNjhAcNXo+bvfCwXburS35uImjLKyz7taqsQSBT
         ig4g==
X-Gm-Message-State: AA+aEWZRyGGfeWpzWKP9h5FwEIOlaST0lmVnXVlOnee+HK3FgEKG5urF
        d+LMaXayrMW99Bq2TlqXA610Ww==
X-Google-Smtp-Source: AFSGD/VWDdkrYowtduhvgFiEshny3EIsPCsjbhzbDWrje90r13tv4sOMm5KYf2TkXgqhxYYgMAz0PQ==
X-Received: by 2002:a37:d91:: with SMTP id 139mr17009575qkn.26.1543875947561;
        Mon, 03 Dec 2018 14:25:47 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm12916968qkp.65.2018.12.03.14.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:25:47 -0800 (PST)
Subject: Re: [Freedreno] [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To:     freedreno@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, festevam@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chris.Healy@zii.aero,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
 <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
From:   Jonathan marek <jonathan@marek.ca>
Message-ID: <caaa2cfb-6b16-60a6-d679-d8b7437c0d99@marek.ca>
Date:   Mon, 3 Dec 2018 17:23:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 05:10 PM, Jordan Crouse wrote:
> On Mon, Dec 03, 2018 at 04:18:16PM -0500, Jonathan Marek wrote:
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>>   arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
>> index 67d462715..e9a7bbce9 100644
>> --- a/arch/arm/boot/dts/imx51.dtsi
>> +++ b/arch/arm/boot/dts/imx51.dtsi
>> @@ -628,5 +628,22 @@
>>   				clock-names = "ipg", "ahb";
>>   			};
>>   		};
>> +
>> +		gpu: gpu@30000000 {
>> +			compatible = "amd,imageon-200.1", "amd,imageon";
>> +			reg = <0x30000000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <12>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +			clock-names = "core_clk", "mem_iface_clk";
>> +
>> +			qcom,gpu-pwrlevels {
>> +				compatible = "qcom,gpu-pwrlevels";
>> +				qcom,gpu-pwrlevel@0 {
>> +					qcom,gpu-freq = <166250000>;
>> +				};
>> +			};
> 
> There shouldn't be any incremental cost in the source code to use OPP; it should
> just work. And then this won't give us a further reason to keep the legacy
> code around when we decide to dump any pretense of downstream "compatibility".
> 

I will switch to OPP.

>> +		};
>>   	};
>>   };
>> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
>> index 207eb557c..586d45586 100644
>> --- a/arch/arm/boot/dts/imx53.dtsi
>> +++ b/arch/arm/boot/dts/imx53.dtsi
>> @@ -838,5 +838,22 @@
>>   			reg = <0xf8000000 0x20000>;
>>   			clocks = <&clks IMX5_CLK_OCRAM>;
>>   		};
>> +
>> +		gpu: gpu@30000000 {
>> +			compatible = "amd,imageon-200.0", "amd,imageon";
>> +			reg = <0x30000000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <12>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +			clock-names = "core_clk", "mem_iface_clk";
>> +
>> +			qcom,gpu-pwrlevels {
>> +				compatible = "qcom,gpu-pwrlevels";
>> +				qcom,gpu-pwrlevel@0 {
>> +					qcom,gpu-freq = <200000000>;
>> +				};
> 
> Same.
> 
>> +			};
> 
>> +		};
>>   	};
>>   };
>> -- 
>> 2.17.1
> 
