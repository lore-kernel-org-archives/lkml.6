Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F99CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DA02086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeKZUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:41:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:51155 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeKZUlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:41:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 01:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="276891243"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2018 01:47:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0515314F; Mon, 26 Nov 2018 11:47:46 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] thunderbolt: Fix for v4.20-rc5
Date:   Mon, 26 Nov 2018 12:47:45 +0300
Message-Id: <20181126094746.65030-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull one fix for Thunderbolt that makes NVM upgrade work better on
systems that support runtime PM for the PCIe root port. I've also included
the patch in case you want to apply it directly.

Thanks!

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fix-for-v4.20-rc5

for you to fetch changes up to 1f23f28d085d318789596b8616f161350b0ecfc9:

  thunderbolt: Prevent root port runtime suspend during NVM upgrade (2018-11-15 13:28:09 +0300)

----------------------------------------------------------------
thunderbolt: Fix for v4.20-rc5

----------------------------------------------------------------

Mika Westerberg (1):
  thunderbolt: Prevent root port runtime suspend during NVM upgrade

 drivers/thunderbolt/switch.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.19.1

