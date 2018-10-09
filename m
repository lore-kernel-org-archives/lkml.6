Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C138C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DC9213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLB7lWJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DC9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJIJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:22:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44702 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJIJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:22:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so5533otf.11;
        Mon, 08 Oct 2018 19:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nb+cq16IQFcnQGzJeb1i7tYlf+kGRWrg66iqq8vetiM=;
        b=MLB7lWJTl11AGDK7ktke3bXNnJfDTvVFEOSSS8HohlrUNFwSLVLyFX3gPGc22rFbZE
         RrGJ5KrERXPul36cL4LqWkuHrzlyn0KJVHvOFGtyk57nRDouNI0ufBZoxDPMhu5xVOOP
         It6Lu5yw7yZq/6HQi378iAYpekkcaOzdDtR5QgxIuD/30n0jKxNQQpRneD+C52QOZVjW
         Yc1/rYL+aYpfyLtCBjpaJaj8MJu/ay9EhG84RBuZtx8IH/D3SOJfTY7szmHgw/c3PRqg
         LJNO3NJ8COlTnPVN44PAosnUfXcle29N/wZyH5FtrNLPLfZ+whgbQ8SwvmHC+JDRU6eU
         DVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nb+cq16IQFcnQGzJeb1i7tYlf+kGRWrg66iqq8vetiM=;
        b=Q4FOYK7IIDD7P66P6C8n2wrDk91LD2jce/hJqLiZkqTS3EnE9BpmG1D+0K1iRdOs4g
         osGsFJaYzmq26oonKBGr9usPRPOdWpeHhNsY+8kDsZ7YOXbQk4KVmxw1ootOXyPGWwOr
         yyuejV2/ZemRvuOq8suCw+R0eMKuod1oMHKVy+PSXx3pDJGgM/UwYBeYJLdo/Gz891Dv
         nJRL1fTUu2ksCx5t6sMj2tAJejx6ohSaaH32SL1Cx0oIgNlWT0+cQAVslCkIlw8qoefh
         A1g3cGhViHAEraIenwBTMO1iBba5JY/id4guEgiJObYY0grh7+iq+G57nt42v/Cb8VQ+
         6hNg==
X-Gm-Message-State: ABuFfojC4a6fqSFaMf0abYvi8vF1FL/f7PsIXvZ6oCHHOY/ezJOY542/
        ZsTUz6vvejulCaqjGFQcUnXACfJpOgIfW39of1iNiw==
X-Google-Smtp-Source: ACcGV61zAt+5YvEEySyhzzy8bKZxL58FK+U5NJ7ZbAlYEdH3Fki12BUxVrlkNXoiGD/sQzPm2Af7iq9hdIUi2OJ5J1A=
X-Received: by 2002:a9d:4590:: with SMTP id x16mr10514509ote.258.1539050867505;
 Mon, 08 Oct 2018 19:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538115136-20092-1-git-send-email-wanpengli@tencent.com>
 <8847332B-9759-4FF2-B6D8-02334AE11015@oracle.com> <CANRm+CzML6RwAOCtPFCBwccECwO+Y=DQhWD_s5mK+uCtHUCFQg@mail.gmail.com>
 <5A4E140E-BC3D-46E4-AF7B-E8053FD4C683@oracle.com>
In-Reply-To: <5A4E140E-BC3D-46E4-AF7B-E8053FD4C683@oracle.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 9 Oct 2018 10:08:35 +0800
Message-ID: <CANRm+Cx1AKXnvqPxvY+vgKULS+hq=JTaNoSL7qnNoQ90NcAWTQ@mail.gmail.com>
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

On Mon, 8 Oct 2018 at 20:04, Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 8 Oct 2018, at 13:59, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > On Mon, 8 Oct 2018 at 05:02, Liran Alon <liran.alon@oracle.com> wrote:
> >>
> >>
> >>
> >>> On 28 Sep 2018, at 9:12, Wanpeng Li <kernellwp@gmail.com> wrote:
> >>>
> >>> From: Wanpeng Li <wanpengli@tencent.com>
> >>>
> >>> In cloud environment, lapic_timer_advance_ns is needed to be tuned fo=
r every CPU
> >>> generations, and every host kernel versions(the kvm-unit-tests/tscdea=
dline_latency.flat
> >>> is 5700 cycles for upstream kernel and 9600 cycles for our 3.10 produ=
ct kernel,
> >>> both preemption_timer=3DN, Skylake server).
> >>>
> >>> This patch adds the capability to automatically tune lapic_timer_adva=
nce_ns
> >>> step by step, the initial value is 1000ns as d0659d946be05 (KVM: x86:=
 add
> >>> option to advance tscdeadline hrtimer expiration) recommended, it wil=
l be
> >>> reduced when it is too early, and increased when it is too late. The =
guest_tsc
> >>> and tsc_deadline are hard to equal, so we assume we are done when the=
 delta
> >>> is within a small scope e.g. 100 cycles. This patch reduces latency
> >>> (kvm-unit-tests/tscdeadline_latency, busy waits, preemption_timer ena=
bled)
> >>> from ~2600 cyles to ~1200 cyles on our Skylake server.
> >>>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> >>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >>> ---
> >>> arch/x86/kvm/lapic.c | 7 +++++++
> >>> arch/x86/kvm/x86.c   | 2 +-
> >>> 2 files changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> >>> index fbb0e6d..b756f12 100644
> >>> --- a/arch/x86/kvm/lapic.c
> >>> +++ b/arch/x86/kvm/lapic.c
> >>> @@ -70,6 +70,8 @@
> >>> #define APIC_BROADCAST                        0xFF
> >>> #define X2APIC_BROADCAST              0xFFFFFFFFul
> >>>
> >>> +static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
> >>> +
> >>> static inline int apic_test_vector(int vec, void *bitmap)
> >>> {
> >>>      return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
> >>> @@ -1492,6 +1494,11 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
> >>>      if (guest_tsc < tsc_deadline)
> >>>              __delay(min(tsc_deadline - guest_tsc,
> >>>                      nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
> >>> +     if (!lapic_timer_advance_adjust_done) {
> >>> +             lapic_timer_advance_ns +=3D (s64)(guest_tsc - tsc_deadl=
ine) / 8;
> >>
> >> I don=E2=80=99t understand how this =E2=80=9C/ 8=E2=80=9D converts bet=
ween guest TSC units to host nanoseconds.
> >
> > Oh, I miss it. In addition, /8 here I mean adjust
> > lapic_timer_advance_ns step by step. I can observe big fluctuated
>
> If that=E2=80=99s the case, I would also put the =E2=80=9C8=E2=80=9D as a=
 #define to make it more clear of it=E2=80=99s purpose.
>
> > value between early and late when running real guest os like linux
> > instead of kvm-unit-tests. After more testing, I saw
> > lapic_timer_advance_ns can be overflow since the delta between
> > guest_tsc and tsc_deadline is too huge.
> >
> >>
> >> I think that instead you should do something like:
> >> s64 ns =3D (s64)(guest_tsc - tsc_deadline) * 1000000ULL;
> >> do_div(ns, vcpu->arch.virtual_tsc_khz);
> >> lapic_timer_advance_ns +=3D ns;
> >>
> >>> +             if (abs(guest_tsc - tsc_deadline) < 100)
> >>
> >> I would put this =E2=80=9C100=E2=80=9D hard-coded value as some =E2=80=
=9C#define=E2=80=9D to make code more clear.
> >
> > How about something like below:
> >
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index fbb0e6d..354eb13c 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -70,6 +70,9 @@
> > #define APIC_BROADCAST            0xFF
> > #define X2APIC_BROADCAST        0xFFFFFFFFul
> >
> > +static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
> > +#define LAPIC_TIMER_ADVANCE_ADJUST_DONE 100
> > +
> > static inline int apic_test_vector(int vec, void *bitmap)
> > {
> >     return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
> > @@ -1472,7 +1475,7 @@ static bool lapic_timer_int_injected(struct
> > kvm_vcpu *vcpu)
> > void wait_lapic_expire(struct kvm_vcpu *vcpu)
> > {
> >     struct kvm_lapic *apic =3D vcpu->arch.apic;
> > -    u64 guest_tsc, tsc_deadline;
> > +    u64 guest_tsc, tsc_deadline, ns;
> >
> >     if (!lapic_in_kernel(vcpu))
> >         return;
> > @@ -1492,6 +1495,19 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
> >     if (guest_tsc < tsc_deadline)
> >         __delay(min(tsc_deadline - guest_tsc,
> >             nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
> > +    if (!lapic_timer_advance_adjust_done) {
> > +        if (guest_tsc < tsc_deadline) {
> > +            ns =3D (tsc_deadline - guest_tsc) * 1000000ULL;
> > +            do_div(ns, vcpu->arch.virtual_tsc_khz);
> > +            lapic_timer_advance_ns -=3D min((unsigned int)ns,
> > lapic_timer_advance_ns / 8);
> > +        } else {
> > +            ns =3D (guest_tsc - tsc_deadline) * 1000000ULL;
> > +            do_div(ns, vcpu->arch.virtual_tsc_khz);
> > +            lapic_timer_advance_ns +=3D min((unsigned int)ns,
> > lapic_timer_advance_ns / 8);
> > +        }
> > +        if (ns < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
>
> Didn=E2=80=99t you meant to compare here that abs(guest_tsc - tsc_deadlin=
e) < LAPIC_TIMER_ADVANCE_ADJUST_DONE?
> This is also a good example on why I would also rename LAPIC_TIMER_ADVANC=
E_ADJUST_DONE to something
> which indicates it represents a number in guest TSC units.

Done in v2.

Regards,
Wanpeng Li
