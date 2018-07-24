Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4CF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSWf7dB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4CF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGXICI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:02:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33841 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbeGXICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:02:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so2195584pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BD5KBPTKxdMtpqygaHhbkvkazGjFD66/w/IEI5sq6YQ=;
        b=KSWf7dB62jD+2CI25qIfV0icHgEzVjhvX+daLfcydF/eeJeFARBKhZvS4pStqBy5zN
         IxWJ523bWypZMHdzMjDVeh65AD+AYBkRgUZ5NComIcmAXDFWKN+eFozGjPTSK3iG07Zk
         RBv+0SzD0fMx7hwfVqwmR26FtLw3uiAxqCkSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BD5KBPTKxdMtpqygaHhbkvkazGjFD66/w/IEI5sq6YQ=;
        b=PVp1/lmSa5Cpg34TI4Tgil6qK83cKps5dU+tMS3737afxlKP5+/cOzoLX+OA5mHAJK
         vMR6ConYDZl8rJ3rh7ztIGbCG2SX7x6qTGiyFzUacXgLTl5HoabuaVd5NkbFE9xup76U
         tF1XFJVMKfjZOpKOmVQ0Dyey+uKQOhi2K3YuCe3OzQdLwJrnWgH8YKhQsVuYWPjV1lny
         +LWG86RUYzPChVZYc3jllLlaYH4RgsDDBpELqHBxpMWsd4XWDTTNrQyRnj+tOa/wqOoV
         9/j5jkg+foSwd1nb9dYOW3GIXa2oI4s5UJS1kA2EaXoUh4+bkLSbj+Pij570k+/tpN/c
         44vg==
X-Gm-Message-State: AOUpUlGorDeegoIIUDZZkWMORz6TyL6EgdVJshm8lpAOF3Kwaq93dieO
        IhAVxSkCz8mfQ2FKK/ZauPp5ug==
X-Google-Smtp-Source: AAOMgpfZytCmntNk893W3ELT04ScsWkhUGrKTLhbTE5ic9zIxhbPiY1g+r7VQnViBdUAwDcfVlVu5Q==
X-Received: by 2002:a63:62c4:: with SMTP id w187-v6mr15035901pgb.55.1532415430908;
        Mon, 23 Jul 2018 23:57:10 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id w81-v6sm21247538pfk.92.2018.07.23.23.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:57:10 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 01/16] asm-generic: add kexec_file_load system call to unistd.h
Date:   Tue, 24 Jul 2018 15:57:44 +0900
Message-Id: <20180724065759.19186-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 42990676a55e..c81f4a0df51f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_kexec_file_load 293
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
-- 
2.18.0

