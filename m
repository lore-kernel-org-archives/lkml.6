Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D57C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C930627D8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VFdlndzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C930627D8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936661AbeF2OCS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:02:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53611 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2OCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:02:17 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so2978755itd.3;
        Fri, 29 Jun 2018 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=411Lz3Evm6LxPhRpem83hpsPyshSD8IQWNZX9Pp29mQ=;
        b=VFdlndzNn7PABpBEITGmVKw/qR1oXm/FWsyqZqj8phiOib44w1CV7SjATRCIsdXl9L
         vX5C42BBvylEz0IA+mSOVsIjrP26dDlHK9lMpbJGmeHlJY4/eMRqIuCtQBSIeqRySUFe
         h+CyqT/0SXf5UTlXYJy7Ozkc/Mw8DIzyOX+ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=411Lz3Evm6LxPhRpem83hpsPyshSD8IQWNZX9Pp29mQ=;
        b=Sy8B4skY2oU3986R9u/wfnQ7pgS5b9Z8qHCGuvGxFazc/cRA85d3sAcf34Csat5mJ8
         m5uzoDJIOQv9dnc8sPnCWK10S+TkyOBXAQV1RpfrtisYQE1Fhtzz4WeIs99RPP0Sxxoh
         7sCxGtErXONkbHiuZ0KrS5HBDEneHl9Wq+tI8IcX5TYmf5hFWF483Hh01DD5mUBMhLPR
         e/s+Ww7CRj4+3nsBO7uh7d714lrCYBT/IU1hzrOqYYkfMjikF2xFgG2GDqsyALihxr10
         8s6Szb6S3woHCmWCmiSQ8Wz4k2kxSyweZjuonoqGvN7GQSoMv7oPV9aKtUrVbWEzbwF5
         hLIw==
X-Gm-Message-State: APt69E2pSZPhLT1X9J+RZYbLzmsNXKChCfVJ9g1Js7mA4iyd53HcOhHI
        ZuABh4Mpgv2SsoYZ0PxZl02FzE7H1HOslghLxjk=
X-Google-Smtp-Source: AAOMgpfhFp+AP5GSuGZyVgwZ8koGqnmv3L+CoUr4rpWJwgu6hRyaxBIFs9V7NxBf6OT7gCymDBBuEe4moL9DR9x0/jI=
X-Received: by 2002:a24:e0a:: with SMTP id 10-v6mr1158577ite.1.1530280936278;
 Fri, 29 Jun 2018 07:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
 <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
 <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
 <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com> <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net>
In-Reply-To: <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 07:02:04 -0700
Message-ID: <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, joelaf@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 6:08 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Jun 28, 2018, at 5:18 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > Make it do
> >
> >        if (rseq_cs->abort_ip != (unsigned long)rseq_cs->abort_ip)
> >                return -EINVAL;
> >
> > at abort time.
>
> You sure?  Because, unless I remember wrong, a 32-bit user program on a 64-bit kernel will actually work at least most of the time even if high bits are set.

Sure.

If you run a 32-bit binary on a 64-bit kernel,. you will have access
to the 0xc0000000 - 0xffffffff area that you wouldn't have had access
to if it ran on a 32-bit kernel.

But exactly *because* you have access to that area, those addresses
are actually valid addresses for the 32-bit case, so they shouldn't be
considered bad. They can't happen on a native 32-bit kerne, but a
32-bit program doesn't even care. If it has user memory mapped in that
area, it should work.

And if it *doesn't* have user memory mapped in that area, then it will
fail when the trying to execute the (non-existent) abort sequence.

After all, depending on configuration, a native 32-bit kernel might
limit user space even more (ie some vendors had a 2G:2G split instead
of the traditional 3G:1G split.

Was that the case you were thinking of, or was it something else?

              Linus
