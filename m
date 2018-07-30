Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392CE16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD30320893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeG3STU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:19:20 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:51299 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeG3STU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:19:20 -0400
Received: from [192.168.1.7] (unknown [110.184.155.251])
        by APP-10 (Coremail) with SMTP id tACowAD3_8_6P19bTuzwEQ--.34045S2;
        Tue, 31 Jul 2018 00:42:36 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v2 01/17] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
To:     Paolo Bonzini <bonzini@gnu.org>, tglx <tglx@linutronix.de>,
        bp <bp@alien8.de>, "thomas.lendacky" <thomas.lendacky@amd.com>,
        mingo <mingo@redhat.com>, hpa <hpa@zytor.com>,
        peterz <peterz@infradead.org>, "tony.luck" <tony.luck@intel.com>,
        rkrcmar <rkrcmar@redhat.com>,
        "boris.ostrovsky" <boris.ostrovsky@oracle.com>,
        jgross <jgross@suse.com>, rjw <rjw@rjwysocki.net>,
        lenb <lenb@kernel.org>, "viresh.kumar" <viresh.kumar@linaro.org>,
        mchehab <mchehab@kernel.org>, trenn <trenn@suse.com>,
        shuah <shuah@kernel.org>, x86 <x86@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-2-git-send-email-puwen@hygon.cn>
 <ed090643-09da-cde7-6edd-970d973afd4d@redhat.com>
 <201807290021145963620@hygon.cn>
 <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Message-ID: <fcf29dd2-f7ea-40de-b8db-4327abd0d5f4@hygon.cn>
Date:   Tue, 31 Jul 2018 00:42:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAD3_8_6P19bTuzwEQ--.34045S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4UJw4rXr18XF45ZryUtrb_yoWrGr1fpF
        W5JFWUJw1vq3WfC34vyrW8WryFvFnxtw4UX3s8KFn7AFnxua45W39ayr4S9a4UCr1v9w17
        t3y7XF4DWw4qva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07b5sjbUUUUU=
X-Originating-IP: [110.184.155.251]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-29 07:42, Paolo Bonzini wrote:
>If the maintainers are okay with X86_FEATURE_HYGON that's certainly
>fine, however I think you can improve the consistency of the patches in
>a few ways.

Thanks for your suggestion.
To improve code consistency , will rework the patches.

>
>Lack of SME/SEV is not an issue, since there are AMD Zen chips without
>SME/SEV too, but potential incompatibility with future AMD fam18h chips
>is important.  Therefore, code like this one in amd_uncore_init
>
>
>-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> return -ENODEV;
>
> if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
> return -ENODEV;
>
>-	if (boot_cpu_data.x86 == 0x17) {
>+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
>
>should check explicitly for Hygon before checking for family 18h.  The
>same applies to the edac patch that I've just sent an answer to.

For the family number, As a JV company, to keep the consistency usage of
CPU family convention, Hygon will negotiate with AMD to make sure the CPU
family numbers both company used will not overlap. So as Hygon will use
the family 18h for Dhyana, AMD will skip the family 18h and directly use
family 19h for its new product.

Based on this assumption, this patch set direct check the family number
for 18h to see if it is Hygon processor to create a minimal patch set.

For the consistency, will modify the codes as follows:
-       if (boot_cpu_data.x86 == 0x17) {
+       if (boot_cpu_data.x86 == 0x17 ||
+          (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+           boot_cpu_data.x86 == 0x18)) {

>
>On the other hand, in many cases the AMD code is testing something like
>"AMD && family >= 0x0f".  In this case you have a mix of:
>
>- duplicate code for HYGON, such as modern_apic or mce_is_correctable
>
>- change the condition to (AMD || HYGON) && family >= 0x0f, such as
>k8_check_syscfg_dram_mod_en and amd_special_default_mtrr
>
>- change the condition to (AMD && family >= 0x0f) || (HYGON && family >=
>0x18), such as smp_quirk_init_udelay
>
>I couldn't find any case where you used (AMD && family >= 0x0f) ||
>HYGON, but I think it would be clearer in most cases than all the above
>three alternatives.

Your suggestion is correct, will try to make the code more consistent and
update the next patch set to use (AMD && family >= 0x0f) || HYGON.

>
>In general, I would duplicate code if and only if the AMD code is a maze
>of if/elseif/elseif.  In particular, code like this
>
>	case X86_VENDOR_AMD:
> if (msr >= MSR_F15H_PERF_CTL)
> return (msr - MSR_F15H_PERF_CTL) >> 1;
> return msr - MSR_K7_EVNTSEL0;
>+	case X86_VENDOR_HYGON:
>+	if (msr >= MSR_F15H_PERF_CTL)
>+	return (msr - MSR_F15H_PERF_CTL) >> 1;
>+	return msr - MSR_K7_EVNTSEL0;
>

>or this
>
>	case X86_VENDOR_AMD:
> rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
> msr = lo | ((u64)hi << 32);
> return !(msr & MSR_K7_HWCR_CPB_DIS);
>+	case X86_VENDOR_HYGON:
>+	rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>+	msr = lo | ((u64)hi << 32);
>+	return !(msr & MSR_K7_HWCR_CPB_DIS);
>
>looks a bit silly, and you already have several cases when you are not
>introducing duplication (e.g. __mcheck_cpu_init_early).  On the other
>hand, code like xen_pmu_arch_init can be very simple for Hygon and so it
>may be useful to have a separate branch.

Thanks for the suggestion, will change this by directly reusing condition
check if reused codes are direct:
+	case X86_VENDOR_HYGON:
	case X86_VENDOR_AMD:
		if (msr >= MSR_F15H_PERF_CTR)
			return (msr - MSR_F15H_PERF_CTR) >> 1;
		return msr - MSR_K7_PERFCTR0;

Also will branch codes for Hygon in case of complicated checking condition
such as in xen_pmu_arch_init().

Thanks,
Pu Wen

