Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7ECC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C30320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcjDolYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C30320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeIKEkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:40:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43701 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:40:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so11238023pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Yw9vxWJ6YGklpxQJwQlNRm6osFUbXs3EZVyomclg/uU=;
        b=bcjDolYst6bXqjaW2RF8VHS4mSuZOYlLSSbZ6BmoiNT0YAd2yOI5U3yIwRYQA+ds82
         uYAX3p/rJJTc3cM1WNxmUAIGs378sHp/YuIBRuQKfhv6+jSga3YCYPcHBX8jX1GWkJYX
         DkHdoSOk1DIV4T8Xx9WGiGb8LqEmVXpld9UbgbhfgAgOd+j5u5eo9+j0I1PHPoZP190C
         1+tCDBUsj73eqWH6dUM18zs5q+BaIDG5jmZd28uH8dJi30iCMr28MMUuxTsIlukpdfId
         VNfGa11mwN3fGGZ/W6LcU4slqG+ywFzP2FgE98tU81ta3isMFZi86114mNnIUuIDggK1
         vArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Yw9vxWJ6YGklpxQJwQlNRm6osFUbXs3EZVyomclg/uU=;
        b=PdGk5AcYuuHjUED3PjWUU3QmIBGppMOqsgcQz7f21X+4iC6sFscnLRcMdykLaZCh9p
         2xNYf3+lystFdZeYY9Bh9pGjzcsMjUN/S5/dTKADTpL7PzKV0+zZVeCAPVI3od0tDaZ6
         6SjBDrDU47MV1qQFeMZiGZnwVYPaaBD1CQbfmnZN6s62hpPPV/CHd8yJPyyEfB6Ug2Ho
         GcZ9vEg2VCf9gAJOY1m4N+ietaKjSV/f5zaJzWFAQKGRZNsr8ruEO0WICjqfDdEvhpIl
         6f9e7lEd/LU3mFDgXxmVd/+K3EdJAJIMlIYHrTVUqsTqqrSCRvRreZt01Ke31Ln6+Jqr
         oMtg==
X-Gm-Message-State: APzg51BAvsFGR1ym7fT1ew1+S/aIT04PsKAetwjXJ9QAhYqrnqMpVKtD
        Kt/qa1jCntU2+cMm+jAdfFQexXcX
X-Google-Smtp-Source: ANB0VdaYs/qwPckOqIjVc/MF9qQPl75UPWohNaI8P/32wDdPVKiG2ZTn76uNfSuuQoMVnCuOBlIxiw==
X-Received: by 2002:a63:d90b:: with SMTP id r11-v6mr25397961pgg.315.1536623016848;
        Mon, 10 Sep 2018 16:43:36 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id 16-v6sm27924027pfo.164.2018.09.10.16.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:43:36 -0700 (PDT)
Subject: [PATCH 0/4] Address issues slowing persistent memory initialization
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Mon, 10 Sep 2018 16:43:35 -0700
Message-ID: <20180910232615.4068.29155.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is meant to be a v3 to my earlier patch set "Address issues
slowing memory init"[1]. However I have added 2 additional patches to
address issues seen in which NVDIMM memory was slow to initialize
especially on systems with multiple NUMA nodes.

Since v2 of the patch set I have replaced the config option to work around
the page init poisoning with a kernel parameter. I also updated one comment
based on input from Michal.

The third patch in this set is new and is meant to address the need to
defer some page initialization to outside of the hot-plug lock. It is
loosely based on the original patch set by Dan Williams to perform
asynchronous page init for ZONE_DEVICE pages[2]. However, it is  based
more around the deferred page init model where memory init is deferred to a
fixed point, which in this case is to just outside of the hot-plug lock.

The fourth patch allows nvdimm init to be more node specific where
possible. I basically just copy/pasted the approach used in
pci_call_probe to allow for us to get the initialization code on the node
as close to the memory as possible. Doing so allows us to save considerably
on init time.

[1]: https://lkml.org/lkml/2018/9/5/924
[2]: https://lkml.org/lkml/2018/7/16/828

---

Alexander Duyck (4):
      mm: Provide kernel parameter to allow disabling page init poisoning
      mm: Create non-atomic version of SetPageReserved for init use
      mm: Defer ZONE_DEVICE page initialization to the point where we init pgmap
      nvdimm: Trigger the device probe on a cpu local to the device


 Documentation/admin-guide/kernel-parameters.txt |    8 ++
 drivers/nvdimm/bus.c                            |   45 ++++++++++
 include/linux/mm.h                              |    2 
 include/linux/page-flags.h                      |    9 ++
 kernel/memremap.c                               |   24 ++---
 mm/debug.c                                      |   16 +++
 mm/hmm.c                                        |   12 ++-
 mm/memblock.c                                   |    5 -
 mm/page_alloc.c                                 |  106 ++++++++++++++++++++++-
 mm/sparse.c                                     |    4 -
 10 files changed, 200 insertions(+), 31 deletions(-)

--
