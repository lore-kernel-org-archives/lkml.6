Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFFC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5FE213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5FE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJDFQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:16:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:58241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDFQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:16:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="88962346"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2018 15:25:54 -0700
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Date:   Wed,  3 Oct 2018 17:28:11 -0500
Message-Id: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support for the Stratix10 SOCFPGA. This patch requires
clock enables for the master TBUs and therefore has a dependency
on patches currently being reviewed.

This patchset is dependent on the patch series
"[PATCH V6 0/4] clk: new APIs to handle all available clocks"
(https://lkml.org/lkml/2018/8/31/97)

v1->v2  Change to dependency on 
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)

v2->v3  Change dependency on device tree bulk clock patches.

Thor Thayer (2):
  arm64: dts: stratix10: Add Stratix10 SMMU support
  iommu/arm-smmu: Add SMMU clock

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 28 +++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                          | 20 ++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.7.4

