Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965785AbeCHLiX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:38:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:7041 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935338AbeCHLiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:38:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,440,1515484800";
   d="scan'208";a="209878402"
Date: Thu, 8 Mar 2018 19:37:30 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: kbuild-all@01.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] rds: rds_info_from_znotifier() can be static
Message-ID: <20180308113729.GA89557@cairo>
References: <201803081946.adQaZcK5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803081946.adQaZcK5%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 9426bbc6de99 ("rds: use list structure to track information for zerocopy completion notification")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 message.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 90dcdcf..f422b2f 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -67,7 +67,7 @@ static inline bool rds_zcookie_add(struct rds_msg_zcopy_info *info, u32 cookie)
 	return true;
 }
 
-struct rds_msg_zcopy_info *rds_info_from_znotifier(struct rds_znotifier *znotif)
+static struct rds_msg_zcopy_info *rds_info_from_znotifier(struct rds_znotifier *znotif)
 {
 	return container_of(znotif, struct rds_msg_zcopy_info, znotif);
 }
