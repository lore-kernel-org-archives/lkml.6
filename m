Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C721E1F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMgWnPrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09C721E1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965130AbeFYWng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:43:36 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:40029 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964972AbeFYWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:44 -0400
Received: by mail-qt0-f201.google.com with SMTP id t23-v6so1078799qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=nKsGAuVdENM/7FYnrmfj+wQvtZVRbdNj5W4MbHllG9I=;
        b=QMgWnPrY0FFp2tJsT9SpkGQ82hDem+ZHwbejjYLcLXBtfJvsWa8nEzaMHwO93NuWPP
         sqV66kWo1fs3yLJhX1h18JPJUKpsHVNrO91UeUF+AuU/0JXL6u/CrsF0s6DULn4UXXkk
         Yg+o+SiV/Hv1q/6K80SNuvGE77D1ZEdmHXHuduU5BcRf/vE4SlATXdCS2N0E91+nSktS
         bel5ChH2VXqYUsLH4LY6hWbf89WEdDP7KmtvjvNXvuCeaZooJTAdQfR3vytzfUhSWNoG
         S8AbFs8lbm6y+zBuquCBXmMiYFswnGXvt8y/kQSSUiCwybSn9neSBq55no6ilXlrp5QC
         l9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=nKsGAuVdENM/7FYnrmfj+wQvtZVRbdNj5W4MbHllG9I=;
        b=NQpBqkjQckFHtJYRElhOmns0F3K8TuMALVCv/K9vSLxvEqlp1HJGUsk4c2Y0AE44Oj
         BRm0x5cWkmGeykV9Jf3fElCTSLUHu0wQMgH+jAVyfnmaPokK5cVbe8BeJV4jM2kfz/LA
         uqNOjVUAYszzqtaY/HH2obg4VJNME62JQV6UWSwB0Rp+TjxDXs+oGjv3hDq1TTAYF3yh
         X8a+I9YHGKwRpCd6LmNtrObFuKQtTwfxaEPLopMzAB3BIa82tTDCTfYSenodC5txiT9X
         /3dr8fjXoLKSgN7NUcsVkz37tBJuBvkSeiWwoEsik4ycNfBE3+hS8tkLLiN4w+CmhgZa
         MhnA==
X-Gm-Message-State: APt69E3IfMbM20RkBOOjYZj2Kq3eoaYL1srdI4CVqJeW86NlRTOXOAAE
        ZJPWDiJeel2W+jbH5VTOFONFTiPgN6A3MA==
X-Google-Smtp-Source: AAOMgpefgEA80eL72T9HTtbgOdbzF2Q0O2xJtYxdVw5C4n1qa+2Z4QJzD0telcd8GxXR8bDNHkm9/XwOGPhOIQ==
MIME-Version: 1.0
X-Received: by 2002:a0c:f751:: with SMTP id e17-v6mr8240108qvo.29.1529966563900;
 Mon, 25 Jun 2018 15:42:43 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:12 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-25-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 24/27] x86/mm: Make the x86 GOT read-only
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..e5b0710fe693 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -314,6 +314,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		VMLINUX_SYMBOL(__start_got) = .;			\
+		*(.got);						\
+		VMLINUX_SYMBOL(__end_got) = .;				\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * Read only Data
  */
@@ -370,6 +381,7 @@
 		__end_builtin_fw = .;					\
 	}								\
 									\
+	RO_GOT_X86							\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.18.0.rc2.346.g013aa6912e-goog

