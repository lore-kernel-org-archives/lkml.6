Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2578C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="trVUftln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2578C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeJYWsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbeJYWsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEEE2085B;
        Thu, 25 Oct 2018 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476910;
        bh=lAxHOwD8ZNhGAsPwXd5JcNnzb3emSJcN8RnTK/sIvms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trVUftlnhfmOJkSDXpoeNvFBUYlQNaPxBXRu1bhcgeNt6cgH9kJS75fw+1OwxiYrl
         ZzQStRqDNxd89iPeieesvQDGnaHA4KJszAPISSuyl/iB8IRVRWPDNmOqotFjeJ0tsL
         ZLoNm7WJK+feNgGPipv0rhwm+FqhKI0hWmML6eAQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jane Chu <jane.chu@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 30/98] arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5
Date:   Thu, 25 Oct 2018 10:13:15 -0400
Message-Id: <20181025141423.213774-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>

[ Upstream commit 7485af89a6fd48f7e6fab2505d2364d1817723e6 ]

SPARC M6-32 platform has (2^5) NUMA nodes, so need to bump up the
CONFIG_NODES_SHIFT to 5.

Orabug: 25577754

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Atish Patra <atish.patra@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8b4152f3a764..cef42d4be292 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -290,9 +290,13 @@ config NUMA
 	depends on SPARC64 && SMP
 
 config NODES_SHIFT
-	int
-	default "4"
+	int "Maximum NUMA Nodes (as a power of 2)"
+	range 4 5 if SPARC64
+	default "5"
 	depends on NEED_MULTIPLE_NODES
+	help
+	  Specify the maximum number of NUMA Nodes available on the target
+	  system.  Increases memory reserved to accommodate various tables.
 
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
-- 
2.17.1

