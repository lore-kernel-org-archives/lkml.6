Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717CC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB03E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544570580;
	bh=eDAlSULV94RqEAFfgBQaVPmif4qoH/rkERvgXe2t4m8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oObEVLcOXwSWqBRfBAj0cOFvTIse81PaU6dKvCM5Qr7s3yM8b3m/62LhqZz0pZUUl
	 jmpVGSJOGUX97x4oCEjVxlANPXJx/qk8CEU/uH8xKjccjuGuOR41zo52hLVt8vJZcR
	 kovzH592O6SBtWuh9Fus19SvYIlS9ybgQ0hTEdFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB03E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLKXW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKXW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:22:59 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF0421473
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544570578;
        bh=eDAlSULV94RqEAFfgBQaVPmif4qoH/rkERvgXe2t4m8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SfbVneZd5Nun9ZpBsZuZsK3Gzjj5SMOJIhXDKSsFYkBqILA/XlmBOHokZuxov6/JG
         IYwqKXSZ7tVkwirR/fHw4Z91EgLfj4ov1FnH+8Ti6VCpYOLJSRTlxeUjl+Q1lIII/X
         icetzV4dxgcJLnYVQ5DuaxvaZM4IJzl5V828N2xA=
Received: by mail-wm1-f50.google.com with SMTP id a18so4059770wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:22:57 -0800 (PST)
X-Gm-Message-State: AA+aEWYhf0LiVgNsAN+VFXYyPtm9VPg3fr8u/G8nX7so/9LbNYGJ9Gq/
        VwyXaqJrmd9BqbcmjJ1r+jeE94Pd0MuEkOJqPTiUXQ==
X-Google-Smtp-Source: AFSGD/U5+YW3RxB0S4/HWjS9g983JWM2WGsSKFJsaZrfGKE6thbAXVoXRjzmvel9+qBe+FTg/oWqPUYYOWynOD4AQac=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr4032598wmd.83.1544570576367;
 Tue, 11 Dec 2018 15:22:56 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com> <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Dec 2018 15:22:43 -0800
X-Gmail-Original-Message-ID: <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
Message-ID: <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     tg@mirbsd.de
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Tue, Dec 11, 2018 at 2:14 PM Thorsten Glaser <tg@mirbsd.de> wrote:
>
> Note: please keep me in Cc because I am not subscribed.
>
> Linus Torvalds dixit:
>
> >I'm not opposed to trying to sunset the support, but let's see who compl=
ains..
>
> I will hereby complain.
>
> I=E2=80=99m using Debian/x32 on my main desktop at work, and do
> occasionally help out with porting issues. It=E2=80=99s a good
> way to make more out of 64-bit machines without going
> all 64 bit; it=E2=80=99s also helped me find bugs in software.
> It=E2=80=99s a nice architectural idea, and a way forward for
> things that are constricted to 32 bits while opening
> up stuff like 64-bit time_t without taking up half the
> available CPU registers (while more than doubling the
> number of the available CPU registers, too).

Thanks for responding!

I suppose the question is: are you enough of a user to justify the
continued maintenance effort.

>
> I was also considering investing a nontrivial amount of
> work into porting klibc to x32, since hpa does not wish
> to do it himself. Thankfully I have only done a bit yet.
>
> Furthermore, x32 was the first of the many *64ilp32
> architectures; I know I=E2=80=99ve seen amd64ilp32 and at least
> one other I don=E2=80=99t recall. It will have prototyped many
> of the problems users of these will run in, and I=E2=80=99d prefer
> to keep it (completely selfish because I don=E2=80=99t wish to
> have to crossgrade a whole system yet again).

it kind of seems like arm64's lesson is "don't do it like x32".

There's some effort going on right now to make it possible to add
syscalls without having to muck with every single architecture.  I
don't really want x32 to derail that effort.  I suppose we could say
that x32 stays but that it simply gets no new syscalls, but that seems
a bit lame.  Unfortunately, on x86, x32 really is a third ABI that is
not compatible in a structure-memory-layout sense with the other two.
What happens if someone adds a struct like:

struct nasty_on_x32 {
  __kernel_long_t a;
  void * __user b;
};

On x86_64, that's two 8-byte fields.  On x86_32, it's two four-byte
fields.  On x32, it's an 8-byte field and a 4-byte field.  Now what?

I'm sure we could have some magic gcc plugin or other nifty tool that gives=
 us:

copy_from_user(struct struct_name, kernel_ptr, user_ptr);

where it automatically generates code for all possible ABIs to copy
over the struct and dispatches dynamically based on the current
syscall ABI, but I have trouble imagining anyone volunteering to
actually do this work.  Instead we get ad hoc fixes for each syscall,
along the lines of preadv64v2(), which get done when somebody notices
a problem.

Linus, any advice here?

--Andy
