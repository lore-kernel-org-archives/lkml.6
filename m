Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CFC10F0B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8AE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBVJKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:10:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48503 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBVJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:10:43 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gx6qv-0006RQ-Ui
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 09:10:41 +0000
Received: by mail-wr1-f72.google.com with SMTP id j16so751338wrp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y+FAKynn9y4C92BfdiFIYfrKjDXa7bUo8PBg50cEQ8=;
        b=aoO/5HKpti3e8X2nNCudALbfPamw42AS+GOhVZYqUSGEQ3PASiISnqryWDStcPy44L
         4jtc6M3iqJrjc/F3cIaMLgeFhwNLBLK5DFhuKsvJcqFsxe1SJvWg4Vd/1aT6XP+7Eo7p
         Q06B5OTNKXIX4SroNMCfAPqf5RVXtoQNrzsyIAvu4HdkzVZhfRMGbVixBBEDnkh2r1bg
         LUEg63uZ2gwCAiymiHbC/OKPcpoiR7IwinUMclEX5RhiPf/ddigHl3PLwLE61+moOzLx
         i7zoDyGTG3lCEafBoHGkO8E266p4vL2QFKvekHwcsMZ/MMHoft3zm4qzQR61kZQMEEhS
         ghRw==
X-Gm-Message-State: AHQUAuaGnlHFQujjjHtFnC9285EjRxOrRPwJXwf/sHOrNR0xitoJJZW5
        9AAjdtyZwTI8rrErBwc2GN9Aa/QhOiTrKCI/nFaRMHdwezXBRjcC6YGDYZtJ1fK0EUe7h3WEgn/
        oXr69VagDZoi9f69gOqYc8dGARMEBJa5NZ6pGArmiRQ==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr1205564wrs.294.1550826641366;
        Fri, 22 Feb 2019 01:10:41 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYndlPgK7Et5bfoF3YWSIXwiuGJxByhBAro/jVzIok97F7WMwQZUUOiqBvv+FMI9HCe4kLONw==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr1205552wrs.294.1550826641254;
        Fri, 22 Feb 2019 01:10:41 -0800 (PST)
Received: from localhost.localdomain ([194.204.107.10])
        by smtp.gmail.com with ESMTPSA id f126sm292559wmf.6.2019.02.22.01.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:10:40 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 2/2] selftests/ftrace: Replace \e with \033
Date:   Fri, 22 Feb 2019 10:10:21 +0100
Message-Id: <20190222091021.10178-3-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222091021.10178-1-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
 <20190222091021.10178-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The \e sequence character is not POSIX. Fix that by using \033 instead.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 20c9c0ad8682..136387422b00 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -161,10 +161,10 @@ color_green=
 color_blue=
 # If stdout exists and number of colors is eight or more, use them
 if [ -t 1 -a "$ncolors" -ge 8 ]; then
-  color_reset="\e[0m"
-  color_red="\e[31m"
-  color_green="\e[32m"
-  color_blue="\e[34m"
+  color_reset="\033[0m"
+  color_red="\033[31m"
+  color_green="\033[32m"
+  color_blue="\033[34m"
 fi
 
 strip_esc() {
-- 
2.19.1

