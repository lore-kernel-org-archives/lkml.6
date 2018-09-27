Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB581C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73353216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ7ji0TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73353216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI1DkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:40:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41136 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1DkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:40:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id j15-v6so4136887wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N3iljbGCPNiYIBPSRv1uIqJ8ZWYEWQD8ogsKLJE9TzM=;
        b=qJ7ji0TI9VJ8VYsx7/mDZCKmLlBWwwfo9yRC51lQ9yyS2QsGBFP3KAc+SCnUmvFCfR
         DEJMGJ/JtyLKxegbR5j/f5YBgK+wiCpuTXyI53ksoIiJp+z3ir1+ntCs9IPu9P/ZEshq
         AUOFDY3RHD64OqHoVUCCE7pJWx5dGMYEKXVICqsRAsz5wO9E7FP8wAbmKgezHvnWrpdL
         aGjie9HrNduokcOyvTchnmeFc7EzeRh6EjesO506/qR9pyCwtoKuf5is8Cht2G9Uc/0M
         W3Ii3L7ncZik7rS9vs0nbqSBmnaRWWm8EKUUXAPmlUXiXrToTKjXWQFPiep+xF03EC+I
         mB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3iljbGCPNiYIBPSRv1uIqJ8ZWYEWQD8ogsKLJE9TzM=;
        b=Qsm2kvxgFFl/n/DoLYVpihuhawldEbeS0gmElXtiYd+CVCmqu0KZ8zpzR746BQCajj
         rAPiw33CeK1us5eeo/zzdj5IVFX9m/Ug6nsbmebAT7oE8OvI4dvv3ywI9eXeD33Ni1na
         CCibpGM/+ssO09G37pvw8qdWA/BnkbgxPTnp8VPWl4cxJlZ6rQCIF6ZXOGzL6yP6BsMX
         voZEcYt/UC5CijSAR8VkGNIBPle9WW0TyDCmH+RghNWZcSys3ja7GU0h+Ytd7dAZOSMO
         ruylrfWNZwd5rwJWodF1K0ipXYSur0yE6vPV2/tWEh/sF3na6T2Y9MRtZUv0SCGv1ZPT
         INTQ==
X-Gm-Message-State: ABuFfoglAwEamh2jG+VMvgaK18TVOfTY50B1N8nIL47waJQ3gu7XWmTw
        LwAcjlGS50c+xiWhuYaw8gw=
X-Google-Smtp-Source: ACcGV60TmIq4PvahrFL6AhkXIL8GB2WzawDQLtM/CUDWgChatLVcR7GGYwfv+BpSgT5uicDrfN4Zvw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13-v6mr10304317wrq.133.1538083194489;
        Thu, 27 Sep 2018 14:19:54 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id w192-v6sm173972wmf.33.2018.09.27.14.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 14:19:53 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: Skip unnecessary field checks
Date:   Thu, 27 Sep 2018 22:19:11 +0100
Message-Id: <20180927211911.26484-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip unnecessary request field checks when the information element
pointer is null.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
v2: combine pointer check and length check & change commit message to be
more appropriate

 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 834053a0ae9d..4d55bbdf8fb7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2971,11 +2971,11 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
 		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (!p)
-		status = _STATS_FAILURE_;
 
-	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
+	if (!p || ie_len == 0) {
+		/*  broadcast ssid, however it is not allowed in assocreq */
 		status = _STATS_FAILURE_;
+		goto OnAssocReqFail;
 	} else {
 		/*  check if ssid match */
 		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
-- 
2.17.1

