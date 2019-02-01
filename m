Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369072084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzoVSu8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfBANrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:47:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfBANrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:47:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so3254722pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zz965XBfeCbUTX9fVRtMKkUoHNbgPl7uY8ky+wHq4Tg=;
        b=pzoVSu8mMCjh1Mr2Sp9ZsNn79eHIs8bdzjc0xj83tu2QDp1mXQMyh5wNEIiMIc3eyd
         fxAfbwHC6uPY6E8WeU9ByxujtunuNauXqUQc/J30PpNsuQCqLQdP5A2ohe3xv44bbI1d
         G9mH8a1vXUHskMWe1USoRDadsWg7gNeJYKEmoBL3i5x+jcd9UDY0bLvBIHY5te9x0eoY
         xWNwQ7ow2+AZBGk+v8ONUK2iL/u1sN1RB/mHpHIEz6f94dFwr3AYXlgUViNec/rVo6QU
         ww/wrp6O0wGjDa+8ghscSeZuJaW31k7o6BQKKhYMxoA792OLBZPDRfCOfnjvHsMhHdmJ
         jprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zz965XBfeCbUTX9fVRtMKkUoHNbgPl7uY8ky+wHq4Tg=;
        b=W/eVcJ4nEsWyeBwx3ksKnhrVm33FU9WFfhEHfb4Tk71JQaLfx5i90AitcESXBP2E+h
         oK6jESyNOu1IYSqtc/8lWfvRsEZy6jiUfoMyUUSbH23igiXDQqPtr59GUQRKnlL0816U
         xDXqLcL0bV9aVwNaKpI5uOEsIrJUpE+VdSNw45wJujFa4bEvdQE1lTM9QAw5HnBEyGfL
         pF5CAnsI7BVjWxad/5Jsn3eAewMflzkidffuwI9nsejumBgDRxB6Dw3ZltxNgxUwYoE7
         /PU2oGkU3vbf1rEiEhs7mN94gg7VGJt99tVwNlXWs0rfr4msrxGCrpxMgyCNcmTxjhMu
         3WjA==
X-Gm-Message-State: AJcUukfaHFs8Z+fYk9n+pC/7vGrsaxtucD+XURPFz6N5tUCLYZpdYhEG
        zsVncyVSPT5KbcZS/fwh75M=
X-Google-Smtp-Source: ALg8bN45G8KFTsxdktQKbDbi2Tq9BHjXPsHx+KLGBy/VuYJefaEMuUgTTJiMF9EiC8Fjlp7FoRR4PQ==
X-Received: by 2002:a62:c42:: with SMTP id u63mr38745523pfi.73.1549028837216;
        Fri, 01 Feb 2019 05:47:17 -0800 (PST)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id d21sm9860377pfo.162.2019.02.01.05.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 05:47:16 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: [PATCH v2] perf record: Add doc for bpf event selection
Date:   Fri,  1 Feb 2019 21:46:51 +0800
Message-Id: <20190201134651.12373-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document for how to pass bpf program with perf.

Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: fix grammar and add llvm section in perf-config.txt.
---
 tools/perf/Documentation/perf-config.txt | 31 ++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt | 14 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 4ac7775fbc11..86f3dcc15f83 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -120,6 +120,10 @@ Given a $HOME/.perfconfig like this:
 		children = true
 		group = true
 
+	[llvm]
+		dump-obj = true
+		clang-opt = -g
+
 You can hide source code of annotate feature setting the config to false with
 
 	% perf config annotate.hide_src_code=true
@@ -553,6 +557,33 @@ trace.*::
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
+llvm.*::
+	llvm.clang-path::
+		Path to clang. If omit, search it from $PATH.
+
+	llvm.clang-bpf-cmd-template::
+		Cmdline template. Below lines show its default value. Environment
+		variable is used to pass options.
+		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
+		-Wno-unused-value -Wno-pointer-sign -working-directory \
+		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+
+	llvm.clang-opt::
+		Options passed to clang.
+
+	llvm.kbuild-dir::
+		kbuild directory. If not set, use /lib/modules/`uname -r`/build.
+		If set to "" deliberately, skip kernel header auto-detector.
+
+	llvm.kbuild-opts::
+		Options passed to 'make' when detecting kernel header options.
+
+	llvm.dump-obj::
+		Enable perf dump BPF object files compiled by LLVM.
+
+	llvm.opts::
+		Options passed to llc.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..aa94ec7335df 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -88,6 +88,20 @@ OPTIONS
           If you want to profile write accesses in [0x1000~1008), just set
           'mem:0x1000/8:w'.
 
+        - a bpf source file (ending in .c) or a precompiled object file (ending
+          in .o) selects one or more BPF events.
+          The BPF program can attach to various perf events based on section
+          names.
+
+          When passing '.c', perf searches an installed LLVM to compile it into
+          an object file first. Optional clang options can be pased by option
+          '--clang-opt'.
+
+          perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
+                      -e ./tests/bpf-script-example.c
+
+          Note: '--clang-opt' must place before '--event'.
+
 	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
 	  Each event is separated by commas and the group should be quoted to
 	  prevent the shell interpretation.  You also need to use --group on
-- 
2.19.1

