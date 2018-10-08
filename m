Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA3C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B382084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lXhTAJp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B382084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJHPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:43:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42626 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJHPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:43:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so7869132pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=39YAHcca+fPJf02KYfXfuH5nIZ0zO+nGnWHb2Dxl2Q0=;
        b=lXhTAJp7SdKyxKm7yWXpoUdYcpPhvW3IBUUY01Ys+6+OUNdYQHwUDDhm82CK47UYqY
         CIRWNqwYmdOwLENS73jwussijgpjOc+PiuWte/ykJHLJ1DYOBJD9xkvFB4QCphUUCj1W
         5z6Q//hE9wBkI15A50o5/5pSAQrrbcXeyiswSjVSyEMny95Rk6T4e5ij3teoGA3fYllh
         PHoVv1nAkOKYP8bjAp06mRQZQIRZFQvxNu28wawAS1jvQUFPIc2cvtNdjK2jv++4U6Tp
         6umZAMFbVXBC4xI+C6hq0TRkPamA0WP/FrlADJwAXC3dpDz88XXOXMW/botlzDDgvNyl
         8meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=39YAHcca+fPJf02KYfXfuH5nIZ0zO+nGnWHb2Dxl2Q0=;
        b=Dd2PrA/l9F1gQkE4Le7hZppMysIm3b257XnOF9b73h1D7A7tjrR7rkNCe8tzG2ZsWt
         5niKMfd24KneNmUpVQQaHAVzXCfAFyfOxyMyJcXIR7KTNENogg4Yc8NbWYHoJciJ9ioq
         +hkgeOH6vqOvtrzcr7s4LHreCyHA8pa4gL9KZOEfKdc9hS6P4L8vpIGiX9l8JdUlW5n9
         FtE9V5Lk5ULEOZ0HauOPLZ9e5PrJMxioGhGkoDZYjvkifPvgvH9yIPVaGpxUKxHyjNso
         sAalPNu0I1iSol3IYJZuFNruCEwALRL6aLwJnuip7Ai3MKrmTS7Hr1RFTIXrbverRerN
         CPhg==
X-Gm-Message-State: ABuFfoiQUvIGbnZ56KdeRuJCbUShJsJwVcjXL7DjSmSA1ssH98NOfMim
        M+zFPGr22PQABDotZZkHsKg8aA==
X-Google-Smtp-Source: ACcGV63QvoRz1Mg6PQXKN3yuD15Ve5Di4EcFELmyh4WtGU5PrnHsFj022OS1SCSoiDqYhPMnxMh0cw==
X-Received: by 2002:a63:9612:: with SMTP id c18-v6mr19548396pge.21.1538987596171;
        Mon, 08 Oct 2018 01:33:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:e03a:e30c:506d:e1d1? ([2601:646:c200:7429:e03a:e30c:506d:e1d1])
        by smtp.gmail.com with ESMTPSA id u79-v6sm29182201pfd.117.2018.10.08.01.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 01:33:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181008072134.GB5663@hirez.programming.kicks-ass.net>
Date:   Mon, 8 Oct 2018 01:33:14 -0700
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
Message-Id: <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org> <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home> <20181008072134.GB5663@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2018, at 12:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Sat, Oct 06, 2018 at 09:39:05AM -0400, Steven Rostedt wrote:
>> On Sat, 6 Oct 2018 14:12:11 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>=20
>>>> On Fri, Oct 05, 2018 at 09:51:11PM -0400, Steven Rostedt wrote:
>>>> +#define arch_dynfunc_trampoline(name, def)    \
>>>> +    asm volatile (                \
>>>> +    ".globl dynfunc_" #name "; \n\t"    \
>>>> +    "dynfunc_" #name ": \n\t"        \
>>>> +    "jmp " #def " \n\t"            \
>>>> +    ".balign 8 \n \t"            \
>>>> +    : : : "memory" ) =20
>>>=20
>>> Bah, what is it with you people and trampolines. Why can't we, just like=

>>> jump_label, patch the call directly?
>>>=20
>>> The whole call+jmp thing is silly, don't do that. It just wrecks I$ and
>>> is slower for no real reason afaict.
>>=20
>> My first attempt was to do just that. But to add a label at the
>> call site required handling all the parameters too. See my branch:
>> ftrace/jump_function-v1 for how ugly it got (and it didn't work).
>=20
> Can't we hijack the relocation records for these functions before they
> get thrown out in the (final) link pass or something?

I could be talking out my arse here, but I thought we could do this, too, th=
en changed my mind.  The relocation records give us the location of the call=
 or jump operand, but they don=E2=80=99t give the address of the beginning o=
f the instruction. If the instruction crosses a cache line boundary, don=E2=80=
=99t we need to use the int3 patching trick?  And that requires knowing whic=
h byte to patch with int3.

Or am I wrong and can the CPUs we care about correctly handle a locked write=
 to part of an instruction that crosses a cache line boundary?=
