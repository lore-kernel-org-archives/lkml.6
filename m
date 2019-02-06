Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC6C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A0D218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jDCmckdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBFDrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:47:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41988 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFDrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:47:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so3490590qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 19:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hn7+N9666cc4lS16XW3pckdR4GfHKvecl40QV/S0Gr0=;
        b=jDCmckdiuhtXoybFpuM3uFm+lgtvEbsTXUi7VxzhH4gerkvuUkAcEMj20+hcJM0I4L
         +Tm6nJTIF2LnT7Jv0bmR7CGF3BdDPlhMVo91k0OEdihfT75hjweOW8igV0UcvETTe3sM
         xc2qMWcUMhQS1cQDjq1Qx+9M2O5r4iRDTk2EslJwzFxhelOZxJmHijj8d/bZwYy9/fC+
         KGp2quNBAnmr0a8whQPJHIyGFGPEMlbZuagS6UsiFgOMzj8PNl5Pe55e++lvXL9KITz2
         XENp3372I1aNr6brGGEd3nFSz5uE4MZ/HR5C7v1qvqtWo/eRwFWHhWwXqq+6pRR9IG0g
         wXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hn7+N9666cc4lS16XW3pckdR4GfHKvecl40QV/S0Gr0=;
        b=EH6sS+AAAP6+ZpAK1SV/UYX6kmVpYiEjOZ5ZQDDoXywr+fqN+HFF6jKGEgtl2brEEc
         1v5QoYS4uiRY8BsVJXmH+BFWcy40duTHPP0yPEFukMpe6S5eDg0tzEYJfdiA7ttPSQwW
         Vr3efKeLnPL5gQLVy0ydRpg/Zcc3XIFhrSqPiNYD+6FHGgVtc/7QQGjbEZ9nE+AbLGWd
         +gD+POImQ2Epgn7BHn7MVk6RJUaupAHDAt7Py0uk0bw8npVNCPdhKGGdVnEdpaM2gq0k
         D6IN2cXRWPW7ttI4d0FIrUKqrj+Di8VH6C653u9u2dpqby/w73DoCrJcZBe++LhDtTBv
         tW8Q==
X-Gm-Message-State: AHQUAuZGSaS1SYorlCripOujwy51hsXZMLGiItsCCgyVd1WOXpVmeb6o
        dnRpjhYSqRICP7XbA2yCwdh1wYj+rWA=
X-Google-Smtp-Source: AHgI3IY5rnr5djl+RIVWHTf46zBv2SkMoEUn9XCb9tFsbn6dnXUyHHUJdKQTmk02zutMbpDTLc1DKw==
X-Received: by 2002:a37:2d02:: with SMTP id t2mr5897714qkh.82.1549424871806;
        Tue, 05 Feb 2019 19:47:51 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u27sm7392987qte.48.2019.02.05.19.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 19:47:51 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/compaction: no stuck in __reset_isolation_pfn()
Date:   Tue,  5 Feb 2019 22:47:32 -0500
Message-Id: <20190206034732.75687-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c68d77911c23 ("mm, compaction: be selective about what
pageblocks to clear skip hints") introduced an infinite loop if a pfn is
invalid, it will loop again without increasing page counters. It can be
reproduced by running LTP tests on an arm64 server.

 # oom01 (swapping)
 # hugemmap01
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
mem.c:814: INFO: set nr_hugepages to 128
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.

Also, triggers soft lockups.

[  456.232228] watchdog: BUG: soft lockup - CPU#122 stuck for 22s! [kswapd0:1375]
[  456.273354] pstate: 80400009 (Nzcv daif +PAN -UAO)
[  456.278143] pc : pfn_valid+0x54/0xdc
[  456.281713] lr : __reset_isolation_pfn+0x3a8/0x584
[  456.369358] Call trace:
[  456.371798]  pfn_valid+0x54/0xdc
[  456.375019]  __reset_isolation_pfn+0x3a8/0x584
[  456.379455]  __reset_isolation_suitable+0x1bc/0x280
[  456.384325]  reset_isolation_suitable+0xb8/0xe0
[  456.388847]  kswapd+0xd08/0x1048
[  456.392067]  kthread+0x2f4/0x30c
[  456.395289]  ret_from_fork+0x10/0x18

Fixes: c68d77911c23 ("mm, compaction: be selective about what pageblocks to clear skip hints")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/compaction.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 03804ab412f3..1cc871da3fda 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -282,17 +282,16 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
 	end_page = pfn_to_page(pfn);
 
 	do {
-		if (!pfn_valid_within(pfn))
-			continue;
-
-		if (check_source && PageLRU(page)) {
-			clear_pageblock_skip(page);
-			return true;
-		}
+		if (pfn_valid_within(pfn)) {
+			if (check_source && PageLRU(page)) {
+				clear_pageblock_skip(page);
+				return true;
+			}
 
-		if (check_target && PageBuddy(page)) {
-			clear_pageblock_skip(page);
-			return true;
+			if (check_target && PageBuddy(page)) {
+				clear_pageblock_skip(page);
+				return true;
+			}
 		}
 
 		page += (1 << PAGE_ALLOC_COSTLY_ORDER);
-- 
2.17.2 (Apple Git-113)

