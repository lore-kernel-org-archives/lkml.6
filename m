Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6FC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="VGGZN7mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfAQVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:04:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfAQVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:04:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so4976979pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvbXIMcbH2/R4T1SUidbudtoMRAWFJRmwFg/TDHuXmk=;
        b=VGGZN7mPjhJMFcmnVD0NlPoBpJH62wKwRTZElRozBsKge7MCsDoeMCZ3Y8vQ27F3CE
         YPJ6vfgDUVU2MmpL9i6kvlTbKhphsGF4tsEoxol+bLZdHNidnxKY6JiUFTVkfZOoH/Bi
         A0P54kfhx5IbRuLz4/EjKCotVGyctdVe8X1liELSTK1uFrfCj/hKWVrGFJV24Of6m2kQ
         qOXdR61FlvRoCBJhVvKZdl8dhIaCCyrWsI8E13D9Pis+Ugtzcs/ppzbJzw8xeoSik4Jl
         YmKOEAZuQLmIXka6fA0EFefEAAAtGDYsJM1fh36D1hxhlDc6olUb3/uUrNtLPMpu8ug4
         5IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvbXIMcbH2/R4T1SUidbudtoMRAWFJRmwFg/TDHuXmk=;
        b=nu8H5rjWmoOWT5h9PWWkB3TBkQkmVqy4vAzAxRWEdIrX3a9xmXiIcydYEqpJQMeE0s
         fH/kp4KmtgVaAICnE9XUtN5wn4Rw7HRe/Vgj0AUE2wGYLzYAMA4sDixBIW9XgTwh808d
         ecYm3SHLc2dLuy6FPlfS8Hq0jhXSIdbY0EUgkHAFQgS2qgU06mBWN54mLfTu7XG1TCsT
         Yug/oCCouElv/s5XhS3bGFdpo8oSDKt4MRbUON0YACK/+e/bMYtaJgYSLJNNM2Y+A6GZ
         62lfPQhAttBN4WWjwSE9zYP7KyGE09pVMBVSmbMuTzo2c43YEwbApbcvfKHSyPQNzD3L
         mCnQ==
X-Gm-Message-State: AJcUukdCqEhTevBFaFLml24F6wvMN6whiviJcMKI3qjHc4RkA0gfNhSU
        jYwo6c/BqBH/0tr60r5ZGC3sWQ==
X-Google-Smtp-Source: ALg8bN4n8vbyaC72R4ALnknVo2KliHsjwcPhNQGMZJDh3k6ioVSlYeockalCHJxw+3fShr1Y9Ys0kQ==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr15020529pgi.244.1547759053363;
        Thu, 17 Jan 2019 13:04:13 -0800 (PST)
Received: from localhost.localdomain ([122.164.30.252])
        by smtp.gmail.com with ESMTPSA id s2sm4916114pfa.167.2019.01.17.13.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:04:12 -0800 (PST)
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     mcgrof@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests: kmod: worked on errors which breaks the overall execution of the test script
Date:   Fri, 18 Jan 2019 02:32:58 +0530
Message-Id: <20190117210258.7871-1-jeffrin@rajagiritech.edu.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmod.sh script breaks because an array is passed as input
instead of a single element input.This patch takes elements
one at a time and passed as input to the condition statement
which in turn fixes the error.There was an issue which had
the need for passing a single digit to the condition statement
which is fixed using regular expression.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/kmod/kmod.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 0a76314b4414..49b273c3646e 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -526,9 +526,12 @@ function run_all_tests()
 		TEST_ID=${i%:*:*}
 		ENABLED=$(get_test_enabled $TEST_ID)
 		TEST_COUNT=$(get_test_count $TEST_ID)
-		if [[ $ENABLED -eq "1" ]]; then
-			test_case $TEST_ID $TEST_COUNT
-		fi
+		for j in $ENABLED ; do
+		         CHECK=${j#*:*:}
+			 if [[ $CHECK -eq "1" ]]; then
+			     test_case $TEST_ID $TEST_COUNT
+			 fi
+		done
 	done
 }
 
-- 
2.20.1

