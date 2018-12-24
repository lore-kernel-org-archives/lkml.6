Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2285C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B8217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="J28AuV6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeLXAXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:23:52 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38840 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeLXAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:23:52 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Dec 2018 19:23:50 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B238D36
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 00:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qTYpaSrhYtJu for <linux-kernel@vger.kernel.org>;
        Sun, 23 Dec 2018 18:13:56 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 866505A8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 18:13:56 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id m12so10527744ioc.16
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+Rh8sGNEq0TCBFXNoqGqgroUg8M8uSZBnhZFj+cnZRg=;
        b=J28AuV6UsP2B6y4tLNSL224TQ7BdIyolzkHoxuOyQm38qQi26YKxbF5DxmBt0C2O4N
         qapOtBfC19brr44MOBYmB7e0vz4rLitsP5DiqDLLeUrHiqu/97sS/8rv+VzgjjUeCu2j
         Vz4oQakeIbDg3A3izWSb8nfEch3O5xSC8ke2RN2TyjFj9YRWaBoOxj+xG3trfELtVh2A
         Ma3Y5ccFblS5q7YHiahtcj5wQqBebv7PeXLZ9xApSM7Gl4FYnuRRH8zNOepbimLB+cTm
         vI6XEO9bBo0kp08T5gGOZD+lxM5k0kiP/a2Z3RnjTOOFQafDKmqL6T7kucRO2WlP55u5
         OOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Rh8sGNEq0TCBFXNoqGqgroUg8M8uSZBnhZFj+cnZRg=;
        b=o5h0sIVdxSHh5nOMAQlGdXRvp4LZkYW1rVylGKEZT0sslrxeyzFroqI6JslVqHFiKQ
         IQrGtNqooifHkPl+yK9nfcGri+AGGIGXv9fUw2Gyf5bDLlJ3cJDxGwEio4QKYhm+2bRZ
         4MtEAWT8UqbscFbubcDj8Zr7Bo7jASl4uIltfVg/B8aNsLOG0VxWNe3dVB+Pkrnq2TTP
         NLGwTdtkCKyvwFe6UeBVkfetFm2qhpCub47DHvLuwSdalavh4za8yab+tx89bCBLPc4z
         KkO05rbb37y75D64E/IEX8d0gqoK12zHbxgXItZNYlpIxECw60oDNlBV4FxGwdyfT0Mu
         IFQg==
X-Gm-Message-State: AJcUukeFefgCnJmV2u2XUPc8XxoirrPIh4raLv9kl3RYNvLsaulaUek8
        G3ITq1Zj+MtwMdDnl3W51ioA6eWOcTCssw7EknlvK0Gl/W/raioWOGyz/f7S6dN/ziNVUw/NsRN
        e+TNC7YwgHrb/38LqJH8zCoZgdKyq
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr7219478ite.123.1545610436050;
        Sun, 23 Dec 2018 16:13:56 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WAYh9sVhoGy/HBZsnc7LLcxxShuwdZVZd9rqXNQM6z5Cyl9Zv5o55vo4QmETDOQsIM0pOnYw==
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr7219465ite.123.1545610435797;
        Sun, 23 Dec 2018 16:13:55 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id i78sm9302671itb.6.2018.12.23.16.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 16:13:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8723bs/ioctl_linux: Add a security check to copy_from_user()
Date:   Sun, 23 Dec 2018 18:13:02 -0600
Message-Id: <20181224001303.9032-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the return value of copy_from_user is not checked.
extra is assigned to u32wps_start irrespective of these failures.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index b8631baf128d..9992caa8c839 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2577,14 +2577,19 @@ static int rtw_wps_start(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_point *pdata = &wrqu->data;
 	u32   u32wps_start = 0;
-        unsigned int uintRet = 0;
 
 	if ((true == padapter->bDriverStopped) ||(true ==padapter->bSurpriseRemoved) || (NULL == pdata)) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	uintRet = copy_from_user((void*)&u32wps_start, pdata->pointer, 4);
+	ret = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
-- 
2.17.1

