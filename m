Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1772C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794BE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYXR7vn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794BE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeKIQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40294 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so489285pfm.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=gAKYnJ5psk2wV1xt10r7KXfjHnI7pT+UXbJjL44QN3U=;
        b=jYXR7vn3Nw/+VXdHhvGo/sLIJaHz2d523S2IeKjiFe6o3APPcw72YcmOMprs+73KJC
         4Gun5Sz6ul+MLrEwzWP+1PpE/ZgqNXZL47pdkmtkndPeFvw9aKyGm7+TQ8nje2VVsfIZ
         rM9LNdxQmcUs7M/s/HGY0/3OFR2VDowKyod7jv1Ic8wjtnUXuD7RLfoOxKe8/8Mw4aHM
         iTRz+t6geXxbXuSc+iOFKJ2VSJuzh4Qzw5og1CkLnu4SY34ck5BpRjjO0TQ8s6iji5xo
         mBVJmlNuWGtCbqsWGixoecMazvMqlNZiHezthMrK6oNdip3miyjZDpPqxWzoDufX6XrE
         oZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=gAKYnJ5psk2wV1xt10r7KXfjHnI7pT+UXbJjL44QN3U=;
        b=CS/M3YqqJc0LQCAM8XnTIEeoYaULBByyqryBySxq0GqozFortkjVjXFtknGBknVCBc
         hhBQJa9Jye8aSjJadIQFiVYkYto3rwqGqjusBHlAcEOuvsAUAbrRBbhWqwVWgqj9msGw
         Kdr+9GnNcNserAfbcNwmmkXKNqJL5v6y9OeA3yy3aE+EnOEnhRuvkOzBiMc8scARJmYA
         9c8NzrdDXQSdQ8S9gdJc/PmQHFWQl27jAOiht9YJCxBtWOd98gpFriz0a8pTTiTSYK+F
         Yhf6NjC52uG9Fttvmz9HgwwXpg4Hb5v8k7OzkQVV54IB2Ea2J9I+QY+LtUb+soTeJ8nL
         N4KA==
X-Gm-Message-State: AGRZ1gKtckAcVMjhPQgY/6Of5YH9ZHnMNzRRZnkI/qzlqprYqvGyLdnh
        g8shZBWPIlmuaaixLYtUoEIYXdLpZw==
X-Google-Smtp-Source: AJdET5dEMRCoZJ4IGqcb0i1Vvnh8N1tjjhVNt2VOnZzGlUCkMAwwWBmM2J30oCd3tXVEiSNYNkLS2w==
X-Received: by 2002:a63:f960:: with SMTP id q32-v6mr6272013pgk.213.1541746048880;
        Thu, 08 Nov 2018 22:47:28 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:28 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH RFC v1 00/11] hwpoison improvement part 1
Date:   Fri,  9 Nov 2018 15:47:04 +0900
Message-Id: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I wrote hwpoison patches which partially mention the problems
discussed recently on this area [1].

Main point of this series is how we isolate faulty pages more
safely/reliable. As pointed out from Michal in thread [2], we can
have better isolation functions rather than what we currently have.
Patch 8/11 gives the implementation. As a result, the behavior of
poisoned pages (at least from soft-offline) are more predictable
and I think that memory hotremove should properly work with it.

The structure of this series:
  - patch 1-7 are small fixes, preparation, and/or cleanup.
    I can separate these out from main part if you like.
  - patch 8 is core part of this series, providing some code
    to pick out the target page from buddy allocator,
  - patch 9-11 are changes on caller sides (hard-offline,
    hotremove and unpoison.)

One big issue not addressed by this series is hard-offlining hugetlb,
which is still a todo unfortunately.

Another remaining work is to rework on the behavior of PG_hwpoison
flag from hard-offlining of in-use page. Even with this series,
hard-offline for in-use pages works as in the past (i.e. we still take
racy "set PG_hwpoison at first, then do some handling" approach.)
Without changing this, we can't be free from many "if (PageHWPoison)"
checks in mm code. So I'll think/try more about it after this one.

Anyway this is the first step for better solution (I believe,)
and any kind of help is applicated.

Thanks,
Naoya Horiguchi

[1]: https://lwn.net/Articles/753261/
[2]: https://lkml.org/lkml/2018/7/17/60
---
Summary:

Naoya Horiguchi (11):
      mm: hwpoison: cleanup unused PageHuge() check
      mm: soft-offline: add missing error check of set_hwpoison_free_buddy_page()
      mm: move definition of num_poisoned_pages_inc/dec to include/linux/mm.h
      mm: madvise: call soft_offline_page() without MF_COUNT_INCREASED
      mm: hwpoison-inject: don't pin for hwpoison_filter()
      mm: hwpoison: remove MF_COUNT_INCREASED
      mm: remove flag argument from soft offline functions
      mm: soft-offline: isolate error pages from buddy freelist
      mm: hwpoison: apply buddy page handling code to hard-offline
      mm: clear PageHWPoison in memory hotremove
      mm: hwpoison: introduce clear_hwpoison_free_buddy_page()

 drivers/base/memory.c      |   2 +-
 include/linux/mm.h         |  22 ++++++---
 include/linux/page-flags.h |   8 +++-
 include/linux/swapops.h    |  16 -------
 mm/hwpoison-inject.c       |  18 ++------
 mm/madvise.c               |  25 +++++-----
 mm/memory-failure.c        | 112 ++++++++++++++++++++++++++-------------------
 mm/migrate.c               |   9 ----
 mm/page_alloc.c            |  95 +++++++++++++++++++++++++++++++++++---
 mm/sparse.c                |   2 +-
 10 files changed, 193 insertions(+), 116 deletions(-)
