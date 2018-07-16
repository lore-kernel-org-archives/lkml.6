Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9858DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD102084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD102084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeGPNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:07:37 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.131]:27259 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729607AbeGPNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:07:32 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 6C417402E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:40:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id f2mvfXPpkbXuJf2nGffTpt; Mon, 16 Jul 2018 07:40:15 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=48026 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ff2mu-002L0q-6J; Mon, 16 Jul 2018 07:39:36 -0500
Date:   Mon, 16 Jul 2018 07:39:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/selftests: Remove redundant code
Message-ID: <20180716123933.GA27121@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ff2mu-002L0q-6J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:48026
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err is assigned to -EIO, but this value is never actually
used and *err* is updated later on.

Remove such reduntant code.

Addresses-Coverity-ID: 1471816 ("Unused value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/selftests/intel_guc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/intel_guc.c b/drivers/gpu/drm/i915/selftests/intel_guc.c
index 407c98f..c10e75c 100644
--- a/drivers/gpu/drm/i915/selftests/intel_guc.c
+++ b/drivers/gpu/drm/i915/selftests/intel_guc.c
@@ -206,7 +206,6 @@ static int igt_guc_clients(void *args)
 
 	if (!available_dbs(guc, guc->execbuf_client->priority)) {
 		pr_err("doorbell not available when it should\n");
-		err = -EIO;
 		goto out_db;
 	}
 
-- 
2.7.4

