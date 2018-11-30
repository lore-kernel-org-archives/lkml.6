Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4108C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70552082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lFKCRrZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70552082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeK3TKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:10:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35247 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK3TKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:10:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so2425317plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=INN3jsKRLwg8ZxL20lAb8hU6CDa49MS7o8/TtSx8NEw=;
        b=lFKCRrZU0ml5pSywxt3O2/vbWpbCYCSLT2N2K4GZCteoayWLUYR4miV6gs2jSF138F
         wtEB3MCh8iWfllnURakdBMmdjRoQ3vuoKs4dGA6bUWLYV77NTe937eUf2VeZ0yHXk6Ta
         Q0qE5Bxd7+1XrHj6wC5lA/Hzg2NCj3OJsn7wBY4uoThcjHvt90wPpgUIRLYkaJXJlRKF
         pWmx5Nd48xiNR1J1BFn/k2HAcY2JXRxBET1vsEpliLGMq+fSV9InOmRz7CLEDLil4/Wj
         ioWz1bjW6aWaQ1oEJrpTzVj+dLS84yPwuYAfqdzG25cHoPpWxkHgtpjHkpksO4RTWANG
         uqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=INN3jsKRLwg8ZxL20lAb8hU6CDa49MS7o8/TtSx8NEw=;
        b=ARcbYyDp2YuuwpORTIEXVcXUbKgE03z4/aXHiKPtQm02i+EDn7vLypJn/oxvjlaRbF
         vnFCYCNHltVyhjRTkbXffmBSboz29CPjv+Qo/QyrRLtZv/ct5GJqAO59Yan6bAh9viri
         1K9Nj9wX2M26ZyHZwxDzyi0f+NgViUSZmSaxIxaC2phqjN70i6+LAOEmNRO7CU8UvALj
         uBUj6M/jL1g/E3MQExZzwydx92bdtKw5Yse8R5GTXQ/f3TXM2FMxd6jk5iqpfEkcmt2i
         XRjj594e9MTUVVfvYgNvTCxv8VfaXd3caKSWUu5ftnQZSeIiH4wClgUDm5BnvrxmZ6FP
         eKzw==
X-Gm-Message-State: AA+aEWY/YMF6MnMz2w6ym6iltWHGPBYH1PHrCvCGBelNdiFi+zzi/sp0
        g3Pi9HmOpE5uCuwBWUYqCWHIBQ==
X-Google-Smtp-Source: AFSGD/Xv5ZCnP0BwNcJNz2N2KU9FXaJGaQVMlUyZFu0QfEFjelerL8044KOCfEXFtyNo9K/rXcpxNw==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr4598243plq.95.1543564934242;
        Fri, 30 Nov 2018 00:02:14 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.52.208])
        by smtp.googlemail.com with ESMTPSA id q187sm19218333pfq.128.2018.11.30.00.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:02:13 -0800 (PST)
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
Subject: [PATCH v3 0/6] IRQ affinity support in PLIC driver
Date:   Fri, 30 Nov 2018 13:32:01 +0530
Message-Id: <20181130080207.20505-1-anup@brainfault.org>
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
and can be found at riscv_plic_irq_affinity_v3 branch of:
https://github.com/avpatel/linux.git

Changes since v2:
 - Fixed incorrect address of enable registers using sizeof(u32) in PATCH1
 - Retained comment about need for locking in PATCH1
 - Split PATCH2 into two patches
 - Split PATCH3 into two patches
 - Minor fix in commit description of PATCH4

Changes since v1:
 - Removed few whitspace changes from PATCH1
 - Keep use of DEFINE_PER_CPU() as it is

Anup Patel (6):
  irqchip: sifive-plic: Pre-compute context hart base and enable base
  irqchip: sifive-plic: Add struct plic_hw for global PLIC HW details
  irqchip: sifive-plic: More flexible plic_irq_toggle()
  irqchip: sifive-plic: Add warning in plic_init() if handler already
    present
  irqchip: sifive-plic: Differentiate between PLIC handler and context
  irqchip: sifive-plic: Implement irq_set_affinity() for SMP host

 drivers/irqchip/irq-sifive-plic.c | 143 +++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 53 deletions(-)

-- 
2.17.1

