Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrC356QnzVU4w1P9v3lT06wIChnA+KpS1r5iAXd5h0PFEpXw6ZUKn04jXO3JrF+J18AiEAB
ARC-Seal: i=1; a=rsa-sha256; t=1524890302; cv=none;
        d=google.com; s=arc-20160816;
        b=ip9T3nA9fetnnFXvE5YE5ETsxWmOUu5RcP6kMDBhTup9mNLYbGP4psBOx52KT77v1o
         JoqPrPib76ja43tB+Ji9euvGLvrQ4kYUPxR8d+LYEgvoeH1Rri7oCQRjazOrSFeyQAAM
         UjysHPFXHR3TX4RaYaYQ69pCh+zUlPNdUyAmLT4f5aQjrYW33JyOfYwsEvzB4ZQS841e
         at22LstzT5LjyEQ1Y6Rx8X/tcxpETTwnMZMonXIWsCnKrS+lUJBtyMTBTmU15mvPQuMk
         +dXsSvTeRMsCGqSJG6vsKwfunFUmJ3tnJnQgjc9iV1lhxMu9Myv3ujcTkBuGdfBa4bqF
         hdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:dkim-signature:arc-authentication-results;
        bh=Zlrue7AO/szVMQVG0fHMWj9qa7QNgAbbJF76Eobw0jE=;
        b=rpP4/tlpN6J36f22Lbae0aNn6rOCw8ifYbxvmq4hEeMr9fqRhLSl1WJK1C8iUSxVy2
         YOUndkblGTVNw5RFViq8IjkzToyRAF5oiZghq+8zQAu+yXAfYG+5oHTOwk5JXzQeJe8T
         pPmbPodjTXrLK+NK+WG77X0SKUagNU8+2/SzyIIsv0V58mCN3bFj1ykhSntu9XyR1Yif
         4x5cgu89VCoTZ9XvtyxTnXdmC7D3uS/ntcagFWkcPYZjgKCWwz+M23ZgDa5jVsjU+QOt
         6aaSCfM9T1Q6Hus1CBkoK4Oqa+M6XcfpKrzRALVd+NC7slfk+f7+kdHbzwQbHjJjmn6U
         olMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=merlin.20170209 header.b=AWyio4TB;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=merlin.20170209 header.b=AWyio4TB;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeD1EiV (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 28 Apr 2018 00:38:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48524 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeD1EiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Apr 2018 00:38:20 -0400
To: linux-kselftest@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kselftests: fix grammar and non-ASCII space
Message-ID: <b1c47352-9389-0117-2a6b-ef552f6b82e5@infradead.org>
Date: Fri, 27 Apr 2018 21:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598963373734287318?=
X-GMAIL-MSGID: =?utf-8?q?1598963373734287318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

This is a small cleanup to kselftest.rst:

- Fix some language typos in the usage instructions.
- Change one non-ASCII space to an ASCII space.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/dev-tools/kselftest.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20180426.orig/Documentation/dev-tools/kselftest.rst
+++ linux-next-20180426/Documentation/dev-tools/kselftest.rst
@@ -9,7 +9,7 @@ and booting a kernel.
 
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
-to run full range of hot-plug tests. In default mode, hot-plug tests run
+to run the full range of hot-plug tests. In default mode, hot-plug tests run
 in safe mode with a limited scope. In limited mode, cpu-hotplug test is
 run on a single cpu as opposed to all hotplug capable cpus, and memory
 hotplug test is run on 2% of hotplug capable memory instead of 10%.
@@ -89,9 +89,9 @@ Note that some tests will require root p
 Install selftests
 =================
 
-You can use kselftest_install.sh tool installs selftests in default
-location which is tools/testing/selftests/kselftest or a user specified
-location.
+You can use the kselftest_install.sh tool to install selftests in the
+default location, which is tools/testing/selftests/kselftest, or in a
+user specified location.
 
 To install selftests in default location::
 
@@ -109,7 +109,7 @@ Running installed selftests
 Kselftest install as well as the Kselftest tarball provide a script
 named "run_kselftest.sh" to run the tests.
 
-You can simply do the following to run the installed Kselftests.Â Please
+You can simply do the following to run the installed Kselftests. Please
 note some tests will require root privileges::
 
    $ cd kselftest
@@ -139,7 +139,7 @@ Contributing new tests (details)
    default.
 
    TEST_CUSTOM_PROGS should be used by tests that require custom build
-   rule and prevent common build rule use.
+   rules and prevent common build rule use.
 
    TEST_PROGS are for test shell scripts. Please ensure shell script has
    its exec bit set. Otherwise, lib.mk run_tests will generate a warning.


