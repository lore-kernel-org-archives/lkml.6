Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A5020869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="XkgAtVTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A5020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeKGDrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:47:01 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45217 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbeKGDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:47:00 -0500
Received: by mail-pg1-f176.google.com with SMTP id y4so5727935pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qDsnffpMgE1JXvMM5u4+JhNGpY4R62QM++WVmvsfdyg=;
        b=XkgAtVTXtJUS8OXK4wzkaLQMNdJLS4+AX8nS4VD1MGxBKiLTxZGGPUTTZTLGytlSiC
         V3GVIDzihnzJ0lub49J1WajK7ovl2yT8qehmBvsZCgu/ML9/NBuUqBwfGsWQLuqsxMGV
         AjmCSn8z0wd/TE2OSUIplOF3Fpf9P+YYP70C8RBS14OSIK5stZw14HPJAPCKaUkmcj9R
         ZFkrZLI8AfLzNwizlDlgAMeimICJKcpKBsx01l5rB0oYf7Vtblo315MzY2swjuXeGuHJ
         C+UnJlS5+xq6C65TeSBAL33rxp25w8j2rzUYMKAzx9rt7+9iIR38o07xHMDf6uP3P3q3
         5AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qDsnffpMgE1JXvMM5u4+JhNGpY4R62QM++WVmvsfdyg=;
        b=apheUgUiaGqWWCG3AejKpVFRjHoQ/SiBlPJtFQ3pPH3aAVTsFlVBglYr/gAem9+ukg
         OhibzAYu2GMRN2IifgrcttGNEzL28QdWKH64yxkMcBexPob19/GyTK9IsoCBKQuZb8uf
         /k8JRXjNCRBLX61SR9goteU+GVqpOctxow2rse5XAgpDKVrkzkJvKSvUk98Y7x+TEJ7+
         mVjB1o5v1PxZcAR3d3kU14BQp9immEc1yuRSDEOd+lRIklysVNT+Vu3DIRu08+N5+EY5
         hiOOR2XXh4IujQNtlLf7R1kTGBnc5n9wJi6xg+67ffcFIjt5X+SHYtx5M4DXWB8Bw0c5
         sW0Q==
X-Gm-Message-State: AGRZ1gIWViYapQBCRKo+YZf73QdmmTIvdIa5EePRaNH7gvACoBptWJ7W
        lQCW8cHP91h+LCcimtp/rCF0kQ==
X-Google-Smtp-Source: AJdET5e+3QCorx17GkkVkhyx1wXs2RjtEk/ZJrIoAq19hkp8sShj+kHCmdfdzex8OFz7JNn6l5AY9Q==
X-Received: by 2002:a62:4784:: with SMTP id p4-v6mr26843289pfi.257.1541528430750;
        Tue, 06 Nov 2018 10:20:30 -0800 (PST)
Received: from ?IPv6:2600:1010:b022:50cc:40e8:641b:7bb4:fb59? ([2600:1010:b022:50cc:40e8:641b:7bb4:fb59])
        by smtp.gmail.com with ESMTPSA id v84-v6sm5926910pfd.182.2018.11.06.10.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 10:20:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: RFC: userspace exception fixups
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <1541524750.7839.51.camel@intel.com>
Date:   Tue, 6 Nov 2018 10:20:27 -0800
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-Id: <22596E35-F5D1-4935-86AB-B510DCA0FABE@amacapital.net>
References: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com> <CALCETrWe4+apXJNswHAKVVqajGS3jTEKxdd2r3iu-MzGK1v0DA@mail.gmail.com> <20181102163034.GB7393@linux.intel.com> <7050972d-a874-dc08-3214-93e81181da60@intel.com> <20181102170627.GD7393@linux.intel.com> <a4d2b3ec-43ec-f062-e180-c6e5a0d9fab8@intel.com> <20181102173350.GF7393@linux.intel.com> <CALCETrUQVPN0LSEz+5aNsbfFc=rQ33JHiOoRXVbvEEb9is9DDQ@mail.gmail.com> <20181102182712.GG7393@linux.intel.com> <CAG48ez0x7ZPcKvLt01WS-VrLm59WfvYE3nE1xbnyn3Qsp5T2rA@mail.gmail.com> <20181102220437.GI7393@linux.intel.com> <CAG48ez1+nGDbuBaKJVPAOzEwiBkXqHHs7vmyAqvbeM42r0nFHg@mail.gmail.com> <CALCETrXq1Kj=McxnPVjkscNq-b_7LeoFOdu7qKjHdvwcfFh9Og@mail.gmail.com> <1541518670.7839.31.camel@intel.com> <AF4A5C77-0A79-403F-A205-0F93B7CD6E26@amacapital.net> <1541524750.7839.51.camel@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Nov 6, 2018, at 9:19 AM, Sean Christopherson <sean.j.christopherson@int=
el.com> wrote:
>=20
>> On Tue, 2018-11-06 at 08:57 -0800, Andy Lutomirski wrote:
>>=20
>> So I guess the non-enclave code basically can=E2=80=99t trust its stack p=
ointer
>> because of these shenanigans. And the AEP code has to live with the fact
>> that its RSP is basically arbitrary and probably can=E2=80=99t even be un=
wound
>> by a debugger?
>=20
> The SDK provides a Python GDB plugin to hook into the out-call flow and
> do more stack shenanigans.  =46rom what I can tell it's fudging the stack
> to make it look like a normal stack frame so the debugger can do it's
> thing.
>=20
>> And the EENTER code has to deal with the fact that its red zone can be
>> blatantly violated by the enclave?
>=20
> That's my understanding of things.  So yeah, if it wasn't obvious before,
> the trusted and untrusted parts of the SDK are very tightly coupled.

Yuck. Just how far does this right coupling go?  If there are enclaves that p=
lay with, say, FSBASE or GSBASE, we=E2=80=99re going to start having problem=
s. And the SGX handling of PKRU is complicated at best.

I almost feel like the right solution is to call into SGX on its own private=
 stack or maybe even its own private address space.=20=
