Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16532218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfBKNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:22:30 -0500
Received: from foss.arm.com ([217.140.101.70]:48378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbfBKNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:22:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56A91596;
        Mon, 11 Feb 2019 05:22:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2F663F557;
        Mon, 11 Feb 2019 05:22:25 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org
Cc:     akpm@linux-foundation.org, anders.roxell@linaro.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        naresh.kamboju@linaro.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCHv2 1/2] locking/atomics: Change 'fold' to 'grep'
Date:   Mon, 11 Feb 2019 13:22:12 +0000
Message-Id: <20190211132213.15249-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211132213.15249-1-mark.rutland@arm.com>
References: <20190211132213.15249-1-mark.rutland@arm.com>
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
Acked-by: Will Deacon <will.deacon@arm.com>
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

