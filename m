Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96229C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644620890
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwIJgKrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4644620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeGIIGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:06:38 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35335 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeGIIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:06:34 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so6855541ybm.2;
        Mon, 09 Jul 2018 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7S1uPsIr5ADBgcsgfQb4AMK/6T1OOwRBEXslU8sjZiY=;
        b=kwIJgKrE0YOzuOXJvBG9U+xP5LxBts9K2k1ZRAtY7CcW2slMAlN9pAHZNx3DVtl2DO
         JHc3YYglBOk4Ykw59UIzu6vxs/x0yut94bXwKpr9aIXZ4eAS+lsMtg59+59rc2j0gOAZ
         yVsxwMKVZfqcv3lIy/SNOugOgFo1xBEZiiWCpAfhAq6fWaDioArMnRwZ3630405WV0M6
         v4DxPqMAe/Zn+JX14cCtubT0ecuciRTlUTJrrN5Pet++Glk+OdZyDDU9IM1jBRoajjQE
         uGx+aqgKYTQJ8EsbQO0WcxtZHMPDoJ4X5uMZgOkW+syh//s3DAvCPgAOBAINP99ZvsaJ
         bvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7S1uPsIr5ADBgcsgfQb4AMK/6T1OOwRBEXslU8sjZiY=;
        b=QV7tgkdxo6AQWYpKggzJR5ywV9LdxfVd4yGP4uyysQPUxEOab4tLPes0f+HExRFW1x
         zvuZDSSk/PxfPQq2PgSkxrIM81lZ8NzcNTq2DuMTlJLrctEkX35/iHu/4DaqBCRM5uKi
         Zi9PKGTye4Flv2pv70yVTRLuivMf2hGDwdmsmnv9zcahJP61J6NxbUFob/oSvsb6uMK0
         oPQ1ji96yLJU4KKe0wQGhBfN5KIcgYQIFxl5aUW5SXvwo95dxYEzT85pQQUNvjF5aTFk
         ZO/uQU2YJ8F9A4laVjIQiknb6/r4UexcHHrLhyXQKK5AFGh/lOiHrAfiHvQ1SyugTAgH
         cnoA==
X-Gm-Message-State: APt69E3SXVUn/dPgRSZ9empf2zOoJMxfK/YyjJHUEFr4Qxgo7u7WBKtR
        XZN7CxGlaqzXOZSuACO6WObwlg==
X-Google-Smtp-Source: AAOMgpcPEHeVirfQm8JXNox+KWiLSEVztBX+fVQf/b7dx2Q+QbR9+nSiNbcyUsQ/BCM2ZmrAGPXz2A==
X-Received: by 2002:a25:403:: with SMTP id 3-v6mr10679430ybe.396.1531123594044;
        Mon, 09 Jul 2018 01:06:34 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id w64-v6sm6339514ywe.46.2018.07.09.01.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:06:33 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] mm: introduce put_user_page(), placeholder version
Date:   Mon,  9 Jul 2018 01:05:53 -0700
Message-Id: <20180709080554.21931-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709080554.21931-1-jhubbard@nvidia.com>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Introduces put_user_page(), which simply calls put_page().
This provides a safe way to update all get_user_pages*() callers,
so that they call put_user_page(), instead of put_page().

Also adds release_user_pages(), a drop-in replacement for
release_pages(). This is intended to be easily grep-able,
for later performance improvements, since release_user_pages
is not batched like release_pages is, and is significantly
slower.

Subsequent patches will add functionality to put_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..db4a211aad79 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -923,6 +923,20 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
+/* Placeholder version, until all get_user_pages*() callers are updated. */
+static inline void put_user_page(struct page *page)
+{
+	put_page(page);
+}
+
+/* A drop-in replacement for release_pages(): */
+static inline void release_user_pages(struct page **pages,
+				      unsigned long npages)
+{
+	while (npages)
+		put_user_page(pages[--npages]);
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
-- 
2.18.0

