Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D99C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E729E2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026840;
	bh=CJ46lVxIpsGgmKGMKLd8qu5tHuajzU09cQlDnxEV5k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vr+lGEu1uA5EcOvoStm/cxYeD3qJ+ERflaaQ4vnCAkErTrN0eMidpzde9Uj6q9gDX
	 DDogO/7tMSCkHP7HwVuD48UKUBlU5UKrTe8M1qRIA/7GgmV39oC0Zwf15eI5s+Uip9
	 nWfDKeStGD5qz5SE6ZOXlJEyX3DG6wGfF+Z7uIyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbfBMDAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbfBMCfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126B1222C7;
        Wed, 13 Feb 2019 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025329;
        bh=CJ46lVxIpsGgmKGMKLd8qu5tHuajzU09cQlDnxEV5k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2Yjwzz6KvN1qDT/3IjfBGlbauQDaQN6R6mvxRTloyn8zuMQn7qz7oJVgBK9keft/
         Bffb2cojDqOwpm67JwE83z/tmnU7/qTZu6ilGZ9OjgPtQ33rMNxWF5hqLDbsG6EHCS
         FP6fYSMUmV2C5ohWCmVi0266GDuGsG6tf0WG0A8w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 073/105] selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh
Date:   Tue, 12 Feb 2019 21:33:04 -0500
Message-Id: <20190213023336.19019-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 1be72f29bfb98be27a95309f18b4ab5249967b59 ]

test_flow_dissector.sh depends on both with_addr.sh and with_tunnels.sh
However, we install only with_addr.sh.

Add with_tunnels.sh to TEST_PROGS_EXTENDED to make sure it gets
installed as well.

Tested with: make TARGETS=bpf install INSTALL_PATH=$PWD/x

Fixes: ef4ab8447aa26 ("selftests: bpf: install script with_addr.sh")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 74ece4f9fcce..d5e992f7c7dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -54,6 +54,7 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_vlan.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
+	with_tunnels.sh \
 	tcp_client.py \
 	tcp_server.py
 
-- 
2.19.1

