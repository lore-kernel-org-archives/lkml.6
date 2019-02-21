Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE9E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfBUDNs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:13:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:22077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBUDNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:13:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 19:13:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,393,1544515200"; 
   d="scan'208";a="124040098"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2019 19:13:47 -0800
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Feb 2019 19:13:46 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Feb 2019 19:13:46 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.102]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.253]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 11:13:44 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "ic23@kernel.org" <ic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Chen, Hu1" <hu1.chen@intel.com>
Subject: [PATCH] io: accel: kxcjk1013: restore the range after resume.
Thread-Topic: [PATCH] io: accel: kxcjk1013: restore the range after resume.
Thread-Index: AdTJklHsGhceer30SUizI4A3viRlAQ==
Date:   Thu, 21 Feb 2019 03:13:44 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A4C63F@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZiMzNmMTAtNmNkNS00ZGU3LWE2NTAtZjhkYjNiYjVjMWUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaHZEaktHTFlYY2tSUlZJK29cL1NKSmt1SFFiRUdFMzdvTVJucktmQ2tQSDRyQ3VMZFY0eUJaeFpEK01iZFhXQncifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

restore the range register in case kxcjk1013 power is off after suspend

we see the issue on some laptops, after system suspend and resume,
the CTRL_REG1 register changed from 0xc8 to 0x80, so acceleration range
is changed, the patch is to restore the acceleration range after resume.

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7506bd9..c6bb3be 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1340,6 +1340,7 @@ static int kxcjk1013_resume(struct device *dev)
 
 	mutex_lock(&data->mutex);
 	ret = kxcjk1013_set_mode(data, OPERATION);
+	ret += kxcjk1013_set_range(data, data->range);
 	mutex_unlock(&data->mutex);
 
 	return ret;
-- 
2.7.4



