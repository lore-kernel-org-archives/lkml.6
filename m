Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B166926C14
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j5s1HJR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B166926C14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbeFZUMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:12:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:36968 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeFZUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:12:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9E18D22BE70;
        Tue, 26 Jun 2018 16:12:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OPX__OKdKFJJ; Tue, 26 Jun 2018 16:12:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1578B22BE6D;
        Tue, 26 Jun 2018 16:12:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1578B22BE6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530043933;
        bh=mzJ99J77WfjoOcEKbhwpUfK+RlJp0Naev3hF9gARofs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=j5s1HJR6zjQN5jBqYNCa/SlcAF24b9LwWw6xNDUlqMbkAM+lJDPWwJ6alzU0uzOhH
         /8lZHEna6sqiDKuiC8VFImzaMZTIzGwso6Ml9DCffNU+Jd8fcC6q2IZl1wjO6TMr70
         W24QDQ1YRORHZqEOu8jEatTYErNXNPLWRfQ5pSriS/mK5WaYmFxvetEHv0t/e8ghYo
         EEmYs5l1NYoEFcKpHdJn90iYvKvsw67+ngPvRiUsKRPOqrjRfKzZiYquQKzVoWi8NM
         ZnNJ8zbR3TtwYr1TW46iUbmRjcp5Fx2udN6gtqnQQe8GeOMFZilX+NFuXBNurb5ovG
         +1H4gLuLrHp9A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id owXi7J4HKdWG; Tue, 26 Jun 2018 16:12:13 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 005D422BE63;
        Tue, 26 Jun 2018 16:12:12 -0400 (EDT)
Date:   Tue, 26 Jun 2018 16:12:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1352608225.6039.1530043932895.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrWhY_+SxKt9Xq2ruiGk8GQeYvrojy84w_Quosrf5fpApQ@mail.gmail.com>
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com> <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com> <CALCETrXimh61U7Tn9KShr6sKag7NCL3qfraN18Oy2Bk+0VRAUA@mail.gmail.com> <1277536320.5963.1530042608296.JavaMail.zimbra@efficios.com> <CALCETrWhY_+SxKt9Xq2ruiGk8GQeYvrojy84w_Quosrf5fpApQ@mail.gmail.com>
Subject: Re: rseq: How to test for compat task at signal delivery
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: How to test for compat task at signal delivery
Thread-Index: d+/kyYTKIoJlIkWYmfsB0PCylhA6Lw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 26, 2018, at 3:55 PM, Andy Lutomirski luto@amacapital.net wrote:

> On Tue, Jun 26, 2018 at 12:50 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Jun 26, 2018, at 3:32 PM, Andy Lutomirski luto@amacapital.net wrote:
>>
>> > On Tue, Jun 26, 2018 at 11:45 AM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >>
>> >> ----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers
>> >> mathieu.desnoyers@efficios.com wrote:
>> >>
>> >> > Hi Andy,
>> >> >
>> >> > I would like to make the behavior rseq on compat tasks more robust
>> >> > by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
>> >> > bits of rseq_cs->abort_ip, rseq_cs->start_ip and
>> >> > rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
>> >> > kernel.
>> >> >
>> >> > The intent here is that if user-space has garbage rather than zeroes
>> >> > in its struct rseq_cs fields padding, the behavior will be the same
>> >> > whether the binary is run on 32-bit or 64 kernels.
>> >> >
>> >> > I know that internally, the kernel is making a transition from
>> >> > is_compat_task() to in_compat_syscall().
>> >> >
>> >> > I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
>> >> > invoked from a system call, but is it OK to call it when it is
>> >> > invoked from signal delivery ? AFAIU, signals can be delivered
>> >> > upon return from interrupt as well.
>> >> >
>> >> > If not, what strategy do you recommend for arch-agnostic code ?
>> >>
>> >> I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
>> >> which I could use in the rseq code. I'll prepare a patch and we can discuss
>> >> from there.
>> >>
>> >
>> > That sounds about right.
>> >
>> > I'm confused, though.  Wouldn't it be more consistent to just segfault
>> > if the high 32 bits are not clear when rseq transitions to a 32-bit
>> > context?  If there's garbage in 64-bit mode, the program will crash.
>> > Why should 32-bit mode be any different?
>>
>> Currently, if a 32-bit binary puts garbage in the high bits of
>> start_ip, post_commit_offset, and abort_ip in
>>
>> include/uapi/linux/rseq.h:
>>
>> struct rseq_cs {
>>         /* Version of this structure. */
>>         __u32 version;
>>         /* enum rseq_cs_flags */
>>         __u32 flags;
>>         LINUX_FIELD_u32_u64(start_ip);
>>         /* Offset from start_ip. */
>>         LINUX_FIELD_u32_u64(post_commit_offset);
>>         LINUX_FIELD_u32_u64(abort_ip);
>> } __attribute__((aligned(4 * sizeof(__u64))));
> 
> This ABI isn't real ABI until a stable kernel happens, right?  So how
> about just making all those fields be u64?

Good point. Unlike the rseq_cs field in the struct rseq TLS, those
fields don't need to be word-sized/word-aligned, so we could simply
declare them as __u64.

> 
>>
>> A 32-bit kernel just never reads the padding, thus in reality acting
>> as if those were zeroes. However, a 64-bit kernel dealing with this
>> 32-bit compat task will read that padding, handling those as very
>> large values.
> 
> Sounds like a design error.  Have all kernels read the fields no
> matter what.  A 32-bit kernel will send SIGSEGV if the high bits are
> set.  A 64-bit kernel running compat userspace should make sure that a
> 32-bit task dies if the high bits are set.

If we end up declaring those as __u64, that approach makes sense.

> 
>>
>> We need to improve that by introducing a consistent behavior across
>> native 32-bit kernels and 32-bit compat mode on 64-bit kernels.
>>
>> There are two ways to achieve this: either the 32-bit kernel validates
>> the padding by killing the process if padding is non-zero, or the
>> 64-bit kernel treats compat mode by zeroing the high bits of padding.
>>
>> If we look at system call interfaces in general, I think the usual
>> approach is to clear the top bits whenever a value read from a
>> compat task ends up being used as a pointer. This is why I am tempted
>> to go for the "clear high bits" approach rather than killing the task.
> 
> I think the modern preference is to use fields of fixed size rather
> than long when UABI is involved.
> 
> In any event, I think the test you want is user_64bit_mode().

Currently, user_64bit_mode is only implemented on x86.

Should we introduce an architecture-agnostic user_64bit_mode(struct pt_regs *)
which maps to is_compat_task() for non-x86 ? I'm just worried that ptrace
code could try to use it from the context of another task and get mixed up.

> 
>>
>> Also, validating that the top 32-bit is zeroes from a native 32-bit
>> kernel requires extra loads, whereas not caring about their content
>> is free, which makes me slightly prefer an approach where 32-bit
>> compat mode on 64-bit kernel just clears the top bits.
>>
> 
> But performance is totally irrelvant here, right?  This only affects
> the abort path, unless I'm rather confused.

This load is added on return-to-userspace after a preemption, and upon
signal delivery. So it's not a fast-path.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
