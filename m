Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3429920841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Opukkf/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3429920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbeHAJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44598 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeHAJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so8404585pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=68DGwEYhPm491eIfZZ6KO/KX2jzukwPpQsbkiYBWDXE=;
        b=Opukkf/0wWc9eGzUj6XgdTjU9cGErNSQjnL4XLZtEr66NATP3fC2Nd55/otDP6Jk41
         LZYQnjeYFyqlGr+gcK9uAD+nWrfUWaoyoBG42/6bIST40Q2+NTrTDWXGA5plcmH2UbSn
         S+FFm5HCGuPvK9E1HKml56RfSWFQfIsB8b4Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=68DGwEYhPm491eIfZZ6KO/KX2jzukwPpQsbkiYBWDXE=;
        b=QZlDjQcjhK9rmeiTrIB4FR9lsHTJZ/g4VTY/NXnbYiklPaScoUgG9ADsRKA9/qSw+n
         TD+JoU4CW8RFh1URZtbgJ8vRSqk6KtPsjU2q1NVN2lYUb0OzV2ckQdp+C6gRc2iIX+tj
         /qYGI7Epc5+C8SI0MQlBKvDy67qP8y3fhgv5im/vd4+CIJwNclcxk4rZrTfLXOcEVeMf
         rlc5gZsnR1eNAm/xwyStn8zyIhAJu0DkOXkdwT3kf7MIsWISlENhe4VSWs55OpYNNRXG
         PgeQFe/yMaY8otqRwopxZsy/9YX3yqP1OBuSQxnK5rJjRFwIyvvSCmPM2agvKJJtA5SS
         wSmg==
X-Gm-Message-State: AOUpUlHwjGgwx3OEZ43B0WEKXjrxAqbjZHqO8OmBub6uVTZAeOguZbjf
        DxikPf7a5LZ3XW/KMDMzYqwMFw==
X-Google-Smtp-Source: AAOMgpdHPnj3RppprbBSdZD1PUdyE6SMEmtZqbIlnESpFoIpLWJHfhTqjnjA48bVu0wNn9dNzzrPvw==
X-Received: by 2002:a17:902:778e:: with SMTP id o14-v6mr15537568pll.198.1533110389383;
        Wed, 01 Aug 2018 00:59:49 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g7-v6sm21547776pfi.175.2018.08.01.00.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 00:59:48 -0700 (PDT)
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
Subject: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date:   Wed,  1 Aug 2018 16:58:07 +0900
Message-Id: <20180801075820.3753-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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
 kernel/kexec_file.c                   |  4 ++++
 2 files changed, 4 insertions(+), 10 deletions(-)

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
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..bf39df5e5bb9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	/* Arch knows where to place */
+	if (kbuf->mem)
+		return 0;
+
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
-- 
2.18.0

