Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73906C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2F22084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="m/lMndz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfASFBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:01:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfASFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:01:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so17477922wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dd9uwnCge9rZcDt0ijTnyOKRUuOBLcXVaM7FFtHlqyk=;
        b=m/lMndz86n8qPCJkLnKM+2V8yp2QOlQoYKvQVfqIZxcqVyvkvqo3V3x8YgJZYVYwYV
         7Tjt0dCO75NQhDH89M+FgJhxwAynIsLjeh1DVqzpTfoBBP2g1gHFJtfzHb7O7oVulxSG
         l5/4AXsoG6yPYEcKDmhlbMk1ltUTZvZFtN5ONSsMcishoZZCNgRy3IdlfgRO108TunNv
         XS28d1OwAsoWpbgFUTfJVKH2mi+qxJ7S/4fPop0F1srTxVFmGJxm8HmAbXqKsKHwAQ9N
         WBr7MTlrgovfn0E3tTvvcloSTI3VRNatCOhn0CIPMsqQ74W+WkbWUsyyvLrtEwZ6M8++
         u70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dd9uwnCge9rZcDt0ijTnyOKRUuOBLcXVaM7FFtHlqyk=;
        b=Aqq7rJ2CXlxm9cQEZH+9FxB66hqFDuDsjs1V0kQfHE+05Jvaw8qvKapGa7zoiSliG/
         ZhhiKo7Q+uF+SQF9zUCG7WQtrpJJD/5RA0vtW+xpqZXNaZumos8kQAML9kszQFIEtoSK
         u7+jX2NLpkhp9kcxxvrKz+edMc4STmYrOr1GXWI5EOkTNQhJPhXrCCljb0Vlh4r4ByDe
         XzRTX/t4e1o3Av2fHbPe1O9cHvqRxkO/LNygzhefpjSt+1rxVZ0gCpuZwPkNxQl33cNr
         Xcyq1zn7VQUzITj+VcsgoQynAld4PTxJE5MDzVA9Drx32UNyD2pOd0HX7LFIuqLbV0PU
         8kbQ==
X-Gm-Message-State: AJcUukd4+ROlxEnfRnTpmVG4Cx3o4BiSS7cesV8OenK3pSpplJWgr2o8
        CGXVPbV8FdYUupZx947l0i+ZeOm9rOQJlI9YNWqe6A==
X-Google-Smtp-Source: ALg8bN7bWIXwsYSaGJWRvj6S8+2Cbrr8+/RaHeRFtYs6v7G/Af1d+RcYGXBOCPbnaUs7FaZdKGco3N442YyvbCXZSM8=
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr20507314wrp.59.1547874063225;
 Fri, 18 Jan 2019 21:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20181227111821.80908-1-anup@brainfault.org> <20181227111821.80908-3-anup@brainfault.org>
 <20190115155437.GA13095@infradead.org>
In-Reply-To: <20190115155437.GA13095@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 10:30:52 +0530
Message-ID: <CAAhSdy1JOFW3f_xtZSjjHPzcHWoG5C50tXzm7U=Oav9GYD=j8g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] irqchip: sifive-plic: Don't inline plic_toggle()
 and plic_irq_toggle()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 9:24 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 27, 2018 at 04:48:18PM +0530, Anup Patel wrote:
> > The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
> > for loop so both these functions are not suitable for being inline
> > hence this patch removes the inline keyword.
>
> That is a weird argument for a function which has by design exactly
> two callers and is in the hot path.  The alternative to the inline
> here would be to duplicate the code.

It's strange that you see it as weird argument. Both plic_toggle()
and plic_irq_toggle() are 5+ lines functions with loops. The loop
is clear in plic_irq_toggle() whereas raw_spin_lock() in plic_toggle()
expands into inline-assembly spin-loop because raw_spin_lock()
is a macro (not function).

Further looking at disassembly of both functions, these are 55+
instructions. I think we let GCC decide whether these functions
should be inlined or not rather than us explicitly making these
functions inline.

Regards,
Anup
