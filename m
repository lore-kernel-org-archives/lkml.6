Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1266C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C71321852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130381;
	bh=j5tMQHlCEmzyTDuPS29MnDpAk1P2MpaiXHaiVdLr4TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yrc57AGydS0Kd5CFFtoaqvl1MQV7oFv+XFK4O26DSqywIwvjvO0rMAQIotq1yqGxm
	 67UlzcgjWecXBsGesjGw+WL/jBdpIy1okC0aZtYGmWLnQk57kpP9yMDVTidUBoa3Hi
	 5MyfNQvJOq5ayb+vOUIFhqvCeKpa3H26s7P2sL54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbfBYVdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732576AbfBYVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542B121841;
        Mon, 25 Feb 2019 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130375;
        bh=j5tMQHlCEmzyTDuPS29MnDpAk1P2MpaiXHaiVdLr4TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZfRc2CXUmR4xo3VlDWtK77ioLj4+urdIN305mBV+1P+uo0o8kadSp2zfURCv+6k3
         3dXKZh+iqHbvVssZClV8d1KwKzj445DRJOETz1xxwti+jtJIVc9PMAKnrPVrk+Z1M4
         1PuThlbsC4GJ1ReLqT5EngY+AGXEoSQVqWC0UDZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 064/183] selftests: bpf: install files tcp_(server|client)*.py
Date:   Mon, 25 Feb 2019 22:10:37 +0100
Message-Id: <20190225195105.287275313@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ecd79b7fb1073..74ece4f9fccee 100644
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



