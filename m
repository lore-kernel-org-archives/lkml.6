Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA34208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlhWdrQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA34208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeGIXmN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:42:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41477 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeGIXmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:42:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so6732605ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2uAeoq4DfhThX9UGnhckbXMfikniIsoGM7JqtwAgeE=;
        b=BlhWdrQdQObN6Qd3dd/qLgvGSfL8WL8Iu/kO0R0s1i1ORgRCkiSEnJ2b0H15tEicAu
         +uxrPb9/wSnO2Xu2sQOgyoBb5GVibE8T26/BlDC9hEnBzvkW7zJ5ir0+Q8JPyl3W2wnB
         9+yM5BgN++j3Cdz6f0+3JtJcDyAdatG5/QgHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G2uAeoq4DfhThX9UGnhckbXMfikniIsoGM7JqtwAgeE=;
        b=MjxJLDrM3tHuBVkPI/yFOfLIbHcGR0m5cQuWLySU1yHuB67PIGinCDoddFjpll3Q6o
         p+r7dFf8/fGUAOhzncQ5pDTvSbfKk5UA+SHA8JP3hvjiLFz5gUZueamUJIoQDfoThvX5
         JBS0ze0dOonOncPV4BqHYBFenxDVu9wRBu9WCNmZoCMY9WaLPmq+tJFG9f/WoTJh7eY6
         VczuW/tpWBBb6eBgwRvvHL+597h0JIZoncDKEAj5mRYArgDGcNniSHRoMsrvr8OSO1Nr
         bdBYH0FHLNhIPRL7RJeEbfYCoFvH3Qgpp/mXjnJjjffCwzFeksoWAV5v1+6rFgv4kSAg
         RqNg==
X-Gm-Message-State: APt69E0Wk3fnp9ehrMHJTn3Deu+v7pWdiBeiFYOJQIeTNO2r95zxmZek
        NNpnTqDRXmB+nC8cBZAoBIi+AQ==
X-Google-Smtp-Source: AAOMgpeK5XTxIBPZbKlC787F1h7QZ/CVmLQLtaTugHCMv3y2BrWimRZYgCGCiGH8CGTFiC43g/fHIA==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6-v6mr22415286plt.286.1531179728447;
        Mon, 09 Jul 2018 16:42:08 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id h190-v6sm12823541pge.85.2018.07.09.16.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:42:07 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory map longer for BGRT
Date:   Tue, 10 Jul 2018 08:42:27 +0900
Message-Id: <20180709234229.20181-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709234229.20181-1-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
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
2.17.0

