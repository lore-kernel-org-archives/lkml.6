Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22726MgYHZE7PEC3CMXlMZRom5ONDNgYMuOyawLU2xwpzjOAWo4bQkkyFUZrfqWLl0vL3vgy
ARC-Seal: i=1; a=rsa-sha256; t=1519424001; cv=none;
        d=google.com; s=arc-20160816;
        b=vl5nWaHQ58B0PykNYOaPijXS3wOU/LIvYg095kn9+1MQZzpzCQ/UBoVmMGgny6HO5x
         lkylG+5XveeGslWvTKX1NwIHVtDidNHk2GC9ep7APa6PkC3PZsk78U0BzrZI8Z/J+Wl+
         dcfKPcDyR+RRdgXoDNyKdH0WVywooAvtPpmdc1WFcb2m9+ptgfjmxsIbYqHQc6ZEo/4f
         PywjJrvd9GzF9QZqNDItLxx4Q/QEite3FSYLhXNRAxWUrvh8p14kR0i6clSpVdtoUhXR
         orrlLD597l1WR7vAhyYTTnuwNKabe4pFtBJLwz6Eut9y386s3ywSQZA2DD+66HJRr/eB
         VzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=McgvGyjHAmA9lh/vstZfFvXGkgzzOy4YQoA1aTi9N+Q=;
        b=MWLhEAxJ5pI9tbS0BlHL6DsrTpnAyDtt8lNASjlJvyCIXEJ8THHY5K37Q4C4xHOM32
         iijmZrulDbNHJU6VxjJR6wtovIhkm6u3Xr7JWuiSbUCV/n5Rm+Iukd4cUSKZEVEAqlvZ
         LfZVo9IBpO/GrP46jIHhkw56gQslqYZPtas85J+7kmL5JYGYm+ccuVHYfjlPfrKlMsRs
         ZkFszXeRU0a8oI5GMwp/Zs2p1I20Ua2u6oOIXtpGGNfmTiKh1wqRp8mSP1eK1lyObo31
         TajzRqwJO1IdsoUB7+B5PMGxoLXmssXzLG214KKdIeKyL7F5Ezi2i2rtWXa3cbYEHgUp
         m9XA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBWWMO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 17:12:14 -0500
Received: from osg.samsung.com ([64.30.133.232]:47199 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeBWWMK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 17:12:10 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, dvhart@infradead.org, tbird20d@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] selftests: lib.mk set KSFT_TAP_LEVEL to prevent nested TAP headers
Date: Fri, 23 Feb 2018 15:11:37 -0700
Message-Id: <92e48a739971361073bcb49db549cdd5d13370fa.1519423340.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231541360905902?=
X-GMAIL-MSGID: =?utf-8?q?1593231541360905902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Set KSFT_TAP_LEVEL before running tests to prevent nested TAP header
printing from tests.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/lib.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7de482a0519d..195e9d4739a9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,6 +20,7 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
 define RUN_TESTS
+	@export KSFT_TAP_LEVEL=`echo 1`;
 	@test_num=`echo 0`;
 	@echo "TAP version 13";
 	@for TEST in $(1); do				\
-- 
2.14.1

