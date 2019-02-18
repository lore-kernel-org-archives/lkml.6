Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC261C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE8E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="k2f3dj4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfBROzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:55:38 -0500
Received: from mail.efficios.com ([167.114.142.138]:37070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbfBROzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:55:37 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 724BAB1079;
        Mon, 18 Feb 2019 09:55:36 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id wSdFUddev7jS; Mon, 18 Feb 2019 09:55:35 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6ABEAB106B;
        Mon, 18 Feb 2019 09:55:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6ABEAB106B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550501735;
        bh=dqICPl8GxPnt3Rpfa7GIh3OrSg7rfOI6RBVqZWpJ6Hw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k2f3dj4tGsu2PlP+cJd5FOQ9hITSTZLzzx+Pa7qYOeFjssg9WSh9ccw9MUkjFIOft
         X25/vDix6x95v2PXp9S/Rr5Zku63DUKG4mnyUnPfnFlpgRCk9hKUOmzZLksD+d7DxH
         ZrmxlyXMblINfcBAHb+vxFUoUKuG8bq5t+cvjBzbr+QzEXfoRP6SbU1cekFJIvQ7dw
         YqM8g/6rU2mot8EqM5R5/F/kPZrhJxC5GS/5K/l2X0Zfw5A3U0i0XsIMWbzj6cMT4S
         45JIs6rfXq0Wp4OlBrSMFJ4m9r/DEVuiON6di7jW+p+7b2sgur73942pUMty/okXgQ
         kJ83Ds2IMB7sw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TE65ajgzXElK; Mon, 18 Feb 2019 09:55:35 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4C1F0B105F;
        Mon, 18 Feb 2019 09:55:35 -0500 (EST)
Date:   Mon, 18 Feb 2019 09:55:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190218122631.GE30260@kroah.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com> <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com> <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org> <20190218122631.GE30260@kroah.com>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Index: aysduGqTEJ/aj3gGSgj9LBgUddzFGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 18, 2019, at 7:26 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
>> On Tue, 5 Feb 2019 15:06:10 +0000
>> Kees Cook <keescook@chromium.org> wrote:
>> 
>> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> > >
>> > > Hi,
>> > >
>> > > I notice this commit as a possible culprit of the illegal instructions my lttng
>> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
>> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
>> > > as well.
>> > >
>> > > commit e46daee53bb50bde38805f1823a182979724c229
>> > > Author: Kees Cook <keescook@chromium.org>
>> > > Date:   Tue Oct 30 22:12:56 2018 +0100
>> > >
>> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>> > >
>> > > I *think* the intent there was to do
>> > >
>> > > -       memcpy(code, &optprobe_template_entry,
>> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>> > >
>> > > But if you look at the commit, the "&" seems to have been stripped away,
>> > > which happens to change the behavior significantly.
>> > 
>> > Yeah, this was a typo on my part. :(
>> 
>> Ah, I thought it had been fixed as same as x86.
>> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
>> but on arm, it still be kprobe_opcode_t.
>> 
>> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h
>> does.
>> OK, I'll prepare for the change.
> 
> Did this ever get fixed in Linus's tree?  If so, what is the git commit
> id, I can't seem to find anything...

It seems to still be in the arm patch tracking system:

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1

If I understand its status correctly, it is applied to the arm tree, but
perhaps it has not been pulled by Linus yet ? The code is still broken
in Linus' master.

It would be important to get this arm kprobes fix upstream before 5.0
final.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
