Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B43C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC82220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOBGvQ46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC82220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbeGXIET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:04:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37639 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:04:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so2192898pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DjZGq5WnpjvJN9iGuoJut9k6LjLfxTrv7tJcxElB2q4=;
        b=LOBGvQ46EyOi/qHw58fwmvardQ5MtYZdZsKI2bhd3NPyZ5Ngm05h1zVfpxB28HzYsy
         cC4OHjfFrWjqeyA6R50p272ExOYbm2fuM7josvLnYlfJCXoyHAdXS4h6od0vIP6qBJNY
         +HYqMAUASv9ZTXy+It/cFonObSZhmrKAg+Pqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DjZGq5WnpjvJN9iGuoJut9k6LjLfxTrv7tJcxElB2q4=;
        b=pdE6aXCp54pgPajzfqX9F41/H0FDXmIF5YegGs7/jr2b2wAYaK9AuEmFE8dF8lpT0K
         sVplZhER+oQTVTf0e5ccRRbJfZl4Lag88e+owO5lVRfvDCcfr93rXvPyVZaqNijAk5Bw
         +UYIZj9Nqj8rGOiSfw4iY0pnL5YEQSBXLAyV0rlDBQNGPwNV0sE/0pXrCsN+NqfEEn/A
         iGamXZgTXYDlsLP8bv1Ns+EQUOXN9lKYqQ+D1n28lmmRF2H0EV7uxW9N0O/f0A8JIJ9R
         aL9LfRWC8JMOacU/ExxzxrFUi3EI8ZAWZ4Qa+wLjV8p7VH1P7iXYe+Rm4pFQG4R6XKKz
         dSDw==
X-Gm-Message-State: AOUpUlG5XTO+VXC0cdVP26gNhggjusa1qmHXtfSeKVSAyuopeiOFvjXC
        NKQc/+m5Tp52Ln8gB6WjsbwEqw==
X-Google-Smtp-Source: AAOMgpeZJQX0AFXWrZnMLMf6ZKT19Qyca3w2nyk84CUXSpX7nVw5iYBL8EJwUB53Ymd+ne0tHPLXTA==
X-Received: by 2002:a63:db05:: with SMTP id e5-v6mr15062646pgg.152.1532415560822;
        Mon, 23 Jul 2018 23:59:20 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c6-v6sm2027520pfg.138.2018.07.23.23.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:59:20 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
Date:   Tue, 24 Jul 2018 15:57:59 +0900
Message-Id: <20180724065759.19186-17-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it will have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7356da5a53d5..47a4fbd0dc34 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
@@ -46,6 +47,7 @@ static int setup_dtb(struct kimage *image,
 	void *buf = NULL;
 	size_t buf_size, range_size;
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	/* check ranges against root's #address-cells and #size-cells */
@@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,
 		}
 	}
 
+	/* add kaslr-seed */
+	get_random_bytes(&value, sizeof(value));
+	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));
+	if (ret)
+		goto out_err;
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.18.0

