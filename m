Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F662087A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcsDhaFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F662087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeJ3WYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbeJ3WYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:24:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0DA20838;
        Tue, 30 Oct 2018 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906235;
        bh=d27csBv/iPNe7vbmVaKl8zTzLykBWhrPLCce6rg06ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcsDhaFfwHeaK6mYg696e2HeKsceoJXMPrd7dJnWbFf+uzCLOBIaQ+3kDCkzOrotK
         BUkNqQXAR19XW+waGMtLQTrCh9hIeoib+fhy3yOcDMyuh8itUQYBwE9++3fJ9KqKJx
         dS5yK7lhHOnMA1dj36lzO45QLFOQTIUFyYZjy8Ys=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 05/13] sparc64: Make proc_id signed.
Date:   Tue, 30 Oct 2018 09:29:15 -0400
Message-Id: <20181030132923.218124-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132923.218124-1-sashal@kernel.org>
References: <20181030132923.218124-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit b3e1eb8e7ac9aaa283989496651d99267c4cad6c ]

So that when it is unset, ie. '-1', userspace can see it
properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/cpudata_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 5b0ed48e5b0c..aa2bf904b582 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -27,7 +27,7 @@ typedef struct {
 	unsigned short	sock_id;	/* physical package */
 	unsigned short	core_id;
 	unsigned short  max_cache_id;	/* groupings of highest shared cache */
-	unsigned short	proc_id;	/* strand (aka HW thread) id */
+	signed short	proc_id;	/* strand (aka HW thread) id */
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
-- 
2.17.1

