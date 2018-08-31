Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F8FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD220837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6vXZEV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIADAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:00:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37118 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIADAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:00:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so5531328pgo.4;
        Fri, 31 Aug 2018 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3AYMW2DVREEVOGphu6KAAuqbYTyiUUSsIbIQMuT8J0=;
        b=O6vXZEV5WQiS36qBnMZemSOCaSPpspWPDN5bXPE1CedhKQ/njd5Y2QK9MPGSRO3k8d
         FQtZLnXez09+m9J4YJcrCKEEqq6DM1QNYvtw/bfuuiM3q0pa9/2BN+Ol2MUiTRQagXd4
         j+khF6ECpasZQ5bqKZgHsHdV1kjeU5ZKeQygwIamAUuf/4VqA5zqCI0Hp4MFpfGwmpV5
         jpooU4uYHbmCTsDSm0+J0dMHBda7Jh14tFH9hl8mlRVo7OgGlXf0likw5pfGWdknJPES
         ++7Bu7HvjFJSnuCfqSh8oTXf3F5Q4uZ53V+1YWD20bDWlf/x6Hn4Gf/drT2kFT1Qcn0w
         akPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3AYMW2DVREEVOGphu6KAAuqbYTyiUUSsIbIQMuT8J0=;
        b=jJvAHcmzrbi0164NQh0jHRB6MF/GxnLgFxTRzO4pqCVMXnwFw+DttGCH+VhnJBtPen
         PiCfb/kGc6eXZk+VjBq9aimJ2tOTxS64jQJfMXXZLLPlnbuE0f7TUqh4ROyEgD7mMbh1
         NnOVqsBAtfT3/r4aVoBhhV0/6Yg9GbLrZrENw1y6nK4va3ki7ChFWTOPC1GIOe+LFy6k
         tsJQ2fwclAbUMT0/bn5KzoBgizxzPOQO6VWJg71pMqd5t0MuYcmL8kyUD2mryLGVPyrp
         HHPYUw1l3xQ0/t+j8zTeaUUjROtojaMGX6bNCGStpNsn82iw5wj/ZzQngofzV6y4rwAz
         rB3w==
X-Gm-Message-State: APzg51BZy4dYZu1SaVq83/Q9Rbl+V25jnfe7azRWVUgrWMdsEOBVVI7z
        JV7zmAG/RRK3RuMPU5nmpUw=
X-Google-Smtp-Source: ANB0VdZMtZ75gjC+kSe12O6XccSRSQOGc8FAdJaih6oFIFjfuDG2iz9V52h1+rY74Repl41OhVIrmQ==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr16380122pgh.10.1535755830013;
        Fri, 31 Aug 2018 15:50:30 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 77-v6sm16072066pga.40.2018.08.31.15.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:50:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
 <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
Message-ID: <f9b942a2-073d-5f28-81d1-63be02829fef@gmail.com>
Date:   Fri, 31 Aug 2018 15:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The email for Ivan is no longer valid.  Can anyone else help me with
my question?

Thanks,

Frank


On 08/31/18 15:46, Frank Rowand wrote:
> Hi Ivan,
> 
> 
> On 02/03/15 04:17, Ivan T. Ivanov wrote:
>> Add SPMI PMIC Arbiter configuration nodes for APQ8084 and MSM8974.
>>
>> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>> ---
>>  arch/arm/boot/dts/qcom-apq8084.dtsi | 16 ++++++++++++++++
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> index 1f130bc..dbedf64 100644
>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>> @@ -226,5 +226,21 @@
>>  			clock-names = "core", "iface";
>>  			status = "disabled";
>>  		};
>> +
>> +		spmi_bus: spmi@fc4cf000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg-names = "core", "intr", "cnfg";
>> +			reg = <0xfc4cf000 0x1000>,
>> +			      <0xfc4cb000 0x1000>,
>> +			      <0xfc4ca000 0x1000>;
>> +			interrupt-names = "periph_irq";
>> +			interrupts = <0 190 0>;> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index e265ec1..2d11641 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -247,5 +247,21 @@
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  		};
>> +
>> +		spmi_bus: spmi@fc4cf000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg-names = "core", "intr", "cnfg";
>> +			reg = <0xfc4cf000 0x1000>,
>> +			      <0xfc4cb000 0x1000>,
>> +			      <0xfc4ca000 0x1000>;
>> +			interrupt-names = "periph_irq";
> 
>> +			interrupts = <0 190 0>;
> 
> The final value in this interrupts property means IRQ_TYPE_NONE.
> 
> A WARN_ON() was added early this year to complain about use of
> IRQ_TYPE_NONE: 83a86fbb5b56 "irqchip/gic: Loudly complain about
> the use of IRQ_TYPE_NONE", resulting in many warnings spewing
> forth when I boot an APQ8074 Dragonboard.  I am trying to
> determine whether the warning is overly aggressive, or whether
> the IRQ TYPE is incorrectly specified for the spmi node.
> 
> The interrupt-parent for the spmi node is intc: interrupt-controller@f9000000,
> which has compatible = "qcom,msm-qgic2".  I do not know the architecture
> or implementation of this interrupt controller.  Is an IRQ_TYPE_NONE
> valid in this case, or should a specific type be provided?
> 
> Thanks!
> 
> -Frank
> 
> 
>> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>>  	};
>>  };
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> .
> 

