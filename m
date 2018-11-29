Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79300C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CBE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CN9ZjInw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CBE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeK3E7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:59:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbeK3E7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:59:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1398879pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FH0mHSzrIfQHzKlvAsI03i1qX/W1ab4yGhCGzEt7Uu0=;
        b=CN9ZjInwaIVYBvwLFHghcF1iopuFpFzIUHYOnDf2cDmr1Xxh/qNNP/nV6V3i8CAe9a
         L/MlrH2tZYIYUU8VFTdqSIeye9IJhsBxOghkfkqmj0DqmJk4E3MZoz8r8DRjSQ28YLAB
         szsHtrcf7MLwgayrwG26i8MUJ+2V56i5KiIUExCRm6gXZeZw9NxRVOmCipPE/gWGk3Zl
         +7ax1Ga0vynUOTu4RpChdBiEXkHUp/9w0QHqAsulMTlKbJFqJSX/D4Svfy4N7hoIOwUV
         +AYlAkIczK2gQry1G6QqTM2eAw9j3hRWLVE71NouPEX3gpLk/me8/cSl6ogD7kPHZ2ek
         XyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FH0mHSzrIfQHzKlvAsI03i1qX/W1ab4yGhCGzEt7Uu0=;
        b=d5aZZHY/vJTP2bifdofvqVuDISyCeFOWtRC83noAqKfjg9FJfiZJwV/x88C2uALO9d
         Ayz6eUlT1LyVx1Ik2GucWEXtB75Xf4/o/S4+9wBnsj6ihX4NohtTkuX9M4wNkZZC8EcF
         pKc/qzP5smtsxgsUwm/1JGkvXzTbMcVI4mXM0FzJ2z+r2++LUuuMZQHSKV98DLtrAnXg
         VHFUR+IZc7iNOCnmVHCevUiTDV4niRV+AFv+zv7TOr/44McWTknRVxbl8cpvitCBIEXq
         jcTZYcdybM17MEVEGZua5Hw3pJTAZ92sX9MrPyelAbAWZzz5ywAbI58BsRpR57DmQMWe
         Xbcg==
X-Gm-Message-State: AA+aEWaPtxPqwi3jwkVFe799Rxxh6r653vxq+t7/W3AndmaCxAYjFr/4
        +gxDeAqxOsWTO85+uPEr7LWweQ==
X-Google-Smtp-Source: AFSGD/WYJGlnGDXXgPJ7bKNo93OTdRmWcxfsQ0ohQPPMP5ZfDsyHuAb1DPxMamQWlwKwCmDyNmGXlg==
X-Received: by 2002:a62:3241:: with SMTP id y62mr2314174pfy.178.1543513978449;
        Thu, 29 Nov 2018 09:52:58 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id x2sm7092587pfx.78.2018.11.29.09.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:52:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129174555.dapti2w4acrbm2jp@treble>
Date:   Thu, 29 Nov 2018 09:52:56 -0800
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3663364-4D2E-42BB-83A2-4D3BA737B6C1@amacapital.net>
References: <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <20181129164914.GA9027@hirez.programming.kicks-ass.net> <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net> <20181129171539.GD9027@hirez.programming.kicks-ass.net> <20181129122000.7fb4fb04@gandalf.local.home> <20181129122156.782e739e@gandalf.local.home> <666E3CE2-CD96-4271-8F9C-614F96D24F26@amacapital.net> <20181129174555.dapti2w4acrbm2jp@treble>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 29, 2018, at 9:45 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
>> On Thu, Nov 29, 2018 at 09:41:33AM -0800, Andy Lutomirski wrote:
>>=20
>>> On Nov 29, 2018, at 9:21 AM, Steven Rostedt <rostedt@goodmis.org> wrote:=

>>>=20
>>> On Thu, 29 Nov 2018 12:20:00 -0500
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>=20
>>>=20
>>>> r8 =3D return address
>>>> r9 =3D function to call
>>>>=20
>>>=20
>>> Bad example, r8 and r9 are args, but r10 and r11 are available.
>>>=20
>>> -- Steve
>>>=20
>>>>   push r8
>>>>   jmp *r9
>>>>=20
>>>> Then have the regs->ip point to that trampoline.
>>=20
>> Cute. That=E2=80=99ll need ORC annotations and some kind of retpoline to r=
eplace the indirect jump, though.
>=20
> I'm going with this idea, but the BP is so rare that I really don't see
> why a retpoline would be needed.
>=20

Without the retpoline in place, you are vulnerable to security researchers c=
ausing you a personal denial of service by finding a way to cause the BP to g=
et hit, mistraining the branch predictor, and writing a paper about it :)=
