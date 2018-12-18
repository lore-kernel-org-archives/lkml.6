Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CB5218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCTky5rN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeLRSfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46490 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeLRSfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so16910501wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNV/4o6AvVcCPYgtVHcIVqW6/xfbDsO6kKE53x45h1M=;
        b=hCTky5rNgDJB8YWAOME3bUvudNHaSUGBFV7CDN6OPfIBUkJoj6hi0GarJ1Cnm0HHdz
         FCarUU7wW8SavVSCRyuN6eClpD9mB++iL9vLvbmQETO3TT0F+c0BGc15diijHJyrK2Y8
         6+QzmO0T354Ge2Fxh5MwqN3shq/ZUM+PMQcGMeHzcNyQvSbfdXJ09A5Rh/hAhkDQ/DFR
         Gikfe0548oM0BfT9wR+n2XhrjdKTl0CK/cQmg5JocgICCWtpz2PmfQ+xHJUrM7fDNobc
         Epxz4eqfJgvaXBvGA3s4wol/V+yybsLnvuwh/zfPiaFciTZGIfauFtu1xtMbAscsesgq
         S1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNV/4o6AvVcCPYgtVHcIVqW6/xfbDsO6kKE53x45h1M=;
        b=guXA0StjGZybzFjUU0E5mB5TX+gw5njzKHbp92rYf7i2xSO+7FoDzXDrcsxzuRW0UR
         Pq6n77vQoQBLyZ/yjiaoBMLVPfz1asvqyJAr8BN4waGF0CL9GHONH7GMpHzJsMpFgQ0c
         UlHVFghbCz7zfcptg6QaJCCgPX5MlDQ6HCUFRRo5KtbBybBM3IErBddcIaljLr0qNbNp
         YXQrosCligYiQlltu+YgJ36Ah8CRnN7nY2+2bIPZpIBP92++DgOrS/brcP48XI5K5M0V
         Db/ZJViKPd8go6Fxn10fIMeHPrK5KbGOCS3Vbfpsv3UpAkS3izWnEQCLfQBRgl5XyxsL
         zQqg==
X-Gm-Message-State: AA+aEWajd1b7jB0tC7zJQWz6BLBPK1JOSAOSiGPIkxANMym99JKwQsK8
        QnogHcHEKUFUmIb4lnjfCLODvZk8
X-Google-Smtp-Source: AFSGD/UTdIw9qng0lE5rKaESCE76CB5bxJ5lLTvGufjF6FiUzNUxlRytgPezqB1at40LFtbYl7uWXg==
X-Received: by 2002:adf:9168:: with SMTP id j95mr15278736wrj.217.1545158119176;
        Tue, 18 Dec 2018 10:35:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 12/17] staging: rtl8188eu: make some arrays static in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:46 +0100
Message-Id: <20181218183451.18692-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some arrays that are only used in rtw_mlme_ext.c static and
remove the corresponding extern declarations from rtw_mlme_ext.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    | 6 +++---
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index ade4045bab45..30ae42c17796 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -23,11 +23,11 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 OUI definitions for the vendor specific IE
 ***************************************************/
 const u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
-const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
+static const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 const u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
-const u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
+static const u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
 
-const u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
+static const u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 const u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 const u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 08151a175d6e..1fb2349bd0a0 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -80,13 +80,8 @@
 #define		_48M_RATE_	10
 #define		_54M_RATE_	11
 
-
 extern const u8 RTW_WPA_OUI[];
-extern const u8 WMM_OUI[];
 extern const u8 WPS_OUI[];
-extern const u8 P2P_OUI[];
-
-extern const u8 WMM_PARA_OUI[];
 
 /*  Channel Plan Type. */
 /*  Note: */
-- 
2.20.1

