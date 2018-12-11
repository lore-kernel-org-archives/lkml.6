Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9F7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330862084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330862084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeLKBGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:06:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:24704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbeLKBFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:05:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="117705213"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2018 17:05:52 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 10/12] Documentation/ABI: Add node cache attributes
Date:   Mon, 10 Dec 2018 18:03:08 -0700
Message-Id: <20181211010310.8551-11-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the attributes for the system memory side caches.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 6cdb0643f9fd..63a757b8a29e 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -151,3 +151,37 @@ Contact:	Keith Busch <keith.busch@intel.com>
 Description:
 		Write latency in nanosecondss available to memory initiators
 		found in primary_cpu_nodemask.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/associativity
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The caches associativity: 0 for direct mapped, non-zero if
+		indexed.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/level
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This cache's level in the memory hierarchy. Matches 'Y' in the
+		directory name.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/line_size
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The number of bytes accessed from the next cache level on a
+		cache miss.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/size
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The size of this memory side cache in bytes.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/write_policy
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The cache write policy: 0 for write-back, 1 for write-through,
+		2 for other or unknown.
-- 
2.14.4

