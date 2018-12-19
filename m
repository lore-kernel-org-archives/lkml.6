Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC192C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E5217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeLSMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:04:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40057 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeLSMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:04:38 -0500
Received: by mail-io1-f67.google.com with SMTP id a11so802086ioq.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xk3LTK0rZU9iPsSUpdLXv+5SfsDQuy6u0SOzzxtG1jI=;
        b=cukspQ5OkCUL4vmFZGNcu4KeiixdrpP+Mm23tFR9z4sSqiRZwuh1279dyGbFJansy/
         YdohvjKRz7b5GHAmrV76l5wtXPkiqZQysXoRnWLHaYijgxeEomgmuWqUx4U7x69tmeTB
         hlxcLQ1b0OW2NEG5SOGsGQ6bFcej6u7nOCr2NZ31WFAoJHaG/KArzfu/7fEWvqNCs8Cz
         T37SyMqydS/6e7hyZ589Xzi96tZyDaz1Av41der1bdhH7DhJHHgQFkbX5iVJnAwfoCFe
         u5nehrqav5owFibhwcElx77vH5x4d8T1+dRJCFQVBn5qjPnrmnvVYhBDPLaag5X/mNI2
         Kj6A==
X-Gm-Message-State: AA+aEWbrmjOH2rvyZ030vglU/uBwOBCISIas/VTfgAWx7zgA/fg89XSm
        bWIyS4s23s0r9Oog+yAP6nBJgA==
X-Google-Smtp-Source: AFSGD/Xe6uBgJPyhjtiW8C/yHzDXJqHegrIC0FbW6IjCmSiUA09cndTGdk7/zDQqJ+P0kSX+mSXUuw==
X-Received: by 2002:a6b:4a09:: with SMTP id w9mr18510023iob.260.1545221078106;
        Wed, 19 Dec 2018 04:04:38 -0800 (PST)
Received: from bsingh.kernel.org ([125.16.97.116])
        by smtp.gmail.com with ESMTPSA id b91sm3393673itd.26.2018.12.19.04.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:04:37 -0800 (PST)
Subject: Re: [PATCH] hpet: Fix missing '=' character in the __setup() code of
 hpet_mmap_enable.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        trivial@kernel.org, prarit@redhat.com
References: <20181219092502.3079-1-bsingh@redhat.com>
 <20181219094627.GC11441@kroah.com>
From:   Buland Singh <bsingh@redhat.com>
Message-ID: <2c7a66e5-9488-b1a3-d08d-e4f508d3ee53@redhat.com>
Date:   Wed, 19 Dec 2018 17:34:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181219094627.GC11441@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 3:16 PM, Greg KH wrote:
> On Wed, Dec 19, 2018 at 02:55:02PM +0530, Buland Singh wrote:
>> The kernel command parameter 'hpet_mmap' never takes effect due to missing
>> '=' character in the __setup() code of hpet_mmap_enable and the memory map
>> of the HPET registers never get expose to userspace.
>>
>> Signed-off-by: Buland Singh <bsingh@redhat.com>
>> ---
>>   drivers/char/hpet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>> index 4a22b4b41aef..9bffcd37cc7b 100644
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
>>   	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
>>   	return 1;
>>   }
>> -__setup("hpet_mmap", hpet_mmap_enable);
>> +__setup("hpet_mmap=", hpet_mmap_enable);
> 
> What commit caused this bug?  Should this go to the stable kernel trees?

Hello Greg,

The commit id is 3d035f58. The bug is there since the initial patch which
introduced the kernel parameter 'hpet_mmap'. The fix should go to the
stable kernel trees.

Regards,
Buland Singh

