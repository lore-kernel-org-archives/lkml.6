Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE82C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB620830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ih6S0dGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAFQVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:21:12 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:39902 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:21:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 9CFCEC07
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 16:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7v3X4UC8arsq for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 10:21:10 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 6E78F862
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 10:21:10 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id f24so46298193ioh.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/Q62Z1xRQr9tV1tpUA+AYPt9W0jrcCVnjC129sJMHCU=;
        b=Ih6S0dGKKOZqdXS0wY+BHG4lcDbMh73FuF/m+TyEpeFO6xJsMEGD0xCPQXnwgZ+eXe
         YhHso3KxYK8UxDvBV60dgeIdS6y9RkYw5VvvHxU5xZ/FA9fDnjLQVZXOBZ7ZSUG7Ch9z
         lB8d2DVZhz+gADzHhJSyy9qK9p5HGPxTZRccYRFJhCJFBNFXlBW8UHe0SAf74zET9ZJk
         y4vXNg23xvnC9J1r03g0Zcqb5ToACyAnr8UY41VgMi4dfrQEbS89hEj4DPNqRSeWbabB
         SqVIJEnegorLp0UMQp0OWUN0+tWVwm5nMV9Xm5NbS3nLFXO7uIODL9vBpfu5udO4pRWS
         WFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Q62Z1xRQr9tV1tpUA+AYPt9W0jrcCVnjC129sJMHCU=;
        b=JV3rEBi0hvzyL1xacGtlpMLBQfn9Qcn9MFaKKljvslr/3+XS7xl37B8BvWR3CHPrcs
         0hTCFqZkcThmJxee0MVLB0Gi/OXP/M24k1GvteoEY7eph1DB3sbaIjv4q4RaO6bkE7uR
         KyMdG88tagkuwGvuB14WSs6cevAuleGAgx1ofc3HL9nXjcKosu+iLd8bHdBtSNbIxwvm
         dhYc4SgefzZD68IpXbrkWXIoZullyS0gHbmJi7Qe1TSBSoAO7S+zGpntxT6sIrlwMc3N
         gZ1mnCTliVW4zIQ4lOwjbJR2SMaPoFHvDnPKvLa+PGQNMYoblMcndYhRXyja9FV28VaF
         oyCA==
X-Gm-Message-State: AA+aEWbZj32G+lcz8UGyK7k/8zetMphPHkkdahWOOmxrlqHB+aAPrEAp
        l9rwS8Z1NFT7nJXQmBK5EYGh/NnSdolyl2w8RjZbgyg5UpH+ZkLjDYs9Ya+7nngFYz9mwTdAxkd
        OhrcLyBSWqG8vAkxzV8g1abT+Dd+C
X-Received: by 2002:a02:c81a:: with SMTP id p26mr39713010jao.59.1546791670047;
        Sun, 06 Jan 2019 08:21:10 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WagIGYI/s0zS/vstjuS48IilWWI7dN0bf13yjyCPPzxAmI5qLR4rf8rVitYbHTljdUUs2ftw==
X-Received: by 2002:a02:c81a:: with SMTP id p26mr39713000jao.59.1546791669803;
        Sun, 06 Jan 2019 08:21:09 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v74sm4109687ita.27.2019.01.06.08.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 08:21:09 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Colin Ian King <colin.king@canonical.com>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] v2 staging: rtl8723bs: Clean up dead code
Date:   Sun,  6 Jan 2019 10:20:59 -0600
Message-Id: <20190106162101.9176-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_wps_start() is part of dead code due to CONFIG_INTEL_WIDI.
The fix removes the deadcode and replaces the function with NULL
in rtw_private_handler. Identified as part of copy_from_user bug.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 +------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 8fb03efd588b..2621c47f343f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2568,38 +2568,6 @@ static int rtw_set_pid(struct net_device *dev,
 
 }
 
-static int rtw_wps_start(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
-{
-
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_point *pdata = &wrqu->data;
-	u32   u32wps_start = 0;
-        unsigned int uintRet = 0;
-
-	if ((true == padapter->bDriverStopped) ||(true ==padapter->bSurpriseRemoved) || (NULL == pdata)) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	uintRet = copy_from_user((void*)&u32wps_start, pdata->pointer, 4);
-	if (u32wps_start == 0)
-		u32wps_start = *extra;
-
-	DBG_871X("[%s] wps_start = %d\n", __func__, u32wps_start);
-
-#ifdef CONFIG_INTEL_WIDI
-	process_intel_widi_wps_status(padapter, u32wps_start);
-#endif /* CONFIG_INTEL_WIDI */
-
-exit:
-
-	return ret;
-
-}
-
 static int rtw_p2p_set(struct net_device *dev,
                                struct iw_request_info *info,
                                union iwreq_data *wrqu, char *extra)
@@ -4820,7 +4788,7 @@ static iw_handler rtw_private_handler[] = {
 	rtw_get_ap_info,					/* 0x04 */
 
 	rtw_set_pid,						/* 0x05 */
-	rtw_wps_start,					/* 0x06 */
+	NULL,					/* 0x06 */
 
 /*  for PLATFORM_MT53XX */
 	rtw_wx_get_sensitivity,			/* 0x07 */
-- 
2.17.1

