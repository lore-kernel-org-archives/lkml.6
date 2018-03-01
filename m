Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs05K269kKqfWlsZUKkNWnTHxjh4zZqg/TyPlM5uzVbGdqTQWior15Sre249ExRiTD7yWLN
ARC-Seal: i=1; a=rsa-sha256; t=1519935572; cv=none;
        d=google.com; s=arc-20160816;
        b=UXSSmswbI+1wvR1D1YgYQ1hmbUU/lijdwb0s+TgBx1a5dkwYmmanf83i1WPJXM1O8V
         yWZ4kl9HIdwiKV65M12hiU3hSnhAvOrGwY8Z1v7E9JbuKdDuwMA0FuBN50VlWb+tftNU
         0fKXW2WqUdDca4to0+nUwczyfUn2Jw2u20Rs3LEfD8hWMpJF2a6V059Ixyrn3tW6YSvw
         mHXTa0kGykXsz9XiWBacgkucGJioaBPuRniNvm3WC9Di3LiZypVIptF4TbvJo/B2pTkF
         QVau7mNZn3tLNIQU85NzIgGGdCO3bBc4BOrsfesqDSIUAXhVtJvBX4sjz5AjyJQdKm7d
         7VKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b4JI1WABLRIJ7ZgSaqjPOlsI+qm645GJFQHSA2D9F3U=;
        b=ecv9FbAiMeKnjmz12OgYePLBfCddbg9DunYvPCM/hMvH9B7na1+UQtA3fPQCIaWBHZ
         DqG3Ixxz9mWjB3q9+Y0qBpzHmlWKRcG/j/2fstG8/Lz7g5W6QUqf7S5iUWJjb/AktqSh
         5HaVvwPUBlSQZYm63aMpJwOpJfsPO9vz2rvC+Tuv3fd0xtYd/aZPxpls8ju1LSJaVjZG
         o2rYYCpJheB3AEuD980ce2bvs6RDi5ERceMbDEHZMRmgsfnshS7wDhuDZ6c39ZpyudZ/
         jd5KFxXmLf+SCA3z0kV7b5uOvId1UvlOhikkPU5U+ZlrNKth5MuoLw8Ryq1DcWYqAZGp
         oVsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161496AbeCAUTc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 1 Mar 2018 15:19:32 -0500
Received: from osg.samsung.com ([64.30.133.232]:57047 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161487AbeCAUTb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Mar 2018 15:19:31 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, dvhart@infradead.org, tbird20d@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests: futex Makefile add top level TAP header echo to RUN_TESTS
Date: Thu,  1 Mar 2018 13:19:07 -0700
Message-Id: <20180301201907.17573-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767962911316222?=
X-GMAIL-MSGID: =?utf-8?q?1593767962911316222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add top level TAP header echo, testname and separator line to make
the output consistent with the common run_tests target.

This change prevents nested TAP13 headers output from individual tests.
Nested TAP13 headers could cause problems for some parsers.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
Changes since v1:
- Add export KSFT_TAP_LEVEL to fix nested TAP header problem
  for "make -C" usecase
- Update commit log with details on nested TAP headers.

 tools/testing/selftests/futex/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index cea4adcd42b8..3006febb59fe 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -18,6 +18,10 @@ all:
 	done
 
 override define RUN_TESTS
+	@export KSFT_TAP_LEVEL=`echo 1`;
+	@echo "TAP version 13";
+	@echo "selftests: futex";
+	@echo "========================================";
 	@cd $(OUTPUT); ./run.sh
 endef
 
-- 
2.14.1

