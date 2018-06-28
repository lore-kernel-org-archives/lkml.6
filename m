Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05621C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8965240BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8965240BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeF1Lnn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:43:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:40364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934344AbeF1Lnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:43:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 04:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,283,1526367600"; 
   d="scan'208";a="68451467"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 28 Jun 2018 04:43:36 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYVKq-0009zD-4L; Thu, 28 Jun 2018 19:43:36 +0800
Date:   Thu, 28 Jun 2018 19:42:37 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     kbuild-all@01.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] crypto: ccree: cc_update_ctr() can be static
Message-ID: <20180628114237.GA119685@athens>
References: <1530171175-31960-4-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530171175-31960-4-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 27646566a1a0 ("crypto: ccree: fix iv handling")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 cc_cipher.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 3af44a5..958ced3 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -596,7 +596,7 @@ static void cc_setup_cipher_data(struct crypto_tfm *tfm,
 /*
  * Update a CTR-AES 128 bit counter
  */
-void cc_update_ctr(u8 *ctr, unsigned int increment)
+static void cc_update_ctr(u8 *ctr, unsigned int increment)
 {
 	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
 	    IS_ALIGNED((unsigned long)ctr, 8)) {
