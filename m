Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F484C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0481B21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmvVejGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBIK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:56:18 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38074 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfBIK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:56:18 -0500
Received: by mail-wm1-f47.google.com with SMTP id v26so7739657wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W2Qcxf/+h9zIBPNrDI4K1i8iwM4Q3fgZNla8lT1itvI=;
        b=nmvVejGSQiWz0fYyC08xbIUaFSXhTismLq0gHzs6pXB+EB1ysO31QM8tZsdm02qMgq
         34c+pTuiBumaKTFob4goxfW3odfmtzcfTgVBrJNor1TMex4IAnn4FIn1nsLwqJClLL33
         xQ6I3++dLVPoRBxkkpduXgDoYlKO0xpHdYsOz2EW7aRa4k9YwhELIwGLOhdnLJOG3A5+
         S0Yj3XKJdkOGNvfL6bZwGH1zdo7FzJfwYjVjukmnRrdlcax230XcjJoEBuWBWqpTUXpy
         mbKwx93qlZ3ky+IrVFE3s/RsuRfnd1TPVKx+vFdiZWkL4GLfQ/WZLJ3W0jRKt+9IFVqo
         AwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W2Qcxf/+h9zIBPNrDI4K1i8iwM4Q3fgZNla8lT1itvI=;
        b=ASWAPBUSIp69rlD06c8Alfjo+D2annzupkn2QFbSu8eQvWy+EbGTQNTKeIK8WB/g36
         FJSAJCi2ZOBKAOWw1e4LSQxSXm43XPE8EbCaRNPFhnb9zeCZm6vBTYo0vZpBTB+Gh/6z
         Q7Ew/0M6FL9fpPlMPWDo+IhxG4HPUQF6/payiT619g3yLHqPcCfN8oQ4p5yr7dnqKdBc
         FieYfxJt7IroGDWjdS0/qVp2EzGRUpBHrlZVPPInRFCUrkxL8rZ5F0Zoj12s+RCsygv6
         BDXn3ZQ/YIOh6YeuviFOxsQ5Te4ag53HO00Jqisv2t5PrFnkADMjbCT/ICzjShTQR/Rj
         nJqQ==
X-Gm-Message-State: AHQUAuZ8Rrikv3r/2uqNr0e7LFPCo9BW/NNnuiKw9eSy+uMhoiAkS/Bw
        bYI9YO7jb5RfRTyYvXKFKnb1DVU=
X-Google-Smtp-Source: AHgI3Iaqcd07dOYM2duuWa+/EoFm5ASpVyfggDAWEAD5ijKRmt25khNNTObHwjfHGtqQ5gP92I8Ahg==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr13893617wrq.273.1549709776354;
        Sat, 09 Feb 2019 02:56:16 -0800 (PST)
Received: from avx2 ([46.53.242.39])
        by smtp.gmail.com with ESMTPSA id j33sm7814387wre.91.2019.02.09.02.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 02:56:15 -0800 (PST)
Date:   Sat, 9 Feb 2019 13:56:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: more robust bulk read test
Message-ID: <20190209105613.GA10384@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc may not be mounted and test will exit successfully.

Ensure proc is mounted at /proc.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/read.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -26,8 +26,10 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 #include <sys/stat.h>
+#include <sys/vfs.h>
 #include <fcntl.h>
 #include <unistd.h>
 
@@ -123,10 +125,22 @@ static void f(DIR *d, unsigned int level)
 int main(void)
 {
 	DIR *d;
+	struct statfs sfs;
 
 	d = opendir("/proc");
 	if (!d)
 		return 2;
+
+	/* Ensure /proc is proc. */
+	if (fstatfs(dirfd(d), &sfs) == -1) {
+		return 1;
+	}
+	if (sfs.f_type != 0x9fa0) {
+		fprintf(stderr, "error: unexpected f_type %lx\n", (long)sfs.f_type);
+		return 2;
+	}
+
 	f(d, 0);
+
 	return 0;
 }
