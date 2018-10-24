Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A3C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F20C206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F20C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJXMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:01:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:49187 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeJXMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:01:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 19:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="102098561"
Received: from jhli-desk1.jf.intel.com ([10.7.198.167])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2018 19:22:22 -0700
From:   Juston Li <juston.li@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     lyude@redhat.com, clinton.a.taylor@intel.com,
        nathan.d.ciobanu@intel.com, mario.limonciello@dell.com,
        jared_dominguez@dell.com, linux-kernel@vger.kernel.org,
        Juston Li <juston.li@intel.com>
Subject: [RESEND PATCH v2 0/2] Check MST topology change on resume
Date:   Tue, 23 Oct 2018 19:19:23 -0700
Message-Id: <20181024021925.27026-1-juston.li@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated and resending these patches from Lyude:
https://lkml.org/lkml/2016/5/19/361
https://lkml.org/lkml/2016/5/19/360

As Lyude explains in patch 1/2, we can't rely on MST hubs to handle
hotplugs during suspend. This patchset will check if any EDID's changed
upon resume and reset the MST connections if they did.

This resolves issues with monitors not being detected when hotplugging them
during suspend.

Signed-off-by: Juston Li <juston.li@intel.com>

Changes since v1:
 - update functions that have been renamed since the original patch
 - add a null check for the cached EDID in case a new device was added
 - checkpatch fixes

Lyude (2):
  drm/dp/mst: Reprobe EDID for MST ports on resume
  drm/i915/mst: Reset MST after resume when necessary

 drivers/gpu/drm/drm_dp_mst_topology.c | 94 ++++++++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_dp.c       |  7 +-
 2 files changed, 99 insertions(+), 2 deletions(-)

-- 
2.17.2

