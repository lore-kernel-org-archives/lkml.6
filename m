Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E2C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2941320665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAIRsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:48:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:34827 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfAIRsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:48:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 09:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="115485629"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2019 09:47:59 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 08/13] Documentation/ABI: Add node performance attributes
Date:   Wed,  9 Jan 2019 10:43:36 -0700
Message-Id: <20190109174341.19818-9-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190109174341.19818-1-keith.busch@intel.com>
References: <20190109174341.19818-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add descriptions for memory class initiator performance access attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index a9c47b4b0eee..74cfc80cabf6 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -114,3 +114,31 @@ Description:
 		The node list of memory targets that this initiator node has
 		class "Y" access. Memory accesses from this node to nodes not
 		in this list may have differet performance.
+
+What:		/sys/devices/system/node/nodeX/classY/read_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's read bandwidth in MB/s available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/read_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's read latency in nanosecondss available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/write_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's write bandwidth in MB/s available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/write_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's write latency in nanosecondss available to memory
+		initiators in nodes found in this class's initiators_nodelist.
-- 
2.14.4

