Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8A121A74
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8A121A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHJD6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:58:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:57988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeHJD6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:58:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 18:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="252869962"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2018 18:30:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fnwFn-000EO9-DU; Fri, 10 Aug 2018 09:30:11 +0800
Date:   Fri, 10 Aug 2018 09:29:59 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Manish Chopra <manish.chopra@cavium.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] qed/qede: qede_setup_tc() can be static
Message-ID: <20180810012959.GA22458@athens>
References: <201808100919.Z4vmd4cO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808100919.Z4vmd4cO%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 5e7baf0fcb2a ("qed/qede: Multi CoS support.")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 qede_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 4b5d98f..46d0f2e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -536,7 +536,7 @@ static int qede_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	return 0;
 }
 
-int qede_setup_tc(struct net_device *ndev, u8 num_tc)
+static int qede_setup_tc(struct net_device *ndev, u8 num_tc)
 {
 	struct qede_dev *edev = netdev_priv(ndev);
 	int cos, count, offset;
