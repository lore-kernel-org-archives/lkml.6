Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6377214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e55gI6uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6377214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJJLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:31:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42873 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:31:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so1843278plo.9;
        Tue, 09 Oct 2018 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OThfs9gTp8nLAyWxORo0ukTHPLMOg7oirp7jiTbaqXc=;
        b=e55gI6uXDZRJu5wByFLCiD/EBOL/1Y/7KHDanwKVLv+UiMSwIoAnjQqTZItMb7InCo
         2Hf0WyW0UixP8IFBQNLnD+a+T7xHJ8NfxSMQTn7QAsqRUSDps2uC2+yRWWmfApWPlrzH
         NBHk5EGaff9Skl/Ep8AW5rJi23juI+jTr1HrTneI+3Exmo7VJKwcmBIk1V33/meUx2bx
         VkyIWBazF+Jzfcud6G17hedVBCujEL5xnAZLYvGzl1h8473Qar56MozL+bDiZg3Ncarf
         xYCzv93DMBQJGXPpL7imPLV20eDIZUIjIbytgxbZlapkU8jDGNKZgW/Lr756B2p99WE8
         KJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OThfs9gTp8nLAyWxORo0ukTHPLMOg7oirp7jiTbaqXc=;
        b=FV3pUhNrSUV3v7TGSD6XgRw2Tr2tEttHaOqhwYQxltF2w/Za4lbeDkTgw4A0pRB/Pj
         UM+uvPVxjeE+5XgoIU70OyvlXNIfHW92txKp1/3HOdtNI2uoEeBa42g5205CQ3lJkUTp
         +10W87NPWc/0wQjgNnif5HP3bEsSVR0CjqDFHq185qTu23C81NRnw/anO77hPIxMGcIC
         /fvN6a+HKiniLPX+Rh0jzUzi/+IAXPybNOwQ+2T4ix6U+j2B2fWmzAlOGQH0XGMyXmMK
         4r9IUqiGdtvtrUAlK/zYZBWhijewz7yttAr9vJh5+n1NKYUqtFCf1fmRWoO8uf8Ew3qV
         nTBQ==
X-Gm-Message-State: ABuFfohxNw/IfBEsFQK+222nK3wvQd2kjLJmrLNrkMWJ8HUQCygWaO7F
        qFcHAfZ1c4hi96B7zL+GHOv+KeaT
X-Google-Smtp-Source: ACcGV60GCLeVx4ll/Xj49TN6guZrZtUqkGevilQ5VFCObeif6PyT390v+BNp0NHcEKNaONzBzcMyxw==
X-Received: by 2002:a17:902:8648:: with SMTP id y8-v6mr31976080plt.335.1539144700765;
        Tue, 09 Oct 2018 21:11:40 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o133-v6sm50045619pfg.86.2018.10.09.21.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:11:39 -0700 (PDT)
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 0/3] get_user_pages*() and RDMA: first steps
Date:   Tue,  9 Oct 2018 21:11:31 -0700
Message-Id: <20181010041134.14096-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Changes since v4:

-- Changed the new put_user_page*() functions to operate only on the head
   page, because that's how the final version of those functions will work.
   (Andrew Morton's feedback prompted this, thanks!)

-- Added proper documentation of the new put_user_page*() functions.

-- Moved most of the new put_user_page*() functions out of the header file,
   and into swap.c, because they have grown a little bigger than static
   inline functions should be. The trivial put_user_page() was left as
   a static inline for now, though.

-- Picked up Andrew Morton's Reviewed-by, for the first patch. I left
   Jan's Reviewed-by in place for now, but we should verify that it still
   holds, with the various changes above. The main difference is the change
   to use the head page, the rest is just code movement and documentation.

-- Fixed a bug in the infiniband patch, found by the kbuild bot.

-- Rewrote the changelogs (and part of this cover letter) to be clearer.
   Part of that is less reliance on links, and instead, just writing the
   steps directly.

Changes since v3:

-- Picks up Reviewed-by tags from Jan Kara and Dennis Dalessandro.

-- Picks up Acked-by tag from Jason Gunthorpe, in case this ends up *not*
   going in via the RDMA tree.

-- Fixes formatting of a comment.

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

This short series prepares for eventually fixing the problem described
in [1]. The steps are:

1) (This patchset): Provide put_user_page*() routines, intended to be used
for releasing pages that were pinned via get_user_pages*().

2) Convert all of the call sites for get_user_pages*(), to
invoke put_user_page*(), instead of put_page(). This involves dozens of
call sites, any will take some time. Patch 3/3 here kicks off the effort,
by applying it to infiniband.

3) After (2) is complete, use get_user_pages*() and put_user_page*() to
implement tracking of these pages. This tracking will be separate from
the existing struct page refcounting.

4) Use the tracking and identification of these pages, to implement
special handling (especially in writeback paths) when the pages are
backed by a filesystem. Again, [1] provides details as to why that is
desirable.

Patch 1, although not technically critical to do now, is still nice to
have, because it's already been reviewed by Jan (and Andrew, now), and
it's just one more thing on the long TODO list here, that is ready to be
checked off.

Patch 2 is required in order to allow me (and others, if I'm lucky) to
start submitting changes to convert all of the callsites of
get_user_pages*() and put_page().  I think this will work a lot better
than trying to maintain a massive patchset and submitting all at once.

Patch 3 converts infiniband drivers: put_page() --> put_user_page(), and
also exercises put_user_pages_dirty_locked().

Once these are all in, then the floodgates can open up to convert the large
number of remaining get_user_pages*() callsites.

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
CC: Andrew Morton <akpm@linux-foundation.org>

John Hubbard (3):
  mm: get_user_pages: consolidate error handling
  mm: introduce put_user_page*(), placeholder versions
  infiniband/mm: convert put_page() to put_user_page*()

 drivers/infiniband/core/umem.c              |  7 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 +--
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +-
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 +--
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 +-
 include/linux/mm.h                          | 22 ++++++
 mm/gup.c                                    | 37 +++++----
 mm/swap.c                                   | 83 +++++++++++++++++++++
 10 files changed, 150 insertions(+), 42 deletions(-)

-- 
2.19.1

