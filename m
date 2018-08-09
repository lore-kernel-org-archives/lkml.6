Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EFCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECB32238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECB32238F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeHJBAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:00:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:14661 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeHJBAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:00:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 15:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="82142749"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2018 15:33:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fntUR-000H2z-Ov; Fri, 10 Aug 2018 06:33:07 +0800
Date:   Fri, 10 Aug 2018 06:33:17 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [RFC PATCH] xen/blkback: xen_blkif_pgrant_timeout can be static
Message-ID: <20180809223317.GA3009@lkp-ivb-ep02>
References: <20180808142528.31029-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808142528.31029-2-jgross@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 5bed25379565 ("xen/blkback: don't keep persistent grants too long")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 blkback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index f341ac8..9eae7b24 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(max_persistent_grants,
  * use. The time is in seconds, 0 means indefinitely long.
  */
 
-unsigned int xen_blkif_pgrant_timeout = 60;
+static unsigned int xen_blkif_pgrant_timeout = 60;
 module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
 		   uint, 0644);
 MODULE_PARM_DESC(persistent_grant_unused_seconds,
