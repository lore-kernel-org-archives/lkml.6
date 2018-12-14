Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC310C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EFA206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeLNWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:12:19 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbeLNWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:12:19 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mv3I0-1hOvqp0o40-00qwLd; Fri, 14 Dec 2018 23:12:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] slimbus: ngd: mark PM functions as __maybe_unused
Date:   Fri, 14 Dec 2018 23:10:09 +0100
Message-Id: <20181214221023.3878670-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GNKPCeeeEz26uJbtRM7gc0MoAF3J/yMkeTY15ugg9ZR34VsoVSz
 0VKVSfwkmxC9jw1gjdVesiNiv757xJnzNi93wiDAQTBRqefgOFs4VmnzwX7QezOHsLVjWkd
 WM1RYVJc2/8E5OlsIAmlBHt5frnjOrneQ/Drv0r6WZBuar3Zztw5ZXisMcPBQSQGT48EVfq
 mXsbo81AdNfyYAJCUepcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mSOC5O6HTCE=:clOJfzWbo27T4UpGKVDOkh
 1hkxFTCziPHNJoG1yDcLOUMQAsONPlu5+4UTN+y3UpKbNeXlkuVUKwJyn/+XByqh3NI8910Kn
 RqbD0V9zjk9A7kA14/HHFMijMeVvLQ8k1RmjLi7bPO1h7Wrr3lDMba0L65C6C85Y2iS2IsKw6
 N84/z7RMxyB91qmtwJzZEaF9FdUZaF9oicwkZUzKn2MvQ8+yatl1kWrvLtS69wKwvxZblxz8t
 ET7yYttpXJCbAsGGwysleRf0KTyiMQ8uEWLUtKgDEGl0ucPdhDGsmVA0IS2OBii68KqvMBlSc
 tRyP/i9YvtA/LOCcRi45IOzR7d7MugeQ1W7rmWIDtylUze6WQgCW+iF9rQalp9UlJK0j922PK
 I9zdPw880BRC/prt0rC3RVS/QKGwYrm1pLw9Mc45X7FqnAGaQJmpLBKm0M51FO4mi5NpYcEwC
 fYM0tBCXeY8Ygzq2zyiSK7E2ec29xluUDh/QJ74322m60zBwBcBtWQswcsWReRRUOGwvOXMxo
 /p3LttYjwMrX5XsioQsS1FSTNkFV3p7aKW6PNgDm6H7BUXoh61401HLp5NSFv8a3O2lLkJe2F
 NS3d2gP7nnGZGt4MizCQupAmaS3uGGxKyk0dph3zvaeMTKuVAIIQAkGS/SovDjRrrHy5y1fPr
 a4sCvhQaAPeu0IZScT7kTr/OAdodTkCgU8YMasAUrvrpeeH2nsILbjSKTJyIiqpdndOUy1qAP
 MUv8kHo5QyBU33/o1z6ON7IawSW3DyabBjq0DA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2e6ae11dd0d1c37f44cec51a58fb2092e55ed0f5 upstream.

qcom_slim_ngd_runtime_suspend is protected by an #ifdef,
qcom_slim_ngd_runtime_idle is now, which causes a build time warning:

drivers/slimbus/qcom-ngd-ctrl.c:1470:12: error: 'qcom_slim_ngd_runtime_idle' defined but not used [-Werror=unused-function]

Marking both as __maybe_unused lets us get rid of the warning
as well as the #ifdef.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.20.0

