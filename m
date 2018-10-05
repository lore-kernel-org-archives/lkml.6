Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75BEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC992084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p93nkplT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC992084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJEK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 06:59:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37384 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeJEK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 06:59:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so4427372pfi.4;
        Thu, 04 Oct 2018 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpy3uRdvgiLxbv/YgQjmak7Z81EMHZur9/b3TrGMUZw=;
        b=p93nkplTtA6tZCC53ZjTadVbFpIsHdIjL0uoqbuTkiZwUt3J5jgFLhQUXXU5Xo5DTZ
         4QmW0z4w+zrn1KZhbAD749M0LreTUUr3c4ubr5ZcJscq7HHhzUDehG0EOZIvsFfDGSHv
         wJgr+iSh81Hu/CS5Y+v/niYJS6LOElPBT++LdgrGm1s2aM8cRRL6tcrQYzAawxeW8y9A
         gWjPhkEhCUJMwtkQ5EaoUbT+v58CtSD1BLtdduYkL6UJn+FX7w8Q7XTknZEeCBcpT+/0
         UVdK6zu4IfIpppS36PO9gwEv5oaMdxY5CW+WcOUtJvPTLTSf1WeZFqq6Nd5PRWrf+AIK
         SPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpy3uRdvgiLxbv/YgQjmak7Z81EMHZur9/b3TrGMUZw=;
        b=W8AJEWQJKgMPEy1wE2djI2Cw/mc4ZyZ76UTRFVvTi042BVFeoRQ2zvBxn/3TTeem6D
         WJ4EbVQYf3XsCga8Yg5iAeOuX68inYbdU9zlxlAoQtF18H6iw3/34JnrjawM9jqe+flP
         s/uED1qZzFIWi+J1bRhruS+imQedCsiGk7iPHJt+ViX3rSqYAKCvYK/v1K7J+Ejp7lBO
         NcloPs0C3PbkZKrqI/2q3Yd7VV13OrkQRIp4lg+iagGTTLAACKsgSNAMTeamnvU+nHe4
         cqxlg9asrp9l0MGJZPEBHUiShr8L7P4LfW0bHxvesAiNmxCfoHnnA6nTpEvLt7U88ine
         zvxQ==
X-Gm-Message-State: ABuFfojE817xyjNLfkqxZbP6sR4bnVFiV7faVW897Tn5urks7dUHteWS
        gJx4m+fSMGCbYgsnFto4eZo=
X-Google-Smtp-Source: ACcGV62l3n29YLfALugf7Vi9Tv1UF9h4fGcEIWLYU55CJIFvow7jO0eMlu/+4IqvnEOTAnTfVE9Znw==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr8408003pge.69.1538712148634;
        Thu, 04 Oct 2018 21:02:28 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8787899pfo.107.2018.10.04.21.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 21:02:27 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/3] get_user_pages*() and RDMA: first steps
Date:   Thu,  4 Oct 2018 21:02:22 -0700
Message-Id: <20181005040225.14292-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

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

I'd like to get the first two patches into the -mm tree.

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

John Hubbard (3):
  mm: get_user_pages: consolidate error handling
  mm: introduce put_user_page[s](), placeholder versions
  infiniband/mm: convert to the new put_user_page[s]() calls

 drivers/infiniband/core/umem.c              |  2 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++----
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +--
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++----
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++--
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
 include/linux/mm.h                          | 42 ++++++++++++++++++++-
 mm/gup.c                                    | 37 ++++++++++--------
 9 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.19.0

