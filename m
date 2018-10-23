Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A32C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfJlInGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJXGlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:41:01 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39776 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:41:01 -0400
Received: by mail-pl1-f201.google.com with SMTP id l7-v6so1428685plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=alsxCznKlRvNPj0cP4LLsmMjM7la4Q0Zm87PjkEbJ8w=;
        b=lfJlInGALFAd1OIp6iUwGTXWlQqWu2DWOy/a4oxUqQi3nTBPR4mjOobZFccaCqT85g
         kADqBEoqv/wWpP2GGhEllXqYb9SQQnGZj7wIicq+rNw4JnGaH3+6+1YpU16nDluLdSVz
         xznVvlyecwJoZ5v+LkoxZsPqu3xK70wCy+DUG1tqZmVf73mFyLW06WwwT6gEzPfJTRo0
         NCnpmiTT2azJBhkrlZiumDAtnofURuoTkwZ5q+gtLuUuPTJ3gXezi8yPB4bcx518ly6L
         PZ1blWLzDD93gDd3frPDA6YZfBP9KCptC6+mBnsbe36LJm0zxph5FhRBhhH6SzUm12je
         vewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=alsxCznKlRvNPj0cP4LLsmMjM7la4Q0Zm87PjkEbJ8w=;
        b=nF2NoWKudCgGMLlV1mhEHkAmXn81C8tJZiSGha7jyg4JB0Sup8V49y1Hn9wiPbJcGs
         TZ49j8pIO4X3om4wK3OGtXeiPDeuATkGG8OdvvZdo/gdgEubzD8lqkkV/dhF970Z4nKD
         Ova3PVQomlmXdOFRI69rbmvupT01ZTShin9AvcvHWeZR78RVX3g0PYiHtaChjKpT0L2z
         vcxDfmm+FbdkpkBDOXA9nwopr0VDsM3B5YMTbozvKmwlhdGjOClIe3x14ESXup4+8dGb
         9g23xWtUUhme8Tl4L82ZhKXssqa0AYvnSzwvA02QdWHvvYxH5Kk2nXpNdStHSCGmrrTU
         JnDw==
X-Gm-Message-State: AGRZ1gLTdfaJQ+QUMv8eysEV6KveaXpTJUuBaIW1Cd74DEniF34gDQ2t
        Sn49ThfX6axBhsd40lSDmY/htrNjOT4V2sQVJyA=
X-Google-Smtp-Source: AJdET5c3UK5TFHmwurixIcGKuD+7CpQQhAxY18huCnlDWkhbaOuhf9LsZHTB968Fre3Jj5rKGuXHe1x/jQ5c8bNHfBA=
X-Received: by 2002:a62:2055:: with SMTP id g82-v6mr87502pfg.28.1540332941776;
 Tue, 23 Oct 2018 15:15:41 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:15:35 -0700
Message-Id: <20181023221535.4740-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] modpost: validate symbol names also in find_elf_symbol
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an ARM mapping symbol shares an address with a valid symbol,
find_elf_symbol can currently return the mapping symbol instead, as the
symbol is not validated. This can result in confusing warnings:

  WARNING: vmlinux.o(.text+0x18f4028): Section mismatch in reference
  from the function set_reset_devices() to the variable .init.text:$x.0

This change adds a call to is_valid_name to find_elf_symbol, similarly
to how it's already used in find_elf_symbol2.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/mod/modpost.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..b709b2e623d6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1204,6 +1204,30 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	return 1;
 }
 
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("axtd", str[1])
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
+/*
+ * If there's no name there, ignore it; likewise, ignore it if it's
+ * one of the magic symbols emitted used by current ARM tools.
+ *
+ * Otherwise if find_symbols_between() returns those symbols, they'll
+ * fail the whitelist tests and cause lots of false alarms ... fixable
+ * only by merging __exit and __init sections into __text, bloating
+ * the kernel (which is especially evil on embedded platforms).
+ */
+static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
+{
+	const char *name = elf->strtab + sym->st_name;
+
+	if (!name || !strlen(name))
+		return 0;
+	return !is_arm_mapping_symbol(name);
+}
+
 /**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
@@ -1229,6 +1253,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 			continue;
 		if (ELF_ST_TYPE(sym->st_info) == STT_SECTION)
 			continue;
+		if (!is_valid_name(elf, sym))
+			continue;
 		if (sym->st_value == addr)
 			return sym;
 		/* Find a symbol nearby - addr are maybe negative */
@@ -1247,30 +1273,6 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 		return NULL;
 }
 
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
-/*
- * If there's no name there, ignore it; likewise, ignore it if it's
- * one of the magic symbols emitted used by current ARM tools.
- *
- * Otherwise if find_symbols_between() returns those symbols, they'll
- * fail the whitelist tests and cause lots of false alarms ... fixable
- * only by merging __exit and __init sections into __text, bloating
- * the kernel (which is especially evil on embedded platforms).
- */
-static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
-{
-	const char *name = elf->strtab + sym->st_name;
-
-	if (!name || !strlen(name))
-		return 0;
-	return !is_arm_mapping_symbol(name);
-}
-
 /*
  * Find symbols before or equal addr and after addr - in the section sec.
  * If we find two symbols with equal offset prefer one with a valid name.
-- 
2.19.1.568.g152ad8e336-goog

