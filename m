Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E084C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273D220675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeLNNjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:39:21 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50316 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728415AbeLNNjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:39:21 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07703226|-1;CH=green;FP=17861118287567185914|1|1|5|0|-1|-1|-1;HT=e01e01542;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DXQyAtf_1544794713;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DXQyAtf_1544794713)
          by smtp.aliyun-inc.com(10.147.42.198);
          Fri, 14 Dec 2018 21:38:38 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH v2] pstore: turn compression options back to 'bool'
Date:   Fri, 14 Dec 2018 21:38:31 +0800
Message-Id: <1544794711-30015-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On commit 58eb5b670747 ("pstore: fix crypto dependencies"),
dependency bug was fixed by selecting the crypto core rather than
turned compression sub-options to 'tristate'.
In addition, these options are used to enable/disable compression. They
are not modules, and mean nothing when set to 'M'.
So, this patch is going to turn them back to 'bool'.

Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 0d19d19..8b3ba27 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -14,7 +14,7 @@ config PSTORE
 	   say N.
 
 config PSTORE_DEFLATE_COMPRESS
-	tristate "DEFLATE (ZLIB) compression"
+	bool "DEFLATE (ZLIB) compression"
 	default y
 	depends on PSTORE
 	select CRYPTO_DEFLATE
@@ -23,21 +23,21 @@ config PSTORE_DEFLATE_COMPRESS
 	  algorithm support.
 
 config PSTORE_LZO_COMPRESS
-	tristate "LZO compression"
+	bool "LZO compression"
 	depends on PSTORE
 	select CRYPTO_LZO
 	help
 	  This option enables LZO compression algorithm support.
 
 config PSTORE_LZ4_COMPRESS
-	tristate "LZ4 compression"
+	bool "LZ4 compression"
 	depends on PSTORE
 	select CRYPTO_LZ4
 	help
 	  This option enables LZ4 compression algorithm support.
 
 config PSTORE_LZ4HC_COMPRESS
-	tristate "LZ4HC compression"
+	bool "LZ4HC compression"
 	depends on PSTORE
 	select CRYPTO_LZ4HC
 	help
-- 
1.9.1

