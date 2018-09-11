Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BBC46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7C22086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7C22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeIKFhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:37:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:32001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeIKFhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:37:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 17:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,358,1531810800"; 
   d="scan'208";a="69864081"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2018 17:41:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzWjp-0001av-G9; Tue, 11 Sep 2018 08:41:05 +0800
Date:   Tue, 11 Sep 2018 08:40:16 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Ocean He <oceanhehy@gmail.com>
Cc:     kbuild-all@01.org, dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [RFC PATCH] libnvdimm, region_devs: nd_region_detach_and_reset() can
 be static
Message-ID: <20180911004016.GA26156@lkp-wsm-ep1>
References: <1536560508-24564-4-git-send-email-oceanhehy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536560508-24564-4-git-send-email-oceanhehy@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 39ac5d361db2 ("libnvdimm, region_devs: reset related seeds when fail to create namespace")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 region_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4c46fb6..a2f667e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -707,7 +707,7 @@ void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
  * To ensure pfn_seed/dax_seed and namespace_seed are ready for
  * next namespace creation, here to do detach and reset.
  */
-void nd_region_detach_and_reset(struct device *dev,
+static void nd_region_detach_and_reset(struct device *dev,
 		struct nd_region *nd_region)
 {
 	/* Only nd_pmem has been verified, fix me for other dev type. */
