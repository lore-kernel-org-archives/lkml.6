Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C811C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B9020666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DjbtAlQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B9020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJCCA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeJCCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507710; x=1570043710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DtzhQvMvxLSSEv9fq5kc/Y4PFD1IDH+eCGEVY+GherI=;
  b=DjbtAlQirnLUuRaEqPYsMdv8/hsRzJbKE+LttoUXitu7esJmtuK1/6LA
   OI3s7/FZ7q+htLHzfdX5G2PP/6waIeH9sCJLCcjq38ay5yCVwGQDYCg+D
   GU+sm1/+Mq3XGditIXmjoGbRHmt++MZBy1NOJ9LxSBS0X2sFmol1L5v5S
   TJ8VR2LzeroKXSIUa9JONK58QihvoGKdad8Z4GW5YDnwfZ3FD+8Ajj9HT
   2twoJA0GnU7vTlw7M7dtCb8oztHFz2AKZ1XBj78X9bs/BDLMpXxwQrTeh
   PNX2C0gkm2im0twun6jCCgPomEbehg1QrOOgJjmu2nrvEufCQPe/R6+Yg
   A==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076740"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:09 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:50 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 04/14] RISC-V: Comment on the TLB flush in smp_callin()
Date:   Tue,  2 Oct 2018 12:14:57 -0700
Message-Id: <1538507707-22299-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

This isn't readily apparent from reading the code.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
[Atish: code comment formatting update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/smpboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 56abab6a..712e9ca8 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -106,6 +106,10 @@ asmlinkage void __init smp_callin(void)
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
+	/*
+	 * Remote TLB flushes are ignored while the CPU is offline, so emit
+	 * a local TLB flush right now just in case.
+	 */
 	local_flush_tlb_all();
 	local_irq_enable();
 	preempt_disable();
-- 
2.7.4

