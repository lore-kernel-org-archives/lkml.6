Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4220842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqE4vu7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD4220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbeG0W1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:27:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44123 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbeG0W1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:27:32 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so11397955oih.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dAf+q5uZJdFty79H+woEwbuw89ltcUxVjRgYA8EiT5o=;
        b=NqE4vu7HLDk/vjjGp0LIuH5IL4wSHjUpBkcwIgpVfkURRdq5lGlsOUBX7eqPSZkJbu
         vz+EyWgT1H4OhgiQ8xzUxbu+i3rwmCnZ6BPn+IY6a/NCZY5c0xayJdIC46SEF8n2d4L+
         Ah2sC+X/NscsGwLBM37FCO3QVfQabS9zLJOuMPOVLbshoPNeB6VFkrxdRh/V1wYwrHTc
         SwynmAV8+64UKpNdvhFYxEdN5g13YByy3Z+T/txQuWux8aCrJqqdli1Kc9Q3+yrEVJMN
         C0tzfHOBh384XyadpM13WLHr0Jm7E255iTFFQtCki3u0B0XNjVoxREOex/yj1e67wQGX
         raOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dAf+q5uZJdFty79H+woEwbuw89ltcUxVjRgYA8EiT5o=;
        b=MoaTZ/CNrBUZtmf3J7pFqf5UHiCQnJGTkwqNMxE+OzuKYx3xhZaBMvSUcz3qwUgPw0
         609n4HC4imAJCxVweNP9qcj2IKLgdMB62ZuonOefpKERX4vYLXKgKLS8LuDGra5uD0aA
         uB1R35DYgOsaurj4xyMPDUYmF8EaaJMH1E60RKR7BK+fEltBQ5Qc5Os/6g+//gUhQBay
         csbNfGi19+wxdy8uvGXP9IN4j9Ea0PyQt8uD1YXvOSVDG6kTxqDA14ll9SOeGkF0lp//
         pZs+9m1Lxf+2K2WLLVBd6ZFHAa2yxt/WwFqT+DszSOVUTFOq1goEsbCfucvzMngWudvo
         4mJQ==
X-Gm-Message-State: AOUpUlGbcW6Ub3D3MD+X3YTg5J2U954wZ2v+Yd2Cf6vCIgSk0mQzwpZJ
        JrfH78JHP/eGOyrf26bhC8Def94E/4DuckkOKnB9QQ==
X-Google-Smtp-Source: AAOMgpeQjipby0lZvQ0FxssNu7FeSb+2WX+Bw9SPG7ujXrS+o/XW78GuN3OVB7rAQwvWZ3+cpxyoMUfbuUoz6Qe9H58=
X-Received: by 2002:aca:efd7:: with SMTP id n206-v6mr8952930oih.70.1532725433510;
 Fri, 27 Jul 2018 14:03:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 14:03:52
 -0700 (PDT)
In-Reply-To: <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com> <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 14:03:52 -0700
Message-ID: <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 1:46 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> On Jul 27, 2018, at 1:28 PM, Jim Mattson <jmattson@google.com> wrote:
>> Initializing this bit to zero helps with migration, but then if the
>> CPUID faulting bits in both MSRs are set, userspace has to take pains
>> to ensure that MSR_PLATFORM_INFO is restored first, or the
>> MSR_MISC_FEATURES_ENABLES value will be rejected.
>
> The code could drop the constraint and just let the entry possibly fail i=
f the MSRs are set wrong

That would be an improvement, I think.

>> I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
>> feeding into someone's calculated TSC frequency.
>
> Hmm. I don=E2=80=99t have a good answer to that. Are there any real CPUs =
that have this MSR but don=E2=80=99t have that field?

No. The reason I bring this up is that a customer has code that
expects to be able to derive the TSC frequency from this MSR (per
Intel's instructions in SDM volume 3, section 18.7.3), and they were
surprised to find that the MSR raises #GP on our platform. We're
looking into cherry-picking this support from upstream as a start, but
I know the customer would be unhappy to read zero from bits 15:8.
