Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EF520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="NSUXMlGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EF520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIDRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:12:04 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43112 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIDRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:12:03 -0400
Received: by mail-pg1-f180.google.com with SMTP id v66-v6so1609017pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qWv9HBA5XbAn8mDa+MpkoRnffkwcjqF2WNP4Ot7qfZ4=;
        b=NSUXMlGM1XGzRmiPPXGaOajzBR3VhRYeLY9V0qx0/9B7EKvwK2X9C6SoPkrrbhlGoe
         IzdeewB2eGZ+7/JBDq/xBsMJ3ZH249ZMwMnWxl7/8PdTznfmw1zJasqVguJfHKEwFIxb
         z454Fwa6EyhzdTabCr15z2ZRE31VpBurYEjEKjp+LwLhlPuJOwIq/dZzsWWZJqUy6Ehn
         YuKUK0HpwBBV0uN5ZuQR3cGgAXgyH9/hnmgTsMbustFbWJXkoo1gF9iVB/TGTNHz/MxO
         cuTieBK/016twC5Lyna98oNPV1yPYFRrvusX0Cc1qHanN/qXx7xOXWMg6Gpe5B8BbdE6
         fNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qWv9HBA5XbAn8mDa+MpkoRnffkwcjqF2WNP4Ot7qfZ4=;
        b=KsMKsfWayHNYx+VZ6NazKbZnloj5xFuO0e8navbhIMF+i+/T5xXIBDGgdpWe+pLR9+
         4zg0Mf8LYeybog2Jrsyx09VeDaY++lO6TxUqauhtRajxOBFR4AqArAOUcuZctOhyYZuy
         eAf/w1EPHl3cCWO/cLTBEHbeI5AwumiqEINPPVc+3OOEdnBy4iFkUMAn25L7vkqR1e6p
         xupe/9337bVukSATcqkzyClZzfVotQjJK5NoL1ei0LUkxoVjOlaxppuRM8dd2b5XutAQ
         KGcydomBbmeAxvwT/U7NWwRsG4OIhzmeIAnljnLtHTQrEzSXeQeEadTfMMZwq/e2Mx+i
         xJEw==
X-Gm-Message-State: APzg51BLk/OPMYCKvU/zlwJe4zXYRgDGs2q9lC7OJRW5X2tzL9yGmUkt
        kygAUVSy/zwhA09I4eevAjEz0Q==
X-Google-Smtp-Source: ANB0VdY1fy8KENoHMgSCSPdoH75O0bZMINVUkJGs0KEVlnB5YH3UrckOtEBm4nVJNUbj4pdE8zMV3w==
X-Received: by 2002:a62:1fdd:: with SMTP id l90-v6mr34063682pfj.121.1536065224083;
        Tue, 04 Sep 2018 05:47:04 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:47:03 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] RISC-V: Select useful GENERIC_IRQ kconfig options
Date:   Tue,  4 Sep 2018 18:15:12 +0530
Message-Id: <20180904124514.6290-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904124514.6290-1-anup@brainfault.org>
References: <20180904124514.6290-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects following GENERIC_IRQ kconfig options:
GENERIC_IRQ_MULTI_HANDLER
GENERIC_IRQ_PROBE
GENERIC_IRQ_SHOW_LEVEL
HANDLE_DOMAIN_IRQ

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980287a5..026abe3d6cb0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -22,7 +22,10 @@ config RISCV
 	select DMA_DIRECT_OPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
+	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
@@ -33,6 +36,7 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_PERF_EVENTS
+	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select NO_BOOTMEM
 	select RISCV_ISA_A if SMP
-- 
2.17.1

