Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B605FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7663B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKRIKKvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7663B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeKXH1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42018 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeKXH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so13412541wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wI9upPqb+0erES6uHn3/tJCvOTsJnHRatY18E0y4L4o=;
        b=JKRIKKvn+80lRcWkv+mIzSdbjqZC8/KRQRErXLMTm7OkLBBWzlwcoXur3MW4iwPSWD
         6q/MLVLvL9cZVz1XPHtTi+JLcf9wR7TZBR36diOzuXQtjbToItLrq7R3DR8YZMEsAsUZ
         oF48Lo+xyPMSfVrG73ChNiRzQSX59ADB0QFR/D7FKwCLBwTNM5G4Iw5nWDs8cxjGvl4G
         nUmgWqgEl/Y8ZbCxh5Pn5/8IEAGIk3Kiihqs9KzjiIvv/S1f5Pj6QBkR/iedzJ/fN1dL
         3Rt+st+2hz6RcMrt8VbLohsUDqd7+7YcWKxEOq87nkbjxoK8FzWq8UdxFBcwp1Zlk3jp
         3wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wI9upPqb+0erES6uHn3/tJCvOTsJnHRatY18E0y4L4o=;
        b=sD+ebgn1qyh7tAuJNrEieczrz8fvRzxUt9OZvZMtKHKvJIsObHEN+G4StDqE2j1oyT
         AMDRSnmpptdIZWZJIK8bM9GzNk1f7PxK8Uy8lAnA/RJdHwNTD501Q+qd6pxc608nWZ6X
         5zNfOlOwPLz8Enezs8GMQBaa7ItCnkHZZBpdaCt2o/sLgBgBMVHkPtWxgOvab/qJOLK+
         +lFBVlE6aNiYkSlE9scsm6TH2UTJ9Ek+5WxJ+KwLDkHvYNEZcS4dR3NtVgIcuSWcNgUT
         LrqNOSoqvspnUQ71HlEgfWGP3/zRZYggil+6EDnIOzwDF/ovplsQ8etu8h8H8n63t1cq
         dbjw==
X-Gm-Message-State: AA+aEWbFChh2RVbDxvEOKIZa59UnvRY7PIK7MfWo7saTHPrYxbMHYcFP
        TBA3zipUDrBGuX1ySQrjZzM=
X-Google-Smtp-Source: AFSGD/WF6YbeRwY5SgpgTlSCH9v0WMe4G9RjhUNENVGJDMQR+TtGr//G8yYy4sjbCxXSh7+XPga6tQ==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr7529565wrg.52.1543005686142;
        Fri, 23 Nov 2018 12:41:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:25 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 9/9] staging: rtl8188eu: cleanup lines over 80 characters
Date:   Fri, 23 Nov 2018 21:41:06 +0100
Message-Id: <20181123204106.2284-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup lines over 80 characters by replacing tabs with spaces
or adding appropriate line breaks.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index b048a3b633a9..714f7a70ed64 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -324,7 +324,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 		(d_cap & WLAN_CAPABILITY_ESS)));
 }
 
-struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
+struct wlan_network *rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 {
 	struct list_head *plist, *phead;
 	struct wlan_network *pwlan = NULL;
@@ -413,7 +413,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	plist = phead->next;
 
 	while (phead != plist) {
-		pnetwork	= container_of(plist, struct wlan_network, list);
+		pnetwork = container_of(plist, struct wlan_network, list);
 
 		if (is_same_network(&pnetwork->network, target))
 			break;
@@ -451,7 +451,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
 			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
+					 ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
 
@@ -469,9 +470,9 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			list_add_tail(&pnetwork->list, &queue->queue);
 		}
 	} else {
-		/* we have an entry and we are going to update it. But this entry may
-		 * be already expired. In this case we do the same as we found a new
-		 * net and call the new_net handler
+		/* we have an entry and we are going to update it. But this
+		 * entry may be already expired. In this case we do the same
+		 * as we found a new net and call the new_net handler
 		 */
 		bool update_ie = true;
 
-- 
2.19.2

