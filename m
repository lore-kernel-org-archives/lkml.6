Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F41320895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="oxvgiyIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F41320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbeG0WJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:09:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44512 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbeG0WJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:09:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3867717pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RsX8RTCn6/cO8NIE+mAWEJg/Q8Os81gZ7TxKhJQu0cg=;
        b=oxvgiyICCqiUMQEtCTIXZoVgX5fx7IR1bWBtVf2wZRuRxS451GrCyq2pAamkrWSsze
         EY0m/sLkr5BfiCIsIwIeDuIbp+0/Z1vWAhb+i+DTlGA7ZcsWtqNViMuMLp9OB7cTQZtp
         F/mDjN+R4rRCgGXm08WDY/8/cHJh7slY07S8mW4OSdSCb7Q1IXV+hHVG+xC19acmf0S1
         tR/1bJilenNkXl/xGiOImGKDagcM7BiKRF3HYSC7Zz94nEPeFkG/Q7eQZqjvfq6PIox5
         WzcdDlpFXTyEyXvGkNAx+TU1lKQAwiA18mJxx/nqO2Neowa9s2BJMdZ2rbOWnISs30cs
         gbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RsX8RTCn6/cO8NIE+mAWEJg/Q8Os81gZ7TxKhJQu0cg=;
        b=S6GUvMQPlQh4JV7++eTtpSibCzQnS7FsyAVNFe1SLs5f4EFEj833Cm3ycthaaVsfSL
         QPMyUfMUUZOyQDiQWe95HxXuf6gLzmm6KOvPIkSXkVDrt7UUK9NANrz8qhCxKz4iAJ4q
         0RbFKaD3Ff1Lyn7SPli6/jYfWgNThcmUU/POW4VC/ZMiAlamtwi4cpppnzDBdcjbtfbS
         EIzEhzSWm0V6lBL4Q7kj7iMUS9Vtvvq4kTmyLSy/eemBC8AtsUZWuDyjYm+CRat2XpJn
         Fm7WE6In5PqhN06XxQVRq5XKFArDAome1rABeZ2TAO16OC7kGlHP/FYvZ5rk4X3mfynT
         Q6gQ==
X-Gm-Message-State: AOUpUlGxulRODV/ZOQr1qI9TNZcW9GSven4hfDhByI/+/XDU0a4kXit+
        B1v1Cg6jRrAuY9gMGI19ABDWzw==
X-Google-Smtp-Source: AAOMgpfN53HnD0GDrS/kolKMvuI4InNSXZeg77UHzkwykOXnQh8k4vcGr/AwmhnrpvuOwGc19kdcAg==
X-Received: by 2002:a63:ac57:: with SMTP id z23-v6mr7203192pgn.74.1532724370107;
        Fri, 27 Jul 2018 13:46:10 -0700 (PDT)
Received: from ?IPv6:2600:1010:b060:8c99:8451:6653:eac8:e7c1? ([2600:1010:b060:8c99:8451:6653:eac8:e7c1])
        by smtp.gmail.com with ESMTPSA id g85-v6sm14032573pfk.39.2018.07.27.13.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 13:46:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
Date:   Fri, 27 Jul 2018 13:46:06 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com> <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com> <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
To:     Jim Mattson <jmattson@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2018, at 1:28 PM, Jim Mattson <jmattson@google.com> wrote:
>=20
>> On Fri, Jul 27, 2018 at 12:41 PM, Andy Lutomirski <luto@kernel.org> wrote=
:
>>> On Wed, Feb 8, 2017 at 12:09 AM, Kyle Huey <me@kylehuey.com> wrote:
>>> Hardware support for faulting on the cpuid instruction is not required t=
o
>>> emulate it, because cpuid triggers a VM exit anyways. KVM handles the re=
levant
>>> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
>>> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
>>> kvm_require_cpl is even kind enough to inject the GP fault for us.
>>>=20
>>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>>> Reviewed-by: David Matlack <dmatlack@google.com>
>>> ---
>>> ...
>>> @@ -7613,16 +7636,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool i=
nit_event)
>>>=20
>>>        kvm_clear_async_pf_completion_queue(vcpu);
>>>        kvm_async_pf_hash_reset(vcpu);
>>>        vcpu->arch.apf.halted =3D false;
>>>=20
>>>        if (!init_event) {
>>>                kvm_pmu_reset(vcpu);
>>>                vcpu->arch.smbase =3D 0x30000;
>>> +
>>> +               vcpu->arch.msr_platform_info =3D MSR_PLATFORM_INFO_CPUID=
_FAULT;
>>> +               vcpu->arch.msr_misc_features_enables =3D 0;
>>=20
>> Jim, I assume you're worried about this bit?  It seems like
>> msr_platform_info should maybe be initialized to zero to avoid causing
>> an unintended migration issue.
>=20
> Initializing this bit to zero helps with migration, but then if the
> CPUID faulting bits in both MSRs are set, userspace has to take pains
> to ensure that MSR_PLATFORM_INFO is restored first, or the
> MSR_MISC_FEATURES_ENABLES value will be rejected.

The code could drop the constraint and just let the entry possibly fail if t=
he MSRs are set wrong

>=20
> I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
> feeding into someone's calculated TSC frequency.

Hmm. I don=E2=80=99t have a good answer to that. Are there any real CPUs tha=
t have this MSR but don=E2=80=99t have that field?=
