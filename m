Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D6BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8011520674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA/j+LYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8011520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJWJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:31:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35613 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:31:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id v68-v6so26656971qka.2;
        Mon, 22 Oct 2018 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=reoZw2EkBU8/NGU6BCm+2JztCf8UNgy8iBR4BKrH64U=;
        b=EA/j+LYBkM+RBFZU5keaLDcsqOpcchNN/uKTn8MEvNJ/RcrESKtM8A8TMSRltoGlRs
         0AEr4IU0cR3CelZZaPsUcrVqZoLTyuCU4Ix32imUECzRp0hejG0krYen7Oqo/Yn0GQs6
         Q9wTEjdD4DXZXpgOE/cfGlzZSn38yYY2xm/TDNPqGn6q6OFilHtUnP7mm9LBm0198/EF
         0YKio5TzxSxhKPUm8iIl8uMSYZQLBGsptUUBH0jnwyyTqu7nVIus0HT5yq2sXMm2pCdm
         Yyb0ythWLxbkhwHs89kFXQUiQQW0caWModhJ9zklk0blbi0ryr/+BBxqA4tnNV2zypdv
         FrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=reoZw2EkBU8/NGU6BCm+2JztCf8UNgy8iBR4BKrH64U=;
        b=o+qLFhr4Ivpp+LCw0MWtT0vDHrHL9m53Bu2bKnTNM8GxNxNJkKwXb9wo2umDZN/bfA
         xeyjgJjZnXjT8W4MlT5WRzMxS+nxFTMt3U9ElB2kN8XHFbmaKJsygvNBM5bqQvcIpQyN
         OIwzxtnRCLPm1yaLWFfwwNbfRoY07YybgbvhFAE7IqEGYnstRzMvw503NJJ7xmKAFdB3
         EdT3/POZRq23mZE+s+mOif6dn6eOk2ppeg1S/nS8XKHFQaQg1+ClCIgBVS22c/hZyadO
         eqph4c4ij6jalDQ9lapoYoZ4PAVrTHq0suOWzvDdOFdapXt8GQCbwVtks1XO6Kb9tp2I
         TlVg==
X-Gm-Message-State: AGRZ1gIRidKFmdK/Lz0sB4xu8ARbZV8LWlTqXH5ZZt+/DoxEiZq4470f
        3j94gL7+YL+7IM3Dbqpl46Q=
X-Google-Smtp-Source: AJdET5fn72VDC7tABC9mL7qYTi8BDoOi6Df/QIRiHu5zFkt6H2KzWGLEU5Sb7M0jm47M6vOp8JBfQw==
X-Received: by 2002:a37:d87:: with SMTP id 129-v6mr9625516qkn.212.1540257029355;
        Mon, 22 Oct 2018 18:10:29 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 82-v6sm11379958qkg.16.2018.10.22.18.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:10:28 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:10:22 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] x86/vdso: Renames variable to fix shadow warning.
Message-ID: <20181023011022.GA6574@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames the char variable to avoid shadowing a variable previously
declared on this function.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
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

