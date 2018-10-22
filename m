Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5959C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2245320665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2245320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeJWEiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:36328 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbeJWEis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="102363901"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 22 Oct 2018 13:18:50 -0700
Subject: [PATCH 9/9] dax/kmem: actually enable the code in Makefile
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:32 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201332.FC3B5EB7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Most of the new code was dead up to this point.  Now that
all the pieces are in place, enable it.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>

---

 b/drivers/dax/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/dax/Makefile~dax-kmem-makefile drivers/dax/Makefile
--- a/drivers/dax/Makefile~dax-kmem-makefile	2018-10-22 13:12:25.068930384 -0700
+++ b/drivers/dax/Makefile	2018-10-22 13:12:25.071930384 -0700
@@ -2,7 +2,9 @@
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_PMEM) += dax_pmem.o
+obj-$(CONFIG_DEV_DAX_PMEM) += dax_kmem.o
 
 dax-y := super.o
 dax_pmem-y := pmem.o
+dax_kmem-y := kmem.o
 device_dax-y := device.o
_
