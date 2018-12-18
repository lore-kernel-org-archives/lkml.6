Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67DC21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151473;
	bh=+SWDljD28IHnvkjfYP6C7tteAO4WliehamUM7h0AeYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gM93VeF/fskoJrfRseNRcNwiMyXI1fHawiLTe9gMNI5gPcxlboWhJSFDxsAHlnzSm
	 oJnUFOobP7TkgDlZ9wrjFD0AjvClaEF6c0UHxKCOJtV1lycvu4VxscLVNY8NRNKen2
	 DTfp1p/gCxFKZOfx1qhRcDHttr8tD6EEBtc7/7zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeLRQoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbeLRQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EE7218A5;
        Tue, 18 Dec 2018 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151215;
        bh=+SWDljD28IHnvkjfYP6C7tteAO4WliehamUM7h0AeYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0rkgxhjR0IZwnB1TRour7yL54GVyvqoD8ZXwXhYUmNg9AJGBRc/4YhTjJg1prcnp
         mTqO7qEj9zxYCPJccPMltePBDNbOvgxkJa+REA6l5ap/WCr8i35ZdTyzVl3SwJZbdp
         zZHHTNj5330lMhnyw/2hUU1XtiJVZHRAMBIuQThY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 04/44] slimbus: ngd: mark PM functions as __maybe_unused
Date:   Tue, 18 Dec 2018 17:39:16 +0100
Message-Id: <20181218163927.624364063@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 2e6ae11dd0d1c37f44cec51a58fb2092e55ed0f5 upstream.

qcom_slim_ngd_runtime_suspend is protected by an #ifdef,
qcom_slim_ngd_runtime_idle is now, which causes a build time warning:

drivers/slimbus/qcom-ngd-ctrl.c:1470:12: error: 'qcom_slim_ngd_runtime_idle' defined but not used [-Werror=unused-function]

Marking both as __maybe_unused lets us get rid of the warning
as well as the #ifdef.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



