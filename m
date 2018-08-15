Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E00EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4C215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AWbi6eIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF4C215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeHORUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:20:30 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34124 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeHORU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:20:29 -0400
Received: by mail-lj1-f175.google.com with SMTP id f8-v6so1121276ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n7WUS0fKlMJeliJ0iVDgDM0bVFy8v2B78VhpQ00X0gc=;
        b=AWbi6eIEgLvZ0w5jCL0adOrFg7glp2UoH27I/PoPy7ocKBxNnJw+w6v04cdFHOSjCa
         GE1VIq/tOnPAKlM0DI/KieDGzl9fmwmwZEzp4L+kku9zQpi6TRSkwR7S9aZTIvIjpvTu
         JLP8wuwpsltDFlSPLt2K87EDPzCrHPpir53vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n7WUS0fKlMJeliJ0iVDgDM0bVFy8v2B78VhpQ00X0gc=;
        b=SdQCfdYgMPyJN9kUSjc4VC2XDhsLC/qTVSnVxzODOQ+zt7InWzjmjk6c2CHYreq7VA
         J+PxSnYerU62R3sTLKfrDpXL73GYl9A6wUT+DccOyHYVQ8anqUhMdkGxQ74nh7SVVXBk
         oxr+iVgFWjrV5h48z0HKwBGsNePpJA1//hAjkiD88V5MrqLlSIqbOvGT6YusdPJ1NCwX
         VR0n/W2FB0RXmLMjDSXuzNRa4p+Bgm1DIaDfFEjK5KUawvIQANAV04aXJT1xEO7yWeCL
         k5JS0Meq45IVGrOp2dg/VE721zXtdFULx3gS/hlXSOrzHoVstUIcFQ5dtESu1sWLK9tO
         fe3w==
X-Gm-Message-State: AOUpUlGv5EcL6D1NQ+wSEuYBiOaHmRsf0NXMcUjms7WzKB/qPUmqlYlV
        L//gxeLRRdq5WxmwxZd+Tp+YhA==
X-Google-Smtp-Source: AA+uWPygkwnyDvOT8lsonh346skNO2Fz32YdNbYqmp6CCZyEChwMSKd0uC0XYyE+yxTHeKE8vmQTyA==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr15801669ljg.114.1534343285495;
        Wed, 15 Aug 2018 07:28:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3-v6sm4559597lfi.36.2018.08.15.07.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 07:28:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Kbuild: let fixdep do the renaming to .cmd
Date:   Wed, 15 Aug 2018 16:27:49 +0200
Message-Id: <20180815142749.18804-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid spawning one more process per TU by having fixdep open the tmpfile
and rename to its final name.

The only change in behaviour is that if fixdep fails, the tmpfile we
leave behind is $(dot-target).cmd.tmp rather than $(dot-target).tmp .

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/Kbuild.include | 10 ++++------
 scripts/basic/fixdep.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index a944510acd9d..ded089436a3f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -274,9 +274,8 @@ ifndef CONFIG_TRIM_UNUSED_KSYMS
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	scripts/basic/fixdep -r $(depfile) $@ '$(make-cmd)'                  \
-		> $(dot-target).tmp;                                         \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+	scripts/basic/fixdep -r -o $(dot-target).cmd                         \
+		$(depfile) $@ '$(make-cmd)';
 
 else
 
@@ -298,9 +297,8 @@ ksym_dep_filter =                                                            \
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
 	$(ksym_dep_filter) |                                                 \
-		scripts/basic/fixdep -e -r $(depfile) $@ '$(make-cmd)'       \
-			> $(dot-target).tmp;	                             \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+		scripts/basic/fixdep -e -r -o $(dot-target).cmd              \
+			$(depfile) $@ '$(make-cmd)';
 
 endif
 
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 7b59c185858a..78985052a3c7 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -94,6 +94,7 @@
  *  but I don't think the added complexity is worth it)
  */
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -105,9 +106,10 @@
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: fixdep [-e] [-r] <depfile> <target> <cmdline>\n");
+	fprintf(stderr, "Usage: fixdep [-e] [-r] [-o <output>] <depfile> <target> <cmdline>\n");
 	fprintf(stderr, " -e  insert extra dependencies given on stdin\n");
 	fprintf(stderr, " -r  remove <depfile> after processing\n");
+	fprintf(stderr, " -o  write to <output> instead of stdout\n");
 	exit(1);
 }
 
@@ -380,15 +382,17 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
 int main(int argc, char *argv[])
 {
 	const char *depfile, *target, *cmdline;
+	char *outfile = NULL, *tmpfile;
 	int insert_extra_deps = 0;
 	int remove_depfile = 0;
 	void *buf;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "er")) != -1) {
+	while ((opt = getopt(argc, argv, "ero:")) != -1) {
 		switch (opt) {
 		case 'e': insert_extra_deps = 1; break;
 		case 'r': remove_depfile = 1; break;
+		case 'o': outfile = optarg; break;
 		default: usage();
 		}
 	}
@@ -402,12 +406,35 @@ int main(int argc, char *argv[])
 	target = argv[1];
 	cmdline = argv[2];
 
+	if (outfile) {
+		if (asprintf(&tmpfile, "%s.tmp", outfile) < 0) {
+			perror("fixdep:asprintf");
+			exit(1);
+		}
+		if (freopen(tmpfile, "w", stdout) == NULL) {
+			perror("fixdep:freopen");
+			exit(1);
+		}
+	}
+
 	printf("cmd_%s := %s\n\n", target, cmdline);
 
 	buf = read_file(depfile);
 	parse_dep_file(buf, target, insert_extra_deps);
 	free(buf);
 
+	if (fclose(stdout)) {
+		perror("fixdep:fclose");
+		exit(1);
+	}
+	if (outfile) {
+		if (rename(tmpfile, outfile) < 0) {
+			perror("fixdep:rename");
+			exit(1);
+		}
+		free(tmpfile);
+	}
+
 	if (remove_depfile)
 		unlink(depfile);
 
-- 
2.16.4

