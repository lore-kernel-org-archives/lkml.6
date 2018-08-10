Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885C223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5885C223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeHJQoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727869AbeHJQoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:44:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9260AEF3;
        Fri, 10 Aug 2018 14:14:27 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]
Date:   Fri, 10 Aug 2018 16:14:26 +0200
Message-Id: <20180810141426.8918-1-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The edac_mem_types[] array misses MEM_LRDDR4 entry, and it leads to
NULL dereference when accessed via sysfs or such.

Fixes: 1e8096bb2031 ("EDAC: Add LRDDR4 DRAM type")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/edac/edac_mc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3bb82e511eca..7d3edd713932 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -215,6 +215,7 @@ const char * const edac_mem_types[] = {
 	[MEM_LRDDR3]	= "Load-Reduced-DDR3-RAM",
 	[MEM_DDR4]	= "Unbuffered-DDR4",
 	[MEM_RDDR4]	= "Registered-DDR4",
+	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
-- 
2.18.0

