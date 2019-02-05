Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FD5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24C12175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAZuQfmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfBEW4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:56:10 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53768 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBEW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:56:08 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so1794504ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWqtVzuirvjo2T+zjz7fGm4ItdnD0S+lPs/qzB59HLk=;
        b=dAZuQfmEk8J7zupKiIXgoenPdh8Ud1hCnjfXqEVHuPcpDNhCK7ZJZ0JFQGsVh6lEDO
         6NXXrPSMuD8SQfpMDlWk8KiJrZE+ltc6/2FquoK9j2n0zH+RQtFMNdT9i2QJz/DRCdk6
         7D81nDZCj9rnpJ0rNoaARzdqMye05VfTYhECWvEqj31El3yCQY8as9hU8Jc1AMcpKVCm
         +jn8TBT853VPok/J9uXXLQmy+fkYeTBMPyUmemtmdwEAEnkcHaPyGa741l1Z73FIW7IN
         +AqXATE5BJ+aTqf1v/Y4LhT0aD/g14jfkkiiuP493o1ZwEbctYJ/RdbyIaW2IBMcejyQ
         YIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWqtVzuirvjo2T+zjz7fGm4ItdnD0S+lPs/qzB59HLk=;
        b=ElmQ7To9Umu0rAo9+FYhxCo2gPZ4zHoJtIwQ1nnjjCNZG2Qt19bkt1tsqqAdn8d0Wk
         wamDO4k1l+qpnMaSF544EwIU1gFzNOnGHFyB3u7ghuksYuNtJV5Draa7sVtfs3mEox2i
         fh6KnS26KB8zM++kmjTPSG0P4sqGnufkBzrBVmBKWfS5EmpJ0rVmD7TzkDO5zThSg/pr
         EPEFae7hbcMe7TlA7xX4KebmirDECx4MT5EiADJGTWjpqwi+OrmFbl4CpGo3RK+OpKmk
         DeIRnDrk1H0ETwkZA9rdUc5Cdl4rzM+NKXhjrjzNtsyAV2X8kou8Y6/c0npjSHCzX8Ya
         MQaQ==
X-Gm-Message-State: AHQUAuaoN0GLKZUj0PnBtKkeXUsXwUR9T7qjGUZYvGLSlUA2wtIbjH3j
        gY37wOYKIEPtanTl63EKU3MsVfTZQXbb03WmPepfUQ==
X-Google-Smtp-Source: AHgI3IZpk+PIYfdPKLzTLokOjlutg1/L//a/xr035Z2IpV+KHmJbsLQWnIiLRNR4aoFsRdODohkxZL0OHnPIWIhv9oM=
X-Received: by 2002:a5d:81c3:: with SMTP id t3mr4606040iol.93.1549407366802;
 Tue, 05 Feb 2019 14:56:06 -0800 (PST)
MIME-Version: 1.0
References: <1548074920-10651-1-git-send-email-alex.popov@linux.com> <2cf80ef9-cacc-c730-7a9e-301703ddc80d@redhat.com>
In-Reply-To: <2cf80ef9-cacc-c730-7a9e-301703ddc80d@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 5 Feb 2019 14:55:55 -0800
Message-ID: <CALMp9eQ06b-x26GQX1LQ=VQ9dXPvUnEjhJgSU2fYp1xbkOiZhA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Fix single-step debugging
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 9:52 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/01/19 13:48, Alexander Popov wrote:
> > The single-step debugging of KVM guests on x86 is broken: if we run
> > gdb 'stepi' command at the breakpoint when the guest interrupts are
> > enabled, RIP always jumps to native_apic_mem_write(). Then other
> > nasty effects follow.
> >
> > Long investigation showed that on Jun 7, 2017 the
> > commit c8401dda2f0a00cd25c0 ("KVM: x86: fix singlestepping over syscall")
> > introduced the kvm_run.debug corruption: kvm_vcpu_do_singlestep() can
> > be called without X86_EFLAGS_TF set.
> >
> > Let's fix it. Please consider that for -stable.
> >
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > ---
> >  arch/x86/kvm/x86.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index f049ecf..9686068 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6407,8 +6407,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
> >               toggle_interruptibility(vcpu, ctxt->interruptibility);
> >               vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
> >               kvm_rip_write(vcpu, ctxt->eip);
> > -             if (r == EMULATE_DONE &&
> > -                 (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
> > +             if (r == EMULATE_DONE && ctxt->tf)
> >                       kvm_vcpu_do_singlestep(vcpu, &r);
> >               if (!ctxt->have_exception ||
> >                   exception_type(ctxt->exception.vector) == EXCPT_TRAP)
> >
>
> Queued, with Cc to stable and the right "Fixes" trailer.
>
> Paolo

This patch seems to imply that userspace is expected to set the
guest's RFLAGS.TF when requesting KVM_GUEST_SINGLESTEP, but the
documentation for KVM_GUEST_SINGLESTEP is not clear about this. Can
someone clarify how KVM_GUEST_SINGLESTEP is supposed to work?
