Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1818DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAED2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnt1VyrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeLNWbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:31:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35346 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:31:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so1650847vke.2;
        Fri, 14 Dec 2018 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1aXsQu9yk6+RQb278EvNnMC6crwN3ixF95JlXBTg5B4=;
        b=qnt1VyrTUsBFFg8bMZs/8P84bIl8kifun+vi2QRIHyJ9zsy5k6eZvEyCTdyZ0SBcYy
         48v9MAfy4O4ZsfYud6FW9903I7DdM0xP+VfKXBKZfhMB/qHasiWxSptAd9BuicJ38RqC
         ptzYKOOGXHsDUf3RnBF8Qxao4q15TbBqA5oIR39KOV+koXhG/amQeDtcM405ga66nDo9
         hqZd7aj+R+Yz9AtBkp4jfD5XQRiwOkYrrcq+Gi9XcuWNcUj74vGolu5aQI857c3fgi+2
         x3Kh+6tOynPja1fUc1a7NXA321txMws9mGQJbuaDc3iwRRgo0utlV9deigkPu6vJUxkW
         nncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1aXsQu9yk6+RQb278EvNnMC6crwN3ixF95JlXBTg5B4=;
        b=QhvxTo8yxwsGLCkXGnKYB4vOWrl+uyXGbpxKWqfoKAmM8gyNlbhm0cKNW025pqobO8
         zRsPXmFD5pJb2Ast/IxfBttEN4y+QqdNI4XK2hqzW5gzpGs3cAIke5+L/vmhl6I9UAo/
         16kuEQS4wIQ0OSKzLHd3H2TlWP9JMHrK6+6q6Fn0bu8EmY0uW7SDAG+KpeKxBzXHcYzg
         2/QmBo4yVAFJJYv39m7ReeiMtvNwnMlh+163Hz0N39f9FvY7boQfZMW5d3bErYG/Aw3J
         at/9jSPS441P2k/c7LcFSpeGKm82FYXgmolAZS+8NPVJVyo4A5TVTbWtnieB5bzWux3o
         5t3Q==
X-Gm-Message-State: AA+aEWYLx7CePf+ZXbGvS1UDGMtb0nCxlq2H/ev869lEgQQzCHkUgwis
        SVUWaJOT8LAnYCCPaZgb7v82i9Y42K1pV4nXRhE=
X-Google-Smtp-Source: AFSGD/Xu8zz10yAibznyL7tmWADFlIsar+MPEhx6wi8b+C3ypFNldBkJFmbp6ZZSzdCaV+VS7VMxpK9Pab6sBK/Zw4Y=
X-Received: by 2002:a1f:f8cf:: with SMTP id w198mr2149238vkh.82.1544826672105;
 Fri, 14 Dec 2018 14:31:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:4401:0:0:0:0:0 with HTTP; Fri, 14 Dec 2018 14:31:11
 -0800 (PST)
In-Reply-To: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com> <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
From:   gengdongjiu <gengdj.1984@gmail.com>
Date:   Sat, 15 Dec 2018 06:31:11 +0800
Message-ID: <CAMj-D2D_fsOS1La3HGV2=bys5KjeQ0=fskrAL1V9FEkUTHFo1w@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     James Morse <james.morse@arm.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>, peter.maydell@linaro.org,
        rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI James,

      Thanks for the mail and comments, I will reply to you in the next mail.

2018-12-14 21:55 GMT+08:00, James Morse <james.morse@arm.com>:
> Hi Dongjiu Geng,
>
> On 14/12/2018 10:15, Dongjiu Geng wrote:
>> When user space do memory recovery, it will check whether KVM and
>> guest support the error recovery, only when both of them support,
>> user space will do the error recovery. This patch exports this
>> capability of KVM to user space.
>
> I can understand user-space only wanting to do the work if host and guest
> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
> kernel feature.
>
> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying
> to
> map a page at stage2 that the kernel-mm code refuses this because its
> poisoned.
> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>
> This is exactly the same as happens to a normal user-space process.
>
> I think you really want to know if the host kernel was built with
> CONFIG_MEMORY_FAILURE. The not-at-all-portable way to tell this from
> user-space
> is the presence of /proc/sys/vm/memory_failure_* files.
> (It looks like the prctl():PR_MCE_KILL/PR_MCE_KILL_GET options silently
> update
> an ignored policy if the kernel isn't built with CONFIG_MEMORY_FAILURE, so
> they
> aren't helpful)
>
>
>> diff --git a/Documentation/virtual/kvm/api.txt
>> b/Documentation/virtual/kvm/api.txt
>> index cd209f7..241e2e2 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4895,3 +4895,12 @@ Architectures: x86
>>  This capability indicates that KVM supports paravirtualized Hyper-V IPI
>> send
>>  hypercalls:
>>  HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
>> +
>> +8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
>> +
>> +Architectures: arm, arm64
>> +
>> +This capability indicates that guest memory error can be detected by the
>> KVM which
>> +supports the error recovery.
>
> KVM doesn't detect these errors.
> The hardware detects them and notifies the OS via one of a number of
> mechanisms.
> This gets plumbed into memory_failure(), which sets a flag that the mm code
> uses
> to prevent the page being used again.
>
> KVM is only involved when it tries to map a page at stage2 and the mm code
> rejects it with -EHWPOISON. This is the same as the architectures
> do_page_fault() checking for (fault & VM_FAULT_HWPOISON) out of
> handle_mm_fault(). We don't have a KVM cap for this, nor do we need one.
>
>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index b72a3dd..90d1d9a 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm,
>> long ext)
>>  		r = kvm_arm_support_pmu_v3();
>>  		break;
>>  	case KVM_CAP_ARM_INJECT_SERROR_ESR:
>> +	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
>>  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>>  		break;
>
> The CPU RAS Extensions are not at all relevant here. It is perfectly
> possible to
> support memory-failure without them, AMD-Seattle and APM-X-Gene do this.
> These
> systems would report not-supported here, but the kernel does support this
> stuff.
> Just because the CPU supports this, doesn't mean the kernel was built with
> CONFIG_MEMORY_FAILURE. The CPU reports may be ignored, or upgraded to
> SIGKILL.
>
>
>
> Thanks,
>
> James
>
