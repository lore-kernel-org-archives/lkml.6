Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C7C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5092075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJh3/FBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5092075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKUAab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:30:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKUAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:30:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so952554pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6pmlTDFihEBurm1dLJqxoC6KqTTJxAXpBV9ussy6bQU=;
        b=GJh3/FBvAImQxMJCmTqAUB+F4ewRctJxtZTladXv5ZCfji4jkAQwT9VXE0Vk+J1H8C
         XWPTEvztUZ/272eQNE1WEEueMz/aFV1SIA+7Uy2wSVOHH2Rcx6YNrwM6rRuR0at6wJov
         HvVorEo6o3ArmxryHePMvKq7z/KnCnCBcrQEeUgF7Uxed3AgEZzMmPYmUeDQg8iyoznE
         5n2ILqpYY2KzqSfp+NDmvt91IKIsVvheV6tvlS6pLCkqoUkUQRPFhQSGpWEfcj93YkqJ
         1iliHRSSi4G545CxJvQSqFL9VMTL0gOOMSA/mZQgInuCRWTL63MHG57HZW5kpRNVYlF/
         6D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pmlTDFihEBurm1dLJqxoC6KqTTJxAXpBV9ussy6bQU=;
        b=TrHtyuDX7aayib1Vs5/EB5i8XYkT7kQKMC2NaGUjLZxA0748eNXB6wXqKqeryfaKI7
         As2LAHbU46kPPpd5uUj5XIW3Sy6d2kl9WTrCf7viA+nfizHPk7iNtrFzJRqBEsOCN6U6
         nKBA2VEt4QNWNrh4cbMqY/kcaJnBvhvLThSLeR2H/1cjF8UylkW0rwK0TEqXaogiG+/b
         +Qcvzizr86YIlW4eXZ0hl05lvA9WXT3iRnL9g0s9yKiuDrMRdj4R0v8SWPS7U0EICywh
         UOMvCIxCY8MdyhaYysqkx4Dz+R+rgvej/vwUaqC/iai5NsXaDHgksT7QdGxkAbRazbym
         evKg==
X-Gm-Message-State: AGRZ1gLBOAEvx5su9jy85Bd0HsVtvpX9ly1yqceSNFbXm2ihhoB0nK+d
        KI7Rk21QYFdX1VCNHJufKW8=
X-Google-Smtp-Source: AJdET5eJMztj/Bls5sZ/jGrj0OwtfBCdjpRKYRIOm8+SU0OKdhgnFIhU6dq2rqiv4ptr/YI/ivQA0A==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr2366212pfa.30.1542722473030;
        Tue, 20 Nov 2018 06:01:13 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i63-v6sm9551776pfi.66.2018.11.20.06.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 06:01:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, robh@kernel.org, mhocko@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] arm: add missing of_node_put()
Date:   Tue, 20 Nov 2018 09:01:09 -0500
Message-Id: <20181120140109.20334-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/kernel/devtree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e3057c1b55b9..9576adf0d15b 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -101,7 +101,7 @@ void __init arm_dt_init_cpu_maps(void)
 		if (!cell || prop_bytes < sizeof(*cell)) {
 			pr_debug(" * %pOF missing reg property\n", cpu);
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -115,7 +115,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
 			of_node_put(cpu);
-			return;
+			goto out;
 		}
 
 		/*
@@ -129,7 +129,7 @@ void __init arm_dt_init_cpu_maps(void)
 			if (WARN(tmp_map[j] == hwid,
 				 "Duplicate /cpu reg properties in the DT\n")) {
 				of_node_put(cpu);
-				return;
+				goto out;
 			}
 
 		/*
@@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 	if (!bootcpu_valid) {
 		pr_warn("DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -184,6 +184,8 @@ void __init arm_dt_init_cpu_maps(void)
 		cpu_logical_map(i) = tmp_map[i];
 		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
 	}
+out:
+	of_node_put(cpus);
 }
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-- 
2.17.0

