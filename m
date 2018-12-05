Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CEC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0167C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWaG5tBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeLERDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35521 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeLERDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so13632808wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrwbSsilASWQXKhY8mtydhKi4I7CC/pS4q3yTCPjBas=;
        b=pWaG5tBJqW29H3mQ3tuk9Z+03uhSi0pBosZ8pbGfspAm1zicvGgYF26zaLeuB3yfuN
         yK4TUYH3dHxsU0Chc1kSM0R6hMWgGMWiNUE5mLde/PGz6cwRNbFH+dWftS7fzVHoWFRP
         Tlnv2OTHivo6XVtHeq8X0hUkttC/2sALNKt0uzdWEdfWdz36QxT70V9a0cgPkOUDFqB0
         BJeTj2r+RfLCEiRFPApuRFARc80sWy7/HK1ft3omGaENA2yDDqklIBRiTzyha4xmQurd
         UMG/Yy8gYRvswuRFTq97KulDxFTceeBd1EgijmL6FVmSBZXvrLRguGX7FBqSHfDI7r0c
         dx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrwbSsilASWQXKhY8mtydhKi4I7CC/pS4q3yTCPjBas=;
        b=tyWes93zkRMLVBUBtbFpy2IWKxKd74grdKdzj5PAYaq7+iPATQIVSMqgl/0DGnExAm
         Gu2jgZyPf1EBN1m9NrvfWC/VOSfyldKx4pi65o4Lq0AJCItlF8dpErbDN4FXr680TRib
         56LiD9fkpUdPLfKN5Red9t9yN0FILX6BaKCaYKEgKynJGb3bSzpcXaxpav88KkbqLOy7
         MahsjI9iSDhdQ2Q0j5VDlCI76zHbeX8ETvzq1SYo05DSVr7m3o/z/IjKJrQDtnOAVNl0
         eU5p+kP7JGNwU5HUOB69KJS8BZXzV88icOWQ7aqwSJi5CzNzOJliK4vcudJgs8ecliWd
         zurA==
X-Gm-Message-State: AA+aEWZ9JyX5/E7rfWubdyHlGHORRC4AyaWUY5pkOh73bA4wfs3PkDLY
        16IdH/j4P2BVu9zziaKBrJdXd8ch
X-Google-Smtp-Source: AFSGD/XTh5TpulvlPaNzULp19x7H7PwT01Yp6dH9OQ1CaM4hwtPTyFel2904vj3nD4T7jcGtVwl2xw==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr16208771wmd.79.1544029381102;
        Wed, 05 Dec 2018 09:03:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/12] staging: rtl8188eu: refactor cckratesonly_included()
Date:   Wed,  5 Dec 2018 18:02:37 +0100
Message-Id: <20181205170247.5401-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor cckratesonly_included() to improve readability and slightly
reduce object file size. Also change the return type to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 10 +++++-----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 90160d5fc292..fac1c1c20b2f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -69,16 +69,16 @@ bool cckrates_included(unsigned char *rate, int ratelen)
 	return false;
 }
 
-int cckratesonly_included(unsigned char *rate, int ratelen)
+bool cckratesonly_included(unsigned char *rate, int ratelen)
 {
-	int	i;
+	int i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-			   (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		u8 r = rate[i] & 0x7f;
+
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
 	}
-
 	return true;
 }
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index c86dec12dec2..0ade33df16d2 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -581,7 +581,7 @@ void addba_timer_hdl(struct timer_list *t);
 		  msecs_to_jiffies(ms))
 
 bool cckrates_included(unsigned char *rate, int ratelen);
-int cckratesonly_included(unsigned char *rate, int ratelen);
+bool cckratesonly_included(unsigned char *rate, int ratelen);
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
-- 
2.19.2

