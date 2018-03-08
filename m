Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755727AbeCHK5b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:57:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:25087 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755522AbeCHK5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:57:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,440,1515484800";
   d="scan'208";a="32274583"
Date: Thu, 8 Mar 2018 18:56:14 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: kbuild-all@01.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] rds: rds_message_zcopy_from_user() can be
 static
Message-ID: <20180308105614.GA22202@cairo>
References: <201803081854.WYn8kS5Y%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803081854.WYn8kS5Y%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: d40a126b16ea ("rds: refactor zcopy code into rds_message_zcopy_from_user")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 message.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index c36edbb9..6d87910b 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -333,7 +333,7 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 	return rm;
 }
 
-int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *from)
+static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *from)
 {
 	unsigned long sg_off;
 	struct scatterlist *sg;
