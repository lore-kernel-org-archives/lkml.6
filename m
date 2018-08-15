Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FDC21528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GfagmevK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDC21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHOV5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:57:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39606 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbeHOV5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:57:35 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so1854110iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zIBQK5kS4J9YhuEHes31K5V1rpNIQR59/RCacyOg08=;
        b=GfagmevKUwJnXKfiX4c3VHiczhZ1jYALrMyc5ASHTl71B2znVUPZWrkHrTe/+6wBtz
         6opj6QDEM4dbJAh5QIgHxlHIgKYzi8PAKvx1QAimYegUiXwwFLY6Q1vEfLqYEBckuoVT
         nrXGi40nEAv45KqbC98QIVSKyQFKhuUnXRE6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zIBQK5kS4J9YhuEHes31K5V1rpNIQR59/RCacyOg08=;
        b=q6tSlu8JSgz+TIQgRURE5fZfAYrD8mfAHhL/CJdDMfR9YX0AScRxQJuKoRbpDeoOTU
         TijBmQ/P4GgQanqhh3DtpPr0OonGk+lAwXpGO2PtL1fNm+9y2FnyoQ/NJUC88soz7MSd
         JGKPmd6PiYrngQue7jw9fN03W9G+kf5PCz7+UpJAdv4WG5lkxjj+8d5rqP4bmWWkgzly
         S2PaxCKSIYpAEO/E2hCxTXsyiLTtvmIfayRU8lVomi/WwRCWyqMjaRHwepJ0iqGS4/Ul
         n+P2GchZR8EcFJA8lSKhtqrPglomCRuLCegTM2c6fBH72lTQX+C5x8kxa0/cbFJlJtVV
         tfuA==
X-Gm-Message-State: AOUpUlHNdjJ90u+brMjMIvm1Axai6JvZFA0hCPtGjrJ92c2XN7BFlt98
        bCBn06A+JCL7Dcc9Q4jt9X0bVJ8M00hnTR1Sgks=
X-Google-Smtp-Source: AA+uWPyTFPax4RXMvGHWZe9rj31TswmV5MtuOQRkJRbNXkwn4OczXDP3gO5WDts391vw6WkZcCJCOdHm/EW+o1/2rP8=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr18963431iom.238.1534359851720;
 Wed, 15 Aug 2018 12:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
In-Reply-To: <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 12:04:00 -0700
Message-ID: <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:35 AM Kees Cook <keescook@chromium.org> wrote:
>
> I swear I'm doing my best. Are you speaking of
> stackleak_check_alloca() or stackleak_erase()? These were both
> discussed on the list, and we weren't able to come up with
> alternatives: in both cases we're off the stack, and recovery is
> seemingly impossible.

Why do you even *test* that thing? Why don't you just allocate stack
and clear it.

Dammit, the whole f*cking point of this patch-set is to clear the
stack used. It is *not* supposed to do anything else. If the process
runs out of stack, that's caught by the vmalloc'ed stack.

And if you don't  have vmalloc'ed stack, then clearly you don't care.

I refuse to take this kind of code that does stupid things, and then
*because* it does those initial stupid things it does even more stupid
things to correct for it.

I hated the thing to begin with, told people that there are better
approaches that don't have the downsides, got ignored, and then I'm
pushed crap.

No.

         Linus
