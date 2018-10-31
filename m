Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29977C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1E92064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPWhmBcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeKAIHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbeKAIHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC56C2064C;
        Wed, 31 Oct 2018 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027225;
        bh=3JtbUwR8XOp8MBQdW7nl0+6wkKqNfq9/3CsuUtWuzvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPWhmBcUNGM3x6wIbj6ChPPvs+kVnYKTfp7VkOjxYINN1sFWFRi6ZfC3a67DuMPKT
         THcqYTnxuSVncO45rgGa2gnoADTYPh1X4Yy8Ioms58rEnKVv9MUnBFyEhpasabIv/W
         5Q5EkD9mgY6w2tttTPxZaTU2J8lR0kChJmRgAyyY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 091/146] of: Add missing exports of node name compare functions
Date:   Wed, 31 Oct 2018 19:04:46 -0400
Message-Id: <20181031230541.28822-91-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 173ee3962959a1985a109f81539a403b5cd07ae7 ]

Commit f42b0e18f2e5 ("of: add node name compare helper functions")
failed to add the module exports to of_node_name_eq() and
of_node_name_prefix(). Add them now.

Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 74eaedd5b860..70f5fd08891b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -67,6 +67,7 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
 
 	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
 }
+EXPORT_SYMBOL(of_node_name_eq);
 
 bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 {
@@ -75,6 +76,7 @@ bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 
 	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
 }
+EXPORT_SYMBOL(of_node_name_prefix);
 
 int of_n_addr_cells(struct device_node *np)
 {
-- 
2.17.1

