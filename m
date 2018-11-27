Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE18C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09A2208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Mi2u6F64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09A2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeK0VAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:00:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbeK0VAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:00:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so7620853pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zQclvUuAWO43QDDHbS+I1HAFxUvaKASGir9+ioQf6KA=;
        b=Mi2u6F646NSMHZe4zbEJMAL46YhGacWYD+Vmg9zVt8AzLl/c/UvEXpYR94FzTGURIy
         NgtYyzXIi/oW77XavD2uVdBHd7y4IIyM8ak4/O1hFwuWDm9KXgwqMyrzZiY1pyoIhst3
         zjC2oxM8rrvhSURijGROXYT09YXqx1LWqCiMp85bAcr2dLV5XTZDMCI5b3YNf4uCXlrH
         48mDmYuRpCmMafK/ezRG8zt8xjjLwEVKQMLhJqO39ypJzjTVpjOe1cxGkFy76LFOMps7
         fp+Sw44j/89CW0g7xeWqAUFMQd2N4+kaRFz5B+hfvP+JD8YMKQJzXb9R29oV9/3krRiN
         /rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zQclvUuAWO43QDDHbS+I1HAFxUvaKASGir9+ioQf6KA=;
        b=a/LrUvitlk3APi5vMWb6DL4QAYcP2JZUQswv3AUkwY8Xo83b23e+PbbnglrHNPkF7A
         LqxgNV+EZpOOKpDBRHmWcYaVcnvc/Uvdc/SFZRN8eqc2yCfJa4glI67RpfPBanWVyEAc
         1b/bhuQMGPozKlm/qcUvdVJ72Hb+Va90Ram3X17jBCsODrMmKb4VG7X6WeDONc5YZFl+
         4LW6/+9H30ZM75FaI8Rl27ObV3FCjBSBZaymc71KapvQw9F57ll/JVZsFKMsy8whcwT+
         CNVH7ryBFsaV4f57Ei9tcKf/ocAriq3iWqnXx3m9FuJ9RrMS/KbLRPwRITgIxQKHYTDO
         CNfw==
X-Gm-Message-State: AA+aEWbltK1FJMMlfVDhRtBUFLDLwMtC+MiboBklmvgrvcnNnKiZxdoi
        OJ83klP86TBWa27pUzy4Z353ag==
X-Google-Smtp-Source: AFSGD/UERRYpH/8nayEUL1RNFfaJHjAtC/dEpPIxVOt71LLPD8IdBLStMU3s4oP7fqTjAlOWfaUPeg==
X-Received: by 2002:a63:e19:: with SMTP id d25mr28523025pgl.272.1543313009752;
        Tue, 27 Nov 2018 02:03:29 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.48.241])
        by smtp.googlemail.com with ESMTPSA id t87sm9519590pfk.122.2018.11.27.02.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:03:29 -0800 (PST)
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
Subject: [PATCH v2 0/4] IRQ affinity support in PLIC driver
Date:   Tue, 27 Nov 2018 15:33:13 +0530
Message-Id: <20181127100317.12809-1-anup@brainfault.org>
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

The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc4
and can be found at riscv_plic_irq_affinity_v2 branch of:
https://github.com/avpatel/linux.git

Changes since v1:
 - Removed few whitspace changes from PATCH1
 - Keep use of DEFINE_PER_CPU() as it is

Anup Patel (4):
  irqchip: sifive-plic: Pre-compute context hart base and enable base
  irqchip: sifive-plic: More flexible plic_irq_toggle()
  irqchip: sifive-plic: Differentiate between PLIC handler and context
  irqchip: sifive-plic: Implement irq_set_affinity() for SMP host

 drivers/irqchip/irq-sifive-plic.c | 144 ++++++++++++++++++------------
 1 file changed, 86 insertions(+), 58 deletions(-)

-- 
2.17.1

