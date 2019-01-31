Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B12218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="xY12TOAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfAaSb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:31:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:31:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so1858955pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMAlePFlsyIeDePU5MTDM6JWGUjU4fjTlKjCeUhFr5U=;
        b=xY12TOAuvAoWdCARxSirtz2vX8BQ0fh7HqT9AGBl5Xk2GkhYAkiU2oE2QO4XxqT8/i
         VqjZVz59Bua0bQf2lgtFNjl+tQsy2m9+2YiCsc+SQfhOKqHBDuNbxqvQGzRVJboEvihe
         NBLZ+zYNzB+p4XtvJclZtwnRhhjSfN/DfWfz59HKLrsSnQR5T6agqlVmwml3aDkbb9Lk
         FiV2iOPJABU4syBbUtShgEox2B3d8nOjpF+ZtKXnsFHtYoX/t+bJZawgaZZ1PXTvKbTl
         x74hv1+d/hpsN2FUEUz9TWIXw3DE94uuyF+dUhaHxMrkVhRyfD5vB4mg31R2LuF9ZOYA
         j/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMAlePFlsyIeDePU5MTDM6JWGUjU4fjTlKjCeUhFr5U=;
        b=TdD8tlW1PTRJ+AC3/2GucN9G2V8IehNP9q0J5sW654qqP6Wa38QAl3j7u8niKDugXP
         MxJ376+/GlCPtkIR3J31r4ZHmeCiEpvJ9+hRqE9mGBUdd0n0IODVtV2cPaTnhhS71mqp
         NDJViVK9I2r5jd4sk+jlJzjbfduqcXRl47IqIrDQtCXJge3LuDCG379vo/SBLYcyfeR9
         /HJ5MWtco6iXWWG8SJHD5sVuVqc6tu7HfpudY0N9DvRTOpllCuRtpuKD1I/Li7y2VWS4
         MXrJOwtd10KCYIqyhF4TGR4jv7NZHAg4sk+1io9VehMRCykp7HvuKbOkHps8XKQYa0P4
         Ti9g==
X-Gm-Message-State: AHQUAuZHKcB2Iy4J/zgxjcVgMOKWYGl9VLQmlsOQ62bqbVEdtZ9tKA9E
        zicAX4EkRKuSgNOjk72xCIujpA==
X-Google-Smtp-Source: AHgI3IZ3zCC28PWd9Q0oz3mJVVjMre+9YCyG+nkPeRZ8MwxcVnHvRcD25RDvZbzAm/XUgPX4pi60Yg==
X-Received: by 2002:a63:96:: with SMTP id 144mr19558616pga.315.1548959486700;
        Thu, 31 Jan 2019 10:31:26 -0800 (PST)
Received: from localhost.localdomain ([122.164.226.184])
        by smtp.gmail.com with ESMTPSA id h19sm6685576pfn.114.2019.01.31.10.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:31:26 -0800 (PST)
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     mcgrof@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH v2] selftests: kmod: worked on errors which breaks the overall execution of the test script. i have manually edited for v2 of the patch by changing the date and also commit log.
Date:   Fri,  1 Feb 2019 00:01:09 +0530
Message-Id: <20190131183109.10919-1-jeffrin@rajagiritech.edu.in>
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
Distribution: Debian GNU/Linux buster/sid
Bash Version: 5.0.0(1)-release

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

