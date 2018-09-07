Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72673C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D8B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D8B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeIGGTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:19:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:36367 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbeIGGTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:19:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 18:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="87899404"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2018 18:41:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fy5ll-000DA4-4R; Fri, 07 Sep 2018 09:41:09 +0800
Date:   Fri, 7 Sep 2018 09:41:08 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Weilin Chang <weilin.chang@cavium.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] liquidio: lio_fetch_vf_stats() can be static
Message-ID: <20180907014108.GA48543@cairo>
References: <201809070936.Xhh3hpBt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809070936.Xhh3hpBt%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 488752220b4a ("liquidio: Add spoof checking on a VF MAC address")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 lio_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 0284204..2122430 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -1357,7 +1357,7 @@ octnet_nic_stats_callback(struct octeon_device *oct_dev,
 	}
 }
 
-int lio_fetch_vf_stats(struct lio *lio)
+static int lio_fetch_vf_stats(struct lio *lio)
 {
 	struct octeon_device *oct_dev = lio->oct_dev;
 	struct octeon_soft_command *sc;
