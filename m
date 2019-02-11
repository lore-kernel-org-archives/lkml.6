Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9BAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56752184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYEaYUBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBKX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38965 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfBKX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so665771wra.6;
        Mon, 11 Feb 2019 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hnmNnr9YQbwfaI93UrUGE24zBu/XKqtY3CcuY5KmkdU=;
        b=uYEaYUBOjZ1m5B6He86ZkAdxBgB6xG90lpl13Gk1Hrdiy2liTU2fpge+1cP7+Qcn6P
         emp1I3cfdW/eFM5ehGcXia7aD5KRIrcUO5KLp3y0d03SJnHlYa9M1Nrk/j9WlOBZd5vM
         NPhVHQ5yjo3jg+IdDZgstra/VE5OEv5TkKDW60i2fCnhn1M3rHve7RRlJI3pwQX0i2oO
         nzXQ3Y1hVyuu7hiWSI6AAJ/iJgoifRyEzUCYAW/WTwTbuJ/c3kKLtIYUUXTTl2s4MABn
         myO9A78iPisLHHaZdLR9c6eEk1EQBlg6qs5wdKYl6B1b1EbFoU++Ygll3gD7Mvu2THwr
         kJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hnmNnr9YQbwfaI93UrUGE24zBu/XKqtY3CcuY5KmkdU=;
        b=M7iLd4toG6iL3Bl54kQbvpDvJse06WaZVgo5Cr7a6RyylljZugvFv6HF3HUwONDBX5
         iUsqVD4Dzn88htOdOa8Gq0G7Mx/l2ZYKStSsZ2hvwblsSwCodQraP9etvKI1PSjFiUAG
         tN8Q5QLostvvFFIlr+syKRxFpTnZa07vJhIpq92GWQOXPWZLZZAXM5b4V5uXWxVeDGVz
         WDapwMIqUd42gbDgJcHZ6AyDMVdMKanbKu0dz32+C89TkNfPMKlDlu4RE/K0CP783oPN
         3tzZCaner+574kQ6eHiI4FgAcKORhNtYklWScoHblQT1sHk0GnnsKRTykrJnyDGNNnrJ
         Fwew==
X-Gm-Message-State: AHQUAuail8AFCcEbqREG8UPoFpNlg2cAkAVJkvdz+luj38HIE/G54Ucz
        URXwqELpFgiCoTR6X7nGZno=
X-Google-Smtp-Source: AHgI3IZ5giTTjGoZ5V4UEH/aAowb6QbzDCVtz5Ak4aVSloW6V3hsGpwN/xytbf9yxR8h2JyjNIwF9Q==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr488678wrg.151.1549927704399;
        Mon, 11 Feb 2019 15:28:24 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:23 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 06/12] __wr_after_init: arm64: enable
Date:   Tue, 12 Feb 2019 01:27:43 +0200
Message-Id: <3aa3892bcef3aa8613df74c911c56a3d07599630.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_HAS_PRMEM to Y for arm64

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..7cbb2c133ed7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -66,6 +66,7 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_PRMEM
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
-- 
2.19.1

