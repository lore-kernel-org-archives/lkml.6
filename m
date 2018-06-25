Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55371C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254C25489
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1254C25489
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeFYFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:31:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:48189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeFYFbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:31:34 -0400
Received: from localhost.localdomain ([122.224.77.194]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MVvDo-1fdnHs2smG-00X1EX; Mon, 25 Jun 2018 07:31:21 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] kernel/power: cast PAGE_SIZE to int when comparing with error code
Date:   Mon, 25 Jun 2018 13:30:58 +0800
Message-Id: <20180625053058.25206-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:0Y5TB6QQObgafKdCKhpsbL2pygV8JraO+7boIcTXrfEj2g/z0EH
 KKLMYTZswiahLTxspbhlrHIC3pOaEp82peI0wl1YchQ/DuhnYJy4XDYjZgpHO/lusLa+QTx
 yBa/El1m1822RptDWbtQlGpg7SBOkLe06CkoIGontLu1A2UhUW4oKLl4AATOfOEXt1XU725
 PdNHevQx2gfc4IbcF/kNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aU4h/BOPr/k=:gIwsqgEMH2bgJbP9ncJvk7
 e/m7VVVSsXuWi0Sa1fheHIN5J45d1YOWiK32qNci1q8ZbwNVd6IbVV6EObNLEu0Kkujsb7aLf
 jkjJL3nCk5PmOYKdwi2kiVYJSFmsY7uwgCtv7WBnqh+3BhihQyjV5ayvlFzxCCFps/CI8QAOq
 eAr6Ec6+kqxYt6bY1zhZaXFhzR9H7j9G+b0dqQzD3m8c2z/3kTtNxciSO8mVoAtO9xxkEp0QP
 xegqsosoAUFq9J/6zKuAtyckZugqcpwnMRQ5QHDFfvOo8VWrjsKtZScX4SgSnWg1FEKNJTySu
 poT3DkGLjse+EA5WnOIIuoMNgElgWzCB8Z1EEh7pKqChBALp+qFRfoe0zDZ8UUdjUxZ0rvnPa
 8s9ZW5NlvfjUEbUC+aZujIqLpTzb2CLP+kdWNwJhVoQxmE3GYPsg5uHuGwkSYqfPNAU+LLKID
 fvacybGIHJB4SAQ52cooWjuMUp97qBVxPFrxBDhzEdt6dvrSTjj3RTNa4x8GvyRSPRafjfG4D
 7bvICgMO0O/LrBfHw7ZvrWuqTHjqHFFJP8nBYXqeb4n6gtbXL7+SqBASh4WqyNtk0OTwgupE4
 xtvlrPx+ER5yBCJPq7zft261P60oTBgWrCcMIiBNKmEnLgVK2xrX8aGqKivqHJxLdGhjX/4H4
 tlVzmMgo1eKIwhpZtYtJZvl7J9tpH9dql+6I8s3I1daHTd1TO2tbw6amxz1u7BnuemXlFbE5k
 pd/e9777uox9NYP5a6wLs43Wgqd8eTiVYI0a06XIPkdjIWfKJLSwW4386WE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PAGE_SIZE is unsigned type then negative error code will be
larger than PAGE_SIZE.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c2bcf97d24c8..d7f6c1a288d3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -923,7 +923,7 @@ int swsusp_write(unsigned int flags)
 	}
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_read_next(&snapshot);
-	if (error < PAGE_SIZE) {
+	if (error < (int)PAGE_SIZE) {
 		if (error >= 0)
 			error = -EFAULT;
 
@@ -1483,7 +1483,7 @@ int swsusp_read(unsigned int *flags_p)
 
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_write_next(&snapshot);
-	if (error < PAGE_SIZE)
+	if (error < (int)PAGE_SIZE)
 		return error < 0 ? error : -EFAULT;
 	header = (struct swsusp_info *)data_of(snapshot);
 	error = get_swap_reader(&handle, flags_p);
-- 
2.17.1

