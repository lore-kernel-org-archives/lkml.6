Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797E72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676660;
	bh=DNOaZsm/IoD1Hx7ejyRaPHyVmAHuQioGBoKSLV82mHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ED6O4v9kI3FvX926MOF9IlCekhcelq6eH4zaBnZhykG3Wp+uWfLYF/RajezAQWnAZ
	 I/ax+ddTakuxH6TMczVFkOdbu/bVB/1UrBrQR7M9+YG5WRoigwiVta5xeaLOaVvUAG
	 zp6DZJx1WopUhU/5fNVgzZJvpjbuTSWuFItLgmiE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797E72080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeLMEu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbeLME3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D876820882;
        Thu, 13 Dec 2018 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675356;
        bh=DNOaZsm/IoD1Hx7ejyRaPHyVmAHuQioGBoKSLV82mHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mt+9J9M9z/oQLwZP9rRbqluj5V4rxMHtahIdDOaYzu4qU8P+IALf1oPcMg2alr4hT
         nmQSrPqhLWNqv91aqz2C+gdm5h5mWuKMfM7B1uRTxHWQMkyMHN7JSqb7n78fFaqi3r
         tLV+bN/D8ze9zer+3B2Nsod3WioMKgDaGSsKqSa0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/73] bpf: Fix verifier log string check for bad alignment.
Date:   Wed, 12 Dec 2018 23:27:48 -0500
Message-Id: <20181213042838.75160-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

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
index 67c412d19c09..d80c36465c1c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -12746,7 +12746,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	reject_from_alignment = fd_prog < 0 &&
 				(test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS) &&
-				strstr(bpf_vlog, "Unknown alignment.");
+				strstr(bpf_vlog, "misaligned");
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	if (reject_from_alignment) {
 		printf("FAIL\nFailed due to alignment despite having efficient unaligned access: '%s'!\n",
-- 
2.19.1

