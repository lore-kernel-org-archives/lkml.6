Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A110ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE0B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFPXsI+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE0B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeGQRLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:11:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44292 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbeGQRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:11:22 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so1432176qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVl6GJqhfYFsJMteXPZTO8wEstZfHR+++EOjxPqmbb8=;
        b=VFPXsI+Ddr4En7+uM+SxQz8glTogb1BX1e/ZO039uYTHj4D4CgxOTnSMxQc2m9PiZq
         WS+LsvLsp6qDsQZF6biu90JnOAvyEHocCwCZ7F5HessbSF8y7Ob5rX941NtkeJOE3lMp
         jfwp5W+2QVtMkCZns/OiOPW8t6TZJDdG7G+EbGyp8IL7aP498JSgQV8drFPuYBoYudLV
         Q2ZJRhhy3P1JQLmGBxVJffIsohnalcp6Ao7qoccHr80ibOB6wI5A9YzOnBMKGRXOy0Iu
         UQElaXYQxY8N5UVQr8qL07/dnMG7e2uJLI2kv/PMI95aIyHzjhLGkLGQDbBOMFug0RfF
         Wqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVl6GJqhfYFsJMteXPZTO8wEstZfHR+++EOjxPqmbb8=;
        b=Az4nv+bPAFOdE2/gajHS4sIhlXfKvPAIV2Ksw1dOmCILYFoW+i/K4ujYVcKcZnzDFo
         zzkE6MeQGJsLNdfRA+A1ngjWeG/m6EOrouXOLqX06krYUaW2m0RSLGlbTeW1jozye6UC
         wvTo2DTQUaXATaKY4t+t1+yhUdzLmcIhXDq7ihx6WeJdbUJ5BR1n0sX+o8sNcXLicvwz
         qmm6wcwmKqYKQfe95h4VxVskx8FBB6XWCd+tyhQr9kRp2KZ+BEh+HHWBSzrEwDRn2Byc
         jcUTCgjisN7zkNYPpX/yKZodMPEXsCawCHZtnGxntYiYkDx3pGmzIPae4jo2CcEg2awD
         d9eQ==
X-Gm-Message-State: AOUpUlEecrZpG6y9qXvqvI8VHanxN5d5gVRBBnhsqixxY8RnBX7ahm1Q
        77q0XyGpH8xPmJCLBXmcYA==
X-Google-Smtp-Source: AAOMgpf2YSpiSzM+YoDGATXXKli6FjFA5dlbt1CRzsBAXf9HV+U/n0fcu39Kb6ezE2of6twCeFZJJA==
X-Received: by 2002:a0c:99ec:: with SMTP id y44-v6mr2586538qve.226.1531845472766;
        Tue, 17 Jul 2018 09:37:52 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a19-v6sm1325285qta.50.2018.07.17.09.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 09:37:52 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
To:     kan.liang@linux.intel.com, mingo@kernel.org, kan.liang@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
 <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
 <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <1677c9ca-a522-ae7e-6a1f-86c3767a35f8@gmail.com>
Date:   Tue, 17 Jul 2018 12:37:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/16/2018 12:31 PM, Liang, Kan wrote:
> 
> 
> On 7/16/2018 11:07 AM, Masayoshi Mizuma wrote:
>>
>>
>> On 07/16/2018 10:29 AM, Liang, Kan wrote:
>>>
>>>
>>> On 7/15/2018 6:34 PM, Ingo Molnar wrote:
>>>>
>>>> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>>>>
>>>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>>>>
>>>>> commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
>>>>> Broadwell CPUs") introduced PCU.3 for Broadwell CPU. Unfortunately,
>>>>> the driver_data of PCU.3 conflicts to QPI Port 2 filter.
>>>>>
>>>>>       { /* QPI Port 2 filter  */
>>>>>               PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
>>>>>               .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
>>>>>
>>>>>       { /* PCU.3 (for Capability registers) */
>>>>>               PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
>>>>>               .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>>>>>                                                  HSWEP_PCI_PCU_3),
>>>>>                                // HSWEP_PCI_PCU_3 == 2
>>>>
>>>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>>>> @@ -1030,6 +1030,7 @@ enum {
>>>>>        SNBEP_PCI_QPI_PORT0_FILTER,
>>>>>        SNBEP_PCI_QPI_PORT1_FILTER,
>>>>>        HSWEP_PCI_PCU_3,
>>>>> +    BDX_PCI_PCU_3,
>>>>>    };
>>>>
>>>> So we use a magic '2' enumerator in the 'QPI Port 2 filter', and that overlaps
>>>> with HSWEP_PCI_PCU_3, right?
>>>>
>>>> Shouldn't we clean up all the enumerators and not use magic numbers, and this fix
>>>> the conflict?
>>>>
>>>
>>> Yes, it should fix the conflict. I will clean up the code.
>>
>> Thanks a lot!
>> I would appreciate if you could add CC to me when you post the patch.
>>
> 
> Here is the patch.
> 
> Masa, could you please give it a try?

Thank you for the patch, it works well!

Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks,
Masa

> 
> Thanks,
> Kan
> 
> From 688378a4003ec33156958a52dc822105c18075af Mon Sep 17 00:00:00 2001
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Mon, 16 Jul 2018 04:57:51 -0400
> Subject: [PATCH] perf/x86/intel/uncore: Fix hardcode index of Broadwell extra PCI DEV
> 
> Masa reports that a warning message is shown while CPU hot-removing on
> Broadwell server.
> 
>   WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
>   uncore_pci_remove+0x10b/0x150
>   Call Trace:
>    pci_device_remove+0x42/0xd0
>    device_release_driver_internal+0x148/0x220
>    pci_stop_bus_device+0x76/0xa0
>    pci_stop_root_bus+0x44/0x60
>    acpi_pci_root_remove+0x1f/0x80
>    acpi_bus_trim+0x57/0x90
>    acpi_bus_trim+0x2e/0x90
>    acpi_device_hotplug+0x2bc/0x4b0
>    acpi_hotplug_work_fn+0x1a/0x30
>    process_one_work+0x174/0x3a0
>    worker_thread+0x4c/0x3d0
>    kthread+0xf8/0x130
> 
> This bug was introduced in:
> 
>   commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
> Broadwell CPUs")
> 
> The index of "QPI Port 2 filter" was hardcode to 2. The index of
> "PCU.3" used enumerator "HSWEP_PCI_PCU_3", which equals to 2 as well.
> 
> To fix the conflict, the hardcode index needs to be cleaned up.
> Introduce a new enumerator "BDX_PCI_QPI_PORT2_FILTER" for "QPI Port 2
> filter" on Broadwell, and increase the UNCORE_EXTRA_PCI_DEV_MAX.
> Clean up hardcode index.
> 
> Reported-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
> Broadwell CPUs")
> ---
>  arch/x86/events/intel/uncore.h       |  2 +-
>  arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index c9e1e0b..e17ab88 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -28,7 +28,7 @@
>  #define UNCORE_PCI_DEV_TYPE(data)    ((data >> 8) & 0xff)
>  #define UNCORE_PCI_DEV_IDX(data)    (data & 0xff)
>  #define UNCORE_EXTRA_PCI_DEV        0xff
> -#define UNCORE_EXTRA_PCI_DEV_MAX    3
> +#define UNCORE_EXTRA_PCI_DEV_MAX    4
> 
>  #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 87dc026..51d7c11 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
>  enum {
>      SNBEP_PCI_QPI_PORT0_FILTER,
>      SNBEP_PCI_QPI_PORT1_FILTER,
> +    BDX_PCI_QPI_PORT2_FILTER,
>      HSWEP_PCI_PCU_3,
>  };
> 
> @@ -3286,15 +3287,18 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
>      },
>      { /* QPI Port 0 filter  */
>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> +                           SNBEP_PCI_QPI_PORT0_FILTER),
>      },
>      { /* QPI Port 1 filter  */
>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> +                           SNBEP_PCI_QPI_PORT1_FILTER),
>      },
>      { /* QPI Port 2 filter  */
>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
> -        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
> +        .driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> +                           BDX_PCI_QPI_PORT2_FILTER),
>      },
>      { /* PCU.3 (for Capability registers) */
>          PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
