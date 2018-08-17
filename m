Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BA321788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGyLCT5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BA321788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeHQXZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:25:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHQXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:25:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so8422706wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h96FBvPBAkQf6eX4S5p/OT/114s/sdFdiKX2lQk1rnU=;
        b=VGyLCT5TbujtOwkqNmrbYDbTWdrC1bKOy2YE//C4mrtykVLkLLEBBOt37ugjJ8ShP3
         jchpxbjjaTBkzSG2MxODaVzi+SOZTJ4gdD4FA7hxmXqxhmWTgu12eQ4cetz0WbqIpefZ
         LwtG1fVZPipyllxCPDTqFPTOEgqCv9D9GcrIDPcjhp954rHAW2Yn1OfSmMMz+wHuwhnJ
         4lypjeqcp0Vje50ieM0EZ0oybXswvZc2HjNKhhVMuZwBvgm+X8Kc4zmYwF2MKDD1TiKA
         qlkaZT2kZxYp5utxsqzgpqZUYw4dcpxRjlnReRx5Tlmvfg4yRhbrmpJMj6NxJivgtTGS
         F7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h96FBvPBAkQf6eX4S5p/OT/114s/sdFdiKX2lQk1rnU=;
        b=VC8/ciIf1tsVKsVt+iNTlaX6z0lLG8AFxPSBbm/7HLbB5gi6RpZVkHhhOHizFc2DWE
         EUACTQR2KiUnjXjpoI547beTgTY0HDrtG08FGlaIXL3WqDhU+GeC8DiyFzcdxy+ABNhp
         E9wMOpGhuKULNj12GUG5vM3le/BTZCJ+L3Fd/cgIsfr8DJk3ftn3ffHF7LAzZyVrczaQ
         j/9r3onnGf/49ToJOpc9qjycK1sIN+o8DQvHv7oQajSqSgRU8Me31/jeA53rlWAOTCxG
         LWWetx6UXhCiJXW8Ng7cRYlV8i0Um/eMihof4k2kWED9r13JA0+iubQyBh5UI6iZvQIf
         FPJQ==
X-Gm-Message-State: AOUpUlH10dMRS1SuMZxagomBbXcrMW6xtsnGjD/33wO53cbDtt+sZQHz
        31DbtHPBkhKAb2vXPbHcB2c=
X-Google-Smtp-Source: AA+uWPy3wNzwmWHjAkAeky0tghL9hHWb9IbeRzQCUkP7/Z6k3ZM/Je7D7OySrj0Ps5E3VbEh4IVchg==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr18579724wma.129.1534537242888;
        Fri, 17 Aug 2018 13:20:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.googlemail.com with ESMTPSA id n11-v6sm4678493wra.26.2018.08.17.13.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 13:20:42 -0700 (PDT)
From:   Harshit Jain <harshitjain6751@gmail.com>
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Tony Finch <dot@dotat.at>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: unifdef: fix stringop-truncation warning
Date:   Fri, 17 Aug 2018 22:20:38 +0200
Message-Id: <20180817202038.27257-1-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling the mainline kernel in android env with latest gcc 8 the compiler threw this warning Thanks to the advantage of improved static analysis in newer gcc we are now able to
see this warning this patch resolves the detected compiler warnings.

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 scripts/unifdef.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index 7493c0ee51cc..985649805cdd 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ignoreon(); }
 static void Itrue (void) { Ftrue();  ignoreon(); }
 static void Ifalse(void) { Ffalse(); ignoreon(); }
 /* modify this line */
-static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
+static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }
 static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
 static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
 static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }
-- 
2.18.0

