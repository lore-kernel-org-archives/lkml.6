Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A466C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E362083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYEH3jMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E362083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIZOot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:44:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38026 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:44:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so134115plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=hYEH3jMlNhLRTGwPJGo2f3wGHDL/EDCtZEHrk/jBVFFQo3S1+2PbIQvscOtoxQx5s0
         KJtZ/i0OsXvbL00R7+7lXHY3Yw1rOfyth5dxZuTixlMqASoGO/sL7QhExPJkbPpEy6IY
         /cC2kRZpmGusKwm61UwrVP2qCQqJZsfW7kNhSyY5gmZGZBn+EWmQcZNYXnCWyodMb5N1
         z/AFpWwJa9OLehnAKeim0lh9acMDcVzW9JOzgdtVIetA08rUNMt+QKS4RSufpnH4+64t
         iy0o7GkTq8PTprWJZxaIf4jsMdmSjWdqwwbXmHor/zPIYVq/bSzQSOk0LpHeb3zqZaf9
         cUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=JsFpXBcw5rn7x8pcxkqwVUav69YgQ3w66Ge2tkmdBg7/MLM97dQG1igQtpzBir/vDH
         GXuBBnAqitaEBlfE2cxJz9EfOF+qjxcItyX9xu6KPKT5OVuh0CKS0f6LBn/k5hnPNwj1
         KMXOxk0o/MabAnPSL6KmblBHXM8PMUj6ZXmIStlfcnfdO/CGRbuyanS5Kf+NcWMNrv+L
         5pxLKkBORExMufnJKXC1ANTysPrgBLWrCDH4jCvTxgdowKSr8nTPmyhPzRoQ4LX9osyS
         AMMFu4V1k+UmcRTvULL9Leqa02rrSwZlkd+wY+XkkrDx6lWsRcDqvFlUFN2UtJ0RIQ36
         vksQ==
X-Gm-Message-State: ABuFfoiCGXTA/3czx51T7n/6U3NbxNlJIIIY1jblpVvzcEofVbN3KcBn
        AFC+FUcEk8+o9RP2KHLYLSg=
X-Google-Smtp-Source: ACcGV61AVIaq65L/UPMDOaBaOxZDgRx4GIKOrQ/BLBI7ZG/Dj2bebNJIkwmqbe7NiYOidRacJsZDJw==
X-Received: by 2002:a17:902:650f:: with SMTP id b15-v6mr4948598plk.2.1537950779386;
        Wed, 26 Sep 2018 01:32:59 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id f15-v6sm5530764pgv.66.2018.09.26.01.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:32:58 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 1/5] RISC-V: Build tishift only on 64-bit
Date:   Wed, 26 Sep 2018 16:31:10 +0800
Message-Id: <40c77db9ee2d23479ff90f2658539d29d7a30896.1537949825.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537949825.git.zongbox@gmail.com>
References: <cover.1537949825.git.zongbox@gmail.com>
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

