Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499EC00319
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957F52080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IRDT7po5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBVARP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:17:15 -0500
Received: from mail.efficios.com ([167.114.142.138]:55974 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfBVARO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:17:14 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 771E81B490F;
        Thu, 21 Feb 2019 19:17:12 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id rOqzMZeZKClw; Thu, 21 Feb 2019 19:17:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CC71C1B490C;
        Thu, 21 Feb 2019 19:17:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CC71C1B490C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550794631;
        bh=X1IaQn/z0rhMxgNYmXPodGhmYUcZTSz6kgVHCxZME4U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IRDT7po5WpJex5TDG4EDAQGhdEYxigPQoSNJnX3fjxsBFNe9gxhJRbOyx2EZflFuO
         8WsyjTOsXwjg59HqYoKQOqhdhG8WWK/Nnr1hbK4Na0HvbMO6jzxFILa3V2its3P/o5
         l2A2RMQgsiS1jbvzrGxYz37pla2OHDavwlbaJGsoWUqJYbDLfjDT3o7egG68xNb/0m
         6M8ipBjCiE9WQIoT1zYWg1fNDxX2j6EfuW9XEbLMBYd0C3Zh0tjzfGCgmB0ZBU5hwP
         U86oTsoEFUj12Yg9RC6tPT2BgFYwEDY70RxSXzhWfFJW/zhZqojt6F2HuoP0MWZM2R
         JMX5NzPIzpP0w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id a2XffBRDqRW0; Thu, 21 Feb 2019 19:17:11 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AC9391B48FC;
        Thu, 21 Feb 2019 19:17:11 -0500 (EST)
Date:   Thu, 21 Feb 2019 19:17:11 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Russell King, ARM Linux" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <622813157.4561.1550794631564.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190222001042.hm6j5h4hmfpwarzr@shell.armlinux.org.uk>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com> <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com> <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org> <20190218122631.GE30260@kroah.com> <843587666.153.1550501735273.JavaMail.zimbra@efficios.com> <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com> <20190222001042.hm6j5h4hmfpwarzr@shell.armlinux.org.uk>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Index: 5+At/aVCZETzUFh4OgPO/ag9JkcMJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 21, 2019, at 7:10 PM, Russell King, ARM Linux linux@armlinux.org.uk wrote:

> On Thu, Feb 21, 2019 at 03:02:57PM -0500, Mathieu Desnoyers wrote:
>> Hi Arnd, Russell, Linus,
>> 
>> Can we ensure the arm32 kprobes fix I submitted gets upstream before 5.0 final ?
>> It takes care of an illegal instruction issue with optimized kprobes on arm32.
>> 
>> Here is the current state of default kprobes configuration on arm32:
>> using them will trigger illegal instruction OOPS on v5.0-rc7, 4.19.24,
>> v4.14.102.
>> 
>> My fix is in "accepted" state in the arm patch tracking system:
>> 
>> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
>> 
>> Should I send it directly to Linus as well ?
> 
> Accepted means it's in my tree pending to be sent to Linus.  It should
> now be in mainline.  Have you checked?

Hrm, why did I not see it earlier today... it's embarrassing.

It's there indeed, all is good!

Greg, you should be able to pick it into the stable kernels now.

Thanks,

Mathieu


> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> ----- On Feb 18, 2019, at 9:55 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Feb 18, 2019, at 7:26 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org
>> > wrote:
>> > 
>> >> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
>> >>> On Tue, 5 Feb 2019 15:06:10 +0000
>> >>> Kees Cook <keescook@chromium.org> wrote:
>> >>> 
>> >>> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
>> >>> > <mathieu.desnoyers@efficios.com> wrote:
>> >>> > >
>> >>> > > Hi,
>> >>> > >
>> >>> > > I notice this commit as a possible culprit of the illegal instructions my lttng
>> >>> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
>> >>> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
>> >>> > > as well.
>> >>> > >
>> >>> > > commit e46daee53bb50bde38805f1823a182979724c229
>> >>> > > Author: Kees Cook <keescook@chromium.org>
>> >>> > > Date:   Tue Oct 30 22:12:56 2018 +0100
>> >>> > >
>> >>> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>> >>> > >
>> >>> > > I *think* the intent there was to do
>> >>> > >
>> >>> > > -       memcpy(code, &optprobe_template_entry,
>> >>> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>> >>> > >
>> >>> > > But if you look at the commit, the "&" seems to have been stripped away,
>> >>> > > which happens to change the behavior significantly.
>> >>> > 
>> >>> > Yeah, this was a typo on my part. :(
>> >>> 
>> >>> Ah, I thought it had been fixed as same as x86.
>> >>> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
>> >>> but on arm, it still be kprobe_opcode_t.
>> >>> 
>> >>> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h
>> >>> does.
>> >>> OK, I'll prepare for the change.
>> >> 
>> >> Did this ever get fixed in Linus's tree?  If so, what is the git commit
>> >> id, I can't seem to find anything...
>> > 
>> > It seems to still be in the arm patch tracking system:
>> > 
>> > https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
>> > 
>> > If I understand its status correctly, it is applied to the arm tree, but
>> > perhaps it has not been pulled by Linus yet ? The code is still broken
>> > in Linus' master.
>> > 
>> > It would be important to get this arm kprobes fix upstream before 5.0
>> > final.
>> > 
>> > Thanks,
>> > 
>> > Mathieu
>> > 
>> > 
>> > --
>> > Mathieu Desnoyers
>> > EfficiOS Inc.
>> > http://www.efficios.com
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> 
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
