Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A40C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF142089C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF142089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbeG0LNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:27704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbeG0LNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 02:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="78308859"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2018 02:52:43 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     wei.w.wang@intel.com
Subject: [PATCH v2 0/2] virtio-balloon: some improvements
Date:   Fri, 27 Jul 2018 17:24:53 +0800
Message-Id: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

v1->v2 ChangeLog:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is negotiated.

Wei Wang (2):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 53 deletions(-)

-- 
2.7.4

