Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B1320663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rjlHzJZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B1320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437776AbeKWCNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:13:12 -0500
Received: from mail.efficios.com ([167.114.142.138]:43684 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437749AbeKWCNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:13:12 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 18ADB250CD0;
        Thu, 22 Nov 2018 10:33:20 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id cgZhkN1M_N7F; Thu, 22 Nov 2018 10:33:19 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BEA28250CCB;
        Thu, 22 Nov 2018 10:33:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BEA28250CCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542900799;
        bh=iX74avaxkopbTzW8iFc6KzfBB2ZkO1P69rbpcHrgCIU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rjlHzJZGqvxHpooCBau9wQ9dZbrMJyqkZ4gv1U9r/DKThVXwSAKeYgXLJSzf+zewZ
         KJjACqU0u2V0iTxGYSRVC9/eilGijS+zhXoTfEUvK4WTAV/KSbKdYQm7YeW00YN/3G
         RMEAyx4FI9+FNCpHtuuE/LAcQY09pSa8ERlIvWAuMbxsiNYWWY/yIvDl1RmFRr6w7u
         HXhT5zy8+yOfOogU4efl//LhpwzglBJtCmbMFmRArxEtPzFIEIpAmczrraX632jfpg
         RLxrKSa127dED8pOBwNZwkR4WcA1UyLsx292qzNjy9fTOKbDCigES1BqOwbleTenSC
         SAQIh7Yg99p3Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xTHlahvGACw5; Thu, 22 Nov 2018 10:33:19 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A05F9250CB3;
        Thu, 22 Nov 2018 10:33:19 -0500 (EST)
Date:   Thu, 22 Nov 2018 10:33:19 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Rich Felker <dalias@libc.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1306224240.10055.1542900799576.JavaMail.zimbra@efficios.com>
In-Reply-To: <875zwpyw81.fsf@oldenburg.str.redhat.com>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <20181122143603.GD23599@brightrain.aerifal.cx> <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com> <87a7m1ywni.fsf@oldenburg.str.redhat.com> <20181122151710.GF23599@brightrain.aerifal.cx> <875zwpyw81.fsf@oldenburg.str.redhat.com>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: VNsyWedxHflm6QgPfgC12cA12AhZDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 22, 2018, at 10:21 AM, Florian Weimer fweimer@redhat.com wrote:

> * Rich Felker:
> 
>> On Thu, Nov 22, 2018 at 04:11:45PM +0100, Florian Weimer wrote:
>>> * Mathieu Desnoyers:
>>> 
>>> > Thoughts ?
>>> >
>>> >   /* Unregister rseq TLS from kernel. */
>>> >   if (has_rseq && __rseq_unregister_current_thread ())
>>> >     abort();
>>> >
>>> >   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
>>> >                       pd->guardsize);
>>> >
>>> >   /* If the thread is detached free the TCB.  */
>>> >   if (IS_DETACHED (pd))
>>> >     /* Free the TCB.  */
>>> >     __free_tcb (pd);
>>> 
>>> Considering that we proceed to free the TCB, I really hope that all
>>> signals are blocked at this point.  (I have not checked this, though.)
>>> 
>>> Wouldn't this address your concern about access to the rseq area?
>>
>> I'm not familiar with glibc's logic here, but for other reasons, I
>> don't think freeing it is safe until the kernel task exit futex (set
>> via clone or set_tid_address) has fired. I would guess __free_tcb just
>> sets up for it to be reclaimable when this happens rather than
>> immediately freeing it for reuse.
> 
> Right, but in case of user-supplied stacks, we actually free TLS memory
> at this point, so signals need to be blocked because the TCB is
> (partially) gone after that.

Unfortuntately, disabling signals is not enough.

With rseq registered, the kernel accesses the rseq TLS area when returning to
user-space after _preemption_ of user-space, which can be triggered at any
point by an interrupt or a fault, even if signals are blocked.

So if there are cases where the TLS memory is freed while the thread is still
running, we _need_ to explicitly unregister rseq beforehand.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
