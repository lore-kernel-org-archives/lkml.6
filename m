Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96418C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1B20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D1B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeLLIYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:24:02 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33688 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbeLLIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:24:01 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0807464|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DWG3E1v_1544603033;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DWG3E1v_1544603033)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 12 Dec 2018 16:23:58 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH] pstore: fix crypto dependencies of 842/zstd compression
Date:   Wed, 12 Dec 2018 16:23:58 +0800
Message-Id: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference to commit 58eb5b670747 ("pstore: fix crypto dependencies"),
which fixed crypto dependencies of deflate, lzo, lz4 and lz4hc
compression, but omitted 842 and newer compression zstd from
commit 1021bcf44d0e ("pstore: add zstd compression support")

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 0d19d19..7068f45 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -44,14 +44,14 @@ config PSTORE_LZ4HC_COMPRESS
 	  This option enables LZ4HC (high compression) mode algorithm.
 
 config PSTORE_842_COMPRESS
-	bool "842 compression"
+	tristate "842 compression"
 	depends on PSTORE
 	select CRYPTO_842
 	help
 	  This option enables 842 compression algorithm support.
 
 config PSTORE_ZSTD_COMPRESS
-	bool "zstd compression"
+	tristate "zstd compression"
 	depends on PSTORE
 	select CRYPTO_ZSTD
 	help
-- 
1.9.1

