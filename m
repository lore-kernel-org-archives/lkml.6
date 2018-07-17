Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62066ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2221820877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2221820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeGQBhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:37:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:49786 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeGQBhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:37:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 18:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="65189131"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2018 18:07:07 -0700
Date:   Tue, 17 Jul 2018 09:18:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: mvpp2: mvpp2_flow_get_hek_fields() can be
 static
Message-ID: <20180717011812.GZ10593@intel.com>
References: <201807141506.hlrwYth1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807141506.hlrwYth1%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: d33ec4525007 ("net: mvpp2: add an RSS classification step for each flow")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mvpp2_cls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 723d0ba..fc9ec51 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -618,7 +618,7 @@ static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
 	return 0;
 }
 
-u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
+static u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
 {
 	u16 hash_opts = 0;
 	int n_fields, i, field;
