Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A92C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239120835
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beplJqcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2239120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeIAPhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:37:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44125 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:37:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so6593802plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=25NOX6BG+WBi0jAWQa6TAWi+GP3D18WHlD7cIG/N4+I=;
        b=beplJqcdDJXn8bSw+iWasasu3zztRvirop8+N8Amd3tGp4UJXcuocjsVHeM56sXVzr
         vu+Gq6bd41MJsCfPR4S+ZIG4dpjkq8PwuQkOZV/yrE/yix3L5lCk+9D5q1VtKLnbRwob
         IaTYr15ASY/6osI3VJObLSwbrmojWJWA5BMljxQ/tTUQZGbd00XCx2jHlK651xFpgpMr
         qHTas2LJTalOSH3gNj41WVqxkSAVbx0d/88EsitiQLP7k0M74AqdCYy1uQVnKR1BWntG
         fRcRBzmzEnqPiJP8o5U/Hnujq1BRGKs1FzCEkGaafYaOVDM9kQur+RJcbOFY+1HYkOnx
         6IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=25NOX6BG+WBi0jAWQa6TAWi+GP3D18WHlD7cIG/N4+I=;
        b=jFj4emJ+sJQUsEjem+2nnpsCA710+yRxMah6ZlTJ2171vfOz3bUOU7mCTPg4E4sdtM
         FtRYS/a0ZBFOx4dzHyLXsFECDYgBIFlba8Fz1A/BiN0aY8NAXjhbaqTNIplTi9AYixgM
         WzONoiZIECx6hOtUXtpKqyZWAdb5QGamZC9JZZE1rhxiScAIxKD+uhJXQzlFrFjBt4VU
         H32dSxwjdSAWSq/GNOGBpQzcn/bWWQs7koYocoEjI0FkPAV2ArlY1jhkr7eZ5ydnElae
         taVwxZHwI3aN8GFaGwe8WqAFNTkDxxYoqBe/AGC9oqdcSzOx3yJHlSk7cb2J8P55jRnK
         M9Iw==
X-Gm-Message-State: APzg51BqXCdpY/9xuwPVKGM7Eplc+60mV0xOnaYMI5LbIFDbUMtsv680
        xKg+Zu3ckVlcdvC/OB9NPa0=
X-Google-Smtp-Source: ANB0VdaacDjilV76LbW6s/9QexkiQ9JJXKNQ3I5YCwlEeIkpns4KKBvKYtUTqEIf42IxPQtJj93f8Q==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr19619730plz.68.1535801138543;
        Sat, 01 Sep 2018 04:25:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id p2-v6sm14343785pgv.21.2018.09.01.04.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:25:38 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: ocfs2: dlm: Fix a sleep-in-atomic-context bug in dlm_print_one_mle()
Date:   Sat,  1 Sep 2018 19:25:28 +0800
Message-Id: <20180901112528.27025-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] get_zeroed_page(GFP_NOFS)
fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 255: __dlm_put_mle in dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 254: spin_lock in dlm_put_ml

[FUNC] get_zeroed_page(GFP_NOFS)
fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 222: __dlm_put_mle in dlm_put_mle_inuse
fs/ocfs2/dlm/dlmmaster.c, 219: spin_lock in dlm_put_mle_inuse

To fix this bug, GFP_NOFS is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/ocfs2/dlm/dlmdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 9b984cae4c4e..1d6dc8422899 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -329,7 +329,7 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 {
 	char *buf;
 
-	buf = (char *) get_zeroed_page(GFP_NOFS);
+	buf = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (buf) {
 		dump_mle(mle, buf, PAGE_SIZE - 1);
 		free_page((unsigned long)buf);
-- 
2.17.0

