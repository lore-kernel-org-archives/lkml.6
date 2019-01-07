Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2160EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07752147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PauB65Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfAGXVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:21:05 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58202 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:21:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0EBF6B89
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jan 2019 23:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o-iIjLqWCAlf for <linux-kernel@vger.kernel.org>;
        Mon,  7 Jan 2019 17:21:02 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id D0F78B88
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jan 2019 17:21:02 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id q207so1662477iod.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eEZZlwwZnonv8Jnbaow5N/PQRcwiKIViUuOqgowjw+o=;
        b=PauB65FyZlvy6agFVlBA7zkb7xNVKTORvThXAH58FMWI9P3eYhLLCor6W6l5hxSS23
         EwIRPkW4VBox6+NrNEfIx07TfwVI07V/HgFzoY0e8WZLYFwcnTfNFbwaK3IecXlRthUS
         /JBIEZgwTTy06vSKSN825Up6GrQHzvWJDaCUnsRxzP0yd3vpcYnmVo2Sp3i/CmrW/i4i
         LRvWPiakHKOaWEe02GI9lfkyWsLXoZe30IMHKIoj7cZptSWhO3RnOzo3upPUjoJXbyrc
         Qg1/GEksF+KzmtkNO0tSsky6jaIkG+xnIBQTs8GPDh2Rf/wkDOC7ojg7gW/gneM56rR9
         UUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eEZZlwwZnonv8Jnbaow5N/PQRcwiKIViUuOqgowjw+o=;
        b=iFMqCVSJZ0XPvHEb9qEolkYkkfQ2f/1Tg4Q5VY0CEJiHfrV61H3r/jJhvkg0xG5y94
         vp/ISu0Mk0MoiHSVyXGNSJO2Smi38AU925kGJ95vd7u10G1CWdY3emXxyzfmo7W9e+N/
         vxcKpEgT+I68SCTG5auOo3gnWoibtY04dwLj8TTFytn7qCzFD+6YGgNqVEMWquQ0q4F6
         aB6v32enMfqiqYOrWI66vOlslUTvyWfQdZYyCBeaXmVMtlC26Gf9RWSbPeQSAIi1WpwY
         zz6kj2SeBQKYhJl/ArjUb6/b4AeajoWmoOvuMLJDmyAlBT3W/+UG23x6oN/w4S6KWRwI
         fDrg==
X-Gm-Message-State: AA+aEWZF9AwegxbHj5C6mgltlitrQX+/KKu7Cp90LqTQqI89Zd7z8l6P
        hTbd2Nfxgo6gaGBmykRu/+N24y8Btldc9LPTvnDZ4FnduhOaVa7za4QzsEV0dD/fGOMXXWjSxie
        nRJoBpiWXujKgE6MdHos0yiBsNQ+7
X-Received: by 2002:a02:b424:: with SMTP id i33mr45795561jaj.37.1546903262344;
        Mon, 07 Jan 2019 15:21:02 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XCOXex0PJ2VVZMji46efYTJXXAht2pPR8Fnf7J1Ql7UzPk+2GEhfIZEmybSHlP89NzDdhBHQ==
X-Received: by 2002:a02:b424:: with SMTP id i33mr45795537jaj.37.1546903262099;
        Mon, 07 Jan 2019 15:21:02 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id t17sm18413178iog.34.2019.01.07.15.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:21:01 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] staging: rtl8723bs: Clean up dead code
Date:   Mon,  7 Jan 2019 17:20:52 -0600
Message-Id: <20190107232054.4742-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_wps_start() is part of dead code due to CONFIG_INTEL_WIDI.
The fix removes the deadcode and replaces the function with NULL
in rtw_private_handler. Identified as part of copy_from_user bug.

Changes from v1 & 2:
The return value of copy_from_user() is not checked appropriately.
However, maintainers identified the patch fixing the issue is not
required as function rts_wps_start() is dead code and can be removed.

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

