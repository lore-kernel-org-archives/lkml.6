Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9AAC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B225120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="q7rIC9fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B225120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeLCOwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:52:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeLCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:52:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5960432wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5guKpBWbU/3wU/cwZnd4lZpwA159/KCkTvnwEqfCpw=;
        b=q7rIC9fWyPq4UGXoAC8kim4IcMfIe7MjD2oFnYjdZLYAW6/7JcYN+rKIUxO0Pst2Sp
         xUr+ORGLQQFuuCPHlJ2OSWG0r/hgeThjsBKakNx/WJFRMvp8l36yZdcnRdbFBsL9cJiI
         c5SNMgxY4xBUV9rMhwB7R5OBor7kX6WavTv0bfZD2qjFyoqwi82y3tarpNjHnHQgs48e
         qf9Hhow6aciaY2knTUA9xTfKAl8GQt1+0jzON2EiJZvSBesInp4RLYNmInb3Nlqj8xoV
         xTXtbjHuhGB93ktbyZKGBk6Sug9fEoXsSrZ1+ZkoiuVGHNV5kIW/UC3F6W9htSYqOWQV
         xOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5guKpBWbU/3wU/cwZnd4lZpwA159/KCkTvnwEqfCpw=;
        b=Jz7PvF+uCh7L0Ge5hOsi2gpcgG8MlANLCXcSHyJYZtOnwWNCW9vGV37v6NGlOilp/d
         hus+QIvoXhtn5aU6g/2a3zOAR3sd770KxXEPJS6eIiMvYV/p7dXQQeSjnKo3vbPl2qjL
         Fx4ZV/bV5wCpIHTjoVfWSdam3HKh10CyQHVllYH8VfRuFHdV8Dee37KV4pTjBLeGMbvs
         v5v9kJM5yaB9ImEHrWG530jia8xpyXTMcRT1r0sw3VlqDbqJGMPIiWMyIzL6h5CxY2/f
         S24FZC4lkLpkvLnpVTCqzNf85NIqAby4qo5Xnyk2/tG49wtqnvdyScS0htVoBXG3+EJU
         gbMg==
X-Gm-Message-State: AA+aEWbBEPn5wnkI4lRCC7uXHxBz/k+Z9rj0Bsp/u82gcv6iJsczn6ai
        G5MC9X5jp1TauOwwZjBAmO5kTiYNfrWIdnCdVlhN+pdp4Bk=
X-Google-Smtp-Source: AFSGD/VTN+6jjIdHaRf9CUm4wcPI2bUAePlk5q4ubpPOmmMe+XY2FVNu4+FqMJ8pGqpegO3tbMFimyhiEcRcaJinqRY=
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr14667wmg.132.1543848658991;
 Mon, 03 Dec 2018 06:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20181203123524.11778-1-anup@brainfault.org> <c970d873-9dbc-9f21-3380-89635d6f574a@linaro.org>
In-Reply-To: <c970d873-9dbc-9f21-3380-89635d6f574a@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 3 Dec 2018 20:20:47 +0530
Message-ID: <CAAhSdy2rw=4Uw8=MZtfHi_ML9ZBqeiJ2iv+tRmDnjQDh7yuUHg@mail.gmail.com>
Subject: Re: [PATCH] clocksource: riscv_timer: Provide sched_clock
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 03/12/2018 13:35, Anup Patel wrote:
> > Currently, we don't have a sched_clock registered for RISC-V systems.
> > This means Linux time keeping will use jiffies (running at HZ) as the
> > default sched_clock.
> >
> > To avoid this, we explicity provide sched_clock using RISC-V rdtime
> > instruction (similar to riscv_timer clocksource).
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
>
> Hi Anup,
>
> the GENERIC_SCHED_CLOCK dependency in the Kconfig is missing.

Sure, will do.

I also have another patch to select GENERIC_SCHED_CLOCK
for CONFIG_RISCV. Should I squash that patch with this patch??

Regards,
Anup
