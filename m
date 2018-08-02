Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A1220862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dugeo-com.20150623.gappssmtp.com header.i=@dugeo-com.20150623.gappssmtp.com header.b="HX+qlXqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A1220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dugeo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHBD1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:27:35 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:35425 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbeHBD1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:27:35 -0400
Received: by mail-pg1-f182.google.com with SMTP id e6-v6so311350pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=nm0UxIhPx1cXqGRwecH+OO05GzRWqNwW8UAtOCMK7/g=;
        b=HX+qlXqHVdu5baAMRSed5b7l7Bl944CtnelvyzdugPnFnZPJ73k19ArZFRXFGhmNVF
         SupLxmicTNDZBtk2NrS761w2hDEVWBBYtrTl7fq2UZFMswZVWNbh+D/U8irtavKFHQq/
         0dZZJZAgN5GZgc+XnnFi/pF7Xe4lCmbiQJMXeHp7T+ueE6BRFyh/0IGTd5OywCrXm6Cz
         1s0plRxGGurfjtaEqvEWBzDlqAZ7vPsxsu5yUQnnQQ+NlgD1CKvfB2z71YqTx2jJ3ah6
         3dSwDozW11/8EeHhmlx+1M8xvZLswTYJgaQNt2EfQ1EWeg3/ZyiwJVxWlDAQcauCkXQO
         9ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nm0UxIhPx1cXqGRwecH+OO05GzRWqNwW8UAtOCMK7/g=;
        b=ZMeoWpdPagiLhJvyLiCloPROYfcOBfS2BfyHPYwBjQjQ/mn8jNUPRirHjGhSIqgKyI
         sfUT/xhqWgheemsYXVKgEDC656+6fXoAuL+0pmXANFVvKZrfxBT3738E6Ics4mQx9cP7
         ioSgrOohxIwVxjRzYFu2i4WoomNCy8tSpN5w4hWthgfnGWFLaeMDhXg3PK64B2YlswLw
         m6enktLVOTk8oK3poDQ70iTqCi5q0MnB6SUTlYU3Mu7LpsAMA1I0Yl8OJ+BdenoTFUCB
         e4Tjh4HDT2zmQETv4GnwnnYZ1rz66YleRgV+B/q35a6nutV+pR832jcL9cZkO2Wz3wRy
         4jsQ==
X-Gm-Message-State: AOUpUlFFompSM2kuQjcEgY0/DNtqCSerc2/wDoAsCUwFrq9X3lzIIXf7
        7nWL0hMKech24feuI5so5jpolA==
X-Google-Smtp-Source: AAOMgpcKWC6BJLamrB+NPI5wzLRZggiBZbmVi/6C+/LpUzhSQlqiN3Ky8xyGIeER6nzYLMdaGHvCpg==
X-Received: by 2002:a63:40c7:: with SMTP id n190-v6mr707666pga.116.1533173935985;
        Wed, 01 Aug 2018 18:38:55 -0700 (PDT)
Received: from bud178.dugeo.com ([116.212.202.58])
        by smtp.gmail.com with ESMTPSA id 14-v6sm503775pft.93.2018.08.01.18.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 18:38:54 -0700 (PDT)
From:   Jacek Tomaka <jacekt@dugeo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: [PATCH v4] perf/x86/intel: Add support for MISPREDICT bit on Knights Landing cpus
Date:   Thu,  2 Aug 2018 09:38:30 +0800
Message-Id: <20180802013830.10600-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Tomaka <jacek.tomaka@poczta.fm>

Problem: perf did not show branch predicted/mispredicted bit in brstack.

Output of perf -F brstack for profile collected

Before:
0x4fdbcd/0x4fdc03/-/-/-/0
0x45f4c1/0x4fdba0/-/-/-/0
0x45f544/0x45f4bb/-/-/-/0
0x45f555/0x45f53c/-/-/-/0
0x7f66901cc24b/0x45f555/-/-/-/0
0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0

After:
0x4fdbcd/0x4fdc03/P/-/-/0
0x45f4c1/0x4fdba0/P/-/-/0
0x45f544/0x45f4bb/P/-/-/0
0x45f555/0x45f53c/P/-/-/0
0x7f66901cc24b/0x45f555/P/-/-/0
0x7f66901cc22e/0x7f66901cc23d/P/-/-/0
0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0

Cause:
As mentioned in Software Development Manual vol 3, 17.4.8.1,
IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
its format. Despite that, registers containing FROM address of the branch,
do have MISPREDICT bit but because of the format indicated in
IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.

Solution:
Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
---
 arch/x86/events/intel/lbr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b9055..81fe5047c6 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1230,4 +1230,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
-- 
2.17.0

