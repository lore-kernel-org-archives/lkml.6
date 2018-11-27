Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DC1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DC1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeK1B1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:27:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:5443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeK1B1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:27:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 06:28:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="114457799"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 06:28:55 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] device property: Add fwnode_get_name() helper
Date:   Tue, 27 Nov 2018 17:28:51 +0300
Message-Id: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm now returning -EOVERFLOW if the buffer is not big enough as
proposed by Andy.

This is the cover letter from v3:

This is the third version of my proposal for this helper. The
second version can be checked here:
https://lkml.org/lkml/2018/11/8/1005

I'm now passing the length as proposed by both Rob and Andy. I'm also
leaving the .get_named_child_node fwnode op untouched.

--
heikki


Heikki Krogerus (4):
  device property: Introduce fwnode_get_name()
  ACPI: property: Add acpi_fwnode_name()
  of/property: Add of_fwnode_name()
  driver core: Add fwnode member to struct device_connection

 drivers/acpi/property.c  | 28 ++++++++++++++++++++++++++++
 drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/of/property.c    | 13 +++++++++++++
 include/linux/device.h   |  6 ++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/property.h |  2 ++
 6 files changed, 88 insertions(+)

-- 
2.19.2

