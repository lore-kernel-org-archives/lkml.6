Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BEBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BBD2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT+pzMCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BBD2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbeKNDMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:12:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37865 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeKNDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:12:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so9403597lfh.4;
        Tue, 13 Nov 2018 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2JeBfFhoU+gX6GHsYw6B5VuNeSX4B6xxkbtBWYkl6Y=;
        b=jT+pzMCi+irxRLn5eAK8i94wOPRszu9H8TaQUuY+3bHsG+LEbw5bLQuY+PQu+0P1b0
         8pGSoaxzt+gftXK/CFcMqKRWg+K6Hady+gVCUMWCe8utH3xzIjbXSW8lOLxyCsTeYyZc
         aS1XyrM4sW/hgFle3us8+eAK1MjDdTh+h5yNdC/piqAZxJXAZDuPaVCOqLvBXjapfI7c
         gGkAIkK0DEpZ8YCLjcWraWLFg3/NNglHoh4q21FZ1Vk6oBF2hQKseSKb/X//4F3COdM4
         g7CFAtq3smyRJ5lmrKWsruSRyUkbFkvD5UlbStwRDTkiHi3IhWX2z2AhnXfOlhW3Gi28
         X9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2JeBfFhoU+gX6GHsYw6B5VuNeSX4B6xxkbtBWYkl6Y=;
        b=HfXwby3Qf+kQRuNnsiqf1hI3ZiS8FrRlP0D1/k4uz3Uqg9tu8DG4aZVozOUgO5ILLy
         baM9sCY63XYWqwjV2IqZ+ic9xLtmYrcumJ0L+b2X2xkNUgUTEIVA23brbF/txxDbEpN9
         U9kraZ2EKh3DVGya1DnmnIp9TxV3dMHaZONs5LPJUX4BZ2w6eBKPhP1BX/AoA/pPx4OT
         abAhvbn0Blq7NPRifaweWw4bPaVfWUOVXl+dhJdrAqlyPjX9OqdZ/zJf5AtOsJu6Mfj2
         wolulyMNzHSeqmVxe52An9ksyUnB68YIMQU5RKrt91+2sE4d3KuFKBfqr2RgbPy/Z03L
         M1Bw==
X-Gm-Message-State: AGRZ1gJmM4ZOGcXdvIEdc9qSS/y0G8bAgO4RvRbAp7SEyOp6/TdmIPZw
        WxIoQRlLo2E3I2vJe3HykcOOHBfo
X-Google-Smtp-Source: AJdET5f+VOuoLDQppbXYLHHPecN/YOc5SKQEBERnQ9FWwwKMK2DZduUnDuLYbS1xhbpRqoRJudKbNQ==
X-Received: by 2002:a19:be16:: with SMTP id o22mr3362294lff.22.1542129213243;
        Tue, 13 Nov 2018 09:13:33 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id y1-v6sm3468834ljh.39.2018.11.13.09.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:13:32 -0800 (PST)
Subject: Re: [PATCH] media: staging: tegra-vde: print long unsigned using %lu
 format specifier
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Colin King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108110224.1916-1-colin.king@canonical.com>
 <0b3bf728-7b7e-7250-40eb-0827f8fe955b@xs4all.nl>
 <67306f07-f270-3395-48c4-f6d4954e0d04@gmail.com>
Message-ID: <84273284-1da5-daf8-491a-3374e2bf7b41@gmail.com>
Date:   Tue, 13 Nov 2018 20:12:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <67306f07-f270-3395-48c4-f6d4954e0d04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2018 19:52, Dmitry Osipenko wrote:
> On 09.11.2018 17:32, Hans Verkuil wrote:
>> On 11/08/18 12:02, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The frame.flags & FLAG_B_FRAME is promoted to a long unsigned because
>>> of the use of the BIT() macro when defining FLAG_B_FRAME and causing a
>>> build warning. Fix this by using the %lu format specifer.
>>>
>>> Cleans up warning:
>>> drivers/staging/media/tegra-vde/tegra-vde.c:267:5: warning: format
>>> specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/staging/media/tegra-vde/tegra-vde.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
>>> index 6f06061a40d9..66cf14212c14 100644
>>> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
>>> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
>>> @@ -262,7 +262,7 @@ static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
>>>  			value |= frame->frame_num;
>>>  
>>>  			dev_dbg(vde->miscdev.parent,
>>> -				"\tFrame %d: frame_num = %d B_frame = %d\n",
>>> +				"\tFrame %d: frame_num = %d B_frame = %lu\n",
>>>  				i + 1, frame->frame_num,
>>>  				(frame->flags & FLAG_B_FRAME));
>>>  		} else {
>>>
>>
>> Compiling for i686 gives:
>>
>> In file included from /home/hans/work/build/media-git/include/linux/printk.h:336,
>>                  from /home/hans/work/build/media-git/include/linux/kernel.h:14,
>>                  from /home/hans/work/build/media-git/include/linux/clk.h:16,
>>                  from /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:12:
>> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c: In function 'tegra_vde_setup_iram_tables':
>> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:265:5: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'u32' {aka 'unsigned int'} [-Wformat=]
>>      "\tFrame %d: frame_num = %d B_frame = %lu\n",
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /home/hans/work/build/media-git/include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
>>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>>                                        ^~~
>> /home/hans/work/build/media-git/include/linux/device.h:1463:23: note: in expansion of macro 'dev_fmt'
>>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>                        ^~~~~~~
>> /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:264:4: note: in expansion of macro 'dev_dbg'
>>     dev_dbg(vde->miscdev.parent,
>>     ^~~~~~~
>>
>> Should it be %zu?
> 
> Same on ARM32. Yes, it should be either %zu or "!!(frame->flags & FLAG_B_FRAME)".
> 

Actually this not a problem with a more recent -next. My bad, sorry for the noise. 

Probably I should try again with a "trace points" patch that removes those debug messages.
