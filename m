Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D011C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EA62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBY2+lnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EA62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeIYRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:32:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeIYRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:32:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so18864842wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xw4ZzyvWXXPp9HCTgg0Xqa2eCpR8hD+yk6bgOZWs1po=;
        b=EBY2+lnYhHuAtKHQHPXpzGFmIY1rafZk2pDJiJ3zhVkT3usQCqNda4wdwyqOVZ9Ti+
         aT0EmOmjHdU7FRmGEKPH/L/SqwZCUvDxos7zjuqiFztPGm6u36LbbPt0OeWUljszMn7J
         vsJInyu0aSSuCrrvu+KOt0b2SiW4WsBISqZEER8343TM4zKGr8zb1VuRH81iusMpCl2a
         S6ieniuUqst55M8yBN55ePmfuC9n8X5Bws020rWhxdJys+g2VpHkUiZLKwL/orxYmale
         nT7MjOeN7ISSiBlrOxuuzXprPDTc6sN/s7Iz5em/7VnWgmlcXskHFl4f68/QQsHmXMQF
         gJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xw4ZzyvWXXPp9HCTgg0Xqa2eCpR8hD+yk6bgOZWs1po=;
        b=bLmcfJO/TeCMxTGaJpO9qV4Su7ZbziAU2OEs1r4uDPTlA1Au+GjEPEudfeTiaD6vMy
         yzjEiJx6Xj41cvEtMdB1ewIth50J2o8k9iW0saVceK4NdyG4nNV1I8rw+bxTYEs5OhxP
         G8Mr5WI0o5VOMmaONDU8A4XbP0wrFsiPlFvZEQoVtQnXS1KZxJK/XR/a3rm48VSNgDe0
         beDaQObkQckEejQ1aT+DkFMyVRdZqBSUICeVYFdKwqoII8cxDpJmUqoXJZN2IkveeAOu
         tZWOhF9+f4Rc6WDT9dQJeZY6/qiQq2iFQmPvCiJQ6mJLGk+dX+oLmZoNpjOqSbNdXHsK
         1SZQ==
X-Gm-Message-State: ABuFfojwNvhwEYc5lig3f5uvCmQl2BTkfyofySRwjZBWrolwP/gwC/FN
        Xsxn41IYcSwq2DgMCY5abes=
X-Google-Smtp-Source: ACcGV63M0ZM81f4O218XfmhWI3C8vaZS9bbk2UrpOgTYv3pWs5EeEWs2uC3u2TfeVCMzXNNj3cDiNg==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr571332wrw.204.1537874730436;
        Tue, 25 Sep 2018 04:25:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id w13-v6sm598143wrn.56.2018.09.25.04.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:25:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove unused rtw_scan_abort()
Date:   Tue, 25 Sep 2018 13:25:20 +0200
Message-Id: <20180925112521.1254-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_scan_abort() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c    | 23 --------------------
 drivers/staging/rtl8188eu/include/rtw_mlme.h |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index ef8a7dc4bd34..d134be69f866 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -828,29 +828,6 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 	rtw_os_indicate_scan_done(padapter, aborted);
 }
 
-void rtw_scan_abort(struct adapter *adapter)
-{
-	unsigned long start;
-	struct mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(adapter->mlmeextpriv);
-
-	start = jiffies;
-	pmlmeext->scan_abort = true;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) &&
-	       jiffies_to_msecs(jiffies - start) <= 200) {
-		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-			break;
-		DBG_88E(FUNC_NDEV_FMT"fw_state=_FW_UNDER_SURVEY!\n", FUNC_NDEV_ARG(adapter->pnetdev));
-		msleep(20);
-	}
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
-		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
-			DBG_88E(FUNC_NDEV_FMT"waiting for scan_abort time out!\n", FUNC_NDEV_ARG(adapter->pnetdev));
-		rtw_indicate_scan_done(adapter, true);
-	}
-	pmlmeext->scan_abort = false;
-}
-
 static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, struct wlan_network *pnetwork)
 {
 	int i;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 35997c521c35..49d23aef47df 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -311,7 +311,6 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter);
 void rtw_indicate_disconnect(struct adapter *adapter);
 void rtw_indicate_connect(struct adapter *adapter);
 void rtw_indicate_scan_done(struct adapter *padapter, bool aborted);
-void rtw_scan_abort(struct adapter *adapter);
 
 int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
 			uint in_len);
-- 
2.19.0

