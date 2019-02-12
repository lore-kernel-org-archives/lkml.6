Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9758620811
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="RZzZVIKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfBLMFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:05:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:05:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so2660584wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcHEmmZgff9rH6vurQUWXdw/7vg+Ums9TMd+fjY7zHU=;
        b=RZzZVIKvpawTjPi44K80byEQQMIvdOQ/s4HtSUN7bf5Nkr4fr9LvJGkPedg7sk+oZi
         DYYSQas+4eAMFiT2JaqeJB+uBe15j3vnGHWW33g8ZKZ6GvwXlDEzlN+RtDIVjfCizsZu
         SMoBK+x2odVuxDOUyQUkKok+4f/sKhPhzckCYE3OQKd7Npaw0TKMrV7P6Uw3zuzp/30f
         BrTJ93MAHjO02e9Nm6Sg/IbZLRSABS+dcTX4xDIp8KDBoz20MTSmKUgGhYHlNXW1q4Jm
         VjMzE++bZ21M+v3xIjAXphVV3zQ+uVUYwNIn/SOq29b52gCP1wOtUbaQJ0PEWLpdgeho
         VEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcHEmmZgff9rH6vurQUWXdw/7vg+Ums9TMd+fjY7zHU=;
        b=dd08ICfxWIZD4K+bAGgmB1Z3inKNAiDhbJxnke8cb2MV7VW+Vv+jduitxyZGREow5D
         CIcl+M0aj2fC30yooyHenV4k76LGs05vzmKe5flvNryljTX17PGADMFE1l3wvKXe1Hml
         YwGi47o4hE7Gja9/4U02YlazOgChuaTvgy5JbVCMjbeEGXUk0edrls5qgl6HpsldK/iK
         r0oEJzodOkyUC6k/Z0jAByKxqPsXwztJiJuWCNsRBV2gXpG5wOq+M9yMgTEEUO72wM9O
         Yw3SACVJCBDrDiByeYRRyLTl+N+mqSFg1TGH4X9I4yp0HSpPHGsdfz/9ClKXGhVsGjRn
         QT5g==
X-Gm-Message-State: AHQUAubpFiEZObpTEPMdV3g1oq39pqEF3AReEvs8jiafnzVqycuYklKs
        7ZBKV8bQNSVm0S4Y/ppjalgQvXwh1H668+lKNkjGqg==
X-Google-Smtp-Source: AHgI3IbqfVuyPXUNL0LIGcN9Tr6PTyAPqGgDXffCCuQk2u1Nkc7xW05tzQoBHALyJZbbqXV8Searpd9tXKf6TBpW06I=
X-Received: by 2002:a1c:48f:: with SMTP id 137mr1892636wme.21.1549973144409;
 Tue, 12 Feb 2019 04:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20190119055625.100054-1-anup@brainfault.org> <20190119055625.100054-3-anup@brainfault.org>
 <20190212070925.GE26747@infradead.org>
In-Reply-To: <20190212070925.GE26747@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Feb 2019 17:35:32 +0530
Message-ID: <CAAhSdy310ninVL5PLHhqbv0-WSj9npjMzauQTiRvE-E==XT=Rg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] irqchip: sifive-plic: Don't inline plic_toggle()
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

On Tue, Feb 12, 2019 at 12:39 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 19, 2019 at 11:26:22AM +0530, Anup Patel wrote:
> > The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
> > for loop so both these functions are not suitable for being inline
> > hence this patch removes the inline keyword.
>
> I still very much disagree.  Very strongly with the above rationale,
> but also (less strongly) with the decision not to inline here.

No issues. I will drop this patch since you "very much disagree".

Regards,
Anup
