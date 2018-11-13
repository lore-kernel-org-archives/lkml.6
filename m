Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC2BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0A2223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tvHv4q0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0A2223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeKNG6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:58:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbeKNG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:58:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so6674515pfm.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hdZDM/3I+pDA/9yywM0qy7D8QuhHoAKpXa2MeX7LccI=;
        b=tvHv4q0ms2uuTZDQ9Iq2iewWKTXQpZqhVF0WvEiJbmsLTMXmFRtzVzL8/KQOI//Wvq
         Mde3zA5vaXaunzcE8xcZ+cjz0P6KrECTdoIEf8Zvtzt+QxZ9/9vPUrGYMSrX/3bhbq5+
         oDTfPCh/Y6Qe/OJjAFXMeLmZOyo7xSZv/MvAc9cEgZubmErYMuTUh8ce4wC//S5f1NHD
         mVIS2h1Fp8QVuopk+xORBxE24Dgiq8IEv7q/yoKDGSeqUSJkdl+9wiTc7XrO/pMZqseo
         XVxub6KRMm5RnKtV1dBFMXACp3tBsEbo/cNVC5PL8YY2NfisuGVd76Zi6+/PQGblFz7+
         ETsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hdZDM/3I+pDA/9yywM0qy7D8QuhHoAKpXa2MeX7LccI=;
        b=YYLCyufF/eU339pzuTFOCUgo9eU27JeQ0ouYvABL3SjzeC3oZyYQIosoItNLvDF4Xs
         6T8/oHB9LTatccdUXuuFZGUA3WrH0ndJ0MUMZA8vhraYhfg7ifxhF9tHVAnf3WuSQl+y
         /NFRzhBb9RKrGs4Foh0YN3ir5QcOH+sqt9rOPBtTuQt7QWms7ay0FiIy7lL2MHM9/tF3
         k/+U3RvATngpq4Hp82R6luZY/Nau18UB+2R9+JvEHjl1szpMVL0l8m5HeFr9x0ao3Ur6
         /RvgoFYHuPflMz8PDwJzuKnH9UG3OywuN7jjlUqdZlH44P3it3j8gUJXMRjAIsVK5M6D
         0j2w==
X-Gm-Message-State: AGRZ1gI8RK8TnOji8OoxQxbga8FFhlZoPvJLm7XBIGFjiOoNLY47AazI
        K9k0+nE6BE6xTRTNu2aWTeDpUg==
X-Google-Smtp-Source: AJdET5ffDQDkjUz9HqXeY8opZwzb0bpfCM8tUimAjjZ1ZLBaVRzqLwINhrDMPW3R8JJWipdjDri3kw==
X-Received: by 2002:a62:5c41:: with SMTP id q62-v6mr6833834pfb.171.1542142722169;
        Tue, 13 Nov 2018 12:58:42 -0800 (PST)
Received: from ?IPv6:2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba? ([2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba])
        by smtp.gmail.com with ESMTPSA id z2sm19483261pgu.4.2018.11.13.12.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:58:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Official Linux system wrapper library?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181113193859.GJ3505@e103592.cambridge.arm.com>
Date:   Tue, 13 Nov 2018 12:58:39 -0800
Cc:     Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69B07026-5E8B-47FC-9313-E51E899FAFB0@amacapital.net>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com> <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <20181113193859.GJ3505@e103592.cambridge.arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 13, 2018, at 11:39 AM, Dave Martin <Dave.Martin@arm.com> wrote:
>=20
> On Mon, Nov 12, 2018 at 05:19:14AM -0800, Daniel Colascione wrote:
>=20
> [...]
>=20
>> We can learn something from how Windows does things. On that system,
>> what we think of as "libc" is actually two parts. (More, actually, but
>> I'm simplifying.) At the lowest level, you have the semi-documented
>> ntdll.dll, which contains raw system call wrappers and arcane
>> kernel-userland glue. On top of ntdll live the "real" libc
>> (msvcrt.dll, kernel32.dll, etc.) that provide conventional
>> application-level glue. The tight integration between ntdll.dll and
>> the kernel allows Windows to do very impressive things. (For example,
>> on x86_64, Windows has no 32-bit ABI as far as the kernel is
>> concerned! You can still run 32-bit programs though, and that works
>> via ntdll.dll essentially shimming every system call and switching the
>> processor between long and compatibility mode as needed.) Normally,
>> you'd use the higher-level capabilities, but if you need something in
>> ntdll (e.g., if you're Cygwin) nothing stops your calling into the
>> lower-level system facilities directly. ntdll is tightly bound to the
>> kernel; the higher-level libc, not so.
>>=20
>> We should adopt a similar approach. Shipping a lower-level
>> "liblinux.so" tightly bound to the kernel would not only let the
>> kernel bypass glibc's "editorial discretion" in exposing new
>> facilities to userspace, but would also allow for tighter user-kernel
>> integration that one can achieve with a simplistic syscall(2)-style
>> escape hatch. (For example, for a long time now, I've wanted to go
>> beyond POSIX and improve the system's signal handling API, and this
>> improvement requires userspace cooperation.) The vdso is probably too
>> small and simplistic to serve in this role; I'd want a real library.
>=20
> Can you expand on your reasoning here?
>=20
> Playing devil's advocate:
>=20
> If the library is just exposing the syscall interface, I don't see
> why it _couldn't_ fit into the vdso (or something vdso-like).
>=20
> If a separate library, I'd be concerned that it would accumulate
> value-add bloat over time, and the kernel ABI may start to creep since
> most software wouldn't invoke the kernel directly any more.  Even if
> it's maintained in the kernel tree, its existence as an apparently
> standalone component may encourage forking, leading to a potential
> compatibility mess.
>=20
> The vdso approach would mean we can guarantee that the library is
> available and up to date at runtime, and may make it easier to keep
> what's in it down to sane essentials.

Hmm. Putting on my vDSO hat:

The vDSO could provide all kinds of nifty things. Better exception handling c=
omes to mind. But it has two major limitations that severely restrict what i=
t can do:

- It can=E2=80=99t allocate memory. We probably want to keep it that way.

 - It can=E2=80=99t use TLS.  Solving this without genuinely awful ABI issue=
s may be extremely hard. We *could* require callers to pass a thread pointer=
 in, I suppose.

Also, if we make the vDSO stateful, CRIU is going to have a blast.  We might=
 need to expose explicit save and restore abilities.

As a straw man use case, it would be neat if DSOs (or the loader, maybe) cou=
ld register a list of exception fixups per DSO.  The kernel could consult th=
ese lists before delivering a signal.  ISTM it wouldn=E2=80=99t be so crazy i=
f the vDSO handled registration, although it could uses syscalls as well. If=
 the vDSO did it, it would need somewhere to put the lists.=
