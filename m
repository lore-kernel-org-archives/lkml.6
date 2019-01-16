Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC6BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3E1206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KdJAJktt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfAPLaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:30:04 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35140 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfAPLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:30:02 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BA29610C075A;
        Wed, 16 Jan 2019 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547638202; bh=h5EcPxQhGPRWk+QH06niiAc6FjPoaGFv3PntjEfYPGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdJAJkttqZVxJ14Eti/JlPkspMTUYbBQtWkGjd6mXd9rnjTP26MMS0ydkBFM9pcqN
         fwdkOquAqJqepxPMcGA3EBO1Ya0E+XpYwjhwcYhf2xFdBLBv56XEVJkpkJYKnLeZBj
         YCiQsjxvcucXZhFkoZ+VzdC1wvi+ocN8SRqwX097CYnftaSFLWz5yAsVsPcolDbhR8
         UOopUb5BuINUpoRpllAqDbqpBriYlFmNSCOC9hhiKMW04Rhh/oodM4DLgnmgtdpJU+
         NFqSvnVE8FWCCikzY2XXmPTGgoxPofINeQuYIsdJ4THot0TrXqLrA/V2wvG3hDVdhj
         UiaulFpvNS6Iw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 09F7644DE;
        Wed, 16 Jan 2019 03:29:59 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] ARCv2: enable HAVE_EFFICIENT_UNALIGNED_ACCESS
Date:   Wed, 16 Jan 2019 14:29:51 +0300
Message-Id: <20190116112951.10641-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
References: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select HAVE_EFFICIENT_UNALIGNED_ACCESS for ARCv2 as we unconditionally
enable unaligned access in HW.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..20ba916c50a3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -117,6 +117,7 @@ config ISA_ARCOMPACT
 config ISA_ARCV2
 	bool "ARC ISA v2"
 	select ARC_TIMERS_64BIT
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
 	  ISA for the Next Generation ARC-HS cores
 
-- 
2.14.5

