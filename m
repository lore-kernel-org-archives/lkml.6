Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2FBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811FE208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgusynQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811FE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeGaNO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbeGaNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so16259983wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NWqh9C/3ImuHo+zZzWz7h5iuIuOT4b1PYSq9aiPPXNU=;
        b=SgusynQRddNU8jdaSlTFGhZzFTeZLkx4ZLhi8rKhon1O/wxWWLKZaanT6GnRe4v+qB
         tR2LZyHfxZNknY4nVdkKFTR9mWwbz+yidgDc/f6sYwjUALWLhL3EcoMmWEOesgJkDxFs
         PMO9DBA73jFZwainLHCtiou8MUfvnKIhi520hajBue9UEtugSV4LEM9BS2meB4WFeWRG
         dzBIoAUnocedxl+USXJGjd4eQlG7dmKmt4+iuC5bn5E3BVJejf/TnU4DPTZitrS8dLLK
         sqeDb9wRdOJktAVShQZj6tgLKzRR1ydBGU3Jfv8hhIinddoOfTcZzTKqGx5nE8i0yu4w
         LQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NWqh9C/3ImuHo+zZzWz7h5iuIuOT4b1PYSq9aiPPXNU=;
        b=X8BSIvzAEmoQvscLuRzL2t+uaLtMACVMIsCCO3HWAKIMbQHKfhNjyMWft39RA+mqNK
         FyIXPik3ARJ3EXkdLhspCUbxyJFpLEcu+YYv1Y/sAAECCQe44Z/L/7TRpLXrZbysP799
         DKBMhdtKvAF3Mr3PaBeq++yX1hli0U4J//QrckWUSUrL1E52heSBzeR3erMPbxjUND8I
         xKgE6ETirvzvoMaGT2629m1eB0rJ9NcZVX2+Sk5TSWloxiiwsUPu4xBITtYFMaJ7gD7u
         N6Nhz6PWoAR+JKorG7mTmHqd/3t+0GgdE70RAt2bfEZDN17frEkHS5rJK+CpEzRInBhZ
         IUOg==
X-Gm-Message-State: AOUpUlHWw3WZeq9Vi2JQm9M4e1gLsxu1a/wrliYSOQ+iF6rcDkwfzB/a
        G1FSGXXoFifqnuQsIZUFpJg=
X-Google-Smtp-Source: AAOMgpfXwvr3kTdjyUFTP777Vu1PNfn1LL5PcfpzXHHk+UQmORghq4PNxhclWtG9gTVUEhURmcdL/A==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr20617224wrf.206.1533036873239;
        Tue, 31 Jul 2018 04:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: rtl8188eu: remove unused rtw_add_bcn_ie()
Date:   Tue, 31 Jul 2018 13:34:13 +0200
Message-Id: <20180731113415.1500-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_add_bcn_ie() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c    | 66 ----------------------
 drivers/staging/rtl8188eu/include/rtw_ap.h |  2 -
 2 files changed, 68 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 220b4bbe1f84..82fb1b028fa0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -145,72 +145,6 @@ static void update_BCNTIM(struct adapter *padapter)
 	set_tx_beacon_cmd(padapter);
 }
 
-void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
-		    u8 index, u8 *data, u8 len)
-{
-	struct ndis_802_11_var_ie *pIE;
-	u8 bmatch = false;
-	u8 *pie = pnetwork->ies;
-	u8 *p = NULL, *dst_ie = NULL, *premainder_ie = NULL;
-	u8 *pbackup_remainder_ie = NULL;
-	u32 i, offset, ielen = 0, ie_offset, remainder_ielen = 0;
-
-	for (i = sizeof(struct ndis_802_11_fixed_ie); i < pnetwork->ie_length;) {
-		pIE = (struct ndis_802_11_var_ie *)(pnetwork->ies + i);
-
-		if (pIE->ElementID > index) {
-			break;
-		/*  already exist the same IE */
-		} else if (pIE->ElementID == index) {
-			p = (u8 *)pIE;
-			ielen = pIE->Length;
-			bmatch = true;
-			break;
-		}
-		p = (u8 *)pIE;
-		ielen = pIE->Length;
-		i += (pIE->Length + 2);
-	}
-
-	if (p && ielen > 0) {
-		ielen += 2;
-
-		premainder_ie = p + ielen;
-
-		ie_offset = (int)(p - pie);
-
-		remainder_ielen = pnetwork->ie_length - ie_offset - ielen;
-
-		if (bmatch)
-			dst_ie = p;
-		else
-			dst_ie = p + ielen;
-	}
-
-	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
-		if (pbackup_remainder_ie && premainder_ie)
-			memcpy(pbackup_remainder_ie, premainder_ie,
-			       remainder_ielen);
-	}
-
-	*dst_ie++ = index;
-	*dst_ie++ = len;
-
-	memcpy(dst_ie, data, len);
-	dst_ie += len;
-
-	/* copy remainder IE */
-	if (pbackup_remainder_ie) {
-		memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
-
-		kfree(pbackup_remainder_ie);
-	}
-
-	offset =  (uint)(dst_ie - pie);
-	pnetwork->ie_length = offset + remainder_ielen;
-}
-
 void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
 		       u8 index)
 {
diff --git a/drivers/staging/rtl8188eu/include/rtw_ap.h b/drivers/staging/rtl8188eu/include/rtw_ap.h
index bca41d68ce9d..f8f07257976c 100644
--- a/drivers/staging/rtl8188eu/include/rtw_ap.h
+++ b/drivers/staging/rtl8188eu/include/rtw_ap.h
@@ -19,8 +19,6 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter,
 				     struct sta_info *psta);
 void init_mlme_ap_info(struct adapter *padapter);
 void free_mlme_ap_info(struct adapter *padapter);
-void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
-		    u8 index, u8 *data, u8 len);
 void rtw_remove_bcn_ie(struct adapter *padapter,
 		       struct wlan_bssid_ex *pnetwork, u8 index);
 void update_beacon(struct adapter *padapter, u8 ie_id,
-- 
2.18.0

