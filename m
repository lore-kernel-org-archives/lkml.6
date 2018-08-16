Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2AC2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2AC2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbeHPQVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:21:12 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:48696 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731048AbeHPQVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:21:12 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowACnrWF7enVbitnMAQ--.8593S2;
        Thu, 16 Aug 2018 21:22:04 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com,
        jgross@suse.com, JBeulich@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <cover.1533989492.git.puwen@hygon.cn>
 <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
 <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
Message-ID: <d8e2dfb0-a2ff-5376-c39f-83626f257fda@hygon.cn>
Date:   Thu, 16 Aug 2018 21:22:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: tACowACnrWF7enVbitnMAQ--.8593S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UZr1UArW8Gw13WFyUWrg_yoW8Jw1rpr
        Z3AF1FyFW8urn2qas3A34kXryj9F1vvr4rCr43Ka13Ar909r90vFWrArnYgFykC3y8Jr10
        vryY9F1xCFZavaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU7RwZUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/11 22:34, Boris Ostrovsky wrote:
> On 08/11/2018 09:29 AM, Pu Wen wrote:
>> To make Xen work correctly on Hygon platforms, reuse AMD's Xen support
>> code path and add vendor check for Hygon along with AMD.
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> ---
>>   arch/x86/xen/pmu.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
>> index 7d00d4a..1053dda 100644
>> --- a/arch/x86/xen/pmu.c
>> +++ b/arch/x86/xen/pmu.c
>> @@ -90,6 +90,12 @@ static void xen_pmu_arch_init(void)
>>   			k7_counters_mirrored = 0;
>>   			break;
>>   		}
>> +	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		amd_num_counters = F10H_NUM_COUNTERS;
> 
> I haven't looked in details at Zen's PMU but the PMC section in the spec
> starts with
>    "There are six core performance events counters per thread..."

There are six core performance events counters per thread, so there are
six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
they are alias of the counters(0-3).

In this version of kernel Zen use the lagacy version of PMU MSRs for Xen.
For safety consideration, Dhyana just fullow this stategy. And it works
fine when VPMU enabled in Xen on Hygon platforms by testing with perf.

Thanks,
Pu Wen

