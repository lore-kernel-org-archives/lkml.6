Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9210FC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE702086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE702086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeINBjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:39:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35899 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINBjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:39:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so10750135oie.3;
        Thu, 13 Sep 2018 13:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ine3I2LJVb7aK1NudtLxCUAku4mC991Izt/kipSue3A=;
        b=hMSigNknvbB1iR9XLhAVVP9VGu7pztdVHwUC8Lsd9i0GQtP5kvzBVlSxFVaFG2TxSA
         GXBAOML4Kxqr3TnGgG7PhL5KMHc60ELeLG6FFOtxcwTENqn79OgE55l864jcOqKuvcic
         XkTMAW/p9DiD/52s/2MuGhjoAugOTHaAl4UkUT6AIhdTflppLyIdD5IwFi94ScIHzEYJ
         R8kj4LM35dymrBNts0/WaYLlBw3eCQBw65mh4Tk1A95YJid6qTUtW2JcGGF0DfTVoEbk
         NYjDYaoFDUTVu6uOVekUNYjmoQTAdjx3scoNS7OoEbU+GEl5cE/GgEIADJsENnYU31qw
         mP8Q==
X-Gm-Message-State: APzg51BtH95pv9rH3SgZF2u3OkSmH2F2HevwS1hNM+A9YtCDKHNcPRIV
        QQp4xBVIlcbA+y1NdTxjQYAJ1zQ=
X-Google-Smtp-Source: ANB0VdbiVQ8tjfx43inyxqCDv7OPT84D3XcijC//KHFZ953VXzBHgQskJO7oga2wV/y0kzEIkUT4qw==
X-Received: by 2002:aca:34d6:: with SMTP id b205-v6mr7234040oia.77.1536870510427;
        Thu, 13 Sep 2018 13:28:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h34-v6sm756745otb.71.2018.09.13.13.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 13:28:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] libfdt: Ensure INT_MAX is defined in libfdt_env.h
Date:   Thu, 13 Sep 2018 15:28:26 -0500
Message-Id: <20180913202828.15372-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next update of libfdt has a new dependency on INT_MAX. Update the
instances of libfdt_env.h in the kernel to either include the necessary
header with the definition or define it locally.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/compressed/libfdt_env.h | 2 ++
 arch/powerpc/boot/libfdt_env.h        | 2 ++
 include/linux/libfdt_env.h            | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 07437816e098..b36c0289a308 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -6,6 +6,8 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index 2a0c8b1bf147..2abc8e83b95e 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -5,6 +5,8 @@
 #include <types.h>
 #include <string.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 #include "of.h"
 
 typedef unsigned long uintptr_t;
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index c6ac1fe7ec68..edb0f0c30904 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -2,6 +2,7 @@
 #ifndef LIBFDT_ENV_H
 #define LIBFDT_ENV_H
 
+#include <linux/kernel.h>	/* For INT_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
-- 
2.17.1

