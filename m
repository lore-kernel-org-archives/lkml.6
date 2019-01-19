Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF87FC61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE792086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="SxMKlJgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfASANJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:13:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45923 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbfASAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so9035522qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RQC9GQYGMjS04/OX/HL+1Aa64AraxU97YP1oqqM470=;
        b=SxMKlJgEiEDCapbrsD7h9fDUHr4ZdgsvQWwYnG+8/dMDxLVeXt/X4Q15j8z+j5ZBej
         HUMUmy+NnO2Wrs+YHlso4gznpG3au2PA7hUNdSzR5RZhCLBb8RH79xedrLYYXr+Cp4WU
         4fz7A/x9XTP4HKWJLgjtfGMjxYuSIs/Hz9uPQwJmzXi5by5L5blp6twGBvBLecxQnBJn
         otOqvsd04zWcxfotypx/KKsItiUpWwpFgDXUvt/YE8tylaApmFVIXoW2aZu1JRCkyhG/
         vSQYe8gp86Kgh0Wu/7Llxk8X7YAfc1X96soH7Cmpduv783sH2yKBzqjot5Hck1wMwqFW
         e6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RQC9GQYGMjS04/OX/HL+1Aa64AraxU97YP1oqqM470=;
        b=hQaCVvOH4lVBop29hGAiskV73i1y0NU451CnNEQqoSNKb7VWZLuuIWnsoNZVP1U1O6
         QLKB5/v3UQkT4oHtCtiSV5Z8NOZPj+wJwxjDvhtJ0OKMvhDmLEzVolbzx6ArDTtPCeMQ
         JVTx39tV0zSq95i/jsMusnFnSzAug5WOeRVs4M/N5YBS1HCKjrOXRQbvkdhIUNCeeYPp
         vInYRCWbm/NAXoJ0GaoCGydASDILiXihFgCa5U3Va3f9Zr8/ygf1lbynn4ZFAytpyTiJ
         HZHeAtXA2/w3pz8MBXAnpNnsqfLRhNQ1+vJWdvOPMXH1zuVS+RXBUD+kGNocLAONYsAt
         Hc8A==
X-Gm-Message-State: AJcUukeuV2aG+LUc2Os5DtksmsR5quLjjhNlYgmDmwCTnRTxol90L7jc
        c54gSIC5sXbIEdKgb+Bef+LE5g==
X-Google-Smtp-Source: ALg8bN6jksQLcJVrddEiaIYydzlZ/pxAS0QyRVnrLKRgJB+XFO3L/3l2G2w+2Iy1HQ2OA523S/VvPw==
X-Received: by 2002:a37:b381:: with SMTP id c123mr16849070qkf.346.1547856774668;
        Fri, 18 Jan 2019 16:12:54 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:54 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 6/6] selftests: unshare userns in seccomp pidns testcases
Date:   Fri, 18 Jan 2019 17:12:17 -0700
Message-Id: <20190119001217.12660-7-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pid ns cannot be unshare()d as an unprivileged user without owning the
userns as well. Let's unshare the userns so that we can subsequently
unshare the pidns.

This also means that we don't need to set the no new privs bit as in the
other test cases, since we're unsharing the userns.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index a4a7dce1a91b..8f6e95773225 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3271,7 +3271,7 @@ TEST(user_notification_child_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
-	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
 
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3308,6 +3308,8 @@ TEST(user_notification_sibling_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
+
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
-- 
2.19.1

