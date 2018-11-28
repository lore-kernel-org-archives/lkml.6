Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE25C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E33720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E33720832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeK1XBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:01:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:3291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeK1XBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:01:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:59:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="116501277"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2018 03:59:52 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] device property: Add fwnode_get_name() helper
Date:   Wed, 28 Nov 2018 14:59:49 +0300
Message-Id: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are no changes compared to v4. I'm resending because of the
extra patch in v4. Sorry for that. This was the v4 cover letter:

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

Heikki Krogerus (3):
  device property: Introduce fwnode_get_name()
  ACPI: property: Add acpi_fwnode_name()
  of/property: Add of_fwnode_name()

 drivers/acpi/property.c  | 28 ++++++++++++++++++++++++++++
 drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/of/property.c    | 13 +++++++++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/property.h |  2 ++
 5 files changed, 82 insertions(+)

-- 
2.19.2

