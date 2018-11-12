Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F202243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Cp1nenxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F202243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeKLW00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:26:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42988 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKLW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:26:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id u5-v6so3868422wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxm/KaMXvT8Da/hEWc3PaitzyuswF/hYKIpA34uqooE=;
        b=Cp1nenxME6xAc86TcP0Ddsvc6qVwB3bUNOthi8wCCVeYxFnKnCT6TCot0OmCS6ga9y
         g9AjJYafC+0+649fzZEyukSbuD2H5F2oK3URWz+TcUkZVwgI52R7VjuMbWfclIAAFex0
         zKwr4HpWnSuGkUpLnlCrkfMcS+qPkUoZCRwcRgnobUcPvoxXnYjkPBK6H/5SV4A8+B3P
         /9fZxMDXOy17Dx5ub9ZUy1PYWsjbM9N0f8ipqsmljk9mu0xuHtKGPYNAnFSvcUC4cgcP
         FOL5FCsLSBGZAqb+Y/YPBuOHDAINIgiSagmvfqI6x8Rx8CD39qJDzjEdVY3GpirX7/Jd
         P4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxm/KaMXvT8Da/hEWc3PaitzyuswF/hYKIpA34uqooE=;
        b=TIJ6q4BDxpSrs8H15fEQYW5DJsBUhjEL+Vc5Jwd+KQnbHwTXQ6nJzF51b7HyXdu/XI
         HdILc9MUNPeYxKehpV/rExvVeOmsa6ulPj4ktXmlAZJcwz54VdXVpXWWLO+RkZY2rxke
         5QFCrksZ8Yve+DyXBFqsZzhBnI0udi0DcN+khXy08mgX3v079rI4Z1nU6xuiA/piKFsW
         LWCD4dzkDG9EtFx32pDbHx9TzGfSlL7LxKvn1vLB0xnzJ6Nsm8bFhFjBVOew2NqWlhDT
         sOuQ2smZORFZtffnPNSrmlELmHMMbwUyVCNwGciG77y2pkOu0757IsTy/lJ2PtF/I/tH
         xb3w==
X-Gm-Message-State: AGRZ1gJC/OH/1iDOFYHyG+2ZhUFcxZ5vESW7UH3I9sriOuEBcMpva2BG
        0UcqxN0isGt6SPACAkBO87PrUdGfvxbClUHRm14u1A==
X-Google-Smtp-Source: AJdET5c1wbXO6MMpWlHs2uETqeWeZ4GWdiQizqlVptUahZhmV2sKT0/ZR98T59mRCBsHBQCTd6lo0MK2WFgptClgPz8=
X-Received: by 2002:a5d:5544:: with SMTP id g4-v6mr812975wrw.222.1542025998895;
 Mon, 12 Nov 2018 04:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20181022114517.22748-1-anup@brainfault.org> <20181022114517.22748-3-anup@brainfault.org>
 <20181109084338.GB6508@infradead.org>
In-Reply-To: <20181109084338.GB6508@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 12 Nov 2018 18:03:09 +0530
Message-ID: <CAAhSdy20zU=GeaePQfYW_FKH-wmsYgvK3-6ouc3S8QpwWH-Z+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] irqchip: sifive-plic: More flexible plic_irq_toggle()
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

On Fri, Nov 9, 2018 at 2:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > -
> >  struct plic_handler {
> >       bool                    present;
> > -     int                     ctxid;
> >       void __iomem            *hart_base;
> >       raw_spinlock_t          enable_lock;
> >       void __iomem            *enable_base;
> >  };
> > -static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>
> This does not match the changelog at all.

My bad. I should have put this change into separate patch.

I will refactor this patch.

Regards,
Anup
