Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05920C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD351204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD351204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeLJRus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:50:48 -0500
Received: from foss.arm.com ([217.140.101.70]:59864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeLJRup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:50:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04FEA15BF;
        Mon, 10 Dec 2018 09:50:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50C7A3F6A8;
        Mon, 10 Dec 2018 09:50:43 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        anders.roxell@linaro.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, naresh.kamboju@linaro.org,
        peterz@infradead.org, will.deacon@arm.com
Subject: [PATCH 1/2] locking/atomics: Change 'fold' to 'grep'
Date:   Mon, 10 Dec 2018 17:50:34 +0000
Message-Id: <20181210175035.45096-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210175035.45096-1-mark.rutland@arm.com>
References: <20181210175035.45096-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

Some distibutions and build systems doesn't include 'fold' from
coreutils default.

.../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found

Rework to use 'grep' instead of 'fold' to use a dependency that is
already used a lot in the kernel.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
[Mark: rework commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 scripts/atomic/atomic-tbl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
index 9d6be538a987..81d5c32039dd 100755
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -180,7 +180,7 @@ gen_proto_variants()
 #gen_proto(meta, ...)
 gen_proto() {
 	local meta="$1"; shift
-	for m in $(echo "${meta}" | fold -w1); do
+	for m in $(echo "${meta}" | grep -o .); do
 		gen_proto_variants "${m}" "$@"
 	done
 }
-- 
2.11.0

