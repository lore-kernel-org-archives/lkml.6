Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A1FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1152147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBSS5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:57:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:40390 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfBSS5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:57:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 10:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="117434277"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 10:57:53 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
        mchehab@kernel.org, james.morse@arm.com
Cc:     thor.thayer@linux.intel.com, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Distinct SOCFPGA SDRAM EDAC config
Date:   Tue, 19 Feb 2019 12:59:57 -0600
Message-Id: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Most users want EDAC support so make it the default.

SOCFPGA SDRAM EDAC reporting was enabled by the parent EDAC
config (CONFIG_ALTERA_EDAC) since initial customers always
wanted SDRAM EDAC enabled.
There are cases where the SDRAM needs to be disabled while
the other block EDACs remain enabled.
This patch set 1) splits out the SDRAM EDAC into a separate
config and 2) enables all the EDAC blocks by default for
32 bit SOCFPGA.

Thor Thayer (2):
  EDAC, altera: Add separate SDRAM EDAC config
  ARM: socfpga_defconfig: enable EDAC by default

 arch/arm/configs/socfpga_defconfig | 36 ++++++++++++--------
 drivers/edac/Kconfig               | 14 ++++++--
 drivers/edac/altera_edac.c         | 67 ++++++++++++++++++++------------------
 3 files changed, 69 insertions(+), 48 deletions(-)

-- 
2.7.4

