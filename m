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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED5C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50926216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDNixGuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50926216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeI1MCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:02:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35717 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1MCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:02:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so3615562pgb.2;
        Thu, 27 Sep 2018 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTxV0aWUbi8aFwYtgG+7uDbNGSrkpXx/JtqQLR1W0X4=;
        b=bDNixGuJlh/VViGK/IVdrd2Ya6UuePjmCtcsgKK/3jykSPzSHwUVjRr32fbM/h5Eu1
         aWG7kNjNxKOjioZ+vW8NhCUe4/AWHvUKE+sTbc3smgAHTt2Mp1w3R3VVwRQwLhQ3upp4
         z345xOHYP0aevKOufhDJEUGR/aRHBPJXIruZc5zPLn0NiTAHFetIb+GInBNx5Sked+RL
         tQmMg7HH66UETFNKv4JaGPH4Qfp2ag0aQwKy08qRSMys5TZw49jJf7/sQ2I6+era5G/Z
         Xnq3phaDVdsUDxIIQGQBKEDA8pNMdbl423L7RDkgYp5PhTSIB39uPk+cEli7RbXh2qHf
         68Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTxV0aWUbi8aFwYtgG+7uDbNGSrkpXx/JtqQLR1W0X4=;
        b=VJ1A2PO6bkoMqs9hwyB4oaZIcBRsnj5knWPd/OuXJEfuABfBRR/vgcH4ofPDwtXWWh
         YO7dJ3VtHAupxGerOSDPlgxig3UuZoVeJjDxG581cHY7dryO+1mf3QYYaRN3rkaPMKvK
         qdyRoHyf27eZriSE+0asiUIL3J4SDzbU06zVBU1i0csNT/1BGSVJyG2NvMTnQnWjZjf8
         GyjnIHbAsPwFP6KyV81XEAXwh2ywAtKFcbPKLkxoq622b3He+yPePvx4QNNtGQw3d404
         C5v0JwhbonLd+DZkF7OobPGIYmjvQJcEBEhwhV3BwWgnpCiOlKKg+x3UuKUp9Fq7s6gr
         ljmw==
X-Gm-Message-State: ABuFfoglYAdJn6JwY1/oCrZv75jOXocLu66VUp9lnfiJ6f2CGBII4V2N
        9BBoZvLn/blsP+zu/gr4CRg=
X-Google-Smtp-Source: ACcGV63rxOc0Wx8ndnvvnZLm+cbC7UMeUJ/O4wKjbN4LjtpvySOpDGyJ7dXg2lbQNGsJNDt27t9iSg==
X-Received: by 2002:a63:531a:: with SMTP id h26-v6mr8070623pgb.441.1538113202538;
        Thu, 27 Sep 2018 22:40:02 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u9-v6sm6569953pfi.104.2018.09.27.22.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 22:40:01 -0700 (PDT)
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
Subject: [PATCH 4/4] goldfish_pipe/mm: convert to the new release_user_pages() call
Date:   Thu, 27 Sep 2018 22:39:49 -0700
Message-Id: <20180928053949.5381-5-jhubbard@nvidia.com>
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

For code that retains pages via get_user_pages*(),
release those pages via the new release_user_pages(),
instead of calling put_page().

This prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index fad0345376e0..1e9455a86698 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -340,8 +340,9 @@ static void __release_user_pages(struct page **pages, int pages_count,
 	for (i = 0; i < pages_count; i++) {
 		if (!is_write && consumed_size > 0)
 			set_page_dirty(pages[i]);
-		put_page(pages[i]);
 	}
+
+	release_user_pages(pages, pages_count);
 }
 
 /* Populate the call parameters, merging adjacent pages together */
-- 
2.19.0

