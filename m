Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1282120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551098172;
	bh=kxNgJ4nH66fr6OGTAIzbJ/wcpIpPxlivIQBBUwJyo/M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dvV85izL+VfLE0ubtZMEhmOi7pNVBZ4oc73qZtF1nPc8snuEqEbtd/FTI79IbC3AY
	 BrWskwXjSd8kT96vyM+Q6laguC1kkstiqEjxxTM+w+vcEnT/srQRXwUurjMPLKfkjE
	 20iHBtwVKrPm11z/NDXi7ShOc7eY3HwNHaDfmcLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfBYMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfBYMgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:36:10 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BE120652;
        Mon, 25 Feb 2019 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551098169;
        bh=kxNgJ4nH66fr6OGTAIzbJ/wcpIpPxlivIQBBUwJyo/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Re6jYtvofUyyfKQdC3FCBpYmPakBnLJQ/sV4I7jsAQCC1dOBHVLF50oZUq8xwVIuM
         da2+BwMJA/CCqvKF8Ttf3CchpUNbH7usPJAf8p3e+mQoMpwwhuiD662D3siUrh8D2Z
         TwlMTgn2Ja6jPbj8zwTHiEaTpjDf5VA12YTE1W6k=
Subject: Re: [PATCH] au0828: minor fix to a misleading comment in _close()
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com, keescook@chromium.org,
        sakari.ailus@linux.intel.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190222174559.8084-1-shuah@kernel.org>
 <20190223014422.GS11484@bigcity.dyn.berto.se>
From:   shuah <shuah@kernel.org>
Message-ID: <46beba87-b87d-b3e2-ec6d-f88d9f21bd06@kernel.org>
Date:   Mon, 25 Feb 2019 05:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190223014422.GS11484@bigcity.dyn.berto.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 6:44 PM, Niklas Söderlund wrote:
> Hi Shuah,
> 
> Thanks for your patch.
> 
> On 2019-02-22 10:45:59 -0700, Shuah Khan wrote:
>> Fix misleading comment in _close()
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/media/usb/au0828/au0828-video.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
>> index 7876c897cc1d..08f566006a1f 100644
>> --- a/drivers/media/usb/au0828/au0828-video.c
>> +++ b/drivers/media/usb/au0828/au0828-video.c
>> @@ -1074,7 +1074,7 @@ static int au0828_v4l2_close(struct file *filp)
>>   		 * so the s_power callback are silently ignored.
>>   		 * So, the current logic here does the following:
>>   		 * Disable (put tuner to sleep) when
>> -		 * - ALSA and DVB aren't not streaming;
>> +		 * - ALSA and DVB aren't streaming;
> 
> Nit-picking, as you are modifying the line anyhow I would s/;/./
> With or without this changed,

Thanks. I didn't notice that one. I might as fix it. Will send v2.

> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 

thanks,
-- Shuah

