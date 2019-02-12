Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YTfimmhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfBLMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:53:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBLMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:53:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1264286plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gudcleFdCAiHH9g+9VtM4J6qJ0j7S0V6CHy56B+EYRc=;
        b=YTfimmhx4jpOCAbeeaUifO8WlUnRge+kE9030Pf7O/nvyg5BAPn51eeBPxdrAgNYK2
         FSJk//xJeKoU6MIR5qhswHQVXA+e3ZAUVllnh4FQHjNiaBpyRKo2nLPXXkKHeJBaT2CD
         yS6MoM2d2bnzC0F0ZWWJ14sDbEfIMiBSG5cBhw9MG6XaT+HyYcGFpH+IwxSVMZ3gkcAh
         z0lWnjWnHwfQuV8+sEAfcrNcw8UHIXGbp0HjHheKuMLUXHXtnn2X4kmqliuN42bLKfyC
         lnT8KdIKIhiTiQmDD+B0KGgOzpnQeLqnCvSG1fGN+Bt+AHbAhwQEOT3tm+XFqjzDL/tb
         PQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gudcleFdCAiHH9g+9VtM4J6qJ0j7S0V6CHy56B+EYRc=;
        b=Lp+cJxlKn2lGQf0o0SOk2cSrrBS8yzjj/Dx0qkVSMhxUXW9Ag/ldFMNbv1SRm4e79k
         bYtaawVzgDM965u3b11VNh5j60hZP8UYmpoIKpt8JXP4L00TrE/Lfghfm5yaYtSca9Af
         ZYnYvVcs2QSvz/QZhYcvi0LEYBadYHr7Jojb2viY6tybIYcLvXD5iHAIpEHYxgSlFGN+
         MpcnBSFgqq0QfoYzVhtnGmWW1SXwgFzduWijCzWXN6/H+hV0nVCiGVhMm9okgqPnx2f+
         dQ4FGvQGGeAjh8E7zMhrzXkEEGfeOOaOtMDrwUdRSJN/CMVPjiYD8zeGFm4wEAXfA1v2
         3a/Q==
X-Gm-Message-State: AHQUAuZtnIBRG90Pj9vZ2/lvOcFNuNRE8gvGEekRbUc18hSaiNGLukGg
        yZW46H89Td3P13JykvxZBvSUgA==
X-Google-Smtp-Source: AHgI3IZsso0hWlaIOFVRBJoXBZvqmsEO+YefkciCgmtmkZ0+j6xKZih3/WqHfAJXN9AWAYiRWGvPSA==
X-Received: by 2002:a17:902:be10:: with SMTP id r16mr3915636pls.304.1549975979427;
        Tue, 12 Feb 2019 04:52:59 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.205])
        by smtp.gmail.com with ESMTPSA id z67sm27894828pfd.188.2019.02.12.04.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:52:58 -0800 (PST)
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
Subject: [PATCH v6 0/4] IRQ affinity support in PLIC driver
Date:   Tue, 12 Feb 2019 18:22:42 +0530
Message-Id: <20190212125246.69239-1-anup@brainfault.org>
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

The patchset is tested on QEMU virt machine. It is based on Linux-5.0-rc6
and can be found at riscv_plic_irq_affinity_v6 branch of:
https://github.com/avpatel/linux.git

Changes since v5:
 - Dropped PATCH2 based on discussion with Christoph

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

Anup Patel (4):
  irqchip: sifive-plic: Pre-compute context hart base and enable base
  irqchip: sifive-plic: Add warning in plic_init() if handler already
    present
  irqchip: sifive-plic: Differentiate between PLIC handler and context
  irqchip: sifive-plic: Implement irq_set_affinity() for SMP host

 drivers/irqchip/irq-sifive-plic.c | 111 +++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 39 deletions(-)

-- 
2.17.1

