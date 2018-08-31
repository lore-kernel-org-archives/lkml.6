Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB47C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F542083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkhJ5KfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F542083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIADNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50657 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so6535006wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXBMyXD1aa0/Sk9qlKdr/7a7haV6OfZc2Sz+IdypMV4=;
        b=jkhJ5KfXBxFnr/+ngpbWHqGUt8JCIqeaCNKUViz1LYB/Aclg8hueP2GbqNdHwppoqB
         lEPkjT86toV+hbz6H2hxNLSwd5LwdXvF4+BDSS8sQHOb2UOi96FaFK2DKJTfe8fo5odJ
         xSbNFI6lkmvUUzlVPAGuqLvQDWIGZV8b+/qPPJHziE7UBX9saH8vWHETWubi89XpaqiV
         NowTelUNE1XgDapRMmBoc/MiGb+uFDpSTU247I8m/mEla2gMYB+XZ5z+zUXksmQOyy6n
         YPaRv9u/SZN386Jhxgw/pw1+k5pOtkuvBCF7fbkQC6vf78qXR3wozxV0vLvI4Am0xrio
         BcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXBMyXD1aa0/Sk9qlKdr/7a7haV6OfZc2Sz+IdypMV4=;
        b=LMkJfRwuJlALAz0lU7xElbHDY5wclNMrL1mnACuXSBRSiBYWjz7hMKsgbp/g93Pj5L
         ru6MyHgFNGywnFIbYxNtIlinHNG0ecDiNSJQC/rhNPfcKGrKKJQv08iLe2SR/isRNOe0
         nd1ekog1/Za8ZSWkQLkJxsKsXEurBMybX5qEauEXeyagVnxWhTxIu1iTlSOaqv4faTrb
         thbUBfBdXnqgTjkre/NecLhQAQ04oP14RpNDL5JIaCGGFmTlRFPuXOsvN27eP4A5HECC
         /vDHEFjgjwG0sF6gcGOxh8AZcJ7onuDto6Icsr0FP5ArdWQ1Mb3UFPjmEEBuuJeoawb/
         wh8g==
X-Gm-Message-State: APzg51Bc4BalQqrby1PxpExt+E0BFkzxNdAcCOBfjJoEJ+Ak0Ytt+pqf
        X5tIv2pP5S+MRvPrzkOnoPUylC+91Z0=
X-Google-Smtp-Source: ANB0VdZE90ia379KaC7aNBg+e+Yn1e6VMsX39i5bleoFF7S90jCe9JXaqk+tVePqv+nF7LzO2JJt+Q==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr5900476wma.63.1535756602398;
        Fri, 31 Aug 2018 16:03:22 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/20] staging:rtl8192u: Rename LastSeg - Style
Date:   Sat,  1 Sep 2018 00:02:47 +0100
Message-Id: <20180831230250.16810-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'LastSeg' to 'last_seg', this change
clears the checkpatch issue with CamelCase naming.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 4d29b7427a0e..672cbfa688f7 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -162,7 +162,7 @@ struct tx_desc_819x_usb {
 	u8	offset;
 	u8	reserved0:3;
 	u8	cmd_init:1;
-	u8	LastSeg:1;
+	u8	last_seg:1;
 	u8	FirstSeg:1;
 	u8	LINIP:1;
 	u8	OWN:1;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b385c686370b..dfbba1177470 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1557,7 +1557,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	 */
 	/* DWORD 0 */
 	tx_desc->FirstSeg = 1;
-	tx_desc->LastSeg = 1;
+	tx_desc->last_seg = 1;
 	tx_desc->OWN = 1;
 
 	/* DWORD 2 */
-- 
2.18.0

