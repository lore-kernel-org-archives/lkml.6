Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F306C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98321906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbeLUMSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:18:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36264 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeLUMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:18:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2463461pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 04:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tYajQfXn2haHQMP9WLk4eyze4RiRp3DRQkG/GKdMfEc=;
        b=WNx4CCxaSrQ3CaTAiVw7r4ngfMdHi5gOs1cgiDNFVEyBv9LfF8kQmDhegixEZP0Z2V
         DNhrFXuw5hClERVva2oumodlUSiKYTMzP8fwjksIBU4zi5vuHt1MAn4oO4lO/kq3OYIg
         ucHeq/jNCgPFHFjQN0CoESCyRzMNgaRNhCTnKczgu2jdL9JcXVtwZKnpTQTMTIgJVAu6
         OBkVuF5keYchBZNiA1+EK7qrHUsQpEY23SwoyJKja0G+Ps/TjPa/PuKrlKaabcgZS2xH
         cqCt2+p8+RPhJhOwloe6KLIPdkIZbfFrGFudPUEVp+Zuz4ht6bs10t6bk0C9Gjvcs0FT
         i7cw==
X-Gm-Message-State: AJcUukd92FgSA/pkFW5eTRc5V1phwN53PQIzyU/b/MehzLNXZkdkhcTF
        Bwbi+KNiJTlM7iJDBsrTJoIBRA==
X-Google-Smtp-Source: ALg8bN6+VmRsmltlkpm/nsiTMmAbysDYmnYvlwhtPCha/LmiU31/IxJb4vM1avCjLdeoQ+nBu560jA==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr2160784pgh.211.1545394723185;
        Fri, 21 Dec 2018 04:18:43 -0800 (PST)
Received: from bsingh.kernel.org ([125.16.97.126])
        by smtp.gmail.com with ESMTPSA id b5sm60518743pfc.150.2018.12.21.04.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 04:18:42 -0800 (PST)
Subject: Re: [PATCH v2] hpet: Fix missing '=' character in the __setup() code
 of hpet_mmap_enable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181220120524.30732-1-bsingh@redhat.com>
 <20181220122932.GB17138@kroah.com>
 <a9704df4-53ee-5b12-2ab1-477fb7e8f083@redhat.com>
 <20181220140951.GB8621@kroah.com>
From:   Buland Singh <bsingh@redhat.com>
Message-ID: <04420337-0df1-73ee-69d7-aa39232f495a@redhat.com>
Date:   Fri, 21 Dec 2018 17:48:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181220140951.GB8621@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 7:39 PM, Greg KH wrote:
> On Thu, Dec 20, 2018 at 07:12:55PM +0530, Buland Singh wrote:
>> On 12/20/18 5:59 PM, Greg KH wrote:
>>> On Thu, Dec 20, 2018 at 05:35:24PM +0530, Buland Singh wrote:
>>>> Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
>>>> user processes")' introduced a new kernel command line parameter hpet_mmap,
>>>> that is required to expose the memory map of the HPET registers to
>>>> user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
>>>> broken and never takes effect due to missing '=' character in the __setup()
>>>> code of hpet_mmap_enable.
>>>>
>>>> Before this patch:
>>>>
>>>> dmesg output with the kernel command line parameter hpet_mmap=1
>>>>
>>>> [    0.204152] HPET mmap disabled
>>>>
>>>> dmesg output with the kernel command line parameter hpet_mmap=0
>>>>
>>>> [    0.204192] HPET mmap disabled
>>>>
>>>> After this patch:
>>>>
>>>> dmesg output with the kernel command line parameter hpet_mmap=1
>>>>
>>>> [    0.203945] HPET mmap enabled
>>>>
>>>> dmesg output with the kernel command line parameter hpet_mmap=0
>>>>
>>>> [    0.204652] HPET mmap disabled
>>>>
>>>> Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
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
>>
>> Hello Greag,
>>
>>> This has _never_ worked?  Since 3.13?
>>
>> Yes, that's true :)
>>
>>> Why not just remove the thing as it is obvious no one actually has ever used it.  > That would make the code even simpler :)
>>
>> Data Plane Development Kit (DPDK)[1] provides API that requires the CONFIG_HPET_MMAP
>> kernel configuration option to be enabled[2]. Some end users might want to use the
>> HPET MMAP functionality within the application.
> 
> But, obviously, they really don't need to do that from the kernel
> command line as no one has ever noticed this didn't work :)
> 
> Also, that page:
> 
>> [2] https://doc.dpdk.org/guides-18.08/linux_gsg/enable_func.html
> 
> Does not say to use this command line option either.  So if no one has
> ever used it, please, let us just delete it.
> 
> thanks,
> 
> greg k-h
> 

Hello Greg,
                                                                            
It is better to allow a user to 'enable/disable' the HPET mmap from the
kernel command line as per the requirement rather than recompiling the
kernel to 'enable/disable' this functionality.
                                                                            
Also as per the description in the initial patch (commit 3d035f58), the
'CONFIG_HPET_MMAP' Kconfig option has a security risk involved. Hence,
keeping the CONFIG_HPET_MMAP_DEFAULT (disabled) and allowing a user to
alter the default behavior using the kernel command line parameter
hpet_mmap is a better solution.

Regards,
Buland Singh

