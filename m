Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E08CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeHMTFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:05:34 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:50199 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbeHMTFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:05:33 -0400
Received: from [192.168.1.7] (unknown [110.184.152.220])
        by APP-10 (Coremail) with SMTP id tACowAAnL8c4sHFbVnMBAQ--.5355S2;
        Tue, 14 Aug 2018 00:22:17 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq
 driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <cover.1533989492.git.puwen@hygon.cn>
 <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
 <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com>
Message-ID: <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
Date:   Tue, 14 Aug 2018 00:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAAnL8c4sHFbVnMBAQ--.5355S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fArykKrWDuF45KF4fAFb_yoW8ZFW7pF
        W5WFWjyF4UXFs3C342yw4UJFyY9Fn2ya4UKryUK3sYvF45uFW5WryqkF45Wr98Xrn5Gr42
        y3WDXw1Igw4Yyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU7CJmUUUUU
X-Originating-IP: [110.184.152.220]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/12 17:55, Rafael J. Wysocki wrote:
> On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
>>
>> Enable ACPI cpufreq driver support for Hygon by adding family ID check
>> along with AMD.
>>
>> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
>> support to function amd_freq_sensitivity_init().
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Is there any technical difference between HYGON and AMD?

For ACPI cpufreq patch, you are right. But for the whole point of view,
there has some technical difference between Hygon Dhyana and AMD Family
17h.
For cpufreq if not added X86_VENDOR_HYGON codes, this driver will not
work functionally on Hygon platforms.

> 
> You seem to be mechanically adding X86_VENDOR_HYGON wherever
> X86_VENDOR_AMD is used.

X86_VENDOR_HYGON is not mechanically added wherever X86_VENDOR_AMD is
used, we have reviewed and tested the features wherever X86_VENDOR_HYGON
is needed.

As Hygon Dhyana can share code path with AMD family 17h, to minimize the
code duplication, we choose to reuse the AMD's codes here.

Thanks,
Pu Wen

> 
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
>>   drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index b61f4ec..d62fd37 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -61,6 +61,7 @@ enum {
>>
>>   #define INTEL_MSR_RANGE                (0xffff)
>>   #define AMD_MSR_RANGE          (0x7)
>> +#define HYGON_MSR_RANGE                (0x7)
>>
>>   #define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
>>
>> @@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
>>                  rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>>                  msr = lo | ((u64)hi << 32);
>>                  return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>> +       case X86_VENDOR_HYGON:
>>          case X86_VENDOR_AMD:
>>                  rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>>                  msr = lo | ((u64)hi << 32);

