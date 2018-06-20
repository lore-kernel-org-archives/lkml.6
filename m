Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1ACC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D313A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TPfsVoPu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mFqwfZIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D313A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFTFX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:23:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeFTFXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:23:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1672C602BA; Wed, 20 Jun 2018 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529472201;
        bh=9PH+xSyDFOgr7Cdzt/AF5StCSO5xtwngt5+6KgmGMqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPfsVoPuEkfKN/IFJu5I8iHFG348Jc/vKqICQ1r84/vV2TV3Or0Cf7wSC9jSxQXsq
         ucCBQHMqydYTBrEIWviTNtxfvaopBFYjrzXpkMlZLrJzIkYOZt/fUTPZyw1CLAkkS3
         lvzfWimCp9EbtsHOsF5Ot3uJyZmvDKLUexD4EkpU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0917F602BA;
        Wed, 20 Jun 2018 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529472200;
        bh=9PH+xSyDFOgr7Cdzt/AF5StCSO5xtwngt5+6KgmGMqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mFqwfZIvt/AALc0dX5slWS6HAwni629eQEnWohODsOdkjvkE+pc7xJJyh4KwXzomn
         SYhP5KTHcMzMvOYB5tP0fDQOPzpdYlPZWURTowlaDP6pQsMRuh+svrr3wQ8RamWLoZ
         ytNl8/OtaQQUK9UptcDBGnsAe5OjMX8a1EcXJ8/0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 10:53:19 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 1/7] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
In-Reply-To: <20180619225421.GE15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
 <20180619225421.GE15126@tuxbook-pro>
Message-ID: <b3e66f817d919b3b8a8330e7c6827ce2@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 04:24, Bjorn Andersson wrote:
> On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
> 
>> pm8941-wled.c driver is supporting the WLED peripheral
>> on pm8941. Rename it to qcom-wled.c so that it can support
>> WLED on multiple PMICs.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> 
> Please carry any tags acquired when reposting patches without changes
> and please add a "Changes since v???:" list below the --- to expedite
> the review process.
> 
> 
> This is still
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 
Thanks Bjorn for reviewing. Sure I will keep the tags when re-posting.
I have mentioned the consolidated changes in the 0th patch. Anyways,
I will keep it for individual patches from next time.
>> ---
>>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 
>> +-
>>  drivers/video/backlight/Kconfig                                   | 8 
>> ++++----
>>  drivers/video/backlight/Makefile                                  | 2 
>> +-
>>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>>  4 files changed, 6 insertions(+), 6 deletions(-)
>>  rename 
>> Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => 
>> qcom-wled.txt} (95%)
>>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> similarity index 95%
>> rename from 
>> Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
>> rename to 
>> Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> index e5b294d..fb39e32 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> @@ -1,4 +1,4 @@
>> -Binding for Qualcomm PM8941 WLED driver
>> +Binding for Qualcomm Technologies, Inc. WLED driver
>> 
>>  Required properties:
>>  - compatible: should be "qcom,pm8941-wled"
>> diff --git a/drivers/video/backlight/Kconfig 
>> b/drivers/video/backlight/Kconfig
>> index 4e1d2ad..8c095e3 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -299,12 +299,12 @@ config BACKLIGHT_TOSA
>>  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>>  	  for its backlight
>> 
>> -config BACKLIGHT_PM8941_WLED
>> -	tristate "Qualcomm PM8941 WLED Driver"
>> +config BACKLIGHT_QCOM_WLED
>> +	tristate "Qualcomm PMIC WLED Driver"
>>  	select REGMAP
>>  	help
>> -	  If you have the Qualcomm PM8941, say Y to enable a driver for the
>> -	  WLED block.
>> +	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>> +	  WLED block. Currently it supports PM8941 and PMI8998.
>> 
>>  config BACKLIGHT_SAHARA
>>  	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
>> diff --git a/drivers/video/backlight/Makefile 
>> b/drivers/video/backlight/Makefile
>> index 5e28f01..6fd76ef 100644
>> --- a/drivers/video/backlight/Makefile
>> +++ b/drivers/video/backlight/Makefile
>> @@ -49,8 +49,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
>>  obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
>>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
>>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
>> -obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
>>  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
>> +obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
>>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>>  obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
>>  obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
>> diff --git a/drivers/video/backlight/pm8941-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> similarity index 100%
>> rename from drivers/video/backlight/pm8941-wled.c
>> rename to drivers/video/backlight/qcom-wled.c
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>>  a Linux Foundation Collaborative Project
>> 
