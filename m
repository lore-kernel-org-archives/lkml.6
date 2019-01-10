Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED38EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A9120665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfAJCu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:50:57 -0500
Received: from [223.203.96.18] ([223.203.96.18]:33959 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfAJCu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:50:57 -0500
X-ASG-Debug-ID: 1547087509-107606139f176010001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id fjQ69rVqfbcloQWy (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 10 Jan 2019 10:31:50 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from openbmc001.localdomain (10.5.21.169) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 10:31:42 +0800
From:   Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shunyong.yang@hxt-semitech.com>,
        <dongsheng.wang@hxt-semitech.com>,
        Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Subject: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
Date:   Thu, 10 Jan 2019 10:31:44 +0800
X-ASG-Orig-Subj: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
Message-ID: <625d047f0f42d30bb5ceb75ada529b5fa0c9a21a.1546918172.git.xiaoting.liu@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.169]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547087510
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1003
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8846 1.0000 3.0633
X-Barracuda-Spam-Score: 3.06
X-Barracuda-Spam-Status: No, SCORE=3.06 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65431
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide support for PSU DPS-650AB from Delta Electronics, INC.

Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
---
v3:
  No change.
---
v2:
  Change the patch subject and commit message.
  Drop dps650ab.c file.
  Replace struct name dps650ab_pmbus_info with pmbus_info_one_skip.
---
 drivers/hwmon/pmbus/pmbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index ef845a1310fa..e648ed8d926a 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -212,6 +212,7 @@ static int pmbus_probe(struct i2c_client *client,
 	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
 	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
 	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
+	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"mdt040", (kernel_ulong_t)&pmbus_info_one},
 	{"ncp4200", (kernel_ulong_t)&pmbus_info_one},
-- 
1.8.3.1

