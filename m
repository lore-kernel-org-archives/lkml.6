Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D7C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED0B216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED0B216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeHCIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:24:19 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:58326 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729946AbeHCIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:24:18 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id lTaYf5arK6brUlTabfBqu8; Fri, 03 Aug 2018 08:29:31 +0200
Subject: Re: [PATCH] media: platform: cros-ec-cec: fix dependency on
 MFD_CROS_EC
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180724093624.1670671-1-arnd@arndb.de>
 <20180802195824.26a9720a@coco.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cb43f8ab-ea10-b847-7724-ee9a87f88ca2@xs4all.nl>
Date:   Fri, 3 Aug 2018 08:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180802195824.26a9720a@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFMRO+UkJhxaU3kZSiCTtm1pFgzt5NdNwmB6WDvbtGkNhdRsRQMYXTBES8R6xrVWstEKZMTPMJYTM9qFQ0Iw2EjwK6fkxO/9YtEe5dXguWkHIyAxHKGC
 HJBKmCm+bXoAjxy/0IyGz5uEQ4NoGk2VwI+cbrfpO8YmIYrbzZ4jEDpp8U51V8EUb0L87MwucyDHAV/+SwMbXXniJUxhYSdND0QxaZQM6DiHMVcrCEKNQxg9
 /l6bdK+z1SX7PnQnZ1+hBAITl9mVZjlmYeBTJnoDQbt8T1sYUZ7fTm0nuWhKzBdNFDFQ71aV8bRfTXywX84+rEDipy58LgvLOLyXhNrB+qAO/3ZWQ/bPvy76
 DBMlJspoS10/AYwHx3g3oahj8w9d2sGfEvxyxtoiW8sROg8094JQT8BaWaJiU/+pu/YYKefMwW/PWV5SMmYcx5VUtKX4GawG2qGjnnthjRkQkGPimbw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 12:58 AM, Mauro Carvalho Chehab wrote:
> Em Tue, 24 Jul 2018 11:35:59 +0200
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
>> Without the MFD driver, we run into a link error:
> 
> Weird... I'm not seeing this driver at the media tree... was it merged via
> some other tree?

Yes, it's going via the mfd subsystem. This driver touched on the mfd, drm and
media subsystems, in the end it was decided to let the mfd subsystem take this
since it had the most impact on that subsystem.

Regards,

	Hans

> 
>>
>> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_transmit':
>> cros-ec-cec.c:(.text+0x474): undefined reference to `cros_ec_cmd_xfer_status'
>> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_set_log_addr':
>> cros-ec-cec.c:(.text+0x60b): undefined reference to `cros_ec_cmd_xfer_status'
>> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_adap_enable':
>> cros-ec-cec.c:(.text+0x77d): undefined reference to `cros_ec_cmd_xfer_status'
>>
>> As we can compile-test all the dependency, the extra '| COMPILE_TEST' is
>> not needed to get the build coverage, and we can simply turn MFD_CROS_EC
>> into a hard dependency to make it build in all configurations.
>>
>> Fixes: cd70de2d356e ("media: platform: Add ChromeOS EC CEC driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/media/platform/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>> index 92b182da8e4d..018fcbed82e4 100644
>> --- a/drivers/media/platform/Kconfig
>> +++ b/drivers/media/platform/Kconfig
>> @@ -535,7 +535,7 @@ if CEC_PLATFORM_DRIVERS
>>  
>>  config VIDEO_CROS_EC_CEC
>>  	tristate "ChromeOS EC CEC driver"
>> -	depends on MFD_CROS_EC || COMPILE_TEST
>> +	depends on MFD_CROS_EC
>>  	select CEC_CORE
>>  	select CEC_NOTIFIER
>>  	---help---
> 
> 
> 
> Thanks,
> Mauro
> 

