Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B4CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494FB2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494FB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIJRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:33:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:33:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ACd7hN1846755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 05:39:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ACd7ri1846752;
        Mon, 10 Sep 2018 05:39:07 -0700
Date:   Mon, 10 Sep 2018 05:39:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-0b405c65ad459f5f4d3db1672246172bd19d946d@git.kernel.org>
Cc:     will.deacon@arm.com, colin.king@canonical.com,
        peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          tglx@linutronix.de, colin.king@canonical.com, will.deacon@arm.com
In-Reply-To: <20180824112235.8842-1-colin.king@canonical.com>
References: <20180824112235.8842-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/ww_mutex: Fix spelling mistake "cylic"
 -> "cyclic"
Git-Commit-ID: 0b405c65ad459f5f4d3db1672246172bd19d946d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0b405c65ad459f5f4d3db1672246172bd19d946d
Gitweb:     https://git.kernel.org/tip/0b405c65ad459f5f4d3db1672246172bd19d946d
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Fri, 24 Aug 2018 12:22:35 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 14:00:01 +0200

locking/ww_mutex: Fix spelling mistake "cylic" -> "cyclic"

Trivial fix to spelling mistake in pr_err() error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20180824112235.8842-1-colin.king@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 5b915b370d5a..0be047dbd897 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -324,7 +324,7 @@ static int __test_cycle(unsigned int nthreads)
 		if (!cycle->result)
 			continue;
 
-		pr_err("cylic deadlock not resolved, ret[%d/%d] = %d\n",
+		pr_err("cyclic deadlock not resolved, ret[%d/%d] = %d\n",
 		       n, nthreads, cycle->result);
 		ret = -EINVAL;
 		break;
