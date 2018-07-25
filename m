Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C195A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeGYJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:13:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:41232 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbeGYJN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:13:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="59298536"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2018 01:03:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2D453BA; Wed, 25 Jul 2018 11:03:21 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] thunderbolt: Changes for v4.19 merge window
Date:   Wed, 25 Jul 2018 11:03:14 +0300
Message-Id: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull Thunderbolt changes for v4.19 merge window.

This adds runtime PM support for the Thunderbolt driver to save energy
in recent systems where the controller is present all the time. In
addition there is a fix for a typo in variable name and a removal of an
unused variable.

I've included individual patches as well.

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v4.19

for you to fetch changes up to 33a7231d8ebbc4a4e05adcbc7ac053ad20dbc054:

  thunderbolt: Remove redundant variable 'approved' (2018-07-15 09:40:25 +0300)

Colin Ian King (1):
  thunderbolt: Remove redundant variable 'approved'

Mika Westerberg (5):
  thunderbolt: Use 64-bit DMA mask if supported by the platform
  thunderbolt: Do not unnecessarily call ICM get route
  thunderbolt: No need to take tb->lock in domain suspend/complete
  thunderbolt: Use correct ICM commands in system suspend
  thunderbolt: Add support for runtime PM

Nathan Ciobanu (1):
  thunderbolt: Fix small typo in variable name

 drivers/thunderbolt/domain.c  |  55 ++++++++---
 drivers/thunderbolt/icm.c     | 174 ++++++++++++++++++++++++++++------
 drivers/thunderbolt/nhi.c     |  46 ++++++++-
 drivers/thunderbolt/switch.c  |  65 ++++++++++++-
 drivers/thunderbolt/tb.h      |  10 ++
 drivers/thunderbolt/tb_msgs.h |   4 +
 drivers/thunderbolt/tb_regs.h |   2 +-
 drivers/thunderbolt/xdomain.c |  18 ++++
 8 files changed, 324 insertions(+), 50 deletions(-)

-- 
2.18.0

