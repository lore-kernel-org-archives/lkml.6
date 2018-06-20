Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6507C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5402083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RqyqfC57";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ANiayX3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5402083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeFTFZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:25:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFTFZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:25:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1799160B14; Wed, 20 Jun 2018 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529472327;
        bh=W8jAeDKbneaxNX34v8+FHgiFVvnRbVHyA7on74tDO5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RqyqfC57PszRQcPlnRiWGdFIKYLW4WDCCAVWKq77E8xq9xanE0JZJaSrezpTREqsW
         +vq3Dk+Usj5aJPIwSWIq4cWxVplR2bBOfHGY3WXT3wTSMjXnamPXnU0pnbyCegvQj3
         D/jJyc/n0wUjZNsnyvAUyvfAjJJdtNXRlyn8iBn8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1AA7260714;
        Wed, 20 Jun 2018 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529472326;
        bh=W8jAeDKbneaxNX34v8+FHgiFVvnRbVHyA7on74tDO5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANiayX3aQqS+CRNUObQoxhZ/ZP2Ik6s59zQZCCi6TBCdqTxeMyUAC0xA+Xm+ZVqxX
         Bj/YjKfGCZsSAx+6g6N/CuNxCUVsYgA3TrNeWLlTAFZ+JIhbG47CRU0a0BfiNkp/rR
         8YqTbfIl+ldNopEj7Q14NYTMzft3Os60DjzhG+D4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 10:55:26 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 3/7] backlight: qcom-wled: Add new properties for
 PMI8998
In-Reply-To: <20180619230351.GG15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-4-git-send-email-kgunda@codeaurora.org>
 <20180619230351.GG15126@tuxbook-pro>
Message-ID: <588c8b50ea33d55a179b1d81a9973ff3@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 04:33, Bjorn Andersson wrote:
> On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
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
>> +		      value: For PM8941 from 1 to 3. default: 2
>> +			     For PMI8998 from 1 to 4. default: 4
> [..]
>> +- qcom,enabled-strings
>> +	Usage:        optional
>> +	Value tyoe:   <u32 array>
>> +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
>> +		      string of leds are operated individually. Specify the
>> +		      list of strings used by the device. Any combination of
>> +		      led strings can be used.
>> +		      for pm8941: Default values are [00 01].
>> +		      for pmi8998: Default values are [00 01 02 03].
> 
> I would suggest omitting the defaults, as we can see in several places
> in this document we end up having to update the document with new
> defaults for each platform.
> 
> Also, per the defaults of the optional qcom,num-strings these are
> already the defaults...
> 
Sure. I will remove the defaults in the next series.
> [..]
>> +pmi8998-wled@d800 {
>> +	compatible = "qcom,pmi8998-wled";
>> +	reg = <0xd800 0xd900>;
>> +	label = "backlight";
>> +
>> +	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
>> +		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
>> +	interrupt-names = "short", "ovp";
>> +	qcom,current-limit-microamp = <25000>;
>> +	qcom,current-boost-limit = <805>;
>> +	qcom,switching-freq = <1600>;
>> +	qcom,ovp-millivolt = <29600>;
>> +	qcom,num-strings = <4>;
>> +	qcom,enabled-strings = <0x00 0x01 0x02 0x03>;
> 
> Please omit the pmi8998 example as well, there's no real benefit of
> adding similar examples for each platform.
> 
Sure. I will remove it.
> Regards,
> Bjorn
