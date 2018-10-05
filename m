Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131AFC65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D2321473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D2321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJFDzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:55:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:1454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJFDzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:55:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 13:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,346,1534834800"; 
   d="scan'208";a="263254384"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2018 13:55:27 -0700
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv4 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Date:   Fri,  5 Oct 2018 15:56:58 -0500
Message-Id: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support for the Stratix10 SOCFPGA. This patch requires
clock enables for the master TBUs and therefore has a dependency
on patches currently being reviewed.

This patchset is dependent on the patch series [1]

v4  Address Vivek's comment.
    Abandon dependency on [2] (no recent activity/reviews)
    Implement device tree parsing of clock on top of [1].
v3  Address comment from Robin and change dependency on device
    tree bulk clock patches [2].
v2  Change to dependency on [1].

[1] [v16,0/5] iommu/arm-smmu: Add runtime pm/sleep support
https://patchwork.kernel.org/cover/10581891/

[2] [PATCH V6 0/4] clk: new APIs to handle all available clocks
https://lkml.org/lkml/2018/8/31/97

Thor Thayer (2):
  arm64: dts: stratix10: Add Stratix10 SMMU support
  iommu/arm-smmu: Get clock config from device tree

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 29 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                          | 30 ++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.7.4

