Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68BC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161F620836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QlDj66ZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBUUDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:03:01 -0500
Received: from mail.efficios.com ([167.114.142.138]:59242 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBUUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:03:00 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C85971B357A;
        Thu, 21 Feb 2019 15:02:58 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 11AiLufJqNMC; Thu, 21 Feb 2019 15:02:58 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0B1211B3573;
        Thu, 21 Feb 2019 15:02:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B1211B3573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550779378;
        bh=N3u63UF5kn45Gi0BudIlAjinzYY1ZSPm2sqD9msLlVA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QlDj66ZMeZ+WTqonLijb6+b1bQoq72o6Lg+TvfzPQ6Hea+G6MFMAcun37fsj0H1hK
         4H6UKWEmxDG3Pfg1hk7JTHGvtoD+eivB5M4SPvSAWrK5GG8ZAkrAk2N5K9JCvnm5xy
         qj/lxmeTxtkvoCnjpYN2z4eSXX/prTIhNcW7scuVR/1a1bJ/9lm3BYFhNdywwfu9y9
         672WR5ey+W2NQ2PX5jCYFrh8COIlNk8wfhyPzDyv61eGli8mlg7diz50+w0k5RwyKI
         +6hej7SdzS7HdtTTDX+Gd8de8rKuF9lISl4+OpvUxE1+M81SDMTuxnNAUH/bq+rIhK
         L6xZp7fr7sW4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id f2JTL5PKS5U4; Thu, 21 Feb 2019 15:02:57 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E069B1B356C;
        Thu, 21 Feb 2019 15:02:57 -0500 (EST)
Date:   Thu, 21 Feb 2019 15:02:57 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com>
In-Reply-To: <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com> <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com> <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org> <20190218122631.GE30260@kroah.com> <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Index: aysduGqTEJ/aj3gGSgj9LBgUddzFGu/0q1MO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Russell, Linus,

Can we ensure the arm32 kprobes fix I submitted gets upstream before 5.0 final ?
It takes care of an illegal instruction issue with optimized kprobes on arm32.

Here is the current state of default kprobes configuration on arm32:
using them will trigger illegal instruction OOPS on v5.0-rc7, 4.19.24,
v4.14.102.

My fix is in "accepted" state in the arm patch tracking system:

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1

Should I send it directly to Linus as well ?

Thanks,

Mathieu

----- On Feb 18, 2019, at 9:55 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Feb 18, 2019, at 7:26 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org
> wrote:
> 
>> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
>>> On Tue, 5 Feb 2019 15:06:10 +0000
>>> Kees Cook <keescook@chromium.org> wrote:
>>> 
>>> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
>>> > <mathieu.desnoyers@efficios.com> wrote:
>>> > >
>>> > > Hi,
>>> > >
>>> > > I notice this commit as a possible culprit of the illegal instructions my lttng
>>> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
>>> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
>>> > > as well.
>>> > >
>>> > > commit e46daee53bb50bde38805f1823a182979724c229
>>> > > Author: Kees Cook <keescook@chromium.org>
>>> > > Date:   Tue Oct 30 22:12:56 2018 +0100
>>> > >
>>> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>>> > >
>>> > > I *think* the intent there was to do
>>> > >
>>> > > -       memcpy(code, &optprobe_template_entry,
>>> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>>> > >
>>> > > But if you look at the commit, the "&" seems to have been stripped away,
>>> > > which happens to change the behavior significantly.
>>> > 
>>> > Yeah, this was a typo on my part. :(
>>> 
>>> Ah, I thought it had been fixed as same as x86.
>>> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
>>> but on arm, it still be kprobe_opcode_t.
>>> 
>>> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h
>>> does.
>>> OK, I'll prepare for the change.
>> 
>> Did this ever get fixed in Linus's tree?  If so, what is the git commit
>> id, I can't seem to find anything...
> 
> It seems to still be in the arm patch tracking system:
> 
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
> 
> If I understand its status correctly, it is applied to the arm tree, but
> perhaps it has not been pulled by Linus yet ? The code is still broken
> in Linus' master.
> 
> It would be important to get this arm kprobes fix upstream before 5.0
> final.
> 
> Thanks,
> 
> Mathieu
> 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
