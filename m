Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A8EC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5982086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581525;
	bh=A4Qew2MhbK2hFq6EYro9b+ykpaUSW3pA8J+uIpJlvtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xwAYCtocCl2OkYvBKadyKeWFPVLnstcmJDnLLpsovzVYFAkNw3AHmw2hPkNuFN7Fh
	 iRjlEzcSJN4zi4CTu/YeT/15MrHKOuevLlbxborReQJYRXJ8vLlqSwoO+2X/Ob0qFM
	 XCeDPDpCdfZyQAnRiOAScAh7qlTAibo+ZdkbiRhc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5982086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLLCZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLCZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:25:15 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526FA21104
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544581513;
        bh=A4Qew2MhbK2hFq6EYro9b+ykpaUSW3pA8J+uIpJlvtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TTOqJsHnrAYH3mg21s/5zt2D5UeE/M8Kxk7CWBKLfDYOpkAvRYrxKLL7JyyEoQAMw
         FGOjxDf5u/E+h9UuWNS5ofb/bAhAROxtsqmhgSqRbtKKQquohgboJuuMPvTLt8OBmp
         GcTG7aOc+N71ON5qVRfKbdzwDQggl70yJSEf82iA=
Received: by mail-wm1-f41.google.com with SMTP id f81so4246126wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:25:13 -0800 (PST)
X-Gm-Message-State: AA+aEWb1RtHLMfkQT68XXU5VCjRzJaPhYYz5lFieiN55q1Mj3XPAk7RK
        WEl1+Fn45+4YAjLLFNWQ0zx0pq1so91HK/2T6pHIpg==
X-Google-Smtp-Source: AFSGD/WZKGg3aNRMvCuRBu4d29Ky6jpXR2dULiUyrtv/ZsDyAv9Nb8h3kdF9qrqzliDutnrSjJ2WNRLgrII1W7jagiA=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr4368027wmd.83.1544581511802;
 Tue, 11 Dec 2018 18:25:11 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Dec 2018 18:24:59 -0800
X-Gmail-Original-Message-ID: <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
Message-ID: <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     tg@mirbsd.de
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 11, 2018, at 3:35 PM, Thorsten Glaser <tg@mirbsd.de> wrote:
>
> Andy Lutomirski dixit:
>
>> What happens if someone adds a struct like:
>>
>> struct nasty_on_x32 {
>> __kernel_long_t a;
>> void * __user b;
>> };
>>
>> On x86_64, that's two 8-byte fields.  On x86_32, it's two four-byte
>> fields.  On x32, it's an 8-byte field and a 4-byte field.  Now what?
>
> Yes, that=E2=80=99s indeed ugly. I understand. But don=E2=80=99t we alrea=
dy have
> this problem with architectures which support multiple ABIs at the
> same time? An amd64 kernel with i386 userspace comes to mind, or
> the multiple MIPS ABIs.

That=E2=80=99s the thing, though: the whole generic kernel compat
infrastructure assumes there are at most two ABIs: native and, if
enabled and relevant, compat. x32 breaks this entirely.

>
>> I'm sure we could have some magic gcc plugin or other nifty tool that
>> gives us:
>>
>> copy_from_user(struct struct_name, kernel_ptr, user_ptr);
>
> Something like that might be useful. Generate call stubs, which
> then call the syscall implementation with the actual user-space
> struct contents as arguments. Hm, that might be too generic to
> be useful. Generate macros that can read from or write specific
> structures to userspace?
>
> I think something like this could solve other more general problems
> as well, so it might be =E2=80=9Cnice to have anyway=E2=80=9D. Of course =
it=E2=80=99s work,
> and I=E2=80=99m not involved enough in Linux kernel programming to be abl=
e
> to usefully help with it (doing too much elsewhere already).
>
>> actually do this work.  Instead we get ad hoc fixes for each syscall,
>> along the lines of preadv64v2(), which get done when somebody notices
>
> Yes, that=E2=80=99s absolutely ugly and ridiculous and all kinds of bad.
>
> On the other hand, from my current experience, someone (Arnd?) noticed
> all the currently existing baddies for x32 already and fixed them.
>
> New syscalls are indeed an issue, but perhaps something generating
> copyinout stubs could help. This might allow other architectures
> that could do with a new ABI but have until now feared the overhead
> as well. (IIRC, m68k could do with a new ABI that reserves a register
> for TLS, but Geert would know. At the same time, time_t and off_t could
> be bumped to 64 bit. Something like that. If changing sizes of types
> shared between kernel and user spaces is not something feared=E2=80=A6)

Magic autogenerated stubs would be great.  Difficult, too, given
unions, multiplexers, cmsg, etc.

I suppose I will see how bad it would be to split out the x32 syscall
table and at least isolate the mess to some extent.

IMO the real right solution would be to push the whole problem to
userspace: get an ILP32 system working with almost or entirely LP64
syscalls.  POSIX support might have to be a bit flexible, but still.
How hard would it be to have __attribute__((ilp64)), with an optional
warning if any embedded structs are not ilp64?  This plus a wrapper to
make sure that mmap puts everything below 4GB ought to do the trick.
Or something like what arm64 is proposing where the kernel ABI has
32-bit long doesn=E2=80=99t seem too horrible.
