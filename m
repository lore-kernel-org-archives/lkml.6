Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012E2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVvx/jX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012E2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeI1MB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:01:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36917 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeI1MB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:01:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so3515276pfn.4;
        Thu, 27 Sep 2018 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2hgA74dPm3XPw9UsKR4RfXplU0BnJxwDgszRzFnK00=;
        b=OVvx/jX6uKzMr3lAfwsb+GdhgB6MOtjKb+gpZh/1ZI24JzMhAp7kDuizQhS2Mhq7Jl
         x8lSPu730dibmQ3OaR+3zfUzulqfuOpaDfdFhC+GlXjtdnwVJ/XqJHiRzhV2u59SYPyp
         AKAGGB9wl/DuRR4YZz1EsuJg37SGwsfrEG3gycKimsojadRzzSYVVJelP1Hf2gJPx3Ff
         WXpuiIWe4ZQqzCHcSFDxA33GzrZWvMawMhTMfoKwbrLl0UTqwjn/9jIpR2OH3hHSe/xT
         Gr/SIVx8NQtJQnlTDH3G3T/GS/4sgqAQw4UaqqMa6rbIStpXD0BlBGTDCl1dxn4opvrt
         A0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2hgA74dPm3XPw9UsKR4RfXplU0BnJxwDgszRzFnK00=;
        b=hubF289ilatE7UBbqItw1iBUQ363fzKahCEB6BzBzSz8OCiUYdQokUZclevHGCxrSn
         ujKNnB3NxMYHp1qa6iisKfEdG9Na9xIxo0olqhGMFdz4USEwDxayBGa/HTWJV5yiI2Je
         PfU15xBffClJP40N0n1X+v8zlbYXOXiOELPjmBXvG6OJ1URfUgkf5JpSbbu0uluzJlvy
         EutP4B9gdUeo4sI5ceqGgnV6G39zOdrfSwqdB+761/1FBb0f2kUm9sP8rfe5WcwTs7S4
         1dmgrMhhCsa0k4N9GQgnUpAj1QfUaZ6bJvz2uZaYdy6o7oDJ3Kg0rO0joyLCTqgU0fhf
         xvZA==
X-Gm-Message-State: ABuFfogAfFqefrzQ6qr7A6hDDXn1/ymTm+SgHb7ZrylC5bs4HHyGfvsS
        VYKz2OQ67g2wGIryvRnxems=
X-Google-Smtp-Source: ACcGV615AdD9uMz04n0+3UqNEVDhQvipc1wOoOB6NO9M3+iYIULVpxLKfCsncwcXF0mr+02dvHr8nw==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr13079669pgc.351.1538113196128;
        Thu, 27 Sep 2018 22:39:56 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u9-v6sm6569953pfi.104.2018.09.27.22.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 22:39:54 -0700 (PDT)
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Date:   Thu, 27 Sep 2018 22:39:45 -0700
Message-Id: <20180928053949.5381-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

This short series prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2].

I'd like to get the first two patches into the -mm tree.

Patch 1, although not technically critical to do now, is still nice to have,
because it's already been reviewed by Jan, and it's just one more thing on the
long TODO list here, that is ready to be checked off.

Patch 2 is required in order to allow me (and others, if I'm lucky) to start
submitting changes to convert all of the callsites of get_user_pages*() and
put_page().  I think this will work a lot better than trying to maintain a
massive patchset and submitting all at once.

Patch 3 converts infiniband drivers: put_page() --> put_user_page(). I picked
a fairly small and easy example.

Patch 4 converts a small driver from put_page() --> release_user_pages(). This
could just as easily have been done as a change from put_page() to
put_user_page(). The reason I did it this way is that this provides a small and
simple caller of the new release_user_pages() routine. I wanted both of the
new routines, even though just placeholders, to have callers.

Once these are all in, then the floodgates can open up to convert the large
number of get_user_pages*() callsites.

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Christian Benvenuti <benve@cisco.com>
CC: Christopher Lameter <cl@linux.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Dennis Dalessandro <dennis.dalessandro@intel.com>
CC: Doug Ledford <dledford@redhat.com>
CC: Jan Kara <jack@suse.cz>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>
CC: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org
CC: linux-rdma@vger.kernel.org

John Hubbard (4):
  mm: get_user_pages: consolidate error handling
  mm: introduce put_user_page(), placeholder version
  infiniband/mm: convert to the new put_user_page() call
  goldfish_pipe/mm: convert to the new release_user_pages() call

 drivers/infiniband/core/umem.c              |  2 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     |  2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 ++--
 drivers/infiniband/hw/qib/qib_user_pages.c  |  2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++---
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
 drivers/platform/goldfish/goldfish_pipe.c   |  7 ++--
 include/linux/mm.h                          | 14 ++++++++
 mm/gup.c                                    | 37 ++++++++++++---------
 10 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.19.0

