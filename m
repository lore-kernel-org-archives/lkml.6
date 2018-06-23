Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB6C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DFB24ABB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpDlmN+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DFB24ABB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934753AbeFWCVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:11 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:41524 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:08 -0400
Received: by mail-pl0-f47.google.com with SMTP id w8-v6so4273946ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QlhV7eDSbsU4GPDGTwzyQDGWNJMnX8a7YNDVlGTagBM=;
        b=LpDlmN+OsYjFbyDSsEpoClCn/Pz9gUAmYcvMoF2+088NDTQta0e1d717zm5GoFqKma
         G99hLqSylXi/k+GgXKMmi3avEG013+TtrfU8M7Re/YoYKewWhk3KdWFycySY7N7gCOp7
         LiaU56/bTKCBxENMFWlTiFA2vHwC6ahnOHGHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QlhV7eDSbsU4GPDGTwzyQDGWNJMnX8a7YNDVlGTagBM=;
        b=b6r0er3hsnV03MK0DJ3iZKrb0H0NInltG8oyBbUCaA9nRwDV/cS+2vAaUOi1D/gICn
         5GEYBYOaqDT9TU+qLnZoDD6h44p5fu8RHrKtTI1H0hRLbpMQIiZ3fxjxodMFgtm99Sod
         XQe6tTCw5QhJHrt4wCizf63H5RoOuxx5B36fRmJd/pzHCTeTTeBxukRZtQg7B/hRi4bx
         rf/t2NLaBHicYsTND2eYxghUPcQrNTPIVsoTKxMuGi08CvoqaORbVbbU+6Q2TPeR4ZDd
         3ADiZ8DG7L9TAxNmkQ5ByuDwhhN/Bt+vERL/ME7Za3HVuzPGSczs+u7pFXDZ5Xz38wP4
         EOSw==
X-Gm-Message-State: APt69E2AqoKVnNmZj3JwmpKr2dyUszG+pF+dZcGrhonTerhU1MPeOsFo
        omK1t+7MKRwb4gCICooOy6Wl+A==
X-Google-Smtp-Source: ADUXVKJun1lY3LX4iqRiEQMehr+U5Xw+otdtPrfL0oxbdXIYdES51zsViDw1rz4n2oNTYzsRKBdYFw==
X-Received: by 2002:a17:902:422:: with SMTP id 31-v6mr3862394ple.320.1529720468323;
        Fri, 22 Jun 2018 19:21:08 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k69-v6sm15243965pgc.39.2018.06.22.19.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:07 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v10 04/14] of/fdt: add helper functions for handling properties
Date:   Sat, 23 Jun 2018 11:20:48 +0900
Message-Id: <20180623022058.10935-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions will be used later to handle kexec-specific properties
in arm64's kexec_file implementation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/of_fdt.h | 10 +++++--
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9688f7..f7c9d69ce86c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
 /* Everything below here references initial_boot_params directly. */
-int __initdata dt_root_addr_cells;
-int __initdata dt_root_size_cells;
+int dt_root_addr_cells;
+int dt_root_size_cells;
 
 void *initial_boot_params;
 
@@ -1330,3 +1331,60 @@ late_initcall(of_fdt_raw_init);
 #endif
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
+
+bool of_fdt_cells_size_fitted(u64 base, u64 size)
+{
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
+		return false;
+
+	if ((dt_root_size_cells == 1) && (size > U32_MAX))
+		return false;
+
+	return true;
+}
+
+size_t of_fdt_reg_cells_size(void)
+{
+	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
+}
+
+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
+
+int fdt_prop_len(const char *prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
+static void fill_property(void *buf, u64 val64, int cells)
+{
+	__be32 val32;
+
+	while (cells) {
+		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
+		memcpy(buf, &val32, sizeof(val32));
+		buf += sizeof(val32);
+	}
+}
+
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size)
+{
+	char buf[sizeof(__be32) * 2 * 2];
+		/* assume dt_root_[addr|size]_cells <= 2 */
+	void *prop;
+	size_t buf_size;
+
+	buf_size = of_fdt_reg_cells_size();
+	prop = buf;
+
+	fill_property(prop, addr, dt_root_addr_cells);
+	prop += dt_root_addr_cells * sizeof(u32);
+
+	fill_property(prop, size, dt_root_size_cells);
+
+	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..9615d6142578 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 				   struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
-extern int __initdata dt_root_addr_cells;
-extern int __initdata dt_root_size_cells;
+extern int dt_root_addr_cells;
+extern int dt_root_size_cells;
 extern void *initial_boot_params;
 
 extern char __dtb_start[];
@@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
+bool of_fdt_cells_size_fitted(u64 base, u64 size);
+size_t of_fdt_reg_cells_size(void);
+int fdt_prop_len(const char *prop_name, int len);
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_OF_FDT_H */
-- 
2.17.0

