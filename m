Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC4C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B8C24E75
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojg7uVqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B8C24E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeFXJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:58:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35803 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeFXJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id c13-v6so711112wrq.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qkrcckuz44Cyt41A31MUxsK25Q72qjMqNa8L82+dMnU=;
        b=ojg7uVqNRXkIuBLNzHmQloaBi4ZN6CkRfwgmQ+WU8iPJzGckxMvKlBi+0EmmRcbmJ+
         sORLjUTls2OsWm8KS/TZgm67vazfSOjXKSbo2ZYGqZvsBumMDvrZW3NjZAhzTR/2XM8p
         71d6N+7Eq77sTTihNNioYLs891RFr2tf75I4mym45lz1y420HKaM0WdaZzBaTzd+zLy1
         LwlWmqY5+dq6btiq4KhQKGJto3jUgcuHlALBnkPNdhudSE1Yj4koJA7u1ZEpq+yZp8CD
         lRekaXdpp4hkgadPZOSBMYJLpOc98i1qxr0Nem0MjSq89bMaIQxNz7SCYahvdL4DLf1f
         mViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qkrcckuz44Cyt41A31MUxsK25Q72qjMqNa8L82+dMnU=;
        b=VgLp5TLI6g4X+bDnOKbx2ka03UWkSnsraps2ScKrHprWQLDmIoSsSRoFTrKPUeq52Q
         zXuFF3oS3xy5v60AAl/7eJq6rFvQ94EaolHG0LrBqBtEUwLlgbHeSSh+Qci0xuBUZ5Vf
         mwgOgti0g8d9qx1rGEWD+kPX+sKIIDdNOIJzOoTLPbIwNMqnXpPWcQ98S4Af4ouafebN
         Yb8G1jEKEZ9S2P25YVH+YTyO7pzTpb14H68DeEXYGMqHiRUfqmtz3C9n2/eMGLh11bju
         Bd0tIEgvzgE2F9itMZB0nlXW8GTexJW11VJt45qhEzUswMvgbOen1/ppnXoDdUAd8JcI
         ybQg==
X-Gm-Message-State: APt69E2tOyEZMQ+LfLf5gxdW7lPKyQRlkTXzIt8DpFk0wi/3L75fLgf7
        dtc/XOepCAB5l57C3x7Bv+TNWQ==
X-Google-Smtp-Source: ADUXVKI9gOiFJwaY3+ZqtR1PBVdiPuYJ3f0pY21N8ylFJPj4A3gU4m0kj14nNrcP9QR214rfaJH9ew==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr6942805wrd.272.1529834296110;
        Sun, 24 Jun 2018 02:58:16 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 3/8] staging: rtl8192u: User memset to initialize memory, instead of loop.
Date:   Sun, 24 Jun 2018 10:57:27 +0100
Message-Id: <20180624095732.12082-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced memory initialising loop with memset, as suggested by Andy Shevchenko

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 4bfadb49c363..bbac9d04c23e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -742,8 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
  */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
-	u8					i;
-
 	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
@@ -756,8 +754,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for (i = 0; i <= 15; i++)
-			pOperateMCS[i] = 0;
+		memset(pOperateMCS, 0, 15);
 		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
-- 
2.17.1

