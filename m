Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69247C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE97217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVgBoxeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBEPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:06:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37137 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfBEPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:06:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so1499633pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=anE2iosT8yhFaYwaO9x+RCZ58uUyN6R+cv7VgMdeUEE=;
        b=jVgBoxeW0gac10Lq0b/WIjJn75joFY0F42l3CdjR9xbjj3qKTVn5OnZyIRQZpQLcWp
         q6qoEIojEHOSdTB4WWYnqeEZHuzZVyR1FePW//VBrhl0RbYTP9+ECqa3bOC0UrQau3cH
         RdIA3+odnzR7eIyzR3wqXt3za9H70E5Pfwuo7PswikMQ/pOfPjfmbMx7sJML/ovWeHdT
         PfTugaHLV5YYovkJwwfiVZ0b41qKoEyu4FjdVj5GBF3RTkLP00KJIHN7HMtF/PxCyYzV
         vZHlM1KteONWj42Z7JAYfrvTHpZYzYXwhiQ32qiJpGVY6qXRD/n5k4k/4YrAsZ0slIE4
         BgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=anE2iosT8yhFaYwaO9x+RCZ58uUyN6R+cv7VgMdeUEE=;
        b=sOZKbr7xb3rg6WD3eY9vBdzaEIgsLvco74JpEWudflWMkGz950Tpovhro2T1Pk+KS2
         mOi+NTRsMgpHn3p0ulyeHf42XbJkc+n+jdl/o4YiHJt4D3oBR26Gt3mxiUjEwTA7LQxQ
         91f+V5xnsnVEAi7vRxkVsAG01/HY45P7sAV/3eUyxICgm3cztG707o9T3kf1S5wPMFwx
         EZL+H8IE4Sw0ek8p9gTC/xJ+VwP6uK3hbuUzbK6VeOLyL+++SyvD0DzU54MiGpyTXcfn
         d139fahjgkSd8oGlHTyY1u/5m2ipk2+R9riqcaFbtAz9NG2Ymh54AyouIEBeUYz7XUul
         p0fw==
X-Gm-Message-State: AHQUAuY8iDwxShhx7Et0vNDHmUc20LU4g5gfWZpQWGpE5JGXwzYD14ye
        b+VQB1om2CHwOxPPow3RNRk=
X-Google-Smtp-Source: AHgI3IbmMUHJiW8ZK/Ype6zI0lmWjM/kdmnZNtVHTyuSNsqIAetzDvHUlYGX6OJbpiedIV1j7dL9SA==
X-Received: by 2002:a63:da18:: with SMTP id c24mr4963901pgh.318.1549379191586;
        Tue, 05 Feb 2019 07:06:31 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id q9sm5820469pgn.0.2019.02.05.07.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:06:30 -0800 (PST)
Date:   Tue, 5 Feb 2019 20:36:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190205150620.GA17522@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the style for SPDX license Identifier in mac.h
by using "/* */" in place of "//" as per Linux kernel licensing rules.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/vt6656/mac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index 94e700fcd0b6..75166020f7c6 100644
--- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
-- 
2.17.1

