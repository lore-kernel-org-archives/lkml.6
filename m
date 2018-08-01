Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26968C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29072083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNzo6+1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29072083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeHANJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:09:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34153 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeHANJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:09:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so8669640plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hrGARehJF+jE98FBlH8fXHCKOio57TlVwx/8oU41KwI=;
        b=CNzo6+1Z8S8n7ltoStYYeoAjxnrfEsck7qyQ0G8yun9LqLEk6CZA99J4dtWvpocnS7
         gpkTzm9hgcwOr+xFbLG3o2UGN6Q7eH61cK+r0ag6bAOoGp85DA2aW1F9utal5qGdYmoR
         hUFac6AM6MBcFQh23ep43z88P8HZ0sUDN6NoO5DJA0YyagMcW1wXZPkz9EpaYU/m8aN8
         DGR003Quk8s7C6sjKKNui27iXd7lWYl3npug2S9Ejq96fV7xoWrGxY1yvNved7KeVQNM
         NubkuHGTBQvswNswE19tj86pLfAGibRyjPrVL2qNGuyHIvNxIWfvHejvkhfnGcDm2MuD
         3kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hrGARehJF+jE98FBlH8fXHCKOio57TlVwx/8oU41KwI=;
        b=bcTIjJv5oPBr/7V9J3qFw4435oNcAeCyd2zb1bNmIQrNLoNUVva8B5J32IiS/icRP1
         S6RbH18KlZn1dK7Z/OZKoqiZCPNrz/635AArz6Md0EsDwK1zCM+ZDxXirW55Ip6SisFs
         /sncj5PwX4tru+eDVsLQvkUNnbnR/A76Kql4opI0Wv2q6YXwSJb9dnJJP3KH9i8XpbBF
         w7/sieCnlBxk8hR19o7BgOXHfTI55gJeV/qUPAA0dI9udjk9oPHQs9IaAQKPN1bBfc9/
         eiwb8BNk/JdXYmKa2seVj5GRUc51/FHzIoA2zzHT6+twFs8m0wYQjbDZz721j4+/r77P
         kIAQ==
X-Gm-Message-State: AOUpUlEokWM9/ceDGUDULaEgOrTylhj57zrt8MO1y+X846uNbVXYId6N
        KNhAfVtiYdWAeUuZHsWz2Ck=
X-Google-Smtp-Source: AAOMgpcGVFp7kVPiwL8xe6/FoUjvRC/91OC7CLFkIFvU1B+TaLezSS6wgr/YmTV5ObHY00+SOSZl0w==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14-v6mr23982032plo.139.1533122626818;
        Wed, 01 Aug 2018 04:23:46 -0700 (PDT)
Received: from localhost (outboundhk.mxmail.xiaomi.com. [207.226.244.123])
        by smtp.gmail.com with ESMTPSA id n24-v6sm36131543pfi.161.2018.08.01.04.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 04:23:46 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: add zstd compression support
Date:   Wed,  1 Aug 2018 19:23:37 +0800
Message-Id: <8da60549d9c649bc6f00cd82f70464b982ecb2a0.1533122560.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch added the 6th compression algorithm support for pstore: zstd.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/pstore/Kconfig    | 17 ++++++++++++++---
 fs/pstore/platform.c | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 09c19ef91526..63cf4813559a 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -50,12 +50,19 @@ config PSTORE_842_COMPRESS
 	help
 	  This option enables 842 compression algorithm support.
 
+config PSTORE_ZSTD_COMPRESS
+	tristate "zstd compression"
+	depends on PSTORE
+	select CRYPTO_ZSTD
+	help
+	  This option enables zstd compression algorithm support.
+
 config PSTORE_COMPRESS
 	def_bool y
 	depends on PSTORE
 	depends on PSTORE_DEFLATE_COMPRESS || PSTORE_LZO_COMPRESS ||	\
 		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
-		   PSTORE_842_COMPRESS
+		   PSTORE_842_COMPRESS || PSTORE_ZSTD_COMPRESS
 
 choice
 	prompt "Default pstore compression algorithm"
@@ -65,8 +72,8 @@ choice
 	  This change be changed at boot with "pstore.compress=..." on
 	  the kernel command line.
 
-	  Currently, pstore has support for 5 compression algorithms:
-	  deflate, lzo, lz4, lz4hc and 842.
+	  Currently, pstore has support for 6 compression algorithms:
+	  deflate, lzo, lz4, lz4hc, 842 and zstd.
 
 	  The default compression algorithm is deflate.
 
@@ -85,6 +92,9 @@ choice
 	config PSTORE_842_COMPRESS_DEFAULT
 		bool "842" if PSTORE_842_COMPRESS
 
+	config PSTORE_ZSTD_COMPRESS_DEFAULT
+		bool "zstd" if PSTORE_ZSTD_COMPRESS
+
 endchoice
 
 config PSTORE_COMPRESS_DEFAULT
@@ -95,6 +105,7 @@ config PSTORE_COMPRESS_DEFAULT
 	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
 	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
 	default "842" if PSTORE_842_COMPRESS_DEFAULT
+	default "zstd" if PSTORE_ZSTD_COMPRESS_DEFAULT
 
 config PSTORE_CONSOLE
 	bool "Log kernel console messages"
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index c238ab8ba31d..15e99d5a681d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -34,6 +34,9 @@
 #if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
 #include <linux/lz4.h>
 #endif
+#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
+#include <linux/zstd.h>
+#endif
 #include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
@@ -192,6 +195,13 @@ static int zbufsize_842(size_t size)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
+static int zbufsize_zstd(size_t size)
+{
+	return ZSTD_compressBound(size);
+}
+#endif
+
 static const struct pstore_zbackend *zbackend __ro_after_init;
 
 static const struct pstore_zbackend zbackends[] = {
@@ -224,6 +234,12 @@ static const struct pstore_zbackend zbackends[] = {
 		.zbufsize	= zbufsize_842,
 		.name		= "842",
 	},
+#endif
+#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
+	{
+		.zbufsize	= zbufsize_zstd,
+		.name		= "zstd",
+	},
 #endif
 	{ }
 };
-- 
2.17.1

