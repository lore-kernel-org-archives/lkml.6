Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB8920866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfAPSAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:00:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:8973 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfAPR7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:59:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 09:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117227782"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 09:59:38 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Date:   Wed, 16 Jan 2019 10:57:56 -0700
Message-Id: <20190116175804.30196-6-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190116175804.30196-1-keith.busch@intel.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for memory initiator and target node class attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 3e90e1f3bf0a..a9c47b4b0eee 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -90,4 +90,27 @@ Date:		December 2009
 Contact:	Lee Schermerhorn <lee.schermerhorn@hp.com>
 Description:
 		The node's huge page size control/query attributes.
-		See Documentation/admin-guide/mm/hugetlbpage.rst
\ No newline at end of file
+		See Documentation/admin-guide/mm/hugetlbpage.rst
+
+What:		/sys/devices/system/node/nodeX/classY/
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The node's relationship to other nodes for access class "Y".
+
+What:		/sys/devices/system/node/nodeX/classY/initiator_nodelist
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The node list of memory initiators that have class "Y" access
+		to this node's memory. CPUs and other memory initiators in
+		nodes not in the list accessing this node's memory may have
+		different performance.
+
+What:		/sys/devices/system/node/nodeX/classY/target_nodelist
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The node list of memory targets that this initiator node has
+		class "Y" access. Memory accesses from this node to nodes not
+		in this list may have differet performance.
-- 
2.14.4

