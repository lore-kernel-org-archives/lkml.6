Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DC0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F284F206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F284F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeIMOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:46:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:49361 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeIMOqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:46:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 02:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="90093154"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2018 02:37:52 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v1 3/3] hv: add description for hv_nopvspin
Date:   Thu, 13 Sep 2018 17:13:25 +0800
Message-Id: <1536830005-37260-4-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hv_nopvspin is a command line parameter used to
disable Hyper-V PV spinlock.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf5..fc761b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1385,6 +1385,11 @@
 	hvc_iucv_allow=	[S390]	Comma-separated list of z/VM user IDs.
 				If specified, z/VM IUCV HVC accepts connections
 				from listed z/VM user IDs only.
+
+	hv_nopvspin	[X86,HYPER_V]
+			Disables the ticketlock slowpath using HYPER-V PV
+			optimizations.
+
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
-- 
1.9.1

