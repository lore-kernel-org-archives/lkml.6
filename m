Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECCC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5A92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LvBLHg5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5A92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJ3B1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:04 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:53655 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeJ3B1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:04 -0400
Received: by mail-it1-f180.google.com with SMTP id f16-v6so2765765ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=BdS9GbwNqTy4UUJTIRVyx9+xOos9PgHC/rUQ7NJVuWI=;
        b=LvBLHg5/oWRWhuYns8nWd0Gs53gQ8e73HtYRpe5kGUjIF251ynfkeQRFowo78rcAd8
         R2xXSXAbqbnZ9yu6E33JJ+xLWs06mYsdAGfmfU6sgwIUjEin1rQsPxAAZou+Tqk3f1oj
         o8asYy+Wn6J58/LVrbeKonW39V5jdkI7VSnlpOj54m3iBpMbYZBm/ozS/x2Q6WLdgxgU
         8xStnhFmMagtgZvVYxGVeZO5TgHzU1qJhlnbC+1k3QwbqgvNlPaI45dMwCsXtCITQHl3
         PwQxIu0iMQIsSBV6Cc6u4cyAp0WbJCwWPQhw5D//7oxfMGlxbqfEa4beOzOi0Qn99ks1
         yteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BdS9GbwNqTy4UUJTIRVyx9+xOos9PgHC/rUQ7NJVuWI=;
        b=Xhy5VGAPlkI7UqqwQIltPHH/h3Ycu91wKReXvrpkcd9EHNni3fKey0OGFRu956b+il
         +yYrpuALRPwGnfajPKLSzji1u4wt/E2A17nYmQ76mWqsrPoThGPKfImZFuMphoKBA4wi
         dLPvMYf8hXWvm/2O4QsO5k6FB+uWrSc9ugyoXkrLk5Ge4UTg/KGLo5/g3OFDUze1pR5D
         YOPwIwbkebWbG5m9KmhNjn8OzMjBxQvyAOmGEjgjFeSaR+QLmhbX0pkNDUEAkJooxkqE
         Dag2K4DSIMpw9L3UWRrvTBhhr+2gy1TqkG2rqhqaHVqlKJYfwQwsxIx0V85W3eYf7Xol
         1Wpg==
X-Gm-Message-State: AGRZ1gJ+Ah8PHw937d99p2MtJY5yQa53rYb43IX0KYuJyS58tbLZsIif
        OUWHwbUeR5PX1SDvNjwGUVRg4N5Kuf8=
X-Google-Smtp-Source: AJdET5cnJd58RLRTtNGRJVGeUaz4G3pRBbyH7I4ihQXkXiqVsORYYg4vh4yZ1H8f1vPKdQqlUtXGiw==
X-Received: by 2002:a24:6c14:: with SMTP id w20-v6mr10219599itb.103.1540831062486;
        Mon, 29 Oct 2018 09:37:42 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 0/14] blk-mq: Add support for multiple queue maps
Date:   Mon, 29 Oct 2018 10:37:24 -0600
Message-Id: <20181029163738.10172-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for multiple queue maps for blk-mq.
Since blk-mq was introduced, it's only support a single queue
map. This means you can have 1 set of queues, and the mapping
purely depends on what CPU an IO originated from. With this
patch set, drivers can implement mappings that depend on both
CPU and request type - and they can have multiple sets of mappings.

NVMe is used as a proof of concept. It adds support for a separate
write queue set. One way to use this would be to limit the number
of write queues to favor reads, since NVMe does round-robin service
of queues. An easy extension of this would be to add multiple
sets of queues, for prioritized IO.

NVMe also uses this feature to finally make the polling work
efficiently, without triggering interrupts. This both increases
performance (and decreases latency), at a lower system load. At
the same time it's more flexible, as you don't have to worry about
IRQ coalescing and redirection to avoid interrupts disturbing the
workload. This is how polling should have worked from day 1.

This is on top of the mq-conversions branch and series just
posted. It can also be bound in my mq-maps branch.

Changes since v1:

- Ensure irq_calc_affinity_vectors() doesn't return more than 'maxvec'
- Rebase on top of current mq-conversions series

 block/blk-flush.c                     |   7 +-
 block/blk-mq-cpumap.c                 |  19 +--
 block/blk-mq-debugfs.c                |   4 +-
 block/blk-mq-pci.c                    |  10 +-
 block/blk-mq-rdma.c                   |   4 +-
 block/blk-mq-sched.c                  |  18 ++-
 block/blk-mq-sysfs.c                  |  10 ++
 block/blk-mq-tag.c                    |   5 +-
 block/blk-mq-virtio.c                 |   8 +-
 block/blk-mq.c                        | 213 ++++++++++++++++++++----------
 block/blk-mq.h                        |  29 ++++-
 block/blk.h                           |   6 +-
 block/kyber-iosched.c                 |   6 +-
 drivers/block/virtio_blk.c            |   2 +-
 drivers/nvme/host/pci.c               | 238 ++++++++++++++++++++++++++++++----
 drivers/scsi/qla2xxx/qla_os.c         |   5 +-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c |   3 +-
 drivers/scsi/virtio_scsi.c            |   3 +-
 fs/block_dev.c                        |   2 +
 fs/direct-io.c                        |   2 +
 fs/iomap.c                            |   9 +-
 include/linux/blk-mq-pci.h            |   4 +-
 include/linux/blk-mq-virtio.h         |   4 +-
 include/linux/blk-mq.h                |  24 +++-
 include/linux/blk_types.h             |   4 +-
 include/linux/blkdev.h                |   2 -
 include/linux/interrupt.h             |   4 +
 kernel/irq/affinity.c                 |  40 ++++--
 29 files changed, 526 insertions(+), 161 deletions(-)


