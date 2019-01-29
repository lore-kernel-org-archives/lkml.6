Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32853C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA80C21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="wwfQ0w/q";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="bY+jgiMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfA2KQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:16:18 -0500
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:57563 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfA2KQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:16:18 -0500
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 05:16:15 EST
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TA8GG6020752
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=zkrNMCGqmQhknpXEnYoasEaaYPOraYskNafnNeeps3s=;
 b=wwfQ0w/qwhM8RfhNcAylkohRBglVrPlDtTiDI8e/SuwhGZT2HgEUx0uVRy6s0PBYRkmx
 8Zcw0EE/i0InoN0Oz26asOiDgARklD8Rje7t2Pa7JMvCxCnmTnHdSwV9zsqR9m+yCpYy
 i9NHDFrUhkEuFgp6kq4AJEV/YRXdqBusAuWlzZVS7SW2nshvU8cxzM/B9JKwFjN20pBx
 o61PVOHLnz/cehQhOIPLl/EAzK8RWyBAlxEeqauY1lnhovZ0ZlhNQkgN8Tty4F4h0meq
 KxzGBqHFQE/LDHWbBmqpcdB0/xcyXXo1PERfaIPdKvA+lyFbv46l52eOm05pmR0Nh02+ 4A== 
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        by mx07-00252a01.pphosted.com with ESMTP id 2q8du51ef6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:16:14 +0000
Received: by mail-wm1-f72.google.com with SMTP id o5so5648525wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zkrNMCGqmQhknpXEnYoasEaaYPOraYskNafnNeeps3s=;
        b=bY+jgiMXN3HjJwanjK7+KP9Xru9ThnEZDjDkgug1o5yrPlyK4JsahTdwE87tAYozvC
         76mVx/VSxz8Xxi0cMwaDK6oNk3UWJCTpM0fGFw/yS3J5PkOArym8v2RrQct7k4ZUEUYR
         zh59YoGTS1M7NpoSYqAP7UMbJAY4kJiuA+W4hVc7A3VNGCMXQRyTlNfsoNou58noy9Xd
         Ay8qN3UVXrfaJu6uN4f0Jw5C8TCL0r/uJXFzU0h7u9poP/e6OJghSQYNJHqU+r9tyIrs
         wBhFerFAMzwjvs3dHHq0RO154hnnrkXYsaN59Wn7yt3PQfcEzkmrv+AokITLZH5D/LbG
         fm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkrNMCGqmQhknpXEnYoasEaaYPOraYskNafnNeeps3s=;
        b=Uby2c604rfWxrDHtLKAIMCUbMf7M4NOfy1SHJjzLUHgnlHm5gV97xpSnRF20HbzajZ
         siSqGhzglYmdocY8tHVaOY1VxGWcLUvnK3mN7CV+gfKM3J5H8iH1ar+ng4h4Gh2muh2o
         cvGsDXbCpiuQZEGQWAbANYcGJNOuaCbDse3Acg1uJKiBIVGlBr3YLJyCPQgIq4YxxghU
         zG0hgyDml3UOVa+LKAlCHHTl8G3SWsp5VhxOewhhVME08OcjhW84SoSTpjVuPQsSGw6H
         6E4DfsM8YjFMfrFSkEToOz1NLKicQMHZFtla+4CUXghJOZoD5aGWJuap7WC3lkrmyWbw
         GfaA==
X-Gm-Message-State: AJcUukdun2YGZuIg99TRbWqxpnmbvOOH7Iz96OLEXNZb4G2JEPbMyr3c
        DD3Iz7JVhyUVwDAfLf5459oQW6hD5Nu8mhNfYeaz8X88fes5YJt0aM2ZIJI1mkmbMqaNGO+StLH
        714B2G5Bp+YxnoUy0CsRAcXUC
X-Received: by 2002:adf:b608:: with SMTP id f8mr24743681wre.120.1548756973849;
        Tue, 29 Jan 2019 02:16:13 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7+oAQpvPORr9mA3Odc6AUubyqQjDTlTwljoiTuz6RToEuKayqIR5BQH2YXeYyFdcYda8vfnA==
X-Received: by 2002:adf:b608:: with SMTP id f8mr24743656wre.120.1548756973537;
        Tue, 29 Jan 2019 02:16:13 -0800 (PST)
Received: from [10.3.14.17] (cust51-dsl50.idnet.net. [212.69.50.51])
        by smtp.gmail.com with ESMTPSA id h131sm2848411wmd.17.2019.01.29.02.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:16:12 -0800 (PST)
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
 <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <4f424b94-f871-08b2-03c7-d3e28c534785@raspberrypi.org>
Date:   Tue, 29 Jan 2019 10:16:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d4a3e7b3-ed86-ca74-0e46-9b3b5f9cbef7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 29/01/2019 09:52, Daniel Lezcano wrote:
> On 29/01/2019 10:10, Phil Elwell wrote:
>> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
>> dereference in bcm2835_thermal_debugfs. The driver makes use of the
>> implementation details of the thermal framework to retrieve a pointer
>> to its private data from a struct thermal_zone_device, and gets it
>> wrong - leading to the crash. Instead, store its private data as the
>> drvdata and retrieve the thermal_zone_device pointer from it.
>>
>> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> One question: do you really want the thermal driver to be loaded as a
> module ? Don't you want to have it operational as soon as possible
> instead of waiting the OS to boot and load the kernel module?
> 
> If a module format is not needed, then the thermal_zone field won't be
> needed anymore because the 'remove' ops can be removed and the need of
> the tz field to unregister it disappears.

Thanks for the review. The general approach for Pi drivers has been to make them
tristate to allow minimal kernels to be built - important when the smallest
Pis have 256M - and the delayed startup isn't a problem because the firmware
is running a thermal limiter from before the kernel is loaded. However, this
driver is very small, and I wouldn't object if somebody decided it was better
to make it built-in.

> 
>> ---
>>  drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
>> index 720760c..ba39647 100644
>> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
>> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
>> @@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
>>  
>>  static void bcm2835_thermal_debugfs(struct platform_device *pdev)
>>  {
>> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
>> -	struct bcm2835_thermal_data *data = tz->devdata;
>> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>>  	struct debugfs_regset32 *regset;
>>  
>>  	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
>> @@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>>  
>>  	data->tz = tz;
>>  
>> -	platform_set_drvdata(pdev, tz);
>> +	platform_set_drvdata(pdev, data);
>>  
>>  	/*
>>  	 * Thermal_zone doesn't enable hwmon as default,
>> @@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>>  
>>  static int bcm2835_thermal_remove(struct platform_device *pdev)
>>  {
>> -	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
>> -	struct bcm2835_thermal_data *data = tz->devdata;
>> +	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
>> +	struct thermal_zone_device *tz = data->tz;
>>  
>>  	debugfs_remove_recursive(data->debugfsdir);
>>  	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
>>
> 
> 
