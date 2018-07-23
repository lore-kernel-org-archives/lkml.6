Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBBC20878
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgyXe18d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBBC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeGWHtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387828AbeGWHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:49:12 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E887720846;
        Mon, 23 Jul 2018 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532328570;
        bh=IvL/xSy/3BU+4aUAtvc5vvngfpI4dTPps9l1r2MUnc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgyXe18dvJm3pm9OUdPzg3wmYJbP3VjIKUv+Fi9daF8CvbvRs+Pu1PLq9ZQCkVkmQ
         HkA6ZnCKghr0kzWLu3cRacJm/1QOIXSkYx/FNDzKOIOPqmlVZl1EorOHSC3ZkTtpXK
         8O3RhssaMdV/qwJMPtakmj6UD1Om3lvvliV+I8O8=
Date:   Mon, 23 Jul 2018 08:49:21 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Martijn Coenen <maco@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com,
        malchev@google.com, joelaf@google.com
Subject: Re: [PATCH 4/6] modpost: add support for generating namespace
 dependencies.
Message-ID: <20180723064921.wepzdsj7tb7ptjbz@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com>
 <20180716122125.175792-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180716122125.175792-5-maco@android.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.11-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Martijn Coenen [16/07/18 14:21 +0200]:
>This patch adds an option to modpost to generate a .ns_deps file per
>module, containing the namespace depedencies for that module.
>
>This file can subsequently be used by other tools to automatically add
>newly introduced namespaces to the modules that require them, saving a
>lot of manual work.
>
>Signed-off-by: Martijn Coenen <maco@android.com>

Regarding modpost, I think it may also be helpful to additionally
output the namespace an exported symbol belongs to (if any) in the
Module.symvers file.

>---
> scripts/mod/modpost.c | 58 +++++++++++++++++++++++++++++++++++++++----
> scripts/mod/modpost.h |  2 ++
> 2 files changed, 55 insertions(+), 5 deletions(-)
>
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index a56a8461a96a..be33d60d5527 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -39,6 +39,8 @@ static int sec_mismatch_verbose = 1;
> static int sec_mismatch_fatal = 0;
> /* ignore missing files */
> static int ignore_missing_files;
>+/* Write namespace dependencies */
>+static int write_ns_deps;
>
> enum export {
> 	export_plain,      export_unused,     export_gpl,
>@@ -2151,10 +2153,15 @@ static void check_exports(struct module *mod)
> 		else
> 			basename = mod->name;
>
>-		if (exp->ns && !module_imports_namespace(mod, exp->ns)) {
>-			warn("module %s uses symbol %s from namespace %s, "
>-			     "but does not import it.\n",
>-			     basename, exp->name, exp->ns);
>+		if (exp->ns) {
>+			add_namespace(&mod->required_namespaces, exp->ns);
>+
>+			if (!write_ns_deps &&
>+			    !module_imports_namespace(mod, exp->ns)) {
>+				warn("module %s uses symbol %s from namespace "
>+				     "%s, but does not import it.\n",
>+				     basename, exp->name, exp->ns);
>+			}
> 		}
>
> 		if (!mod->gpl_compatible)
>@@ -2457,6 +2464,38 @@ static void write_dump(const char *fname)
> 	free(buf.p);
> }
>
>+static void write_ns_deps_files(void)
>+{
>+	struct module *mod;
>+	struct namespace_list *ns;
>+	struct buffer ns_deps_buf = { };
>+
>+	for (mod = modules; mod; mod = mod->next) {
>+		char fname[PATH_MAX];
>+		const char *basename;
>+
>+		if (mod->skip)
>+			continue;
>+
>+		ns_deps_buf.pos = 0;
>+
>+		for (ns = mod->required_namespaces; ns; ns = ns->next)
>+			buf_printf(&ns_deps_buf, "%s\n", ns->namespace);
>+
>+		if (ns_deps_buf.pos == 0)
>+			continue;
>+
>+		basename = strrchr(mod->name, '/');
>+		if (basename)
>+			basename++;
>+		else
>+			basename = mod->name;
>+
>+		sprintf(fname, ".tmp_versions/%s.ns_deps", basename);
>+		write_if_changed(&ns_deps_buf, fname);
>+	}
>+}
>+
> struct ext_sym_list {
> 	struct ext_sym_list *next;
> 	const char *file;
>@@ -2473,7 +2512,7 @@ int main(int argc, char **argv)
> 	struct ext_sym_list *extsym_iter;
> 	struct ext_sym_list *extsym_start = NULL;
>
>-	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
>+	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:Ed")) != -1) {
> 		switch (opt) {
> 		case 'i':
> 			kernel_read = optarg;
>@@ -2517,6 +2556,9 @@ int main(int argc, char **argv)
> 		case 'E':
> 			sec_mismatch_fatal = 1;
> 			break;
>+		case 'd':
>+			write_ns_deps = 1;
>+			break;
> 		default:
> 			exit(1);
> 		}
>@@ -2545,6 +2587,12 @@ int main(int argc, char **argv)
> 		check_exports(mod);
> 	}
>
>+	if (write_ns_deps) {
>+		/* Just write namespace dependencies and exit */
>+		write_ns_deps_files();
>+		return 0;
>+	}
>+
> 	err = 0;
>
> 	for (mod = modules; mod; mod = mod->next) {
>diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
>index 9626bf3e7424..92a926d375d2 100644
>--- a/scripts/mod/modpost.h
>+++ b/scripts/mod/modpost.h
>@@ -126,6 +126,8 @@ struct module {
> 	struct buffer dev_table_buf;
> 	char	     srcversion[25];
> 	int is_dot_o;
>+	// Required namespace dependencies
>+	struct namespace_list *required_namespaces;
> 	// Actual imported namespaces
> 	struct namespace_list *imported_namespaces;
> };
>-- 
>2.18.0.203.gfac676dfb9-goog
>
