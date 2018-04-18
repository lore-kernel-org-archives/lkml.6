Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/hAA7DQrETUcGM+90hCkF/zmFLGHTJWkA4t1ng7BjTJo4Ix5hxjDePnVOtUXvTCHLVntLD
ARC-Seal: i=1; a=rsa-sha256; t=1524038007; cv=none;
        d=google.com; s=arc-20160816;
        b=G4O7uGwn0jk9cqD3wDIua7tx1K0gtSFg4as6RXnTypS5XqZss2vQm8pfOm8zgMMXTA
         qIDmIx+2zd4QN0WOZV+D7Fns9weGE/8SCuZL+Sml3JhHZGpgZ7IqvG4TpxbCQyjWqBHG
         xmRgijJWyj1fp0suhSDZEm1O0vmLJI2s/gR0kyiMWcYoQTMuYrsHflZKHtRujyjfjqv6
         5x1+/lLYxjZmoiVrld0cr2rQKCZ8a3I8l6aaIdxGOZsDA4fcfkiCL/mrzgx5DEIpqIZE
         2b87HN91YSkI6cgQslAgkiE+eIUHKUHd+xTF9LvNkVl6OJs+iNaX7ci+TCtLIuoTUW/7
         gGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Owc2DqjXxZdbUCbpvDTbd3s8ple96NdNMCJxSJ75/HA=;
        b=kf/8nvtvKoO9IOs/+xqVzep3i89PET1qPaHzBZfDzU0feIc8JVuAbQmrR/bdNQHjza
         5xkbTmC6y+zHFxzYc6v4PeejSi1/qEbGpu/tz9M5K6ZjU5rBetrPEDhlZzScSAalHOgQ
         gA1uOR4uT6QAfmufyrok3rqYwO5h4UpozJoQWmw1bErJmsYQVwaeYlRaOq+HA9ehlnZn
         JCIPc59UtfYyIcesxxZJOo5+TlwgWu01LpIHyL72Onnqy0NyHWTrYnjnS5anPDilbUur
         3T7LhzYbzxYn67EjDyL4SFJDMM1eNP9kAyyq7I2QyofBqBQJi1gdv4ZmSXKueEX5EQtD
         p7+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ABtPqI4x;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ABtPqI4x;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDRHxP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 18 Apr 2018 03:53:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41189 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeDRHxN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Apr 2018 03:53:13 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, christian.brauner@ubuntu.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests/filesystems: remove Makefile warning
Date: Wed, 18 Apr 2018 09:52:56 +0200
Message-Id: <20180418075256.300-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180418075256.300-1-anders.roxell@linaro.org>
References: <20180418075256.300-1-anders.roxell@linaro.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598069678446839048?=
X-GMAIL-MSGID: =?utf-8?q?1598069678446839048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When overriding the 'clean' target make throws up warnings:
Makefile:9: warning: overriding recipe for target 'clean'
../lib.mk:98: warning: ignoring old recipe for target 'clean'

In current code we change from TEST_PROGS to TEST_GEN_PROGS and that
does that we can remove the target 'clean' and 'all'.

Fixes: 10924bc64487 ("selftests: move dnotify_test from Documentation/filesystems")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/filesystems/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 427a401aae5c..a55ac3ac09ad 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := dnotify_test devpts_pts
+TEST_GEN_PROGS := dnotify_test devpts_pts
 CFLAGS += -I../../../../usr/include/
-all: $(TEST_PROGS)
 
 include ../lib.mk
-
-clean:
-	rm -fr $(TEST_PROGS)
-- 
2.11.0

