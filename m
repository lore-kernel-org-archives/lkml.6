Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C9520850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VNbjVWpl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VNbjVWpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C9520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeH2JrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:47:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeH2JrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:47:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D288C6053B; Wed, 29 Aug 2018 05:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535521929;
        bh=x12b7IBQCVTDo0nQDS/PvT04cXA7gJzx+zLHbUqc6ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNbjVWplU34OHNNaf27Ns7E8zkGYaDuJJPKxvQV5JBR/z7DeGQ2Hs5rt65/RogN4i
         moiaJu3hlfgDn3QOwtPwZTE9ljlr4Q5sEDZJCYcUAhU6G2q5pEDdX3HBy+ydNgldtR
         8VzdtmM+mk2djhMZvbfnsTdfeRvqBfWK0ekKwZW0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0B2F6603D2;
        Wed, 29 Aug 2018 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535521929;
        bh=x12b7IBQCVTDo0nQDS/PvT04cXA7gJzx+zLHbUqc6ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNbjVWplU34OHNNaf27Ns7E8zkGYaDuJJPKxvQV5JBR/z7DeGQ2Hs5rt65/RogN4i
         moiaJu3hlfgDn3QOwtPwZTE9ljlr4Q5sEDZJCYcUAhU6G2q5pEDdX3HBy+ydNgldtR
         8VzdtmM+mk2djhMZvbfnsTdfeRvqBfWK0ekKwZW0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Aug 2018 11:22:08 +0530
From:   kgunda@codeaurora.org
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
In-Reply-To: <20180827100143.GE31905@amd>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-4-git-send-email-kgunda@codeaurora.org>
 <20180827100143.GE31905@amd>
Message-ID: <a32ac1da9453d45be3f70496fc6fe82b@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 15:31, Pavel Machek wrote:
> Hi!
> 
> On Fri 2018-08-24 15:57:42, Kiran Gunda wrote:
>> Update the bindings with the new properties used for
>> PMI8998.
> 
>> Changes from V3:
>>     - Removed the default values.
> 
> Why?
> 
As per Bjorn's comment I have removed the default values.
Do you want to add them back ?

>> +- qcom,current-limit-microamp
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   uA; per-string current limit; value from 0 to 30000 
>> with
>> +		      2500 uA step.
>> 
>>  - qcom,current-boost-limit
>>  	Usage:        optional
>>  	Value type:   <u32>
>>  	Definition:   mA; boost current limit.
>>  		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
>> -		      1680. Default: 805 mA
>> +		      1680.
>>  		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
>> -		      1500. Default: 970 mA
>> +		      1500.
>> 
> 
> I'd say that optional properties should list default values...?
> 
Same as above.

>>  - qcom,ovp
>>  	Usage:        optional
>>  	Value type:   <u32>
>>  	Definition:   V; Over-voltage protection limit; one of:
>> -		      27, 29, 32, 35. default: 29V
>> +		      27, 29, 32, 35.
>>  		      This property is supported only for PM8941.
>> 
> 
> Same here.
> 
Same as above.
>> +- qcom,ovp-millivolt
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   mV; Over-voltage protection limit;
>> +		      For pmi8998: one of 18100, 19600, 29600, 31100
>> +		      If this property is not specified for PM8941, it
>> +		      falls back to "qcom,ovp" property.
>> +
> 
> "voltage-limit-millivolt"? "ovp" is not really well known acronym.
> 									Pavel
"ovp" is already being used in pm8941-wled.c driver. That's why I am 
using ovp-millivolt.
If I rename this, i think I have to rename the existing "qcom,ovp" also, 
which will break
the backward compatibility.
