Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0417F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KughboVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0417F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeJPBsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:48:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeJPBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:48:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so22415653wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BkSCW1+g0Xa3QWREzCUBVKcJWssmOB39XpykeRBF57E=;
        b=KughboVQri5wJrwFlOoVtKQS7eJinUD4K39X8YcM5qmW2idqeo4QIZkW71Sx0iA4St
         KTMyzGpViP5PR+hjl+9Q8Lk2Fe552ZSBPR+QgbXhMfj+VbVP+byS7LKAi/JyplTmXd1W
         eOq25aX2wlH+CsTtpwrgBW4ptPlT4WS0gP1ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BkSCW1+g0Xa3QWREzCUBVKcJWssmOB39XpykeRBF57E=;
        b=ETpco3x6NOYX3/ziVO7L1QwLT6Xu0x1h6HzTehJgnwCRoOs5+4mjtD6LSOohU5tbci
         +Osa/PoSjjF5fLstSd2ePEloLWu46oSqlnnKJmWGBk6x7lP6HE/VDWEPzFT99diXT6Wb
         79kavw+cyko0t33nptHycAkAxL7MWXPwmQTl7XjKkv3yibEs+n5Mmg1IzN7UuI0D9Jda
         P5+AxHhnzQpxEPcud6MURWcDqGI0cAWmpvkAxQW5HqbdyydAM4Rmutb6TVEsewKpwgVf
         IIniChG0qFBADoeug1TeiRQJNmOf17Mh/LZhcb29VBiwjETs3gwYa2UrTUmrs4YK0hnK
         5+/Q==
X-Gm-Message-State: ABuFfogK/mfewczwy+a3hn4tEH1po/jtaHfDvM2YnIKoDYWm8tjYAZxH
        0q5/4mYfHijv/bVvlFICMuTTnQ==
X-Google-Smtp-Source: ACcGV63h+DFdLhzznk1PQOiidwhQSguHcqRzES39E++tsf1bcLfqSfkJCm0VA84diksg2LJNijs6+g==
X-Received: by 2002:adf:9bcf:: with SMTP id e15-v6mr14527550wrc.240.1539626500972;
        Mon, 15 Oct 2018 11:01:40 -0700 (PDT)
Received: from [192.168.0.40] (85.238.136.77.rev.sfr.net. [77.136.238.85])
        by smtp.googlemail.com with ESMTPSA id c18-v6sm9201983wrr.74.2018.10.15.11.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 11:01:40 -0700 (PDT)
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
To:     Rob Herring <robh@kernel.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/HISILICON SOC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
 <20181015162835.GA20955@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
Date:   Mon, 15 Oct 2018 20:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015162835.GA20955@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

thanks for the review.

On 15/10/2018 18:28, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
>> Add the interrupt names for the sensors, so the code can rely on them
>> instead of dealing with index which are prone to error.
>>
>> The name comes from the Hisilicon documentation found on internet.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  .../bindings/thermal/hisilicon-thermal.txt         |  3 ++
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 63 +++++++++++-----------
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  1 +
>>  3 files changed, 36 insertions(+), 31 deletions(-)
> 
> Lots of whitespace errors reported by checkpatch.pl.

Yeah, I don't know why but I have something bad with my emacs
configuration when changing DT files. Will look at this.

>> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>> index cef716a..3edfae3 100644
>> --- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>> @@ -7,6 +7,7 @@
>>    region.
>>  - interrupt: The interrupt number to the cpu. Defines the interrupt used
>>    by /SOCTHERM/tsensor.
>> +- interrupt-names: The interrupt names for the different sensors
> 
> Need to define what the names are.
> 
>>  - clock-names: Input clock name, should be 'thermal_clk'.
>>  - clocks: phandles for clock specified in "clock-names" property.
>>  - #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>> @@ -18,6 +19,7 @@ for Hi6220:
>>  		compatible = "hisilicon,tsensor";
>>  		reg = <0x0 0xf7030700 0x0 0x1000>;
>>  		interrupts = <0 7 0x4>;
>> +		interrupt-names = "tsensor_intr";
> 
> That name seems pretty pointless.
> 
>>  		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
>>  		clock-names = "thermal_clk";
>>  		#thermal-sensor-cells = <1>;
>> @@ -28,5 +30,6 @@ for Hi3660:
>>  		compatible = "hisilicon,hi3660-tsensor";
>>  		reg = <0x0 0xfff30000 0x0 0x1000>;
>>  		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "tsensor_a73";
> 
> Just 'a73' is sufficient.

This is the name defined in the board documentation to give a name to
the interrupt when requesting it. This one appears in /proc/interrupts.

I can replace the 'tsensor_intr' by 'tsensor', but if 'tsensor_a73' is
replaced by 'a73' that may looks odd in /proc/interrupts to see an
interrupts line with the 'a73' name.

However this is the preparation for the multiple sensors support so we
will have more interrupt names.

Is it possible to keep these names ?

 - tsensor
 - tsensor_a73
 - tsensor_a57
 - tsensor_gpu




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

