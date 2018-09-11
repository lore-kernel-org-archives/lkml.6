Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E00FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD9F20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD9F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeIKKSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:18:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:9854 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeIKKSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:18:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="231841860"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Sep 2018 22:20:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzb67-000FPF-CK; Tue, 11 Sep 2018 13:20:23 +0800
Date:   Tue, 11 Sep 2018 13:20:07 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     kbuild-all@01.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] crypto: dpaa2_caam_iova_to_virt() can be static
Message-ID: <20180911052007.GA10279@ivb42>
References: <20180910171550.5659-8-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910171550.5659-8-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 10c08052347f ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 caamalg_qi2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index e883386..af8d890 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -80,8 +80,8 @@ struct caam_ctx {
 	unsigned int authsize;
 };
 
-void *dpaa2_caam_iova_to_virt(struct dpaa2_caam_priv *priv,
-			      dma_addr_t iova_addr)
+static void *dpaa2_caam_iova_to_virt(struct dpaa2_caam_priv *priv,
+				     dma_addr_t iova_addr)
 {
 	phys_addr_t phys_addr;
 
