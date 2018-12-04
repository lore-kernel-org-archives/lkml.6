Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A07C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E232146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm+E9p5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E232146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLDAR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:17:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38383 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:17:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so7317532plb.5;
        Mon, 03 Dec 2018 16:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1x1cDnNOHkq9POIl9mXSqKMvWtsGgpET723VS8Rjac=;
        b=Wm+E9p5AFCOlYOW8Ir9ld4/uLPX1bcqHWw6w6M0uA0Wz5wMFqmERF0q6z5dKG0gkbe
         TSVBSHVYMATmNHqIs6PdnYDjVpy/FiMC4m/DnXxhKN9xQ8QxyFhcUkT8E8DkWjX8cSPD
         NaXrtoTFIX5vORNwcuuN2+G3dSGNc3hUUhDiTa6jjrrRLCCZlCtwmw/uUlOgs0g+CtQU
         ibma0Fq2nxaNbEQbOM23UwwkNr6kkl35/+Ixait/Qyi7tZSqQ/0SsXLLO9HPJIOiTPvQ
         1G1mifXzH1zd3E0jPNafw2ko1EDoDVc86SHaEGCR6pe5vmmnwIaS7AaLrfr6U+ZqFl/x
         zZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1x1cDnNOHkq9POIl9mXSqKMvWtsGgpET723VS8Rjac=;
        b=Fc+MNgR4JmFT7BfFFrI+bMKFMNSdOoindh0hOlY2vFKKigq7T9/jNcQNC4/AAsx8eB
         r0rEPukkODEUDxyUrsiebeXnZHOBV4n0a2IJM03MCs2bQIxvpHUalsUc3CDFSpM8scW+
         f4i8DXwgc8YqfpKMcnstzJIGDt3+J+WrD9tnd45OEUQJVeGhVRmk69ddC068MsPdnBcY
         DuyTzkRUi0uduL/sVyNlXfoX75VaYRHxdSorphNoApfCM0DzWvUafwAEHIUAEkuUagru
         gxT69tSUGEYNLep2G7DFbMaalPOnJGd+k2A0mTzM14L4IA29rRrIVBHYvpGDsN/GGMvT
         /biA==
X-Gm-Message-State: AA+aEWY+73YQm/ZeOLs3xLqy8EGBNe6e21Xd+XQ9bqA2g1eMRQZcCP4V
        gamK+Vk86MwnHGIqYr1NAos=
X-Google-Smtp-Source: AFSGD/VxNQuEAyVjgUOpyeC2Z31zrY9GHQ9yIwGJExOAvLnS4yTkAOWE9pj6BXTj7ufoaNU3aaCmIA==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr17769720plc.220.1543882645453;
        Mon, 03 Dec 2018 16:17:25 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y12sm21733332pfk.70.2018.12.03.16.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:17:24 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] put_user_page*(): start converting the call sites
Date:   Mon,  3 Dec 2018 16:17:18 -0800
Message-Id: <20181204001720.26138-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

Summary: I'd like these two patches to go into the next convenient cycle.
I *think* that means 4.21.

Details

At the Linux Plumbers Conference, we talked about this approach [1], and
the primary lingering concern was over performance. Tom Talpey helped me
through a much more accurate run of the fio performance test, and now
it's looking like an under 1% performance cost, to add and remove pages
from the LRU (this is only paid when dealing with get_user_pages) [2]. So
we should be fine to start converting call sites.

This patchset gets the conversion started. Both patches already had a fair
amount of review.

(Tom, I'll add you Tested-by to the actual implementation that moves
pages on and off the LRU. These first two patches don't do that.)

[1] https://linuxplumbersconf.org/event/2/contributions/126/
    "RDMA and get_user_pages"

[2] https://lore.kernel.org/r/79d1ee27-9ea0-3d15-3fc4-97c1bd79c990@talpey.com

John Hubbard (2):
  mm: introduce put_user_page*(), placeholder versions
  infiniband/mm: convert put_page() to put_user_page*()

 drivers/infiniband/core/umem.c              |  7 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++-
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +-
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++-
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 +-
 include/linux/mm.h                          | 20 ++++++
 mm/swap.c                                   | 80 +++++++++++++++++++++
 9 files changed, 123 insertions(+), 27 deletions(-)

-- 
2.19.2

