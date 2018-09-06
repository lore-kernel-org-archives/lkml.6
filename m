Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A692075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k+BKrsir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A692075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeIFMkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:40:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53554 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIFMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221195; x=1567757195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rn22RKN5Vd3GpklO+NDM1Y4QajHeBOsCO+uMXUM357s=;
  b=k+BKrsirkPvk9hObUvaQ5VRMiMosjldNN0VzLXE1hEynC4dSoV4NyeWJ
   gE5Rvtp/0Bf0nh0xvne/gFwuRw6UEXxHqeXcK0ONg0ENCCWObq0p0OQbX
   UvnQiC4eCaEFxwTxdmFyfIpJ3wEqOtrFvRUSdr8Q59kQySbCcDIUVmXRL
   CNjWDzPKiy2KFYD1fjTEy1Q1ogAupW4SH6628jAWorQxGtCZBfhRpw8jS
   Fg7W/AAiwoNNk+9fgD+WEKMwk/cnpETDIEJrD9ZSi/rYc9cqwMLqUGzBG
   uZ4ToLicWHrVwIoEsaVNpO0dNS/grobMum4SMtdOeN6Gjc9rB4LWJQOIt
   A==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673955"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:35 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:13 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 07/12] RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
Date:   Thu,  6 Sep 2018 01:05:30 -0700
Message-Id: <1536221135-182613-8-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

The old name was a bit odd.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index cfb0b02d..4a232600 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -50,7 +50,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 void __init setup_smp(void)
 {
 	struct device_node *dn = NULL;
-	int hart, im_okay_therefore_i_am = 0;
+	int hart;
+	bool found_boot_cpu = false;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hartid(dn);
@@ -58,13 +59,13 @@ void __init setup_smp(void)
 			set_cpu_possible(hart, true);
 			set_cpu_present(hart, true);
 			if (hart == smp_processor_id()) {
-				BUG_ON(im_okay_therefore_i_am);
-				im_okay_therefore_i_am = 1;
+				BUG_ON(found_boot_cpu);
+				found_boot_cpu = true;
 			}
 		}
 	}
 
-	BUG_ON(!im_okay_therefore_i_am);
+	BUG_ON(!found_boot_cpu);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.7.4

