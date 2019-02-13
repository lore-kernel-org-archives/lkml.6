Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492A3C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6182190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026981;
	bh=+9j0unRSTknpAUW23EePJ0SS1U9GA7Ic3/VenbnWK+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LSYSgpxvxpXGO8Rpsg77eefC8IfUy8STKnX5wQ+W3phDXyKzetOn9YvN+os++LDUY
	 02O4e1O4+AUwPTVfcZdqWxkopy3yn2zKAJ7mGLZZMSizyy93djmfapYUoXZSYYkKNj
	 Pw8sPLtGytTjAAKH2wHYHH+wt7ifoZshyoqPP2Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfBMDC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbfBMCes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90253222CD;
        Wed, 13 Feb 2019 02:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025287;
        bh=+9j0unRSTknpAUW23EePJ0SS1U9GA7Ic3/VenbnWK+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EegwY3DpxcFc3K75U7i48j18bZPvRYDaHthKrManW1tev4ZYtSjKfNmpAyHgY1jni
         2PNsXicCaNg+GVtwY5s7hqW6ckfOIEPpelHg8uAztfUmT7dN3UErEOVd2onHr4Krdv
         NBYqHQNpn25bZWIufVi9BiBvM+Y9JRRM3s5xeNQk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 046/105] selftests: bpf: install files tcp_(server|client)*.py
Date:   Tue, 12 Feb 2019 21:32:37 -0500
Message-Id: <20190213023336.19019-46-sashal@kernel.org>
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

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit f98937c6bb73ae11717a15aec85c187d33ca5d34 ]

When test_tcpbpf_user runs it complains that it can't find files
tcp_server.py and tcp_client.py.

Rework so that tcp_server.py and tcp_client.py gets installed, added them
to the variable TEST_PROGS_EXTENDED.

Fixes: d6d4f60c3a09 ("bpf: add selftest for tcpbpf")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ecd79b7fb107..74ece4f9fcce 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,7 +53,9 @@ TEST_PROGS := test_kmod.sh \
 	test_flow_dissector.sh \
 	test_xdp_vlan.sh
 
-TEST_PROGS_EXTENDED := with_addr.sh
+TEST_PROGS_EXTENDED := with_addr.sh \
+	tcp_client.py \
+	tcp_server.py
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
-- 
2.19.1

