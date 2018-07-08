Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C043A208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRfxpT7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C043A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGHKkL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:40:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932833AbeGHKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so11627020eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QphCGNw9bSTBPGiBNt3GYy/IZIA5Fm9gGqXEZSfIvI=;
        b=tRfxpT7wNxHSmHkA4louKUCMwGDD4AJ3Qu4dunvxcW00O8irqYBn4MElbZ3rp7xTNu
         ijcgFg/obTZkXgUfChlncb10wkquchVG96X43W+i1zR674IHuj/2jla7xq7up1/zpO46
         6XgXTtXATSAseKtnUrgmzegiLS6Ye6DtBdNkH3HqYzzScNugZ9nCeZL/0gqoOdlRNxvV
         bTHUlyhhzmjmovMl7lCJ9nR8Mk1nRdqPFuKkwm3rAHtP1r76X8A1BqgLzmckS61tSB6R
         3n2hkUAOMx+NAxCHqV6zfFNoIZ3NOzncqGSgVCXdVG2cXUpaKN3JGyaysCoSKMHugOb0
         OYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5QphCGNw9bSTBPGiBNt3GYy/IZIA5Fm9gGqXEZSfIvI=;
        b=gVKMxQgOt8ZyXDbmcOsESukJHE4d2nVVdtTDDAzaC7Vlq5JzQkFJMyAeZp3LLz+7Nk
         pwB/Rc1ZVjVfqxojMufP1vJfAlhg/HuldXcndUv2ANt3FZmryWPfqDjLgAEK70x1jdBx
         O1zVKej+Pc2yuB995WlyqQwi4PZI8LK3WGQFNEeHKg8HEDhm09viXqjTk4WL1v5YHfXP
         xDMe2kUqOKHQDiMMaKLifaLpXhti9uS95hczUIawt3VYwjrjnx2Rb0n/zDr0xdOfMaT6
         AQNjJ7oQE9mlR1TuzkaG6zxFra13CSLvhnVgu74BbeUgmIhUxKVhPfPpSHkhb77w5oJY
         f98A==
X-Gm-Message-State: APt69E09Fl7fX+jAJb4cwQEmyZoxdXYAt1IrJpnSUWz9Tqz9CueKazuY
        aOonGYcXRUQ79RebF5WQ5Uw=
X-Google-Smtp-Source: AAOMgpc3GH3dduLKaCqXSxskF5ugpzcymXgxSVTSC6FLxeGa0bxNs1jfMkGHUzFC3ql+R3wHqEyj6A==
X-Received: by 2002:aa7:d68b:: with SMTP id d11-v6mr17981574edr.196.1531046362027;
        Sun, 08 Jul 2018 03:39:22 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8723bs: fix indentation
Date:   Sun,  8 Jul 2018 12:38:52 +0200
Message-Id: <20180708103855.12473-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708103855.12473-1-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired extra indentations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 429ec929fa1a..adf216de113b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -69,16 +69,16 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 
 uint rtw_is_cckrates_included(u8 *rate)
 {
-		u32 i = 0;
+	u32 i = 0;
 
-		while (rate[i] !=  0) {
-			if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-			     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
-				return true;
-			i++;
-		}
+	while (rate[i] !=  0) {
+		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
+		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+			return true;
+		i++;
+	}
 
-		return false;
+	return false;
 }
 
 uint rtw_is_cckratesonly_included(u8 *rate)
-- 
2.18.0

