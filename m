Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B6FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BB820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BB820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbeGWNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388261AbeGWNjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BCCA59F9E70DE;
        Mon, 23 Jul 2018 20:37:54 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 20:37:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ilia.lin@gmail.com>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end of_device_id array
Date:   Mon, 23 Jul 2018 20:34:29 +0800
Message-ID: <20180723123429.20040-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure of_device_id tables are NULL terminated
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 29389ac..efc9a7a 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
 static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{}
 };
 
 /*
-- 
2.7.0


