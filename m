Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D914C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CA52082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tj9hXT/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CA52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLHNhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:37:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39477 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLHNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:37:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so3118841pld.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 05:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5TrM5uSqDuHn/TJD2QwMyhxyWPNtLFwaBkvImxSto0=;
        b=Tj9hXT/DuAvwyjYZmXNs2dWKa8SFX94n+Mm9WunJ70at9IU96NStA70gHxieahsxQ1
         8P+7BHAS6+UI3/AOlu0fmG+NlKiBKj7aIpF0NftxogZtmrb1yvNW39RdS3QXpIiXFHse
         sVHnnqN8NdftgYCTmMifx6TCSh+W3cQGHzCOiuQdMUVXoJ9A6868WCzgSlh12WRHDDmj
         /xLO9OJhULyvEc6epbTC+840qRVTtdG7QEuSmvC89PrTgJkjqmy6AUWt5T4UUR3BhMQ3
         67NGMBUM+wpUmwDQl6BQU0IKaCmu8PByn+wXfM5QviqaAsvfUyVIgdy/5BYf/0iE2n4e
         pdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5TrM5uSqDuHn/TJD2QwMyhxyWPNtLFwaBkvImxSto0=;
        b=MbP0Io8TOnmgXz6YDnwkxBwsEy1z5M9tWFhiZy4Woi0QDId9nwHiL1eI/G5cAi77MB
         WnK2UxZq27Pzkf7xnRFU8YrvAdSNnqIUCNUstffPYLtNUeSRkwhariwOFRk3OSVGgVS1
         Qo5faNi94awhV4dXM7iLntD5oQ9sVFKScEc+bQM/DsB3JOZBBrG9QGp0QagcfLqZ3X01
         PYiDLQ8uPJBBlsvzlJsTZZGDilZIChtjjgrLYFi9lFjEQCE3FXk/3SPRhM4acfcY9wVS
         dujqe/j9Nz44oQgJougokRY/0BdBu7QsnjOcPpVnLRYnGyA+K0EUbUp8H9Ed+/1xsE7p
         baow==
X-Gm-Message-State: AA+aEWZ13QUaeJEBGV7SFQKYeLaJqZhigLv+Iuiu8aGonz9Bsk3mqKqJ
        Nryn2rjnaXRB1tVYcMRbxWGsjFkWuHU=
X-Google-Smtp-Source: AFSGD/VrS9rzVDzjLs2IY5ktOjX1Z5gS+G7wJrOxApYEbk/6QLl0zvQeVDNR2/3AGpjNy6MJJjINow==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr5726599plr.190.1544276260032;
        Sat, 08 Dec 2018 05:37:40 -0800 (PST)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id k15sm10814432pfb.147.2018.12.08.05.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 05:37:38 -0800 (PST)
From:   Eric Dumazet <edumazet@google.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] iov_iter: optimize page_copy_sane()
Date:   Sat,  8 Dec 2018 05:37:35 -0800
Message-Id: <20181208133735.245799-1-edumazet@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid cache line miss dereferencing struct page if we can.

page_copy_sane() mostly deals with order-0 pages.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 54c248526b55fc498c996f2a5ea651262fcc7f61..2a1e282c3d38e2d03b075f54b7f9313e48b90289 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -854,8 +854,18 @@ EXPORT_SYMBOL(_copy_from_iter_full_nocache);
 
 static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 {
-	struct page *head = compound_head(page);
-	size_t v = n + offset + page_address(page) - page_address(head);
+	struct page *head;
+	size_t v = n + offset;
+
+	/*
+	 * Fast path if this is an order-0 page,
+	 * or if the copied area fits the first page of a compound one.
+	 */
+	if (likely(n <= v && v <= PAGE_SIZE))
+		return true;
+
+	head = compound_head(page);
+	v += (page - head) << PAGE_SHIFT;
 
 	if (likely(n <= v && v <= (PAGE_SIZE << compound_order(head))))
 		return true;
-- 
2.20.0.rc2.403.gdbc3b29805-goog

