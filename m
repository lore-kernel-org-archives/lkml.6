Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3CC20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="HXaQnP5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3CC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLDKph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:45:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:45:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so8009956pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=lw9dv8XtfZcbn7EFOqB9w5nPQid5fHNBwj4EA4pjoCI=;
        b=HXaQnP5Qh3ow5wxkyC0HHl3isat0FQe6KyrGS3hp5h2rVEVJYqBMVZb+eW71IbAi5t
         sGsmiY+SZ3Ds+vahPolmRRuw1RgLLVJ9f7IaxGwwLbw7QvgFrm52CKZ68AXDrgwHQeA4
         WGM4uQ/U4qzoVi9AlR3ZTqvMkzP0Rca9D+nlgMtsc0/KVoLqkOcV4mVOuTJwsLzEuMZa
         aQRojEOx/lDmz9oz1qTULL9pJ04bRKMrNZfLWyFztfm/YZWvvTPZb3Ax0GCYG4O4/Jve
         tSgZmn5lDrwo8kYjH5fHbjtWM3drGHsigDFr271ZbnyYmMFAs9J+afBa77sLe41bPB9d
         TqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lw9dv8XtfZcbn7EFOqB9w5nPQid5fHNBwj4EA4pjoCI=;
        b=E92byhfPoZsiqbORTGjm1kAhR0zjUg0TMWj4IVbQuMq8LbsZtDYL11zjLFkNee7mUH
         deY7DnT0ZgD0SJET7oipIwuf+2cmymsa7yz40O7iu6Y48T7ag7tntX+7qjQZIxEfmh+i
         SegIM3oVcJzDU6fUUaErDmeGWaATxXjLAyRkQwzJvuydz5s4+3B98RB+DNxN2+bTMjS+
         azbHz5oyga7N3DGjj2YHYhdyBb1+Apyt4HSRm19uXPmGFWwa2wpxLUKoVoEO2jfJrGdg
         cvOPDwrmMTxHby8VHjmptv74WLaNeK/XsRSiXSgLuax6rqyRXK1qcts6PxQFF4eqsGc+
         SSiw==
X-Gm-Message-State: AA+aEWbRbT0mJOCYjtT9rfB9+hXJgy1xibC40bzeAAMLEnUk1GOGWzS7
        wpkP8G0WlokWvXl3656ylzsW5w==
X-Google-Smtp-Source: AFSGD/VWLw+81cALEKeJeVhuXT2s0lnov+7mGExOsyEKWPIIzXzan6QNeE3rORL7IIxprQguLCNdig==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr19345510pfg.98.1543920336142;
        Tue, 04 Dec 2018 02:45:36 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.23.39])
        by smtp.googlemail.com with ESMTPSA id s37sm19034734pgm.19.2018.12.04.02.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:45:35 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 0/2] Provide sched_clock for riscv_timer
Date:   Tue,  4 Dec 2018 15:59:50 +0530
Message-Id: <20181204102952.21297-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends riscv_timer to provide sched_clock using generic
sched_clock framework.

The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc5
and can be found at riscv_sched_clock_v2 branch of:
https://github.com/avpatel/linux.git

Changes since v1:
 - Added patch to select GENERIC_SCHED_CLOCK for RISC-V
 - Kconfig RISCV_TIMER depends on GENERIC_SCHED_CLOCK

Anup Patel (2):
  RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
  clocksource: riscv_timer: Provide sched_clock

 arch/riscv/Kconfig                | 1 +
 drivers/clocksource/Kconfig       | 2 +-
 drivers/clocksource/riscv_timer.c | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

