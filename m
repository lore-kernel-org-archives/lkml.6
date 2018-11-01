Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5197A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP0R5w69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5197A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeKAMUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:20:50 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36020 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeKAMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:20:50 -0400
Received: by mail-qt1-f169.google.com with SMTP id u34-v6so19662062qth.3;
        Wed, 31 Oct 2018 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuLNrA7rriyAhJkMEFnPydKWkWCnPgwIADQDCUFLAjQ=;
        b=YP0R5w697jYe21ywRL4bkHcmI/HeCD/0qKSNHlanWBVUQqerOVYHDw2UlQMXlGhPaV
         IwaEplPBIxZ0xwZmi7ismNmexgDRM+Rj2sYSJYHUDpx9xIdtKZ2OrfcTwsQgeLc8F9q9
         458FjWMRC786b/zP4UNKCb+eVbEmUqB7r3PoNiyOGuLH07N5I5Tce83lFpg9i08OoE2V
         JcG7K+jhuvz/CG4WviUZBgqjNd0TTDqgp7pN6v947T5vYM9uuZcdXY8ky+OqigUnupxg
         GdYvAj3z3paeC8wJuPuPV0dnRtGgOqo2+fGiEVoYFcRLifnHmjlLjYWnwPs+CRt5Qcm/
         Qy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuLNrA7rriyAhJkMEFnPydKWkWCnPgwIADQDCUFLAjQ=;
        b=JuSFR0cUCoj52rXRIYlfDPt8+lpBZG2+kmuOmCYZ6ALZifbtyU3nk+TVPuWrLWBTfS
         /3gRJaGcZqdV2rkDHcEo1H9V4e+HjMnbgbtBjYJuQa+mhmSjdj1oAW4byjm05e615MJx
         G/8vKMWi7LTdB5K6Fs+wojg2JpK0041RhgNlnJc0NVQtV5cei+tVB6B8vfIYpDZA/Kt+
         5n7wB/0WfZiejOpRRT/herFAc/bin7Fcy7tXbrFtmVlBqLEzshY/gyMhl8PO4BucGBV1
         w3agwlW4AVnI8+FErNI8Q6KFd0j9LR+bZrVjVFS4/FBByNgJ7iMi1aCbBd9t59BL8wr0
         3VQw==
X-Gm-Message-State: AGRZ1gLtFW46SQRKK4vVYWx5tLbbp4pq6izkp+qinNrW1qfWvi7h3YX5
        zcxO4O7PyD+SKjZo9ZmbbMTwrHhL
X-Google-Smtp-Source: AJdET5dWiBj+TdTe+Kl1Aezo4rdf5WSBi0OOlwbDKpoQWYSvw3pjf6YQLIMhXKZgq7nl3EiGMKtkmQ==
X-Received: by 2002:ac8:458e:: with SMTP id l14-v6mr5256964qtn.124.1541042385927;
        Wed, 31 Oct 2018 20:19:45 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id s52-v6sm24343300qts.5.2018.10.31.20.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 20:19:45 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] modpost: Refactor and removes global variable *modules
Date:   Thu,  1 Nov 2018 00:19:40 -0300
Message-Id: <20181101031940.23119-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactors the code to accept the modules list as a parameter in
the functions that need it, and moves the variable from the
global scope to the main function scope.

This also fixes the parameter shadowing of add_depends.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 scripts/mod/modpost.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..bebe65ed957a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -118,10 +118,7 @@ void *do_nofail(void *ptr, const char *expr)
 	return ptr;
 }
 
-/* A list of all modules we processed */
-static struct module *modules;
-
-static struct module *find_module(const char *modname)
+static struct module *find_module(const char *modname, struct module *modules)
 {
 	struct module *mod;
 
@@ -131,7 +128,7 @@ static struct module *find_module(const char *modname)
 	return mod;
 }
 
-static struct module *new_module(const char *modname)
+static struct module *new_module(const char *modname, struct module **pmodules)
 {
 	struct module *mod;
 	char *p;
@@ -149,8 +146,8 @@ static struct module *new_module(const char *modname)
 	/* add to list */
 	mod->name = p;
 	mod->gpl_compatible = -1;
-	mod->next = modules;
-	modules = mod;
+	mod->next = *pmodules;
+	*pmodules = mod;
 
 	return mod;
 }
@@ -1929,7 +1926,7 @@ static char *remove_dot(char *s)
 	return s;
 }
 
-static void read_symbols(const char *modname)
+static void read_symbols(const char *modname, struct module **pmodules)
 {
 	const char *symname;
 	char *version;
@@ -1941,7 +1938,7 @@ static void read_symbols(const char *modname)
 	if (!parse_elf(&info, modname))
 		return;
 
-	mod = new_module(modname);
+	mod = new_module(modname, pmodules);
 
 	/* When there's no vmlinux, don't print warnings about
 	 * unresolved symbols (since there'll be too many ;) */
@@ -1992,7 +1989,8 @@ static void read_symbols(const char *modname)
 		mod->unres = alloc_symbol("module_layout", 0, mod->unres);
 }
 
-static void read_symbols_from_files(const char *filename)
+static void read_symbols_from_files(const char *filename,
+				    struct module **pmodules)
 {
 	FILE *in = stdin;
 	char fname[PATH_MAX];
@@ -2006,7 +2004,7 @@ static void read_symbols_from_files(const char *filename)
 	while (fgets(fname, PATH_MAX, in) != NULL) {
 		if (strends(fname, "\n"))
 			fname[strlen(fname)-1] = '\0';
-		read_symbols(fname);
+		read_symbols(fname, pmodules);
 	}
 
 	if (in != stdin)
@@ -2318,7 +2316,8 @@ static void write_if_changed(struct buffer *b, const char *fname)
 /* parse Module.symvers file. line format:
  * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
  **/
-static void read_dump(const char *fname, unsigned int kernel)
+static void read_dump(const char *fname, unsigned int kernel,
+		      struct module **pmodules)
 {
 	unsigned long size, pos = 0;
 	void *file = grab_file(fname, &size);
@@ -2347,11 +2346,11 @@ static void read_dump(const char *fname, unsigned int kernel)
 		crc = strtoul(line, &d, 16);
 		if (*symname == '\0' || *modname == '\0' || *d != '\0')
 			goto fail;
-		mod = find_module(modname);
+		mod = find_module(modname, *pmodules);
 		if (!mod) {
 			if (is_vmlinux(modname))
 				have_vmlinux = 1;
-			mod = new_module(modname);
+			mod = new_module(modname, pmodules);
 			mod->skip = 1;
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
@@ -2415,6 +2414,8 @@ int main(int argc, char **argv)
 	int err;
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
+	/* A list of all modules we processed */
+	static struct module *modules;
 
 	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
 		switch (opt) {
@@ -2466,21 +2467,21 @@ int main(int argc, char **argv)
 	}
 
 	if (kernel_read)
-		read_dump(kernel_read, 1);
+		read_dump(kernel_read, 1, &modules);
 	if (module_read)
-		read_dump(module_read, 0);
+		read_dump(module_read, 0, &modules);
 	while (extsym_start) {
-		read_dump(extsym_start->file, 0);
+		read_dump(extsym_start->file, 0, &modules);
 		extsym_iter = extsym_start->next;
 		free(extsym_start);
 		extsym_start = extsym_iter;
 	}
 
 	while (optind < argc)
-		read_symbols(argv[optind++]);
+		read_symbols(argv[optind++], &modules);
 
 	if (files_source)
-		read_symbols_from_files(files_source);
+		read_symbols_from_files(files_source, &modules);
 
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
-- 
2.19.1

