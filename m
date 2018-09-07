Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2610020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2610020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeIGQAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:00:30 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:46793 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728868AbeIGQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:00:22 -0400
X-ASG-Debug-ID: 1536319181-093b7e54e60b370002-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id X8AS2Yr9EyYdXZ4z (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Sep 2018 19:19:43 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from localhost.localdomain.localdomain (10.5.21.103) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Sep 2018 19:19:45 +0800
From:   Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To:     <jeffrey.t.kirsher@intel.com>, <sergei.shtylyov@cogentembedded.com>
CC:     <jacob.e.keller@intel.com>, <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Date:   Fri, 7 Sep 2018 19:19:34 +0800
X-ASG-Orig-Subj: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Message-ID: <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1536319181
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8718 1.0000 2.9301
X-Barracuda-Spam-Score: 3.43
X-Barracuda-Spam-Status: No, SCORE=3.43 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57058
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "inline" from __i40e_add_stat_strings and move the function.

In file included from
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
__i40e_add_stat_string:
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
function __i40e_add_stat_strings can never be inlined because it uses
variable argument lists
 static inline void __i40e_add_stat_strings(u8 **p, const struct
					    i40e_stats stats[],

Tested on: x86_64, make ARCH=i386

Modules section .text:
i40e: 00019380 <__i40e_add_stat_strings>:
i40evf: 00006b00 <__i40e_add_stat_strings>:

Buildin section .text:
i40e: c351ca60 <__i40e_add_stat_strings>:
i40evf: c354f2c0 <__i40e_add_stat_strings>:

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
V3: add static 
V2: Move function
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
 .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974beca2..34121a72f2e7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1821,6 +1821,30 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		  "ethtool stats count mismatch!");
 }
 
+/**
+ * __i40e_add_stat_strings - copy stat strings into ethtool buffer
+ * @p: ethtool supplied buffer
+ * @stats: stat definitions array
+ * @size: size of the stats array
+ *
+ * Format and copy the strings described by stats into the buffer pointed at
+ * by p.
+ **/
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size, ...)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i++) {
+		va_list args;
+
+		va_start(args, size);
+		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
+		*p += ETH_GSTRING_LEN;
+		va_end(args);
+	}
+}
+
 /**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
  * @netdev: the netdev to collect strings for
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0b658f..553b0d720839 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -181,29 +181,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
 	*data += size;
 }
 
-/**
- * __i40e_add_stat_strings - copy stat strings into ethtool buffer
- * @p: ethtool supplied buffer
- * @stats: stat definitions array
- * @size: size of the stats array
- *
- * Format and copy the strings described by stats into the buffer pointed at
- * by p.
- **/
-static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
-				    const unsigned int size, ...)
-{
-	unsigned int i;
-
-	for (i = 0; i < size; i++) {
-		va_list args;
-
-		va_start(args, size);
-		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
-		*p += ETH_GSTRING_LEN;
-		va_end(args);
-	}
-}
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
-- 
2.18.0

