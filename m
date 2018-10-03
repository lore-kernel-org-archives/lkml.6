Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66237C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB220878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozkGzWC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJCJ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id q17-v6so2707761plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=ozkGzWC1BS/YfjLwcS6q3JARNRWaHL6yjlm4R3ayBowh6ZlDwa1ZBvqq6jXSGo79CO
         0eOOUIcz2M8LnamirEJORIag5ip8ElyW3/6fpmQa6D5q1wx9DS8VpFQ+tgrI/7w1mdtn
         3zwyu3yEk7JldyPEMu/d1c2Fx/D25CEPQ1eBpklu58o7hQUZL6GjH0RSr/t131djvtTY
         N8q7wbs6MwJxlgSbS4C0Vx5hK0fKd0yxbe+tIY6zPMOMcb0EsqHFCDnjLya8RrlnVWZr
         Ln/g3teDqx7ZPgHvZEMGDf683wIRwJgdfGE1Cfi5XB+UMnSa8VSOW4IMIG3K3+RJFlip
         9acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=H8FRqVKARkFtaqImZuZxGnWvvG4gx8MtZiEKsZCRln5Idn+az6eGX9my7ppfQqB7Bx
         gEluA7/QQp2rp6b71vEK3a523pRNkAwLBu9LJyfSOfdFltkwbklcA3uUpHRyMnWe2zSJ
         pDK+whRuxBgcA3GLHPsEkkhGlsLucAuFaCR5LoxQgo15/B4bjaFF+FwgacrprGOmgN6T
         re9Ue9sS1v1C4z1zY/zASkONFJ2Yoc+m3tsbwgQ7a3bMS+PkGEjbS+ymFy92RVg5jfDt
         4X2DxXtYtNpObsSM480esH4eMo7k9Zo+5XaB8bmypvPTR7hmYNfbrcCxxwigCH2SLm9p
         0U+Q==
X-Gm-Message-State: ABuFfogRW3I0miuanQEK9P5/Rd+fsOr18/uQV5Mlv1zEDCM85Rl36tDw
        h16KVDyvAMlD5KkJ0+pCr3w=
X-Google-Smtp-Source: ACcGV63IdAyq+FT0Bm8b1xU4VCTVmILjCPLP0XzQ6AUKiVnXv9KTKwfkDXoXHJeO49FnOiHiR5LriQ==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr19472163plc.270.1538536361445;
        Tue, 02 Oct 2018 20:12:41 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:40 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v4 1/5] RISC-V: Build tishift only on 64-bit
Date:   Wed,  3 Oct 2018 11:09:58 +0800
Message-Id: <bedaad30d6ab1102e195c50d8c919bcef70b3b24.1538535528.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
References: <cover.1538535527.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports 128 integer size.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 445ec84..5739bd0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -2,6 +2,7 @@ lib-y	+= delay.o
 lib-y	+= memcpy.o
 lib-y	+= memset.o
 lib-y	+= uaccess.o
-lib-y	+= tishift.o
+
+lib-(CONFIG_64BIT) += tishift.o
 
 lib-$(CONFIG_32BIT) += udivdi3.o
-- 
2.7.4

