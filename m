Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AACECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D47214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0UPs1kc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D47214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeIQVWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:22:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeIQVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:22:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so17858640wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvzl9H3xPJzLzHnnsDcqJvOeljahJanEEgDBqdLYdMQ=;
        b=0UPs1kc/PQYzgjvW9LT+kfCQ5VTmt8ce38+s6EvyhgZeKWTH4dAnO6Mlv6Hzvr4fuk
         7Iv1REzp8Sw7xlHvHSu4COR1hjYWDwtQliqlAQNUDOVwrATv3PmHd52knT2thuLsACVV
         2MsdUts7o9E8btx1028IIjJczn3O/Q2jVfpAArDhPTLsgwzn5YtDoEprT9iAYyrdLfz8
         LFr701cNM1XoIjHpG7xCn+0KhXmGdUchOyg6Yt/7wU4ayFvccxSzr/8pjKSndjTsFrsl
         YE3hkDlIdGDoABw4Q2fTgDv7UTS4hioSs00ETm941IGhwlH8dNiYTcuZwvSDZu818IJW
         EH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvzl9H3xPJzLzHnnsDcqJvOeljahJanEEgDBqdLYdMQ=;
        b=hirdrEdM+hXlAQNIywfLF5OrZgLACB+t74lLczsELo2Ui76HCuZUeRZsCyu2LQbSBv
         IXwK3Q8ddSV+5kQhpVjV58PLFTzLdvV68SKDbHHCVI/QQ7tnsoTpdyTho7X6HP5TZsRm
         CRgFKicinfoJ9/7JYO6iNwByOjcI9R+duGxcp0EpoPY1F68NKnyWpyR7zWghff5QVLKv
         /d9S294EPLBNkOlQi+DG/QfxgNUL/XAQlMgPximyh9udXFCkk0ZalyHPZVn43nVYFL2l
         SncBeqkvL4RVyQWlkSwiHTZhJiOzbweRnR6cmahemCeTQvAdwuGweqkxBxNykJ6rSjEL
         VACA==
X-Gm-Message-State: APzg51DsMJ/S9b34d1KmOKuxfM2IRbEttTy6eTF51OXGX5B6dUk/a48X
        VfgEL2KRh62f2rcixBjYI1N8WUbWJgm2tJhwExeYZQ==
X-Google-Smtp-Source: ANB0VdanSSxDThj6e2ZYsSDSpJO2NzZA5E9dwXn0i6l1OkUL5YCIFIcGsKMnNRfTvoFDjR+8AfmVkfszkaQ1z3lATTw=
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr20055039wrp.59.1537199683131;
 Mon, 17 Sep 2018 08:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-4-git-send-email-atish.patra@wdc.com> <20180917143550.GC15588@infradead.org>
 <alpine.DEB.2.21.1809171638560.16580@nanos.tec.linutronix.de>
 <20180917150149.GA25348@infradead.org> <alpine.DEB.2.21.1809171703220.16580@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809171703220.16580@nanos.tec.linutronix.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Sep 2018 21:24:31 +0530
Message-ID: <CAAhSdy3NSNn=YicWdnyos87A7gDq0O1BMvQQ0FVmCtv+rBo=vg@mail.gmail.com>
Subject: Re: [RFC 3/3] RISC-V: Remove per cpu clocksource
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, robh@kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 8:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 17 Sep 2018, Christoph Hellwig wrote:
> > > Just for the record, this would be the first (architected) timer ever which
> > > just works. I'm having a hard time to believe this, but I'd certainly
> > > welcome it.
> >
> > And that would be the contact with reality.
>
> I've dealt with the reality of timers for a long time ....

I think the problem is we don't have separate DT node
for RISC-V timer. Instead, we have been probing timer
for each CPU DT node.

Ideally, we should have one DT node for RISC-V timer
and the DT should should also describe the local interrupts
to be used for RISC-V timer.

Regards,
Anup
