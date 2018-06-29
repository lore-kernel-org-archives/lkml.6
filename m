Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2EC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D417D27C1D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D417D27C1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937121AbeF2UAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:00:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:19117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932890AbeF2UAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 13:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241791985"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 13:00:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 0/4] nvme trace updates
Date:   Fri, 29 Jun 2018 13:59:56 -0600
Message-Id: <20180629200000.16171-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on/inspired by Johannes Thumshirn that
improves the nvme trace events.

The first one from Sagi is saving the nvme_ctrl in the driver request data
so we can reference it in other places, both for this series and future
developments.

The others are adding and simplifying the nvme traces so we can see
information to uniquely identify what hardware the trace event is showing,
and filter events for specific hardware.

v2 -> v3:

  Removed unrelated code that leaked into the previous series

  Added helpers for setting the qid and disk name fields

  Simplified printing the disk name: it's already null terminated, so
  don't need to define the limit.

  Updated change logs

  Minor code formatting updates

  Added Reviewed-by for Sagi's patch

v1 -> v2:

  Dropped the blk-mq patch as there were pre-existing ways to get to the
  desired information without introducing a new API

  Changelog typo fixups

Keith Busch (3):
  nvme: use hw qid in trace events
  nvme: add controller name to trace events
  nvme: add disk name to trace events

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   |   5 +-
 drivers/nvme/host/fc.c     |   1 +
 drivers/nvme/host/nvme.h   |   1 +
 drivers/nvme/host/pci.c    |   2 +
 drivers/nvme/host/rdma.c   |   1 +
 drivers/nvme/host/trace.c  |  11 ++++
 drivers/nvme/host/trace.h  | 137 +++++++++++++++++++++++++--------------------
 drivers/nvme/target/loop.c |   1 +
 8 files changed, 93 insertions(+), 66 deletions(-)

-- 
2.14.3

