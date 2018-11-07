Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12045C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfMSevtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeKGTM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:12:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeKGTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:12:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so5184807pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zt+cAHGPGAk3FRcCwtw+OvlifyTE54P1ADmO0eZIEKQ=;
        b=PfMSevtAMS0fLAtSV/LojYIPQXAPpcTGkm7pdZx4ADB2H+M9wTxx7WOWs931lKaZSt
         YmwuvzO/MpfYtRgspvxemGGonJnHTIUY5M23VzLmu4AQzniE01W3UTQqkkEwS5WOHw7C
         NOoahiYeHxZcjqqWdF72aUzVeXqlSqMKhTlJyPRuvH9IAfG6ABpdSJ8iJljnTL72FPaA
         cA1Ue5LeUR0tqwRek0AkZhJTlD2ZZl4GPuDV+nCuwfGLKCSeCVsd3GD5XPSlN2l9wz9W
         ztBpEXQvARvUj04V51ZifDG+OtVt2ul9NDBp16nkhYHIwFSDdDy0tdtUGf7Uqgc+ugUe
         6cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zt+cAHGPGAk3FRcCwtw+OvlifyTE54P1ADmO0eZIEKQ=;
        b=NntoypFP1WI1WEJA6y38y7J0zGV2z8WASwWmxqVuzIJXvfmbX5kmBGfoS/M67qxwgP
         /iVzEii0hUpUfmK73moa4fFujsB40SnkChQRpaG09RZ7VzWmcU3MSev7TCjRHl+GvvPy
         ZQXXbQOy5AySsCb/KS7YOu8Zho8MN1t6v2/pXwtFYbPkHn93Af07w97jQM6BFJIXGhIl
         RU+l4Qj06uE3TSPAM97p44Ml7qVmiSmuWWFJQl7aWi/ROSGPrD6dIzt8tiBihYfaWRjE
         BZUiH9V/RQSyI1YRt749S4Wr6YMY95Tx4Vj7TyLogcgDuXZRhw4pOwkmxbO7P4ULGH9U
         9TvQ==
X-Gm-Message-State: AGRZ1gIRS/L+LDaaJgeH1AsH8Hlv0/AnhFnzPxJtkjOO/etdOLn6jfq8
        X2IBT45LSAS9TplRgGpD4hCWoIOsvCk=
X-Google-Smtp-Source: AJdET5cZRanTj6PmIYOliiEG82VRbjya9IwbbAbNSBteMKsyfYMOz14Z2SL8ewA/7Y6tfB8ICk5ydg==
X-Received: by 2002:a63:c746:: with SMTP id v6-v6mr1034262pgg.108.1541583800830;
        Wed, 07 Nov 2018 01:43:20 -0800 (PST)
Received: from SARKAR ([1.186.14.88])
        by smtp.gmail.com with ESMTPSA id v20-v6sm127868pfm.114.2018.11.07.01.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 01:43:20 -0800 (PST)
Date:   Wed, 7 Nov 2018 15:13:14 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     rohitsarkar5398@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: goldfish: Add SPDX license identifier.
Message-ID: <20181107094314.GA15179@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning by adding the SPDX license identifier.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/goldfish/goldfish_audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index 3a75df1d2a0a..d4520490cf6d 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/misc/goldfish_audio.c
  *
-- 
2.17.1

