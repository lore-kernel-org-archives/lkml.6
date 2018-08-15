Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D62C216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RoHdLxuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D62C216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeHORU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:20:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42423 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbeHORU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:20:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so1093159ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OYwUrioNl0zu7PVa/7o6YFOoh5jN7+LZqEy07jO1sw=;
        b=RoHdLxuWjTk/rNqR20+kqFPqE+YmvChPEWvIfIoh0xsfbFvs0Cv53/HL4B99ASpYXB
         lfRVRlTEiiE/jOPdWVRhNxer02ttnJnejDr9qRS5oZrFdZCKOJfqPnl7NRYu6ALgO1jI
         snbagIsjAJrr6/i2pDRkk3PPpcyPJH953OVMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OYwUrioNl0zu7PVa/7o6YFOoh5jN7+LZqEy07jO1sw=;
        b=DeLQojvZyXj9Sy+nWeKkksOqlrhlWushwkp1MfGaLyVFyYFXfaiss2P1oRvu+XOfrC
         nVCt/H5vr15XP1VFtWSomOzHhk0y2KvzFVBKVbcWVJtv9QlTCBJFGIs8lMDP7WUoeLTK
         w7PvmQ/V+Yf/BmHwVpABuNWQZWB55lytblFTKcOVuN2j/h/swGqA4OkQrRQC/qn7093J
         YV2A6Lwbk8JC04epLd+y3S97qX7QmA4xSSu3AVscRPMalOx24KibQHIZ/4Dx+nWY7BMO
         jpLZ9KzKbyU2st3pMczENwunwsuABvyWkte61OHQ49NaajoHw6guPe3cX0YskzZlQzFG
         hCCw==
X-Gm-Message-State: AOUpUlFJfRe85jHeXXM8uLaniSMN6VbdHUXt03n2A+necgCOfd4OkWUT
        MrXbkzbvuaUBAV85N+OJWKDovg==
X-Google-Smtp-Source: AA+uWPwx9eqaLRvtean9XmwcRN3Qu7MNpL+hO5JjbqGcHvMwd+Q9c4kWVsz1iPSLQM+FS0wWQVgxfA==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr17648692ljj.53.1534343284381;
        Wed, 15 Aug 2018 07:28:04 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3-v6sm4559597lfi.36.2018.08.15.07.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 07:28:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Kbuild: teach fixdep to optionally remove the depfile
Date:   Wed, 15 Aug 2018 16:27:48 +0200
Message-Id: <20180815142749.18804-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having to spawn an 'rm' instance to remove the depfile after
processing, let the fixdep program itself do that. For debugging, it's
nice to not do it unconditionally.

Note that the fixdep calls from Makefiles are done under 'set -e', so
this also preserves the behaviour of keeping the depfile if fixdep exits
prematurely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/Kbuild.include |  7 +++----
 scripts/basic/fixdep.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index d52db4279aa5..a944510acd9d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -274,8 +274,8 @@ ifndef CONFIG_TRIM_UNUSED_KSYMS
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
-	rm -f $(depfile);                                                    \
+	scripts/basic/fixdep -r $(depfile) $@ '$(make-cmd)'                  \
+		> $(dot-target).tmp;                                         \
 	mv -f $(dot-target).tmp $(dot-target).cmd;
 
 else
@@ -298,9 +298,8 @@ ksym_dep_filter =                                                            \
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
 	$(ksym_dep_filter) |                                                 \
-		scripts/basic/fixdep -e $(depfile) $@ '$(make-cmd)'          \
+		scripts/basic/fixdep -e -r $(depfile) $@ '$(make-cmd)'       \
 			> $(dot-target).tmp;	                             \
-	rm -f $(depfile);                                                    \
 	mv -f $(dot-target).tmp $(dot-target).cmd;
 
 endif
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 666041841200..7b59c185858a 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -105,8 +105,9 @@
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: fixdep [-e] <depfile> <target> <cmdline>\n");
+	fprintf(stderr, "Usage: fixdep [-e] [-r] <depfile> <target> <cmdline>\n");
 	fprintf(stderr, " -e  insert extra dependencies given on stdin\n");
+	fprintf(stderr, " -r  remove <depfile> after processing\n");
 	exit(1);
 }
 
@@ -380,12 +381,14 @@ int main(int argc, char *argv[])
 {
 	const char *depfile, *target, *cmdline;
 	int insert_extra_deps = 0;
+	int remove_depfile = 0;
 	void *buf;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "e")) != -1) {
+	while ((opt = getopt(argc, argv, "er")) != -1) {
 		switch (opt) {
 		case 'e': insert_extra_deps = 1; break;
+		case 'r': remove_depfile = 1; break;
 		default: usage();
 		}
 	}
@@ -405,5 +408,8 @@ int main(int argc, char *argv[])
 	parse_dep_file(buf, target, insert_extra_deps);
 	free(buf);
 
+	if (remove_depfile)
+		unlink(depfile);
+
 	return 0;
 }
-- 
2.16.4

