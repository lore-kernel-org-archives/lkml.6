Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9C020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYLNQz0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9C020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeIJUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:52:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeIJUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:52:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so10692630pff.6;
        Mon, 10 Sep 2018 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wPoXvIHDlj1zK5urIZp4G7FqAylzcX55B7BkWWrDRQk=;
        b=eYLNQz0vHYdOkmxNoePksSxZr0vDGabV4znaXB5GPl83CvNp3tIJ9ux5jFKUcNRJBj
         Fq5lvGrCZQUkPD4joUTNFOALUyfPwSToLWf5tnT+4EAnyIFyQOTKZwxCacS0AI+RWS6l
         rAnZVgylyiK3r53XQV36+MM4T+EQQ0DIQ5IKUYYfolTrakTb6jDP3xMjhprROZ23/p6R
         VOaFzr3kveAmbf91vfFRhanYLoZRXmrFtKmVVm4DnTR5MaNjFn3oDvNyA+Is18a6jlIy
         VwMrYHloGsHAA7SGOzSJz1xe+uJPaN96fyum379pp6K77kXX+wXHwjdGX41JxDsMAuCG
         GvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPoXvIHDlj1zK5urIZp4G7FqAylzcX55B7BkWWrDRQk=;
        b=hRAKoJnhcjkGo3PMmSgJo6fs3uFfY6+zZ5FNKWil5iEumzfajDmurZoBSxqgXBl6WG
         Rc60wlqE/NpeY4WNMjNuGibOI3rk0+HYA8/JSQvtFkLowN612W9v6CH/AIXFWblf6c8R
         gtb92IzOhPAhzKA/CZH1/dCu1f8LAo79ZDp/FsHrtV3QyMcVTtot/UClv0+XXuRkThfg
         GtcmbCMq+wrizBxFX/lmJ5YmEHme6x8LWzUQWEFt5sYsRne3OKENqjtU4cuDQstauZVJ
         jkza/ZnRrwxBMQLpKdYdSq0BRqNhMt+eTrVKlUc3HvfJqiF2gHlAkR1JX7Ttd38lzsE9
         rfKg==
X-Gm-Message-State: APzg51CB+PD7LaI5Icku8ScXsqVOw/4ftgmB4YQBvy6aGdUeco8ECbk6
        WzSYapXfWDgxgYyJjaONiHMmVNDd
X-Google-Smtp-Source: ANB0VdboruX+/LPZp3AQNVN+SWSaY0T+YvtfF+TEYfhqsD5n+PW+0R/fB/xYmSUAE+HFnUmW83xJvg==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr23536040pgb.136.1536595076245;
        Mon, 10 Sep 2018 08:57:56 -0700 (PDT)
Received: from [10.1.70.2] (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id 1-v6sm36434492pfm.145.2018.09.10.08.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:57:55 -0700 (PDT)
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in
 am2315_trigger_handler
To:     Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
 <20180908122913.GA4445@himanshu-Vostro-3559>
 <20180908151751.20e7396f@archlinux>
From:   David Frey <dpfrey@gmail.com>
Message-ID: <a721fd9e-b845-ee1c-0b8b-e763ab182330@gmail.com>
Date:   Mon, 10 Sep 2018 08:57:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180908151751.20e7396f@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2018 7:17 AM, Jonathan Cameron wrote:
> On Sat, 8 Sep 2018 17:59:13 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
>> On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
>>> The iterator in for_each_set_bit is never null, therefore, remove
>>> the redundant conditional judgment.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/iio/humidity/am2315.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
>>> index 7d8669d..dc12e37 100644
>>> --- a/drivers/iio/humidity/am2315.c
>>> +++ b/drivers/iio/humidity/am2315.c
>>> @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>>>  		i = 0;
>>>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>>>  				 indio_dev->masklength) {
>>> -			data->buffer[i] = (bit ? sensor_data.temp_data :
>>> -						 sensor_data.hum_data);
>>> +			data->buffer[i] = sensor_data.temp_data;  
>>
>> No, this seems wrong!
>>
>> We have buffer support to either take both readings(temp & humid)
>> simultaneously, or only single channel using specified scan mask.
> 
> Key think is that bit most definitely can be 0 if the 0th bit is set.
> This isn't a null check at all.
> 
> I'm curious, was this a by inspection case or did some script throw
> this one up?

Firstly, +1 on the patch in this thread being an incorrect change.
While inspecting the surrounding code,  I noticed that there's a bit of
questionable code in this area.  I believe this whole chunk:

	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
		data->buffer[0] = sensor_data.hum_data;
		data->buffer[1] = sensor_data.temp_data;
	} else {
		i = 0;
		for_each_set_bit(bit, indio_dev->active_scan_mask,
				 indio_dev->masklength) {
			data->buffer[i] = (bit ? sensor_data.temp_data :
						 sensor_data.hum_data);
			i++;
		}
	}

could be reduced to this:

	for_each_set_bit(bit, indio_dev->active_scan_mask,
			 indio_dev->masklength)
		data->buffer[bit] = (bit ? sensor_data.temp_data :
					   sensor_data.hum_data);

The if/else structure seems like an unnecessary optimization.

Thoughts?



