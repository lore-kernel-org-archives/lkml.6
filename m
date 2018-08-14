Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52F7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD120C03
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD120C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHNNUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:20:14 -0400
Received: from foss.arm.com ([217.140.101.70]:41160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbeHNNUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D31C67A9;
        Tue, 14 Aug 2018 03:33:39 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.emea.arm.com [10.4.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E453F73C;
        Tue, 14 Aug 2018 03:33:38 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, corbet@lwn.net,
        Dave.Martin@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH] Documentation/arm64/sve: Couple of improvements and typoes
Date:   Tue, 14 Aug 2018 11:33:32 +0100
Message-Id: <20180814103332.28836-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    - Fix mismatch between SVE registers (Z) and FPSIMD register (V)
    - Don't prefix the path for [3] with Linux to stay consistent with
    [1] and [2].

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 Documentation/arm64/sve.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/sve.txt b/Documentation/arm64/sve.txt
index f128f736b4a5..7169a0ec41d8 100644
--- a/Documentation/arm64/sve.txt
+++ b/Documentation/arm64/sve.txt
@@ -200,7 +200,7 @@ prctl(PR_SVE_SET_VL, unsigned long arg)
       thread.
 
     * Changing the vector length causes all of P0..P15, FFR and all bits of
-      Z0..V31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
+      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
       unspecified.  Calling PR_SVE_SET_VL with vl equal to the thread's current
       vector length, or calling PR_SVE_SET_VL with the PR_SVE_SET_VL_ONEXEC
       flag, does not constitute a change to the vector length for this purpose.
@@ -500,7 +500,7 @@ References
 [2] arch/arm64/include/uapi/asm/ptrace.h
     AArch64 Linux ptrace ABI definitions
 
-[3] linux/Documentation/arm64/cpu-feature-registers.txt
+[3] Documentation/arm64/cpu-feature-registers.txt
 
 [4] ARM IHI0055C
     http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
-- 
2.11.0

