Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B45C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643F321479
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJHmpJuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643F321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeJFJvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:51:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJFJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:51:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so811142pfg.3;
        Fri, 05 Oct 2018 19:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWVvB4KoMztN3RfvQsH7juqXZuH+ge8yGMOqZR0qLbk=;
        b=tJHmpJuj6//bePZPXlSMexP3IqebnIh82gjuaIdBGQuaf+VL86X7SZ15++gk3CwHPc
         2Fn1TDWsH+h/ITuZ02XSImb+GR0A0uCwdBO78ygB3cN1QcWg/2VrA0rrXYD57Vct+W+Z
         Oh+AdHlOZTPB7BOyRUPYT7yiqy7B/fNcYz4yQAH7E+QUJLifeYphwghxxU1ILUZbWRRD
         GmDYPJW+25ZQ/ItnugPeAOtjrwLrdHqTkJjdxvHcOcQvr4wA5HfglhdN2DwkJ9rXY864
         VIhUcMRVGLHKExqG60rKheeDiqQWTe818BUxDy45QzIcs/FYVwnoAtVxRPSNGTwO8GdC
         Sddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWVvB4KoMztN3RfvQsH7juqXZuH+ge8yGMOqZR0qLbk=;
        b=h7a6g6Npcf6D/XBzImyr2Bj/3IjMTN0b9alH5Q4jdpnQSobmoHh4P2lfQJT9fTEdLn
         Dyq7uoZfEvLQpQOUFcyoQRVQfbii/xSJy1gaLiIt7pYoCiFJJv1Q6fcR1uj5a7/wxNau
         Q1lLTe1IfT+OjAqNrMigbRxXvl/kjUscZ/GUEER9e35qoW88aBPtsqIKlmwZbTXaN6fJ
         9VWCgMWdNVUz9ZiFjF94ddoDPBjTgoAygdjmIGT1t9bSlhTpcj/vSnxOnPpctgj2fSq6
         YV5hpbEqcImPx2RBYPQFhXNFQyq7m68/13+SzZrubdkHnwjOzHo+FOgYyHr2yqzxt9D/
         AS+Q==
X-Gm-Message-State: ABuFfoggpRYDNc8ofJQszpX8za8Mg9Jfx1pP5QrIARItQCWHfET/MmtN
        c1i/eSVcarPSE/HwO6WSjyVxpTWl
X-Google-Smtp-Source: ACcGV62eipnqqwRNkNBaKJerrKmLONkG7QsEP58EDheoe5/H3eOzEMVP6KBDnMJ1U/aUATxVLfD/cg==
X-Received: by 2002:a63:1520:: with SMTP id v32-v6mr8273824pgl.150.1538794192307;
        Fri, 05 Oct 2018 19:49:52 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n63-v6sm3962785pfn.9.2018.10.05.19.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 19:49:51 -0700 (PDT)
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
Subject: [PATCH v3 0/3] get_user_pages*() and RDMA: first steps
Date:   Fri,  5 Oct 2018 19:49:46 -0700
Message-Id: <20181006024949.20691-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Changes since v2:

-- Absorbed more dirty page handling logic into the put_user_page*(), and
   handled some page releasing loops in infiniband more thoroughly, as per
   Jason Gunthorpe's feedback.

-- Fixed a bug in the put_user_pages*() routines' loops (thanks to
   Ralph Campbell for spotting it).

Changes since v1:

-- Renamed release_user_pages*() to put_user_pages*(), from Jan's feedback.

-- Removed the goldfish.c changes, and instead, only included a single
   user (infiniband) of the new functions. That is because goldfish.c no
   longer has a name collision (it has a release_user_pages() routine), and
   also because infiniband exercises both the put_user_page() and
   put_user_pages*() paths.

-- Updated links to discussions and plans, so as to be sure to include
   bounce buffers, thanks to Jerome's feedback.

Also:

-- Dennis, thanks for your earlier review, and I have not yet added your
   Reviewed-by tag, because this revision changes the things that you had
   previously reviewed, thus potentially requiring another look.

This short series prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2], [3], [4].

Patch 1, although not technically critical to do now, is still nice to
have, because it's already been reviewed by Jan, and it's just one more
thing on the long TODO list here, that is ready to be checked off.

Patch 2 is required in order to allow me (and others, if I'm lucky) to
start submitting changes to convert all of the callsites of
get_user_pages*() and put_page().  I think this will work a lot better
than trying to maintain a massive patchset and submitting all at once.

Patch 3 converts infiniband drivers: put_page() --> put_user_page(), and
also exercises put_user_pages_dirty_locked().

Once these are all in, then the floodgates can open up to convert the large
number of get_user_pages*() callsites.

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

John Hubbard (3):
  mm: get_user_pages: consolidate error handling
  mm: introduce put_user_page*(), placeholder versions
  infiniband/mm: convert put_page() to put_user_page*()

 drivers/infiniband/core/umem.c              |  7 +--
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++---
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +--
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++---
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++--
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 +--
 include/linux/mm.h                          | 48 ++++++++++++++++++++-
 mm/gup.c                                    | 37 +++++++++-------
 9 files changed, 92 insertions(+), 45 deletions(-)

-- 
2.19.0

