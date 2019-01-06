Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37856C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9452085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfAFOJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:09:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44618 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfAFOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:09:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so19533164pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 06:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rgd6dB84Md44yvPvtVZ2yuH/V3ZSZBiAqn99ljefJz4=;
        b=hG0/IQvStOFv36UueMd2PcxleLNRcEwkttzmFMZD4n7G4Fjgf42qxFOAqu3HKeN9Wu
         XzEl0KcsvLzFBNdOOZOPwmXoLzDygMOb2zVdu+y35eA3eMtlHEKhNnCziw7fEodiL1Ss
         O+HCWVUoYEAg/UWtAs3xAjd+hbqI+BYiJ0H4AU0UA3xqh4ss/PsUo2oRRUNJIUgglx8y
         XEojAQF0AWd92vZvd3+1AiEGzrRXKi4VdNnRNdBt3GK8JRYUDTa38gzr+VM8hBZzVoKu
         oXib13GzzJu3IMlEyomXs2+3qH3HNYikiClT/n4G0VF1+X+jvEzOnOWO5MJiiN1mqclX
         o4Lg==
X-Gm-Message-State: AJcUukfisZXDdtu2cBOb5pY3KX1hvsxT83JqyacBnBPzDJw+0+0UawO1
        NPG0M4scxTGp1fBAIYpQs2wUMQ==
X-Google-Smtp-Source: ALg8bN5ThljOhw8ZKeWDldbv/jHxdle6qABB21gIye9ibmfGRyl8Ttta1SfFbm8zCiQmoD8fNBMPxw==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr7550036pgd.156.1546783774636;
        Sun, 06 Jan 2019 06:09:34 -0800 (PST)
Received: from bsingh.kernel.org ([125.16.97.119])
        by smtp.gmail.com with ESMTPSA id o7sm86105875pfb.34.2019.01.06.06.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 06:09:33 -0800 (PST)
Subject: Re: [PATCH v2] hpet: Fix missing '=' character in the __setup() code
 of hpet_mmap_enable
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>, clemens@ladisch.de,
        arnd@arndb.de, prarit@redhat.com
References: <20181220120524.30732-1-bsingh@redhat.com>
 <20181220122932.GB17138@kroah.com>
 <a9704df4-53ee-5b12-2ab1-477fb7e8f083@redhat.com>
 <20181220140951.GB8621@kroah.com>
 <04420337-0df1-73ee-69d7-aa39232f495a@redhat.com>
 <20181221124603.GA7723@kroah.com>
From:   Buland Singh <bsingh@redhat.com>
Message-ID: <7ee186c2-dba9-983c-89d1-4c7e66a6f7fb@redhat.com>
Date:   Sun, 6 Jan 2019 19:39:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181221124603.GA7723@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 6:16 PM, Greg KH wrote:
> On Fri, Dec 21, 2018 at 05:48:38PM +0530, Buland Singh wrote:
>> On 12/20/18 7:39 PM, Greg KH wrote:
>>> On Thu, Dec 20, 2018 at 07:12:55PM +0530, Buland Singh wrote:
>>>> On 12/20/18 5:59 PM, Greg KH wrote:
>>>>> On Thu, Dec 20, 2018 at 05:35:24PM +0530, Buland Singh wrote:
>>>>>> Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
>>>>>> user processes")' introduced a new kernel command line parameter hpet_mmap,
>>>>>> that is required to expose the memory map of the HPET registers to
>>>>>> user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
>>>>>> broken and never takes effect due to missing '=' character in the __setup()
>>>>>> code of hpet_mmap_enable.
>>>>>>
>>>>>> Before this patch:
>>>>>>
>>>>>> dmesg output with the kernel command line parameter hpet_mmap=1
>>>>>>
>>>>>> [    0.204152] HPET mmap disabled
>>>>>>
>>>>>> dmesg output with the kernel command line parameter hpet_mmap=0
>>>>>>
>>>>>> [    0.204192] HPET mmap disabled
>>>>>>
>>>>>> After this patch:
>>>>>>
>>>>>> dmesg output with the kernel command line parameter hpet_mmap=1
>>>>>>
>>>>>> [    0.203945] HPET mmap enabled
>>>>>>
>>>>>> dmesg output with the kernel command line parameter hpet_mmap=0
>>>>>>
>>>>>> [    0.204652] HPET mmap disabled
>>>>>>
>>>>>> Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
>>>>>> Signed-off-by: Buland Singh <bsingh@redhat.com>
>>>>>> ---
>>>>>>     drivers/char/hpet.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>>>>>> index 4a22b4b41aef..9bffcd37cc7b 100644
>>>>>> --- a/drivers/char/hpet.c
>>>>>> +++ b/drivers/char/hpet.c
>>>>>> @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
>>>>>>     	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
>>>>>>     	return 1;
>>>>>>     }
>>>>>> -__setup("hpet_mmap", hpet_mmap_enable);
>>>>>> +__setup("hpet_mmap=", hpet_mmap_enable);
>>>>
>>>> Hello Greag,
>>>>
>>>>> This has _never_ worked?  Since 3.13?
>>>>
>>>> Yes, that's true :)
>>>>
>>>>> Why not just remove the thing as it is obvious no one actually has ever used it.  > That would make the code even simpler :)
>>>>
>>>> Data Plane Development Kit (DPDK)[1] provides API that requires the CONFIG_HPET_MMAP
>>>> kernel configuration option to be enabled[2]. Some end users might want to use the
>>>> HPET MMAP functionality within the application.
>>>
>>> But, obviously, they really don't need to do that from the kernel
>>> command line as no one has ever noticed this didn't work :)
>>>
>>> Also, that page:
>>>
>>>> [2] https://doc.dpdk.org/guides-18.08/linux_gsg/enable_func.html
>>>
>>> Does not say to use this command line option either.  So if no one has
>>> ever used it, please, let us just delete it.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Hello Greg,
>> It is better to allow a user to 'enable/disable' the HPET mmap from the
>> kernel command line as per the requirement rather than recompiling the
>> kernel to 'enable/disable' this functionality.
> 
> It might be "nice" but given that no one has noticed that this has never
> worked, for all of the years that this has been present, that means to
> me that no one has ever tried it because they really do not "need" it.
> 
>> Also as per the description in the initial patch (commit 3d035f58), the
>> 'CONFIG_HPET_MMAP' Kconfig option has a security risk involved. Hence,
>> keeping the CONFIG_HPET_MMAP_DEFAULT (disabled) and allowing a user to
>> alter the default behavior using the kernel command line parameter
>> hpet_mmap is a better solution.
> 
> Again, because no one has ever noticed that this was not working, why
> not just rip it out until someone speaks up as to why they have to have
> this feature and the other alternatives do not work for them?
> 
> thanks,
> 
> greg k-h
> 

Hello,

Adding Prarit to cc list for his opinion.

Regards,
--
Buland Singh



