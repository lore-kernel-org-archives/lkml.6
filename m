Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997AC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B0A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="kN56Gi4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B0A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeJVUV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:21:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36840 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJVUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:21:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id l6-v6so206157pgp.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dWqYib6c7YCfkEeuiyUid02W5JbWuq8jXJrrJ2nv3tM=;
        b=kN56Gi4O7/FFa2Xc//BlTk+VZ0+ZxduRW9DN3Dd53WYr/HYBuvZ4EEavfu3eSh1or3
         vc1yIfpRosWXeT6rDEJwKWOcCXREstmPIHvN+A1eVBbik0fHkwqxx7KFXJbte3Bm6A7m
         3ikyCJcR6/yhpbX2a0/b9DQofhzvjSDb/7AuLxXk9tUCLunlnwoWdAqtrm5nEaIMU1sZ
         7Pnhehag+gPyq2f/E6D/ReMQ5H0FuhHFoL7FjKzfYjpBSfLFLZp5edp+0+rn3uR2WY9O
         +ZwluxBDBXvmTYkjb6OqSA1B54nFMV9gb7nD29phNvaY4XfV3SEp3jnWv9J+sIZDnUf6
         Lqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dWqYib6c7YCfkEeuiyUid02W5JbWuq8jXJrrJ2nv3tM=;
        b=fsNE9vG7/gD+Ww/1ark/jTw76uTYbibUSKMU+bbljjRnY3X9UVEzugrqCF07JAGQnp
         S/t3IFsW0UWP7WNMaee3TXr1zEOhf9zPy+Gl/9I8BoT345Az+oVCdXSHRrdEXJPyGlql
         oqh3N5Xa0ejUdYlnF2z4qHjYVrNf0WSFM8xPy+mKta9HX9k+tp5Seb50aWPIiPCbv/m4
         On8PSQBx0Luu3D4Q3BTRpuTPe7DejDRIw5axro40gM+VmIYYstoxh2lsGCMI6FNR9zr1
         /9Oo8+YXvmGcGoNkxhC6bL7albiMIx+kl3B3Lm4XGX0EE+6TDvpiYK/PgCdaFdpnFp8+
         B5fg==
X-Gm-Message-State: ABuFfog6dbcYBmw8ovXMntheNQi1YZEb3r5JNog86s4Nk5uLqecQBuU3
        idngeFceyKPVCV1t1YgnU+T0gQ==
X-Google-Smtp-Source: ACcGV63LjxoASoVU0N9GOjkHm3GIxpYGE+VrCNf3317VMFiXHXpyw88po3hVN1ovB/orTf4wqrA9aQ==
X-Received: by 2002:a63:584f:: with SMTP id i15-v6mr42745920pgm.178.1540209820537;
        Mon, 22 Oct 2018 05:03:40 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm55443405pfk.19.2018.10.22.05.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:03:39 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 0/4] IRQ affinity support in PLIC driver
Date:   Mon, 22 Oct 2018 17:15:13 +0530
Message-Id: <20181022114517.22748-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset primarily adds IRQ affinity support in PLIC driver and
other improvements.

The patchset gives mechanism for explicitly routing external interrupts to
particular CPUs using smp_affinity attribute of each Linux IRQs. Also, we
can now use IRQ balancer from kernel-space or user-space.

The patchset is tested on QEMU virt machine. It is based on Linux-4.19-rc2
and can be found at riscv_plic_irq_affinity_v1 branch of:
https://github.com/avpatel/linux.git

Anup Patel (4):
  irqchip: sifive-plic: Pre-compute context hart base and enable base
  irqchip: sifive-plic: More flexible plic_irq_toggle()
  irqchip: sifive-plic: Differentiate between PLIC handler and context
  irqchip: sifive-plic: Implement irq_set_affinity() for SMP host

 drivers/irqchip/irq-sifive-plic.c | 164 ++++++++++++++++++------------
 1 file changed, 99 insertions(+), 65 deletions(-)

-- 
2.17.1

