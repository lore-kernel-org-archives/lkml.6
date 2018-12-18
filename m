Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40190C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1010B218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex46AfUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLRSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:36:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53792 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeLRSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so3673788wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZ/29z9MgCSGEc0k0cJUvP0EFrh8XsoApfscBWCIWPg=;
        b=ex46AfUirCxqVWYBJgVa3pVl8SjpGauB75iSbrw19FR1PquvmfClGc8wjOdokYF9VK
         DmFV9FB13GpCLhyERjrGCbbm8448MoG1XzOOoS3ifbJPX/3JdhJDmwDm+2Vf9pzdjpIZ
         1M0SJ75PDK+l7emcv2c5zdOeFP8bKoH+f/oDsMUy+IOtOJlCkfvsNQ7R6/CLMvpFUmOP
         QSUn2McJ2IvtomDJTH3Qg6bFjt2I6i0lLHsIwNRwfID72SO5GYWRZy6o7rJa8EVUuIYg
         IdZAI09yfra39nUgqcqiQB/Y5jjKzskJhR8mdLNbTiRefnnJ8rMzu//ZWS4yRwRCpRQ+
         Oi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZ/29z9MgCSGEc0k0cJUvP0EFrh8XsoApfscBWCIWPg=;
        b=fMK1B8ztwMkRchmBHYYoyEu2KYAM9S7l+kGhz+rJZDghbxqDUEIvFFuuRDay+gX/l9
         OUqQTxGjhnX7GIZX2m9r5qozkzeEKqk3Oqowteb1A514T53rP3hgshXZmGYlz+dpIdhK
         SXqMQDbYBBYwPpVq7Pv9giXcDVgrDwmowfL/jcU/8JIuMmh5cm0JHTR9DzrGTkl72fDJ
         /VMnuMXTx2yMQLXuJdvnh3tKC6xRFxtrw5ZOhuen+jrron0t9/d1F13HyvKqRTG+UZWd
         w45lb5GOP1i5KZSRQGLeU6NZk4FdTvwVKEKdxdU/EDfUC84MiZmYHxz/9lS+Qu9VC0cu
         Y0Mg==
X-Gm-Message-State: AA+aEWY581+zhGjbIFcHGPDby5/xFKCt0SWWiH6X/RC5847UPnEuQQa5
        6V68OXbLmd2ymK+jM+ArjTk=
X-Google-Smtp-Source: AFSGD/UMoJD/Q0qaZhiXXDJ1zsEX7ZNROsUU0rWe9gUmWHsznGahMf8gWs720eGsuKHwKzPX52NsOA==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr4232254wmd.2.1545158113347;
        Tue, 18 Dec 2018 10:35:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:12 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 06/17] staging: rtl8188eu: remove unnecessary comments in rtw_mlme_ext.c
Date:   Tue, 18 Dec 2018 19:34:40 +0100
Message-Id: <20181218183451.18692-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comments from 'endif's where the corresponding 'if' is just
a few lines above to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index beac6e9ee5dd..40951a31a606 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -333,7 +333,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	}
 #if defined(CONFIG_88EU_AP_MODE)
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
+#endif
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -436,7 +436,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pmlmepriv->update_bcn = false;
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
+#endif
 
 	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
 		DBG_88E("beacon frame too large\n");
@@ -465,7 +465,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
+#endif
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
@@ -4087,7 +4087,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct mlme_handler *ptable;
 #ifdef CONFIG_88EU_AP_MODE
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-#endif /* CONFIG_88EU_AP_MODE */
+#endif
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
-- 
2.20.1

