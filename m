Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D3A26F3A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="f4ikRtrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3A26F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755057AbeFZTcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:32:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32837 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeFZTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:32:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so18388097wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyZwxDwR0IPTb8b0HJ2A/QtKVQS7O55KugwpA1bxnhI=;
        b=f4ikRtrXumoKh+5L+Hinl935bR2lvzXiTv+bNWAqyQQjMx2OaonT11CXHRdUt5d7cG
         oq+d2Z7Pbq41ozevX066L4eHRG20PfHIuSyd8lIx+DQ3nxbXPbah7m/ppgrh0O3oCmdb
         dxy3cZruNx4O/tLs/+VbQV94AhDvLnXBS0h/8VwNni1PJxBI6JFJl0EKpK9hEs8aIMuQ
         Nst4zPZwJwEmV099JepoTQ+/akrQBYN7r6RB0CKUbvPW4rc27rIX7XT7vQ0Pz7Iy0LQp
         X98SVhWe3NqW/CDIOukQJWnPF3JWU51mMGjaec/1t7CtpTO3YOrzLgHStYkOUj3asL0x
         H6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyZwxDwR0IPTb8b0HJ2A/QtKVQS7O55KugwpA1bxnhI=;
        b=dBg0NrAz9N+5mnE9siIzkGQrr2K4naU9VSgi0wZqtaz+x18nneCm7jRGvqX1o71GYp
         QlF/R6tXdQbR8ugF/iXRx0GEkor7XKlJOa95fVO2MicAoAjJ/HxL+OqnuHgtiqEH8Cc0
         TdBNNpxetF6pNr4UzcdahPg5AhIEPaBaxxb7vbjZVV6+Ruae18UbY6wc/EBB8liZB3yp
         ibYsSJNiYM/UUeyF0xkSMTwnihzhSY8n5G5AofgQdG7z1ZxrDfjyaBscZq0ewa2d0Ys9
         9AXtCtlqHzu5JR6SDtpmURGs4VdjcUSKuhO/wETW957Ozynt1Fm8eNtR3XdDMHOWWAY0
         5sQw==
X-Gm-Message-State: APt69E1A4ZRykO9nMrx8pnzJ1c6gNW7V9VkiH/4RyB8WXWM7JIFvRZTz
        u7MKocmcH38pHWuY0EwpWVqwTwag/iPF6qiQfVbTeA==
X-Google-Smtp-Source: AAOMgpeZwXHi7pLbYs9XRX49ktK5QHN7ebIaKsRCeYD196hCZEplLvezJEC9zNKC882gt/OvrEUclkVbgchjZWdybqk=
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr2438418wrk.221.1530041553864;
 Tue, 26 Jun 2018 12:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com> <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com>
In-Reply-To: <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 Jun 2018 12:32:22 -0700
Message-ID: <CALCETrXimh61U7Tn9KShr6sKag7NCL3qfraN18Oy2Bk+0VRAUA@mail.gmail.com>
Subject: Re: rseq: How to test for compat task at signal delivery
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:45 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
> > Hi Andy,
> >
> > I would like to make the behavior rseq on compat tasks more robust
> > by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
> > bits of rseq_cs->abort_ip, rseq_cs->start_ip and
> > rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
> > kernel.
> >
> > The intent here is that if user-space has garbage rather than zeroes
> > in its struct rseq_cs fields padding, the behavior will be the same
> > whether the binary is run on 32-bit or 64 kernels.
> >
> > I know that internally, the kernel is making a transition from
> > is_compat_task() to in_compat_syscall().
> >
> > I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
> > invoked from a system call, but is it OK to call it when it is
> > invoked from signal delivery ? AFAIU, signals can be delivered
> > upon return from interrupt as well.
> >
> > If not, what strategy do you recommend for arch-agnostic code ?
>
> I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
> which I could use in the rseq code. I'll prepare a patch and we can discuss
> from there.
>

That sounds about right.

I'm confused, though.  Wouldn't it be more consistent to just segfault
if the high 32 bits are not clear when rseq transitions to a 32-bit
context?  If there's garbage in 64-bit mode, the program will crash.
Why should 32-bit mode be any different?
