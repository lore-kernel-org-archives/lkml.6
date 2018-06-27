Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F98C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039E625284
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnIRv5vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039E625284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966118AbeF0TvK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:51:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44301 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965654AbeF0TvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:51:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id p12-v6so3171221wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=KlcY18rCo18wSPaSXYIxo3ylA3s7nippMFpOL+uhToA=;
        b=jnIRv5vBiP89v1Gka3OuXCxk6T5lhuE+U5BosCQQQ0+gnFHV604aEFrj+DBbefBZAi
         EniHA02pb2tvU9LU05zON8Bzqyg3tlGluLTY4dPnWBhjPGw6ufeqf37KRE8PC7R7avl2
         0P9f7HqnV7TXdy+/4wE5w/zb6P6Lr423N4ZFTSPLeHO4tAVDADHfVtUsQLL5ILZp8t6H
         yZ2W5Ix7n+CtK2kF4WoXAUalxx0Jh1g4Ul70lOWF/uyTgCtCO5m6Bf0jcfjOcPxv5h87
         5jCXnagr5ZTdNFH/klF4BkZe2DXYy32Vxj/9SbxYC/0H8ydiJOnpUK1OxzgIDSyqWjRS
         y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=KlcY18rCo18wSPaSXYIxo3ylA3s7nippMFpOL+uhToA=;
        b=CO10q6HKEKmmNIih9xKynA9W5k1KLi4PSRJGm4xUj1DZMzVO5JE8+boGpJYMatMgZT
         Wj+n6cYl+yxAgHjEFmogzyjmZ7/plL08ntBxgaMhcHiJP6RtZXJuW6sKX5W4X+i9K9Lt
         Jdf4Iq2aSEzjELaFIo9PKD+2LfcICImTb4E1FNv9yGeWjXlGKo9VKeglss4VrFFFmuLh
         7SQPoVEGif/4yJT8B02yJgfQC6uJp3MrR4xnpUm8TVTARJ0aEMwi+Wp/8W580tEW8Eiw
         yNGbRZCurl4xOIpl7bR8CyDwkt6GcpVIRBNVhzj/mFf91ifBTZv7XBPkyxpMqVAgruqJ
         aHdA==
X-Gm-Message-State: APt69E0KthKb81qQ8ehmTTZd6GZ+0ziXKi2M6Xb74eNgaiusRmW+2/RQ
        QBVs4+dzlk6tVIxFhkpbxctN
X-Google-Smtp-Source: AAOMgpc5maH7LCLggmI+YbQr1xq5VxPqDs+MRTqiHYyN5yqUW4bKh6x4J2xO6//+tjQOTPPfTkPNmg==
X-Received: by 2002:adf:e881:: with SMTP id d1-v6mr3117236wrm.43.1530129065871;
        Wed, 27 Jun 2018 12:51:05 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id m185-v6sm5840342wma.36.2018.06.27.12.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:51:05 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:51:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] proc: test /proc/self symlink
Message-ID: <20180627195103.GB18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are plans to change how /proc/self result is calculated,
for that a test is necessary.

Use direct system call because of this whole getpid caching story.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore |    1 
 tools/testing/selftests/proc/Makefile   |    2 +
 tools/testing/selftests/proc/proc.h     |    7 +++++
 tools/testing/selftests/proc/self.c     |   39 ++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -9,3 +9,4 @@
 /proc-uptime-001
 /proc-uptime-002
 /read
+/self
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,4 +1,5 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += fd-001-lookup
@@ -12,5 +13,6 @@ TEST_GEN_PROGS += proc-self-wchan
 TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
+TEST_GEN_PROGS += self
 
 include ../lib.mk
--- a/tools/testing/selftests/proc/proc.h
+++ b/tools/testing/selftests/proc/proc.h
@@ -6,6 +6,13 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+static inline pid_t sys_getpid(void)
+{
+	return syscall(SYS_getpid);
+}
 
 static inline bool streq(const char *s1, const char *s2)
 {
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/self.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+// Test that /proc/self gives correct TGID.
+#undef NDEBUG
+#include <assert.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "proc.h"
+
+int main(void)
+{
+	char buf1[64], buf2[64];
+	pid_t pid;
+	ssize_t rv;
+
+	pid = sys_getpid();
+	snprintf(buf1, sizeof(buf1), "%u", pid);
+
+	rv = readlink("/proc/self", buf2, sizeof(buf2));
+	assert(rv == strlen(buf1));
+	buf2[rv] = '\0';
+	assert(streq(buf1, buf2));
+
+	return 0;
+}
