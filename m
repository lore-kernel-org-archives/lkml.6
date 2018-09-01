Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95569C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422952083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422952083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeIAQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:49:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53158 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIAQtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:49:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so7435897wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UeZHQZjqLAPZvWDqu/Ed2azMhqBPY7h7lAovxX5XwmI=;
        b=Qgyhy+LlO6QucGNgYg38fFPoTZBjO20QdK+8RrPlIBYo8XNRvl6S9l/C4UHglhKFS8
         vPczL89er6jUydFgRqga6i4QxlZ63T/flVfh1Am697GW75/kJF1rz8EksNkQQhQJWf52
         7g5Sw8puLQfO7XWCVJMaYBmibHCFutr2dZRWykVX/IjgpVFMoDFQ100XV08s0uzlXnvy
         ypr1sjkeuu+GuuIS1MuOO3sZTWaJqUDeczlzMkfvQNfBH6mq8W4/dkd00/k4GjGhtknA
         w3VGWqqLzxNBSkw4byjtqYz5dOwfbLpdRsweryQrT6GqBi+qWGcRuJbzGivd8izqfV4t
         MA/Q==
X-Gm-Message-State: APzg51Cy2DEvBPnSzuBtLK0SeoQY1ZYFuPyUNj86BkgVSFkWEDwtzpKg
        MdEfcPlWqtgTHqO2njw9mo8aio6fVxg=
X-Google-Smtp-Source: ANB0VdZm6EH8jvtPfpwvUlG18QxmnOo5A5OCqf0at5J0RpiXYgRZSleiP4f1sXY63RhAaz79KatJAw==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr662412wmf.59.1535805469529;
        Sat, 01 Sep 2018 05:37:49 -0700 (PDT)
Received: from [192.168.1.16] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id i4-v6sm11618643wrs.85.2018.09.01.05.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:37:48 -0700 (PDT)
Subject: Re: [PATCH] media: ov2680: register the v4l2 subdev async at the end
 of probe
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org
References: <20180831151906.9315-1-javierm@redhat.com>
 <20180901114629.rupnr7xaeyxjqfdk@valkosipuli.retiisi.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0e0e3893-98b4-28f0-8088-91b19c806129@redhat.com>
Date:   Sat, 1 Sep 2018 14:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180901114629.rupnr7xaeyxjqfdk@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for the feedback.

On 09/01/2018 01:46 PM, Sakari Ailus wrote:
> Hi Javier,
> 
> On Fri, Aug 31, 2018 at 05:19:06PM +0200, Javier Martinez Canillas wrote:
>> The driver registers the subdev async in the middle of the probe function
>> but this has to be done at the very end of the probe function to prevent
>> registering a device whose probe function could fail (i.e: the clock and
>> regulators enable can fail, the I2C transfers could return errors, etc).
>>
>> It could also lead to a media device driver that is waiting to bound the
>> v4l2 subdevice to incorrectly expose its media device to userspace, since
>> the subdev is registered but later its media entity is cleaned up on error.
>>
>> Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> ---
>>
>>  drivers/media/i2c/ov2680.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
>> index f753a1c333ef..2ef920a17278 100644
>> --- a/drivers/media/i2c/ov2680.c
>> +++ b/drivers/media/i2c/ov2680.c
>> @@ -983,10 +983,6 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
>>  
>>  	sensor->sd.ctrl_handler = hdl;
>>  
>> -	ret = v4l2_async_register_subdev(&sensor->sd);
>> -	if (ret < 0)
>> -		goto cleanup_entity;
>> -
>>  	return 0;
>>  
>>  cleanup_entity:
>> @@ -1096,6 +1092,10 @@ static int ov2680_probe(struct i2c_client *client)
>>  	if (ret < 0)
>>  		goto error_cleanup;
> 
> How about instead moving ov2680_check_id() call earlier in probe()? That
> would seem to be a better fix: the driver should check the device is around
> before registering anything.
>

Yes, that would work too. We can't move it too early though since it has to
be after the DT was parsed, the regulator, clocks and gpio looked up, etc.

But moving ov2680_check_id() before ov2680_v4l2_init() would work indeed,
in that case ov2680_v4l2_init() should be renamed to ov2680_v4l2_register()
I think to make it clear that the function not only does initialization but
also register the v4l2 subdevice.

I'll post a v2 doing what you suggest.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
