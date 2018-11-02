Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71A720657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bPLcXLKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71A720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeKCA15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:27:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42451 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKCA15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:27:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so2357451wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfPxxHk0f50f6dqCzBYwwkhAPbv53ERmyCaLkHLzhRY=;
        b=bPLcXLKgjlChjHKzrE+oC6p5X/dP0JWYkFkMRuSyRH5xhfoNMwkBNL9NqIXR5mBYrd
         nRoEUpWf1A21KDxBavo9y/ubvx1Ril7Pn9WnSdWzcH9xZbDMpkaWBxDpYwlIBMoxUPo7
         lCEsm982B1TwXpyrcsNumbRzhIacsTuonJun+yZv6NRCx3DkIyunRRkL1DdgtpbrQvrA
         hI/t01z2rcK5ettpETgTLQMBRScrfLqD+vrFpi6+ILth3Yw2isMkNI+LBk2KPmhJJPIC
         OMcGOlI5U1Ato1qLFm5o9P3+vz4WC/SpvIzs74u7o/8zZsFUvbeV0z0OfYbTUgOhLvNB
         xJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfPxxHk0f50f6dqCzBYwwkhAPbv53ERmyCaLkHLzhRY=;
        b=TmW+3YQHy8cux0S8N1BNpMShuNy0F3zEG3Yviuw/umXFWj49bT+Zsuhxqa4UdqsG+r
         cOnAySit+l+iZI1uGuhjtofCcISuR13OfoPxDCZpfskr6dfy3NK1ed0tFAghvwMQLjNy
         f9W8Rh1/I5rAKkLBipA0sxCtqDG75yAYPwIawdvZQkLHY0iAm+GVye0DI702ggGa8kyT
         Kur7EtJMSYex9TnssU45wdseREplgtL/ltWUejGMwanKlrPooDGDzvYai7pJELfSDowm
         IMgaa2XLqrttzstROgHXzSWS1iXVFokahAvBxT1Ap/5vmq3311cJMgBv/S1Q9k6SnYr4
         gVuA==
X-Gm-Message-State: AGRZ1gL9w/ihPGFWo1LvSEDBCzZXVg31GHeJMMebqyMWJwdfS5s+C/jc
        dAILoa9twnzuAqoJ5HiwFbnVitCRYurPCql3EOCQJw==
X-Google-Smtp-Source: AJdET5dws959i1hjoTiIE4PTv8xJ7NpeEf/yBLMbzP/AyXq2K7cls/011CYL5wyQfcU7X6Yf3DC4Oux5uDoP30QVa3w=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr10002215wrc.131.1541172030852;
 Fri, 02 Nov 2018 08:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181102115259.11383-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20181102115259.11383-1-mathieu.desnoyers@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 2 Nov 2018 08:20:18 -0700
Message-ID: <CALCETrWG4j7R7jzuoPW6ifYVzwuQGMEHBp7Pb_k66_2hn1wUHg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] glibc: Perform rseq(2) registration at nptl init
 and thread creation (v3)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Joseph S. Myers" <joseph@codesourcery.com>, szabolcs.nagy@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:53 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Here is a third round of prototype registering rseq(2) TLS for each
> thread (including main), and unregistering for each thread (excluding
> main). "rseq" stands for Restartable Sequences.
>
> Remaining open questions:
>
> - How early do we want to register rseq and how late do we want to
>   unregister it ? It's important to consider if we expect rseq to
>   be used by the memory allocator and within destructor callbacks.
>   However, we want to be sure the TLS (__thread) area is properly
>   allocated across its entire use by rseq.
>
> - We do not need an atomic increment/decrement for the refcount per
>   se. Just being atomic with respect to the current thread (and nested
>   signals) would be enough. What is the proper API to use there ?
>
> See the rseq(2) man page proposed here:
>   https://lkml.org/lkml/2018/9/19/647
>

Merely having rseq registered carries some small but nonzero overhead,
right?  Should this perhaps live in a librseq.so or similar (possibly
built as part of libc) to avoid the overhead for programs that don't
use it?
