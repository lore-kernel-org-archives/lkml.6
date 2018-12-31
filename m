Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CC821783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV8MTMZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeLaN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:27:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41135 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeLaN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:27:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so23601969ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0M4OawCboNcD91Tap7IyIZTkmVexgAxLIIXYJWmUsZY=;
        b=cV8MTMZPz3gBTw7vLq1oN3ZG6Pgs4lDCZTNvUdHLVn9fyoF1KXd0gnaCQ03DhUuNOt
         mOLBhdTPI9z/o5XUlgkFrzgDgFWUSOH0Z6TIJ0dmUOo1W6W2J/2aVTHXHaS+rTBDFW7F
         PGVR0TKz7sgneoYv5Dhp4KDTh7mrI/j8NZlfj++w6XgCw6t1+bfgRWzG60dUHreZ1F6N
         fnK96Xkeax9XEuvojl0hWlk26rKOJMwJsW+u3uAK49Zml7ai3QZuoNUV7u8icLMBIalV
         9EvX+6eptbu++bX5VjY0uPBWbLE/+qucZ5xYmDpbRCGAdMrHslAsCZXn2CwieQl1X7A0
         xbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M4OawCboNcD91Tap7IyIZTkmVexgAxLIIXYJWmUsZY=;
        b=HcfBbAK+f0xlmrWWqctjbB79oD6D4T2bbml87DYacV+430cxK7fi8cPbnPS7T2AuOu
         cRgxtTucyEWwo27mu/ue51aPpU+gTdmJehmQumuK1bvMMcVqGbYvtXkF8h49lXFasJD0
         TJ0ZtwhUr8M1cJFUcRw5MlyVseWWuwy51Eli1jrFhIFEZvPLNs4mX5nJjfOT+sxjfPnz
         bA56tmNgAa+o6IDO8tFnzZByHocbPnc8AV7A4NL2mh4RT4osh99AwcMKPFdQ/c8swPT7
         uE2N8mzQv7RvXtPUrH4y4UdcsMwmXU2y6acgsopirIYQnY6OrmVbEGDDdiOXoHITylKK
         /a7Q==
X-Gm-Message-State: AJcUukeLuqPUQ5nFZlfk5UROFELfFBYVlso83ZQyNU+9Sm7kNjSV4vah
        RWkEAXZLacCZtjKtOlF3NAs=
X-Google-Smtp-Source: ALg8bN75tW18bA7H2RNfwbdlH1L4oCQsyWKv//tuq+BNLw+1AxvAHMdCUSBghNd7qu7I/2h/VKYFfQ==
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr16664172ljc.39.1546262820227;
        Mon, 31 Dec 2018 05:27:00 -0800 (PST)
Received: from localhost.localdomain (mm-142-13-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.13.142])
        by smtp.gmail.com with ESMTPSA id y23-v6sm10162231ljk.95.2018.12.31.05.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 05:26:59 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v2 3/3] selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE
Date:   Mon, 31 Dec 2018 14:26:40 +0100
Message-Id: <20181231132640.21898-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231132640.21898-1-urezki@gmail.com>
References: <20181231132640.21898-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the test script for the kernel test driver to analyse vmalloc
allocator for benchmarking and stressing purposes. It is just a kernel
module loader. You can specify and pass different parameters in order
to investigate allocations behaviour. See "usage" output for more
details.

Also add basic vmalloc smoke test to the "run_vmtests" suite.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/vm/run_vmtests     |  11 ++
 tools/testing/selftests/vm/test_vmalloc.sh | 173 +++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 tools/testing/selftests/vm/test_vmalloc.sh

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 88cbe5575f0c..56053ac2bf47 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -200,4 +200,15 @@ else
     echo "[PASS]"
 fi
 
+echo "------------------------------------"
+echo "running vmalloc stability smoke test"
+echo "------------------------------------"
+./test_vmalloc.sh smoke
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/test_vmalloc.sh b/tools/testing/selftests/vm/test_vmalloc.sh
new file mode 100755
index 000000000000..f4f0d3990f2c
--- /dev/null
+++ b/tools/testing/selftests/vm/test_vmalloc.sh
@@ -0,0 +1,173 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to analyse vmalloc
+# allocator. Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of vmalloc allocations;
+#     b) stressing and stability check of vmalloc subsystem.
+
+TEST_NAME="vmalloc"
+DRIVER="test_${TEST_NAME}"
+
+# 1 if fails
+exitcode=1
+
+#
+# Static templates for performance, stressing and smoke tests.
+# Also it is possible to pass any supported parameters manualy.
+#
+PERF_PARAM="single_cpu_test=1 sequential_test_order=1 test_repeat_count=3"
+SMOKE_PARAM="single_cpu_test=1 test_loop_count=10000 test_repeat_count=10"
+STRESS_PARAM="test_repeat_count=20"
+
+check_test_requirements()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $exitcode
+	fi
+
+	if ! which modprobe > /dev/null 2>&1; then
+		echo "$0: You need modprobe installed"
+		exit $exitcode
+	fi
+
+	if ! modinfo $DRIVER > /dev/null 2>&1; then
+		echo "$0: You must have the following enabled in your kernel:"
+		echo "CONFIG_TEST_VMALLOC=m"
+		exit $exitcode
+	fi
+}
+
+run_perfformance_check()
+{
+	echo "Run performance tests to evaluate how fast vmalloc allocation is."
+	echo "It runs all test cases on one single CPU with sequential order."
+
+	modprobe $DRIVER $PERF_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Ccheck the kernel message buffer to see the summary."
+}
+
+run_stability_check()
+{
+	echo "Run stability tests. In order to stress vmalloc subsystem we run"
+	echo "all available test cases on all available CPUs simultaneously."
+	echo "It will take time, so be patient."
+
+	modprobe $DRIVER $STRESS_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_smoke_check()
+{
+	echo "Run smoke test. Note, this test provides basic coverage."
+	echo "Please check $0 output how it can be used"
+	echo "for deep performance analysis as well as stress testing."
+
+	modprobe $DRIVER $SMOKE_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+usage()
+{
+	echo -n "Usage: $0 [ performance ] | [ stress ] | | [ smoke ] | "
+	echo "manual parameters"
+	echo
+	echo "Valid tests and parameters:"
+	echo
+	modinfo $DRIVER
+	echo
+	echo "Example usage:"
+	echo
+	echo "# Shows help message"
+	echo "./${DRIVER}.sh"
+	echo
+	echo "# Runs 1 test(id_1), repeats it 5 times on all online CPUs"
+	echo "./${DRIVER}.sh run_test_mask=1 test_repeat_count=5"
+	echo
+	echo -n "# Runs 4 tests(id_1|id_2|id_4|id_16) on one CPU with "
+	echo "sequential order"
+	echo -n "./${DRIVER}.sh single_cpu_test=1 sequential_test_order=1 "
+	echo "run_test_mask=23"
+	echo
+	echo -n "# Runs all tests on all online CPUs, shuffled order, repeats "
+	echo "20 times"
+	echo "./${DRIVER}.sh test_repeat_count=20"
+	echo
+	echo "# Performance analysis"
+	echo "./${DRIVER}.sh performance"
+	echo
+	echo "# Stress testing"
+	echo "./${DRIVER}.sh stress"
+	echo
+	exit $exitcode
+}
+
+function validate_passed_args()
+{
+	VALID_ARGS=`modinfo $DRIVER | awk '/parm:/ {print $2}' | sed 's/:.*//'`
+
+	#
+	# Something has been passed, check it.
+	#
+	for passed_arg in $@; do
+		key=${passed_arg//=*/}
+		val="${passed_arg:$((${#key}+1))}"
+		valid=0
+
+		for valid_arg in $VALID_ARGS; do
+			if [[ $key = $valid_arg ]] && [[ $val -gt 0 ]]; then
+				valid=1
+				break
+			fi
+		done
+
+		if [[ $valid -ne 1 ]]; then
+			echo "Error: key or value is not correct: ${key} $val"
+			exit $exitcode
+		fi
+	done
+}
+
+function run_manual_check()
+{
+	#
+	# Validate passed parameters. If there is wrong one,
+	# the script exists and does not execute further.
+	#
+	validate_passed_args $@
+
+	echo "Run the test with following parameters: $@"
+	modprobe $DRIVER $@ > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+function run_test()
+{
+	if [ $# -eq 0 ]; then
+		usage
+	else
+		if [[ "$1" = "performance" ]]; then
+			run_perfformance_check
+		elif [[ "$1" = "stress" ]]; then
+			run_stability_check
+		elif [[ "$1" = "smoke" ]]; then
+			run_smoke_check
+		else
+			run_manual_check $@
+		fi
+	fi
+}
+
+check_test_requirements
+run_test $@
+
+exit 0
-- 
2.11.0

