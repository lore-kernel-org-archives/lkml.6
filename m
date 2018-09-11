Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D8C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D4220645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gXhz7Ran"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D4220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeILBGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52888 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeILBGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696345; x=1568232345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0OZ3nt/EEsQssBD+UQWuWr8qJL45NeYy9tco1TnCX6Y=;
  b=gXhz7RanQn4r4a6e0XBr6C3YmrTBo0fJK97BrerQCHP4TS1UkyCd1IN8
   WGppNcfDMIAXapb3+i96BzPYzeMFdQehHf5uLjoIiUeauGtzI1OZpFBFx
   HxBFvsv459ujUktiYQaEBEEKawE/3AHoNMIEKp4RuSDfHP3BmRv+h2d9c
   84Qc0j5XzrmALoWJD3aOhtddZRAzWd7VTuKck2OIZEUn9egJs8bhsMOqz
   Tcg7oSCmuOqec5MIiNNzGJU+k26KRwmmmZKuGguLOn4u13nkMgPf7Rcis
   ETBGNDWCbH1jnKsfvrztCh+HlUIyiDh1cShN+7kMD7mgPJC4snFf7jRxS
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728835"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:42 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:17 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:43 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 08/12] RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
Date:   Tue, 11 Sep 2018 13:05:35 -0700
Message-Id: <1536696339-15204-9-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

The old name was a bit odd.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

