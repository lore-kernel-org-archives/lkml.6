Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4907C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812A020700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lPiwGYtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfBVUSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:18:50 -0500
Received: from mail.efficios.com ([167.114.142.138]:53124 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:18:49 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DBDC81B617B;
        Fri, 22 Feb 2019 15:18:47 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id APOjNuhxJEfs; Fri, 22 Feb 2019 15:18:47 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F3A171B6173;
        Fri, 22 Feb 2019 15:18:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F3A171B6173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1550866727;
        bh=RWQa7xZDLkG6ufG7fv1kyR3M58NSWuQ7FX06KjwL24s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lPiwGYtTlMutyPXhZ0NXj7+AqWNrsCv/RCmZOOIH1F/yG71tcLs+JaWza0bAhS24h
         rPtZEnnMJoRWRzrArENTDLu5rj//a/ZUXj0fxchqn45zxsURjyvo4UQvSDhLvOV/VQ
         16De7GV/LHwrlgsBOFGRSBWgl+a3jznv/g1Zk1nqnwzHP8jqnMPRaD+R8I16UBtsbe
         emF9io1Hxo+7S/Rnj8L3G88JAfQC7oPQGQ3xARwEuQNbUrG2qEPG+OhSm5xn+JVp4r
         D2rOIeTWB61Edx76Ur+gXoaPH1VCktUvD0SIkKiqPec66wr+9QMr6U91+hzHfRERFs
         Kz/P3ayARZSjg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id GKPvfBSmkBW8; Fri, 22 Feb 2019 15:18:46 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D3E7D1B616A;
        Fri, 22 Feb 2019 15:18:46 -0500 (EST)
Date:   Fri, 22 Feb 2019 15:18:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <886010660.5183.1550866726676.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190222082924.GA16734@kroah.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com> <20190218122631.GE30260@kroah.com> <843587666.153.1550501735273.JavaMail.zimbra@efficios.com> <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com> <20190222001042.hm6j5h4hmfpwarzr@shell.armlinux.org.uk> <622813157.4561.1550794631564.JavaMail.zimbra@efficios.com> <20190222062550.GA3780@kroah.com> <20190222082924.GA16734@kroah.com>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Index: ndoCUPa9XcPKlbawYfDEuxYJbGCuZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 22, 2019, at 3:29 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Fri, Feb 22, 2019 at 07:25:50AM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Feb 21, 2019 at 07:17:11PM -0500, Mathieu Desnoyers wrote:
>> > ----- On Feb 21, 2019, at 7:10 PM, Russell King, ARM Linux linux@armlinux.org.uk
>> > wrote:
>> > 
>> > > On Thu, Feb 21, 2019 at 03:02:57PM -0500, Mathieu Desnoyers wrote:
>> > >> Hi Arnd, Russell, Linus,
>> > >> 
>> > >> Can we ensure the arm32 kprobes fix I submitted gets upstream before 5.0 final ?
>> > >> It takes care of an illegal instruction issue with optimized kprobes on arm32.
>> > >> 
>> > >> Here is the current state of default kprobes configuration on arm32:
>> > >> using them will trigger illegal instruction OOPS on v5.0-rc7, 4.19.24,
>> > >> v4.14.102.
>> > >> 
>> > >> My fix is in "accepted" state in the arm patch tracking system:
>> > >> 
>> > >> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
>> > >> 
>> > >> Should I send it directly to Linus as well ?
>> > > 
>> > > Accepted means it's in my tree pending to be sent to Linus.  It should
>> > > now be in mainline.  Have you checked?
>> > 
>> > Hrm, why did I not see it earlier today... it's embarrassing.
>> > 
>> > It's there indeed, all is good!
>> > 
>> > Greg, you should be able to pick it into the stable kernels now.
>> 
>> What is the git commit id of it?
> 
> Oh nevermind, I see it.  I'll queue it up for the next round of kernel
> releases after this one.

Sorry about late reply, it's indeed
commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")

upstream.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
