Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F44C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1CD22436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g45qt2En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1CD22436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeHKEH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:07:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46828 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeHKEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:07:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so5254044pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6D8lsRhhjwMG3VXiYtID+Ot7ZV5JG34DBjU41vN98IY=;
        b=g45qt2EnA8N2D/zpweDwRcF/rpjeRqLpWfxu+sJobaz+HP4bjGVPJIUQpkWWFwofBt
         0xv1jXkxF3GTmzz4pCeE/GonhLa4f6wZPufY9Du4LpkNavmX39fqVuJRs/UgKhCol5MG
         vEKclVi8MJSDHM7G/9LOBNHIFkOt8JDZSNLC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6D8lsRhhjwMG3VXiYtID+Ot7ZV5JG34DBjU41vN98IY=;
        b=Is44n1/wJzs1hahLm+bZq0qM+7UR+HLw4nv/ckkvSl6+kaCTKiead45ruQCiX1C+xu
         +AZ1JuuyQ57fG0Ba2CwsIZuDKIi31lyJHBRM/NTvaa+7rGtnCLpezM8TLrtIOrxCtZzW
         +Kq9uKE8xI5cGwKllBO8tcIeZ4LVjGeKwLtXBGXd4cB6XNyT2JN8ECgLbRdUcsFrAToZ
         +SnHuSpz2SYYB9slnVK0PP5rm9fv9W8Jczqy52eQ1rPQQgHaZQHDvD+ARYHffgYXaUtC
         qlLpFqPgUV17/9ifj0Y+pHNI1CkLXPI73Hskifxqdx8EO4h00459RnNvRhSPnR/1pBhg
         ZEwA==
X-Gm-Message-State: AOUpUlH0mPq32/jdW4HaM8LejI5j5tQxev6rgpPL5CUdLfAjfQBmthM8
        EHyDYyxDojgDyf7sI4nY3BjIrA==
X-Google-Smtp-Source: AA+uWPw7dX3M4NfWK3hA1W2QshGARFIqMWeNOQgpvTov640UMyhoRHYf9RhyfaEISQXZfYvjcMLKRw==
X-Received: by 2002:a63:920c:: with SMTP id o12-v6mr8576702pgd.141.1533951307312;
        Fri, 10 Aug 2018 18:35:07 -0700 (PDT)
Received: from ubuntu.localdomain ([45.56.155.48])
        by smtp.gmail.com with ESMTPSA id d22-v6sm21722373pfk.69.2018.08.10.18.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 18:35:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] serial: sprd: Remove unused structure
Date:   Fri, 10 Aug 2018 18:34:23 -0700
Message-Id: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused reg_backup structure.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 828f114..1b0e3fb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -95,19 +95,8 @@
 #define SPRD_IMSR_BREAK_DETECT		BIT(7)
 #define SPRD_IMSR_TIMEOUT		BIT(13)
 
-struct reg_backup {
-	u32 ien;
-	u32 ctrl0;
-	u32 ctrl1;
-	u32 ctrl2;
-	u32 clkd0;
-	u32 clkd1;
-	u32 dspwait;
-};
-
 struct sprd_uart_port {
 	struct uart_port port;
-	struct reg_backup reg_bak;
 	char name[16];
 };
 
-- 
1.9.1

