Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF78ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0199D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BhoGOYFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0199D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbeGWWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:54:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35634 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWWyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:54:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so1309188pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vtZPnlxWvNmHMtTbeH3BWD3K4ieJxxr85OI9hXi37J4=;
        b=BhoGOYFo5Gaj+wobtL7P8xO/l2H2kLuD9jNILxXDb96LWBRZaAuVDDve3BOdZ6fgH+
         0ZreZyv4OEBQ/TgoqTF5gCTpJ2xAePSoHsyJRAsIIt5ss0JTEyTdCTyc4RAyoMXjSpW/
         nc+DC6hAmlGQ39fXajbkGeapBZ4wlkmEx6tK85HfHGXQfPcT8BO0LUgwUDQyFNxRXFLQ
         e2t7NTYIyaUD3s5Vy6MN7yff/NWmdhmVaiU8R8KgjBqIp6YrfT1b8eOyaeixaOLC+ru1
         Cjk1Y8bWjzsXaJtmzpqExNnVfBFs33xoLT9XpWf+1ybWMVzKOMi/x8UhWC9Jyb293Jzy
         oJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vtZPnlxWvNmHMtTbeH3BWD3K4ieJxxr85OI9hXi37J4=;
        b=V81sQ5ejrdThtctA3Jncd8bpi5YFkzAHtNxF8432ChG/kGGAhOxQXTNkzUZ1btvNyM
         vU63cg77ykcCAFSLFVXjwd1S3AqXgUJZOh1VSY8LdYOlufbqOJv/DqEkv/WgosUuo/sE
         nxKX/tfKFip64kwVCmUDrK4ZX0TcTgCdflPt55lA0Owiu4HwGr5SmY0WMX1WhZrt79zM
         MjXb1Du8GTEh4zDdF4+/EL1u3L6WhE4seTXQz+r5ai5/GfPFHCzfspPpGtRF+1Cz7WUn
         aj7IUf+4nDm0xM4/Jk9fIo61BGMtSTZQsI7PN8LJVgF2lmV4VSl0kYmvmjgNg56aLKQC
         5gAQ==
X-Gm-Message-State: AOUpUlFEl5W8DELrO5bQNGwr6dq0E7h7W2g7DZ/2eEzlS9mEilyAdRYd
        pYxI5SqBkmWl5OohMf+aeLyiRA==
X-Google-Smtp-Source: AAOMgpf3ZWJBG10vKrt6X+D3MuXxk9/j4l1dKIvkzWVtpuEBUrgygvvcOnAUF9lMca5FUGcimiQnWQ==
X-Received: by 2002:a63:a619:: with SMTP id t25-v6mr13463560pge.288.1532382653452;
        Mon, 23 Jul 2018 14:50:53 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:c03e:2ca6:ca95:c68d:5143? ([2600:1010:b052:c03e:2ca6:ca95:c68d:5143])
        by smtp.gmail.com with ESMTPSA id v20-v6sm23054589pfk.12.2018.07.23.14.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:50:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] PTI for x86-32 Fixes and Updates
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180723213830.GA4632@amd>
Date:   Mon, 23 Jul 2018 14:50:50 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39A1C149-DA03-46D1-801F-0205DCD69A36@amacapital.net>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <20180723140925.GA4285@amd> <CA+55aFynT9Sp7CbnB=GqLbns7GFZbv3pDSQm_h0jFvJpz3ES+g@mail.gmail.com> <20180723213830.GA4632@amd>
To:     Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 23, 2018, at 2:38 PM, Pavel Machek <pavel@ucw.cz> wrote:
>=20
>> On Mon 2018-07-23 12:00:08, Linus Torvalds wrote:
>>> On Mon, Jul 23, 2018 at 7:09 AM Pavel Machek <pavel@ucw.cz> wrote:
>>>=20
>>> Meanwhile... it looks like gcc is not slowed down significantly, but
>>> other stuff sees 30% .. 40% slowdowns... which is rather
>>> significant.
>>=20
>> That is more or less expected.
>>=20
>> Gcc spends about 90+% of its time in user space, and the system calls
>> it *does* do tend to be "real work" (open/read/etc). And modern gcc's
>> no longer have the pipe between cpp and cc1, so they don't have that
>> issue either (which would have sjhown the PTI slowdown a lot more)
>>=20
>> Some other loads will do a lot more time traversing the user/kernel
>> boundary, and in 32-bit mode you won't be able to take advantage of
>> the address space ID's, so you really get the full effect.
>=20
> Understood. Just -- bzip2 should include quite a lot of time in
> userspace, too.=20
>=20
>>> Would it be possible to have per-process control of kpti? I have
>>> some processes where trading of speed for security would make sense.
>>=20
>> That was pretty extensively discussed, and no sane model for it was
>> ever agreed upon.  Some people wanted it per-thread, others per-mm,
>> and it wasn't clear how to set it either and how it should inherit
>> across fork/exec, and what the namespace rules etc should be.
>>=20
>> You absolutely need to inherit it (so that you can say "I trust this
>> session" or whatever), but at the same time you *don't* want to
>> inherit if you have a server you trust that then spawns user processes
>> (think "I want systemd to not have the overhead, but the user
>> processes it spawns obviously do need protection").
>>=20
>> It was just a morass. Nothing came out of it.  I guess people can
>> discuss it again, but it's not simple.
>=20
> I agree it is not easy. OTOH -- 30% of user-visible performance is a
> _lot_. That is worth spending man-years on...  Ok, problem is not as
> severe on modern CPUs with address space ID's, but...
>=20
> What I want is "if A can ptrace B, and B has pti disabled, A can have
> pti disabled as well". Now.. I see someone may want to have it
> per-thread, because for stuff like javascript JIT, thread may have
> rights to call ptrace, but is unable to call ptrace because JIT
> removed that ability... hmm...

No, you don=E2=80=99t want that. The problem is that Meltdown isn=E2=80=99t a=
 problem that exists in isolation. It=E2=80=99s very plausible that JavaScri=
pt code could trigger a speculation attack that, with PTI off, could read ke=
rnel memory.
