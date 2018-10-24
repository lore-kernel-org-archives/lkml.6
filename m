Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1661C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8F0207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQQROJYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8F0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeJYAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:46:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36385 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:46:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so4573826oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SHb51qNidXX1azSEMCSFQKhmfnfm4385+9UvNhmSAfk=;
        b=LQQROJYZOkNEYyN+cJp3zSOF1zCBVCtBDxTm7nLfGTf6phAMqXbmpQyTIIl1KAsVcB
         MHFOyo0bPnK5et/k6WL89xNiok03ptEI51Tc70rxTVgraMRVxAAJ0Z4bsuygpiXNsSM/
         ktZpPZZ2Cjbnaz08IrwdAtPGv6Ifi1BsJi46vD0JCpt6VmK19fgEkS1ODmHUlNzkk4zt
         ZujSZuLLUuGaI0Dqg8KjQdM7tQk9DzKZdYj64PaylVVMswKM8MVeb9LyAfcmZfj6C8m+
         62Ryiu3oGQTmuhPazQxFWbMiPWB1tnk7C1TMNSCobzAn199db4MgwZL+9uryRhADIXe/
         ht2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SHb51qNidXX1azSEMCSFQKhmfnfm4385+9UvNhmSAfk=;
        b=OCUsV7hrev4Fn35cvkN4DIzCc/pS84nIrjJtG+ueWGtuDImvc2QIw+MrF0OpoO8/QP
         IQ+FDH8awjTf36isig2maaSSTm4khRLFcSgTt7OSiZdtfZFRvHIu7Yf+wO/YYvdFnXjA
         TsdXw+LACFvXXA5oLsfkpPFje400rXtaAsrsx+tqEtdRyPVZkuGu1lxzkcjhc9QpM5a/
         /k/uuUwq6Qeh8erIKG1vLp4XI2VQVGSMKHPU2JLVmFR7/Hem6h+fAJiRW2n8DNpTrDZN
         Cm2I4cBxrz5xE/TNoqdEPqn3WCEge4x6oyauxTVx3/iAuABYtiPA15A1hjnwZBHCjg1m
         RoBg==
X-Gm-Message-State: AGRZ1gJN2X7lyg9ECKfMWNJacxxfF8QX3d4QnQw59hcvcuWKW0GdhJ+r
        /L0GGK5ni8ik+PxPh9SmeKj1SAm1W7Y25/oXuF6/bA==
X-Google-Smtp-Source: AJdET5e3akmf4B6QfldM1ya30TQL9dTyCM5AuLacfur/NJohpXiEWzDQFNUxByXiLw9iVGL4SBw/5CCUiVKG2hOdl3c=
X-Received: by 2002:aca:d651:: with SMTP id n78-v6mr1691698oig.287.1540397893313;
 Wed, 24 Oct 2018 09:18:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 09:18:12
 -0700 (PDT)
In-Reply-To: <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 24 Oct 2018 09:18:12 -0700
Message-ID: <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
Subject: Re: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work mode
To:     Luwei Kang <luwei.kang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, songliubraving@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        mattst88@gmail.com,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:05 AM, Luwei Kang <luwei.kang@intel.com> wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Intel Processor Trace virtualization can be work in one
> of 2 possible modes:
>
> a. System-Wide mode (default):
>    When the host configures Intel PT to collect trace packets
>    of the entire system, it can leave the relevant VMX controls
>    clear to allow VMX-specific packets to provide information
>    across VMX transitions.
>    KVM guest will not aware this feature in this mode and both
>    host and KVM guest trace will output to host buffer.
>
> b. Host-Guest mode:
>    Host can configure trace-packet generation while in
>    VMX non-root operation for guests and root operation
>    for native executing normally.
>    Intel PT will be exposed to KVM guest in this mode, and
>    the trace output to respective buffer of host and guest.
>    In this mode, tht status of PT will be saved and disabled
>    before VM-entry and restored after VM-exit if trace
>    a virtual machine.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---

> +#define SECONDARY_EXEC_PT_USE_GPA              0x01000000
> +#define VM_EXIT_CLEAR_IA32_RTIT_CTL            0x02000000
> +#define VM_ENTRY_LOAD_IA32_RTIT_CTL            0x00040000

Where are all of these bits documented? I'm looking at the latest SDM,
volume 3 (325384-067US), and none of these bits aredocumented there.

> +       GUEST_IA32_RTIT_CTL             = 0x00002814,
> +       GUEST_IA32_RTIT_CTL_HIGH        = 0x00002815,

Where is this VMCS field documented?

> +/* Default is SYSTEM mode. */
> +static int __read_mostly pt_mode = PT_MODE_SYSTEM;
> +module_param(pt_mode, int, S_IRUGO);

As a module parameter, this doesn't allow much flexibility. Is it
possible to make this decision per-VM, using a VM capability that can
be set by userspace? (In that case, it may make sense to have a module
parameter which allows/disallows the per-VM capability.)


> +static inline bool cpu_has_vmx_intel_pt(void)
> +{
> +       u64 vmx_msr;
> +
> +       rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
> +       return !!(vmx_msr & MSR_IA32_VMX_MISC_INTEL_PT);
> +}

Instead of the rdmsr here, wouldn't it be better to cache the
IA32_VMX_MISC MSR in vmcs_config?
Nit: throughout this change, the '!!' isn't necessary when casting an
integer type to bool.
