Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B80AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6A2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pbW0xkX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C6A2241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeKMArH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:47:07 -0500
Received: from mail.efficios.com ([167.114.142.138]:49734 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:47:07 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C88B2393CE;
        Mon, 12 Nov 2018 09:53:30 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 90pQfI9TdtYy; Mon, 12 Nov 2018 09:53:29 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B2DFF2393B6;
        Mon, 12 Nov 2018 09:53:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B2DFF2393B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542034409;
        bh=TK4/ipd3NpcmT6fmpp7d/sNrZR5j/NsFt2yFt2Uy2cs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pbW0xkX4xbEnappOesXXOC3pI/2q2BeijJ/q5uqyNCdIc4+EtUPbOHEM+696Xri0b
         TdwUZHTzK/VaF8/UiQyixJwOlZXkfJZf1PnYab94j3lNrqtmNpsOw5YsCgZZkG36vy
         pLTqnzj38Ei9LnoqLpvjzz5R5otPKDnCqXMy74yWGhExjp4eUkZYpXBUv3rb2OpeGJ
         qrfx8m3G5EqWdAC1LzZfzLmCydoznCn40ltqe/Cch+Knm3dEr90EIDay2DggpnHSlw
         +M/jzWzy0m16qibB7f/dulo+4hK0UMP7QVHWZMH4Ei0G1L0CHBdRbTvN9+U9ykHIUK
         Lu/73GYgIZwVw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id VC_EBszx5mtB; Mon, 12 Nov 2018 09:53:29 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9171F2393AF;
        Mon, 12 Nov 2018 09:53:29 -0500 (EST)
Date:   Mon, 12 Nov 2018 09:53:29 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        kernel-hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <97842534.3842.1542034409326.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181112115058.39e98750750c91eeb349cfdf@kernel.org>
References: <1541887530-16610-1-git-send-email-alex.popov@linux.com> <20181110183011.2290fc20@gandalf.local.home> <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com> <20181111205351.1874bb1e@vmware.local.home> <20181112115058.39e98750750c91eeb349cfdf@kernel.org>
Subject: Re: [PATCH 1/1] stackleak: Disable ftrace for stackleak.c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: stackleak: Disable ftrace for stackleak.c
Thread-Index: Ubb1Z/iQugJ+BVkUy4jUosaq2/248g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 11, 2018, at 9:50 PM, Masami Hiramatsu mhiramat@kernel.org wrote:

> Hi Alexander and Steve,
> 
> On Sun, 11 Nov 2018 20:53:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Sun, 11 Nov 2018 13:19:45 +0300
>> Alexander Popov <alex.popov@linux.com> wrote:
>> 
>> > On 11.11.2018 2:30, Steven Rostedt wrote:
>> > > On Sun, 11 Nov 2018 01:05:30 +0300
>> > > Alexander Popov <alex.popov@linux.com> wrote:
>> > >   
>> > >> The stackleak_erase() function is called on the trampoline stack at the
>> > >> end of syscall. This stack is not big enough for ftrace operations,
>> > >> e.g. it can be overflowed if we enable kprobe_events for stackleak_erase().
>> > > 
>> > > Is the issue with kprobes or with function tracing? Because this stops
>> > > function tracing which I only want disabled if function tracing itself
>> > > is an issue, not for other things that may use the function tracing
>> > > infrastructure.
>> > 
>> > Hello Steven,
>> > 
>> > I believe that stackleak erasing is not compatible with function tracing itself.
>> > That's what the kernel testing robot has hit:
>> > https://www.openwall.com/lists/kernel-hardening/2018/11/09/1
>> > 
>> > I used kprobe_events just to reproduce the problem:
>> > https://www.openwall.com/lists/kernel-hardening/2018/11/09/4
>> 
>> Have you tried adding a "notrace" to stackleak_erase()?
>> 
>> Not tracing the entire file is a bit of overkill. There's no reason
>> ftrace can't trace stack_erasing_sysctl() or perhaps even
>> stackleak_track_stack() as that may be very interesting to trace.
> 
> I think it is not enough for stopping kprobes. If you want to stop the kprobes
> (int3 version) on stackleak_erase(), you should use
> NOKPROBE_SYMBOL(stackleak_erase),
> since kprobes can work without ftrace.

Just to clarify: AFAIU you guys are recommending to add _both_ a "notrace"
annotation to stackleak_erase() _and_ a NOKPROBE_SYMBOL(stackleak_erase),
so neither function tracing nor kprobes can hook on that function.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
