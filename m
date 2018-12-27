Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB587C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E6214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="v4sUq0s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbeL0LSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:18:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38299 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeL0LSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:18:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so8672796plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=djb8MENL/623mqGLQLtq4KrCkJHOJsxRY0UHXKe8Sak=;
        b=v4sUq0s12CeTvwimAYl9h4YlypmX5EU2jDU3hkfGx/2cPtHtnt2IuAgStbbF0JOBE/
         lsbH6bc2mtlEZVVv2z8oWiKrXzeC+dqGF+94/tPACwz91yuCJvfm9S7xV1kK9pNUt9Pm
         kTOWxWNBSGlkNE+9C8rK5weVpd0OVF07XqTiJfXoW1ACOdmR1dBbM5lU3JcHQLMd0t/b
         L14xHBTfHopOAOJNaYl0fS8+7ovSbnOI7NXBI4v5rM8g/0yAlLAxbltgn1rYcu7yb50J
         FpqsarJX0zsPSMXlxsOZXBzIB6fdvs/cmiuRya0NobPMj+UW8vmr/PkBIgNNYO5iigxx
         kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=djb8MENL/623mqGLQLtq4KrCkJHOJsxRY0UHXKe8Sak=;
        b=aCLOjNJescxPCeiQlk1N6T2caDkx6QU4qkRVJSM/q/f2MV5pwb+hZj+gi1zs1JoN2M
         68ozCWi2rMZlbFMqo8t2fd4aU8H+vQHWGjzgU468CIOXWP17N+ILTWWkwoU3xaxmZ8bH
         BIJSOSPD8NoBcaIqHBRFnUnveHNDdBXNfuYH6SBkkGjxMOZ15foI+2dMgDuIWnk6y3HE
         7U4Jq2tEhCl4GTnKaIrRBYP8o1m7aJSs2ZLsYih7S7lNp6aklQ7+omN28bUnxDcYO/K0
         uXFitIFHOcS/gaXRJq8BawdNuQnFk2m6Gt8ftUc5eETFIINBxmDExC06d43WcJ5CSRme
         Yfhw==
X-Gm-Message-State: AJcUukfXqUl1tigdhH5XfsfawHc6IoHo/UK6T6i4rOUw463EIALKlLvc
        7FfxUaQnJ0P2axxIGcGzD6goPg==
X-Google-Smtp-Source: ALg8bN6sSH2nHZighgs8yjW+ZKAodEkWhcq8w0DJiA41vf103STRAl+YMj+ZhYXXjeNvS+DJ/UJhSg==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr23084934pll.187.1545909514921;
        Thu, 27 Dec 2018 03:18:34 -0800 (PST)
Received: from localhost.localdomain ([106.51.18.57])
        by smtp.gmail.com with ESMTPSA id u137sm66830105pfc.140.2018.12.27.03.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 03:18:34 -0800 (PST)
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
Subject: [PATCH v4 0/5] IRQ affinity support in PLIC driver
Date:   Thu, 27 Dec 2018 16:48:16 +0530
Message-Id: <20181227111821.80908-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset primarily adds IRQ affinity support in PLIC driver and
other improvements.

It gives mechanism for explicitly route external interrupts to particular
CPUs using smp_affinity attribute of each Linux IRQs. Also, we can now
use IRQ balancer from kernel-space or user-space.

The patchset is tested on QEMU virt machine. It is based on Linux-4.20
and can be found at riscv_plic_irq_affinity_v4 branch of:
https://github.com/avpatel/linux.git

Changes since v3:
 - Dropped PATCH2
 - Added PATCH to not inline plic_toggle() and plic_irq_toggle()
 - Moved PATCH3 changes to PATCH6
 - Used WARN_ON_ONCE() instead of WARN_ON() in PATCH5

Changes since v2:
 - Fixed incorrect address of enable registers using sizeof(u32) in PATCH1
 - Retained comment about need for locking in PATCH1
 - Split PATCH2 into two patches
 - Split PATCH3 into two patches
 - Minor fix in commit description of PATCH4

Changes since v1:
 - Removed few whitspace changes from PATCH1
 - Keep use of DEFINE_PER_CPU() as it is

Anup Patel (5):
  irqchip: sifive-plic: Pre-compute context hart base and enable base
  irqchip: sifive-plic: Don't inline plic_toggle() and plic_irq_toggle()
  irqchip: sifive-plic: Add warning in plic_init() if handler already
    present
  irqchip: sifive-plic: Differentiate between PLIC handler and context
  irqchip: sifive-plic: Implement irq_set_affinity() for SMP host

 drivers/irqchip/irq-sifive-plic.c | 110 +++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 39 deletions(-)

-- 
2.17.1

