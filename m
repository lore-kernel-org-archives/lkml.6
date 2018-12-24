Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9393C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78BB21783
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="cd6RISGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLXHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:22:15 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:51353 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbeLXHWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:22:13 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Dec 2018 02:22:11 EST
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545635207; h=from:subject:to:date:message-id;
        bh=8v4/KKk+X6FipG/m4pDYobn/nLuJH7Dwnes+wppRiWo=;
        b=cd6RISGiQv+W7+xiA2NVXVuWt6fKcWcqyqzQYtcpi3goVoyenzL8HxI7DQzzkM5HuEADrlb0sM1
        6HMaKBS7fsykPPalntFKoZXkmqrJCjNV0Ona0iSuMV0u5w3JGBUw+RLGPgoEfulDzDCSO+V7GC4Hr
        GU0kBxsA0mbWiEB+Rd4=
Received: from localhost.localdomain (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 24 Dec 2018 15:06:47 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <sfr@canb.auug.org.au>, <alexey.skidanov@intel.com>,
        <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Date:   Mon, 24 Dec 2018 15:06:22 +0800
Message-ID: <20181224070622.22197-2-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181224070622.22197-1-sjhuang@iluvatar.ai>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may use the addr_in_gen_pool() in the driver module.
So export the addr_in_gen_pool for the compiling.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 lib/genalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 0d0ff9f0483f..9da91a16046f 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -450,6 +450,7 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
 	rcu_read_unlock();
 	return found;
 }
+EXPORT_SYMBOL(addr_in_gen_pool);
 
 /**
  * gen_pool_avail - get available free space of the pool
-- 
2.17.1

