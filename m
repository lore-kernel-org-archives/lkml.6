Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22587214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jy2O0Pmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLRDPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:15:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35152 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRDPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:15:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so7129037plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=2fkPyuVe/+Eb9oaaMmfp5ZNbRALVy3L/AzhL5ZaGSYI=;
        b=jy2O0PmvLiHh7VulOAmtYIEFUg1XHtNHNMTc4y1Bo+//Rj7SqTUPh5WHnjUqWkox+s
         IvHd7WAvAunSalzIwcgdMVYIG/uOESpQPOYAu2tPU12+dU+an2WkN/b0H7tFDwzZaZ7o
         CoeKuW601ns1y6mQsyMC12X+vtyw6A1WKLm3xUTamg+Zj5NLih2oL5jLgV3LMAxAbPWc
         UhoRNZgUTJsRpJHTdNSy4+R+0Y203It7/nFdp3RIp4ztgZW653fp8OifjnKI0wjQfyGF
         p5uuP94bqJM0RkrTyFBMRMjBR5BfleiM6YCuQUB7u70QdRm223GXJhtUnQeOxWnm3ioN
         tT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=2fkPyuVe/+Eb9oaaMmfp5ZNbRALVy3L/AzhL5ZaGSYI=;
        b=M/w2/3u9os5oq+X6LOoAjd4n4SG0yE443IPD40rrJVmvddmv5iIz1oAuRYJl0AdlE9
         xiJ1VyLtwm99AJnbi+Pns7txQdygNd3i7klm3JjykU2xVuuGdx6isQdbPbBglYfOWjO8
         ybbzKTbnU9JEd1e0KvpKhQo3DlViHtuP4am0izDLwJwjq+6mf2Q1qmaFeYnLPrx3wa3c
         z5gLGq45kGLWC7wASkLaxq9+1JlUlFgDiqvdtjxTtByFtBuTmp5J3eOHOfcGFJEiFZDs
         rYDXy3CyUqCu8MnZsu6yN3L4lgcSKe4+jN1d1OvROX4i5rvKNlkXik8UM7Cc7RIiTJLi
         zgxg==
X-Gm-Message-State: AA+aEWZPtrSLCTHtP+DQQnSKsofT8F2e7L+sjgQhS266Vmfi1QkWYaYQ
        gDCSMeEPI+l+DwYACrBcypddbwAWaik=
X-Google-Smtp-Source: AFSGD/UKokULiGcBmvfhuULU1nhDdeXHfPtgW4viIBlapdU9ie7QP7jzgV/68PJE9Jt4ufi4MxIDTg==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr15025231plx.232.1545102914304;
        Mon, 17 Dec 2018 19:15:14 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q195sm14787445pgq.7.2018.12.17.19.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 19:15:13 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Mon, 17 Dec 2018 19:15:12 -0800 (PST)
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul@pwsan.com
Subject: [PATCH] arch: riscv: support kernel command line forcing when no
 DTB passed
Message-ID: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_CMDLINE_FORCE doesn't work on RISC-V when no DTB is passed into
the kernel.  This is because the code that forces the kernel command
line only runs if a valid DTB is present at boot.  During debugging,
it's useful to have the ability to force kernel command lines even
when no DTB is present.  This patch adds support for doing so.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

Applies on v4.20-rc7.

 arch/riscv/kernel/setup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c290e6aaa6e..e6b962ff39b1 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -171,7 +171,14 @@ asmlinkage void __init setup_vm(void)
 
 void __init parse_dtb(unsigned int hartid, void *dtb)
 {
-	early_init_dt_scan(__va(dtb));
+	if (!early_init_dt_scan(__va(dtb)))
+		return;
+
+	pr_err("No DTB passed to the kernel\n");
+#ifdef CONFIG_CMDLINE_FORCE
+	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
+#endif
 }
 
 static void __init setup_bootmem(void)
-- 
2.20.0

