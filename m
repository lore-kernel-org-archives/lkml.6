Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7BAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw0Yios/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbeLQPDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33258 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbeLQPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so9695554lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQMuRzWOBhHTvXfYtOTPGwd5FvN5/WsTMjmOY5C33tI=;
        b=Vw0Yios/NN0dTV584a1Qod/ElQP5ApqFVgTyy5SAdlZaDd6bIbsbv2W99RoZferYv/
         IvoO165WLhANh8vvuZzBSvRRtqMKBE4a2eTcdkhQlBSgymQj+zftWz4mIH9oJUaU+H4j
         sdNbgXrjHP6DikeTuSjBrdWE02dsWtKj2QQ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQMuRzWOBhHTvXfYtOTPGwd5FvN5/WsTMjmOY5C33tI=;
        b=dO4tylhOG8DxIuWB+GLOy7Pk/SOZexmZPa1opQV9m4RPAIPTxWZ8yJZgZQhg94qr7Z
         9IyDv8nZP+c6ZPy+aM4wD+cldsL/cwMfof0V2032qUDeg12/7b97joqkpJF5O7W0J9SV
         OcetJtxaZKz3kgvjquHedQeCwDltyY+RfHuUhqbeRi8IbH3AYb3j7k88OuLShIRy3qOR
         7sb4QF31km9RYHJE/7HGvEdwyLaiY+cAYAA/isFm87YQyZD7zX9tpX2CLaI6bS8nz0TQ
         T4DhLalUqoRtFbkkbUPnU8Fd9hr/vsctLVo3cvZXhCHONXXK3FiLYuL0fkbXczUeiyN+
         iC0g==
X-Gm-Message-State: AA+aEWZcPPjBdElHyf/YRj6Aq4fU0juxjWlIdkVUwxY8pfv1kyuHZOEW
        1VBoR1nhrb8USURV/uSzzws1Lw==
X-Google-Smtp-Source: AFSGD/VmyysweIcZ6MMMXbrVi/mqjFGcz83mx2DYDt5L5Jl4PE76r9++fLhDW227NbzuJqanFmpaew==
X-Received: by 2002:a19:3809:: with SMTP id f9mr7249686lfa.148.1545059012077;
        Mon, 17 Dec 2018 07:03:32 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id z15-v6sm3030076ljb.9.2018.12.17.07.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:31 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aryabinin@virtuozzo.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] lib/ubsan: default UBSAN_ALIGNMENT to not set
Date:   Mon, 17 Dec 2018 16:03:26 +0100
Message-Id: <20181217150326.30933-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting an allmodconfig kernel, there are a lot of false-positives.
With a message like this 'UBSAN: Undefined behaviour in...' with a call
trace that follows.

Reworked so that when building a allmodconfig kernel that turns
everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.ubsan | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 98fa559ebd80..a2ae4a8e4fa6 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -27,15 +27,19 @@ config UBSAN_SANITIZE_ALL
 	  Enabling this option will get kernel image size increased
 	  significantly.
 
-config UBSAN_ALIGNMENT
-	bool "Enable checking of pointers alignment"
+config UBSAN_NO_ALIGNMENT
+	bool "Disable checking of pointers alignment"
 	depends on UBSAN
-	default y if !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	default y if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
-	  This option enables detection of unaligned memory accesses.
-	  Enabling this option on architectures that support unaligned
+	  This option disables the check of unaligned memory accesses.
+	  This option should be used when building allmodconfig.
+	  Disabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
+config UBSAN_ALIGNMENT
+	def_bool !UBSAN_NO_ALIGNMENT
+
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
 	depends on m && UBSAN
-- 
2.19.2

