Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A527A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBTOJQLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A527A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeGWC6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:58:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46609 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGWC6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:58:24 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so4986923ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erM0Z9H4UEy3rQv1/bN5wC7X6sLU17kati65NrFno1I=;
        b=TBTOJQLkajO3HY6BXZarrvI5rygueAf02u7zvXLiL8oTEfyaCJiEWTAKkFQD5siKva
         mwaNxKr1ko7O/hpoL0Yf46+dJ/Gmq4FUsvC+B1nuuSBCRmjKi15MRKmf61rtoDX8JMnh
         nAAee1TLGfgJeNxcajORbEOx9nj83BlAi5ICU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erM0Z9H4UEy3rQv1/bN5wC7X6sLU17kati65NrFno1I=;
        b=uGU//AUicRI//PR+UpxHnK+g9mXaOQAQjNqOAGxjZ7Dq+O95FBZrvwTv5LGmTkeAzd
         DYeU6RelqMHh/HoSPWUy5sr1tWepi+ZrNfx3ZBWOzNacC0tjhGKmGZEAB7p0bkgTOAB9
         P0z3xHvqnxyClPog6WiFgAJEL8z9RXN3d5pZyKECBsGuSDpEhomwZn7K/8aYGewz1LWJ
         QD6jdMGUbCZCdRi7igPQluHMopQNGlI/nbDzpRiIinJe+OHsDpgOfqIIFxd42PJjnz+r
         csUEe2je3oC+jAd0P+QHWAXnJfqjWBZ2S/P6/1SXkena+42Wyi0fez2D+q5tmzFrTz40
         1a4g==
X-Gm-Message-State: AOUpUlHv+h2IixoNMw+XYUpW306kzl6eNAtu0+pLxT7uloFHWxuu6TqL
        a7WTynPj0Lt+ABXOEFcIN+6Jsg==
X-Google-Smtp-Source: AAOMgpcSpIUIcUkR3QCXsLSSr+NEIoUVNT6LpOgFCnbyOdGoKRDptWin1nb676nh1J6ZGLVtbaziSA==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr11083324plf.115.1532311176843;
        Sun, 22 Jul 2018 18:59:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id h190-v6sm15115682pge.85.2018.07.22.18.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 18:59:36 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v4 3/5] efi/arm: preserve early mapping of UEFI memory map longer for BGRT
Date:   Mon, 23 Jul 2018 10:57:30 +0900
Message-Id: <20180723015732.24252-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The BGRT code validates the contents of the table against the UEFI
memory map, and so it expects it to be mapped when the code runs.

On ARM, this is currently not the case, since we tear down the early
mapping after efi_init() completes, and only create the permanent
mapping in arm_enable_runtime_services(), which executes as an early
initcall, but still leaves a window where the UEFI memory map is not
mapped.

So move the call to efi_memmap_unmap() from efi_init() to
arm_enable_runtime_services().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c    | 1 -
 drivers/firmware/efi/arm-runtime.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index b5214c143fee..388a929baf95 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -259,7 +259,6 @@ void __init efi_init(void)
 
 	reserve_regions();
 	efi_esrt_init();
-	efi_memmap_unmap();
 
 	memblock_reserve(params.mmap & PAGE_MASK,
 			 PAGE_ALIGN(params.mmap_size +
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..59a8c0ec94d5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
 		return 0;
 	}
 
+	efi_memmap_unmap();
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
-- 
2.18.0

