Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91DBC10F08
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FFA2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBUNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:50:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:43674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfBUNuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:50:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 05:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="119707604"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2019 05:50:05 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/7] stm class/intel_th: Updates for v5.1
Date:   Thu, 21 Feb 2019 15:49:52 +0200
Message-Id: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the STM and Intel TH changes that I have for v5.1. Nothing big,
a few fixes that are too late for the v5.0 and a few minor cleanups and
a documentation update. All sparse/smatch/coccinelle/cppcheck/checkpatch
clean as usual, courtesy of aiaiai.
Individual patches follow. Please consider pulling or applying. Thanks!

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-for-greg-20190221

for you to fetch changes up to 4c3cef46a96e8f623d1edf03424880ebc901b068:

  stm class: Prevent division by zero (2019-02-21 15:29:26 +0200)

----------------------------------------------------------------
stm class/intel_th: Updates for v5.1

These are:
  * 2 bugfixes in stm class
  * one bugfix in intel_th
  * a few minor cleanups

----------------------------------------------------------------
Alexander Shishkin (4):
      intel_th: Update ABI documentation
      intel_th: Only create useful device nodes
      intel_th: Don't reference unassigned outputs
      stm class: Prevent division by zero

Andy Shevchenko (1):
      intel_th: pti: Use sysfs_match_string() helper

Gustavo A. R. Silva (1):
      intel_th: Mark expected switch fall-throughs

Zhi Jin (1):
      stm class: Fix an endless loop in channel allocation

 .../ABI/testing/sysfs-bus-intel_th-output-devices        |  6 ++++--
 drivers/hwtracing/intel_th/core.c                        |  6 +++++-
 drivers/hwtracing/intel_th/gth.c                         |  4 ++++
 drivers/hwtracing/intel_th/pti.c                         | 16 +++++++---------
 drivers/hwtracing/intel_th/sth.c                         |  4 ++++
 drivers/hwtracing/stm/core.c                             | 11 ++++++++---
 6 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.20.1

