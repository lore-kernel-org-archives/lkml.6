Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A237B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxycN4L1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A237B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeJVSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:05 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B41B2089C;
        Mon, 22 Oct 2018 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203610;
        bh=hktN2G7Ny9mHhcfykBD5nH0RNCWE9uanWAg0xOW0XIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxycN4L1jkUPUkRrpNdcl68sCE3svHY8dycob/0HFL9uBvge7qdw2B1ZpXUBp8qya
         Ce614X+xTPywUK+acdU7Jevgr9TeP3nipUzItLQ6yyg5HDHVSrM0mU4WTWN2xOnEF7
         ZYYTgUsNyxjYNcoSjNz7Rkh7gd3lBGZIQzGSwjt4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 22/27] selftests: rtnetlink.sh explicitly requires bash.
Date:   Mon, 22 Oct 2018 06:19:19 -0400
Message-Id: <20181022101924.40531-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 3c718e677c2b35b449992adc36ecce883c467e98 ]

the script rtnetlink.sh requires a bash-only features (sleep with sub-second
precision). This may cause random test failure if the default shell is not
bash.
Address the above explicitly requiring bash as the script interpreter.

Fixes: 33b01b7b4f19 ("selftests: add rtnetlink test script")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 0d7a44fa30af..8e509cbcb209 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # This test is for checking rtnetlink callpaths, and get as much coverage as possible.
 #
-- 
2.17.1

