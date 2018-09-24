Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52EEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882932145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882932145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeIXQWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:22:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:23957 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:22:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="73243482"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2018 03:20:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AD028113; Mon, 24 Sep 2018 13:20:45 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] thunderbolt: Fixes for v4.19-rc6
Date:   Mon, 24 Sep 2018 13:20:43 +0300
Message-Id: <20180924102045.75807-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This includes two fixes:

  - Stop handling ICM events when the domain is already removed upon module
    removal.

  - If the module is built into the kernel image, initialize after IOMMUs
    to keep the driver working when IOMMUs are enabled.

I've included both patches as well in case prefer to apply them directely
instead of pulling the signed tag.

Thanks!

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v4.19-rc6

for you to fetch changes up to b3cea5ec12adc0fe0c0d264e56aa97ab617a51d6:

  thunderbolt: Initialize after IOMMUs (2018-09-14 10:45:22 +0300)

----------------------------------------------------------------
thunderbolt: Fixes for v4.19-rc6

----------------------------------------------------------------

Mika Westerberg (2):
  thunderbolt: Do not handle ICM events after domain is stopped
  thunderbolt: Initialize after IOMMUs

 drivers/thunderbolt/icm.c | 49 ++++++++++++++++-----------------------
 drivers/thunderbolt/nhi.c |  2 +-
 2 files changed, 21 insertions(+), 30 deletions(-)

-- 
2.18.0

