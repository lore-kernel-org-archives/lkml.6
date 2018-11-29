Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37662145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="avRx9ApN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37662145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbeK3EI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:08:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39354 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeK3EI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:08:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1192517pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VJT3Cqw1s+1LfZz1jZVQmfF+EB+6vDsy5FMvUfM+kJc=;
        b=avRx9ApNjygatqM/IP78x10vo+BDyCP2h1NYOfBFUEjOQJTj+NtKBC2w6ld9dIjEjL
         VRyj7QPtjBHkLLllohfpqf0a9PSdxwC3BVOvSvHzZ/8dAUZKyZpPIAJDw1jk4kAxLQxj
         K0kchWQOQm9VKNZPwSTEJXN9Hfvw4agQ8SBHs4WGaYTg+ecz+zyWZMRn2OGdO6a8c4yK
         aD4zaNnjfFwgZKPvzQKAhBpMtb+0Cj+HbkVg2CdXI9qjqplZcIMEMaoZ3LXItm7U2w9a
         y9w/TkvewtMTCjXW0CVHlUyTYyjtg6cdTt1++Rwfw/iZ9E7PAgMJma3Ejet7WTPX8XaN
         syDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VJT3Cqw1s+1LfZz1jZVQmfF+EB+6vDsy5FMvUfM+kJc=;
        b=RB84+nd4PUJloZDXmKBZxUWKGnZnHMDQGCOViINSDqkN1EzB6x7ayRfIJnvTIU1o7G
         rIEM9clUg5SkXnThtmut/1BckiH5S9reN8g+5HzVxI1gM/WQU+qLtT9Hj0QqK255YIhc
         5EyTb5SZz4gRJoGgvTGpmFzZnWgF7ZZ0R8bFw1DnrFgG14z/Wcy2umStA/Fe3Oxdlg4A
         rGqkBgQFiYJKO46kS8IrwrrO3hJ0U4GO2lZzMOFi3eU4inEubdVWwQ+6zB5V7in+b3ay
         byAwMfgs3SO4pdiDNPXM8NXeghjBi+Z92yCaYeJDrT2MoiIOsuRhZir4sUr88DJT0k3o
         Kc+Q==
X-Gm-Message-State: AA+aEWa/PrMqaR0EbrvtbZcBAuaCpeAnz9KQySi1RBYbDF5zJy5PvmBA
        pmqy8J1wJavKWs5thrT0qpoZpg==
X-Google-Smtp-Source: AFSGD/Wcg21guAWFzr7GgnMIRR57MgueaoWWTeYzemDAYmUWPH+gPZ0lldC18OoszB+BjlZPj+TtyA==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr2116783pfc.185.1543510946287;
        Thu, 29 Nov 2018 09:02:26 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id h134sm3853363pfe.27.2018.11.29.09.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:02:25 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 09:02:23 -0800
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
Message-Id: <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net> <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 8:50 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Thu, Nov 29, 2018 at 8:33 AM Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
>>=20
>> This seems to work...
>>=20
>> +       .if \create_gap =3D=3D 1
>> +       .rept 6
>> +       pushq 5*8(%rsp)
>> +       .endr
>> +       .endif
>> +
>> -idtentry int3                  do_int3                 has_error_code=3D=
0
>> +idtentry int3                  do_int3                 has_error_code=3D=
0        create_gap=3D1
>=20
> Ugh. Doesn't this entirely screw up the stack layout, which then
> screws up  task_pt_regs(), which then breaks ptrace and friends?
>=20
> ... and you'd only notice it for users that use int3 in user space,
> which now writes random locations on the kernel stack, which is then a
> huge honking security hole.
>=20
> It's possible that I'm confused, but let's not play random games with
> the stack like this. The entry code is sacred, in scary ways.
>=20
> So no. Do *not* try to change %rsp on the stack in the bp handler.
> Instead, I'd suggest:
>=20
> - just restart the instruction (with the suggested "ptregs->rip --")
>=20
> - to avoid any "oh, we're not making progress" issues, just fix the
> instruction yourself to be the right call, by looking it up in the
> "what needs to be fixed" tables.
>=20
> No?

I thought that too.  I think it deadlocks. CPU A does text_poke_bp().  CPU B=
 is waiting for a spinlock with IRQs off.  CPU C holds the spinlock and hits=
 the int3.  The int3 never goes away because CPU A is waiting for CPU B to h=
andle the sync_core IPI.

Or do you think we can avoid the IPI while the int3 is there?=
