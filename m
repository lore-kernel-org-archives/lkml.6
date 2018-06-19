Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F017C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D9D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D9D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966889AbeFSPv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:51:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966587AbeFSPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:51:25 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LknvV-1g5SUe3jj3-00apmV; Tue, 19 Jun 2018 17:43:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] reiserfs: remove unused j_timestamp
Date:   Tue, 19 Jun 2018 17:43:13 +0200
Message-Id: <20180619154343.3640484-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:PhUlqdc57Bsheo9QhsiqJC4Hy04uSKg3QW7Iy9pKND6Tkc7NvIw
 LFMnHADwjxFX4sqU2Rwc2MHEYaGs7U0NmFTPtzp1bujQYfqD1Mw0jziAt2WaP2NLWxBoxgo
 iTU4VpcrgE50ITkrSwlIYhvHDCtwiAERm3Poz16c6k3uk/JlKeUPVZryQW3P3DqkQaVZlGo
 dDV8u4BR2pLP3nPfJkpLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xZegJWaghyQ=:D6yuCmDPNbtLH7SJE3CV5Z
 3aaqSCxMs0nc7ehl0U7pvJ9zgyBMS9pQGzs3j47Cljky82h+4e+wN9m8OqOQLvT7Q6u0WKHF2
 rRMwuY1fCDmo+NzIWyYVsXMb2MFwTbDdSiRuxXr6rohbbAogJlw2OY1KJtRkyYlYtnNI6C8Hf
 rHaEfCYZlEOZ4XG887sJ+iULp75netPv38Orz9MScn0Sif0uMisC2mqAjfCTscL/2sgrChXVs
 FaoKxiBasQnb5PrDDu7UNkPG9TFLfecvfBG0YkAoPGREORrpYpDNEcmHylG9dPImGn4KdA2/J
 RKgJQt19bQc1YAPkINA7o2HBBAvU+vF0xYcV7NwCUxRgS3zEoERF5/W7ryusH/PoeLwX//iuJ
 3L5e2w/td0rDzavVwb7Mb46GNPUoC34lyWlmc9IoMPfQIrt0JHuDCqoyqypVpSSMqRkWW0aMo
 VjROvN85OKdXbgGcvnw8m+XUnn0qJkNq7XTtZiY2re1wxjwRd49Evntf/US07c2zyu1AvH2Vf
 gpbE7cg5O0o4s/uBDvjC4HTCnvjdXDbjL+PAIJ5XdbintEFMMTy/i0sOreELHNcR8r/xdi+rf
 nrsH4w9/y2ZrNE6OjHxfwnZajXWSCD2a6g2dwTDuHgvIxXSNarBCXV1KPZ4DsxWDLQohjcRh8
 wpQbXgtvldTknleDb56I+UTS7NjE51W4/2kvmUCc4yWpSFF7bE6RUrArIspCN9wg4dhA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the deprecated time_t type but is write-only, so we
can just remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/reiserfs/journal.c  | 1 -
 fs/reiserfs/reiserfs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 52eb5d293a34..1e7f733b2a12 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -4110,7 +4110,6 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
 
 	atomic_set(&jl->j_older_commits_done, 0);
 	jl->j_trans_id = journal->j_trans_id;
-	jl->j_timestamp = journal->j_trans_start_time;
 	jl->j_commit_bh = c_bh;
 	jl->j_start = journal->j_start;
 	jl->j_len = journal->j_len;
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index ae4811fecc1f..1536ebbaf6ab 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -271,7 +271,6 @@ struct reiserfs_journal_list {
 
 	struct mutex j_commit_mutex;
 	unsigned int j_trans_id;
-	time_t j_timestamp;
 	struct reiserfs_list_bitmap *j_list_bitmap;
 	struct buffer_head *j_commit_bh;	/* commit buffer head */
 	struct reiserfs_journal_cnode *j_realblock;
-- 
2.9.0

