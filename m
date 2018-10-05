Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEEFC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38062064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL84bocD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38062064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeJEX1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbeJEXNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A3D21479;
        Fri,  5 Oct 2018 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756070;
        bh=qvnfQ8cdMmHJ7gEq6TRlybVToPDxtF7fq9eErYBV4o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lL84bocDDiNkSeAJ84zbwJZFLk6F6qg5yYSIqcUEypitDcaWIsaozU1Ryf25sI5lp
         Vyuot9Ttr/DQAP/X2TjCn7cZJzOyC+w8Y1kUZGNxUwK/LoB4V9/G1YqJThV/4qPwvC
         IKxAU7EmB+Ph+LITGN6phYojngo7zlBPjsLinyMs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/48] selftests: kselftest: Remove outdated comment
Date:   Fri,  5 Oct 2018 12:13:41 -0400
Message-Id: <20181005161424.20521-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

[ Upstream commit c31d02d1290e1e82a08015199e408228e152991f ]

Commit 3c07aaef6598 ("selftests: kselftest: change KSFT_SKIP=4 instead of
KSFT_PASS") reverted commit 11867a77eb85 ("selftests: kselftest framework:
change skip exit code to 0") but missed removing the comment which that
commit added, so do that now.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/kselftest.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 15e6b75fc3a5..a3edb2c8e43d 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -19,7 +19,6 @@
 #define KSFT_FAIL  1
 #define KSFT_XFAIL 2
 #define KSFT_XPASS 3
-/* Treat skip as pass */
 #define KSFT_SKIP  4
 
 /* counters */
-- 
2.17.1

