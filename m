Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAD5C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CB208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdADbBSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6CB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeGHKjU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:39:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38091 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeGHKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id a5-v6so11630125edt.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eP9P7vyIeEe4TkRqiX3aiqmc3cEl0zb4SpAm/o6lWYc=;
        b=bdADbBSCdpQXJWJHSZ3nnMQ3eYlWYF3QjAPrOQB/WNa77Gccx+1SL2JY65JTTAFmKg
         0kqEZbaqRwRGBpJjOnF9sxHqrtnynq0TnuuVujfFWlfAQL2nGlIqiUV7x/A+ipPEmxeY
         lD4/bL2ejUXjxLOOAYr0EV4RgESGG6r9oKzeC5ehbU9WglwsBIwhwcQA41UbFBCIc9A2
         KOku6v2J+5k5ct5hfG7WttzEQU+P1aK4IaN+SvBTRpVjDHDIJoMGZslksRIgJrbKmr+N
         ybmSPdL5a4uvU/Wu+oYQdxZCdBxPeKHKUtQfQhB58Xqln67CXBKJGWnbZAUzgFkLCpD9
         Pmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eP9P7vyIeEe4TkRqiX3aiqmc3cEl0zb4SpAm/o6lWYc=;
        b=Xfhvk6aA0vD03TDG8vnJDV9NXcCvfovYONCDjMg9Wu8NaeJZU8LM4ocaQ9VyeN3fPW
         1kDOXOGxY6HqsnWLZ9L8cfcAgVujfBlKW51nGrLAttIzH4RYU0yereR1SwZqqtDr14iX
         ppU1u+icbD/mCjAYwjr89yhE7zKstCpo0PI1DUkDot03kJe3C2x8TbFeYUgG/bgc9SUJ
         jVuUV82rQamoFWGGJ+LxfMPlRuByv5PXu09UqI8/QQhSGsNBWk9Rg12nunAw+bNhC8SB
         Z2rzjvYlOXWc68uYRldm7ydxBjl5YWzNR0wpA8GwSoRgcDznrNVfspa16GIeKYFUH1sb
         z69Q==
X-Gm-Message-State: APt69E3GtksjVObF36NJCHP0cpIKsjo5FrCmluMh2ELnPVUUElEcWqbl
        CEEw5i5ckg8Ysub6oyiWBvo=
X-Google-Smtp-Source: AAOMgpdY5mkeol6Msw7L72L4hQzkMe14MmBrA2w2fqmnlpzl+rSCTjTXw2tgJHJBVzlTB52GpfSmBg==
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr17833985edb.177.1531046358222;
        Sun, 08 Jul 2018 03:39:18 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8723bs: replace while with shorter for loop
Date:   Sun,  8 Jul 2018 12:38:50 +0200
Message-Id: <20180708103855.12473-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify rtw_get_rateset_len() by replacing the while loop
with a shorter for loop.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 8e0025e1ff14..9b60e0214bd8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -298,17 +298,11 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 
 uint	rtw_get_rateset_len(u8 *rateset)
 {
-	uint i = 0;
+	uint i;
 
-	while (1) {
-		if ((rateset[i]) == 0)
-			break;
-
-		if (i > 12)
+	for (i = 0; i < 13; i++)
+		if (rateset[i] == 0)
 			break;
-
-		i++;
-	}
 	return i;
 }
 
-- 
2.18.0

