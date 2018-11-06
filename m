Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB71C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFDB20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT3LbXPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFDB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbeKGCr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:47:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35225 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388987AbeKGCr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:47:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so9460531lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KL/TXHJ9tRTBtZbAo4en4y4moLqNmxu8glUjmxpXqZM=;
        b=bT3LbXPXTwX3DIpaUEYAtfi8NohysF7yNnfX+4lBxlWx9in1zKJGwL5MLLovgwLiIx
         GnHsTw6IhAnJkzJCaiifQDuhiekEXZIIFQ59Jgok4lXzYH8pPlZ0XxaxG5IR1vSgaDZ6
         2zL9ISMTVjdhE2G965THJiO+JWvveagBKk6Z3sIu6xg0wQt+JoPtds+f+j/auG691J/U
         K94CuWoo/x8x+FhMnNpVNavkozDFOtxQbFExy10M0b3WQphJ6Lht1IBSsr5kFQbVN1tQ
         lDt024hhJGfjgd013jZuK6kot5qToGGwArBAKWv2PE+25PegM4B/0vA/oBpttBGw9fK4
         AcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL/TXHJ9tRTBtZbAo4en4y4moLqNmxu8glUjmxpXqZM=;
        b=h+fwa2fyuCLooilltgKXmalLPPWVi/6nyoBCOcta9SmJwed/5NMWr221ZyqfMETX/X
         0AKOVm4nxD5ZQEjrdTjDOkx41BWq5kEOO2/dadzmNOd9NfMR1NHaD7698tZjkXChyQJG
         v6/9c2KRB0QRz5O4KyTJJvqalxw7bBzhdvQM/4mw51DcCeTfzo/z3p8hQU7IB2+OcDvi
         gRnuUez456H7mPm5TAM46FG4P3t6FaOcBwMuLOD//7TcH+/JM+A7EOziDv3YHR+wbrM0
         WPfnFVbC2w8nrCrVVemeUW9XzXlko7RFJSOmCNvAZ/RSOqWXTy3XiaGhQPPBLjhxnX+k
         w9ew==
X-Gm-Message-State: AGRZ1gLn9/mVgcKZNV7g1dOBBv3vAKbNPiug1qor5BusmJa5Yrh7miJx
        hhiQiffK3yGVmKPCloZwOAqGcspKQEU8XsaJLKo=
X-Google-Smtp-Source: AJdET5fj3RcYExIsDjvDBRpDQHAr1D8Y9OUmjyhxkfAIvPyUO8HWYVyedHRd9LUc6fTjyp9HohmAhrVSSsDOHyQssMA=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr15335314lfk.151.1541524904698;
 Tue, 06 Nov 2018 09:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
 <CANiq72=VUEvPJf_U8s+FJbdj7pbEpsxepFaduUoW7Ov_arnRGA@mail.gmail.com> <20181106144619.GB9781@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106144619.GB9781@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 6 Nov 2018 18:21:33 +0100
Message-ID: <CANiq72n9KkCzJYD+9Xz-SSYy05ePmkB-A0XOnAqaVu8cWJ9S1Q@mail.gmail.com>
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

On Tue, Nov 6, 2018 at 3:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> If you actually read what I wrote:

You got me, I did read very quickly :)

> Dunno, but that is a far more difficult patch. The proposed one is an
> obvious identify.

I would say they are orthogonal, even if both would solve the problem.
I also wondered why we have the funny __inline[__] stuff around while
doing the compiler attributes series, so I thought bringing it up.

Cheers,
Miguel
