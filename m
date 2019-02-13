Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ABDC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A04B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025547;
	bh=6nZuPPO5ytx0fTbdNX8Ap/TnKK41sWKsS1+Co7NdiwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dKKPIn6xVAopxf7IWm8Bs168X/e7o8rheHpoOSVoFY8xuX+ItVmaB8x/byn30Ygh7
	 foD3K9ZGxnhPeawBhvhD71AtUSRQtA3eC5yyJZywGsbkHS0B0ozQOedn0uLEKg1Gkn
	 H1ezpxSeCZDlW/rGOqhnWgu3zC13rQaWOKQIycsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbfBMCjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732480AbfBMCjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBD32175B;
        Wed, 13 Feb 2019 02:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025541;
        bh=6nZuPPO5ytx0fTbdNX8Ap/TnKK41sWKsS1+Co7NdiwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1z7/QDSc8hcYs/Pe10zn6qqyIW7lpItzwlHRBKp7Ds2e9lK63/pvh13RmqUDJvFE
         HX7KkpfdbDuuOXZm0a0X/RK6MWhHVV2i191/HoZi2DaufNRN2A5fa4REFgaISQPlzn
         S8SlSb8DjcdNoh7EWjGbPp7PkVWqrKRGJnUvstic=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 64/83] selftests: tc-testing: drop test on missing tunnel key id
Date:   Tue, 12 Feb 2019 21:36:42 -0500
Message-Id: <20190213023701.20286-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit e413615502a3324daba038f529932ba9a5248af0 ]

After merge of commit 80ef0f22ceda ("net/sched: act_tunnel_key: Allow
key-less tunnels"), act_tunnel_key does not reject anymore requests to
install 'set' rules where the key id is missing. Therefore, drop the
following TDC testcase:

 ba4e - Add tunnel_key set action with missing mandatory id parameter

because it's going to become a systematic fail as soon as userspace
iproute2 will start supporting key-less tunnels.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../tc-tests/actions/tunnel_key.json          | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
index 10b2d894e436..af5e99d27229 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
@@ -81,35 +81,6 @@
 	    ]
         ]
     },
-    {
-        "id": "ba4e",
-        "name": "Add tunnel_key set action with missing mandatory id parameter",
-        "category": [
-            "actions",
-            "tunnel_key"
-        ],
-        "setup": [
-            [
-                "$TC actions flush action tunnel_key",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC actions add action tunnel_key set src_ip 10.10.10.1 dst_ip 20.20.20.2",
-        "expExitCode": "255",
-        "verifyCmd": "$TC actions list action tunnel_key",
-        "matchPattern": "action order [0-9]+: tunnel_key set.*src_ip 10.10.10.1.*dst_ip 20.20.20.2",
-        "matchCount": "0",
-        "teardown": [
-	    [
-		"$TC actions flush action tunnel_key",
-		0,
-		1,
-		255
-	    ]
-        ]
-    },
     {
         "id": "a5e0",
         "name": "Add tunnel_key set action with invalid src_ip parameter",
-- 
2.19.1

