Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1203BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FE520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548965446;
	bh=mLIilOK83moF07lX6gQ5Ef9Vig+OfthoGbV1rxtW+JY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xNrONDSW0G7aqBmNUpqPZoZDhUtzoH6nnDBm5e3CtoPKwfpKHrVVmuJsa733mXiHs
	 7BoltTPs8qxbX+rLOfVxHTSl6eDcTAKFpqB0WnTWvOlOMkJ9TCE/evP3htNfSsaDsl
	 IvOLJcGe/o66c0FokGkycVJnIcbziC+n/CsCoFc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfAaUKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfAaUKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:10:41 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85BD20B1F;
        Thu, 31 Jan 2019 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548965441;
        bh=mLIilOK83moF07lX6gQ5Ef9Vig+OfthoGbV1rxtW+JY=;
        h=From:To:Cc:Subject:Date:From;
        b=xdyu9nZ1MnmtHXO1csKOn29NH6ZYUfvqxRbKTbZWehZaFg79k/nwpxPeUXsGZmhe+
         u1PzhA3jS39nis8G9SsrWFC8zr9wQDmcLHfwhiNyw58yZBZIpA2xvU7F3kXwbCFf4m
         ON5+aUuW9kse9o/W53qiFPNXvvquDFlsoa2mctHM=
From:   Shuah Khan <shuah@kernel.org>
To:     shuah@kernel.org, sean@mess.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ir: skip when lirc device doesn't exist.
Date:   Thu, 31 Jan 2019 13:10:39 -0700
Message-Id: <20190131201039.20602-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip instead of fail when lirc device doesn't exist.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 8cdf1b89ac9c..ff351bb7c163 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -76,7 +76,7 @@ int lirc_open(const char *rc)
 	}
 
 	if (!dent)
-		ksft_exit_fail_msg("cannot find lirc device for %s\n", rc);
+		ksft_exit_skip("cannot find lirc device for %s\n", rc);
 
 	closedir(d);
 
-- 
2.17.1

