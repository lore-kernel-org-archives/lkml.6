Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE77BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNzBb5HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9955020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeGWIjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:39:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35572 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGWIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:39:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so31599889oik.2;
        Mon, 23 Jul 2018 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A98c3pN0in+1Jsrk2GiiXzMq0ORDPtoekvKVYk8Zfp8=;
        b=jNzBb5HJ5v7wiIol9moqtNn59VypRfcdXh8VxyzXBWBK0202HgeSqMVg4b2+m64SE7
         XJGiWgpc7L9hOh7mEgFYQ3BlU4rpXctOK4Pgrdb4uqr8jHFJ88nNRCBWZtkDN0Q3N0N5
         LVh57enOFTEGnq4gWZqpcm6vpcx6YSiNhQ8fAoue+VY1z65iVQrPh6cyrG57B4GMfGXT
         pcwbqS/ugMvzNPKhmOJ6I5aKt6HHFY8QAMlCrqYQJV5AmHYeRMgZFTjKpAzKmYO6fBkk
         wGdozbsZuLbuK5X6mcHAwNDC3+jTLFJMXKzOu0tPoguxyV4M3s1ER0YaoIWjx+Nc+Oop
         pkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A98c3pN0in+1Jsrk2GiiXzMq0ORDPtoekvKVYk8Zfp8=;
        b=DV+JZXV6i2cf/mEFbvbcNbkiov4ryrWMJTBJEPkK/WrgoJkgkttnUD2RoB2mva4ACr
         ++c46nSWPmLRZVqRQuDA9oiKXP9buzN2RAoyuT0y476QG2lFw84n+GpOt0Ua+IxZY6LO
         UjHZjWdC99WLJ8tpKN1Vi879a2SN7jhRKz5mWh2tt1molg3YYHVomxpuSe+0mTRphzs2
         mOVKSc1mnZ6X67Rf12Ia7E8nFcPtcQa7OmngDlmSreLGdd/A5rdbw3D02zoBgStlKFid
         KkqeWrk8bJ/nNkFDsJy8scCReXolSJjt1HSw3lu/kNsxhUhYMNZXtnnjA9sTbVfO4qes
         whIg==
X-Gm-Message-State: AOUpUlGiGpKy0If/1w92BtzhImlIVITwPIDobzEcCgYM9DL2wiKUwYtc
        4fT6ELRQY2O5JRSdP3SLEabmdMAi6KDi0lFuW9U=
X-Google-Smtp-Source: AAOMgpduam/noMbYoiiBhp2XdxVNurD56B7pXC6zsmmOJ4Ke4ukqJMS/uIW1JmTYGeTR6FNqtTThy7H7AjaFAPdPYVQ=
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr8082600oih.58.1532331595806;
 Mon, 23 Jul 2018 00:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1113BF48AF4E3802CC29A10EA0510@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <a51f8e18-5592-5dbd-87e2-9cf42c1af16a@redhat.com>
In-Reply-To: <a51f8e18-5592-5dbd-87e2-9cf42c1af16a@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 15:39:47 +0800
Message-ID: <CANRm+Cwbo5scibX4xusibb5TJZaQ_DjeY+c2bVLzGLte94Y-Lw@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>, Tianyu.Lan@microsoft.com,
        devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 16:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/07/2018 05:58, KY Srinivasan wrote:
> >
> >
> >> -----Original Message-----
> >> From: Tianyu Lan
> >> Sent: Thursday, July 19, 2018 1:40 AM
> >> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; devel@linuxdriverproject.or=
g;
> >> Haiyang Zhang <haiyangz@microsoft.com>; hpa@zytor.com;
> >> kvm@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; linux-
> >> kernel@vger.kernel.org; mingo@redhat.com; pbonzini@redhat.com;
> >> rkrcmar@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> >> tglx@linutronix.de; x86@kernel.org; Michael Kelley (EOSG)
> >> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> >> Subject: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address
> >> space mapping flush support
> >>
> >> Hyper-V provides a para-virtualization hypercall
> >> HvFlushGuestPhysicalAddressSpace
> >> to flush nested VM address space mapping in l1 hypervisor and it's to =
reduce
> >> overhead
> >> of flushing ept tlb among vcpus. The tradition way is to send IPIs to =
all
> >> affected
> >> vcpus and executes INVEPT on each vcpus. It will trigger several vmexi=
ts for
> >> IPI and
> >> INVEPT emulation. The pv hypercall can help to flush specified ept tab=
le on all
> >> vcpus
> >> via one single hypercall.
> >>
> >> Change since v2:
> >>        - Make ept_pointers_match as tristate "check", "match" and "mis=
match".
> >>        Set "check" in vmx_set_cr3(), check all ept table pointers in
> >> hv_remote_flush_tlb()
> >>        and call hypercall when all ept pointers are same.
> >>        - Rename kvm_arch_hv_flush_remote_tlb with
> >> kvm_arch_flush_remote_tlb and
> >>        Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops-
> >>> tlb_remote_flush
> >>        - Fix issue that ignore updating tlbs_dirty during calling
> >> kvm_arch_flush_remote_tlbs()
> >>        - Merge patch "KVM/VMX: Add identical ept table pointer check" =
and
> >>        patch "KVM/x86: Add tlb_remote_flush callback support for vmx"
> >>
> >> Change since v1:
> >>        - Fix compilation error for non-x86 platform.
> >>        - Use ept_pointers_match to check condition of identical ept
> >>             table pointer and get ept pointer from struct vcpu_vmx->ep=
t_pointer.
> >>        - Add hyperv_nested_flush_guest_mapping ftrace support
> >>
> >>
> >>
> >> Lan Tianyu (4):
> >>   X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
> >>     support
> >>   X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
> >>   KVM: Add tlb remote flush callback in kvm_x86_ops.
> >>   KVM/x86: Add tlb_remote_flush callback support for vmx
> >>
> >>  arch/x86/hyperv/Makefile            |  2 +-
> >>  arch/x86/hyperv/nested.c            | 67
> >> ++++++++++++++++++++++++++++++++++
> >>  arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
> >>  arch/x86/include/asm/kvm_host.h     | 11 ++++++
> >>  arch/x86/include/asm/mshyperv.h     |  2 ++
> >>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
> >>  arch/x86/kvm/vmx.c                  | 72
> >> ++++++++++++++++++++++++++++++++++++-
> >>  include/linux/kvm_host.h            |  7 ++++
> >>  virt/kvm/kvm_main.c                 |  3 +-
> >>  9 files changed, 183 insertions(+), 3 deletions(-)
> >>  create mode 100644 arch/x86/hyperv/nested.c
> >
> > Acked-by: K. Y. Srinivasan <kys@microsoft.com>
>
> Queued, thanks!

My CONFIG_HYPERV is disabled, there is a warning when compiling kvm/queue.
warning: =E2=80=98hv_remote_flush_tlb=E2=80=99 defined but not used [-Wunus=
ed-function]
 static int hv_remote_flush_tlb(struct kvm *kvm)

Regards,
Wanpeng Li
