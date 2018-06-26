Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CD026D80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XYjC13QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CD026D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeFZQL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:11:56 -0400
Received: from mail.efficios.com ([167.114.142.138]:50134 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFZQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:11:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CA8B022434B;
        Tue, 26 Jun 2018 12:11:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UKCULEAoQZoX; Tue, 26 Jun 2018 12:11:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 32B7222433A;
        Tue, 26 Jun 2018 12:11:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 32B7222433A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530029513;
        bh=8Qy8TA51SqtZA2Yj56xgADbPKjenij4JuPW9sWGbJ38=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XYjC13QLbuOnsShINqTQBzIO+iRIMb2QxO46pBFbuOtkfydeGg+FKG1xe4H2zdjq1
         hm5fCcO9gHlAkeAFsg8fJOMvNXyKdwo3oA+AutV4TVaTj4HUqupT7HOtUvchOKIZLX
         b+MsiexKJMe4YahIAkpht6HfBVyMlGeikUjUJTm/4BLsyTg/AXjFKJc5AbcEakTsqF
         RqRAzhsWlQl6Rcev8D5COpOvE/U9VItI4KctxfpYL6iRo5zW/MPwbmkxffr4QSrM1V
         XkraTmKJ/Ku0Ql9DiwOHIa8Bfxg0+ZfOqGFo5qmGE0eWdW7f0TMYy/lUpOYGwX7vLv
         gzOpDD+0g8PZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id HantETh1Tt_O; Tue, 26 Jun 2018 12:11:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1B6CE224330;
        Tue, 26 Jun 2018 12:11:53 -0400 (EDT)
Date:   Tue, 26 Jun 2018 12:11:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peter maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Message-ID: <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180626151427.GF23375@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com> <1529949285-11013-4-git-send-email-will.deacon@arm.com> <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com> <20180626151427.GF23375@arm.com>
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq/selftests: Add support for arm64
Thread-Index: jaY8/S1XCTXNdlQJVG6SQJx716rbhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon@arm.com wrote:

> Hi Mathieu,
> 
> On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jun 25, 2018, at 1:54 PM, Will Deacon will.deacon@arm.com wrote:
>> > +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
>> > +				post_commit_offset, abort_ip)			\
>> > +	"	.pushsection	__rseq_table, \"aw\"\n"				\
>> > +	"	.balign	32\n"							\
>> > +	__rseq_str(label) ":\n"							\
>> > +	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
>> > +	"	.quad	" __rseq_str(start_ip) ", "				\
>> > +			  __rseq_str(post_commit_offset) ", "			\
>> > +			  __rseq_str(abort_ip) "\n"				\
>> > +	"	.popsection\n"
>> > +
>> > +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
>> > +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
>> > +				(post_commit_ip - start_ip), abort_ip)
>> > +
>> > +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
>> > +	RSEQ_INJECT_ASM(1)							\
>> > +	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
>> > +	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
>> > +			", :lo12:" __rseq_str(cs_label) "\n"			\
>> > +	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
>> > +	__rseq_str(label) ":\n"
>> > +
>> > +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
>> > +	"	.pushsection	__rseq_failure, \"ax\"\n"			\
>> > +	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
>> > +	__rseq_str(label) ":\n"							\
>> > +	"	b	%l[" __rseq_str(abort_label) "]\n"			\
>> > +	"	.popsection\n"
>> 
>> Thanks Will for porting rseq to arm64 !
> 
> That's ok, it was good fun :)
> 
> I'm going to chat with our compiler guys to see if there's any room for
> improving the flexibility in the critical section, since having a temporary
> in the clobber list is pretty grotty.

Let me know how it goes!

> 
>> I notice you are using the instructions
>> 
>>   adrp
>>   add
>>   str
>> 
>> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
>> performance-wise with an approach using a literal pool
>> near the instruction pointer like I did on arm32 ?
> 
> I didn't, no. Do you have a benchmark to hand so I can give this a go?

see tools/testing/selftests/rseq/param_test_benchmark --help

It's a stripped-down version of param_test, without all the code for
delay loops and testing checks.

Example use for counter increment with 4 threads, doing 5G counter
increments per thread:

time ./param_test_benchmark -T i -t 4 -r 5000000000

> The two reasons I didn't go down this route are:
> 
> 1. It introduces data which is mapped as executable. I don't have a
>   specific security concern here, but the way things have gone so far
>   this year, I've realised that I'm not bright enough to anticipate
>   these things.

So far I've been able to dig up that "pure code" or "execute only" code
is explicitly requested by compiler flags (-mno-pc-relative-literal-loads
on aarch64, -mpure-code on arm32 when the moon cycle is aligned). It's a
shame that it's not more standard, or that there does not appear to be any
preprocessor define available to test this within code.

I'm all for allowing end users to chose whether they want to use literal
pools in code or not, but I think it should be configurable at compile
time, and we should make it similar on arm32 and arm64. Given that compilers
don't emit preprocessor define, perhaps we need to introduce our own
RSEQ_NO_PC_RELATIVE_LITERAL_LOADS (or perhaps a shorter name ?) define to
select behavior at compile-time.

> 2. It introduces a branch over the table on the fast path, which is likely
>   to have a relatively higher branch misprediction cost on more advanced
>   CPUs.

Hrm, wait a second... I see that your comparison of the cpu number requires:

+#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)                                        \
+        "        ldr        " RSEQ_ASM_TMP_REG32 ", %[" __rseq_str(var) "]\n"        \
+        "        sub        " RSEQ_ASM_TMP_REG32 ", " RSEQ_ASM_TMP_REG32                \
+                        ", %w[" __rseq_str(expect) "]\n"                        \
+        "        cbnz        " RSEQ_ASM_TMP_REG32 ", " __rseq_str(label) "\n"

because the abort code is emitted in a separate section:

+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)                                \
+        "        .pushsection        __rseq_failure, \"ax\"\n"                        \
+        "        .long         "        __rseq_str(RSEQ_SIG) "\n"                        \
+        __rseq_str(label) ":\n"                                                        \
+        "        b        %l[" __rseq_str(abort_label) "]\n"                        \
+        "        .popsection\n"

Like I did on x86. But the cbnz instruction requires the branch target to be
within +/- 1MB from the instruction (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/ch06s04.html),
which clearly is not guaranteed when you place the abort label in a separate
section.

Also, using cbnz to jump to a label that is outside of the assembly
(e.g. %l[error1]) does not ensure that the branch target is within
1MB of the code.

I've had assembler issues on arm32 due to those kind of constraints
when integrating rseq headers into larger code-bases.

So, one way to fix the fast-path so cpu number comparison can branch
to a close location is to put the abort code near the fast-path, and
you end up having to unconditionally jump over the abort code from
the fast-path on success. So once you bite the bullet and jump over
abort, you just have to ensure you place the struct rseq_cs data
near the abort code, so you end up jumping over both at the same time.

> 
> I also find it grotty that we emit two tables so that debuggers can cope,
> but that's just a cosmetic nit.
> 
>> With that approach, this ends up being simply
>> 
>>   adr
>>   str
>> 
>> which provides significantly better performance on my test
>> platform over loading a pointer targeting a separate data
>> section.
> 
> My understanding is that your test platform is based on Cortex-A7, so I'd
> be wary about concluding too much about general performance from that CPU
> since its a pretty straightforward in-order design.

I did benchmarks on our Wandboard (Cortex A9) as well as the Cubietruck. I
could only use perf to do detailed breakdown of the fast-path overhead on
the Cubie because I could not get it to work on our Wandboard, but overall
speed was better on Wandboard as well (as I recall) with the literal pool.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
