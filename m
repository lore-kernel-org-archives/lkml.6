Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E76ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D9220869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D9220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJSX6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:58:40 -0400
Received: from mail1.windriver.com ([147.11.146.13]:61044 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJSX6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:58:40 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9JFpHqS023514
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Oct 2018 08:51:18 -0700 (PDT)
Received: from pek-lpg-core1-vm2.wrs.com (128.224.156.107) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Oct 2018 08:51:17 -0700
From:   Hongxu Jia <hongxu.jia@windriver.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <kim.phillips@arm.com>, <brueckner@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <mpe@ellerman.id.au>, <peterz@infradead.org>,
        <ravi.bangoria@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>,
        <acme@redhat.com>, <namhyung@kernel.org>,
        <hongxu.jia@windriver.com>, <sboisvert@gydle.com>
Subject: [PATCH] perf arm64 Makefile: remove harmless but unneeded extra slash
Date:   Sat, 20 Oct 2018 00:01:35 +0800
Message-ID: <1539964895-35174-1-git-send-email-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 tools/perf/arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index dbef716..bc2a284 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -13,7 +13,7 @@ out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
 incpath := $(srctree)/tools
 sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
+sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-- 
2.7.4

