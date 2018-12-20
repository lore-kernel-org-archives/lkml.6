Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8366EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8C2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeLTGiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:38:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36720 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeLTGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:38:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so416685pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 22:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6Jy+rfQrqvJI7cfyZQDs+gFXdxT8VlRJb8jJYruMWU=;
        b=SaZ8IBZoFn6Qs1TearzNeR/VQ9FVZZKUUV64O0h7+o+lERDieyLcps7/S/cTt4TARG
         mo2Cqr8lKNWrP/BX5obpH/4vH9gvWeu15Kw+ZugUzhJ5OBH/SHzVbHijcsGE8FyFhdrG
         bMZqrippLOhD5eJMXWnuO2Jk4tToBSr8nnjfDIaKXkLaVoIDSlF8J1Lkwad9g9BiT/ZY
         7lUkZFMQNLZ+A3UEBHyQ+Qac7u5irL7mpHw2A4CzSGGON/9e09iK/w0sWWrnpOQNOLtH
         C819MsnTT7fCGCwEwUISVYDSIYlvwsCUogBnCdQtkaed0l9g1r0eYpcvvzf5qm1KQalh
         VLZg==
X-Gm-Message-State: AA+aEWZpKodyZkbMW4jTHSogrftpWrWd/UDM8QkC7OpsmJhWaGKdOETq
        L/J6mUUOY4T1VyDvSoRl/p8hqSQSq8P3Ww==
X-Google-Smtp-Source: AFSGD/U460VtwS5mh+3RpdbW8Y/DHHMmhkXPb5yUl06YiuBt5eEYDw302UVV//JcU93dbIr8Hd2bPQ==
X-Received: by 2002:a62:d885:: with SMTP id e127mr23036979pfg.197.1545287882617;
        Wed, 19 Dec 2018 22:38:02 -0800 (PST)
Received: from bsingh.kernel.org ([125.16.97.115])
        by smtp.gmail.com with ESMTPSA id c72sm14965348pfb.107.2018.12.19.22.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 22:38:01 -0800 (PST)
Subject: Re: [PATCH] hpet: Fix missing '=' character in the __setup() code of
 hpet_mmap_enable.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        trivial@kernel.org, prarit@redhat.com
References: <20181219092502.3079-1-bsingh@redhat.com>
 <20181219094627.GC11441@kroah.com>
 <2c7a66e5-9488-b1a3-d08d-e4f508d3ee53@redhat.com>
 <20181219123733.GC20670@kroah.com>
From:   Buland Singh <bsingh@redhat.com>
Message-ID: <459d12ac-5d21-bae7-164e-978af3eebf22@redhat.com>
Date:   Thu, 20 Dec 2018 12:07:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181219123733.GC20670@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 6:07 PM, Greg KH wrote:
> On Wed, Dec 19, 2018 at 05:34:32PM +0530, Buland Singh wrote:
>> On 12/19/18 3:16 PM, Greg KH wrote:
>>> On Wed, Dec 19, 2018 at 02:55:02PM +0530, Buland Singh wrote:
>>>> The kernel command parameter 'hpet_mmap' never takes effect due to missing
>>>> '=' character in the __setup() code of hpet_mmap_enable and the memory map
>>>> of the HPET registers never get expose to userspace.
>>>>
>>>> Signed-off-by: Buland Singh <bsingh@redhat.com>
>>>> ---
>>>>    drivers/char/hpet.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>>>> index 4a22b4b41aef..9bffcd37cc7b 100644
>>>> --- a/drivers/char/hpet.c
>>>> +++ b/drivers/char/hpet.c
>>>> @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
>>>>    	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
>>>>    	return 1;
>>>>    }
>>>> -__setup("hpet_mmap", hpet_mmap_enable);
>>>> +__setup("hpet_mmap=", hpet_mmap_enable);
>>>
>>> What commit caused this bug?  Should this go to the stable kernel trees?
>>
>> Hello Greg,
>>
>> The commit id is 3d035f58. The bug is there since the initial patch which
>> introduced the kernel parameter 'hpet_mmap'. The fix should go to the
>> stable kernel trees.
> 
> Great, can you resend it with all of this information (a fixes: and cc:
> stable tag?)

Sure, I will send the v2 with all the information.

Regards,
Buland Singh


