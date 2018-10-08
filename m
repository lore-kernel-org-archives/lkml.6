Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E2C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C0120652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqc5VWKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C0120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJHSJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:09:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46867 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJHSJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:09:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id o21so18871901otb.13;
        Mon, 08 Oct 2018 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HYauraNz349rvrX33twpDLpNOIEeG2x7NtAWEK5ACoE=;
        b=Hqc5VWKn6DcGDQjrP4DfN1qEmn3WvCPH8APi3MImhY/LN3U3q1FD+vWlqlbpIidmEn
         CQExPoCFLtZ5btnBcCYDRwHGDe9J8Nik6OAfW05eRaOYfnZ+M4JYHM0bZOlejUxnT498
         dfUSZ2NdQEHbuquyI3gWsiIj+uJwgZoW/69IHBWVa7B5CwslwSeIqSFQkF1oiD3WNouz
         VBTC2urb4duMPXGZOQs3ev2MuLDYd5+o0vOFGwJs19ZqVs7KnDcrFHNuQI/V1J/h+alV
         6TPZDU2VpXKWx79FFo/yozhQIeJsL20i7Ow7ILUzNlfl5jxhDzkFkIfDNRl7Rp8nj1gQ
         OiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HYauraNz349rvrX33twpDLpNOIEeG2x7NtAWEK5ACoE=;
        b=lvvRh4nlDMfWJCvQb/TxTXqtBLr9xRo+5iKOr3MPdVaeCdIJ9HJOsREgRPq+r+Dd1H
         ih03Mxs8JxtMPJe8qMOJ76CPAX80N7q9ueivDzTY8yJvvV+pAjVHCcMd7a6mnN44FZoF
         WaI+P98GF0OoSnedNOZbx1sebPLwWAYrZg3NCUuDIV2/CGhsvqcRENcAEQC6sdRzRGqK
         AHKk15g5CqiqmfN0kUAPJKYd+bbisOaRvdE2O44xeLhxdbQVR1DIPwqnmFm8PfuUoZr7
         i3dtD7uqDSOIwPmIJoi7/kWWzdxvWshRb9SqJh52aFWlvvgkoSRdmhpTnKoihpTBanar
         /J5w==
X-Gm-Message-State: ABuFfoj04RpcKVaDoqLPXTN5mLuZqodl2jkXqLB0OmlY0LjAaok98Omd
        lU0C7bbsj+M9o59hfLXjxBFU5nrEPenpIcfADhc=
X-Google-Smtp-Source: ACcGV62DPC8ig/v+4/mqAMeqUjIhpu6Die1LQV2xLHSAjFlJYE2IztFODsw2PfKfTB/j4KS4ra4VrBqAnSo/Cr9QPPw=
X-Received: by 2002:a9d:4492:: with SMTP id v18mr14527415ote.282.1538996319050;
 Mon, 08 Oct 2018 03:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <1538115136-20092-1-git-send-email-wanpengli@tencent.com> <8847332B-9759-4FF2-B6D8-02334AE11015@oracle.com>
In-Reply-To: <8847332B-9759-4FF2-B6D8-02334AE11015@oracle.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 8 Oct 2018 18:59:22 +0800
Message-ID: <CANRm+CzML6RwAOCtPFCBwccECwO+Y=DQhWD_s5mK+uCtHUCFQg@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Tune lapic_timer_advance_ns automatically
To:     Liran Alon <liran.alon@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 at 05:02, Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 28 Sep 2018, at 9:12, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > In cloud environment, lapic_timer_advance_ns is needed to be tuned for =
every CPU
> > generations, and every host kernel versions(the kvm-unit-tests/tscdeadl=
ine_latency.flat
> > is 5700 cycles for upstream kernel and 9600 cycles for our 3.10 product=
 kernel,
> > both preemption_timer=3DN, Skylake server).
> >
> > This patch adds the capability to automatically tune lapic_timer_advanc=
e_ns
> > step by step, the initial value is 1000ns as d0659d946be05 (KVM: x86: a=
dd
> > option to advance tscdeadline hrtimer expiration) recommended, it will =
be
> > reduced when it is too early, and increased when it is too late. The gu=
est_tsc
> > and tsc_deadline are hard to equal, so we assume we are done when the d=
elta
> > is within a small scope e.g. 100 cycles. This patch reduces latency
> > (kvm-unit-tests/tscdeadline_latency, busy waits, preemption_timer enabl=
ed)
> > from ~2600 cyles to ~1200 cyles on our Skylake server.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> > arch/x86/kvm/lapic.c | 7 +++++++
> > arch/x86/kvm/x86.c   | 2 +-
> > 2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index fbb0e6d..b756f12 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -70,6 +70,8 @@
> > #define APIC_BROADCAST                        0xFF
> > #define X2APIC_BROADCAST              0xFFFFFFFFul
> >
> > +static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
> > +
> > static inline int apic_test_vector(int vec, void *bitmap)
> > {
> >       return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
> > @@ -1492,6 +1494,11 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
> >       if (guest_tsc < tsc_deadline)
> >               __delay(min(tsc_deadline - guest_tsc,
> >                       nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
> > +     if (!lapic_timer_advance_adjust_done) {
> > +             lapic_timer_advance_ns +=3D (s64)(guest_tsc - tsc_deadlin=
e) / 8;
>
> I don=E2=80=99t understand how this =E2=80=9C/ 8=E2=80=9D converts betwee=
n guest TSC units to host nanoseconds.

Oh, I miss it. In addition, /8 here I mean adjust
lapic_timer_advance_ns step by step. I can observe big fluctuated
value between early and late when running real guest os like linux
instead of kvm-unit-tests. After more testing, I saw
lapic_timer_advance_ns can be overflow since the delta between
guest_tsc and tsc_deadline is too huge.

>
> I think that instead you should do something like:
> s64 ns =3D (s64)(guest_tsc - tsc_deadline) * 1000000ULL;
> do_div(ns, vcpu->arch.virtual_tsc_khz);
> lapic_timer_advance_ns +=3D ns;
>
> > +             if (abs(guest_tsc - tsc_deadline) < 100)
>
> I would put this =E2=80=9C100=E2=80=9D hard-coded value as some =E2=80=9C=
#define=E2=80=9D to make code more clear.

How about something like below:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fbb0e6d..354eb13c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -70,6 +70,9 @@
 #define APIC_BROADCAST            0xFF
 #define X2APIC_BROADCAST        0xFFFFFFFFul

+static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
+#define LAPIC_TIMER_ADVANCE_ADJUST_DONE 100
+
 static inline int apic_test_vector(int vec, void *bitmap)
 {
     return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
@@ -1472,7 +1475,7 @@ static bool lapic_timer_int_injected(struct
kvm_vcpu *vcpu)
 void wait_lapic_expire(struct kvm_vcpu *vcpu)
 {
     struct kvm_lapic *apic =3D vcpu->arch.apic;
-    u64 guest_tsc, tsc_deadline;
+    u64 guest_tsc, tsc_deadline, ns;

     if (!lapic_in_kernel(vcpu))
         return;
@@ -1492,6 +1495,19 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
     if (guest_tsc < tsc_deadline)
         __delay(min(tsc_deadline - guest_tsc,
             nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
+    if (!lapic_timer_advance_adjust_done) {
+        if (guest_tsc < tsc_deadline) {
+            ns =3D (tsc_deadline - guest_tsc) * 1000000ULL;
+            do_div(ns, vcpu->arch.virtual_tsc_khz);
+            lapic_timer_advance_ns -=3D min((unsigned int)ns,
lapic_timer_advance_ns / 8);
+        } else {
+            ns =3D (guest_tsc - tsc_deadline) * 1000000ULL;
+            do_div(ns, vcpu->arch.virtual_tsc_khz);
+            lapic_timer_advance_ns +=3D min((unsigned int)ns,
lapic_timer_advance_ns / 8);
+        }
+        if (ns < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
+            lapic_timer_advance_adjust_done =3D true;
+    }
 }

 static void start_sw_tscdeadline(struct kvm_lapic *apic)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca71773..1f3f955 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -136,7 +136,7 @@ static u32 __read_mostly tsc_tolerance_ppm =3D 250;
 module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);

 /* lapic timer advance (tscdeadline mode only) in nanoseconds */
-unsigned int __read_mostly lapic_timer_advance_ns =3D 0;
+unsigned int __read_mostly lapic_timer_advance_ns =3D 1000;
 module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
 EXPORT_SYMBOL_GPL(lapic_timer_advance_ns);
