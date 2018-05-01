Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrlGlRhcVIsxdrxC0RZIroFSFTIhr8n8snS1zkuXnpZIz9NgegLVKyPeZ6uyFB6fw/+R7co
ARC-Seal: i=1; a=rsa-sha256; t=1525215362; cv=none;
        d=google.com; s=arc-20160816;
        b=hCyC9vqH3lAEVAxJ7B8oOiBucCD6opOGP/ozad/SXcNB5PkRskUPNhxKHL1/up9ntD
         GsOEunKUjmXizZ61irw0kloiXWy897mvhnv9zhRvArGX29fW+SPu9qUu/QWs8wjDy+8/
         jCqX0tqkEawGyYP92EP4bLF14uCqsEdsP+teVsXYt27KpW9WgfJ/2OBKibvda40p7RWn
         Pt7yWT+omHKTJoLGabRkAI4m36REKacngfOr9bUtt7rf5zKt/S5qRn9+A2zBxlHYqFK9
         Z9BF28ddeI7nXd33qsOIh3Pbal2tohjZmi2K3VgW+qutNTnO4JPC9IewyJjqoYZ+HQT5
         SalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/owHvoNVkGzEOknIkLysj7b3JpzEqexscUoGWh7HW+M=;
        b=GgS+wpL4pO4kPu0wSUemvzaLC6eCygtRjkrJ0Njj5LJ7SyKVxuO5fhCs/rnGi/sKZv
         r7q2CqkbbCxFY4b4DdhxwGmVFCoeWKG/AjdhFsSUNXmy4P2JeguEfyyhVOrKUtNtlDbu
         NO4Cyv5bq/RzSm9Zmhmt/4nYpg3DSHP5UCZYOckYZFEaccEhYkTQLZ+KmrkovI1ewvn/
         Wr+dgwlw8CaafXGcpPRCb0XpvazAoMYm9q6IjwBHCMOyqGhw+TCQ9j+dr8x8z2xBL398
         Bn825KecC0ARGMR7TJTK6d9WDSCMyz4S0m7DWA0A7RLWw6Bt3f358/1K2t3EJIAzw+nI
         8yvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbeEAWzu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:50 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38415 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeEAWzm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:42 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests: kselftest: change KSFT_SKIP=4 instead of KSFT_PASS
Date: Tue,  1 May 2018 16:54:39 -0600
Message-Id: <16ce561ed5b34d1066d2e9de747ccdf0550078e7.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
In-Reply-To: <cover.1525212671.git.shuah@kernel.org>
References: <cover.1525212671.git.shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304223746888837?=
X-GMAIL-MSGID: =?utf-8?q?1599304223746888837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KSFT_SKIP points to KSFT_PASS resulting in reporting skipped tests as
Passed, when test programs exit with KSFT_SKIP or call ksft_exit_skip().
If tests are skipped because of unmet dependencies and/or unsupported
configuration, reporting them as passed leads to too many false positives.

Fix it to return a skip code of 4 to clearly differentiate the skipped
tests.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 1b9d8ecdebce..15e6b75fc3a5 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -20,7 +20,7 @@
 #define KSFT_XFAIL 2
 #define KSFT_XPASS 3
 /* Treat skip as pass */
-#define KSFT_SKIP  KSFT_PASS
+#define KSFT_SKIP  4
 
 /* counters */
 struct ksft_count {
-- 
2.14.1

