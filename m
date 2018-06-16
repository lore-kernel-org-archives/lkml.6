Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF40C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF82D2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF82D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFPH3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:29:18 -0400
Received: from www.osadl.org ([62.245.132.105]:49668 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753776AbeFPH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:29:17 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5G7QpAQ009199;
        Sat, 16 Jun 2018 09:26:51 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: Octeon: assign bool true/false not 1/0
Date:   Sat, 16 Jun 2018 09:26:32 +0200
Message-Id: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booleans should be assigned true/false not 1/0 as comparison is not needed

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by scripts/coccinelle/misc/boolinit.cocci
  ./arch/mips/cavium-octeon/octeon-irq.c:817:3-13:
  WARNING: Assignment of bool to 0/1

Patch was compile tested with: cavium_octeon_defconfig
(with a number of sparse warnings - not related to the proposed change)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/mips/cavium-octeon/octeon-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index b3aec10..31be6a9 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -814,7 +814,7 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
 			pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
 
 		if (cpumask_test_cpu(cpu, dest) && enable_one) {
-			enable_one = 0;
+			enable_one = false;
 			__set_bit(cd->bit, pen);
 		} else {
 			__clear_bit(cd->bit, pen);
-- 
2.1.4

