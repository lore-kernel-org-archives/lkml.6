Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E9208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZGqqP+Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1E9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeKOKdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:33:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40935 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeKOKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:33:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so3132446pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+YBnNurkqDo7ErqUbtfeyI5S4n0SWhVxEZNF1H10U08=;
        b=ZGqqP+Gvxz89We5VkbQ98KgKuA8EiRmJF5fF7P2tmTEExGi1Nixn2oUtDSHqacP3RL
         NTApvPwGWQC5u87ShFaZXdKXJYQswrMp4IM0nqPq1jjRiH96XXkhGfPMu7em6ni6X+9z
         tsPn4I1sMPT2rohyuxsCc5rZgtx9EnZXSGk4SnCDMiU8njE/LNER+GWM8CjxCqLtmGAx
         7raXT5d4a5vtCMvd7v/87zwvVm7V4YOqItL2d6UeLLEldS93epH6Y4Afwmy1Aw/XjUhY
         +B8YHBJUqaetNzdo5y5+Aocyusw8tjgm/bif5T9km2t4y0RDwgmqh4pD9PVFsE4NJbb5
         kYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+YBnNurkqDo7ErqUbtfeyI5S4n0SWhVxEZNF1H10U08=;
        b=AxM/afUZ93xlDdQx8J3Kdb12JQYFPJ1zqO16CmFXyeQsGkpharAeLfyDJ6PjmRY/Lh
         tokeb5UPhV/CEcXa8MMqTALmtVlvS7OeH7CGQYIzq/hY7/8BFo0qj+n+mwuyv1rXN991
         TpjDUYFJD0UdK0lF5yEwWsYpoEcxNXFIhKoeURvjHhUxJydkumUA6XNEGIMeYr8y3gpI
         EqqIV3NVpNbWg48bZPmNT8bRCuJ9CUyMmn42ggeEf8AV0+Oa1TQrNyuLzw2ptTbjc/6R
         xnEbZl02/PNBoHwOLGrUGF+1banijAqWSA+aTNs9tqE8HMYgLJMT8J67XTp9B3nxA56S
         YqDw==
X-Gm-Message-State: AGRZ1gJXiWgPjx+b6LCAe1rRfeQ4oxHrQOQNqa9qEbTsplChNdYRzY4c
        ybyjmXts8NLEoQlRsAPhM/ZDKQ==
X-Google-Smtp-Source: AJdET5ccpmVeWWLqZ5C55DH4IVPkwN3PoT+a9D7VZaSk6mMTs9/6/VsYBH5ZsVBy4YmTgd8MRpDaxg==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3-v6mr3957902pls.144.1542241688346;
        Wed, 14 Nov 2018 16:28:08 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id d8-v6sm29159472pfj.106.2018.11.14.16.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:28:07 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] RISC-V: Fix raw_copy_{to,from}_user()
Date:   Wed, 14 Nov 2018 16:27:55 -0800
Message-Id: <20181115002755.24195-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse highlighted it, and appears to be a pure bug (from vs to).

./arch/riscv/include/asm/uaccess.h:403:35: warning: incorrect type in argument 1 (different address spaces)
./arch/riscv/include/asm/uaccess.h:403:39: warning: incorrect type in argument 2 (different address spaces)
./arch/riscv/include/asm/uaccess.h:409:37: warning: incorrect type in argument 1 (different address spaces)
./arch/riscv/include/asm/uaccess.h:409:41: warning: incorrect type in argument 2 (different address spaces)

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 473cfc84e412f..8c3e3e3c8be12 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -400,13 +400,13 @@ extern unsigned long __must_check __asm_copy_from_user(void *to,
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __asm_copy_to_user(to, from, n);
+	return __asm_copy_from_user(to, from, n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __asm_copy_from_user(to, from, n);
+	return __asm_copy_to_user(to, from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
-- 
2.11.0

