Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D395AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8803826542
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8803826542
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeFZGWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:22:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:58874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeFZGWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:22:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 23:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="240651341"
Received: from shawn-bm6650-bm6350.itwn.intel.com ([10.5.253.27])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2018 23:22:13 -0700
From:   alanx.chiang@intel.com
To:     linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@intel.com, rajmohan.mani@intel.com,
        andy.shevchenko@gmail.com, brgl@bgdev.pl, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "alanx.chiang" <alanx.chiang@intel.com>
Subject: [PATCH v2 0/2] Add a property in at24.c
Date:   Tue, 26 Jun 2018 14:22:06 +0800
Message-Id: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "alanx.chiang" <alanx.chiang@intel.com>

In at24.c, it uses 8-bit addressing by default. In this patch,
add a property address-width that provides a flexible method to
pass the information to the driver.

alanx.chiang (2):
  dt-bindings: at24: Add address-width property
  eeprom: at24: Add support for address-width property

 Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
 drivers/misc/eeprom/at24.c                        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.7.4

