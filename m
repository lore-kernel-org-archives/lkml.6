Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47DC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8902148D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGEJ2VM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8902148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeJEXOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeJEXN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEFF208E7;
        Fri,  5 Oct 2018 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756077;
        bh=2ijBGWYGoC8VzMkaFc8AwRwUrSeoEpUeEKJOespls2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGEJ2VM6tXYQxcBl81dqdaY5iDL1mlzlvK5VN9zGnSC2J0Dtc7JrJ/vLyEiyHswjg
         6R+9rrc50mL7R7OZa9D4KvIaIJwiBycXISz9V2bMeYg04337rhtN/rWpQZsd39G6Ys
         7f3n2Z+9kbZbsdWVplwryN2CIH2oLdseeYWfBLuQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lei Yang <Lei.Yang@windriver.com>, Shuah Khan <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/48] selftests: memory-hotplug: add required configs
Date:   Fri,  5 Oct 2018 12:13:48 -0400
Message-Id: <20181005161424.20521-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei Yang <Lei.Yang@windriver.com>

[ Upstream commit 4d85af102a66ee6aeefa596f273169e77fb2b48e ]

add CONFIG_MEMORY_HOTREMOVE=y in config
without this config, /sys/devices/system/memory/memory*/removable
always return 0, I endup getting an early skip during test

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/memory-hotplug/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memory-hotplug/config b/tools/testing/selftests/memory-hotplug/config
index 2fde30191a47..a7e8cd5bb265 100644
--- a/tools/testing/selftests/memory-hotplug/config
+++ b/tools/testing/selftests/memory-hotplug/config
@@ -2,3 +2,4 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_NOTIFIER_ERROR_INJECTION=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
+CONFIG_MEMORY_HOTREMOVE=y
-- 
2.17.1

