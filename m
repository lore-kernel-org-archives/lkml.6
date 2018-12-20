Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE63FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298637;
	bh=utvaQVECUxct64VzgGTM3HD1SQ4ii7aStnZo+ZVBgfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hfzq+Bsza/U3xVIRTITajrA0LB9kWFo19HWOX9w5NWDQlUPyRWa/jTQ7720wugFFd
	 ABHvK+M6846KaYAnUnB4XzrbGUmD+lVaIFrSAjMnisz1VfY5e/PMLi7QCaRcrxsSQJ
	 iOK+uYu4ntOod+LAysZqQe7yGFEgKiG8s2/eEnLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbeLTJ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732233AbeLTJ1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:27:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E39A20656;
        Thu, 20 Dec 2018 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298025;
        bh=utvaQVECUxct64VzgGTM3HD1SQ4ii7aStnZo+ZVBgfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCTcP0tAnkiYA+6k/WVJ030AUzteDG1kd4u70Hp+ZBjGrS9elZ2TlRinlGGXNELFW
         nAfAbpdyam2fSAYKV0PfOUx65n0ibzM1oM56bXnnYrJHILDIz/Zs0dhQVuzjv1Lpvl
         1Jpp93yW431708rbI5JX3R2euZVaKlmqebn+1oxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 44/72] bpf: Fix verifier log string check for bad alignment.
Date:   Thu, 20 Dec 2018 10:18:43 +0100
Message-Id: <20181220085924.084258036@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c01ac66b38660f2b507ccd0b75d28e3002d56fbb ]

The message got changed a lot time ago.

This was responsible for 36 test case failures on sparc64.

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 041dbbb30ff0..a0591d06c61b 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -8070,7 +8070,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	reject_from_alignment = fd_prog < 0 &&
 				(test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS) &&
-				strstr(bpf_vlog, "Unknown alignment.");
+				strstr(bpf_vlog, "misaligned");
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	if (reject_from_alignment) {
 		printf("FAIL\nFailed due to alignment despite having efficient unaligned access: '%s'!\n",
-- 
2.19.1



