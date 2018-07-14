Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C3620673
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C3620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeGNBph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:45:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:52018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbeGNBph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:45:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 18:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,350,1526367600"; 
   d="scan'208";a="66860861"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2018 18:28:26 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fe9MF-000PPo-0F; Sat, 14 Jul 2018 09:28:23 +0800
Date:   Sat, 14 Jul 2018 09:27:35 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: mvpp2: mvpp2_cls_flow_get() can be static
Message-ID: <20180714012735.GA24562@lkp-sb05>
References: <201807140954.503e2wSM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807140954.503e2wSM%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: f9358e12a0af ("net: mvpp2: split ingress traffic into multiple flows")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mvpp2_cls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index dc7dfa9..723d0ba 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -557,7 +557,7 @@ static int mvpp2_flow_set_hek_fields(struct mvpp2_cls_flow_entry *fe,
 	return 0;
 }
 
-struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
+static struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
 {
 	if (flow >= MVPP2_N_FLOWS)
 		return NULL;
