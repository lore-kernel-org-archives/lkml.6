Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0156218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Vi8b8c+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbeLTTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:51:33 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52990 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeLTTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:51:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 84D349C8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RbqLMdHwvAy2 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 13:51:31 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 58BD9514
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:51:31 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id i12so2633787ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DCNlHdkvdIUGRN9ww792EColzsYz2mqQhXZ13uy+EAM=;
        b=Vi8b8c+EMz1/I1CM8QktxdJxf5M2bVA6wCChCLYlpiFA79j4MMsN41zYDRPayfzG0n
         xukf2ZMz8vlkRE1phxdwFXGt4GsnZJHzUrAuhFVJ+xP77LqOYPLrBvXGmq4PtPCMk6E8
         3+bG2H1c5ROZO1wBhjC8+2767l6lRVIuEel2BWmqFzXL9hlSvcLyDc0Im/PH8h84eG7i
         kXrQjBeh1RiArvMch7iSRXY8lVoTZ6h7ts2cSjN+YtmjzMV0SmfMDCz6e5eUGEZ4YsYg
         ZGqYjMK1Dpx+Mk1adS283EkRNDp7tfYJQBoYY06FZ5cHzX8GBGTQnOkmntowdi3VbWR+
         BDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DCNlHdkvdIUGRN9ww792EColzsYz2mqQhXZ13uy+EAM=;
        b=GNM1FylVauOqqVHPCkWUXUz1Ys1cD+VTeebFWgxtTJeE8Nymp2zS6IqYIIYcKfrcal
         +T2WGMnDJKQIb/EbFSYvwfwnCclZHL6nIn+ayZJLWdfd1dhepDXe4XLp6PcT6VOQRRA6
         LzV114MYOF7nObHI2NTVQ6rRAM4lOckhjeNAdE/V30I30IPdQYhOQuuVSNu6r8PK5tco
         stPO1JlZ+lqltRot2PH3oicIszQ0Q2IRCTBBNpGVLybYKN/UwDtp5CRTaQ/IXncw4peM
         odD/gTXUDhO93EASu9CChEHfls474Y4lMJ/RHQBkwI4tmC8XnVIAuNTEml4k2hJKNb0t
         Fi/w==
X-Gm-Message-State: AJcUukfPfZU/VlcQQpgjOQb+Z3pFJBZB2ERnJqbUsCoM3OuoluLriEMh
        Fn230xJyOVg8SaRsVjtkF5xVpoLs5j75ymeSJW26vvhSMHiETU1gM5Z9G/uyz2+4Na4vURKQNf3
        U2uaKywLPVl8rhUzq8RzOYfAnm74H
X-Received: by 2002:a24:4545:: with SMTP id y66mr17605ita.174.1545335490933;
        Thu, 20 Dec 2018 11:51:30 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WjX8lK8Aj3+mLdGM379dUNOAGELi7yTdzhAcN0DAkTkJ3aE1B9tfvBnwLIKf7pChnyI+7mZw==
X-Received: by 2002:a24:4545:: with SMTP id y66mr17595ita.174.1545335490694;
        Thu, 20 Dec 2018 11:51:30 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id 197sm5314454itx.21.2018.12.20.11.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:51:29 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: twl4030: fix a missing check of return value
Date:   Thu, 20 Dec 2018 13:51:24 -0600
Message-Id: <20181220195124.29467-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If twl4030_bci_read() fails, the read data in "s" is incorrect,
which is however used in the following execution. The fix checks
the return value of twl4030_bci_read() and returns an error code
upstream upon the failure of twl4030_bci_read().

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/power/supply/twl4030_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 0e202d4273fb..4299873a1118 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -809,7 +809,9 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 		is_charging = state & TWL4030_MSTATEC_AC;
 	if (!is_charging) {
 		u8 s;
-		twl4030_bci_read(TWL4030_BCIMDEN, &s);
+		ret = twl4030_bci_read(TWL4030_BCIMDEN, &s);
+		if (ret < 0)
+			return ret;
 		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
 			is_charging = s & 1;
 		else
-- 
2.17.1

