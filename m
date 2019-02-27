Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE020643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfB0RZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:44139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0RZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303030788"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 09:25:26 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/5] Update Stratix10 EDAC Bindings
Date:   Wed, 27 Feb 2019 11:27:20 -0600
Message-Id: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Instead of using the Arria10 (ARM32) EDAC bindings for
Stratix10 (ARM64), create Stratix10 specific EDAC bindings
to capture architecture differences between ARM32 and ARM64.
This requires fixing the previous Stratix10 bindings.
Also add the peripheral bindings for the Stratix10.

Thor Thayer (5):
  Documentation: dt: edac: Fix Stratix10 IRQ bindings
  Documentation: dt: edac: Add Stratix10 Peripheral bindings
  EDAC, altera: Skip DB IRQ for Stratix10
  arm64: dts: stratix10: Use new Stratix10 EDAC bindings
  EDAC, altera: Remove Stratix10 Machine compatible check

 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 129 +++++++++++++++++++--
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  25 ++--
 drivers/edac/altera_edac.c                         |  49 ++++----
 3 files changed, 158 insertions(+), 45 deletions(-)

-- 
2.7.4

