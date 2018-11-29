Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E512145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RKtWMSx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E512145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeK3Elx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:41:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45930 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbeK3Elx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:41:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so1220352pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J8yQOQHMXyz3r7W2eapoGqGcd3xONi9q4UZZucXm28w=;
        b=RKtWMSx42uyNQ43UFYORQ7GjvTUW+a+W5GUyO2dv/sdE65kYzq4zA5eZ1oKCDCEE5b
         ZfRgWdVjw1aBHF7jIWoA0QrHk7i2AG6GF8yH8Cbnl6g/a87vpOhcg062wlbXJvtal2iK
         8pR4mX1/DVvyfHwzHCuzC0Rq0izeCgi5usUH0+0XY8MNuXFoTtVuddE1QSP1C5QYbiWd
         7sLucaKdG9dTSe8EE3PqI+IiGblLMR73LorntsiemMERy78Ph4dNWFKLe+yfH+KFtLC/
         vtxAoL7a+DLvfetnV6jnUkw+hqcvyfK7mat58rfdpfBhPnr3hXfBag/PRXlbgGRZpdfD
         wazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J8yQOQHMXyz3r7W2eapoGqGcd3xONi9q4UZZucXm28w=;
        b=dD6Aa3w3kCL1XoOoWm9i5Bjz/eHRMAurHo7vmQ7AdIot4j7L8VjCsu/YifHuJlGAyT
         cQgRar/ir2KMvOGhvJZuCA5mhC0h9M2dqNOQ3OLk2CwYrqBA0jtWOH32ydRq74bUSqML
         ZMFo4MFQiMTjkPcuj8Hl9RQRYTHG1lNonrWq8JVBkTJ+GGxP7oEm6mW6hahOP/gWKyw4
         k73FmvuXDfERtwV+xcXok2JIIZGSSK6pmH+EItfFnpTzJeutPZAux/1t0VQBCn+rVawz
         vhFn/kz7aBawIdaB2UIOLhHEYAOvNAV4AwWFTAx9eCRrHM3ckmbKvbf0rg9VMTilWpAR
         2ogQ==
X-Gm-Message-State: AA+aEWZe8dM1Vn5YzlGTQYH8V2th0mkXrB8Fse5HqQlOgLNHbvqmt3eG
        +PC2jmnnAyr7c9wHy1pag0PruQ==
X-Google-Smtp-Source: AFSGD/XloxVzuNovXVIsP1ho6uPHowT0eynaoThrdiYeeB9pz1/E75iWWyA7yF18BA4nfLbs7LMfPw==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr2236576pfk.191.1543512944380;
        Thu, 29 Nov 2018 09:35:44 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id v76sm4708855pfj.145.2018.11.29.09.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:35:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <CAHk-=wgoeXuodaDkKNneiQmU3mxkt2C1MeyPF5_0NX1VSQV=XQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 09:35:42 -0800
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B36138FF-6BA5-4868-A321-2E31CA4875F4@amacapital.net>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com> <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <CAHk-=wgoeXuodaDkKNneiQmU3mxkt2C1MeyPF5_0NX1VSQV=XQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 9:29 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> On Thu, Nov 29, 2018 at 9:02 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>>>=20
>>> - just restart the instruction (with the suggested "ptregs->rip --")
>>>=20
>>> - to avoid any "oh, we're not making progress" issues, just fix the
>>> instruction yourself to be the right call, by looking it up in the
>>> "what needs to be fixed" tables.
>>=20
>> I thought that too.  I think it deadlocks. CPU A does text_poke_bp().  CP=
U B is waiting for a spinlock with IRQs off.  CPU C holds the spinlock and h=
its the int3.  The int3 never goes away because CPU A is waiting for CPU B t=
o handle the sync_core IPI.
>>=20
>> Or do you think we can avoid the IPI while the int3 is there?
>=20
> I'm handwaving and thinking that CPU C that hits the int3 can just fix
> up the instruction directly in its own caches, and return.
>=20
> Yes, it does what he "text_poke" *will* do (so now the instruction
> gets rewritten _twice_), but who cares? It's idempotent.
>=20
>=20

But it=E2=80=99s out of order. I=E2=80=99m not concerned about the final IPI=
 =E2=80=94 I=E2=80=99m concerned about the IPI after the int3 write and befo=
re the int3 is removed again. If one CPU replaces 0xcc with 0xe8, another CP=
U could observe that before the last couple bytes of the call target are wri=
tten and observed by all CPUs.=
