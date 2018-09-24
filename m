Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE05ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459592086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459592086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIXQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:30:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:19673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeIXQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:30:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="88803813"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2018 03:28:19 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 00/14] serial: langtiq: Add CCF suppport
Date:   Mon, 24 Sep 2018 18:27:49 +0800
Message-Id: <20180924102803.30263-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for adding common clock framework support
for langtiq serial driver, mainly includes:
1) Add common clock framework support.
2) Modify the dts file according to the DT conventions.
3) Replace the platform dependent functions with kernel functions


Songjun Wu (14):
  MIPS: dts: Change upper case to lower case
  MIPS: dts: Add aliases node for lantiq danube serial
  serial: lantiq: Get serial id from dts
  serial: lantiq: Change ltq_w32_mask to asc_update_bits
  MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
  serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
  serial: lantiq: Rename fpiclk to freqclk
  serial: lantiq: Replace clk_enable/clk_disable with clk generic API
  serial: lantiq: Add CCF support
  serial: lantiq: Reorder the head files
  include: Add lantiq.h in include/linux/
  serial: lantiq: Replace lantiq_soc.h with lantiq.h
  serial: lantiq: Change init_lqasc to static declaration
  dt-bindings: serial: lantiq: Add optional properties for CCF

 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++
 arch/mips/Kconfig                                  |   1 -
 arch/mips/boot/dts/lantiq/danube.dtsi              |  42 +++---
 arch/mips/boot/dts/lantiq/easy50712.dts            |  18 ++-
 drivers/tty/serial/lantiq.c                        | 145 ++++++++++++---------
 include/linux/lantiq.h                             |  23 ++++
 6 files changed, 155 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/lantiq.h

-- 
2.11.0

