Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72482133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XfODicEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLRIuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:50:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40221 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:50:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so14991908wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8CVInH/SbEiauJpAH+701m4etUfcrFaiMTk9o+WaXM=;
        b=XfODicEZuXglLaLhb0Mx6r7CDHrVRQnpjHtTqVFRqLzKs93Q0/5G4JzUMttOtwTm3o
         gc2OMYxj7QZGuMJcOljt/AmxYq3qXSQRbXsBouoG7CGwqx+r5TYjJAd54HEmGzSSWA0l
         j3zRwkHxrZK2ueV2l+hIUopDlMjeTc8jeUkvUiEUjryHrQp/UaFMNPzgHSgtXoX8EelP
         FyADUBTcXXqbIL4usyRZUeQaDXeB9rhIgdH9w6eyeY1BwR0g1DL1XdpuTbv7kmTvUCCl
         2KONdXA43hKkLnPm+0cSMGvigCY0P2CdWvAjKlkTxERmGZ+SuGE+l0YKyQg461siaRpH
         sCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8CVInH/SbEiauJpAH+701m4etUfcrFaiMTk9o+WaXM=;
        b=Ip1BN3tX5ssgS4FffE+gTrBznFHa9KDRqPGW72lzc0pFBLbo/V0AvIQqdv3iseU+di
         fkeYD03rIjljJRhOrHdDQG5O/wQLNCivLpiFnnrCwvmz7y8jYS6mQw6sNLw0o+Xfowoz
         nhDyzVVowosIp8D8uH6hoJ/kV/s4zBDSPJF5Xr6lgU3NaPaPKN0ORWBQNJpV5NkjHoGa
         itcidYPN/Uem6UUf0K99CglCHZnroxjBBJa/LVZIMqthDQJWwHIMO1YutRn4hODaAwwo
         swf+UlJSg7mD3Y4otgEeWpHBXPHZFMOjpfv2ZcIj8XQ+N+aHULKC/DHG8pAyg8uz481p
         dqlA==
X-Gm-Message-State: AA+aEWalh9B7o+J82e95TpVmGwumCgebg1PXjN8796P0VpMJQ17iYlKz
        cpjYZ9/alZ0agWylEmFTCvwo58g0w6AdLWAD8AQztg==
X-Google-Smtp-Source: AFSGD/WKPPe/HQ7gZY5Aorl6zhP8OTNnHT2P8RntasKyZaqkXlwXzXL63KPV/JNloZx6uWTkOxX5DeUECoCrRzBIF/U=
X-Received: by 2002:adf:f785:: with SMTP id q5mr14616682wrp.9.1545123021978;
 Tue, 18 Dec 2018 00:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-4-anup@brainfault.org>
 <20181217182719.GC7086@infradead.org>
In-Reply-To: <20181217182719.GC7086@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 14:20:10 +0530
Message-ID: <CAAhSdy3i+ap2J0By3nRqK6yvb8oD4-+2QwUO9PH9GM+0odKqSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] irqchip: sifive-plic: More flexible plic_irq_toggle()
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

On Mon, Dec 17, 2018 at 11:57 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > -static inline void plic_toggle(struct plic_handler *handler,
> > -                             int hwirq, int enable)
> > +static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
> >  {
> >       u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
> >       u32 hwirq_mask = 1 << (hwirq % 32);
> > @@ -92,27 +91,27 @@ static inline void plic_toggle(struct plic_handler *handler,
> >       raw_spin_unlock(&handler->enable_lock);
> >  }
> >
> > -static inline void plic_irq_toggle(struct irq_data *d, int enable)
> > +static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
>
> It also removes inline statements which seems rather unrelated to
> the patch description.

Actually these functions should not be inline because plic_toggle() uses
raw_spin_lock() and plic_irq_toggle() uses for-loop.

>
> Also the actual addintion of the single cpumask argument is simple
> enough that it should probably go into the patch that makes use of it.

OK, I will have separate patch for removing "inline" and move addition
of cpumask argument to last patch.

Regards,
Anup
