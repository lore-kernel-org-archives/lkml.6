Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A413C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CEB21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu7f+CGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CEB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJIEaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:30:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJIEaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:30:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so8947461pfi.1;
        Mon, 08 Oct 2018 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SwmFY4jXs0sJ3RkahlBQalMCCI13w3vJK/FnRSX15g=;
        b=Mu7f+CGYuavAm6LT3wKt2q3gupspRXJ9W9dzlGI8FXame7/UARagjYP+NiNdgstmGN
         R78sSogaAPABWfNqZpIb4gX4JZQ/fZBLD1hUhL93SDL4wB6kRPzOSXuR7x/5wudfbkcz
         KEit7dbY1CUdnzaSAQCAYW5gYIg1HrCrERGIzCF72G26wazkL8GyZRQiHaU0xKn7whq+
         weben2m+iQ8Oy36RAOdLrzB1zQZEdaKQa53Hsf7UBrygnF2/FSh1msVLdaeyBd/TkvsY
         JiO+ldDgbTyIgFtGVx74zsS2Zmro22M2yOwJHbmja/jTuaQSZbIeEZcEnVfCq74WxHtc
         pFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SwmFY4jXs0sJ3RkahlBQalMCCI13w3vJK/FnRSX15g=;
        b=TNsnrtAuSmUJU2LnJetmO+UV4Oqagff3mZ5wJkb0GdXawZFc64TA8pkKz6TmqKLDHK
         lZ2mWAtCkF6AwtKguyljR4m5olOwCfOeMA/M1ldo/XDBbJVZORpyjEsV/Pc84qyRTSen
         3lzHuvdqX5bkrX3Ltb838jpblcNsyr4OCAajPVbtdKyyeJCpyRed/WOahb8bok0gCwhT
         2nPxPNjVhmvGBMYs9d4MUkiOgcswdi8hCoXx9fa5At4HB/xAQjCnnm7P9Z6j2QR3otMX
         mvXmXDD57SKj1QRyBApts+Z+pfFefsYD+y8gZaY4dEMG1j3Q17WHwun7WC1pw94ROzaM
         E+xw==
X-Gm-Message-State: ABuFfojBHjhGV9kafyE9PqZN7xIG8LQiFiasnCJyRPFE6yyb2BDLZiI1
        J/A7My2oASgw7c2Cg3t8j8E=
X-Google-Smtp-Source: ACcGV62nxj2SeoUr3i/lvPLCL4XiL6oJYEDBIBIRp6r4C8vQ+mqDba/yODkRcqzVMN+L9V3KsmYtaw==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr22057024pfs.6.1539033388744;
        Mon, 08 Oct 2018 14:16:28 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id w127-v6sm23480045pfd.112.2018.10.08.14.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 14:16:27 -0700 (PDT)
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
Subject: [PATCH v4 0/3] get_user_pages*() and RDMA: first steps
Date:   Mon,  8 Oct 2018 14:16:20 -0700
Message-Id: <20181008211623.30796-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Andrew, do you have a preference for which tree (MM or RDMA) this should
go in? If not, then could you please ACK this so that Jason can pick it
up for the RDMA tree?

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
CC: Andrew Morton <akpm@linux-foundation.org>

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
 include/linux/mm.h                          | 49 ++++++++++++++++++++-
 mm/gup.c                                    | 37 +++++++++-------
 9 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.19.0

