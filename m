Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225/0tjTyjI5gVf0WrWywVJkeCd0nESEd8Lq4NX9UtJrGzZ/92+Yrtv+4GDbbAy9W82Fgy2g
ARC-Seal: i=1; a=rsa-sha256; t=1519424000; cv=none;
        d=google.com; s=arc-20160816;
        b=0+uTC3yDlURa5nNtJtj4Qx/7A6Z/hg7t4emxrjdqtCRdxO7q0s2Y2zTO1Obhs0bHee
         I7n5Zb/K2+d8bcT0VsNNl3B5gQgeMwGS2RDnlq6lAT6RXI5cWi85YIZixdB45QEXgphn
         o452p6xC7IzyJ/Z97aODFU39nhfIORaG3bWSdlDREWbKT70nZCjPWS+Gg+dtMLtGu3ML
         WNycgh50ETsUcTHiuhWDdsCFvmEFdWcjMqs5FrN2iOdGWFndnG/kJmZ4mvLLjkOKN9K8
         jowZ/3muRsR2xylKKLbKeOgGi1bwzbtO1U2St1UJh5PhQMSKOlO/PPVFRwczWXgCfxLx
         JrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=j8SLhrkaVetrs4xp2mo9fKBv4hvx1rLUNbQLA7RfeXc=;
        b=sdBgooL2i7bwBYxRCJaSe4TOifDmZKYCgXL1W63B9hZUUL8nl0+VN38mlv6gq6gNp+
         0ErWRWeccmzEq5ubuEUJZVjE1IpZyzksqUicvnskCcYTYH2vHBN81fH3CUUsLB6gichZ
         NpBDjgPyBAeUSH4Jr+uSLsaxTjAHjEk6xUIqarlVsZHJTF8eEsgWjuTNAidh51YzaKaD
         AvMEuNdmTJwkCT2YlXxW5y0eRpEdV8AZYW4pwViWItcGHrHDlNOoEmhdmUZeyZS+tcbU
         N84KcY8tMgffM4zxEBB304Z+o76ZlQ8uq1ZnxntYA+OMfC9lqtnVqY0F4B2fCi2UItBw
         wgMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBWWMO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 17:12:14 -0500
Received: from osg.samsung.com ([64.30.133.232]:55252 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752127AbeBWWML (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 17:12:11 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, dvhart@infradead.org, tbird20d@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] selftests: futex Makefile add top level TAP header echo to RUN_TESTS
Date: Fri, 23 Feb 2018 15:11:40 -0700
Message-Id: <bec2e6c01cbf3b2f6dc49e022a2a7543fc7f3182.1519423341.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231540843660776?=
X-GMAIL-MSGID: =?utf-8?q?1593231540843660776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add top level TAP header echo, testname and separator line to make
the output consistent with the common run_tests target.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/futex/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index cea4adcd42b8..3e9a9d7b4de1 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -18,6 +18,9 @@ all:
 	done
 
 override define RUN_TESTS
+	@echo "TAP version 13";
+	@echo "selftests: futex";
+	@echo "========================================";
 	@cd $(OUTPUT); ./run.sh
 endef
 
-- 
2.14.1

