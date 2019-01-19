Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55AFC61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03E22086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Tj4U5JId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfASANA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:13:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfASAMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so17265164qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xYyUhHddUIYM/qVhIDdz28Cxrw9f+oJSbudf679vJA=;
        b=Tj4U5JIdYV5Zdhy33wHxsxGsLIp7ac1oDRlYsBWgr4RBgbAEwto+lVomOViEK+6+/d
         VwOzM7/ufX17prkUwcsJyXPf/SXLRIhufHIGk4MP+uqFW3AJjz1cAmsemVtOtW1RWouE
         Wy87UK0jk0dxmaYgbkKg66UCnkO4YF7gb5cHVYMCJpkh4p771WEqYkGJNp26Y8CJPABo
         F1SXiqwHZOeoAbQmubP+9TPCFnwYWbPpcJ7wBJCvNf1OwekYx1MBOEGHDe4Qzm61kYqH
         HIJWShQUaX5fbCE6ISy8WOvpE8ZrnWMcOWPjFoLiBTXHONdZWwbyHkXmDxPjEv1yZhvE
         39tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xYyUhHddUIYM/qVhIDdz28Cxrw9f+oJSbudf679vJA=;
        b=edjsOVOsm1vHzUYabCIN8ae8L26+ZDTU8sHiGaOmrgp8fEKHEZQEwlTOPrxDlBk4Gu
         F1ot15X782eCvudP5U3t9mJ2wLo+4Yjrx80/h3NYkJAQwXOgjykLZlu0zCdGbVXpwT1/
         yWgoRlIEge3v8+7LcItelSJpc41rL1t6u6zIBw6poaLOqEGpymLUN3YHk8vGG8x9CWx9
         CPGbm4B6mlFDQdW/xGPDJ8nrWE29NGZvCYudb2SF9evyCZFVW1PeOlBe5nJ0LbrC6QQ7
         Bwnz3iDMlc7b7KZZ1XJw2Q+s9RrniGPARwo+728/VoSVBaHKi8Ytv4NP2phpG2Ngd1l2
         Jvpw==
X-Gm-Message-State: AJcUukdGTwx41874nOnkSZbf5EfFv4S0xK06eIJWSytS/4N4G1GtcXsj
        LuoJDlXNC+EpIX9Zp+0uFjFlfg==
X-Google-Smtp-Source: ALg8bN79Iu3vj7HxoY6RJSVdIIaOABF51ItMX6RQiNJ+s5Ho4VEm7NAcTzM3xLtYdtQ/vT3p7fwxZA==
X-Received: by 2002:aed:2044:: with SMTP id 62mr18135646qta.11.1547856773475;
        Fri, 18 Jan 2019 16:12:53 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:52 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 5/6] selftests: set NO_NEW_PRIVS bit in seccomp user tests
Date:   Fri, 18 Jan 2019 17:12:16 -0700
Message-Id: <20190119001217.12660-6-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp() doesn't allow users who aren't root in their userns to attach
filters unless they have the nnp bit set, so let's set it so that these
tests can pass when run as an unprivileged user.

This idea stolen from the other seccomp tests, which use this trick :)

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ab6b6620f522..a4a7dce1a91b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3026,6 +3026,11 @@ TEST(user_notification_basic)
 		.filter = filter,
 	};
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
@@ -3107,6 +3112,11 @@ TEST(user_notification_kill_in_middle)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3154,6 +3164,11 @@ TEST(user_notification_signal)
 	struct seccomp_notif_resp resp = {};
 	char c;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
 
 	listener = user_trap_syscall(__NR_gettid,
@@ -3219,6 +3234,11 @@ TEST(user_notification_closed_listener)
 	long ret;
 	int status, listener;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3350,6 +3370,10 @@ TEST(user_notification_fault_recv)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ASSERT_EQ(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0), 0) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
-- 
2.19.1

