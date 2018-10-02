Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7DCC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00C3208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00C3208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJCD4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:56:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeJCD4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:56:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2o9-1g1hJF3fRN-00CNds; Tue, 02 Oct 2018 23:10:56 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2o9-1g1hJF3fRN-00CNds; Tue, 02 Oct 2018 23:10:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: ina3221: mark PM functions as __maybe_unused
Date:   Tue,  2 Oct 2018 23:10:47 +0200
Message-Id: <20181002211054.2654746-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:AWAUVauV1leeCsuY40J7OzBwYmEDTuCejW8uq2wJywkpRoGcnqr
 NJ3c+dsRJTzJo9S+CPFgVdZKWEhUs8jrd9bHReMmg6jcQFZkACZSX1m1QAEicqFXcerKt/O
 dDRuVExWpmrgxzMnV7JtPZvOsAQHzkoHzgLvdSbyiCc+t5fe1m6k+gOgypE5kSBLtIER6cc
 a/nNEAEDw91pHfgnFHXYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UnAOkePO3Q4=:Umb8hOZsOpS/uo+qO66oQP
 9za/4WRUYeKeKMgUokRYtAWzXWaow7wJ3CRtYalqS7oUXzm70bIwhoCGFyGcWGh9KD5hD4cIr
 qyTj3pi95G56c3QfQ6ZNL2F7aExSsmuRgybub8LTcngQjOjOdbXokO7q6W6Fm9dp5LRwfQzoo
 JkUZqWsQuaXHGXuI6+YAHrHuQWmlj8Nvzr8pzi+iQKc71eKw88E3wQCJrKWFAtmzy8F64QLKK
 C7j8ljnBmNu1s9FvjmCBbSbTbiGxZq9H27/dlmt/qI/gpdZPDC9cwgq9GOVsWWauFlQvdl1+j
 ngMjo8iL272aZ2kuxHFgy2xR0RD39pzbGCLgpko/QAD7f3lZig9bgPJjddUg1mHUaQjRVwC3Q
 62R/PBJuUbHUM6SMxK9zqBmDgIWBdugBWawQemuVbPOzWI/eMKtiyrgMvkLonhBXA8T7EUVSb
 2mGoZcGlVNIndFNKNXT/AxaCZ3m0+/dvbnyi2CMBk+gYI7VMiscAK8GcI9wWEE68bRfkk3Q2b
 tn9cZkpRAJCrt51FJwlaaLCf+EzTR67gr+tEhqGXdaPieUMCOx4ubTIhQMtiOT3yi8G8uGrGt
 5gjTywRIdIq1ia2A/uf7Qfzkl4UouEMRLSWzE7BI34H1Q+Kuooy6Bq/qK/6/do3NBJmFKxOq9
 NPVxCIqxsB6483W4BT07EdAYBf9ZEbPDbfcqKpYN8GVizVcBYdw7+erAV8lq7tB98QgU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM_SLEEP is disabled, we get a warning about unused
suspend/resume functions:

drivers/hwmon/ina3221.c:451:12: error: 'ina3221_resume' defined but not used [-Werror=unused-function]
 static int ina3221_resume(struct device *dev)
drivers/hwmon/ina3221.c:428:12: error: 'ina3221_suspend' defined but not used [-Werror=unused-function]
 static int ina3221_suspend(struct device *dev)

Picking the correct #ifdef check is hard, so let's remove
that check and instead mark the functions as __maybe_unused
to let the compiler silently drop them instead.

Fixes: 7de1ab9dac8e ("hwmon: (ina3221) Add suspend and resume functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/ina3221.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 1e38b4c43fbf..8c3352910cc4 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -424,8 +424,7 @@ static int ina3221_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ina3221_suspend(struct device *dev)
+static int __maybe_unused ina3221_suspend(struct device *dev)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	int ret;
@@ -448,7 +447,7 @@ static int ina3221_suspend(struct device *dev)
 	return 0;
 }
 
-static int ina3221_resume(struct device *dev)
+static int __maybe_unused ina3221_resume(struct device *dev)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	int ret;
@@ -474,7 +473,6 @@ static int ina3221_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops ina3221_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
-- 
2.18.0

