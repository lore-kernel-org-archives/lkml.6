Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B55820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B55820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKJDJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:09:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40816 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:09:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so2712344wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYGqs1VkAAmOXim62cmhAUgSmzpI1bqQVQVUbS41Vv8=;
        b=D45Or2aL1Bb1rQktiXIE4wpNeLJCjerv6K5Ja7JGL8tlP0niKi09RusmDu/tdxh95Z
         YcsIcKS/4EmaU9ttHbkbxWOMADfJKAQwnifAvaztq3nLhHdyOMxeyY/BIcaG71LyqLEg
         WaYG5avB6vUrhKnrtlQnpWdNR1IST+HWbE8zX7NQvWMZ5AmQH6foj2MU0TNQqpZ5EEiZ
         j64n2q55SfcQ9Xy0apC0B1sBUZ3wnKFsxpNDaGKOeI6HWh80uY/KQKRwoeRApAsyAISU
         enwo/GIPp9Tk6TWpC1Ili4kR5i9oWXRBsSFsk2zOXtRpGRwOvWQF7563Sm7V1EVByTny
         Xdrw==
X-Gm-Message-State: AGRZ1gKdOsyUrAkDb2oMWX+xK9/58ZH/pvGQgr3m2939PjFSEpZRBETi
        gfufFifjrx7FLs/lkXeqIr1A9Xa8p6rK0qW6Gt6xmkzd
X-Google-Smtp-Source: AJdET5dFic2bHAz2TScqkqQ4plcjZEKZ5PBj4ZeEMukXjTvE3xKMhFEW0zbyVD1IVJTiJxouT3QMOFpySMMNoS+cAm4=
X-Received: by 2002:adf:ff4e:: with SMTP id u14-v6mr8877714wrs.232.1541784495493;
 Fri, 09 Nov 2018 09:28:15 -0800 (PST)
MIME-Version: 1.0
References: <1541710771.12945.7.camel@gmx.us> <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com> <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
 <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com> <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
 <930d61db-6e44-8501-983d-09cd3759d153@arm.com>
In-Reply-To: <930d61db-6e44-8501-983d-09cd3759d153@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 9 Nov 2018 17:28:04 +0000
Message-ID: <CAPKp9uY7DOV9xMhCQcAC8yh0z3-=2U-CmZq064Br=d4VYrcg=A@mail.gmail.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     cai@gmx.us, open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, Jason Cooper <jason@lakedaemon.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:10 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
[...]

>
> See bb42ca474010 and d003d029cea8 for details.
>
> Now, activating this workaround leads to lockdep being really angry,
> most likely because the cpus_read_lock is not taken, which is a change
> in behaviour...
>
> I'm trying to dig into this now.
>

Yes we found similar issue in kernel/sched/core.c sched_init_smp
There's a fix with detailed description in -next
(Commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")

The behaviour changed since  commit cb538267ea1e ("jump_label/lockdep:
Assert we hold the hotplug lock for _cpuslocked() operations")

--
Regards,
Sudeep
