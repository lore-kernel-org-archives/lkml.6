Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4331EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CFA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CFA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKESgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:36:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:34873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKESgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:36:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 01:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="105337691"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 01:17:28 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/4] device property: Add fwnode_name() helper
Date:   Mon,  5 Nov 2018 12:17:23 +0300
Message-Id: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I prepared fwnode_name() for something I'm working on, but then I
realized that it makes it possible to also implement a generic
fwnode_get_named_child_node(). So in practice I'm proposing that we
replace get_named_child_node fwnode op with that new "name" fwnode op
in this series.

thanks,

Heikki Krogerus (4):
  device property: Introduce fwnode_name()
  ACPI: property: Introduce acpi_fwnode_name()
  of/property: Introduce of_fwnode_name()
  device property: Drop get_named_child_node callback

 drivers/acpi/property.c  | 26 +++++++-------------------
 drivers/base/property.c  | 28 +++++++++++++++++++++++++++-
 drivers/of/property.c    | 21 ++++++---------------
 include/linux/fwnode.h   |  4 +---
 include/linux/property.h |  2 ++
 5 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.19.1

