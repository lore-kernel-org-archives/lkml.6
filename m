Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD39C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D7E2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WcKudnip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D7E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeKBHWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:22:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:34048 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKBHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:22:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BE916248FD5;
        Thu,  1 Nov 2018 18:17:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id pT1KKaqffgvx; Thu,  1 Nov 2018 18:17:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 08605248FCC;
        Thu,  1 Nov 2018 18:17:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 08605248FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541110640;
        bh=nLOC64PJ5pF7Y01BvQ3alJLieZtPk44Z1AwJKP6NkEs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WcKudnipIEsiA6SlbNFYmhyE9timeyuSRrwBgsN0hCPLmmmidaYSdblzRXoYmkh+4
         DW4hflmsg5zusDOmC5OBGGIDg8+tZMDeXRc/u90HKUDGqrNHCricrrSLzzfbLh55oB
         0BlEOnxPhe1MUla6bNH+W4km7ihTt7ZttnK0AZ+lHXdCNdtKbalYbiCRg9Zgi1/vlR
         Ye6F9k6Xgn1FhcP5dAqq5s/h4Ao/NQkqKivemDxZLtoIXMxz0x4pMYNUdshBfLN1Cx
         ISkttrp2FAQr2R9KoOl4CpP+jjbLfA0FngD3pzqadMb+pI7eIRUp+8AWcUSSn3+52D
         cd89tTBmG2Eng==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 8L99Eqgy8iMi; Thu,  1 Nov 2018 18:17:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D7123248FC4;
        Thu,  1 Nov 2018 18:17:19 -0400 (EDT)
Date:   Thu, 1 Nov 2018 18:17:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Message-ID: <1770995215.4046.1541110639818.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wiOm8x5KnBQH+FYN76sSjCeP2_9cxgzu4WArR3jP0MD8g@mail.gmail.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com> <20181101095844.24462-4-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1811011320160.1642@nanos.tec.linutronix.de> <20181101144623.61d43102@gandalf.local.home> <278477314.3995.1541102273591.JavaMail.zimbra@efficios.com> <CAHk-=wiOm8x5KnBQH+FYN76sSjCeP2_9cxgzu4WArR3jP0MD8g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.21 03/16] mm: Replace BUG_ON() by WARN_ON() in
 vm_unmap_ram()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: Replace BUG_ON() by WARN_ON() in vm_unmap_ram()
Thread-Index: u7d7Mm49+9xZFUQFHlYrNmBJx3nCrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 1, 2018, at 11:00 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Nov 1, 2018 at 12:57 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> > I think the graceful recovery is to simply return:
>> >
>> >       if (WARN_ON(cond))
>> >               return;
>> >
>> > is better than just
>> >
>> >       BUG_ON(cond);
>> >
>> > As that's what Linus made pretty clear at the Maintainer's Summit.
>>
>> That's it. For an unmap function, this basically boils down to
>> print a warning and leak the memory on internal unmap error.
>>
>> I will update the commit message describing this behavior.
> 
> It might be even better to use WARN_ON_ONCE().
> 
> If it's a "this shouldn't happen" situation, the advantage of
> WARN_ON_ONCE() is that it will still show the backtrace of the "how
> the heck did it happen after all" situation, but if it turns ouit to
> be user-triggerable (or simply triggerable by some odd hw situation),
> it won't spam your logs forever.
> 
> Obviously, things like rate limiting etc can also be good ideas, but
> that's just overkill for "this really should never happen" cases.
> 
> (Side note: WARN_ON_ONCE() will _warn_ just once, but will always
> return the condition that it warns for, so the return value is _not_
> "I have warned", but "I have seen the condition that I should warn
> about". Just in case people are worried about it).

Allright, I'll update this patch (and the following one implementing
vm_{map,unmap}_user_ram) to use WARN_ON_ONCE().

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
