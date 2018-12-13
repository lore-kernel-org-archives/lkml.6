Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72248C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBA520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675608;
	bh=aJ6UTfMqfn17j0KJGywYqmuL6Yb/GSoL3bZEf3Cn5JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fkmet2Q2vR5HRQ3d83l8NJU2yABkmzfNRtSi5CYEuD/ic0rfIyx/nnx1SBsiFSQiI
	 sI40iYoZvt3U84Fg7BMNR85fXR3U+/2zvtKOTDEo+JRtzhBfcxt14IpogAhM5Jd1Ps
	 /IR4trqY99v+j0OqM63/KVIi/94FfsjYm3/Uiu8Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBA520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeLMEd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbeLMEdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EFF20672;
        Thu, 13 Dec 2018 04:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675602;
        bh=aJ6UTfMqfn17j0KJGywYqmuL6Yb/GSoL3bZEf3Cn5JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsoxpyA050y08FsFUq+ySiis5v8yBDCHLkcwvGQ1tvubgDo/2R2aMsRoCkKUbP3ac
         /C/SrSf4/cbV7WFN8vXrpgQt3TqS2srkZOwk3VjW3G7IV9axhdEjVcQDtqMyeKmFyR
         WlmDN8IPiOaJVzuLuXKRIZMyqse/q901KHWg6u/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 13/23] ide: pmac: add of_node_put()
Date:   Wed, 12 Dec 2018 23:32:49 -0500
Message-Id: <20181213043259.76643-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit a51921c0db3fd26c4ed83dc0ec5d32988fa02aa5 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 96a345248224..0add5bb3cee8 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.19.1

