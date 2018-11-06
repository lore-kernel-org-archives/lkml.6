Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96339C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="04IKQHjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbeKGGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:35:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43545 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbeKGGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:35:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so6781830plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 13:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j/p4Rkoi1f8osFSfUldINn+hQAee4qZ2uYwdF+ITjj4=;
        b=04IKQHjye1aJ6ChMu0ak3em2+V9j5vjNQHj3zO+hBaQHNFVCWrBKOocwI6WeAqW4/Z
         daGsDMCnPyebmeMXiRWbN59xEDjI0fuGBcC+793l9jBeOvXAJTmi0od4SpQESmSH71or
         c/aYANAkWrsxUt9SCPfesKFb0fy50CSuPQOetH5iw4QLXLn22U7fhXzhpf407Az6NFV+
         0TKqTib/aff76vlt8iKwVaFYNsETXcJVR++GtavggEO+a85wulAwGJ7hS186IoRViED9
         WjDwR21nYqsJpGnoMJhGLjjMDb+EEKceKFmhoywYQ934un6tWOfI1xtnyKe4vAXeTuaS
         VMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j/p4Rkoi1f8osFSfUldINn+hQAee4qZ2uYwdF+ITjj4=;
        b=Ihil27bfjMZaJO5RdouFMf43WHEaH1gh/+8XkcjlMc59x3M8F1qPxjCPGOfRP8YyP7
         9fn9xrPlXxjbrBA1pzxEvUHNvseSjY5UJvKqtUl8JSWkYhf59UmXhHqWlEHnai0wqUR0
         FqeTkm1grEJL5DBRb+W2OJ8nkXZWaKxiSsoTEJjhXpzOF6lRsNmHm3KIqplYff2KXOsZ
         trRV9cpK0lh4IcdTQlv/grqkJ6OE8SVfxwcikVFgXLlY4hEiiuBOaBunJm0NWAitPivp
         Z0au3uvrnwn2xZWxR4k3OX9p16tQUouu0JkGPqXaPJIcbvXT9kxB6Kv+yetTdkmpL/zn
         4f6Q==
X-Gm-Message-State: AGRZ1gJS/rdlwmE4zBG+BpUJEuH/J8Cq6RoJ2f0pg1uWmjpm+WCXT6d4
        lpG/Tm6psMUJb/mTqYc5U82cXA==
X-Google-Smtp-Source: AJdET5fmIbggkMcOEeXnvRRDjr0zRYUzW12145z1rJdUDXP3urYr1L7XvE9G7d6tMrpTBBaPgEoN7w==
X-Received: by 2002:a17:902:4523:: with SMTP id m32-v6mr4461946pld.276.1541538476331;
        Tue, 06 Nov 2018 13:07:56 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:8c77:2d31:8ab8:32d8? ([2601:646:c200:7429:8c77:2d31:8ab8:32d8])
        by smtp.gmail.com with ESMTPSA id b11-v6sm36889995pgi.10.2018.11.06.13.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 13:07:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: RFC: userspace exception fixups
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <209cf4a5-eda9-2495-539f-fed22252cf02@intel.com>
Date:   Tue, 6 Nov 2018 13:07:54 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Carlos O'Donell <carlos@redhat.com>,
        adhemerval.zanella@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B76E95B-5745-412E-8007-7FAA7F83D6FB@amacapital.net>
References: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com>
 <20181102170627.GD7393@linux.intel.com> <a4d2b3ec-43ec-f062-e180-c6e5a0d9fab8@intel.com>
 <20181102173350.GF7393@linux.intel.com> <CALCETrUQVPN0LSEz+5aNsbfFc=rQ33JHiOoRXVbvEEb9is9DDQ@mail.gmail.com>
 <20181102182712.GG7393@linux.intel.com> <CAG48ez0x7ZPcKvLt01WS-VrLm59WfvYE3nE1xbnyn3Qsp5T2rA@mail.gmail.com>
 <20181102220437.GI7393@linux.intel.com> <CAG48ez1+nGDbuBaKJVPAOzEwiBkXqHHs7vmyAqvbeM42r0nFHg@mail.gmail.com>
 <CALCETrXq1Kj=McxnPVjkscNq-b_7LeoFOdu7qKjHdvwcfFh9Og@mail.gmail.com>
 <1541518670.7839.31.camel@intel.com> <AF4A5C77-0A79-403F-A205-0F93B7CD6E26@amacapital.net>
 <1541524750.7839.51.camel@intel.com> <22596E35-F5D1-4935-86AB-B510DCA0FABE@amacapital.net>
 <c9659222-efc6-b73a-ce48-30be8bdc5397@intel.com> <CALCETrWBV=1JbAKYn2Jy2LxkGZQvKRtFRnrWUMoejrwQe73VHw@mail.gmail.com>
 <b9c53669-cd27-e3bc-3d62-f47c77029c43@intel.com> <1C426267-492F-4AE7-8BE8-C7FE278531F9@amacapital.net>
 <209cf4a5-eda9-2495-539f-fed22252cf02@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2018, at 1:00 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 11/6/18 12:12 PM, Andy Lutomirski wrote:
>> True, but what if we have a nasty enclave that writes to memory just
>> below SP *before* decrementing SP?
>=20
> Yeah, that would be unfortunate.  If an enclave did this (roughly):
>=20
>    1. EENTER
>    2. Hardware sets eenter_hwframe->sp =3D %sp
>    3. Enclave runs... wants to do out-call
>    4. Enclave sets up parameters:
>        memcpy(&eenter_hwframe->sp[-offset], arg1, size);
>        ...
>    5. Enclave sets eenter_hwframe->sp -=3D offset
>=20
> If we got a signal between 4 and 5, we'd clobber the copy of 'arg1' that
> was on the stack.  The enclave could easily fix this by moving ->sp first.=

>=20
> But, this is one of those "fun" parts of the ABI that I think we need to
> talk about.  If we do this, we also basically require that the code
> which handles asynchronous exits must *not* write to the stack.  That's
> not hard because it's typically just a single ERESUME instruction, but
> it *is* a requirement.
>=20

I was assuming that the async exit stuff was completely hidden by the API. T=
he AEP code would decide whether the exit got fixed up by the kernel (which m=
ay or may not be easy to tell =E2=80=94 can the code even tell without kerne=
l help whether it was, say, an IRQ vs #UD?) and then either do ERESUME or ca=
use sgx_enter_enclave() to return with an appropriate return value.


