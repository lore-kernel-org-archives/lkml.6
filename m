Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90109C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4BF218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeLSPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:19:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:30409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbeLSPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:19:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 07:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="260746532"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2018 07:19:44 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 0/3] stm class/intel_th: Fixes for v4.20
Date:   Wed, 19 Dec 2018 17:19:19 +0200
Message-Id: <20181219151922.44839-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is a second attepmpt of [1]. This time commit references are fixed.
A new tag is also pushed, just in case.

I have 3 fixes for STM Class and Intel TH. Two things that I introduced in
v4.20-rc1 and one long-standing bug since v4.4. As usual, there is a signed
tag ready for pulling and individual patches follow. Please consider pulling
or applying. Thanks!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20181219

for you to fetch changes up to 28b39d95ea6f6b4ad8f6516cab135e85c577ebea:

  intel_th: msu: Fix an off-by-one in attribute store (2018-12-19 13:43:53 +0200)

----------------------------------------------------------------
stm class/intel_th: Fixes for v4.20

These are:
 * module refcount leak in stm class, introduced in v4.20-rc1
 * documentation fix
 * string parsing off-by-one in intel_th, also for -stable

----------------------------------------------------------------
Alexander Shishkin (3):
      stm class: Fix a module refcount leak in policy creation error path
      stm class: Add a reference to the SyS-T document
      intel_th: msu: Fix an off-by-one in attribute store

 Documentation/trace/index.rst    |  1 +
 drivers/hwtracing/intel_th/msu.c |  3 ++-
 drivers/hwtracing/stm/policy.c   | 12 +++++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)
