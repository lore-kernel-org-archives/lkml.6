Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1EE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlATow9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1EE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeIQKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43731 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeIQKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so7031924pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PuLa06lO0jfsyCXAVeGXqVVVMPIP4UQbMjn2YuVpDmA=;
        b=SlATow9g7jrYPGE+tll5JZkbkXydsyc4dC/AI8W3mt6Jhpo60efQbWQTKlWglCrbPr
         Dl4D060o0HgJpNMvfTT8G0ciciSTpA+qosEhDf00enGQh7V+hcRqeuChWii+behZYjSZ
         OSPDsmxzVSzCSYRWSiGZijfC0S1/EHhV/Vzdfb1giWqjhFBUviHUKuKGN8YRTQi45NGr
         oahuZA2RwkgdKraO8icZ2nvbuZSjHRI0SQSgFz2Jx/6iByvhTLvO7UkDPItHdphHgNDH
         aVaeMDcp2X0g5ATbzcttD0E1iDUNaANuyO+mOpTSwQYzjzB+6vPc3IkVvNpVD4g9Fw3P
         9j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PuLa06lO0jfsyCXAVeGXqVVVMPIP4UQbMjn2YuVpDmA=;
        b=BSkPMsvp9NEXp0I0b5aJs9zzF/LYGFJ6QxWpTrjM3hMckoEq4rYzZ4xwe5myIuhHOo
         bB/o7N2ohQt77mQK2/H6JECAHi8wevvKYYFeiHZrE5TXm7QwLGRWdZfJxXhIYds5N30h
         Wi2kt7oddZVhg9z+PjmjIAaGgjSXAtP3/+mx+AIktmnUVVuoo7jXhXtuJqJR4IqqRn+d
         2PuHz52N9y9svSPV54pMHK08+aAf3b5vv04eiD91cjBorhIN5u604/cL230V1E2K/pU6
         qPE3xFrRsAUNZ41st/KifqoZ7bdUXk8zzx3lHdvKSWp/7ODn7wn0qjFRAedyZiqp+Xas
         R2bQ==
X-Gm-Message-State: APzg51BmcTIczSq0lmyXqR6HMsl3u0BGnD3KhqcoLMlsdHWAPnukQTeX
        n670vKfLD4HDVvkvwGrOjfHF5rItblw=
X-Google-Smtp-Source: ANB0VdZ9GsvddCJdKBBbTGUGlxc+ErMrFraxpxKYHaGcwKkG32jjDeARlRpGuLjphAvNFaxY+sclEA==
X-Received: by 2002:a63:7353:: with SMTP id d19-v6mr21637954pgn.281.1537159455773;
        Sun, 16 Sep 2018 21:44:15 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:44:15 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.
Date:   Mon, 17 Sep 2018 12:43:33 +0800
Message-Id: <20180917044333.30051-7-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the idmap_pg_dir/tramp_pg_dir/reserved_ttbr0/swapper_pg_dir to
the rodata section. When the kernel is initialized, the
idmap_pg_dir, tramp_pg_dir and reserved_ttbr0 will not change. And
it's safe to move them to rodata section.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index a634def77442..328925b308fc 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -64,8 +64,13 @@ jiffies = jiffies_64;
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_end = .;
+
+#define TRAMP_PG_TABLE					\
+	tramp_pg_dir = .;				\
+	. += PAGE_SIZE;
 #else
 #define TRAMP_TEXT
+#define TRAMP_PG_TABLE
 #endif
 
 #define INIT_PG_TABLES					\
@@ -74,6 +79,24 @@ jiffies = jiffies_64;
 	. += SWAPPER_DIR_SIZE;				\
 	init_pg_end = .;
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+#define RESERVED_PG_TABLE				\
+	reserved_ttbr0 = .;				\
+	. += RESERVED_TTBR0_SIZE;
+#else
+#define RESERVED_PG_TABLE
+#endif
+
+#define KERNEL_PG_TABLES				\
+	. = ALIGN(PAGE_SIZE);                           \
+	idmap_pg_dir = .;				\
+	. += IDMAP_DIR_SIZE;				\
+	TRAMP_PG_TABLE					\
+	RESERVED_PG_TABLE				\
+	swapper_pg_dir = .;				\
+	. += PAGE_SIZE;					\
+	swapper_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -143,6 +166,7 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
 	NOTES
+	KERNEL_PG_TABLES
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
@@ -224,21 +248,6 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1

