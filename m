Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF53EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A641020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeFTOZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:25:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:25:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M4miX-1gQ7583WYv-00ywch; Wed, 20 Jun 2018 16:25:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] reiserfs: remove unused j_timestamp
Date:   Wed, 20 Jun 2018 16:25:02 +0200
Message-Id: <20180620142522.27639-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:8youE5gdzqlCVc47C1M34WBtIrfY3nKAxGELInFt2od+eETb7vX
 qLjzZIMt0nw1tperFlZofr/vs2qvCZEustwtGaSN0yuhn0Wcjwfg1FFNcLdxhAsC9kkJFE9
 xR3oIE/QcOZEpsD9tKi3Jh0e5pcRr86IL7EffEgoRtXS9orUAGHkbtE3xxh/cH69dVnY47z
 l4VPohNRiaVH9ZgT6hnEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VD5C1kPIHoE=:2qDUVVSovwfSDfKR7NJZ0d
 x+rE4qCrAyAFZ+gmRwtP3DcS99UUqBbjWN9zYiBXcifuilb823C4iRun56driWsJ2lCS8ZLBB
 rT/tkGf6SXQdFaDysi1fmTxT8Xs05LpHRwWAwh+rSiGMGG7Ga06CUYWzVIIhHDX5lUe2C3OlL
 ixO6WUUCqK4FSQDIiefkduTvYEC6bt9rYnM3lQO+Nnkc6EFnnh+DqNvltzA86xRTU7nPdAvlT
 rAKxP5V1IwelJIhRls+6I+F8j3epFLmTWHZFPmu45wxcQSbIAANaQEwuijV8ShyHmx3RZT3ly
 MXbS5EiSEC6LTGKVOgcTR33YQaWQdALJGHMdLMxOBcwF6aPVm/o2z/G+KhyXBQKmZIlmMQrbx
 bSQB7IbOfh80uLPnZ+XSmJ9kQYB3omkz1eZWbQNgKNrzDmbVlPzdIVSDfuhIhrz0YgyIjo3tP
 +3ORMpqn+mOkJ61zBbrdIzr6C6xlQfiUCQxpcr6+6Yp8RGrK9ZatI+dcTC3s8b3bIq1IJHTep
 B3cEZs5KEui8BrbxxDYUMglqeK601obgvgRFX1h5YMCmBlpp3yCwqQCkIDMlrDe5qwP7EBuNw
 loh1dlGB7XtLrJ8zz5xvfyOMx0zW3GWlYtM5okMi3bfu2e6bkUvS0GXzVm4vKzRqInUq6sLFP
 AAwjfr6yZd5sMmYOAzOTnX19K5ef/KvKe5atoORxemvb3K7KSy1rynwCz+yK6Bk0xQlk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the deprecated time_t type but is write-only, so we
can just remove it.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: no changes
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

