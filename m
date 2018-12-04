Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C062087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="WSU1xHpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C062087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLDKpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:45:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:45:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so7187854pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4avgKxJ7er1mkSgLv64vmGkmY63IGVLkeRJB+3yExU=;
        b=WSU1xHpUmzmizOSvpN72KaeN2XZ8/7U+r8fWZAv3osZYg0oBPm9JBHzmo865sFHHo3
         et6IlRcweK8Qru2TFutmmYeKd23IYfmk/lzVby6S1N4dBuK/XSwD84KF9Ui9UWxsagvU
         TVWTDHSmXv3NrUqvFOpV88V8o0rB6pRbLUDkGFI2d/FsNc9zh/tDfPfUXuI3NINHjbEu
         /HjjGJppSP6tA7zhwI0aHXUAQ6mfP4oX+D91BuH+BlkVccu8x/86dz4wDMR2aISYciDp
         VBtghfj32yA9LTdBgGoIAfvS8egJFJLup65dRMx2ZcGBfIl2wmy07VI5GRMtsVfRvi7v
         g6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4avgKxJ7er1mkSgLv64vmGkmY63IGVLkeRJB+3yExU=;
        b=qixwCrhWjqbzBo52WIsKX0U/MqLOfVe0M7y47QjjxjMqxqgf2D1pKkK6qy7eNAkIwW
         VpWYOMBzDyjZ0bvv9JyXw9wnv0f/PVpYKbgBLu06h7R0NYlG13wDSnpdkC38EaPpH6Vg
         8k7Y+1JB89D6g88/nVgUL4vu6+1qxO1tkNZpJwE8kC9ZekC4/19GW9RZjIObqiHWZRhk
         QcqforGzrQDxbfH9pVybp+fVzKkJQlxIUDVFjtPJDLzPmIrfnhWyaLlYNPbvdyM/2kII
         IeS4UxlG+Gis9zgr6DWKmGL8J69uDsMKimW1n6g2miJdzVQm3/jAgVNK+RGotevVfR3O
         B2iw==
X-Gm-Message-State: AA+aEWZRGARj+p/f6Ug7QWCIchbrtf6WE0xin4dLs4n+3yReUfWEdmo7
        NJQrBT8L7s2p8mCu+E6heRhAvnH+UZ4=
X-Google-Smtp-Source: AFSGD/Wtvji/X00CS395VNSz+1FZ95aC6LHfk23e/UOH/alPQ3I8LuRRnct+LM9YFxLP4/syqguAEA==
X-Received: by 2002:a63:cd17:: with SMTP id i23mr16162337pgg.13.1543920340951;
        Tue, 04 Dec 2018 02:45:40 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.23.39])
        by smtp.googlemail.com with ESMTPSA id s37sm19034734pgm.19.2018.12.04.02.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:45:40 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 1/2] RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
Date:   Tue,  4 Dec 2018 15:59:51 +0530
Message-Id: <20181204102952.21297-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204102952.21297-1-anup@brainfault.org>
References: <20181204102952.21297-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The riscv_timer driver can provide sched_clock using "rdtime"
instruction but to achieve this we require generic sched_clock
framework hence this patch selects GENERIC_SCHED_CLOCK for RISCV.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f4e818..09a0f2582cad 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -24,6 +24,7 @@ config RISCV
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
-- 
2.17.1

