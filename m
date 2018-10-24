Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C314C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A6320651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2D73BAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A6320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJXMa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44986 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJXMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id n12so1135448qkh.11;
        Tue, 23 Oct 2018 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88tE2zjEF2j1GAGOLvzG+qHTGlCXFlhFhtkVbtaj0Xc=;
        b=J2D73BAFyJaU21S6JWh6bLsBu+7Hz8molMeZEVoTKiy/R2PEjnQ6qwyLA2d1GuzgrE
         xexsAdlUnpep4wT5q0pHb0AbocaVmEzGyx2MjjMM3SqaswKK+Z3c8iplnap7j9+jh+qV
         UjOpGhNZAlqby8PuNIL/Do91OPssuG3zZTY8uWDmvhjIR8GfFmWg8sRnFB9KUJ2Vn5PA
         81cjsfU1ic3aExCLXqhlY7ZbCHBZWkP+vAiJGQ0Ls0s2vcYPE7MbY/9ANyQt+msqSNHj
         ms7TAOjmABM6i7WXTrryDETgpjJsJ7DURNwGAHqsv0KUADshTUgRNOcMPZT2ywA3IUc0
         pBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88tE2zjEF2j1GAGOLvzG+qHTGlCXFlhFhtkVbtaj0Xc=;
        b=Zalst3SpGhJjVhZOF1i5lfZoskd1/ZF+uc7nHWXFeAogRV31M4Ed12jh1Myuf455qh
         DB74bntfvzfMdurTeOt8bJsHvs/sGBGZVxF11NZetu5tfbQtJjS2YnqNU/lkh93jpC8/
         yOnUtwdpNbU3WPjd9Njyu2/SvQNVd0DYhv82OMwL5jVd5qU3YdWcyhmxCoqCXQcquN6L
         0v31wSwjeX67OyDdFvO4QIGkC3Zo9K/RhV/5jJZVL5CojGi0fQ2XGWb/UNbKDjp7FlzB
         9yl0gkp4/S5F3c4kIn3twNLiSVFUn/j4MX+ciy9NjA8fHoNoR33f6/9b43ucPQc5ntmm
         f53w==
X-Gm-Message-State: AGRZ1gKuPKOAI4tOyQjfZe5y3GV8SvwOb0RHZykMGZn7vKUIY6yijNE+
        hBySkzUJ+z9uwOM2Ulvqyws=
X-Google-Smtp-Source: AJdET5dJj34PF5kK11M8ALUp0GpSP7KXvAiXXRC1VJ8ZMST4tefNKM6rmo9kWBlf+X3L5upwFp4rNg==
X-Received: by 2002:ae9:c01a:: with SMTP id u26-v6mr842266qkk.328.1540353847025;
        Tue, 23 Oct 2018 21:04:07 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:06 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] x86/vdso: Renames variable to fix shadow warning.
Date:   Wed, 24 Oct 2018 01:03:50 -0300
Message-Id: <20181024040354.24879-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024040354.24879-1-leobras.c@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The go32() and go64() functions have an argument and a local variable
called ‘name’.  Rename both to clarify the code and to fix a warning
with -Wshadow.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/x86/entry/vdso/vdso2c.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index fa847a620f40..a20b134de2a8 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -7,7 +7,7 @@
 
 static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			 void *stripped_addr, size_t stripped_len,
-			 FILE *outfile, const char *name)
+			 FILE *outfile, const char *image_name)
 {
 	int found_load = 0;
 	unsigned long load_size = -1;  /* Work around bogus warning */
@@ -93,11 +93,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
-		const char *name = raw_addr + GET_LE(&strtab_hdr->sh_offset) +
-			GET_LE(&sym->st_name);
+		const char *sym_name = raw_addr +
+				       GET_LE(&strtab_hdr->sh_offset) +
+				       GET_LE(&sym->st_name);
 
 		for (k = 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k].name)) {
+			if (!strcmp(sym_name, required_syms[k].name)) {
 				if (syms[k]) {
 					fail("duplicate symbol %s\n",
 					     required_syms[k].name);
@@ -134,7 +135,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	if (syms[sym_vvar_start] % 4096)
 		fail("vvar_begin must be a multiple of 4096\n");
 
-	if (!name) {
+	if (!image_name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
 	}
@@ -157,7 +158,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 	fprintf(outfile, "\n};\n\n");
 
-	fprintf(outfile, "const struct vdso_image %s = {\n", name);
+	fprintf(outfile, "const struct vdso_image %s = {\n", image_name);
 	fprintf(outfile, "\t.data = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
-- 
2.19.1

