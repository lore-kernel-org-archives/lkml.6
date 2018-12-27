Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F221741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICXCGPvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeL0XYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:24:05 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33432 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbeL0XYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:24:04 -0500
Received: by mail-qt1-f201.google.com with SMTP id k90so26192750qte.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/EPudTNTCq6A/FDFSmKHo8KDd0/qXZYQkhOO70XqdFY=;
        b=ICXCGPvizN+YIcmS6sKJFNWk8na/m9i3Rq+r7Bq2yRFPRzfnA5NCZ+jvToLfPu9cBT
         DxW6HlXi1aPAHETpDgifwyd7gcKgN60HKjPTA0lTy97bcC8lDcuQMgmv2MohL6JDMNE4
         BHDtsUyC0pFyFQP45HInBC4kd88R94sJc1g4DYK3ypcNY24jjrULXzft7KgIBY6X9jKp
         UT3NbAjf+5VEa6jTvbvmyEYVd10+CVAue1WM+nb8VPC2L4GUPnfY158yaHg59lrIpEFr
         XAvXku8YhWYesYFlojgnabaCeKutP1MmWy/9GzA3/IK9UJViZoZ/9Os7ygMN3ImFakFi
         E6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/EPudTNTCq6A/FDFSmKHo8KDd0/qXZYQkhOO70XqdFY=;
        b=PsIxJ90n6ILx7/hO5eq02QFA2y+gvhpr5uwHG7G2PFI+h0xYxaRZXfLLJZ5InQ6ykx
         hISMdqKJHr3sU5B/zh+LmNahItdkzmvERZYhSWIZfLQBwzFsGyq0+WHz8wLBYDkCp7L7
         rR8s19QfIX8eMzIAQvTnhjNosC+nB5JkKGc3Mz5HRKi1Pwkr22zvllRsVCq6doKNikNn
         ORCNpXajjUuwMM5TD/5Vy79jIOW1Su+3P3ZILa/qwDqwI4U3iiqmAU7jMlvWYxs1X/Yf
         2czzuO6+AeJTBnZfEPxktRSPVYlAC1bkEOEZXV4xBwKwbzX1hGj/WyB0uivTv91Wmo/8
         hGFw==
X-Gm-Message-State: AA+aEWbESwF93ZhJhAr3j3q8pt/Ut/FsySg+TDUOtY44fhZ3tBklnYQN
        LRs5pFZJ9Qsh4Gmoi1tPRlbMyizZi9ozMw==
X-Google-Smtp-Source: AFSGD/U7619okJT/MmqRvvy/VsDXoCm1OtFCLvuLwoIolPSFkuNW6cmjTJF5K4EdrQZPuAtKtPrhCU7Rrldw5Q==
X-Received: by 2002:aed:22cb:: with SMTP id q11mr18964903qtc.31.1545953043487;
 Thu, 27 Dec 2018 15:24:03 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:23:54 -0800
Message-Id: <20181227232354.64562-1-ksspiers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] include/linux/gfp.h: fix typo
From:   Kyle Spiers <ksspiers@google.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kyle Spiers <ksspiers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelled "satisfied"

Signed-off-by: Kyle Spiers <ksspiers@google.com>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0705164f928c..5f5e25fd6149 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -81,7 +81,7 @@ struct vm_area_struct;
  *
  * %__GFP_HARDWALL enforces the cpuset memory allocation policy.
  *
- * %__GFP_THISNODE forces the allocation to be satisified from the requested
+ * %__GFP_THISNODE forces the allocation to be satisfied from the requested
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
-- 
2.20.1.415.g653613c723-goog


