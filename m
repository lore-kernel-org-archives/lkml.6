Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53756C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C383208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C383208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389880AbeHPLQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:16:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:27823 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeHPLQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:16:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 01:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="83781731"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2018 01:19:10 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org,
        penguin-kernel@I-love.SAKURA.ne.jp
Cc:     wei.w.wang@intel.com
Subject: [PATCH v4 0/3] virtio-balloon: some improvements
Date:   Thu, 16 Aug 2018 15:50:55 +0800
Message-Id: <1534405858-27085-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

ChangeLog:
v3->v4:
- use kzalloc to allocate the vb struct so that we don't need to zero
  initialize each field one by one later;
- also remove vb->shrinker.batch = 0, which is not needed now.
v2->v3:
- shrink the balloon pages according to the amount requested by the
  claimer, instead of using a user specified number;
v1->v2:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
  negotiated.

Wei Wang (3):
  virtio-balloon: remove BUG() in init_vqs
  virtio-balloon: kzalloc the vb struct
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 58 deletions(-)

-- 
2.7.4

