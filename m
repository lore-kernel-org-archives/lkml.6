Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946123AbeBORon (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:44:43 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:13701 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1164558AbeBORok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:44:40 -0500
Date: Thu, 15 Feb 2018 11:44:35 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] i40evf/i40evf_main: Fix variable assignment in
 i40evf_parse_cls_flower
Message-ID: <20180215174435.GA19969@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emNaJ-0013h9-4e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:36216
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems this is a copy-paste error and that the proper variable to use
in this particular case is _src_ instead of _dst_.

Addresses-Coverity-ID: 1465282 ("Copy-paste error")
Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4955ce3..58be99e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2763,7 +2763,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 
 		if (key->src) {
 			filter->f.mask.tcp_spec.src_port |= cpu_to_be16(0xffff);
-			filter->f.data.tcp_spec.src_port = key->dst;
+			filter->f.data.tcp_spec.src_port = key->src;
 		}
 	}
 	filter->f.field_flags = field_flags;
-- 
2.7.4
