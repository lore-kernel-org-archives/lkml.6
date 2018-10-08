Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4357AC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05A7213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDiPneiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05A7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJIEaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:30:16 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46389 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeJIEaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:30:15 -0400
Received: by mail-pf1-f180.google.com with SMTP id r64-v6so8906434pfb.13;
        Mon, 08 Oct 2018 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+/+jNVpClYYrnYjCdSDtQ5UKgPHQ1Yc+3CgIrq50RY=;
        b=fDiPneiU/6UFz4R1QH02YqIZ/WkPKzDaTlQBxArt122EPNQPQYe4k7I1BgXBoCy2GD
         lwGKE4fvsonhnvALxgDzpzKa+knf/mDwOmhcxMOUZFQleSGrUph4kP9ikUoeuzXa1pgG
         l6PvBcAfRFP9PAnChf6HEO+OC2eX4jHLobh6tjlfqZprgJFMQfKOGGA8mG1EeDgMQT/F
         TVXl79hARghB+r/3ifEnjmfbSWj1NykpxiSAyCSCPuu7M2ynO8ihcGovbvtBqaHKTsBL
         rT95UgYUYRvMTz8cnXjJobWnwkB+S1ibUPXLW7L8AB9f9Q44JiBE1kLNifQTKsmFFftJ
         joNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+/+jNVpClYYrnYjCdSDtQ5UKgPHQ1Yc+3CgIrq50RY=;
        b=ITve0nVXzbgrqRoP66AL8/smS/KO1ke8e869RDGBMXMEZx4qXvGnZRXft+p8VTmYW2
         s/ZMAjStLA0K93Plpo3TKQs0bAO0ksyptcKJYWflOEssv36W3X9KykTxcEnxhk3QXD/s
         VSpZKEhUk51/KMtVurUYBFOGENHFDrHnAoHMf/kvjBd/awrxYiF9maWGAjeIxV6DOl1J
         hpqULfwk/4UcxK48yNAUXwHxwN2HSe7AwDbH8kP/gx8TnWi1u5btuN/8X1Ci82Pcx/N3
         B8IvI+yyeYUFw8vlYY1M8hQdWtcZlS/5zmFmwwtyN6/+KP5kJi94k9+Z2qDYI0rnxN7q
         D0iw==
X-Gm-Message-State: ABuFfohRYkP7/Rtih75nVRs5mX6zZZh24Zm2nwT3GNrthWEG5UQgqFty
        aTJc3ThNGmopgc51XjdU4y0=
X-Google-Smtp-Source: ACcGV63PCOzCN2MG+rT/XCxcvCW40Ear5HyFZydHxWNbKohKjbyv4gWznSz60IpepE+x+bqWyt8Z5w==
X-Received: by 2002:a62:1655:: with SMTP id 82-v6mr26623699pfw.11.1539033393061;
        Mon, 08 Oct 2018 14:16:33 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id w127-v6sm23480045pfd.112.2018.10.08.14.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 14:16:32 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder versions
Date:   Mon,  8 Oct 2018 14:16:22 -0700
Message-Id: <20181008211623.30796-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008211623.30796-1-jhubbard@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Introduces put_user_page(), which simply calls put_page().
This provides a way to update all get_user_pages*() callers,
so that they call put_user_page(), instead of put_page().

Also introduces put_user_pages(), and a few dirty/locked variations,
as a replacement for release_pages(), and also as a replacement
for open-coded loops that release multiple pages.
These may be used for subsequent performance improvements,
via batching of pages to be released.

This prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2], [3], [4].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

[3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
    Bounce buffers (otherwise [2] is not really viable).

[4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
    Follow-up discussions.

CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>
CC: Christopher Lameter <cl@linux.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Jerome Glisse <jglisse@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>
CC: Ralph Campbell <rcampbell@nvidia.com>

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 49 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..0490f4a71b9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -137,6 +137,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
 extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 				    size_t *, loff_t *);
+int set_page_dirty(struct page *page);
+int set_page_dirty_lock(struct page *page);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
@@ -943,6 +945,51 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
+/*
+ * Pages that were pinned via get_user_pages*() should be released via
+ * either put_user_page(), or one of the put_user_pages*() routines
+ * below.
+ */
+static inline void put_user_page(struct page *page)
+{
+	put_page(page);
+}
+
+static inline void put_user_pages_dirty(struct page **pages,
+					unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		if (!PageDirty(pages[index]))
+			set_page_dirty(pages[index]);
+
+		put_user_page(pages[index]);
+	}
+}
+
+static inline void put_user_pages_dirty_lock(struct page **pages,
+					     unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++) {
+		if (!PageDirty(pages[index]))
+			set_page_dirty_lock(pages[index]);
+
+		put_user_page(pages[index]);
+	}
+}
+
+static inline void put_user_pages(struct page **pages,
+				  unsigned long npages)
+{
+	unsigned long index;
+
+	for (index = 0; index < npages; index++)
+		put_user_page(pages[index]);
+}
+
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define SECTION_IN_PAGE_FLAGS
 #endif
@@ -1534,8 +1581,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb);
-int set_page_dirty(struct page *page);
-int set_page_dirty_lock(struct page *page);
 void __cancel_dirty_page(struct page *page);
 static inline void cancel_dirty_page(struct page *page)
 {
-- 
2.19.0

