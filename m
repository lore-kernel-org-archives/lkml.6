Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E469C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977226957
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EXyD080P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D977226957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeFZSpP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:45:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:59318 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933615AbeFZSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:45:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4F67522B8F1;
        Tue, 26 Jun 2018 14:45:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OwxrCMlfO9Xq; Tue, 26 Jun 2018 14:45:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BF4B022B8EE;
        Tue, 26 Jun 2018 14:45:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BF4B022B8EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530038711;
        bh=v8nSl5O6JQotaKpRZ2s3rbOoTbh14uB3IPy5ozjdjYY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EXyD080PS1Cij6dp/BWoIthYJ5ZdRYYHrrhzTwJtYJSXizuUhBzGIOD2VbhhJGP1A
         5tV8BnLowaOb3NGS5vWaO6g0d7at981xfJkkDGFWL2dNfsRls0KYxA7JgcmG0tTkrw
         2IMK9eW+jT+HDDOxUYXLRAwJVTJOnmTBRFOUHgSrweOvUj1crWhkL9xkR6EAqcG80O
         Y6Ad7lLKAuklMGSnol+WmLBB8bwlK2K2KROlb45WeLkQVQK9mDbCMtHWM3C+STiC+b
         WVfc9xIpEXyWzxWAj+aIkG/4cctGNafkvrajVNZTTvxONdWAcraRfho/xCXwl3DCT7
         HTXoWX1NmMrbg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id NtQIekr6jv7F; Tue, 26 Jun 2018 14:45:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AB41F22B8E5;
        Tue, 26 Jun 2018 14:45:11 -0400 (EDT)
Date:   Tue, 26 Jun 2018 14:45:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com>
In-Reply-To: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com>
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com>
Subject: Re: rseq: How to test for compat task at signal delivery
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: How to test for compat task at signal delivery
Thread-Index: F0bW3mNX5qaSbdCuC2GA2EC17JUeiAc/l39L
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi Andy,
> 
> I would like to make the behavior rseq on compat tasks more robust
> by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
> bits of rseq_cs->abort_ip, rseq_cs->start_ip and
> rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
> kernel.
> 
> The intent here is that if user-space has garbage rather than zeroes
> in its struct rseq_cs fields padding, the behavior will be the same
> whether the binary is run on 32-bit or 64 kernels.
> 
> I know that internally, the kernel is making a transition from
> is_compat_task() to in_compat_syscall().
> 
> I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
> invoked from a system call, but is it OK to call it when it is
> invoked from signal delivery ? AFAIU, signals can be delivered
> upon return from interrupt as well.
> 
> If not, what strategy do you recommend for arch-agnostic code ?

I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
which I could use in the rseq code. I'll prepare a patch and we can discuss
from there.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
