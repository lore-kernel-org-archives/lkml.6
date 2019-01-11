Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE0520878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TXDJKDjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfAKSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41814 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfAKSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5QJ5058843;
        Fri, 11 Jan 2019 12:05:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229926;
        bh=iMs/08grKUKeyJNc16SBl6/0zIJKaQp+E/CCklxB6es=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TXDJKDjx5XtporYqu/JuqogHkUnYSvAHYhqhkevL2a7EimKDhcmExd9DcNGGt05NC
         R3BwoJzIdiBfDM8FNLZT5g2EQPjJbw/70jDf1wrC65x2DJRtDcFoeX4pgc8lg4KL9T
         yfV4kev16T9Uw051Jg3Apzxg6P4hTHac6Pn/IuPo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5QMn022391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:26 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:26 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:26 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5Qmo022544;
        Fri, 11 Jan 2019 12:05:26 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5PU07710;
        Fri, 11 Jan 2019 12:05:25 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 02/14] staging: android: ion: Remove empty ion_ioctl_dir() function
Date:   Fri, 11 Jan 2019 12:05:11 -0600
Message-ID: <20190111180523.27862-3-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is empty of real function and can be replaced with
_IOC_DIR().

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion-ioctl.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index a8d3cc412fb9..b366f97a5728 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -31,23 +31,11 @@ static int validate_ioctl_arg(unsigned int cmd, union ion_ioctl_arg *arg)
 	return 0;
 }
 
-/* fix up the cases where the ioctl direction bits are incorrect */
-static unsigned int ion_ioctl_dir(unsigned int cmd)
-{
-	switch (cmd) {
-	default:
-		return _IOC_DIR(cmd);
-	}
-}
-
 long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int ret = 0;
-	unsigned int dir;
 	union ion_ioctl_arg data;
 
-	dir = ion_ioctl_dir(cmd);
-
 	if (_IOC_SIZE(cmd) > sizeof(data))
 		return -EINVAL;
 
@@ -65,7 +53,7 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ret;
 	}
 
-	if (!(dir & _IOC_WRITE))
+	if (!(_IOC_DIR(cmd) & _IOC_WRITE))
 		memset(&data, 0, sizeof(data));
 
 	switch (cmd) {
@@ -90,7 +78,7 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ENOTTY;
 	}
 
-	if (dir & _IOC_READ) {
+	if (_IOC_DIR(cmd) & _IOC_READ) {
 		if (copy_to_user((void __user *)arg, &data, _IOC_SIZE(cmd)))
 			return -EFAULT;
 	}
-- 
2.19.1

