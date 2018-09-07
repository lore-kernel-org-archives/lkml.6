Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7724AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FD82077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD82077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeIGQAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:00:22 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:46816 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728876AbeIGQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:00:21 -0400
X-ASG-Debug-ID: 1536319181-093b7e54e60b370003-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id ARGbx1YfwZn4Na5M (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Sep 2018 19:19:45 +0800 (CST)
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
Subject: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Date:   Fri, 7 Sep 2018 19:19:35 +0800
X-ASG-Orig-Subj: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Message-ID: <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1536319183
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8813 1.0000 3.0288
X-Barracuda-Spam-Score: 3.03
X-Barracuda-Spam-Status: No, SCORE=3.03 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57058
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't have non-inline function in a header file.
There is a risk of "Multiple definition" from cross-including.

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
---
 .../intel/i40evf/i40e_ethtool_stats.h         | 23 +-----------------
 .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
index 60b595dd8c39..62ab67a77753 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
@@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
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
 static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
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
+				    const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 9319971c5c92..eb2e910bc3a1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -171,6 +171,30 @@ static void i40evf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	}
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
  * i40evf_get_stat_strings - Get stat strings
  * @netdev: network interface device structure
-- 
2.18.0

