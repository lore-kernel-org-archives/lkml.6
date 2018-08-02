Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865EDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B44321536
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tq0yvWif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B44321536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeHBTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50482 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3405123wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kdlb1psiWURE57dERNFKn+WuY2MBJzefboP4g6OAT00=;
        b=tq0yvWifGCtK1LXq8KPA18uLwFV09QHfd52gcnaOPw+TA0jtPRN1CeYhU5nGICmGIV
         sGBMRz+WlDgh9HSZ/GBcQLqQYgoTIrrHxAsHPHAA6mrsPR0WCOxr7gxWXncjf5y/qPLo
         N5B6v1i9CEZt7R99xAVY+cRfEZ9jEssgH1p0HXCTNR/5BVQiBerw2f4zhyh5KWU3SfRR
         Nz5jeBBS/h4J/3AbAdm9S7oekqJudZ2MuQmuyj7oHUWsYvERgjjtNd74J7aFWcou0jWA
         0YB0IM58hghB7UNLwR4xdgZ5aVWb5p15ydPuzoQ3SsxyP2jvsW4gkMRjmNQi47A2Hcq+
         PZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdlb1psiWURE57dERNFKn+WuY2MBJzefboP4g6OAT00=;
        b=i5A5ZgVWjqFmBLLlQtBCJUivMYTRjgC5P6x/fdKyaM98ElPtgCVqSvixUAaXCgqg1F
         ynLNf1wmgP7dw0oZC65HmFzU6fmDpha2sMel7h+xOCp0KPiGTtjz2Gk4Ej2v/k1F/JcE
         n2oc4iF2eUacOtXE00ioWBIV4ASj76E1I7oPAQGLqGTrSENpAVGlfCC+2XULAQty4/GY
         wdkYtqtG8bQ0E1sz4IsNozLF5hXE4sVFm7PI84PdtAcHlVZUaT2sDTALIFcNAgxv1kQ4
         4lHiO4CnK73L2WuFIx6QP0nMuVI9yj4KcstQPQ+aubTty1SyU2FrlTOWDc9/lehU5exT
         M5hw==
X-Gm-Message-State: AOUpUlHT0LaRqN5rzcI8UUWHfXSdmuS98i8htFESCuJ2n218jf98tnq8
        8A0mqd6GcEq2d408KdCOAUk=
X-Google-Smtp-Source: AAOMgpcLp1sH5bbxKa1vSR4lrjJx2m5Jzsv+B3QXSbgYiGXIbKWnR7c8TjvnblE2n9CfgIyuc8caTQ==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr2599080wmc.107.1533230322343;
        Thu, 02 Aug 2018 10:18:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: use is_multicast_ether_addr
Date:   Thu,  2 Aug 2018 19:18:18 +0200
Message-Id: <20180802171823.1571-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
os_dep/recv_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index deadf26ea2aa..6f74f49bf3ab 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -84,11 +84,11 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-		int bmcast = IS_MCAST(pattrib->dst);
+		bool mcast = is_multicast_ether_addr(pattrib->dst);
 
 		if (memcmp(pattrib->dst, myid(&padapter->eeprompriv),
 			   ETH_ALEN)) {
-			if (bmcast) {
+			if (mcast) {
 				psta = rtw_get_bcmc_stainfo(padapter);
 				pskb2 = skb_clone(skb, GFP_ATOMIC);
 			} else {
@@ -104,7 +104,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 
 				rtw_xmit_entry(skb, pnetdev);
 
-				if (bmcast)
+				if (mcast)
 					skb = pskb2;
 				else
 					goto _recv_indicatepkt_end;
-- 
2.18.0

