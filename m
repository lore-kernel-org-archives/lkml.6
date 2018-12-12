Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCAAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFFB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z27NIEeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFFB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeLLOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:14:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35593 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeLLOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:14:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so8944424pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RC6CyxsSpOllp+yTkhbx4mv1Uz8eGWzFf31umDuBjzc=;
        b=Z27NIEeCJbqIO5tbS6E1a+ZCLOyE43/0nBk7ZOz0WSCJbGhx/Ih8Fc6atzbwEfHN/4
         bJg4F3iXPsXa8MpF/X+JIJ4zWoLtUe/97S7bzf87fVq87pZ1Iz1NvB/AVum4jx6zPAEy
         ZynQyE6QRXzRBN3e6HjBhXqW7VyV0RM8tHdfQpQ9fvCDl6+jvSZIvWefxSaFh3auWOrN
         Uea7Nkzj0NY447T2KDXDD+6lS/CDd3vcWYJ0zuJHGZO9BxmNXILIDe2jww7R1Ge0BrBh
         lpeg6eufBxw+1929yeXFIucgU8RY48jXJF46EPDZUl2kIj4i3E3nrSN1vdpnQl4x03n1
         GRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RC6CyxsSpOllp+yTkhbx4mv1Uz8eGWzFf31umDuBjzc=;
        b=ir2aY5T1W0GpuJEZInyMB1yjwVjGoorrW+aB4Zfq3v0kKO26CffDFGOQFHdGmMlI5N
         w0MNw2NhKhUKnIw2Dq44W3v1A6alTThXJAT21tBG/qy+IKJYMOj1XpZCxlJuSfahJSvX
         ELR+yUjxMTQCW50lnsxWBt3xgOnufNc8ffOXNpgncCjseGGWj8CQjYPTrFUE8YkeC/zf
         cu+7j11uuzo8sAtQHiXM57WvVO5d+wO//METi1WkxKiWyNJ2AUl/vLNMGLP9LkxBqLx8
         9l98XeLlSFBkIgnsu2IHRfC4qmMZKKhorkYr36dhNaOyjtUMbC2fu+peSDs5iZNKBd4V
         C3Ig==
X-Gm-Message-State: AA+aEWYdRtH2eEwYWL4eVDILuaU+T74DAhoSEdzzk0EwbvYp+UZkNfkn
        P3bDBSegraeQdt0h/kf8FwQ=
X-Google-Smtp-Source: AFSGD/XtTs9hu8/VxWg6/stm7vvL41O02YWVT5i893R0pKzdsL/RgldK4l7/OfcBP8ZZEYVNYriufw==
X-Received: by 2002:a63:104d:: with SMTP id 13mr18456250pgq.303.1544624066578;
        Wed, 12 Dec 2018 06:14:26 -0800 (PST)
Received: from gmail.com (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id t21sm21809154pgg.24.2018.12.12.06.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Dec 2018 06:14:25 -0800 (PST)
From:   zhangjun <openzhangj@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: ubifs: fix page_count in ->ubifs_migrate_page()
Date:   Wed, 12 Dec 2018 09:13:57 -0500
Message-Id: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the PagePrivate() in UBIFS is different meanings,
alloc_cma() will fail when one dirty page cache located in
the type of MIGRATE_CMA

If not adjust the 'extra_count' for dirty page,
ubifs_migrate_page() -> migrate_page_move_mapping() will
always return -EAGAIN for:
	expected_count += page_has_private(page)
This causes the migration to fail until the page cache is cleaned

In general, PagePrivate() indicates that buff_head is already bound
to this page, and at the same time page_count() will also increase.
But UBIFS set private flag when the cache is dirty, and page_count()
not increase.
Therefore, the expected_count of UBIFS is different from the general
case.

Signed-off-by: zhangjun <openzhangj@gmail.com>
---
 fs/ubifs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1b78f2e..2136a5c 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1480,8 +1480,15 @@ static int ubifs_migrate_page(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode)
 {
 	int rc;
+	int extra_count;
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
+	/*
+	 * UBIFS is using PagePrivate() which can have different meanings across
+	 * filesystems. So here adjusting the 'extra_count' make it work.
+	 */
+	extra_count = 0 - page_has_private(page);
+	rc = migrate_page_move_mapping(mapping, newpage,
+			page, NULL, mode, extra_count);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-- 
2.7.4

