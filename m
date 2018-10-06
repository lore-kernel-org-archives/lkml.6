Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38BC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BC721473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TXvCrvW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJFWRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 18:17:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45308 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeJFWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 18:17:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so3287032pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=osp/8g64650E0fpKftQjpbgb16j7L2b3OT1r+lOeUAU=;
        b=TXvCrvW3NF/na5gFsjPMP9JDUp7Pf+ZSudJTPbRrqBNcoLZRcQAErkffPV/hpaSZu6
         m20UZ58r9E84Ysmu9yfIE+32vE/D6LPN/weuQ8/VYQWiNrIF3OU1HoFF5llDefCtpTkf
         RpQwgipUJC2CKei3Fpleqg4L/8dqJkK9FsMbM0vTtqLYUDkabXzcjtKekfkSPkOYFrK9
         osYp8qT79wlsVKpmo45y08EYewDOp0/LoSyL65e79CMY/fN4UqWeCvBQVE66N3KHWvT6
         GIcP9WRMMB5CgfAsWDzcOSxpQyQef6YZsKjjAcboTfzAPoen3STo64Sm4gO2d4hZOpGd
         gmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=osp/8g64650E0fpKftQjpbgb16j7L2b3OT1r+lOeUAU=;
        b=VPixdeEZKH9h6pwYR1BjsJk20NNKyFRue8Z5uPxb2ykTRTlZOtG6TQoTFwELYBEkQw
         48Nb/m2mCAtY31go1vsCwbTNmBLiQuPbjzcSIXWamV80jVsc5kXe4/C+58ZvM0A30Z4q
         /sgOrdweCfbWkJx1MCi+WA/VWssVqhA05xua4Ki/t0QDmoEooMaI9quq79cKzD1OlJgj
         e+WIXe/i+YY4bu+CN2/DHSQSTxRRWieRkqNInlpjh+IIUJxpY18i9Ifm+ssNjpWOI5pT
         kkHPMAJlLK60OFmm/qwLr12jEUmof6GRma8k7P5g1qJGAFGHiImLDDXgmg0avY0YknLO
         07Zw==
X-Gm-Message-State: ABuFfohOzOHtAyO8Q5D3rMT6s2PKhtH83kmQ6v5W6OTkA8A+XY+dWQRZ
        YhYKyOB9SLPVtitn+GOIm4Xq9v9lw4M=
X-Google-Smtp-Source: ACcGV60AqXJtCLHApgztkmQBpmMrC37TFPndkuXBE5ZQgSXpF/2fho6v5h7PPdzLkrgX+PKEAV5E/A==
X-Received: by 2002:a62:9b9a:: with SMTP id e26-v6mr17571762pfk.181.1538838801042;
        Sat, 06 Oct 2018 08:13:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:b0dd:ac42:e4a:4c9f? ([2601:646:c200:7429:b0dd:ac42:e4a:4c9f])
        by smtp.gmail.com with ESMTPSA id 72-v6sm24717361pfr.115.2018.10.06.08.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 08:13:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181006093905.46276505@vmware.local.home>
Date:   Sat, 6 Oct 2018 08:13:18 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AF87411-7E98-4FD7-B3D8-F4C6423F24AE@amacapital.net>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org> <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 6, 2018, at 6:39 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sat, 6 Oct 2018 14:12:11 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>>> On Fri, Oct 05, 2018 at 09:51:11PM -0400, Steven Rostedt wrote:
>>> +#define arch_dynfunc_trampoline(name, def)    \
>>> +    asm volatile (                \
>>> +    ".globl dynfunc_" #name "; \n\t"    \
>>> +    "dynfunc_" #name ": \n\t"        \
>>> +    "jmp " #def " \n\t"            \
>>> +    ".balign 8 \n \t"            \
>>> +    : : : "memory" ) =20
>>=20
>> Bah, what is it with you people and trampolines. Why can't we, just like
>> jump_label, patch the call directly?
>>=20
>> The whole call+jmp thing is silly, don't do that. It just wrecks I$ and
>> is slower for no real reason afaict.
>=20
> My first attempt was to do just that. But to add a label at the
> call site required handling all the parameters too. See my branch:
> ftrace/jump_function-v1 for how ugly it got (and it didn't work).
>=20
>>=20
>> Steve, also see:
>>=20
>>  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.o=
rg
>=20
> Interesting. I don't have time to look at it at the moment to see what
> was done, but will do so in the near future.
>=20
> Remember, this was a proof of concept and even with the trampolines, it
> showed a great level of improvement. One thought was to do a
> "recordmcount.c" type of action to find where the calls were and patch
> them directly at boot up. I tried to keep the API the same where this
> could actually be done as an improvement later.
>=20
> Perhaps a gcc plugin might work too.
>=20

My suggestion was to have objtool do the dirty work. Josh said something sus=
piciously like =E2=80=9Csounds fun=E2=80=9D on IRC :)

> I'll have to see what Ard did to handle the function parameters.
>=20
> -- Steve
>=20
