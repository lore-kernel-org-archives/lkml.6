Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3102895-1519914520-2-10597163201067753103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519914520; b=HiMd+igL39kPzJWtTA9V42sVkyeD0GSVg4f1fEKAywaN95x
    XooqrbyHxZ8skyEDAsXHqvWLPDd2MAvoRcdQOgw0UaqahprUWJMrR/MtvmD1Y3O9
    1AEPZVT9S6UpoHJV3Vd3WCHLBxc17FGtRgMPh2TIcp3BSmvFtazifDw3bAc+oQMM
    xMRiZLirVX5aI/I/AToVD4vxN3Bqsn9nQsrMilQr0OuItI6hDNZOQd7HPrXfqsC+
    AxC5xPFEnbeN10V9ZUE6bhYza14phbkflA8XANPIiy+KHjit5l5PjZAJRUl8zDHW
    LlgRd18huOsqEotX2i5Jl/NeMvtzYm2rWfLumsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519914520; bh=DeKJfDR20HE2tMNUTCDNP1m2fXJ7hpEHZl8IipYDJBM=; b=g
    2fLXqa+hn1F2ddMNl3Po3dctVKU+tz1yBriXWqVVMdCiPYt7ImllNLMwxbPPGHRC
    JlXY3DLJs9G4wWS1vBfzuPNHKEce1uojywnhcxIgXySM4rHHkI2F54+O0CEqjIem
    2jwode1jk00wqd0MgNZam4gERWEeKb6aiQ7+wwF0UvKfii0z/GY5lTa8JN3slci8
    0AatYoukoUwu3l4XC81mcNYmAXgUvDkW2BpGWGpjND3yFgTc8f+Ujl4A1yKbfl/m
    aXyszxxQmfTedF/Q/49GH0/FKs5td9ktJ0iC7bUeUC9bcjS+w6r+/YLPOkUZMRXd
    TIS+vWzPpmGnHAhibVOCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vCxaRLpq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jcJzwtY3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vCxaRLpq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jcJzwtY3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031520AbeCAO1x (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 09:27:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45387 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031485AbeCAO1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 09:27:49 -0500
X-Google-Smtp-Source: AG47ELvtziS2/mX0haaKF328cJ/yJl65cX0xHgE741XyphoS4geIM5UVDujz4QzktYDThA9LeZYCDlE+N4ngy0UV3RM=
MIME-Version: 1.0
In-Reply-To: <20180301142425.18550-1-rkrcmar@redhat.com>
References: <20180301142425.18550-1-rkrcmar@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Mar 2018 15:27:28 +0100
Message-ID: <CACT4Y+ad=y2pakP-v83vF3N27ohj4_KErCZ4TkDuw71qd93hmg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: fix vcpu initialization with userspace lapic
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 3:24 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat=
.com> wrote:
> Moving the code around broke this rare configuration.
> Use this opportunity to finally call lapic reset from vcpu reset.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>

This was reported by syzbot:
https://groups.google.com/d/msg/syzkaller-bugs/QrDXoM_mQRk/mT2cebykBQAJ

Please add the
Reported-by: syzbot+fb7a33a4b6c35007a72b@syzkaller.appspotmail.com
tag so that syzbot will know when it's fixed.

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: 0b2e9904c159 ("KVM: x86: move LAPIC initialization after VMCS crea=
tion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 10 ++++------
>  arch/x86/kvm/x86.c   |  3 ++-
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index cc5fe7a50dde..391dda8d43b7 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2002,14 +2002,13 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u6=
4 value)
>
>  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> -       struct kvm_lapic *apic;
> +       struct kvm_lapic *apic =3D vcpu->arch.apic;
>         int i;
>
> -       apic_debug("%s\n", __func__);
> +       if (!apic)
> +               return;
>
> -       ASSERT(vcpu);
> -       apic =3D vcpu->arch.apic;
> -       ASSERT(apic !=3D NULL);
> +       apic_debug("%s\n", __func__);
>
>         /* Stop the timer in case it's a reset to an active apic */
>         hrtimer_cancel(&apic->lapic_timer.timer);
> @@ -2568,7 +2567,6 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
>
>         pe =3D xchg(&apic->pending_events, 0);
>         if (test_bit(KVM_APIC_INIT, &pe)) {
> -               kvm_lapic_reset(vcpu, true);
>                 kvm_vcpu_reset(vcpu, true);
>                 if (kvm_vcpu_is_bsp(apic->vcpu))
>                         vcpu->arch.mp_state =3D KVM_MP_STATE_RUNNABLE;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1a3ed81031f1..3f96b51d0495 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8123,7 +8123,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>         kvm_vcpu_mtrr_init(vcpu);
>         vcpu_load(vcpu);
>         kvm_vcpu_reset(vcpu, false);
> -       kvm_lapic_reset(vcpu, false);
>         kvm_mmu_setup(vcpu);
>         vcpu_put(vcpu);
>         return 0;
> @@ -8166,6 +8165,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>
>  void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> +       kvm_lapic_reset(vcpu, init_event);
> +
>         vcpu->arch.hflags =3D 0;
>
>         vcpu->arch.smi_pending =3D 0;
> --
> 2.15.1
>
