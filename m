Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AFAC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589322518E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="iGd7Yj8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589322518E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeGAWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 18:24:40 -0400
Received: from vern.gendns.com ([206.190.152.46]:55480 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbeGAWYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 18:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DKMNsLWyspmQH68DhnvBOyLuWEz37fs9Dtrc5hkURPk=; b=iGd7Yj8q7+siPNirWqdXHaKqkv
        jlpkmsfTc1YJ/GC6VqX7dw1oIPRtYBrLxPE3mpSVwfdfsbOK7AIxeCF2rxfuE0r2gLxD0j3WipgXL
        sVFH8NmM9Mv1I+Nh70/4KSUv9C92n6Hga22ZpxANIBpkZI4KtRohnYImjG1iaCpfQUHdZk/Lr+laY
        ANdlXH4Iu+q3/REPSwaj6pdPIdTxHjBH1ZrImsS6oqhRKUcneygYkRpfVCQTRQJErsW5GgcadUd2K
        LIWIjy3R5qjJJWh4morvIpCriWf9Jk0afyCIII9ROM/5OJT73KDOtM8CX38jvTtJJe25b2iX1wJVH
        nFyF8ezQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41360 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fZkln-00AGn6-C8; Sun, 01 Jul 2018 18:24:35 -0400
Subject: Re: [PATCH] iio: add channel type for frequency
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
References: <20180701025953.3561-1-david@lechnology.com>
 <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
Date:   Sun, 1 Jul 2018 17:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 02:18 AM, Lars-Peter Clausen wrote:
> On 07/01/2018 04:59 AM, David Lechner wrote:
>> This adds a new type for frequency to the IIO channel type enumeration.
>>
>> Units are in Hz.
>>
> 
> Documentation?

I take it that you mean Documentation/ABI/testing/sysfs-bus-iio? Or
somewhere else too?

> 
> We already have the altvoltage channel type with the frequency attribute.
> Difficult to say if there are any overlaps without documentation on how this
> new attribute is supposed to be used.

I'm basically trying to implement a quadrature encoder in iio. I want to be
able to use it in-kernel to get a rotational speed value for a motor.

The motors (and encoder wheels) are hot-swapable, so we don't know how many
counts from the quadrature encoder equals one rotation because it depends on
which motor is being used. So using IIO_ANGL_VEL doesn't work for this case.

It seems to me that the proper generic unit for "speed" from the quadrature
encoder would be counts per second, hence the suggestion of a frequency unit.
I'm not sure if voltage frequency works here since a "count" on a quadrature
encoder is derived from two different voltage signals (and may vary depending
on how the encoder determines what one count it).

Also, unrelated to my quadrature encoder project, I was thinking that
frequency counters would use this unit as well (although the voltage alt
makes more sense for this case).

There are also sound sensors that measure frequency that could use this unit.

> 
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/iio/industrialio-core.c | 1 +
>>   include/uapi/linux/iio/types.h  | 1 +
>>   tools/iio/iio_event_monitor.c   | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 19bdf3d2962a..f3c2c9e4b997 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>   	[IIO_COUNT] = "count",
>>   	[IIO_INDEX] = "index",
>>   	[IIO_GRAVITY]  = "gravity",
>> +	[IIO_FREQUENCY] = "frequency",
>>   };
>>   
>>   static const char * const iio_modifier_names[] = {
>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>> index 4213cdf88e3c..9fee86e2046f 100644
>> --- a/include/uapi/linux/iio/types.h
>> +++ b/include/uapi/linux/iio/types.h
>> @@ -44,6 +44,7 @@ enum iio_chan_type {
>>   	IIO_COUNT,
>>   	IIO_INDEX,
>>   	IIO_GRAVITY,
>> +	IIO_FREQUENCY,
>>   };
>>   
>>   enum iio_modifier {
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index b61245e1181d..c3ef20057d52 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>   	[IIO_PH] = "ph",
>>   	[IIO_UVINDEX] = "uvindex",
>>   	[IIO_GRAVITY] = "gravity",
>> +	[IIO_FREQUENCY] = "frequency",
>>   };
>>   
>>   static const char * const iio_ev_type_text[] = {
>>
> 

