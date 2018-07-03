Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635B6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194B121C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="eppRSTK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194B121C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeGCRHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:07:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34886 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeGCRHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:07:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id e6-v6so120119pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=galbsdql0h4Ke+55XrE6E++pNPv/d6xGhXwEg+3rNik=;
        b=eppRSTK8NIe+EcbTxw8hY5IFnJEUO2O9x7bnH0TvqgjXc+uTSg0DF77Kz56etye2fY
         yqhtJFvam8uaNjmPEcwPNbvrTLvxcLmb2z9mz4csnI6nZcDnfT0wmqBLEPhyt4E8JwW0
         WvdAb60i1UDXiNA/2m++p07F2TfI+gYoMEYQuk6F5H1fknjpB+4MTQU2cxbtZreZ8wrR
         XrRjY7fJzeVEYlSoRK7U0xhX6zcSAQAo8TZFC4NNIf5AL3sL+sBQ80DKkOaFhpk7R0NJ
         3F+aBQtPbASgTYi9nFa7+w/tX0RRi/UN/Lyx/M4j63ggoBJJ0sX1bL13DrCk9pf7mSmt
         zV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=galbsdql0h4Ke+55XrE6E++pNPv/d6xGhXwEg+3rNik=;
        b=LubggPMdnixzDOdPHxASMafvrDUA7EeZMCCxF/IhTa1vKoVagJXeloRNGfDxkEdxbl
         srSZ/Fcs6zGEYBFhytFW3oa+S4X+dryfZqPT3kKzxjg4H2WPXL7Sn436grrbxBJRoLOa
         ENtEjA5T2bpZ381L4qs8UotSpx6za1T/fp16QquCarrqHRVrxp27nZ2cvYI6rbqPtxb+
         HzfB3twQi1JA8+1mNn2UyJA1R+a1gO1xdLSUtBkN9k9GK1tucalDnvihLMVbBx74yj0y
         t3BtnOngUBd9cXoEJh4EFp/9XcDf5f6XlSzXVkfqQ3h1emm692fQgJzw4wkYilWzwh+m
         n5Pw==
X-Gm-Message-State: APt69E0m/7AqmjMYgH4rFrR5UFpEaaeY7aRiPg968hUiPgAGn4JoR/l4
        Rm3NrMhL7ypXX1Et7AptP/HzoQ==
X-Google-Smtp-Source: AAOMgpedyMc5vjTgWnPGEzTXn23MIn8IfPOICdOqBSpbDbpZlQ00jF9khRuMdg4sazKhswyrDKBZzg==
X-Received: by 2002:a63:b02:: with SMTP id 2-v6mr7886262pgl.301.1530637630743;
        Tue, 03 Jul 2018 10:07:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:85e5:9e5e:da86:1f2b? ([2601:646:c200:7429:85e5:9e5e:da86:1f2b])
        by smtp.gmail.com with ESMTPSA id u67-v6sm3848011pfi.30.2018.07.03.10.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:07:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate user inputs
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
Date:   Tue, 3 Jul 2018 10:06:40 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, michal.simek@xilinx.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C9EE370-1BE4-4556-8B79-39BDBBAED7F8@amacapital.net>
References: <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com> <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com> <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com> <20180703081449.GT2494@hirez.programming.kicks-ass.net> <20180703082955.GH3704@osiris> <20180703084312.GU2494@hirez.programming.kicks-ass.net> <20180703085546.GJ3704@osiris> <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
To:     Andi Kleen <andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 3, 2018, at 9:40 AM, Andi Kleen <andi@firstfloor.org> wrote:

>>=20
>> So I think you're good... But yes, you raise an interresting point.
>=20
> So it sounds like architectures that don't have an instruction atomic u64
> *_user need to disable interrupts during the access, and somehow handle th=
at
> case when a page fault happens?

I think all this discussion of =E2=80=9Catomic=E2=80=9D is a huge distractio=
n. The properties we need are:

- User code can change rseq_cs from one valid user pointer to another with a=
 single instruction (or equivalent) such that we can=E2=80=99t end up in the=
 kernel with the write only partially done as seen in that thread.

- The kernel needs to be able to read the value consistently with the above r=
equirement.

I don=E2=80=99t think it=E2=80=99s possible to have a valid implementation o=
f get_user() on any architecture that=E2=80=99s so weak that this doesn=E2=80=
=99t work.

If user code writes rseq_cs from the wrong thread, I think the user code is b=
uggy and we simply don=E2=80=99t care what happens.  The kernel should be al=
lowed to use an arbitrarily weak read with respect to other threads.
