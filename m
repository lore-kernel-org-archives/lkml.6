Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C86C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8325701
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phuNDwy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB8325701
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936144AbeF3KFE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:05:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39080 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934077AbeF3KE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:04:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so1915399oib.6;
        Sat, 30 Jun 2018 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMKgtBgwBs2NQxoA+pqhzkcW4VxhWNcSOwckUHcRIvs=;
        b=phuNDwy1bgA6QDXXwEjb+5kL2RONfdM9wOCXZ9MGi8aacdFs3pu0/o8HF2Nceu+UBh
         Khz6e9SQJL4R6JOMCV5TK8emHDGEjzn5cQGMk09dhkQzmnOmqI3h6SnCac3k23um5cjc
         6Y8iko6A1IQ9D+dPwDBlwioEMhiHzFUR4tpAz7mZlcGx4+qOLAropHFnJ6jUYxSyYUff
         Da+BbaLa6npocL9UjWdvx/tb1sx8E0uwy0VDcea/Kif9DaWBx0ZBnGpjcMnQnk8dLxsf
         fet4VXnvCWgqe05r4cMOkbOyjHpwYzd5U90X28vSMW8nnvOC9DmeOF3suropoPfaZFHs
         sKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMKgtBgwBs2NQxoA+pqhzkcW4VxhWNcSOwckUHcRIvs=;
        b=bGVcdQmZUS76Xo+nNolNocm39M4iXGJaKybcC3MtucFPT+SIVWKRQ30TxjHSptSXA8
         jEtVhmc5mggK/jllv/VhVqRJn/MixXvcl3s9NEYu79CLwgHtRS7e6n7rf24cwykXyrXJ
         PcTylfqBKRFhJVZJK5rOSbt/4ytMBQyJZRBISVh1HO8RJO71az8dOoJXbLmTlRfmsU3n
         mZs2gFICZTVoG6P9HohBSRD+y3QKc1sJC8bc+4jZlS3T7qOPyAHhC+FgdocBcRXITHNn
         WHgjBA+i+lOvvHz8ilXnNJZWGAXEDHTftGw78WxeQH9r0/iRGMkFUk6RcbwhNXiSXTZP
         U1Lw==
X-Gm-Message-State: APt69E27USB1so81en4FlnH92iswknlZSqqjvtgdxKN3wsq70H9AyERv
        pMrZmCpTcKdfoyLCYZqf5waWwHMbQOAKqliH5JE=
X-Google-Smtp-Source: AAOMgpcTywQ2vaa5+dFMqjhHGyqdi19jStc3w3fXSKYxfrnUyB69YDl90+5L3TVptPlmNMGwCnS0XVQh1qgnDqGnJls=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr2808000oie.233.1530353099248;
 Sat, 30 Jun 2018 03:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
 <1530265876-18136-3-git-send-email-wanpengli@tencent.com> <96bad133-077d-e27d-9f57-4df6399eb3b8@redhat.com>
In-Reply-To: <96bad133-077d-e27d-9f57-4df6399eb3b8@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sat, 30 Jun 2018 18:04:47 +0800
Message-ID: <CANRm+CwjHX7Dr61aFHoSEftrj-nPMpyj9DGktg8wzXJ-zzNuFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: X86: Implement PV send IPI support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 at 18:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/06/2018 11:51, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Using hypercall to send IPIs by one vmexit instead of one by one for
> > xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluste=
r
> > mode.
> >
> > Even if enable qemu interrupt remapping and PV TLB Shootdown, I can sti=
ll
> > observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the
> > total msr-induced vmexits reduce ~70%.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  Documentation/virtual/kvm/cpuid.txt |  4 ++++
> >  arch/x86/kvm/cpuid.c                |  3 ++-
> >  arch/x86/kvm/x86.c                  | 25 +++++++++++++++++++++++++
> >  include/uapi/linux/kvm_para.h       |  1 +
> >  4 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtua=
l/kvm/cpuid.txt
> > index ab022dc..d72359f 100644
> > --- a/Documentation/virtual/kvm/cpuid.txt
> > +++ b/Documentation/virtual/kvm/cpuid.txt
> > @@ -62,6 +62,10 @@ KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || parav=
irtualized async PF VM exit
> >                                     ||       || can be enabled by setti=
ng bit 2
> >                                     ||       || when writing to msr 0x4=
b564d02
> >  ----------------------------------------------------------------------=
--------
> > +KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this featu=
re bit
> > +                                   ||       || before enabling paravir=
tualized
> > +                                   ||       || send IPIs.
>
> It's not "enabling" but "using".  You also need to document the
> hypercall itself.

Will fix it in v2.

Regards,
Wanpeng Li
