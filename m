Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D862C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1144820685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMmsPR9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1144820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeKFAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:07:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37117 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:07:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so4542273pfm.4;
        Mon, 05 Nov 2018 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YGDbV8M6ZQhO26iEMemFlbnzNSn4SXD18e12/JLSXVs=;
        b=RMmsPR9hjn8LPbtES6bav82LC1g5/WYwn+HoicDgDaSIIbVrcehduVS0JWuXyjJJMy
         SRU9xgFrAYeeob3ZB7zUY/l3g7TLeDIUgqoIVa/aldvD1V3Q13znsx1OsNXAFXX76699
         LmGKn550c20qKejouedYZaFyupx7MDqUfeK0qPDhJL8ZxUMOfR/hcNKgSEqpNVDQr21f
         4kazinm0bBZb0w8K8AtXrTBcAtYrCw/PlDUGN/CRgqxV2A7yGD6Qy616xfdxlNjYsD/h
         /aqLz17morRx0/Lrfu6nEWCq4fJgQGbeElDb/3jdzLiygI8DUvH9c0plRg0sZSR+nlwZ
         LPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YGDbV8M6ZQhO26iEMemFlbnzNSn4SXD18e12/JLSXVs=;
        b=hqA+6eeuDOBD2QLr4fR1YaWPh+GGszA+vUWSUQj87mwie3XzbP1Dd/QD2RdVGLlDq1
         r1Oo8RF0rbHyNs5WNr8yF4cSZpDbrmsulhQ2pNZ6ft5LHV0cvesmhLSIY2ObGC5AWQF3
         MzukqcZuslCTXy0GvKKo6nTk5GY/2D6Bw26kwR0lJ767Uy+qPlgh2Tm6fMvopK1kURjT
         TG2mmvprd6hd4WaGncab2NxBC9ORnMOpDTfXmsIJdaEOs3rPtjufooFyHsC0Jbaf3tX0
         jb+ihrXN1z1WN/kxrXEKxNRfeZm9VogIB4aICrKYBtyH3b8UPvUaEKuhqxpBSgzdPF2v
         t95w==
X-Gm-Message-State: AGRZ1gK/u+f+aA4F70tA8CSLTsp61iKR6F2F4tti/mrVQE2jfJJlv9mU
        8W7aGD6cMbaaP7q/ciRnFcwWAUcUYsQ=
X-Google-Smtp-Source: AJdET5eUcLJ+GtS+SNLmCHoE/gL2bJb7EPSmgPl24XzdFchd55UlHeIdmha17HQXvuyIdNFRQRIFmQ==
X-Received: by 2002:a63:194f:: with SMTP id 15mr6214161pgz.192.1541429244750;
        Mon, 05 Nov 2018 06:47:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z14-v6sm50956027pge.47.2018.11.05.06.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:47:23 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:47:17 -0500
Message-Id: <20181105144717.6233-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/powerpc/kvm/book3s_xics.c | 12 +-----------
 arch/powerpc/kvm/book3s_xive.c | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b8356cdc0c04..8fdc8eb77039 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1017,17 +1017,7 @@ static int xics_debug_show(struct seq_file *m, void *private)
 	return 0;
 }
 
-static int xics_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, xics_debug_show, inode->i_private);
-}
-
-static const struct file_operations xics_debug_fops = {
-	.open = xics_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(xics_debug);
 
 static void xics_debugfs_init(struct kvmppc_xics *xics)
 {
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 30c2eb766954..57ef1502a52c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1905,17 +1905,7 @@ static int xive_debug_show(struct seq_file *m, void *private)
 	return 0;
 }
 
-static int xive_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, xive_debug_show, inode->i_private);
-}
-
-static const struct file_operations xive_debug_fops = {
-	.open = xive_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(xive_debug);
 
 static void xive_debugfs_init(struct kvmppc_xive *xive)
 {
-- 
2.17.0

