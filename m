Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D04BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D61220844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aNQFipmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D61220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGPMsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:48:50 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41683 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbeGPMsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:48:50 -0400
Received: by mail-ed1-f44.google.com with SMTP id s24-v6so13612528edr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uMKHrpNNhtX0cvVMIjiPuRB/bNICYt0G5I9g8+sP+nE=;
        b=aNQFipmi4W+YFASqmc2Msq0FamvrT7dN0ntsO7ETyikVz8z/hwEyg7uLk4awX4Kmk5
         cSr0QdVT3FZkhlFktid85Hh4sdcjzG5SY0sScJIWYd+8Fquv4LzjpNTZTfJVDLFDC6l0
         LI1vIXfrFvQGJ7bhrNcmjRjc09jBGyUsCPQMG8AH3l/g1IABE0ogVxAt+1+PTQvSZnh7
         Amkf3ei0RczAsgK7d/nK+qFqnO5R+H2QLeA+sKYlnvr6LRAlEaGBxRXdeDH0If9/j1yA
         q3jAQkj6GfqidOFDDega9bbRPmfXU5ZCo37EHqd4SEYtSWBx96OiuvAyOqvMnXNJC+qJ
         cTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uMKHrpNNhtX0cvVMIjiPuRB/bNICYt0G5I9g8+sP+nE=;
        b=dq8igN8r5Go6UrYDOWzJC1EeWTzIM/wpVsMs+4RvMpxE0/IPTn7ISXoLZ+UPDCtx40
         BK/NXxjNFdanpJpEJscPLSPIItwQiL2+1IyxzXvSCVpDCzEnS9IwUlhdc9Xz7orMc6x0
         GWOQFE3SqO3URzZNUavdQA4mOntxRf5s9FZhrh0FVdCkEEl9UPD01kcrSVFFNQngniqo
         kz/izS98GP8/6bTZw55TO9YLeY1/udx7EbP80eUCWsJ1WD+VaWQY72/FavIe16nyPcoy
         oIgccx/3wPvu2OJIJAqhG0VGE/bk/BAMVVHYxXYZoNN8jDF7ZuqwjnvNGlfyKxtZoFn4
         Nmzw==
X-Gm-Message-State: AOUpUlFA0VJCU4HaVOvb6hQvLixhsNBBkSil2OCAbqoJf6VP+1kkxBjk
        5xwLe/jGx2zXhZTmFuCYk995a1/PnNM=
X-Google-Smtp-Source: AAOMgpfdnu7YE//VAJQwgJ10pJe8y2O0ZaaPONgU2SP4pX7piFevT8Zda1qjmcK3IgrY/fLluFcbYA==
X-Received: by 2002:aa7:d7d0:: with SMTP id e16-v6mr16457372eds.82.1531743696632;
        Mon, 16 Jul 2018 05:21:36 -0700 (PDT)
Received: from maco.fcp3.net (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4635471edi.26.2018.07.16.05.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:21:35 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com,
        malchev@google.com, joelaf@google.com
Subject: [PATCH 3/6] modpost: add support for checking symbol namespaces.
Date:   Mon, 16 Jul 2018 14:21:22 +0200
Message-Id: <20180716122125.175792-4-maco@android.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180716122125.175792-1-maco@android.com>
References: <20180716122125.175792-1-maco@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emits a warning whenever a module refers to an exported symbol without
explicitly importing the namespace that it is defined in.

Example:

WARNING: module ums-usbat uses symbol usb_stor_resume from namespace
USB_STORAGE_NS, but does not import it.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 scripts/mod/modpost.c | 70 +++++++++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h |  7 +++++
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1663fb19343a..a56a8461a96a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -165,6 +165,7 @@ struct symbol {
 	struct module *module;
 	unsigned int crc;
 	int crc_valid;
+	const char *ns; /* namespace */
 	unsigned int weak:1;
 	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
 	unsigned int kernel:1;     /* 1 if symbol is from kernel
@@ -234,6 +235,35 @@ static struct symbol *find_symbol(const char *name)
 	return NULL;
 }
 
+static bool contains_namespace(struct namespace_list *list, const char *ns)
+{
+	struct namespace_list *ns_entry;
+
+	for (ns_entry = list; ns_entry != NULL; ns_entry = ns_entry->next) {
+		if (strcmp(ns_entry->namespace, ns) == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static void add_namespace(struct namespace_list **list, const char *ns)
+{
+	struct namespace_list *ns_entry;
+
+	if (!contains_namespace(*list, ns)) {
+		ns_entry = NOFAIL(malloc(sizeof(struct namespace_list)));
+		strcpy(ns_entry->namespace, ns);
+		ns_entry->next = *list;
+		*list = ns_entry;
+	}
+}
+
+static bool module_imports_namespace(struct module *module, const char *ns)
+{
+	return contains_namespace(module->imported_namespaces, ns);
+}
+
 static const struct {
 	const char *str;
 	enum export export;
@@ -313,21 +343,40 @@ static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
 		return export_unknown;
 }
 
+static const char *sym_extract_ns(const char **symname)
+{
+	size_t n;
+
+	n = strcspn(*symname, ".");
+	if (n < strlen(*symname) - 1) {
+		char *dupsymname = NOFAIL(strdup(*symname));
+
+		dupsymname[n] = '\0';
+		*symname = dupsymname;
+		return dupsymname + n + 1;
+	} else {
+		return NULL;
+	}
+}
+
 /**
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
  **/
-static struct symbol *sym_add_exported(const char *name, struct module *mod,
-				       enum export export)
+static struct symbol *sym_add_exported(const char *name,
+				       struct module *mod, enum export export)
 {
-	struct symbol *s = find_symbol(name);
+	const char *extract_name = name;
+	const char *ns = sym_extract_ns(&extract_name);
+	struct symbol *s = find_symbol(extract_name);
 
 	if (!s) {
-		s = new_symbol(name, mod, export);
+		s = new_symbol(extract_name, mod, export);
+		s->ns = ns;
 	} else {
 		if (!s->preloaded) {
 			warn("%s: '%s' exported twice. Previous export "
-			     "was in %s%s\n", mod->name, name,
+			     "was in %s%s\n", mod->name, extract_name,
 			     s->module->name,
 			     is_vmlinux(s->module->name) ?"":".ko");
 		} else {
@@ -697,6 +746,10 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		}
 		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = 1;
+		if (strstarts(symname, "__knsimport_")) {
+			const char *name = symname + strlen("__knsimport_");
+			add_namespace(&mod->imported_namespaces, name);
+		}
 		if (strcmp(symname, "cleanup_module") == 0)
 			mod->has_cleanup = 1;
 		break;
@@ -2097,6 +2150,13 @@ static void check_exports(struct module *mod)
 			basename++;
 		else
 			basename = mod->name;
+
+		if (exp->ns && !module_imports_namespace(mod, exp->ns)) {
+			warn("module %s uses symbol %s from namespace %s, "
+			     "but does not import it.\n",
+			     basename, exp->name, exp->ns);
+		}
+
 		if (!mod->gpl_compatible)
 			check_for_gpl_usage(exp->export, basename, exp->name);
 		check_for_unused(exp->export, basename, exp->name);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 8453d6ac2f77..9626bf3e7424 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -109,6 +109,11 @@ buf_printf(struct buffer *buf, const char *fmt, ...);
 void
 buf_write(struct buffer *buf, const char *s, int len);
 
+struct namespace_list {
+	struct namespace_list *next;
+	char namespace[0];
+};
+
 struct module {
 	struct module *next;
 	const char *name;
@@ -121,6 +126,8 @@ struct module {
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	int is_dot_o;
+	// Actual imported namespaces
+	struct namespace_list *imported_namespaces;
 };
 
 struct elf_info {
-- 
2.18.0.203.gfac676dfb9-goog

