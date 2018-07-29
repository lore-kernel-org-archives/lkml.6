Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23AD113C62A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D5C20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4MEHRNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D5C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeG2U0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56228 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeG2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so10712697wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rB4/hg8RO73toEiKmPlnSrntqLStIoWKWrMoDa0XxwY=;
        b=N4MEHRNPcuaK5DE04RDff8hp2Qf4LcJGRV641kBcPZZP0U6cNVWameoCPO7Y7xIFm1
         clH8+D1EKc7sMWnv6h6yDsZ8d+j8vhumdcG0iqptDLD1AOGzVxwhiwRgv4UlPmN/FyGP
         c2Mv02rIVFMA2qN+AUfQX5VRmeQGeKTiEAY9uLUZzSyrVvefIlu32+UVAQkTltpxz1gg
         B9VphHtPy3TrAQ/QENqIRy0Gnt2ZmYeGeMbT8R7vjWH6tNMm1/LYMFW12WSkC+AVYKSb
         FlUAOLGz7VVP8dn2cTqwocJxBtpUsgJ5zcap56jNz+96djWxtjhr27H8Nj6wNJFdy+ZU
         NvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rB4/hg8RO73toEiKmPlnSrntqLStIoWKWrMoDa0XxwY=;
        b=ivVsuEADYh7+RpM2DYKX8AjVNIcEes/gCaLceBGa5IoEUdDmPcBPqYzJKUXDqwLlab
         EJZwRLrmU+JYVjsYoYvYgOnQl29+THmtuf/nnVqg94Tq5nNGaoVGZhp1DhLyGayjzqkj
         bwz9NKenkK9VScFaejx6a2XKGhQ2Fai4er4aquHY9MglU0QNwc1TN3stXtmQa0scLQn4
         F8QkOZgX83/TmLmGdxp+dIaxI0lDrD9cq5Nkc5TrrYZEQL9uuHfuhAGEKjC+Vh4Y7ga1
         9yyJ+A32nilf9cbzPiXfnhmnBlm7DSbw72kcZYLP7XoDjN+PMxh3G1pRe+64GUfG54W3
         yXlg==
X-Gm-Message-State: AOUpUlFepSs6r8GFvrX7sJCGSnxp8wvyWyqbhPSnAu2dJ8wRaaTt820L
        icRsDvzAra0P6VLC5t7c9TA=
X-Google-Smtp-Source: AAOMgpdV2sFKzgUqNWdNkXl9vUIWJJBvHizZmReJNkOpNGnEqoIAD8eplCW/uO+A6MZfIVZMeWggnQ==
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr11664521wmd.46.1532890512973;
        Sun, 29 Jul 2018 11:55:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/7] staging: rtl8188eu: remove unnecessary parentheses
Date:   Sun, 29 Jul 2018 20:54:47 +0200
Message-Id: <20180729185447.19903-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses, also clears checkpatch issues about
missing spaces around '-'.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index b21ba01abc57..b8fecc952cfc 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -48,15 +48,15 @@ uint rtw_hal_deinit(struct adapter *adapt)
 
 void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
-	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
 
-		if ((mac_id-1) > 0)
-			psta = pstapriv->sta_aid[(mac_id-1) - 1];
+		if (mac_id - 1 > 0)
+			psta = pstapriv->sta_aid[mac_id - 2];
 		if (psta)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
 #endif
-- 
2.18.0

