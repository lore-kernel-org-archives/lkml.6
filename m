Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A069C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EC3224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ork8+ywi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EC3224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeGGFns (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:43:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44876 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGGFnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so9983699pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JkawiA4Loii6C6Xx6TTs36KM2s595aR9Wn0+XSAet7o=;
        b=Ork8+ywiuruYTaziROIuRPEf2p5Kko2+lXySCCrj+GOlHtBeVeVJrvLsVpnE68pbiJ
         1npcwITRZidyu1eAZ2Em9JkPtb6sKVigc6oPzyPpEPag700LG4EJi7w4INderFyQ+n87
         xZwbrviTqVQOL1pRwrPy7dMTWAQDWWKpZA6QHghiHE9d4hc6uTGmER3EFraMnpRB3bhE
         pUrZ5cVW6nh2EY1C3hYtqcQcXi75rBUQ1gnlHzF7Aav1IJ+ywhW/chx51fVAxxzylqE9
         aM1BYRt68377cUM2Dn78cZXgN3uEVr8OvqDQV6lyNuno5uOKaRcATXTw7s8uA5PN71Hf
         mRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JkawiA4Loii6C6Xx6TTs36KM2s595aR9Wn0+XSAet7o=;
        b=U3i6RdI9cuD3aiTpMcINyCSueAUeb+ENrGjhWmIkVnSFEKfmNJn5EODNhai89YXfE0
         DB3ig3wbXT+7Jns8yKROW7I94H/wN0F5ShSGC6e2++seiIq1NP/82y+Ay3f7bCh9UbgC
         6Qxr8NBPhbTnnjqzTkGzVZTp2MZboKgai2vxWNUB355I8uTy1nld9S/FWzbAoD645fCx
         QW5E2uq6fKcIJE51/THQzlY+O2LJdofa88WJGVYSleVDSB6//mSyY+j2E+gDa3chZAqL
         FZW7eCfcTEc9cVHJ5WpN9k6braX2oHxtvGSxk5U7mVgM467NwDoDHrOZViBLKf6MLRVu
         aEtg==
X-Gm-Message-State: APt69E1oLjfd76d/2+HQ+b5zt8e11dK0sGF8FqGnTHN4UbfvU2//83zV
        OEdKhR1gRiCNJL8oPBNxXcQ=
X-Google-Smtp-Source: AAOMgpc7sQMqFgVNts2FtWxUehRetoA5sTXN0IyLkWAM0b+JCrvh+iwqzU29GIR+Ib1siD955qW+JA==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr11529765pgq.174.1530942225946;
        Fri, 06 Jul 2018 22:43:45 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:45 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, palmer@sifive.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/7] riscv: Delete asm/compat.h
Date:   Fri,  6 Jul 2018 22:42:43 -0700
Message-Id: <20180707054247.19802-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv does not enable CONFIG_COMPAT in default configurations:
defconfig, allmodconfig and allnoconfig.
Remove the asm/compat.h as it does not seem to add any value to
the architecture without CONFIG_COMPAT.

Now that time compat syscalls are being reused in non CONFIG_COMPAT
modes, asm-generic/compat.h provides definitions for riscv 32 bit
mode.

Alternative would be to make compat_time.h to be conditional on
CONFIG_COMPAT_32BIT_TIME. But, since riscv does not does not need
asm/compat.h, delete it instead.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: palmer@sifive.com
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/compat.h | 29 -----------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 arch/riscv/include/asm/compat.h

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 576ffdca06ba..efdbe311e936 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
+generic-y += compat.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
deleted file mode 100644
index 044aecff8854..000000000000
--- a/arch/riscv/include/asm/compat.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_COMPAT_H
-#define __ASM_COMPAT_H
-#ifdef CONFIG_COMPAT
-
-#if defined(CONFIG_64BIT)
-#define COMPAT_UTS_MACHINE "riscv64\0\0"
-#elif defined(CONFIG_32BIT)
-#define COMPAT_UTS_MACHINE "riscv32\0\0"
-#else
-#error "Unknown RISC-V base ISA"
-#endif
-
-#endif /*CONFIG_COMPAT*/
-#endif /*__ASM_COMPAT_H*/
-- 
2.17.1

