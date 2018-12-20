Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237C218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbeLTS17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:27:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeLTS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:27:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIRmQ13686412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:27:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIRmDJ3686408;
        Thu, 20 Dec 2018 10:27:48 -0800
Date:   Thu, 20 Dec 2018 10:27:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3r9blij6n8wdlsyd5dujx86r@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        lclaudio@redhat.com, namhyung@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@kernel.org
Reply-To: acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Wire up the x86_arch prctl code table
 generator
Git-Commit-ID: 40714e8b37723c31aa1b48dd2f346c3827059957
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  40714e8b37723c31aa1b48dd2f346c3827059957
Gitweb:     https://git.kernel.org/tip/40714e8b37723c31aa1b48dd2f346c3827059957
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 17:00:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:19 -0300

perf beauty: Wire up the x86_arch prctl code table generator

  $ cat /tmp/build/perf/trace/beauty/generated/x86_arch_prctl_code_array.c
  #define x86_arch_prctl_codes_1_offset 0x1001
  static const char *x86_arch_prctl_codes_1[] = {
	[0x1001 - 0x1001]= "SET_GS",
	[0x1002 - 0x1001]= "SET_FS",
	[0x1003 - 0x1001]= "GET_FS",
	[0x1004 - 0x1001]= "GET_GS",
	[0x1011 - 0x1001]= "GET_CPUID",
	[0x1012 - 0x1001]= "SET_CPUID",
  };

  #define x86_arch_prctl_codes_2_offset 0x2001
  static const char *x86_arch_prctl_codes_2[] = {
	[0x2001 - 0x2001]= "MAP_VDSO_X32",
	[0x2002 - 0x2001]= "MAP_VDSO_32",
	[0x2003 - 0x2001]= "MAP_VDSO_64",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3r9blij6n8wdlsyd5dujx86r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8c1350c591f2..3af432bccd3e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -396,6 +396,7 @@ SHELL = $(SHELL_PATH)
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
+x86_arch_asm_uapi_dir := $(srctree)/tools/arch/x86/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
@@ -490,6 +491,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
+x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
+
+$(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
+	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(x86_arch_asm_uapi_dir) > $@
+
 rename_flags_array := $(beauty_outdir)/rename_flags_array.c
 rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
 
@@ -610,6 +617,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array)
 
@@ -907,6 +915,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
