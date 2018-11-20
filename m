Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0693C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDDA206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcKwMhPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDDA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeKTXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:20:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33559 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeKTXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:20:46 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so374181vka.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUxynNTNnhWdgYLwhy/R/Dz/u5lnYR+060N7MOQ7yVw=;
        b=vcKwMhPkimRdBULZj8EptFCg/ixgS7del/Zsw9eFg1bl8I8t/0BGa58VgRS9hO8uYP
         J+JR5xtK9EqKGsTS5ign0UDk525lx3FV/N+MMODuR7QZ+8J1njVfUSa1cH8lfk/2FX+1
         BiZY6m7ZzNa/iH+6eJrBAqlJgfoRv5VfwUnrnY6GsW42EkE2EfTC2LT8JQiNaBDYBzev
         9wZdKZ3Oc0ji+JvWC6ioF+hX5+6oqXWqCQp/CewmbW96thEANUHMhM9S+5cTetjZR4j5
         W14sTFNHtsHDz9DyjSmDIN75YR2DnDU0aOdjkPAxktUrKYc7tFPfhENykza7v0uC5SsK
         zr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUxynNTNnhWdgYLwhy/R/Dz/u5lnYR+060N7MOQ7yVw=;
        b=AvGTjBOLb65mMtc/VrIVMfEeRNYWe9j3ZmWWNmtutxnSvtSo0kDDItD5IUzUb6I+zN
         z6RnJTLuTgbCt953ckwNDJZKU6DnNL4/FNblOL0BtI6qtULzSnTkzyRj2dfiDo6s+hdw
         PA/+7qu9n6Tb8uKRXoM0W5JnhJRAhqL62vMqqZGqpF03P1SbBdWD4iSV77r2EUD8ighu
         otAexHD3lwm8v0X7LJrht2xubrUai1PxlU+kt5VX0chSZ58BcRr/ynlr57ywJzTvcQqF
         VseD3dPH+TtVovbqPTKQxk7eiKCvyKIsU8uo4cTSBTFkjg0btyKF8NtRfqlWhM3EKWzs
         qRUw==
X-Gm-Message-State: AA+aEWZzSmutVUktV24zAEMCG13nDug2AW/SglEuj+5HNWyajGenhuwO
        QgYS2e1Y6ct0HbYaISbbzvVpIWTPo4Ym4nn3K0k=
X-Google-Smtp-Source: AFSGD/UG3/sgga3CU4ehVZDJtfkf7Lk03uuPK5SDzQlbw/QTJuUzeE2ztuQO9YrJFju18HFgQ1omtQNrBny9EnbFbR0=
X-Received: by 2002:a1f:f0d:: with SMTP id 13mr752612vkp.21.1542718305445;
 Tue, 20 Nov 2018 04:51:45 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu> <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu> <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
 <15703.1542393111@turing-police.cc.vt.edu> <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
In-Reply-To: <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 20 Nov 2018 18:21:33 +0530
Message-ID: <CAOuPNLgGuomqaQVtj=1O8tYV_Bq8cqf5HqCxJ-LSGeQOVffnzw@mail.gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 6:36 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 12:02 AM <valdis.kletnieks@vt.edu> wrote:
> >
> > > But my concern is that if I dump it from irq handler, I will get
> > > information only for the current cpu.
> > > How do I store and get the information for all the cpu from the boot time ?
> >
> > Make the high-water mark a per-cpu variable.
> >
> > > From where do I call my dump_irq_stack_info() [some where during the
> > > entry/exit part of the irq handler], so that I could dump information
> > > for all the handler at boot time itself ?
> >
> > No, you don't do a dump-stack during entry/exit.  You just maintain a high-water
> > value in the exit,
>
> Which is the right place to keep track of this
> high-water-irq-stack-usage (per_cpu)
> in arch/arm64/* ?
>

I tried to create a per-cpu irq_stack_usage variable like this in :
arch/arm64/include/asm/hardirq.h
+DECLARE_PER_CPU(unsigned int, irq_stack_usage);

But, I could not figure out, from where to fill these variable for irq
stack usage.
+ sp = current_stack_pointer;
+ if (on_irq_stack(sp, cpu)) {
+         stack_start = (unsigned long)per_cpu(irq_stack, cpu);
+         last_usage = per_cpu(irq_stack_usage, cpu);
+         curr_usage = sp - stack_start;
+         pr_info("cpu:%d : sp: %lu, stack_start: %lu, usage: %lu\n",
cpu, sp, stack_start, (sp - stack_start));
+         if (curr_usage > last_usage)
+                 per_cpu(irq_stack_usage, cpu) = curr_usage;
+ }

Which is the best place to invoke this ?
I have the following option:
1. kernel/softirq.c => __do_softirq()
2. arch/arm64/kernel/smp.c => handle_IPI()
3. kernel/softirq.c => irq_exit()
4. ???

Please let me know.

Thank You!
Pintu
