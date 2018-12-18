Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F73C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B9218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrc5o/ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeLRSfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50648 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLRSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so3684000wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9J5Blxm383J8hyjcDroLXwXnSmb1MbWGbnJ7VOJtZY=;
        b=Hrc5o/ibaoYO320/GHpLipW3d9kafYiLFnyeN/h5kvNurQhKibB+2GEve26BnRwlBw
         Is/6s5lb6ZPt792tnP8JjC098OhAsbFfpwjrYNCQNpNu3ALUx5JYazbVSA5/YbSXDJ2h
         ddg5fknT2GQBkJME9pMG7SZLx40Wdca+CYEDlAG2C4fby6g74THmAbeqK850+QQOvsO6
         rrUNltunF4KNDjX9+/tvyPQyYvJbNo9lsI5U8nr9N29JDGAleirsEpQ+BQJ6TpM959nX
         3Faj2ntxqmlcCwIPwzG1cfZYSSmrwNDWBJlVL0lzzYebNT28iD9OZqaee4BZ1rhDFnL8
         ROzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9J5Blxm383J8hyjcDroLXwXnSmb1MbWGbnJ7VOJtZY=;
        b=te4LDzhOBWXmkptIB4LTeWiKjjboncr8rPXlrEnDABrwDCJqX25hWyRHhdEVQXB8pH
         RZ2lLS6LHUYFGMmooBCQE9KoWbQ3707b/uZFJNIvu5P6WlApw6Ak1ozShYeUdH6Y4fv9
         /o/oT7QS1Toa7D8zYi6HXYLUJQnbuSg4GWwHu+OhbvNpk7s7XtSL4wpRKWYJDRAQoCD2
         fE0MstFMhiaAvFspdmdtNVzaVqsm1wXgZbNmxOnNnS9kTznGbSgIfHAUYE6PKp/o4h40
         IEURYI05RHf3LsxDaVhMgcUL/6Fl0ZiJhpUpQW6lCBIX82AUI/cWH9e656hw8rJnpCKm
         xFWw==
X-Gm-Message-State: AA+aEWZOVy3tz15X1d8KY6bT5BbkTlipkUUNWNJKOcizmsiM0xCX38uU
        LyT1TAW+d8RPc6sIxQoG130=
X-Google-Smtp-Source: AFSGD/XC9uxxkQj/yd9zOT0nWoHZjgamFZCBSS/M4N3HktEIGKmJhmnO3ktkpmjrY8By/KAij8vumQ==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr4153960wme.32.1545158121251;
        Tue, 18 Dec 2018 10:35:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 14/17] staging: rtl8188eu: simplify null array initializations
Date:   Tue, 18 Dec 2018 19:34:48 +0100
Message-Id: <20181218183451.18692-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy initialization of null arrays to improve readability
and save some lines.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_xmit.c     | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index d3d211d8eeee..2a42f80d1970 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -17,7 +17,7 @@
 #include <mlme_osdep.h>
 #include <recv_osdep.h>
 
-static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
+static u8 null_addr[ETH_ALEN] = {};
 
 /**************************************************
 OUI definitions for the vendor specific IE
@@ -5207,7 +5207,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[ETH_ALEN] = {};
 
 	/* main tx key for wep. */
 	if (pparm->set_tx)
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 14e3f59b9009..3b1ccd138c3f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -592,7 +592,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct	pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
+	u8 priority[4] = {};
 	u8 hw_hdr_offset = 0;
 
 	if (pattrib->psta)
@@ -605,9 +605,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	if (pattrib->encrypt == _TKIP_) {
 		/* encode mic code */
 		if (stainfo) {
-			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0};
+			u8 null_key[16] = {};
 
 			pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
-- 
2.20.1

