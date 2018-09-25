Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AAD2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILilAhzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AAD2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeIZARg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:17:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50339 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:17:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so14443778wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcsiSHC0IriMHLUqwataqDFFhjE03MSei2N5kMdLovo=;
        b=ILilAhzmHg3sw6pL13xeTdJOGIsluDxAm3sABWjPa7BWKiLJU5oUSkgnRSzSF+yjtV
         THXQQ4a77+AWvPdjc07c0LI9BQhvumu64ew4clbmLy2nKg7KQHdfPJBWO5mfw4OtDV6l
         KcujJ3S1cBd/GGc8faJ3dZmWgJ91Xy+OLjahjqyJGB3FWjwuhzIRgvpzTHmfnnaZBbKc
         R69d/m2qrGS9RcmVFZOdcNiVHFDHw5BZyA5/EczB9FVGgHNYVIsCpLctBZTs/GkQNI+5
         ezcW8DCcBvdI9PJ3k+GNGyYtBoF1LL7ZIBmasxdaLFjLJjZKIeB+KXKEP0kob0Eu9v8o
         7v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcsiSHC0IriMHLUqwataqDFFhjE03MSei2N5kMdLovo=;
        b=CYWbfb8PoA0zESXmZq0WQIOMgGR8A89AktmHjkh/HX1NTtC7XBNpHjbTeUXKJKd9Nk
         62OOf05H0SRqu7S1uMPfDhDyFhjNptJdklpKpu5tIHPutzeJ+s3m2qORay9kv8tEL3p2
         Qc33qIUrBssc4Bya7O7/JbTzL9hH0jrksB+qvfCsF8JTYIY8uJ9KXCdrnA0OI5y6Rl9I
         lUpoIAZSDIpSG0kF2hK6ywEAjiEdKH8zd+r3i0F1TZz9zFlyFrz1kaBAKmG4RMIgC88l
         ed8buFpa5lI9qYa/Ah2we+46KXjHgMIL6JBi7vonRoRzKlTEQHazxg+qqy0cX2hbpR3M
         CpdA==
X-Gm-Message-State: ABuFfoi89aQ25F31+zkW884cVN3+TiXWydRJ7dIZ1ofq+vMRfUVsTMmG
        qqDtADeFMNScSRQe30nDGpU=
X-Google-Smtp-Source: ACcGV60qL4SXJHtBZOWibWIdpZmktz3VnDAyONE3q0jTsn3JyrXZmO0MOvX0JI82I/o5KDaYx/007A==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr1732086wmd.45.1537898931422;
        Tue, 25 Sep 2018 11:08:51 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:51 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS/head: Store ELF appended dtb in a global variable too
Date:   Tue, 25 Sep 2018 21:08:23 +0300
Message-Id: <20180925180825.24659-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 15f37e158892 ("MIPS: store the appended
dtb address in a variable"),
in kernels with MIPS_RAW_APPENDED_DTB=y, the early boot code detects
the dtb and stores it in the 'fw_passed_dtb' variable.

However, the dtb is not stored in 'fw_passed_dtb' in kernels with
MIPS_ELF_APPENDED_DTB=y.

Under MIPS_ELF_APPENDED_DTB=y, the dtb is also located in the
__appended_dtb section, so we just need to update the #ifdef.

This will allow to access the dtb in a more uniform way.

Fixes: 15f37e158892 ("MIPS: store the appended dtb address in a variable")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index fef2f61c5394..351d40fe0859 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -94,7 +94,9 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 0:
 
 #ifdef CONFIG_USE_OF
-#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
+#if defined(CONFIG_MIPS_RAW_APPENDED_DTB) || \
+	defined(CONFIG_MIPS_ELF_APPENDED_DTB)
+
 	PTR_LA		t2, __appended_dtb
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -104,7 +106,7 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 #endif /* !CONFIG_CPU_BIG_ENDIAN */
 	lw		t0, (t2)
 	beq		t0, t1, dtb_found
-#endif /* CONFIG_MIPS_RAW_APPENDED_DTB */
+#endif /* CONFIG_MIPS_RAW_APPENDED_DTB || CONFIG_MIPS_ELF_APPENDED_DTB */
 	li		t1, -2
 	move		t2, a1
 	beq		a0, t1, dtb_found
-- 
2.19.0

