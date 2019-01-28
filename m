Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A922175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690751;
	bh=eDFwEh+ZmzJK1Q3KeYklCisN3mudpWsNQInYGOJtr5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUhvLKofytKeRnjWWOhOMRWYfbBDtC2IbQA4Zoh8wjOpawNoqcKP7VDC1Zv5B+JPs
	 0Hh2x0rDnaNHkOld3y6irJcBLAZmN5osN3W6n90wtq+TsktjpuiUjc0ORMYjS/Qhiz
	 QfGL9b+hsdITec4ot/GogN0O2dWgvL1ctrh9WVyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfA1Pw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1Pw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F4F20880;
        Mon, 28 Jan 2019 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690746;
        bh=eDFwEh+ZmzJK1Q3KeYklCisN3mudpWsNQInYGOJtr5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHJJh1241UgZnQNW1Z50PVroklQv9dtx9EC2SiQ0tTfVBo9w2FGaVAnaFLZRweRCK
         ETD1U/7O4O6BQNHWbOD9siNZjQE+1FBF2cU78wwfskJhUVMaqt8NZReY9qx7urDWFa
         a+JujyktafixdvpvyI7ofue+toQrTcSuRhQZXrpY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 180/304] tools: bpftool: fix -Wmissing declaration warnings
Date:   Mon, 28 Jan 2019 10:41:37 -0500
Message-Id: <20190128154341.47195-180-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit c101189bc9680675a2686bafe908015a07a0da51 ]

Help compiler check arguments for several utility functions used to
print items to the console by adding the "printf" attribute when
declaring those functions.

Also, declare as "static" two functions that are only used in prog.c.

All of them discovered by compiling bpftool with
-Wmissing-format-attribute -Wmissing-declarations.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c        | 4 ++--
 tools/bpf/bpftool/json_writer.c   | 6 ++++--
 tools/bpf/bpftool/prog.c          | 4 ++--
 tools/bpf/bpftool/xlated_dumper.c | 7 ++++---
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 70fd48d79f61..05d715e6b128 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -58,7 +58,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
-void p_err(const char *fmt, ...)
+void __printf(1, 2) p_err(const char *fmt, ...)
 {
 	va_list ap;
 
@@ -76,7 +76,7 @@ void p_err(const char *fmt, ...)
 	va_end(ap);
 }
 
-void p_info(const char *fmt, ...)
+void __printf(1, 2) p_info(const char *fmt, ...)
 {
 	va_list ap;
 
diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index c6eef76322ae..4e4149421d07 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <inttypes.h>
 #include <stdint.h>
+#include <linux/compiler.h>
 
 #include "json_writer.h"
 
@@ -156,7 +157,8 @@ void jsonw_name(json_writer_t *self, const char *name)
 		putc(' ', self->out);
 }
 
-void jsonw_vprintf_enquote(json_writer_t *self, const char *fmt, va_list ap)
+void __printf(2, 0)
+jsonw_vprintf_enquote(json_writer_t *self, const char *fmt, va_list ap)
 {
 	jsonw_eor(self);
 	putc('"', self->out);
@@ -164,7 +166,7 @@ void jsonw_vprintf_enquote(json_writer_t *self, const char *fmt, va_list ap)
 	putc('"', self->out);
 }
 
-void jsonw_printf(json_writer_t *self, const char *fmt, ...)
+void __printf(2, 3) jsonw_printf(json_writer_t *self, const char *fmt, ...)
 {
 	va_list ap;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index ccee180dfb76..69b01a6158bd 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -84,7 +84,7 @@ static const char * const attach_type_strings[] = {
 	[__MAX_BPF_ATTACH_TYPE] = NULL,
 };
 
-enum bpf_attach_type parse_attach_type(const char *str)
+static enum bpf_attach_type parse_attach_type(const char *str)
 {
 	enum bpf_attach_type type;
 
@@ -713,7 +713,7 @@ struct map_replace {
 	char *name;
 };
 
-int map_replace_compar(const void *p1, const void *p2)
+static int map_replace_compar(const void *p1, const void *p2)
 {
 	const struct map_replace *a = p1, *b = p2;
 
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 3284759df98a..98083e4dc0f9 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -114,7 +114,7 @@ struct kernel_sym *kernel_syms_search(struct dump_data *dd,
 		       sizeof(*dd->sym_mapping), kernel_syms_cmp) : NULL;
 }
 
-static void print_insn(void *private_data, const char *fmt, ...)
+static void __printf(2, 3) print_insn(void *private_data, const char *fmt, ...)
 {
 	va_list args;
 
@@ -123,7 +123,7 @@ static void print_insn(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
-static void
+static void __printf(2, 3)
 print_insn_for_graph(void *private_data, const char *fmt, ...)
 {
 	char buf[64], *p;
@@ -154,7 +154,8 @@ print_insn_for_graph(void *private_data, const char *fmt, ...)
 	printf("%s", buf);
 }
 
-static void print_insn_json(void *private_data, const char *fmt, ...)
+static void __printf(2, 3)
+print_insn_json(void *private_data, const char *fmt, ...)
 {
 	unsigned int l = strlen(fmt);
 	char chomped_fmt[l];
-- 
2.19.1

