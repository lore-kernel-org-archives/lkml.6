Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CAAC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B7F21746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxwziGWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B7F21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHRVle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:41:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36949 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:41:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so10130884wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jqBMWRa1KDfc17Ou2WUWVCY5T5bSvG0WQ0HRNeToD0U=;
        b=oxwziGWBgaRNkYVncCBHDOAufcTsr5Hs7Hu6wddYv4fS643Yy2aq8HuYDH4Pbnyzl8
         Kq/c0rXdfOyhlhm3s4hpzSlBMq7nOECH3AkdvMMNCduQnp2xjM2YFNxDcAOTXp2b1Eq6
         1pKvh9JQLi9NsnFhe+uBQpYQjTqX7GKpt92tpnHKgRbkY6pEwq2Yzh1F1hsZmmtIxAQR
         8+YqsMnqfFd+EOG5ugAD+CulMiLr+xlMoTQSLoOkrEeYN6afejay2nToLZJH2MTfQTk0
         re/0En+N3SQxtW1aODq9Lxp3cVvXqzlUR6uBXyiS/wMGhxS7sIovkQKtvNCeR4guVu1d
         91gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jqBMWRa1KDfc17Ou2WUWVCY5T5bSvG0WQ0HRNeToD0U=;
        b=iz9onvL9hCDGtGoINQjQDkwNqf6Nd9vbm1+2ZaJqcYlBz2Vb9YyZ+BHhKaL9/0Ctsh
         pNnnjbbeB6hAHEc42VBT8CSm8pxvZBeVdb3jCYMP/Cptpiwr+2/Kj2G4AeKw30XCaZ9D
         4zF5mvHtgAuStgfqSjD+Zh5vYSoZAnmMD3fjawo1dxdopzCfv/X4A0CkmXwgPGgc2Z14
         O7JXsvjMR46URZdShDtj/x249kUWOC8z1m0O1k+dVvqQBfp9ysSv1+hJj2pzM+hjwzQ+
         VjIHgwLEjMolQrnBAotCcUpQJp8w4B+U8ZqenbozKF/jzzIZuaitYOau2Jo+sJRbPIf4
         D1CA==
X-Gm-Message-State: AOUpUlHP4kXyD/kbtnAZF+oc6GLHdBNoT1dZiSA7s/vkcQ8J3nzQzMIU
        XxuZPM8mAfIABICeq32q5ehAfOua4ck=
X-Google-Smtp-Source: AA+uWPxBd90hCoXLK45V+lBrswHud30CHZqku9z1oB8npyEb89hlcR8tqPx4UILq2nEpvuCnuJQscg==
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr21121972wmg.67.1534617175778;
        Sat, 18 Aug 2018 11:32:55 -0700 (PDT)
Received: from Fulcrum ([39.40.115.2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm11028162wrc.21.2018.08.18.11.32.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 11:32:55 -0700 (PDT)
Date:   Sat, 18 Aug 2018 23:30:58 +0500
From:   Faisal Mehmood <f.m3hm00d@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom: gdrom: Fix spelling of 'additional'
Message-ID: <20180818183058.GA14367@Fulcrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'additional' was misspelled as 'addional'. Fixed it. It is a coding
style change which should have no impact on runtime execution of code.

Signed-off-by: Faisal Mehmood <f.m3hm00d@gmail.com>
---
 drivers/cdrom/gdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index ae3a7537cf0f..38139e0854fb 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -463,7 +463,7 @@ static int gdrom_getsense(short *bufstring)
 		pr_info("%s\n", sense_texts[sense_key].text);
 	else
 		pr_err("Unknown sense key: %d\n", sense_key);
-	if (bufstring) /* return addional sense data */
+	if (bufstring) /* return additional sense data */
 		memcpy(bufstring, &sense[4], 2);
 	if (sense_key < 2)
 		err = 0;
-- 
2.18.0

