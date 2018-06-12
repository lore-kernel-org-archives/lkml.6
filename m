Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCAC2C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CF9208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hAzKIX9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CF9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeFLA12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:27:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42385 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933673AbeFLA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:27:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so22146769qty.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=egsupfA1ocbvg8rTuYslCHSkWDE6kC5b+LryDisOgtM=;
        b=hAzKIX9nwEKUKTmtOtshfYo6Jb0Gpgw+E1YvGF/bErI+ob8UNj2mLJfMwCpuSXsoSO
         r1CFbySDgW/dT1J7MVebpa6Mkz09Dbgser6UB2R0HoRcdeIfWis3Piwyc6Gm+AP3N9aM
         DGmF9hme1g1HWhHLRDrO8OlYex4HLyrWUVsu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egsupfA1ocbvg8rTuYslCHSkWDE6kC5b+LryDisOgtM=;
        b=t2gZ4fX7PcecgsYfVhwRt/kFMFCuekrhY3UVADpi9bTbxwm6bAoISk0BCickIqv9E5
         hhFmAMzlUDW76+SMhQJuwmdLDmnMtJbS4KW7KNG+0+ue4X7fFWmKDZUNppZhwoXDxIis
         OSeo5UsKTSkGgf2URbUdQZe4TuRW+DeKnL0uH3I3lpRs9Fzu+bsLE08Yv90bPijqDyXB
         iMoJW7IQAt2CwiE30/aTXUFykLIt/18V5+ugok10qfFZ3iKMY+uVbQWnwok/0ez7GGoE
         C1ni2nwrVCJaR/KZg/Gax77RlOfRcxPZOrUFqf2zITc5xUWOfGhWwbIhZSNLX6Sn6IuP
         pDlw==
X-Gm-Message-State: APt69E3Eg1y0W0u+GjE8ydTh/EKn6nPAnLBzY2PyGthVydLk2+btruD5
        W9w4/q2cdDZUL/b8p00Bd1j1Uw==
X-Google-Smtp-Source: ADUXVKLYQ4knrwwJPje6eFRVcxIumXgh48Ci5xXY88T1vebN8o0YtZ8jBnuAzM0xKQS3LYnE6l2dyQ==
X-Received: by 2002:a0c:9621:: with SMTP id 30-v6mr1333129qvx.127.1528763244970;
        Mon, 11 Jun 2018 17:27:24 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l25-v6sm17364516qkk.49.2018.06.11.17.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:27:23 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
 <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
Date:   Mon, 11 Jun 2018 17:27:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2018 3:36 PM, Florian Fainelli wrote:
> On 05/29/2018 02:58 PM, Ray Jui wrote:
>> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
>> IRQ domain of the iProc PCIe controller itself
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 699fdf9..6de21ef 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -254,9 +254,14 @@
>>   			compatible = "brcm,iproc-pcie";
>>   			reg = <0x18012000 0x1000>;
>>   
>> +			interrupt-controller;
>>   			#interrupt-cells = <1>;
>> -			interrupt-map-mask = <0 0 0 0>;
>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie0 1>,
>> +					<0 0 0 2 &pcie0 2>,
>> +					<0 0 0 3 &pcie0 3>,
>> +					<0 0 0 4 &pcie0 4>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
> 
> You would want to fix those IRQ_TYPE_NONE values as well because since
> commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
> complain about the use of IRQ_TYPE_NONE") this is going to create some
> nice warnings on boot.
> 
> I am about to send fixes for NSP and HR2 since that's what I have access
> to at the moment, but it would be good if you could send updates to the
> Cygnus and NS2 DTS files?
> 
> Thanks
> 

Okay. Thanks for letting me know. How do you want this to be done for 
Cygnus and NS2?

I guess I should have the fix patches to DTS done and sent out first, 
and then rebase this INTx patch series against the patches with the fix.

Does that make sense to you?

Thanks,

Ray

>>   
>>   			linux,pci-domain = <0>;
>>   
>> @@ -289,9 +294,14 @@
>>   			compatible = "brcm,iproc-pcie";
>>   			reg = <0x18013000 0x1000>;
>>   
>> +			interrupt-controller;
>>   			#interrupt-cells = <1>;
>> -			interrupt-map-mask = <0 0 0 0>;
>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie1 1>,
>> +					<0 0 0 2 &pcie1 2>,
>> +					<0 0 0 3 &pcie1 3>,
>> +					<0 0 0 4 &pcie1 4>;
>> +			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>   
>>   			linux,pci-domain = <1>;
>>   
>>
> 
> 
