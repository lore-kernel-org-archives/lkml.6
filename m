Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97391ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036720844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="latej/bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4036720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGPMtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:49:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40493 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeGPMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:48:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so29791650edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVZIJPfvWJqOSFveqFBy2DcrPUiSUudnPwDvBU+djl0=;
        b=latej/bnQ6e2xx7dGFsNEEB0rGAz34NFJLp53eBusAUOwA8+V2T96PhEhXiAkFky8E
         8VpfbWo9E0XwOGfOduqfJLTGmtT19P2zwY6yctG/fmh5+GWNroTe7jS1hDcFhM0boGkE
         VXaU0wFnVZn8jDlY/Hc3hJLlYz02uc2RLUiLxQDdpWXRSrMom3TrnhbdhV/jZo+mITFN
         7DQFUMM8btSdMHO0peDNyberBR5yjc9wbAcmn2/D4Gf2TQ08bNIH77aHgMo8sUYmz1qd
         JcPocKJiNSrAzbzx57VOxVL0DlWf3Ix2tzSnnjY0DPfME+Yf8syI6b1mtxIPuwp9iujQ
         fcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVZIJPfvWJqOSFveqFBy2DcrPUiSUudnPwDvBU+djl0=;
        b=jHSwdxtECTMjOwEi30jv3R7kDZwt4pqXMDXAyHoGkHv6AbOWUtlBh3MGo4f3es9Spx
         kGLR3FOq7119CraaZngWpoO0jbk2v88KuQEdKfVExc5V1Yus2N9o9z4JDhMnyZoFW7fR
         iEEfZBb0359KDppP7yqWtVrsjM+hEJZs6Xs8eHsgknP0ra19v5tazsvKSPT2S9St915U
         dOmP4HYhJ2AoQA/j357QA5TmkTfLndA+pZeKRbuRiV+MppbupqAp3bOKrqZHT8nhS7f0
         R6D7TF+eo9Dt8L0pyag9jEmxMd7Qq9mcMeQxQ+sHhHTMBv0tkBcbpleViKmsyRMfAFIj
         uCmw==
X-Gm-Message-State: AOUpUlEV5HnMEIi6qYVwKfLWmBHzImURz7kB4sU1R+LjgNbx493exgmp
        xfogJE/bOrbTfikISFVB4hVii2wDYFs=
X-Google-Smtp-Source: AAOMgpdADJwxmcLe5kwD62Tsw9tQT2sAu7WdYyaoFf05HHZsMXN1NgWJuldTp/92+BI3mgfLQmPvhQ==
X-Received: by 2002:a50:b5a5:: with SMTP id a34-v6mr16570081ede.88.1531743697889;
        Mon, 16 Jul 2018 05:21:37 -0700 (PDT)
Received: from maco.fcp3.net (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4635471edi.26.2018.07.16.05.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:21:37 -0700 (PDT)
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
Subject: [PATCH 4/6] modpost: add support for generating namespace dependencies.
Date:   Mon, 16 Jul 2018 14:21:23 +0200
Message-Id: <20180716122125.175792-5-maco@android.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180716122125.175792-1-maco@android.com>
References: <20180716122125.175792-1-maco@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an option to modpost to generate a .ns_deps file per
module, containing the namespace depedencies for that module.

This file can subsequently be used by other tools to automatically add
newly introduced namespaces to the modules that require them, saving a
lot of manual work.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 scripts/mod/modpost.c | 58 +++++++++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h |  2 ++
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a56a8461a96a..be33d60d5527 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -39,6 +39,8 @@ static int sec_mismatch_verbose = 1;
 static int sec_mismatch_fatal = 0;
 /* ignore missing files */
 static int ignore_missing_files;
+/* Write namespace dependencies */
+static int write_ns_deps;
 
 enum export {
 	export_plain,      export_unused,     export_gpl,
@@ -2151,10 +2153,15 @@ static void check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->ns && !module_imports_namespace(mod, exp->ns)) {
-			warn("module %s uses symbol %s from namespace %s, "
-			     "but does not import it.\n",
-			     basename, exp->name, exp->ns);
+		if (exp->ns) {
+			add_namespace(&mod->required_namespaces, exp->ns);
+
+			if (!write_ns_deps &&
+			    !module_imports_namespace(mod, exp->ns)) {
+				warn("module %s uses symbol %s from namespace "
+				     "%s, but does not import it.\n",
+				     basename, exp->name, exp->ns);
+			}
 		}
 
 		if (!mod->gpl_compatible)
@@ -2457,6 +2464,38 @@ static void write_dump(const char *fname)
 	free(buf.p);
 }
 
+static void write_ns_deps_files(void)
+{
+	struct module *mod;
+	struct namespace_list *ns;
+	struct buffer ns_deps_buf = { };
+
+	for (mod = modules; mod; mod = mod->next) {
+		char fname[PATH_MAX];
+		const char *basename;
+
+		if (mod->skip)
+			continue;
+
+		ns_deps_buf.pos = 0;
+
+		for (ns = mod->required_namespaces; ns; ns = ns->next)
+			buf_printf(&ns_deps_buf, "%s\n", ns->namespace);
+
+		if (ns_deps_buf.pos == 0)
+			continue;
+
+		basename = strrchr(mod->name, '/');
+		if (basename)
+			basename++;
+		else
+			basename = mod->name;
+
+		sprintf(fname, ".tmp_versions/%s.ns_deps", basename);
+		write_if_changed(&ns_deps_buf, fname);
+	}
+}
+
 struct ext_sym_list {
 	struct ext_sym_list *next;
 	const char *file;
@@ -2473,7 +2512,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:Ed")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2517,6 +2556,9 @@ int main(int argc, char **argv)
 		case 'E':
 			sec_mismatch_fatal = 1;
 			break;
+		case 'd':
+			write_ns_deps = 1;
+			break;
 		default:
 			exit(1);
 		}
@@ -2545,6 +2587,12 @@ int main(int argc, char **argv)
 		check_exports(mod);
 	}
 
+	if (write_ns_deps) {
+		/* Just write namespace dependencies and exit */
+		write_ns_deps_files();
+		return 0;
+	}
+
 	err = 0;
 
 	for (mod = modules; mod; mod = mod->next) {
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 9626bf3e7424..92a926d375d2 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -126,6 +126,8 @@ struct module {
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	int is_dot_o;
+	// Required namespace dependencies
+	struct namespace_list *required_namespaces;
 	// Actual imported namespaces
 	struct namespace_list *imported_namespaces;
 };
-- 
2.18.0.203.gfac676dfb9-goog

