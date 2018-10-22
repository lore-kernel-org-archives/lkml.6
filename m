Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A72C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206A020652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnwTpmoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206A020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeJVSmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbeJVSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58BD20658;
        Mon, 22 Oct 2018 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203612;
        bh=OJIA1E/aTmXj8bFED9597q1P+JQPsS9Mmmm6HsU6nRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnwTpmoNl92Xp8E2js0zlDXP8ZPkLxJWWxrMsxIeDXHeYYK60LnqHSx2GsJYjPSwd
         xqAmn1ux3TZDxqkJJmAcSYzM6FbQR3HnITBX9DCsW30b2otUT2Un/C65tSfAMGibb3
         MURIjrT5k7eGeAofIgDlJ8t8b8BP35PZA0Zw0HuA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 23/27] selftests: udpgso_bench.sh explicitly requires bash
Date:   Mon, 22 Oct 2018 06:19:20 -0400
Message-Id: <20181022101924.40531-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 12a2ea962c06efb30764c47b140d2ec9d3cd7cb0 ]

The udpgso_bench.sh script requires several bash-only features. This
may cause random failures if the default shell is not bash.
Address the above explicitly requiring bash as the script interpreter

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/udpgso_bench.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index 850767befa47..99e537ab5ad9 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Run a series of udpgso benchmarks
-- 
2.17.1

