Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6A921773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7ELw0G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeLTL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:26:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40739 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:26:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so1204324lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=wzNDox5Z5BKA+Ln81oxx9eYCmgy/euRTyDPWKRHNA8g=;
        b=f7ELw0G8v+5VB7Nn3bvVFbKoSP4K4loPZD/M7NAC3hnpWmYr7i695kNhTe22U0ZyJx
         s8ZGvY2f/52wdaVB1PAHdUv7kwO4pTKj/oCGmZHB5cwGDCbFa/qzxzrMli46/jDQjVJI
         eAoNWSSfhZed/m35iXzlBQZ63aGYx6r7NRI1zAyG7nZFFp3Vr6wSCuSD/6bH4+ve+Yej
         vjnLPPYc11JmtAFF3TDhj0233BCLNRSzoZMAT9PGsTOpaASk1leXhyEGF0G2tM7MY+To
         YppW9fG4bp/bH3G2IyZOjqQuYukGj6Fji+2D14o3LU6r86+x5Rufy0a9jQ4c5FEGHE88
         zuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wzNDox5Z5BKA+Ln81oxx9eYCmgy/euRTyDPWKRHNA8g=;
        b=OeyHHnw6roi+EzUkwICsWjjZ1DlRKUFj9LzXW+LbElj7vD1Ij8iEnje/JPtTNjffsd
         +siBiusc5mUszSBPL1Ng09esjA5PqKCPu1q72fvlmEAuinC+yqOTFaWhGH4Lzku6qf5+
         mXflpt3RgWxFJjhgh2emnU7LBGTphVUQDWvGq3CZu0FgmQPR/LvJ9BaHz51pRWDzSDGe
         zJkfczF2mYdp1NXayQvipPqW42I9zZlRXeSvRXKUxUr9RD1tT5n9IxY93nGEs0j07G6u
         Y8TObdl38+93bJeb0RhP8d/SF0jvpDgvOrnkeVjsdhL7C9rmQW2zM9GeqXGxzJaPiAq5
         qmMg==
X-Gm-Message-State: AA+aEWZKs181V8Jpwrw4URjGjey2OHi+F0pyHNQog53EAQ0SfE/n3M7v
        QWK4264LUPpH/XlRMQ7YlEu9Dxgk
X-Google-Smtp-Source: AFSGD/X5SJ8lcUcnAn5bIbQbHi2jWv4FAUynDpWit9mPFomEIk7XYjU+FVNMAZDDeTmHPOdgvFaLkQ==
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr7332860lje.105.1545305206275;
        Thu, 20 Dec 2018 03:26:46 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id n16sm4318819lfl.35.2018.12.20.03.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 03:26:45 -0800 (PST)
Subject: Re: [PATCH v3] drm/bochs: add edid present check
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181220101122.16153-1-kraxel@redhat.com>
 <20181220105104.GI21184@phenom.ffwll.local>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <57c74dd5-4ea6-8bc7-8e83-55b27976e8e5@gmail.com>
Date:   Thu, 20 Dec 2018 13:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220105104.GI21184@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 12:51 PM, Daniel Vetter wrote:
> On Thu, Dec 20, 2018 at 11:11:21AM +0100, Gerd Hoffmann wrote:
>> Check header before trying to read the complete edid blob, to avoid the
>> log being spammed in case qemu has no edid support (old qemu or edid
>> support turned off).
>>
>> Fixes: 01f23459cf drm/bochs: add edid support.
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
>> ---
>>   drivers/gpu/drm/bochs/bochs_hw.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
>> index c90a0d492f..d0b4e1cee8 100644
>> --- a/drivers/gpu/drm/bochs/bochs_hw.c
>> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
>> @@ -86,9 +86,16 @@ static int bochs_get_edid_block(void *data, u8 *buf,
>>   
>>   int bochs_hw_load_edid(struct bochs_device *bochs)
>>   {
>> +	u8 header[8];
>> +
>>   	if (!bochs->mmio)
>>   		return -1;
>>   
>> +	/* check header to detect whenever edid support is enabled in qemu */
>> +	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
>> +	if (drm_edid_header_is_valid(header) != 8)
>> +		return -1;
>> +
>>   	kfree(bochs->edid);
>>   	bochs->edid = drm_do_get_edid(&bochs->connector,
>>   				      bochs_get_edid_block, bochs);
>> -- 
>> 2.9.3
>>

