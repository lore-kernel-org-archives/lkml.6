Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5BD20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5BD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeJAQIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:08:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:22619 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbeJAQIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:08:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="94958365"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2018 02:31:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2871511E; Mon,  1 Oct 2018 12:31:22 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] thunderbolt: Changes for v4.20 merge window
Date:   Mon,  1 Oct 2018 12:31:17 +0300
Message-Id: <20181001093122.65833-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are Thunderbolt changes I've queued for v4.20 merge window. I guess
the most notable change is that now the driver is not as verbose it used to
be and it now prints out the connected devices in the same way USB stack
does. In addition there are removal of meaningless NULL pointer check, some
conversions to use SPDX identifies and copyright update.

I've also included all the patches in case you prefer to take them directly
instead of pulling the signed tag.

Thanks!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v4.20

for you to fetch changes up to 7086a65c7634d3c9c4d48fcc06b7e35f9dd0ee43:

  thunderbolt: Add Intel as copyright holder (2018-09-21 11:21:24 +0300)

----------------------------------------------------------------
thunderbolt: Changes for v4.20 merge window

----------------------------------------------------------------

Mika Westerberg (4):
  thunderbolt: Make the driver less verbose
  thunderbolt: Print connected devices
  thunderbolt: Convert rest of the driver files to use SPDX identifier
  thunderbolt: Add Intel as copyright holder

zhong jiang (1):
  thunderbolt: Remove a meaningless NULL pointer check before dma_pool_destroy

 drivers/thunderbolt/cap.c      |  3 +-
 drivers/thunderbolt/ctl.c      | 12 +++---
 drivers/thunderbolt/ctl.h      |  3 +-
 drivers/thunderbolt/dma_port.c |  5 +--
 drivers/thunderbolt/dma_port.h |  5 +--
 drivers/thunderbolt/domain.c   |  7 +---
 drivers/thunderbolt/eeprom.c   |  5 ++-
 drivers/thunderbolt/icm.c      |  5 +--
 drivers/thunderbolt/nhi.c      | 33 ++++++++--------
 drivers/thunderbolt/nhi.h      |  3 +-
 drivers/thunderbolt/nhi_regs.h |  1 +
 drivers/thunderbolt/path.c     | 26 ++++++-------
 drivers/thunderbolt/property.c |  5 +--
 drivers/thunderbolt/switch.c   | 71 +++++++++++++++++++---------------
 drivers/thunderbolt/tb.c       | 10 ++---
 drivers/thunderbolt/tb.h       |  9 +++--
 drivers/thunderbolt/tb_msgs.h  |  5 +--
 drivers/thunderbolt/tb_regs.h  |  3 +-
 drivers/thunderbolt/xdomain.c  |  5 +--
 include/linux/thunderbolt.h    |  5 +--
 20 files changed, 108 insertions(+), 113 deletions(-)

-- 
2.19.0

