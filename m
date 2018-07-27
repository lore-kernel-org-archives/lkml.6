Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6CA208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbNt/KSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6CA208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbeG0SXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:23:00 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33149 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbeG0SW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:22:59 -0400
Received: by mail-qk0-f194.google.com with SMTP id 27-v6so3710948qkv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7kUhz4iRpkT/SHlFMVfOW3f5JfC7cKLRjPwIZdZJ6mY=;
        b=HbNt/KSk0rnKJmuwVxKvsiJLasLcmMcr7+C50pr3IDYI3ekATcP9iC7ni3d0kBZm4O
         e9lVQc/w8o57FgmMs6BtEKPfR5AHvRgg389OlhY1tCHlFZzUGFt/yHmwxXm60XBvmsQZ
         PrOHlm1kX+kJTtgDolBji8nFKSIT7p6dDKT2KwuTWc1iKlA/mc9IQK1heIXcGPUwTbWS
         79qpN1fjarxywty5j57wHhoEEH/pVVE2PxjG1gsr6xT7S1D4x3sW+F2UKLB0imlUFNkJ
         p0TwbzGHDafheJ+MQoNTqrirLl3/GauDcOBTTukxI0ULA0hLy+82jbyJ/FdyGxzlxLyb
         JUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kUhz4iRpkT/SHlFMVfOW3f5JfC7cKLRjPwIZdZJ6mY=;
        b=T064m4KsICWxiIOFgY1ht5ALJYT5bGUvBqlz8iPHHhbuQNMSKenALs64aEWgQmC6bI
         7d86HvW++uxlECSl+2aTGT8NZ5wnjtHYjtG82I8P6+rAjnMYsdde3jJH6NupFpuS1PaS
         O5kY4CLySEJXow+nsTMnMgsvrpa/WQO8pBI0IlEQRkgPw6Om2fKeIyNyCYtj5BmmQmjS
         OrW0X9vpOwv5y/SyperDJvLxLUMHxzAeT+qmLlbAIWlnan1UOnoQOdBsHK0KQ95Mk+EF
         gYT+POqKLnqon0OB/36k1Y0iEV08KCBynO4RqIVS/2IdxPP0HwAkWG31hiEpXyPWUZ55
         3RGQ==
X-Gm-Message-State: AOUpUlEojie6560nc8L6/SYwIYDPErxY3LHSua8bzhFLYJMHQXjfzuWO
        900OEFDR1bbvdXvPYtGELw==
X-Google-Smtp-Source: AAOMgpffA11ZnTjopQ1fh9c9LMk9caGV1Mklqjxt9PsEm5k+agUzzMWjG7aNhejilg2Rv2cFU9KtGg==
X-Received: by 2002:a37:284a:: with SMTP id o71-v6mr6399111qkh.176.1532710813333;
        Fri, 27 Jul 2018 10:00:13 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z18-v6sm4421561qtz.89.2018.07.27.10.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:00:12 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     mingo@kernel.org
Cc:     kan.liang@linux.intel.com, kan.liang@intel.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
 <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
 <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
 <1677c9ca-a522-ae7e-6a1f-86c3767a35f8@gmail.com>
Message-ID: <3aed5057-7328-90aa-3c35-7c143866aaf0@gmail.com>
Date:   Fri, 27 Jul 2018 13:00:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1677c9ca-a522-ae7e-6a1f-86c3767a35f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Is the following Kan's patch ready to merge...?

Thanks,
Masa

On 07/17/2018 12:37 PM, Masayoshi Mizuma wrote:
...
>> Here is the patch.
>>
>> Masa, could you please give it a try?
> 
> Thank you for the patch, it works well!
> 
> Please feel free to add:
> 
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Thanks,
> Masa
> 
>>
>> Thanks,
>> Kan
>>
>> From 688378a4003ec33156958a52dc822105c18075af Mon Sep 17 00:00:00 2001
>> From: Kan Liang <kan.liang@linux.intel.com>
>> Date: Mon, 16 Jul 2018 04:57:51 -0400
>> Subject: [PATCH] perf/x86/intel/uncore: Fix hardcode index of Broadwell extra PCI DEV
>>
>> Masa reports that a warning message is shown while CPU hot-removing on
>> Broadwell server.
>>
>>   WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
>>   uncore_pci_remove+0x10b/0x150
>>   Call Trace:
>>    pci_device_remove+0x42/0xd0
>>    device_release_driver_internal+0x148/0x220
>>    pci_stop_bus_device+0x76/0xa0
>>    pci_stop_root_bus+0x44/0x60
>>    acpi_pci_root_remove+0x1f/0x80
>>    acpi_bus_trim+0x57/0x90
>>    acpi_bus_trim+0x2e/0x90
>>    acpi_device_hotplug+0x2bc/0x4b0
>>    acpi_hotplug_work_fn+0x1a/0x30
>>    process_one_work+0x174/0x3a0
>>    worker_thread+0x4c/0x3d0
>>    kthread+0xf8/0x130
>>
>> This bug was introduced in:
>>
>>   commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>> Broadwell CPUs")
>>
>> The index of "QPI Port 2 filter" was hardcode to 2. The index of
>> "PCU.3" used enumerator "HSWEP_PCI_PCU_3", which equals to 2 as well.
>>
>> To fix the conflict, the hardcode index needs to be cleaned up.
>> Introduce a new enumerator "BDX_PCI_QPI_PORT2_FILTER" for "QPI Port 2
>> filter" on Broadwell, and increase the UNCORE_EXTRA_PCI_DEV_MAX.
>> Clean up hardcode index.
>>
>> Reported-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>> Broadwell CPUs")
>> ---
>>  arch/x86/events/intel/uncore.h       |  2 +-
>>  arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index c9e1e0b..e17ab88 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -28,7 +28,7 @@
>>  #define UNCORE_PCI_DEV_TYPE(data)    ((data >> 8) & 0xff)
>>  #define UNCORE_PCI_DEV_IDX(data)    (data & 0xff)
>>  #define UNCORE_EXTRA_PCI_DEV        0xff
>> -#define UNCORE_EXTRA_PCI_DEV_MAX    3
>> +#define UNCORE_EXTRA_PCI_DEV_MAX    4
>>
>>  #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 87dc026..51d7c11 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
>>  enum {
>>      SNBEP_PCI_QPI_PORT0_FILTER,
>>      SNBEP_PCI_QPI_PORT1_FILTER,
>> +    BDX_PCI_QPI_PORT2_FILTER,
>>      HSWEP_PCI_PCU_3,
>>  };
>>
>> @@ -3286,15 +3287,18 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
>>      },
>>      { /* QPI Port 0 filter  */
>>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
>> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
>> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>> +                           SNBEP_PCI_QPI_PORT0_FILTER),
>>      },
>>      { /* QPI Port 1 filter  */
>>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
>> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
>> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>> +                           SNBEP_PCI_QPI_PORT1_FILTER),
>>      },
>>      { /* QPI Port 2 filter  */
>>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
>> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>> +                           BDX_PCI_QPI_PORT2_FILTER),
>>      },
>>      { /* PCU.3 (for Capability registers) */
>>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
