Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D5C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfBVUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:54:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:54:14 -0500
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHpk-0000Lx-HV
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:54:12 +0000
Received: by mail-wm1-f71.google.com with SMTP id u74so740425wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRPeMIi4WkzlI/wi4uTphGWN+IH4+mQk5AY4oH1wsVE=;
        b=ex0IrbE6v2SCbZBFMGCA4/CTnopWetiaa/a1EuN0M6Q9XeKUTQyMyHa5n/FAbEeGF7
         KrVboFR7nXLhKT+wH5kQKDLFZuIAz9URgnzfCgwWntM9MofasJUAwPXMX4QN3ItY7S4W
         /nK4CqyEM0BW/Sqv9yuRLQ/37nEhuMX2QeNzaS6tzM3qmNyvtitVgznb6atREaU1E86x
         LzBK+GByL0PfoNjcGAQn/EQjyhg7rpzMs0exyV+4XiUc+c48v4589fbhNktN9BF/8tS7
         NxRUA0BBAExJje59kYBhRZyAQiTuMPM5YLFP57/GxZsi2NgH17r+eGYcObU3ZpdVJ/6K
         894A==
X-Gm-Message-State: AHQUAub1X87WvRG4BasaeBdjwfohr23qlhxbhqUuo8/TX3hr26Neaoma
        reA/NldrJrHqHnZo5t8v+P50cu36uYh7wAui4cce+crYm4FW6lFcCyNTgQ9Zl3lmPvXwRxoofIJ
        aMuCKT/GZozAMbACxVOkNaLHw7L73ZBXU1xleolEofQ==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr3731360wmi.3.1550868851594;
        Fri, 22 Feb 2019 12:54:11 -0800 (PST)
X-Google-Smtp-Source: AHgI3Ialsemdfap9Uq6CkVhuIqk/R+3D8RwXnBkjzKnz4OIkFedPm1/Tr/PIJkJuQiFWK7EGw45u7w==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr3731351wmi.3.1550868851431;
        Fri, 22 Feb 2019 12:54:11 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id r14sm1432990wrv.77.2019.02.22.12.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:54:10 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
Date:   Fri, 22 Feb 2019 21:53:50 +0100
Message-Id: <20190222205351.743-2-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222205351.743-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205351.743-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo -e is not POSIX. Depending on what /bin/sh is, we can get
incorrect output like:
$ -e -n [1] Basic trace file check
$ -e 	[PASS]

Fix that by using printf instead.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index fc755e1b50f1..20c9c0ad8682 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -173,8 +173,13 @@ strip_esc() {
 }
 
 prlog() { # messages
-  echo -e "$@"
-  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
+  newline="\n"
+  if [ "$1" = "-n" ] ; then
+    newline=
+    shift
+  fi
+  printf "$*$newline"
+  [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
   cat $1
-- 
2.19.1

