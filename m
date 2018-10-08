Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2522089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dCdCdrJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2522089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJHXma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:42:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:42:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so10308479plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o10MbsYKlJ1hXQ2t+BydwRhuW/v1ses3zLRCbNJuo2w=;
        b=dCdCdrJqcPQgVn3mn8Uil/DBWOtvfGT3HmVRmSAT8Z+63WYFkaEu79TcC8/08/zI5L
         iUAzM4z7Zq5rwmv2G3pHUSiWOW9r9wT727f7sWpEVPyGGzBG2XB2HFEzy4YCgk+2HXLb
         nlhrOyzwT9aSP0gwLhEuNAaBHtHiZ3yX/c5p6cYkXrLMGd2cD8qLwgneyeN8M3eVhrbU
         +IT2BHfJIJnRhtKTDeS7GrSXUaF2oo+X+BYj1fcMJjJ7KOFjHESGn4tKRyS40aduk/kO
         VzbqJAw8dLoH3w1r/jTe09N1dSFJOPD9+y2YT4APZwsnNGnPwF2a45BLJmDLj6eHfVmB
         a4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o10MbsYKlJ1hXQ2t+BydwRhuW/v1ses3zLRCbNJuo2w=;
        b=bWhj9ihU+Grh+k58/oxueydlnieccRrjqVUrbu93IPTgcjbsmWKuVttaddZMtaOod8
         IOlj4gEMeWjcDwd6QlJBUeUlYwNDZXrT4rTA5OyAGjbkRMmu2oCmz2YwN3APcHfQ0CdO
         RPooGgFmU/+1UTbGzbumF2FmKM0q8xQ4fYFM21tt6G825AKSwoNFiFN/3pvpcXSTDoNt
         ug8zfESF3xS0WJ5441qAWJGiE7UvdulSys83AoDuWF1GaEyq8xM8JvS53zFcr96CBC1G
         fR1iHRlEnNVCn//65A5RSfq4lk031t71vLNa019zjjQQKTYi6MhM4sZTxIHwf7D2wMZu
         jxMA==
X-Gm-Message-State: ABuFfoiS2fJMgOKSpsD5MyBYxuctqqYwQCv0WvLeqit0UzfZGl6pDuRn
        PGg6LmeS3odaCpk2CedQMmQiAQ==
X-Google-Smtp-Source: ACcGV63G7jEoG5FKfgDy20c8zhKNT3WnS4z4CHQaRfQoR34jwRBFFS9hr6KfD2tLOjvZ5FFRY1S1dA==
X-Received: by 2002:a17:902:9f8c:: with SMTP id g12-v6mr25316654plq.309.1539016198216;
        Mon, 08 Oct 2018 09:29:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:945b:1f25:be7:bc4b? ([2601:646:c200:7429:945b:1f25:be7:bc4b])
        by smtp.gmail.com with ESMTPSA id u77-v6sm29516726pfj.40.2018.10.08.09.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:29:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181008155757.GC5663@hirez.programming.kicks-ass.net>
Date:   Mon, 8 Oct 2018 09:29:56 -0700
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
Message-Id: <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org> <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home> <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net> <20181008155757.GC5663@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2018, at 8:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
>>> Can't we hijack the relocation records for these functions before they
>>> get thrown out in the (final) link pass or something?
>>=20
>> I could be talking out my arse here, but I thought we could do this,
>> too, then changed my mind.  The relocation records give us the
>> location of the call or jump operand, but they don=E2=80=99t give the add=
ress
>> of the beginning of the instruction.
>=20
> But that's like 1 byte before the operand, right? We could even double che=
ck
> this by reading back that byte and ensuring it is in fact 0xE8 (CALL).
>=20
> AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: E8 <PL=
T32>,
> so if we have the PLT32 location, we also have the instruction location. O=
r am
> I missing something?

There=E2=80=99s also JMP and Jcc, any of which can be used for rail calls, b=
ut those are also one byte. I suppose GCC is unlikely to emit a prefixed for=
m of any of these. So maybe we really can assume they=E2=80=99re all one byt=
e.

But there is a nasty potential special case: anything that takes the functio=
n=E2=80=99s address. This includes jump tables, computed gotos, and plain ol=
d function pointers. And I suspect that any of these could have one of the r=
ather large number of CALL/JMP/Jcc bytes before the relocation by coincidenc=
e.


