Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1CC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E012171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RofPxRvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeLZTnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:43:09 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50926 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeLZTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:43:09 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E6FADC16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id puzT2C1vZQOS for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 13:43:07 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B561EC37
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:43:07 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id n124so19304793itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Yukg6b4y64c8KSBao2PH5s3zw4SW0jWagPInPwmkaHA=;
        b=RofPxRvKoEh6WqNyov5/t7AACnJ3fsdmQTVMNY4Dk/Uo9/hJO3Dl6Ex731mLii54rf
         1R6h3pFd767vc5CygWQXG9idF/gg12zZHqAH7kuMKvYar9dJoN1hXa0AzWmLlAzX9kfQ
         fzT4V5k6qtS+c8GiZbTsImfbtPA4YgEF1ovRZZMEE+wmSOhN8ilFnbEV17lFXcmn7Ij2
         w4MwibNTIaQxmQnT5P+6Br9dt42SP222WmmhHP+IQyIRn3bIiYOlHEC2gUW38uv1tZSQ
         A/LjBnBxel49NVzpKpY5bKTlPdd2ZS7bBiPRQhsrpB25DU43X3giCa0RA3P9F/CLYPmm
         X1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yukg6b4y64c8KSBao2PH5s3zw4SW0jWagPInPwmkaHA=;
        b=qm7Wnw8IL4Xm3E8yffzG1Dt1tfAm/MmENP3C6BLy2H/ZkuvBhd/1QBelk241AGnmNG
         DqI2VexXSY2x24SWx8g8Qis6AbQ2peGCh7E/5XpMRFXkyuT+6wyswcSzqNDMxUPgUjCQ
         xNvsaEUaec1Q5Y6m+ET6PXJAjCMWc3a/BhyItvpZU6g4BXb2tjvChtljPAaWmHmdTNai
         6wgGe6vDsauJyK66Us0TEf+LizdE2AiAyG9jXlXo9bP/QD258aLZMC9GmsXhXWfcLUVa
         J7AvtptMK2yAf7tSZNrMQJDRGE4FxynKxp38sj0B2qTujObsqBdCshFIZZpKQlDQlq24
         6LxQ==
X-Gm-Message-State: AA+aEWYZ1G0Jdza/N36tvYkuQImob6/aOuQEnDVdo2smi+lWskpJw71w
        BIKsC9+0a/Xrv7pSPjJtP2r0Q5vfHv2eyeq2Jmn7aBCgQR/867QVLAsNymY9+obPlEp+anAta5G
        GDo5w/dRJtccZTXagms+oVmlfuTdq
X-Received: by 2002:a24:76d0:: with SMTP id z199mr12624072itb.165.1545853387291;
        Wed, 26 Dec 2018 11:43:07 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7RLNHABeS4sylwXyw2vD+2670ol3IoMhrvfd5n61tTaGnrtPpPxF6L6ay7qnP9l60tg36zBg==
X-Received: by 2002:a24:76d0:: with SMTP id z199mr12624056itb.165.1545853387054;
        Wed, 26 Dec 2018 11:43:07 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id x128sm13391996itb.8.2018.12.26.11.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:43:06 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction.c: Propagate return value upstream
Date:   Wed, 26 Dec 2018 13:42:56 -0600
Message-Id: <20181226194257.11038-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysctl_extfrag_handler(), proc_dointvec_minmax() can return an
error. The fix propagates the error upstream in case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 mm/compaction.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7c607479de4a..d108974d0867 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1879,9 +1879,7 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
 int sysctl_extfrag_handler(struct ctl_table *table, int write,
 			void __user *buffer, size_t *length, loff_t *ppos)
 {
-	proc_dointvec_minmax(table, write, buffer, length, ppos);
-
-	return 0;
+	return proc_dointvec_minmax(table, write, buffer, length, ppos);
 }
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
-- 
2.17.1

