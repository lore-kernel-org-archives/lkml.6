Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AA5C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948EB20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDrsjMhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948EB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeLFJuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:50:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39618 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:50:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so22561884wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SLJYc++pqRvEbdPPcx04NW2WQIDy0+VqRd4VPyqYzUs=;
        b=pDrsjMhMbtUsSRUBecI5Jwpt09ELfZmtOxGrWejSaKdQfbi3yYW+9C4Aikgbhle7yd
         lX9dk7uYWictvcHa/rpRHFiYYEIeIssQHT3YUVaaM/BcdUednBU+x89H7WwZcAaXHIr/
         rofkiMrh2xbOhcb7QZa2Pp31HJ2shzIt6HO71FTaZDUBEdu4t9U8O+r5UmQvLrrgXzVZ
         6fIvDTaun/2T5nfC4+FweeJkGU0G5/n5mABO1i1jdXap135INHredODjdlVWk61Wiq0G
         Ygxywu4aTESvHWtAsk8gBFXP/oYRi+ssk1nv6YCsVcgAhMBv+jQYkkdwoTCPXjWylbRi
         2JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=SLJYc++pqRvEbdPPcx04NW2WQIDy0+VqRd4VPyqYzUs=;
        b=ca6Jj3Yp8umsyGSSQ6UPjXlfQUQj88lyw09/ZGkqvikSKu2dQqzJYVIINiEUxU92e6
         DJ2BYWqJo1XsqhVVDhvDb4lPKGWj1uQRckM/H0zcuWNo+2Kwkp/MvOTLfhe3XCXhBRzC
         0+ksYOftra80LG1IyXttmnp6BLZXXUtcMAPEuW5W5XiaJf6UDrljhLghoWmyh2MHk3FW
         +GoxJMSdgM9kH/UvecLrRTindQrFm8mLFvZwoyWUCfcYVSA9/3TlsS0HWmwXkGTMMWQh
         20K7Yor0RP8PiHAzb57SGKRGr49dEd1T9a88yuPNXBmLY0k++1bqNA7JpgphsAIMQOTF
         j8xg==
X-Gm-Message-State: AA+aEWbhftFWqZVY1szv7P6hY88bvv1TpIzFjXFQs0XX7lJntjVgP0Kb
        m5QRBEftdPS8hhWP6QG6alufDFaL
X-Google-Smtp-Source: AFSGD/WkYxbyaWeyEaZSpPSVkWBB0R2fKFth/1FINj1Hh29VWNMvzcjxLgtTfxx5LttNJV8Y22dD5A==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr23924998wrv.202.1544089799868;
        Thu, 06 Dec 2018 01:49:59 -0800 (PST)
Received: from ?IPv6:2a02:908:125b:9a00:a142:2be6:b7be:5a3a? ([2a02:908:125b:9a00:a142:2be6:b7be:5a3a])
        by smtp.gmail.com with ESMTPSA id f192sm414735wmd.12.2018.12.06.01.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:49:59 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
To:     "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20181205165621.5805-1-michel@daenzer.net>
 <20181205165621.5805-2-michel@daenzer.net>
 <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
 <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
 <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
 <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <50899531-c8ea-6562-f7f3-593481bcef60@gmail.com>
Date:   Thu, 6 Dec 2018 10:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.12.18 um 10:39 schrieb Zhang, Jerry(Junwei):
> On 12/6/18 5:33 PM, Koenig, Christian wrote:
>> Am 06.12.18 um 10:09 schrieb Michel Dänzer:
>>> On 2018-12-06 3:43 a.m., Zhang, Jerry(Junwei) wrote:
>>>> On 12/6/18 12:56 AM, Michel Dänzer wrote:
>>>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>>>
>>>>> All the output is related, so it should all be printed the same way.
>>>>> Some of it was using pr_debug, but some of it appeared in dmesg by
>>>>> default. The caller should handle failure, so there's no need to spam
>>>>> dmesg with potentially quite a lot of output by default.
>>>>>
>>>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>>> Sounds reasonable, but personally prefer to show error when some
>>>> vital incident happens, e.g. no memory on eviction.
>>> The amdgpu driver still prints these in that case:
>>>
>>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* 
>>> amdgpu_cs_list_validate(validated) failed.
>>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough memory for 
>>> command submission!
>
> That's from cs submit, perhaps it may come from other places by 
> ttm_bo_evict_mm().
> Is that right? Christian.

Yeah, exactly my thinking as well. When we silence the TTM messages we 
might miss those cases.

Additional to that other drivers using TTM might not have those messages 
either.

If TTM is to noisy we should use ratelimit and/or reduce the number and 
size of the warning messages.

A simple "Warning, I ran out of memory during eviction!" should do.

Regards,
Christian.

>
> Regards,
> Jerry
>>>
>>> That's plenty as far as I'm concerned. :)
>> Yeah, but in this case I would rather make the amdgpu messages debug
>> level and leave the TTM meassages on error level.
>>
>> Christian.
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

