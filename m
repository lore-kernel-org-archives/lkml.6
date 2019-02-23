Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D788F206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQBsUEfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBWHEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:04:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44170 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBWHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:04:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so2081833pls.11;
        Fri, 22 Feb 2019 23:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=V9oHt98crmFrdUvp7m267PBEG8+VEKI9MKfQ+oxnd90=;
        b=SQBsUEfezZFarr0BfV/nBxxA5r3Qp869wxfWnurAcuP/+FXnozR7Kqno0t8ehNRXgb
         EGVmTC6fTVcqpwz9pPQEJdRW+S/Hyut+TBN2glOZj1nevKokQHrYmEK880FOwlegIXyZ
         GAvvWGY9wiH7nL48WZjvtLgln0ewRGBe/KDkQssJ5TDbPfbp5tCcpy+/Z0j5YQbIc+c/
         NLQaQkXIiZXzG2bwCAVbpD8YOMyvJ23FApk7SVrpOFR5WZwV53n7UfQ8FDYROlzkVGGd
         FybE+5oX05L02GPA6MyVbYuNJr0iLwZqIbxnQSVvQcrdD04Z3POa/0ZS25TMBVePxXQa
         VJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=V9oHt98crmFrdUvp7m267PBEG8+VEKI9MKfQ+oxnd90=;
        b=TZhyap3MortZq6n1w+IHWe3i/OhN4Kx1IyUBWA7vzE4YmdACYuu5JP8kNSqKOueNIQ
         GwiIwtfwQnVSclVJMrRU8Z4givCxDyRHFD1yibry4O331PjaZ5a/ZOxmiJnHcU2QC+ve
         SGeQ2SDMLXlrrcOZLw7Yk/GanCekzXPi+/w3xfT7K8fRL50Hhfk0GzCBh4MpME3zTs1d
         H8vJypGn6zvY8xuLgwWJ6kPlOaI8Spi2IeRYy+b5NpaSyzPYBguyipBAvFGqHy4QMcPG
         3gm9ItFNLbEpgSUKQUBSphcTZbhqLZo1Kf4i/FaVdFpx20fqIPugNr4A4CV3P/r0AsJ9
         ip2Q==
X-Gm-Message-State: AHQUAuaWUxH185+Rt1bap7EN5baMzf15EYDkpyvGbXXsxD29sYaofZGP
        +kEWDaRi/cb2nR+9zMkCoyQ=
X-Google-Smtp-Source: AHgI3IbfhdT+5w9bnfHnexY3r0tLTLyeGXfxwWZRPyY7PYZHTGUjuw4JJNjE9HVw5P7nLEmR2l2NMg==
X-Received: by 2002:a17:902:6f08:: with SMTP id w8mr8201728plk.5.1550905481641;
        Fri, 22 Feb 2019 23:04:41 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([1.39.146.163])
        by smtp.gmail.com with ESMTPSA id t12sm6634255pgq.68.2019.02.22.23.04.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Feb 2019 23:04:40 -0800 (PST)
Date:   Sat, 23 Feb 2019 12:39:02 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     bamv2005@gmail.com, shuah@kernel.org, davem@davemloft.net,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        adobriyan@gmail.com, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, paulmck@linux.ibm.com, boqun.feng@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] tools: testing: selftests: Remove duplicate headers
Message-ID: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c          | 1 -
 tools/testing/selftests/net/udpgso.c                        | 1 -
 tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
 tools/testing/selftests/proc/proc-self-syscall.c            | 1 -
 tools/testing/selftests/rseq/rseq.h                         | 1 -
 tools/testing/selftests/timers/skew_consistency.c           | 1 -
 tools/testing/selftests/x86/mpx-dig.c                       | 2 --
 7 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index aaa1e9f..d587c81 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index e279051..b8265ee 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -17,7 +17,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
index 167135b..af1b802 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
@@ -11,7 +11,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
-#include <signal.h>
 
 #include "ebb.h"
 
diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 5ab5f48..3a4fec3 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -20,7 +20,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <unistd.h>
 #include <string.h>
 #include <stdio.h>
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70..6c1126e7 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <linux/rseq.h>
 
 /*
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711..8066be9 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607e..880fbf6 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

