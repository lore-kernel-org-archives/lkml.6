Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C516C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF4B20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF4B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIDON3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:13:29 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:36449 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbeIDON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:13:28 -0400
X-ASG-Debug-ID: 1536054535-093b7e636b113490001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id 5zRlLBeMC85CPmo0 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 04 Sep 2018 17:48:55 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from localhost.localdomain.localdomain (10.5.21.103) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Sep 2018 17:49:01 +0800
From:   Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To:     <jeffrey.t.kirsher@intel.com>
CC:     <jacob.e.keller@intel.com>, <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [PATCH] net: ethernet: i40e: fix build error
Date:   Tue, 4 Sep 2018 17:48:47 +0800
X-ASG-Orig-Subj: [PATCH] net: ethernet: i40e: fix build error
Message-ID: <1536054527-34184-1-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1536054535
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6628 1.0000 1.1043
X-Barracuda-Spam-Score: 1.10
X-Barracuda-Spam-Status: No, SCORE=1.10 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.56851
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "inline" from __i40e_add_stat_strings.

In file included from
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
‘__i40e_add_stat_strings’:
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
function ‘__i40e_add_stat_strings’ can never be inlined because it uses
variable argument lists
 static inline void __i40e_add_stat_strings(u8 **p, const struct
					    i40e_stats stats[],

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0..0290ade 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -190,7 +190,7 @@ struct i40e_stats {
  * Format and copy the strings described by stats into the buffer pointed at
  * by p.
  **/
-static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
 				    const unsigned int size, ...)
 {
 	unsigned int i;
-- 
1.8.3.1

