Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5D3214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V4PDs+9c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQCEiaMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5D3214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeHPITD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:19:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeHPITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:19:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 565C96221A; Thu, 16 Aug 2018 05:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534396992;
        bh=uHMXIJP+m6/O0v2CpnOgKxk/Dmpb2jFAcMQv5SYObCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V4PDs+9cOtznuzhKgCwh1wwMUEthArHuXw5JsyysM7GveidpBpN+xMBhRXZkvtauO
         If3nHKJSPqDJoKaUJCo1dzNTLSytNe1ohpADJpyS2JmjJkASD8UNPJiJtdyFSXP8io
         CUyiDHp7MSekLx1KmtSGzNLqkvvEvlmnlJdn5Sxw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6690D6221A;
        Thu, 16 Aug 2018 05:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534396991;
        bh=uHMXIJP+m6/O0v2CpnOgKxk/Dmpb2jFAcMQv5SYObCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQCEiaMHmP7IMKV3gBVfycJcTX6WSiKIVBh/sVZQRVHhEvcuhO6CGFZrZoDrx6QQ0
         sMJWoIFTaP/Y1WYVhKwDw50tRLj7iW/3iHUF76SUOJaodOZS0y4LCpPYHpWhX1FuBZ
         jf98C6bNYW0oaBRCCFUK6+BRje7JfT03o6Z4msaU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Aug 2018 10:53:11 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
In-Reply-To: <20180807052355.GA23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
 <20180807052355.GA23866@tuxbook-pro>
Message-ID: <897ab82c450bff71658c1fa32e7e6021@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 10:53, Bjorn Andersson wrote:
> On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> [..]
>>  - qcom,num-strings
>>  	Usage:        optional
>>  	Value type:   <u32>
>>  	Definition:   #; number of led strings attached;
>> -		      value from 1 to 3. default: 2
>> -		      This property is supported only for PM8941.
>> +		      value: For PM8941 from 1 to 3.
>> +			     For PMI8998 from 1 to 4.
> [..]
>> +- qcom,enabled-strings
>> +	Usage:        optional
>> +	Value tyoe:   <u32 array>
>> +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
>> +		      string of leds are operated individually. Specify the
>> +		      list of strings used by the device. Any combination of
>> +		      led strings can be used.
> [..]
>> 
>>  Example:
>> 
>> @@ -99,4 +146,5 @@ pm8941-wled@d800 {
>>  	qcom,switching-freq = <1600>;
>>  	qcom,ovp = <29>;
>>  	qcom,num-strings = <2>;
>> +	qcom,enabled-strings = <0x00 0x01>;
> 
> Nit. I would assume that specifying qcom,num-strings = <2> implies that
> the first 2 strings are used, so one would not also specify
> qcom,enabled-strings.
> 
Thanks Bjorn for reviewing the series !

"qcom,enabled-strings" need be specified along with the 
"qcom,num-strings".
Because the enabled-strings can be <0, 2> or <0, 3 > also. The driver 
picks the string
configuration from the enabled-strings array and enable only those 
current-sinks.

> (And you should use decimal for natural numbers)
> 
I will modify it in next series.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
