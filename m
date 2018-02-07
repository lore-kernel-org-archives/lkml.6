Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224oH1kJuB4YNBw8nIXPGtkhp6vpOT49ajCN93xNH1hYpEVq5/UEJXgxU1pxO2KVsd9g4/FI
ARC-Seal: i=1; a=rsa-sha256; t=1518024344; cv=none;
        d=google.com; s=arc-20160816;
        b=smT5AScsCvttjdthcIUfC8sbpLgW1ozwtn3rO8IdBnk61H0Hp7NtMERoMDzKPpKpBb
         t4ZkoifEW0E7Jir8+s3oRtjIjHNNK0TwteI+BLDK9eGdWLyZ6icNS00B2S4+Qmv1pKgP
         VXaTduKq69TKb9wLJ7NrzND9Yi+eiSbpbR0lyJDBCg2dxQebuekB3QKBxS8s89bjWHPg
         IMjRsMHWSzsCcNoP9j1OHmbvWkopSTN+iGBbSXj9gcNZ90QlMHsjnWmKM53LvuyEWAeq
         A45IhDj3TO0J+uqiGnYQKGAV+jw+JvanK63vyvcbfFUSdJuRJY3R75BP2Y3lgfaVizE9
         qksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kT9/Jegvppf0VuYHE1q2q5gv/xx5yG1zczAhDH2Jm6E=;
        b=bUdzDfxKBMNM8BaCr6UoRuh/Op61R60q+aaNEYBBJE5qmcT55vchwXTbQEvSjqh0Nk
         Tc6CB2NrbojmqolGl1uRoBS6OcPnizBIqHHJBiOvErwcX4KzBTGf+Y/XzVwV8j9yJ7aY
         8Dwf+mkO4xulrc8b/xAuWSKGpDyWsu8LjcC+ioagoDO9qPiOPHm20jq8ffbfjm0D0SyU
         HG0aaWXJB6rB8Uszg+4xHn2ihAb+s0WsOU8vrObqQd/GydW35v8v4a2YpHd0IcUCigWI
         kC3w3qU/QkvIV/VWxplIjf4Qnq08Jjsz8yomp7YI86zZ8dviocvDMOZzwIdXgIs/LEsn
         XZFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=EIF0uVPT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=EIF0uVPT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeBGRZT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Feb 2018 12:25:19 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44871 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbeBGRZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Feb 2018 12:25:18 -0500
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org (open list:FUTEX SUBSYSTEM)
Subject: [PATCH] selftests/futex: Fix line continuation in Makefile
Date: Wed,  7 Feb 2018 11:24:31 -0600
Message-Id: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1591763894080699218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Makefile lacks a couple of line continuation backslashes
in an `if' clause, which produces an error while make'ing:

  $ make
  make[1]: Entering directory `/[...]/linux/tools/testing/selftests/futex'
  /bin/sh: -c: line 5: syntax error: unexpected end of file
  make[1]: *** [all] Error 1
  make[1]: Leaving directory `/[...]/linux/tools/testing/selftests/futex'
  make: *** [all] Error 2

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/futex/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index cea4adc..a63e845 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -12,9 +12,9 @@ all:
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
-		if [ -e $$DIR/$(TEST_PROGS) ]; then
-			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/;
-		fi
+		if [ -e $$DIR/$(TEST_PROGS) ]; then \
+			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
+		fi \
 	done
 
 override define RUN_TESTS
-- 
2.7.4

