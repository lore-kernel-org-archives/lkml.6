Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E9206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcvFPXdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660E9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeIGMhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:37:24 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:36477 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeIGMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:37:24 -0400
Received: by mail-pl1-f174.google.com with SMTP id e11-v6so6231064plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFZdSzOBCDhCucMx9QLxaQGXbSUDnlXX6wiHP7BXxqU=;
        b=NcvFPXdYdZnDZNUVaQmm1LA4c2cwtD4jx3+WjEo8Va01rghMCP75wL98HCDEiKEYvr
         gafPvWw6Fq5vvgw1w6y3oLFWGyMnKqI+8chfWup9dmIjcNopmB2AM6xhsOdh1VACxtHz
         mIx7zRckOMd9qDkvOk9BiiHRfQ7z7O5wM+3TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UFZdSzOBCDhCucMx9QLxaQGXbSUDnlXX6wiHP7BXxqU=;
        b=iJTGoeNKQrQwuQ1kqlDn3UrRe+i2AkIxteSpnCvC/ZTM+55cca1S9WGL77blOWNJ4s
         sd2pJgOZjzXGf6QvNvzyx8qctHTn/pWqXlLZqwbEqa1p7LpjwgKKMVV5GgExwt+rEVyB
         2FQp83UilU5dIDoebu0T12jJ50N9+PS3fifdlQycWbXLbLpb2zJM10eGNYxWWt5mo4/j
         P6sTAzwLoRfBSYvrm7MMr6rhq52q+6Cysd6akZBitSNgbWkYtzm64rD595oSZ+dyu9dU
         Q03/gJ0ZeNLDl+0rCCcyj1euz0CaMc/y9KqjVY2v7hpUpG8i24MtNSXJZWscSI79B7oP
         96rg==
X-Gm-Message-State: APzg51ABur1QY9qvg90Z6kltfhU6sqmaCGsrPZYRojFlD1vpI7Jy3tlK
        qdw8M0gxs0CtzaH1rYq+klEFiw==
X-Google-Smtp-Source: ANB0VdZfil51JUnpmyhtdzSSLzTm0D/G1dShFjmbF9UAvtCZSnPX7baPMcWHq0drrGHkqyRQMTA8jQ==
X-Received: by 2002:a17:902:5a87:: with SMTP id r7-v6mr6601602pli.247.1536307060716;
        Fri, 07 Sep 2018 00:57:40 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f87-v6sm19872299pfh.168.2018.09.07.00.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:57:40 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date:   Fri,  7 Sep 2018 16:56:40 +0900
Message-Id: <20180907075653.4696-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907075653.4696-1-takahiro.akashi@linaro.org>
References: <20180907075653.4696-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since s390 already knows where to locate buffers, calling
arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
indicates this while all other architectures sets it to 0 initially.

This change is a preparatory work for the next patch, where all the
variant memory walks, either on system resource or memblock, will be
put in one common place so that it will satisfy all the architectures'
need.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 10 ----------
 include/linux/kexec.h                 |  8 ++++++++
 kernel/kexec_file.c                   |  4 ++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index f413f57f8d20..32023b4f9dc0 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
 	return ret;
 }
 
-/*
- * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
- * and provide kbuf->mem by hand.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	return 1;
-}
-
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 49ab758f4d91..f378cb786f1b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -145,6 +145,14 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
+/*
+ * If kexec_buf.mem is set to this value, kexec_locate_mem_hole()
+ * will try to allocate free memory. Arch may overwrite it.
+ */
+#ifndef KEXEC_BUF_MEM_UNKNOWN
+#define KEXEC_BUF_MEM_UNKNOWN 0
+#endif
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..0fcaa86219d1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
-- 
2.18.0

