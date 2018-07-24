Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2980820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2980820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeGXH3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:29:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388296AbeGXH3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:29:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C03CAA8061911;
        Tue, 24 Jul 2018 14:24:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.382.0; Tue, 24 Jul 2018 14:24:44 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] regulator: bd9571mwv: Make symbol 'dev_attr_backup_mode' static
Date:   Tue, 24 Jul 2018 06:32:59 +0000
Message-ID: <1532413979-187684-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/regulator/bd9571mwv-regulator.c:220:1: warning:
 symbol 'dev_attr_backup_mode' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/regulator/bd9571mwv-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index c44613b..274c5ed 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -217,7 +217,7 @@ static ssize_t backup_mode_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR_RW(backup_mode);
+static DEVICE_ATTR_RW(backup_mode);
 
 static int bd9571mwv_suspend(struct device *dev)
 {

