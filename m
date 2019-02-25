Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C41C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F392147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBYTCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:02:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:35221 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBYTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:02:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 11:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="127150058"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 11:02:33 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
        mchehab@kernel.org, james.morse@arm.com
Cc:     thor.thayer@linux.intel.com, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Date:   Mon, 25 Feb 2019 12:56:44 -0600
Message-Id: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
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

V2 Changes
  Rebase socfpga_defconfig against arm-soc/arm/defconfig

Thor Thayer (2):
  EDAC, altera: Add separate SDRAM EDAC config
  ARM: socfpga_defconfig: enable EDAC by default

 arch/arm/configs/socfpga_defconfig | 12 +++++++
 drivers/edac/Kconfig               | 14 ++++++--
 drivers/edac/altera_edac.c         | 67 ++++++++++++++++++++------------------
 3 files changed, 59 insertions(+), 34 deletions(-)

-- 
2.7.4

