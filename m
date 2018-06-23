Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CBDC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3735924AB3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoEKVO0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3735924AB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934691AbeFWCUk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:20:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44497 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:20:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id b10-v6so31970pgq.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdv7JCAGldq0YAFu/ACWfRReGIBSUaIhom0oFCx/M8A=;
        b=WoEKVO0csIZ3KZJOqeQJk3nFpCLfca2WyshHC6YmCikgKWYbFS5IlldO8but1IJaq/
         PxxZSc6nHtru9lJvBYhYTMRp/84d3/hdrAuukdn5Dpartg06Zd31QhUGD6iNPwXnJH3A
         vzG+uguTdmR0u73JU6pxGWZSArm0ecLYOsOZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdv7JCAGldq0YAFu/ACWfRReGIBSUaIhom0oFCx/M8A=;
        b=KvRZOHAxbMm5YfiWx0b28ryaEhcD+sWG5yD/Pc4yUqoXRh6YzFSpRlTfyB1pmyMQbq
         aSJeF8SX1077At2nPWS2TZfSnhdZsHH8+MFcY6My5rFa+JrIUDhGe1OMIB5Gl5N3P0LZ
         RMtR8lBQGBzGtMlS8T+MsiUUySVD+uNFe9sSr6sb2LvVuLdnpMNQrKd87e8/+SP3T8dA
         v25b69Hi+YRqndW/SvZV9kJqa3jEzk6isc5/ah0leFdD5bd70l9FZK1W+OeZqJCuqQ4K
         Yya11H8NvyEkK2uDGUBZ6xoExUCV4RQEu1ydSTa+xdvh2Jl32v/OFIe1sRzop1d/Avxz
         Jdkw==
X-Gm-Message-State: APt69E1Y9tL2W7jr7F/EF8DDVboQgNWHInKBmWCcrB4V/azKtglzWA3D
        XPS9D9Cetm950WIt5QyEzzbKGQ==
X-Google-Smtp-Source: ADUXVKJFB8NIUtgGFrBMZ5EVRbrPxfuldMM2AvyRvIejmK55kcslf7RkW+dFSPkJkiqxq9Y3qTAJ6Q==
X-Received: by 2002:a62:e70e:: with SMTP id s14-v6mr4090799pfh.131.1529720437986;
        Fri, 22 Jun 2018 19:20:37 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l1-v6sm556418pgn.55.2018.06.22.19.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:20:37 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 01/14] asm-generic: add kexec_file_load system call to unistd.h
Date:   Sat, 23 Jun 2018 11:20:45 +0900
Message-Id: <20180623022058.10935-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
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
2.17.0

