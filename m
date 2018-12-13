Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F47C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D158C20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675474;
	bh=Cl36LEeN6eZ4QFFRvBZtbBjhcClhwpstygWulRB/jw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gX8eooSeyPpr6rhNhNBlCsjHImF6L3SChXzpvdg3JEqMrgHqd7qTNvuOBDNLWVvKq
	 GzLTFx+GoGljlp5Zh1KMPl8xpVd7jsE5yHiWBGb/lp3yoc3geCXnhV6ACOqLCv91Rv
	 AvS7KqXq2RZbfQ54Z83B7M2j5Hj4/6KuJIIPNYB4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D158C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeLMEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbeLMEbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3841320879;
        Thu, 13 Dec 2018 04:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675468;
        bh=Cl36LEeN6eZ4QFFRvBZtbBjhcClhwpstygWulRB/jw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJ34LyPTAMfh3W/rfMkIk/2UivOmYLpZFVT35HCV0joSWruX2p8WQUyKNpkvKA5jB
         bOQR3zHkYC+xWQ8L9HA+5lfx5E8NsjtihWshSz8HqDtl/I8kfRXTN3ArK9z/Q2f/o/
         HeO+cy3oadaFTv80+uZHK3wByCexYkrLkeJoQyY8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/41] bpf: Fix verifier log string check for bad alignment.
Date:   Wed, 12 Dec 2018 23:30:22 -0500
Message-Id: <20181213043054.75891-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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

