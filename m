Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60139C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2260C2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fP9zCSOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfASF1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:27:07 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40286 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfASF1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:27:06 -0500
Received: by mail-wm1-f49.google.com with SMTP id f188so6291446wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BQqAME/n96OaDRAvhqrmL+Q8yZyrA9mWoXMS5JE7pE=;
        b=fP9zCSOI58Il0IPLCGwoSGtvSya1dK7oL8gdVFU4k+p415AnygBCURviv37BBme5Xu
         CNWsikmffBocAkY298f4gm7QaEfVr10uNE5cMeLt+3fBjBHBGYS+9/mZ94+Yqp9F2bru
         L8Ym/yDXLJ3kLHiKBNM7Hrh2vHFmNEAWb10DmhPBsJQGRiFw8lfHERrpIqwLmwCEHmDo
         3aSmWY+mGMXPxX87cjvyXgG+sD3bF2d0aky7rNngPY2SZbH93SdTqHm3KBsJ5W1zqi6v
         RpSMr6BzQJL+dEzKHfF5EWOqfwbacHm0fr1e33D8uPyU9dxkrOPLjWAkutaYQ/jlSLp7
         2IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BQqAME/n96OaDRAvhqrmL+Q8yZyrA9mWoXMS5JE7pE=;
        b=HxFYdh6NSsdTUj8PLzhg48Nde8NO0vczY87yr6LrqLZEuRS73Pf9LVCBIAvtiA1FKS
         3b5ZhQzvbuxO2PNQDsOMYzh6FO4khfBjOvV9XHXeJJudJtwS5im9vEHHfaGu25V8d9i1
         pYfV+xnpnLyKZOmHelsLNqLB+mAk2TkRS40DnU/2mP8bsEkdrzJl6Oi3/vd3SyJT6FQJ
         lxaDnR++x2B0V0GNQdOSteQaFV9Jl7lS6wifQSjHhMROpWdy9wtABygqvCMuVuI/YevN
         R+geR2k2Kwzoth9Jkvswqz+WikkGXQX4209bNKOE2UiLxe6u4JEq5swiXpfatt7f4vox
         5swA==
X-Gm-Message-State: AJcUukfWJaQ6jU4QY/084xcwvbFhAqe7UZLOntNcH5xArpPO+DDe6hkg
        X9XbUZ2saA7Pw7qQUbhaJTbS9udRe3lS5AIieyw0xw==
X-Google-Smtp-Source: ALg8bN6HPCgf6Y92vYMKkS6v+Nl7Gq6Rxxcz7LLyiaVmaCS98mMzr238JY944RYvOiwSQc5gijwXBvzHPuUqVvBVsDc=
X-Received: by 2002:a1c:1801:: with SMTP id 1mr19018322wmy.153.1547875624887;
 Fri, 18 Jan 2019 21:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20181227111821.80908-1-anup@brainfault.org> <20181227111821.80908-6-anup@brainfault.org>
 <20190115155727.GD13095@infradead.org>
In-Reply-To: <20190115155727.GD13095@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 10:56:53 +0530
Message-ID: <CAAhSdy1JpFfxPmuLM_T_YVax9HD2oNbfwMAwttNYjZ+BSL4fuw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] irqchip: sifive-plic: Implement irq_set_affinity()
 for SMP host
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

On Tue, Jan 15, 2019 at 9:27 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     if (!force)
> > +             cpu = cpumask_any_and(mask_val, cpu_online_mask);
> > +     else
> > +             cpu = cpumask_first(mask_val);
>
> Any reason for the inverted test?

Okay, I will not use inverted test here.

>
> Otherwise this looks fine to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
Anup
