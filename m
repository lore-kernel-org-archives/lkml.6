Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5CC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5CC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGQWRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:17:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:41011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbeGQWRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 14:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,367,1526367600"; 
   d="scan'208";a="58456042"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.117.43])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2018 14:42:31 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatree.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 3/3] docs: Document the expanded hp{io,mem}size interface
Date:   Tue, 17 Jul 2018 15:39:47 -0600
Message-Id: <1531863587-3723-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
References: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expanded interface allows specifying sizes on a per-device/per-bus
path granularity.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c..8e4c129 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3142,11 +3142,24 @@
 				the default.
 				off: Turn ECRC off
 				on: Turn ECRC on.
-		hpiosize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's IO window.
+		hpiosize=
+				Format:
+				<nn[KMG]>
+				<nn[KMG]>@][<domain>:]<bus>[:<slot>.<func>][; ...]
+				<nn[KMG]>@]pci:<vendor>:<device>\
+						[:<subvendor>:<subdevice>][; ...]
+				The fixed amount of bus space which is reserved
+				for the matching hotplug bridge(s)'s IO window.
 				Default size is 256 bytes.
-		hpmemsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's memory window.
+		hpmemsize=
+				Format:
+				<nn[KMG]>[P]
+				<nn[KMG]>[P]@][<domain>:]<bus>[:<slot>.<func>][; ...]
+				<nn[KMG]>[P]@]pci:<vendor>:<device>\
+						[:<subvendor>:<subdevice>][; ...]
+				The fixed amount of bus space which is reserved
+				for the matching hotplug bridge(s)'s memory window.
+				'P' specifies prefetchable.
 				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
-- 
1.8.3.1

