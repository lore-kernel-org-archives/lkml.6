Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E270C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190BA204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aQprcnoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190BA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeIMXru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:47:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26981 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeIMXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536863828; x=1568399828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DtzhQvMvxLSSEv9fq5kc/Y4PFD1IDH+eCGEVY+GherI=;
  b=aQprcnoZpNjypnm4pZdgulVyXM2Co3ktXvodYSxbdiEt8j5GOBusC2/M
   Fw9Qv9n2sXwVI3TOPfuhxvQbEOVYnsrXksTtGHRvmIou+/Dt8zjcS1U78
   xWGFushP5ttNoyajBz9LUfVYWtNrpPGs6orTnPPucIMdbjx9R5/9S08k1
   ENTm1ZLdkrmouwA0X/dQdvggT1xCU/Sc775xFsu3Y2ccoMlkUcXFWIT4r
   x9rh1xZz6hw7LOtXdg8F/YqFfNOto0bNWsjtePUPvvxVYVuegZMPqy1Xi
   RofykOOFYMzbuRpgxGE18jZEHvcve4a4zrJQS1omk/vZMTdcVxuofM4ri
   w==;
X-IronPort-AV: E=Sophos;i="5.53,370,1531756800"; 
   d="scan'208";a="89712015"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2018 02:37:08 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 Sep 2018 11:23:38 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2018 11:37:07 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org, schwab@linux-m68k.org
Subject: [PATCH v5 04/12] RISC-V: Comment on the TLB flush in smp_callin()
Date:   Thu, 13 Sep 2018 11:36:57 -0700
Message-Id: <1536863825-66808-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
References: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
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

