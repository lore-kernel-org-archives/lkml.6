Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9016DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4384E24ACD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNofj1H0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4384E24ACD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeFWCV4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43723 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeFWCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so3991581pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kjrhtHupdHh4T5Hnsk+P2sAae5O1LRvrUqSekVnnVSw=;
        b=kNofj1H0U7Jw4ClKkIBEMiVX02MACndzKKCawpN+Ze9B3jo6c4pewzlZtXN+62sR87
         p/niEICqNaT2bXBkULcysrad368qaB1aMcZznES1lHarEOYCJbBueMORBP5d5U7e8teN
         n4zukzR+/fEZ4yFinkoL/i316OWePqGkYwrhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kjrhtHupdHh4T5Hnsk+P2sAae5O1LRvrUqSekVnnVSw=;
        b=eZHVywgCz/FU+WXrcG81e7Kl+bw7dk+SYcGznV5qxsSeYlJlQFF6y04YHDr9GKIO4K
         nSidFGb8/BYCGDqzfC8UaG9nd9iNSJZiGUenZYg5NTDLv7wWKwzuS/ZX1WkXk50EzjTY
         D1EXnMVMG3ucr1CFw5+is2l0PwX3TdwX1JHMR+vGLPABRH7AyWVX51J4joJdkF4O+oY1
         niGYILhT+pMFNQZnEAVLXStuUskme212qdlCD0SBbCJcSdc+oSQddSTup1KIrO0sQfdK
         AfhJ8unV6H9fbRJhsWmclNKJQKInD2vYQ9ZpH8ic/LyjI+psiwrrtkm04FvzTC242lJp
         dAtw==
X-Gm-Message-State: APt69E0j2VO3Ijb5HLabmTXkVE/Tf8lXSvbQuPCzkdNxMRVVh1nWwNcr
        uYDmf5cEIKsaN4StQL7uXoMt1w==
X-Google-Smtp-Source: ADUXVKKuYQTI4ZVrrOJAWwRe4rSjJIpAs2BYccNzkFVQpFkhzl+mZt8NFLdebP6YCqEV9gPVerIJPQ==
X-Received: by 2002:a63:2b88:: with SMTP id r130-v6mr3349043pgr.170.1529720512561;
        Fri, 22 Jun 2018 19:21:52 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id e81-v6sm19973085pfb.62.2018.06.22.19.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:52 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 14/14] arm64: kexec_file: add kaslr support
Date:   Sat, 23 Jun 2018 11:20:58 +0900
Message-Id: <20180623022058.10935-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "kalsr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it wll have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 6aec996d015a..1283c1d912f2 100644
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
@@ -132,6 +133,12 @@ static int setup_dtb(struct kimage *image,
 			goto out_err;
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
2.17.0

