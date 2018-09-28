Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BEA21754
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+Kj425j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BEA21754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeI1MCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:02:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41759 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1MCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:02:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so3591331pgv.8;
        Thu, 27 Sep 2018 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mqzGKFVMjSnTLiDsAB/mdn2GuZtUkrT/vpmmy1PyQs=;
        b=o+Kj425jnKP42HZw2x4xeAHlUiUb3CZEXHJRcINqCsnanOWKoDQcrLtOmLskp9VWzI
         R49hevMHgx5Oqhb/KxZmZXFpqPT9XxjRA801Ch4IO4lGkq6dJWo7RJYA3OGLPLE/m1lX
         shbtgZkw25oR0DBx4bBOEJGoSX5PJRB+9UDhiPtUqQEOu73eqgHSAJOFFpEcOwOmH3Ng
         FkMF54STPwp6EWRRuKQ5s0l1a/DkGtmuQs9sspRRnxOXE7U790apW8hYjonhKa6WjS9J
         gPyxjdzkZCTp/NGZ4sftBnnibXaHKNMuTdlafDkkORRZmUAS0dWpdNFtDx1bU9ChbQe8
         Du1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mqzGKFVMjSnTLiDsAB/mdn2GuZtUkrT/vpmmy1PyQs=;
        b=Mf/DZj+XV8lBjl5JIbwZp0lC+bo+X1kIJz5V3WvgVwhM5UYyKaHOLnGpawYGNkEMz1
         5JeAHil8Ku65Uz5qge89Jith+OLIp6KKOK6zUwyvc8gLKBl9Y6loUL8pGp1auiSk3Jtw
         WIU/NQxVhPWMlm9jYa8KA62sCYQg+BYqqg8SKwo+nG+AElLOFkJH40FQWoydGkHY+kAQ
         jQG+uUQKfN0uCo15UCQY56Te0Bi+PRzczZDJlnknJYZFFIov3kWtapf8+lP/Qdf4ZHZ3
         n1tyB6D2ZpKnwvFLjp13U9V6/x0sqMXNC1OCJDrpCn2gbnDFPDkW/DnzFdf3zMf+DRHa
         ZF9w==
X-Gm-Message-State: ABuFfoi7nS0CYKAle7YBj0z6QqE4XqWbnVfBl+Oxl82dEGIacKxjA4Wt
        u/V6qa7VT3k8ct4N1UXs8p8=
X-Google-Smtp-Source: ACcGV63ypN7jtruDL64Blbt9oo1dr/8T7M2lG9FPtvldbr3uBAGfMxqPHuSYsSPqT8bCod53sR8lrw==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr13566667pgq.382.1538113200923;
        Thu, 27 Sep 2018 22:40:00 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u9-v6sm6569953pfi.104.2018.09.27.22.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 22:40:00 -0700 (PDT)
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
Subject: [PATCH 2/4] mm: introduce put_user_page(), placeholder version
Date:   Thu, 27 Sep 2018 22:39:48 -0700
Message-Id: <20180928053949.5381-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928053949.5381-1-jhubbard@nvidia.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
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

Also adds release_user_pages(), a drop-in replacement for
release_pages(). This is intended to be easily grep-able,
for later performance improvements, since release_user_pages
is not batched like release_pages() is, and is significantly
slower.

Also: rename goldfish_pipe.c's release_user_pages(), in order
to avoid a naming conflict with the new external function of
the same name.

This prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>
CC: Christopher Lameter <cl@linux.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>
CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/platform/goldfish/goldfish_pipe.c |  4 ++--
 include/linux/mm.h                        | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 2da567540c2d..fad0345376e0 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -332,7 +332,7 @@ static int pin_user_pages(unsigned long first_page, unsigned long last_page,
 
 }
 
-static void release_user_pages(struct page **pages, int pages_count,
+static void __release_user_pages(struct page **pages, int pages_count,
 	int is_write, s32 consumed_size)
 {
 	int i;
@@ -410,7 +410,7 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 
 	*consumed_size = pipe->command_buffer->rw_params.consumed_size;
 
-	release_user_pages(pages, pages_count, is_write, *consumed_size);
+	__release_user_pages(pages, pages_count, is_write, *consumed_size);
 
 	mutex_unlock(&pipe->lock);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8ad4ca..72caf803115f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -943,6 +943,20 @@ static inline void put_page(struct page *page)
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
2.19.0

