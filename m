Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283720658
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B283720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbeHPQ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:28:13 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:50538 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbeHPQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:28:12 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowACXYu0qfHVbIyTNAQ--.17029S2;
        Thu, 16 Aug 2018 21:29:15 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com,
        JBeulich@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <cover.1533989492.git.puwen@hygon.cn>
 <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
 <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
 <0aa44410-47ec-27e2-10d9-c0dc5d2e457a@suse.com>
 <150f6a8d-33e8-a84d-f34b-17bdb7264ebe@oracle.com>
Message-ID: <16c21c53-2a03-d5fe-9232-8c0e377566a7@hygon.cn>
Date:   Thu, 16 Aug 2018 21:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <150f6a8d-33e8-a84d-f34b-17bdb7264ebe@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowACXYu0qfHVbIyTNAQ--.17029S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF18Gw1kGr1rWw43Gr4kJFb_yoWDGFbE9F
        WUCr1Uu3yvv3W0qan5Gr15ArsxJrsYkrWjgFyjyFWUAFW3A345GF13KrWvkr18twsxGrnI
        kwn2kws8K3ya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUzgAwUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/12 21:26, Boris Ostrovsky wrote:
> On 08/12/2018 04:55 AM, Juergen Gross wrote:
>> On 11/08/18 16:34, Boris Ostrovsky wrote:
>>> On 08/11/2018 09:29 AM, Pu Wen wrote:
>>>>   bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
>>>>   {
>>>> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>>>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>>>
>>> 'if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)' please.
>> Really? Xen supports Centaur, too.
> 
> VPMU doesn't --- hypervisor will not initialize it. Besides, the
> existing code will steer non-AMD execution to Intel, which is not right
> either.
> 
> I'll add a check to bail if VPMU is not initialized properly, we seem to
> ignore xen_pmu_init() failures. Which, BTW, makes this patch rather
> pointless until there is support for Hygon Xen.

So should it still need to test vendor Hygon here or wait for your check
done?

Thanks,
Pu Wen

