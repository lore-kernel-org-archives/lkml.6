Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpvkObgm0dLnRMZNAKJ/pPdij3ur4eE1yLbyDhh0vkp7d8a79wQlUMWAzRcuNj+VlImaqER
ARC-Seal: i=1; a=rsa-sha256; t=1525215408; cv=none;
        d=google.com; s=arc-20160816;
        b=fxDvBZRLj9gXt6aJlVlix/qy+mM59kmUS+Zg4c1hNV1v/PybpgRU9saa31DFRuBvMb
         jU/MYpGchtSwZiIlycQDjwaUmBTblx99B9y/n6bcZbYgjMtg2OPoqdExFf1ZL6Y7ZblQ
         yIb1fJP51OllKN8EJgbtC4fZKy8FMlXL2raN7GnnUxVFWv/z5AZPNltn8yUUBojw4FMd
         eGQ/Pp6JRoEmR6XShk7dfnLawMJuKvcUFvKCTUgjUKdsMD6UVpeaAgXRVsU5wclYyvR7
         aP0Zl1c4f1MnaVsroItFxP26VWlOh07DG4i0/Kl1E9eh5yQO8nyprnQe9gkJj6vcJ3Mq
         hVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=S6JU2uYVlH9lXfy3ame20JoeQhpDZDqbzz4d4DgId/c=;
        b=XwumfCgzwBCtz+LUjLhtpACBu5FRVilTBbG/Zecgr4tGNkcCus/mj0FEN+6ZPO6YTE
         6XE7Rn4grinAid7v0zaNHCRpsK6fTpARAui6fxki7/5W3CuBJfu/NjMssh0mZUONDeWZ
         eX3xZggrrhEBR3Uz7BIELUObuTSeoMMZSKMHvLvBkXYy0t35elzsSL+Se2A9NZ9He6/0
         XuzSaEiE/Mk37QcPG+pGZSgsq7ZgQnjeEgzEahBBcUFCqnjFJQgJjb6k2yGTVLBxnrBg
         BvBl1SclJyH0e4oVz4DzCA/viAU+lKA5EEhamt6bBe4c+C+RIqvsgYfJqSJ9SzJAcfmV
         IAnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeEAWzM (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:12 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38351 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:10 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] selftests: lib.mk: cleanup RUN_TESTS define and make it readable
Date: Tue,  1 May 2018 16:54:33 -0600
Message-Id: <00bbd3e056ada1aeebc3cd108dcb5c780ae2f76e.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304271629775537?=
X-GMAIL-MSGID: =?utf-8?q?1599304271629775537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Refine RUN_TESTS define's output block for summary and non-summary code
to remove duplicate code and make it readable.

cd `dirname $$TEST` > /dev/null; and cd - > /dev/null; are moved
to common code block and indentation fixed.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index c1b1a4dc6a96..1d2b48f2d481 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -32,11 +32,13 @@ define RUN_TESTS
 			echo "selftests: Warning: file $$BASENAME_TEST is not executable, correct this.";\
 			echo "not ok 1..$$test_num selftests: $$BASENAME_TEST [FAIL]"; \
 		else					\
-		if [ "X$(summary)" != "X" ]; then		\
-				cd `dirname $$TEST` > /dev/null; (./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]"; cd - > /dev/null;\
+			cd `dirname $$TEST` > /dev/null; \
+			if [ "X$(summary)" != "X" ]; then	\
+				(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";		\
 			else				\
-				cd `dirname $$TEST` > /dev/null; (./$$BASENAME_TEST && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]"; cd - > /dev/null;\
+				(./$$BASENAME_TEST && echo "ok 1..$$test_num selftests: $$BASENAME_TEST [PASS]") || echo "not ok 1..$$test_num selftests:  $$BASENAME_TEST [FAIL]";					\
 			fi;				\
+			cd - > /dev/null;		\
 		fi;					\
 	done;
 endef
-- 
2.14.1

