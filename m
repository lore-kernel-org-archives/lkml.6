Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C2A5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39D208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C39D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934284AbeFLOup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:50:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:33186 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbeFLOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:50:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="63434973"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2018 07:50:42 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fSkd4-000WXt-A6; Tue, 12 Jun 2018 22:50:38 +0800
Date:   Tue, 12 Jun 2018 22:50:37 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@01.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ath10k: ath10k_snoc_get_ce_id_from_irq() can be static
Message-ID: <20180612145037.GA95182@lkp-ib03>
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612113907.15043-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: aecf55e7df3a ("ath10k: allow ATH10K_SNOC with COMPILE_TEST")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 snoc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index a3a7042..92ddb1c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -820,7 +820,7 @@ static const struct ath10k_bus_ops ath10k_snoc_bus_ops = {
 	.write32	= ath10k_snoc_write32,
 };
 
-int ath10k_snoc_get_ce_id_from_irq(struct ath10k *ar, int irq)
+static int ath10k_snoc_get_ce_id_from_irq(struct ath10k *ar, int irq)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	int i;
@@ -868,7 +868,7 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 	return done;
 }
 
-void ath10k_snoc_init_napi(struct ath10k *ar)
+static void ath10k_snoc_init_napi(struct ath10k *ar)
 {
 	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll,
 		       ATH10K_NAPI_BUDGET);
