Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFCCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60421850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130351;
	bh=La9YGp/QgCNOuFjRs+qxNH8m7X/OuItqjOd+b8q6aew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwbeHQo32nsPDHx5jj2jN879LkgFwspxujisqVuwQSqdyLm3NDzFjbgomUqYWlNPS
	 IUyLONsivAMREpdJUR13Q2YFH4Iv+90FUT9bGoRz6PKWIaIbu/6WjdqRSmjgQIPNgU
	 227rhTARUo34G2OQ1qCRR4J4GExtvrtReynoGPfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfBYVc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfBYVc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4EF2184E;
        Mon, 25 Feb 2019 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130347;
        bh=La9YGp/QgCNOuFjRs+qxNH8m7X/OuItqjOd+b8q6aew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWDgTFtvJibO63sCOqOs/6KEEYZD5+r0gjnSuX1F7l65WeB5s9fjiYWINw72l90De
         rRGpdG77OZ5us7hQeEiXyb4cogmM3n+/eEzGjA08IcOKvie0diPa2lxyzOkdigII6a
         PuB/C51vHX28+6WP7f5fQrNfcPjPH8o2sDOU9iwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 091/183] selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh
Date:   Mon, 25 Feb 2019 22:11:04 +0100
Message-Id: <20190225195109.963448868@linuxfoundation.org>
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
index 74ece4f9fccee..d5e992f7c7dd5 100644
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



