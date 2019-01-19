Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC00C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB62086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="SWu7fbN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfASAMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:12:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34686 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfASAMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so9111227qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYt/K9NYhTv2NeJAx/KG9lq59/XGrM4evbM+iin9jyc=;
        b=SWu7fbN20E/BcGEqPu8Q2vi3pnrfAXEX514qycWU22bHVsOQXeHs7NEei7f0I6ukNb
         mAUh63b9FudOND7r5AZJdcAjPajxLfKBs/1SPJzi0dYN9cxX5JihX6O1CWF60wQmpUcW
         bxOxWn1P4OA/ooAanw3WV/Nya2UjAPkn9uYa1PGMf8viHLrWyhbLnMaFtJpbI+u00bqZ
         WPukauGk0CINuSwma7vUrII6uJ1YakEDUakQamnfKN6xIZ7TPvgpE8tDGbXPPWKBbdc/
         P/BZnx1MwYLgEkhqNB+HEkivJ4svnU4q5Gn+qk23niZrZe1wPSZh0cMgsxb4QvUbZc6E
         6srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYt/K9NYhTv2NeJAx/KG9lq59/XGrM4evbM+iin9jyc=;
        b=iivLHUAZly/aZRLkxxBef2ptcl5o88a1UdHT3z6xpZHmU50W+LfTWogVP1TX31eA9M
         rbpJT1SWTcjBAo6zgkqYz/L2No0ec6BkoRaLcrcDgV0Q/WUn8MFfm8MKwzcXg0SQINBF
         fstAuZ2pt77dmMFjHg3Ov97ingPg/5pSTjN1xH0TeAlVA4tk+Xax8SLT2ySyjLLLUaQQ
         VwxBleOuuHlLhOB7PXpSwt/ovlf9AYnyeaekwJVY3KLuAhXs6mdNmhcnf6vsSXyPd5CP
         rHGaoqlVqzhYomDKwsieiX2pH87heYp1YOyHFLaDqlUKYq4n/AzAFHdZYtB35xU7tbAm
         1FmA==
X-Gm-Message-State: AJcUukePKDkxYg/b9j37KuS5C5uj5O0/ULu+rviPSQTkRyEACt8D0F0S
        Vc+iYRAyyYu8Z7yxnwFv1/2eLFELt8c=
X-Google-Smtp-Source: ALg8bN69hr9P8qlQphs5KANrd0pNvQIb1AIfQhhqsFRB3NIZ1kIWmIVgbWRD4jXUJJ7QEswBk4VB+g==
X-Received: by 2002:a37:8006:: with SMTP id b6mr16115382qkd.19.1547856767670;
        Fri, 18 Jan 2019 16:12:47 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:47 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 1/6] selftests: don't kill child immediately in get_metadata() test
Date:   Fri, 18 Jan 2019 17:12:12 -0700
Message-Id: <20190119001217.12660-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This this test forks a child, and then the parent waits for a write() to a
pipe signalling the child is ready to be attached to. If something in the
child ASSERTs before it does this write, the test will hang waiting for it.
Instead, let's EXPECT, so that execution continues until we do the write.
Any failure after that is fine and can ASSERT.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 496a9a8c773a..9aba1b904089 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2943,11 +2943,11 @@ TEST(get_metadata)
 		};
 
 		/* one with log, one without */
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
 				     SECCOMP_FILTER_FLAG_LOG, &prog));
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
 
-		ASSERT_EQ(0, close(pipefd[0]));
+		EXPECT_EQ(0, close(pipefd[0]));
 		ASSERT_EQ(1, write(pipefd[1], "1", 1));
 		ASSERT_EQ(0, close(pipefd[1]));
 
-- 
2.19.1

