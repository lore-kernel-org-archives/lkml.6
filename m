Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A46E215E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A46E215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHTMvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:51:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42726 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:51:10 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LpUcU-1gMupL33uI-00fQRb; Mon, 20 Aug 2018 11:36:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: ngd: mark PM functions as __maybe_unused
Date:   Mon, 20 Aug 2018 11:35:37 +0200
Message-Id: <20180820093605.3760472-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:8Akwv0/LmdnmR3g7x7gqBQW73zi3N98rj+ATJoxknTi//9BQdux
 vYp3UIw9HuQ5U1F+A5jbG+PXfdZrhV6lLkWuBwoh1VUblK79wwZYby0pkTolk2pQFpcIfp9
 eizndm3LaPJziM9GYBO9lzWMtYy4tIN9wZ2WehoObAxElGCDGR7vKBTguQViXC2k61802zb
 8+tZAMllV0R9QRdC8L5lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S90ofa/Kg8s=:6JdmVUpBXFL4CX6QVw+vKt
 uqr5YvIh3LODR12zBmd1D53BoUHXvs6EFo9gsRa1pKB0sRtGwL85MYNFbKsyp8X9eMpI9lLsd
 uR3MpsqWEuJrvkQAPZSyz0kojFkdg5hAtTUIFdQNxYEImA+bsghyxVDU/Cq35qLibD2joKEZN
 CBYfzL3mVtKJQZKbcq5Vz6eK5G8yVa929kXixyGz9EekfAB/pHOEZfw2TJbcCX0MMLhchAqga
 Jpr/4csWzLsC1CU0fcRdGjfHTZP5xHEARh7CCXi5teUQ3ANASdEpJkVk5LpUV7uLNrFYuL/KQ
 8YIWC5qx2C8uuFkx4L+dQ3cfpRqMdG8as/HrJB0ewGiRNGTh0v8fwwfnFLA0STSwtfFipkHGX
 Y26SRscfmXzu0HrYzGaj+MBxB+gFXb//hQkTEQ0FbzV98YA6oQjUJVKTK2bQ6KAlYQGBZWMhw
 mro0lizrL6WPMhJS4ljDm6Z0VWivCdf1+Ox0K1QWuOlxWgV2HP5FWVTq8Jk/khoGCz1hKHUSi
 ZQpDiv+C8l5Z9MEwpWOuUavqC4h03TP02cNuXyNoe5LSIOYC1ZTSpSXtZM5PCcoK2rC37AgzZ
 bEx2W8aBpnWxbcSA3s+IQYUltE1wrYwXr1F9IvOyZhkn7WaxKR0n1qAyopr7T9zH6i2Mkgbjc
 lQLEdekESJqmuKurb5vO6UdohKkSnHVBqEyZLnpfFfF+kssRYTcpCQHhDx22ZfYLWjPU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_slim_ngd_runtime_suspend is protected by an #ifdef,
qcom_slim_ngd_runtime_idle is now, which causes a build time warning:

drivers/slimbus/qcom-ngd-ctrl.c:1470:12: error: 'qcom_slim_ngd_runtime_idle' defined but not used [-Werror=unused-function]

Marking both as __maybe_unused lets us get rid of the warning
as well as the #ifdef.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8be4d6786c61..14a9d18306cb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1467,7 +1467,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_slim_ngd_runtime_idle(struct device *dev)
+static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 
@@ -1477,8 +1477,7 @@ static int qcom_slim_ngd_runtime_idle(struct device *dev)
 	return -EAGAIN;
 }
 
-#ifdef CONFIG_PM
-static int qcom_slim_ngd_runtime_suspend(struct device *dev)
+static int __maybe_unused qcom_slim_ngd_runtime_suspend(struct device *dev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1491,7 +1490,6 @@ static int qcom_slim_ngd_runtime_suspend(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-- 
2.18.0

