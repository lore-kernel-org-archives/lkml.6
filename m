Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF998C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E0B20853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VizzAh+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E0B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJORGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:06:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42375 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJORGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:06:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id j46-v6so20654582qtc.9;
        Mon, 15 Oct 2018 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Dnanha3D4dCUytghZ+vyI7OKj4lv5a0P6ozKDyoQR8=;
        b=VizzAh+EM8V0n0gRGxBt9zej01CvxrXr6NBDbGltlGIZPqyey/687EYELW1W1CeFfP
         1qm9CE+MyenAJqSQ/KmUBej4qK6LhrXhp9KQH+l5nJNphraxUtjkzbHC1ReT/wTg+WT2
         mqvQT+gITzyU3WoPAFfVJvkabF13GiKgZmSIqICyjjNayhIUOF1m1QWoG8aX6QkuFARC
         BpOCc/HIU1V8sS5Zz7dvdbOBAjeLebdjPi9YTRhpOy0Nib7Pq7BK289Qa2EFDhm1x2xc
         z/AcOA7mbluuC2YDqPjEyHCTwnJaYXgyEXRE4Qu5txXrHjJWTTLfvtdcFIQYaXixMhP0
         nuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Dnanha3D4dCUytghZ+vyI7OKj4lv5a0P6ozKDyoQR8=;
        b=TCDuH5ut01f8bx3Dprz5ryB36iVzp3a+jGK8vEaMHFCI4yKD+9b06G0N3DDOBEeiHv
         0mTtQc1W2llRkzQwWcff3P6HF6cISZ/Hv6YNSkmUAYdcOuRoyQGP0ZiaYNhI8KzBDOEW
         MiuABM0xJAY1Uw985Au6+Rnuc8cCc+3PqkcNK8OluLHddzc8hV0PYWMV/3VmzCBAMKPI
         pMrwE1A4Ol+tFSANw3xZLeZY2Fa5UAZurShYv+8FaPDyAiqGQiShLy03Dxc70GuQg6XI
         1kfpkzoBxRnQYA+dr0XXJ+4/tf53x53oAAddrCf4ihg//FhYaEYxnh2YOXucSn1Edrgd
         ZwmA==
X-Gm-Message-State: ABuFfoizmNAMd2B/u5034ptWm6iP831tnGC2ZdGEP2M9PvcO938GEOe5
        44Wn4nGKd6uhMsENpxZn0HQ=
X-Google-Smtp-Source: ACcGV60RBO1NqsCbvm9vuE8VOzuF42cttRT+MOH5F2N0U9Uv9LXSWK7O3ftQ9t7XNp9JhqzQZ9Y2Ug==
X-Received: by 2002:aed:2a0d:: with SMTP id c13-v6mr15144190qtd.147.1539595299040;
        Mon, 15 Oct 2018 02:21:39 -0700 (PDT)
Received: from bdn-beauty.caveonetworks.com (117.61.165.46.access-pools.setitagila.ru. [46.165.61.117])
        by smtp.gmail.com with ESMTPSA id r82-v6sm10291288qkh.28.2018.10.15.02.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 02:21:37 -0700 (PDT)
From:   Dmitry Bazhenov <bazhenov.dn@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Dmitry Bazhenov <bazhenov.dn@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus) Fix page count auto-detection.
Date:   Mon, 15 Oct 2018 14:21:22 +0500
Message-Id: <20181015092122.10533-1-bazhenov.dn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with compatible="pmbus" field have zero initial page count,
and pmbus_clear_faults() being called before the page count auto-
detection does not actually clear faults because it depends on the
page count. Non-cleared faults in its turn may fail the subsequent
page count auto-detection.

This patch fixes this problem by calling pmbus_clear_fault_page()
for currently set page and calling pmbus_clear_faults() after the
page count was detected.

Signed-off-by: Dmitry Bazhenov <bazhenov.dn@gmail.com>
---
 drivers/hwmon/pmbus/pmbus.c      | 2 ++
 drivers/hwmon/pmbus/pmbus_core.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 7718e58dbda5..7688dab32f6e 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -118,6 +118,8 @@ static int pmbus_identify(struct i2c_client *client,
 		} else {
 			info->pages = 1;
 		}
+
+		pmbus_clear_faults(client);
 	}
 
 	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 82c3754e21e3..2e2b5851139c 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2015,7 +2015,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 		client->flags |= I2C_CLIENT_PEC;
 
-	pmbus_clear_faults(client);
+	if (data->info->pages)
+		pmbus_clear_faults(client);
+	else
+		pmbus_clear_fault_page(client, -1);
 
 	if (info->identify) {
 		ret = (*info->identify)(client, info);
-- 
2.17.1

