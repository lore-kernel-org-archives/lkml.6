Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B820857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJxUR9m9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234B820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeG0VwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:52:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38295 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389584AbeG0VwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:52:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so11263310oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g8zamwCJhG2JH0emzOpTzwB/JCG1SNTehEBT1BIX3bM=;
        b=SJxUR9m9y478ApKMcfzSe1i8wG0IVMCwjk0RbQF5zqtvvskwa3kG4wHnupEEaOX73i
         o4pZADjnPmJyr6zyHbCLCpQo7oRpu1ej99KziYmNiXzYooB1tgQ16me3BdOuee0YClv5
         P4gt3fU+kSggSnZBzc/Tr9hsoC8Zr/ozHwreOWPQ1/mfCPdl49JvjCjuiaZ4ZukVrntF
         X/RnYdJXkP1xct0MJfA3GavQEFENclsw7H+ZNJayeuS5PQTSqmfTknuZKG0PLPWrxP/5
         md0qWI8XByayS56WqC44GUycavCQnfu2IHPn3UXWBEx/yuVLDBN4LyayTREmwim6nvYZ
         bYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g8zamwCJhG2JH0emzOpTzwB/JCG1SNTehEBT1BIX3bM=;
        b=qd9n79Qx262RZ4hgtLGY/c6eWhgMWm+tRdyiMj+q6TACjqvoQjAjVfu2JYir1BIaTD
         GMKFBPZ1QtWkgt5v2REY9gmAofe7j0EtzJDncH6HeQu3ukdPdcg3iH288uZqXaRSV5Ci
         lYVYeonYzZWtOAaPFcRYVe9HQpgQaqqT/8LLRoX7sOZjP8F+DhJzxX5r9J46p9uU3B82
         Hp9OlvBLuzYeaTj4mjKBvZl3QKWRzk0bX2pIJcX4K+9F7a7b4UCOxD4uCjjXtiMh/xTp
         1rZEK5UOIrBTpPHBy+YQUIRYEq8voZSJxeb4VwJuYJYG8odgCb267dgjC1R8CeYnT+/u
         Kxvw==
X-Gm-Message-State: AOUpUlHtel8Lb6YIAOXLzCVBUDF/mR+5ggdD/BaHKdkNXk/xPwg5ef5j
        R3wPblGoDjOaGSnOdPKQB1m9sCep9NLcfehom1hv1Q==
X-Google-Smtp-Source: AAOMgpfi5HMNjiw9SBgFWUA2/eFNOz7wTCgpxcrAQ9JQ3eua0zEDEeGpsgDp2Ta2uP+8LPdcAGM0W0zO/+jjNa1wrK0=
X-Received: by 2002:aca:ec46:: with SMTP id k67-v6mr8600091oih.81.1532723322030;
 Fri, 27 Jul 2018 13:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 13:28:41
 -0700 (PDT)
In-Reply-To: <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 13:28:41 -0700
Message-ID: <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        "open list:USER-MODE LINUX (UML)" 
        <user-mode-linux-user@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:41 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Feb 8, 2017 at 12:09 AM, Kyle Huey <me@kylehuey.com> wrote:
>> Hardware support for faulting on the cpuid instruction is not required to
>> emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
>> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
>> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
>> kvm_require_cpl is even kind enough to inject the GP fault for us.
>>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> Reviewed-by: David Matlack <dmatlack@google.com>
>> ---
>> ...
>> @@ -7613,16 +7636,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>
>>         kvm_clear_async_pf_completion_queue(vcpu);
>>         kvm_async_pf_hash_reset(vcpu);
>>         vcpu->arch.apf.halted = false;
>>
>>         if (!init_event) {
>>                 kvm_pmu_reset(vcpu);
>>                 vcpu->arch.smbase = 0x30000;
>> +
>> +               vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
>> +               vcpu->arch.msr_misc_features_enables = 0;
>
> Jim, I assume you're worried about this bit?  It seems like
> msr_platform_info should maybe be initialized to zero to avoid causing
> an unintended migration issue.

Initializing this bit to zero helps with migration, but then if the
CPUID faulting bits in both MSRs are set, userspace has to take pains
to ensure that MSR_PLATFORM_INFO is restored first, or the
MSR_MISC_FEATURES_ENABLES value will be rejected.

I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
feeding into someone's calculated TSC frequency.
