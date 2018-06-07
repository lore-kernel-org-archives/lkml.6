Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r30LIv5+GVt5cwAAmS7hNA
	; Thu, 07 Jun 2018 18:53:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A4F1608BF; Thu,  7 Jun 2018 18:53:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ENRNd6j1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 764AD606DD;
	Thu,  7 Jun 2018 18:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 764AD606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeFGSx2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:53:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46284 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753591AbeFGSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:53:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so10926259qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=asaZvDqz8zPNnH/25ReSQRWMQ3ZDFxwlDO8popdxW4w=;
        b=ENRNd6j1ty7II8h14zGCdG5wnVDVD7sd7FYYKd9j8zdRDGBo4JnH9sQ0H7ti2kmvPv
         2D20habUT4Xa8o2vIScOco8iCUru4ViWc9r+93Fph4mKm8VYZznzkI4P7Jz4y8DgZ0kE
         DUWwxEIqwzwxvH7730xf757UbbKlfdhQf+97I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=asaZvDqz8zPNnH/25ReSQRWMQ3ZDFxwlDO8popdxW4w=;
        b=iJ7cN/iwaxnrcFq8qoVesJqIeXGDCadhUFY55cVfTFtRxKvz7BwpIi9Z6j+nQz4eq0
         muWzMxCtYDpxKCfGkXLUH/uZy04YbhYJtiNHSzfpJlD+XCkh1D10n9EkMuaKCRUTAb7k
         +3Eqjugfyd/AfddojPwGZ+l5QDL60i2qP25KNwcfP5kYo8qq4xI8bVm6F6mLGep/3ra1
         td8f1UKs167ekd26PFE5oPoXUEhJhi8dVEpylVR1a7bpkXN65wX2hU5AL7TqRLp+1iiv
         kQHbulxl9jZOaOI5PiArWy4gH6PprNlWotPNNToIHD+Q53G+L3HapfwdK79vDxeIbMvJ
         4fbA==
X-Gm-Message-State: APt69E3OnUOuTzTGMwgpjZvhHsbmY9Yk6CVhQARMuu6yH3gTgoWKKmO1
        0rFvb36O9TyHSrY7jMmeJUbzcyUk
X-Google-Smtp-Source: ADUXVKJ/u9Me3DwVgx1MF8MqB2hHta3tTy12bgQspFvnYUn3/J9R2hiF8KLn1JAMoz2tIJzzdEoKQw==
X-Received: by 2002:ac8:2779:: with SMTP id h54-v6mr2886672qth.85.1528397603240;
        Thu, 07 Jun 2018 11:53:23 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u22-v6sm27894900qtk.18.2018.06.07.11.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:53:22 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
Date: Thu, 7 Jun 2018 11:53:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Could you please kindly comment on change below.

It allows board variants to be added easily via a simple define for 
different number of SATA ports.


On 18-06-04 09:22 AM, Florian Fainelli wrote:
> On 05/18/2018 11:34 AM, Scott Branden wrote:
>> Move remaining sata configuration to stingray-sata.dtsi and enable
>> ports based on NUM_SATA defined.
>> Now, all that needs to be done is define NUM_SATA per board.
> Rob could you review this and let us know if this approach is okay or
> not? Thank you!
>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 64 --------------------
>>   .../boot/dts/broadcom/stingray/bcm958742k.dts      |  2 +
>>   .../boot/dts/broadcom/stingray/bcm958742t.dts      |  2 +
>>   .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 68 ++++++++++++++++++++++
>>   4 files changed, 72 insertions(+), 64 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> index 8862ec9..cacc25e 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> @@ -72,70 +72,6 @@
>>   	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>>   };
>>   
>> -&sata0 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy0{
>> -	status = "okay";
>> -};
>> -
>> -&sata1 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy1{
>> -	status = "okay";
>> -};
>> -
>> -&sata2 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy2{
>> -	status = "okay";
>> -};
>> -
>> -&sata3 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy3{
>> -	status = "okay";
>> -};
>> -
>> -&sata4 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy4{
>> -	status = "okay";
>> -};
>> -
>> -&sata5 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy5{
>> -	status = "okay";
>> -};
>> -
>> -&sata6 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy6{
>> -	status = "okay";
>> -};
>> -
>> -&sata7 {
>> -	status = "okay";
>> -};
>> -
>> -&sata_phy7{
>> -	status = "okay";
>> -};
>> -
>>   &mdio_mux_iproc {
>>   	mdio@10 {
>>   		gphy0: eth-phy@10 {
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
>> index 77efa28..a515346 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
>> @@ -32,6 +32,8 @@
>>   
>>   /dts-v1/;
>>   
>> +#define NUM_SATA	8
>> +
>>   #include "bcm958742-base.dtsi"
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
>> index 5084b03..6a4d19e 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
>> @@ -32,6 +32,8 @@
>>   
>>   /dts-v1/;
>>   
>> +#define NUM_SATA	8
>> +
>>   #include "bcm958742-base.dtsi"
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>> index 8c68e0c..7f6d176 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>> @@ -43,7 +43,11 @@
>>   			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 0)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata0_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -58,7 +62,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 0)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata0_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -73,7 +81,11 @@
>>   			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 1)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata1_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -88,7 +100,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 1)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata1_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -103,7 +119,11 @@
>>   			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 2)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata2_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -118,7 +138,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 2)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata2_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -133,7 +157,11 @@
>>   			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 3)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata3_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -148,7 +176,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 3)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata3_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -163,7 +195,11 @@
>>   			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 4)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata4_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -178,7 +214,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 4)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata4_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -193,7 +233,11 @@
>>   			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 5)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata5_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -208,7 +252,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 5)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata5_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -223,7 +271,11 @@
>>   			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 6)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata6_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -238,7 +290,11 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 6)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata6_phy0: sata-phy@0 {
>>   				reg = <0>;
>> @@ -253,7 +309,11 @@
>>   			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 7)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata7_port0: sata-port@0 {
>>   				reg = <0>;
>> @@ -268,11 +328,19 @@
>>   			reg-names = "phy";
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>> +#if (NUM_SATA > 7)
>> +			status = "okay";
>> +#else
>>   			status = "disabled";
>> +#endif
>>   
>>   			sata7_phy0: sata-phy@0 {
>>   				reg = <0>;
>>   				#phy-cells = <0>;
>>   			};
>>   		};
>> +
>> +#if (NUM_SATA > 8)
>> +#error "NUM_SATA > 8"
>> +#endif
>>   	};
>>
>
