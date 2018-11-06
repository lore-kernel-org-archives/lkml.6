Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB58C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E932083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAydqI2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E932083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbeKFXfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:35:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46333 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKFXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:35:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so4386256lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpOAl1OpAEp8M5kp0g/sQDdZ2i7LNZSniMj1qN+icZE=;
        b=bAydqI2eN9Y7XUm6vppUgsQX/xlIjB5RJXzOFjBiYWGDW+sI156lt+kA/LPGbYl0DN
         aL0uiqBUdAdi7Qou4u32lqSPSCmHUp6UxYWuHxDv5RwVEXxq1nEE7alifYFb6BHfhLkD
         WsDZTYUxXTYUY7tZwGg3ft1UUrVUFRbFDmmulfHccAPNQkZ9ug+nDRUHeoJ2AGMWWHIA
         eWE2WW9tPgoL+6sFYk02ihg+QB94jc4JAg+WkJgNEb7vjYXl36+6NP/Avx+eH2Nf1z6B
         gRPmk77oJKhXCWIEVcLuMzFM9KPe/6lq9aPjmunH+dZx+GkvDOpiKKTEOG5AxkA6Zdn9
         YcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpOAl1OpAEp8M5kp0g/sQDdZ2i7LNZSniMj1qN+icZE=;
        b=bT/UPx4XA8o3fVHTSgG0Dn0+btjqO0+LKezx/QXRd4VQL8rIXH0Jg8vyXiXW+or6+W
         RV68Z8wO1umkOTQqhDC9Vggwfq5sIl7EN+wpuQ0CuGhqbghtu0NGmC4jK+EwWctva2kF
         sn39E7M0T7FVkE5F+yaLb+IOwtcH0MSxp6nO5HNY3MMSgiFNKC3/t1NudVrpWBnuZDNK
         w1lANdXi/UL8O8wrSCOd28e5NmdAI03hQo1RRw04b1W7h/kXBcxlOLmZWPJt+/yQpxAp
         y88ompsrl4tJFpKJmyqy/JHysXKC+EvBOz/Fd7hnbsmHGVxHuRyaypJd6lD2T0S5O09Z
         cnzQ==
X-Gm-Message-State: AGRZ1gJ1y4dGM9X7Xrkwq1E27usxst2WB5a2GB4Bx+CWkorxPgCXCCAd
        A2RCj14Cfn3nOOvAJ1K2BOAqSgZ3jFos9aqBMNE=
X-Google-Smtp-Source: AJdET5dbFXPMl/lj1mypzpsuqExd7zbGwptWFZBFQOiFdU3k4EJaM2f2mDbVGbq+rC1XwEgfe4SBPCzEnNCsj2Ju3Ps=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr15104488lfa.49.1541513389531;
 Tue, 06 Nov 2018 06:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 6 Nov 2018 15:09:37 +0100
Message-ID: <CANiq72=VUEvPJf_U8s+FJbdj7pbEpsxepFaduUoW7Ov_arnRGA@mail.gmail.com>
Subject: Re: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, namit@vmware.com,
        Joe Perches <joe@perches.com>, segher@kernel.crashing.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 11:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> allows adding the "inline" keyword to 'asm ("")' statements. The
> problem is that we're possibly redefining "inline" to
> "inline __attribute__((__always_inline__))" which makes the proposed:
>
>   asm volatile inline ("")
>
> (...)
>
> -#define inline inline
> -#define inline   inline
> -

It seems somehow your patch got underscores removed.

By the way, we have been re#defining the inline keyword since (at
least) 2003, and already in 2008 Ingo was commenting in a commit to
add the #ifdef to avoid it for x86. Is it still a good idea nowadays
that the minimum compiler is quite modern compare to a decade ago? Is
it still needed on non-x86 arches (they don't have it in the
defconfig)? Couldn't functions be marked as __always_inline if really
needed (as many are)?

By the way (x2): CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING is only ever
referenced in that #ifdef. May it be removed?

Cheers,
Miguel
