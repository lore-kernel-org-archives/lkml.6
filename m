Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0833208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1TWw3Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0833208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeH1NEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:04:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH1NEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:04:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z25-v6so468114pgu.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kjmNryIxbwqbCCdSwgMdVQyiF4PoiPt24SSCjDlqFI4=;
        b=S1TWw3QjA9e+k6uAEi0C07pb8JFzOms14oVcppKgEE/Y/YXibzU3/ZSWJXG3lq87W1
         RRK97aPOo9dosXyS9tJfP6rKCNBoZoWhbrsAMuGvI8exNSrZT8caqTd5qm+AzpaFPuIH
         QsllOgPSGF2LcfJWWr/I842oyGs+7Ono47VRWnBXxAgUr/Kz0jZdtjN8fDFalHVbX+py
         +FyewmC+XSohWtmSX74nzt9VX8CGu5h63D7ULcfkv5DEXwHJGIk1zRQ5Knb+HP4d//N7
         K43VVwZ+0tGyWubLHabcKigEx/vFAqW6o4KI2UsbaT5z8itjkvzrU4AQJu1S2ytCAES2
         0UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kjmNryIxbwqbCCdSwgMdVQyiF4PoiPt24SSCjDlqFI4=;
        b=UrXTQn0J5JJ8Y4R0woQQAwb5hsbTq9xuDhbnGyzjqYqadkt7tYiGJ0uDDNUOllboq0
         gogbasbq+i188p1zw5lAWD0LDmkJRljSDUOp1peXK3clXCO5tz3fm8YmSbiOILRCTCjs
         8i+V0qcCI7kQ69MTmQwxZnDz1ADaWWwij5KBdVX75NKJwf/7GoJKgHkfeXjE09inr95g
         oSJTZF5DhbF/fmT6cTBH68DX1bIViypN5nIkgXtaZKqnGhKs8yXHz84s80w6CUz9VXyJ
         pVBNI+Svpu/t00F19ya3tC+YfM8688qYBfYA3vsRK78n5nTaRwahZF/uMxFdcacU4SSn
         f0ag==
X-Gm-Message-State: APzg51ACczfnyRwAMsiTR8NGJpMdUFQItrxIwF6rntH21NTDMKSMZTDI
        97axBffUzEOIqnyeffsF/g68kCJ2
X-Google-Smtp-Source: ANB0Vdb4/CS30Hltz0iaSkx10uFSdORLizSHKVVDyiM4EFQqyhepVLKiM2dGsH1ozZ+jdK/YJ07RmQ==
X-Received: by 2002:a62:435c:: with SMTP id q89-v6mr627636pfa.135.1535447618330;
        Tue, 28 Aug 2018 02:13:38 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id l9-v6sm1083027pgg.79.2018.08.28.02.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:13:37 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nds32: fix build error because of wrong semicolon
Date:   Tue, 28 Aug 2018 17:12:22 +0800
Message-Id: <20180828091222.31672-3-greentime@andestech.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828091222.31672-1-greentime@andestech.com>
References: <20180828091222.31672-1-greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It shall be removed in the define usage. We shall not put a semicolon there.

/kisskb/src/arch/nds32/include/asm/elf.h:126:29: error: expected '}' before ';' token
 #define ELF_DATA ELFDATA2LSB;
                             ^
/kisskb/src/fs/proc/kcore.c:318:17: note: in expansion of macro 'ELF_DATA'
     [EI_DATA] = ELF_DATA,
                 ^~~~~~~~
/kisskb/src/fs/proc/kcore.c:312:15: note: to match this '{'
    .e_ident = {
               ^
/kisskb/src/scripts/Makefile.build:307: recipe for target 'fs/proc/kcore.o' failed

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 56c479058802..f5f9cf7e0544 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -121,9 +121,9 @@ struct elf32_hdr;
  */
 #define ELF_CLASS	ELFCLASS32
 #ifdef __NDS32_EB__
-#define ELF_DATA	ELFDATA2MSB;
+#define ELF_DATA	ELFDATA2MSB
 #else
-#define ELF_DATA	ELFDATA2LSB;
+#define ELF_DATA	ELFDATA2LSB
 #endif
 #define ELF_ARCH	EM_NDS32
 #define USE_ELF_CORE_DUMP
-- 
2.18.0

