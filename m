Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0DDC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Abbiyo33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfASF4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:56:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33765 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfASF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:56:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so7295033plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sQoivAFbNDy6muWIVQt/y3vdJRVoP20aiW8gxmhC/Eg=;
        b=Abbiyo336l24wipav+ZxwC19i158Qe2M89QOsU8cICHRf9im14FWdTdwzrJj2QRuUf
         qHAnUDQs1GWIM+kwV+l9Vu1QiSRImZJQMVTCYCUlk1/dfdJ5HlPJhZYlt/uyIRnfTxTc
         1mU3PmS31ZNgj1u3kUjCZ+ts/lSKt0P+3uNBYPaV/bKFIWfV36EM/SkwgZBPzbuxwJV3
         Y7UU0WBnlU3qEWJjCyUHx//1MPmCF+zVHAFOMZt3i5/hyPYWNmLEh0SJZCyC3a002GPi
         vGY8HTh9C4L+uLtZScU5gfnI7jb2Ix7fP2tz3s/IupOHnwy+QeCmWkx/Cshxub2DG0CI
         gGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sQoivAFbNDy6muWIVQt/y3vdJRVoP20aiW8gxmhC/Eg=;
        b=Z8/ymbkh20Zb2ZGREUBH/X/WpAsi8TNmByt7SqCG/ss4MOptKXQwUozWd5t05BwUCG
         xdWE4co/QesrPXEREilDfUAAvhJio8kD7pBFLmbe6w/gHAzZiRqWAG20Kk0KB5EtfiM6
         Xf6a9sagoliV4LdOuWFg3nxIL8heIQU75pdAdrKMfZDc44RqoorwOZoCVtrHf8/PBCYM
         BB2P/QseRmloMG3x1tDdG/gUJUZ9CrfuAB4AeVGGsc/gXE9ofXu9cBpboX6xEQV81VDQ
         bPTgmiajkmKmQUTUSxh9IeyOyc6iUYfhAns5JCbIU+/ZQ18JtAcgt9WmVRx9Z/1ZT0Ci
         pmkA==
X-Gm-Message-State: AJcUukeViF422Eyr7dpGWzXf81+0De5Jx+pCLL0S5yeyrQj2NCouz1wl
        9UgJNCa6ZRwSYG/eHojN1ktk1w==
X-Google-Smtp-Source: ALg8bN5r2zDbLwk1v1+PTbuS+mSZwcs2QRA2lm1fnlHMIbAP/DhbWNLuWfx1TZ3q9I21gjSKzYaRfg==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr22348699pld.152.1547877400048;
        Fri, 18 Jan 2019 21:56:40 -0800 (PST)
Received: from localhost.localdomain ([49.207.51.221])
        by smtp.gmail.com with ESMTPSA id c7sm9295535pfh.18.2019.01.18.21.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 21:56:39 -0800 (PST)
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
Subject: [PATCH v5 0/5] IRQ affinity support in PLIC driver
Date:   Sat, 19 Jan 2019 11:26:20 +0530
Message-Id: <20190119055625.100054-1-anup@brainfault.org>
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

Changes since v4:
 - Use "if (force)" instead of "if (!force)" in PATCH5

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

