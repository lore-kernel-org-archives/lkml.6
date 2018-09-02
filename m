Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DDEC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0627D20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iEy7BeCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0627D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIBRan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:43 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:45024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729883AbeIBRam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPkunMDu6p1v7/2wbXHlMi846EvFkzHGIGbWEZkpDSI=;
 b=iEy7BeCgPuQUAFcLmDtR1irlKeMHne5PHAmjXNTMhKT/x/nWE/P3gy1jgqkYBjWf5TWVmdIU6qrqH0Be/6/l9VEjB/l2p98mp28KbEh8dKLxQ2xZHHuDCumATH7nc8NfYTHereiEW61mDhgrVgPxFMaCrpBH9wMZbmMMRzeq6Ok=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 38/62] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Topic: [PATCH AUTOSEL 4.9 38/62] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Index: AQHUQr7uHDwhhcTwUEacnuQXAqNoNg==
Date:   Sun, 2 Sep 2018 13:14:51 +0000
Message-ID: <20180902131411.183978-28-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:9v4c+sDMScZkAXYtq50c/Gn3KB5veZg3gjNBcOmffUzW2qCE5pL11mkE2YRKaRsYplGwPNdgriEUJeOJe3QKnR0KG+1gnVFiEfCgEtpiQSa0TTeX8XzTjVrhmq7kv7qrsvAHw9gWHxlOtm6MOqgLrWN2oTSzfRHpDskHT5k8wEgEYmUMS5BHHmLfnoxCY6Fr9NS06TxQtIizfep14tvY6i/3r6TOAnBuW3PjmiHsuEmeJuhMfat86F27e9orjQ+HEDVpg/iOv6wkC5wAyIa8X/CNjclk63rfjXoTtcpj8ASdnOVqgK4CjW8YToOoVMc5VhF6+ObH/wa2i42tmTiquu9EHOWhTnlLVmAqmm99UBZl8mkLAHa3Q3wKWSmos4ErqREzg7rRD+l9okrK+ClO4P1Hpqo109jafn8VIwZXZ0xlLQFKwgfA57zzBz+P4D9iWDqfx4H/UVA3AnizWoMMhA==;5:4KQMRTIKodsZvcPWYohc0WIZhDLBw6UMaTaSVOmwBlZxZIVSYPw5Ghktf6QQc8xOLnOoJTkARnCDhR3dwiCUScWZUmv1GaoFmFjwU4FUFnIVqf+vR6gEiJM7ZbjMqKzNV2HIE4x6LkhbKpXOTOfo8Dj55QC1mMxhviWO6dX3cs4=;7:mEE/6sPkEG7mCZjX/sppl7hrhe5jiPAf21C9fUZE5S0QIdAuCYKDaF81l/NBFuTs3LFHjnEPtptL5zm6eY8devCnvh7wm3rs01Ig8ELqta2YvkBbmmG3oIvqyOhcn4//vh1BoRIDjmAcVQrGQ2T0E0i3bHluyztqMjRid81JsK6/6IbYIS+jTAftDnVHt0f5wGELA8RNCfbgzoTNkNg1+Aqhl64tNEUyDjZReKwIQVRXw24o3guSwJvTMjqtBhW2
x-ms-office365-filtering-correlation-id: 36ea4652-71ae-4f03-261e-08d610d6116b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07410E6D9AED1F7F703B567CFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1EA8uFZ4zSiHFpglmSOm5qr2/+yCpFbn4gLsBvevMzNpDMdBmRRkjymBu3DFz9wEGJ7y09dNOm8FTvwbHCTCGmKzS4bteUC14DeCdW8MhQ67Ilzw7hBBLk7+WlCUKRJgwYdtHkDji3tFa7ZV9UxUZu8V4biCl0P5iNDY6kUXVbTiFvhj5PnLCJZ/hbTwOMp9cY6Z0tXyCfA9mXXpBb+d+YPbuy+DKLf5rI7cNUA7YKA/S9Pv4b98XhVcggwLtOWpQapUzFUcvk8qSZCkh3SYQuFGtr22TbeoTOCrRGnK8Xo/vcuFdhB0Iqn7jPRDACgE81m8lq17djSfYfvLe3HzYM4R6Fv9RH2qD9/ycrzUlso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ea4652-71ae-4f03-261e-08d610d6116b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:51.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 9a5094ca29ea9b1da301b31fd377c0c0c4c23034 ]

A sysfs write callback function needs to either return the number of
consumed characters or an error.

The ad952x_store() function currently returns 0 if the input value was "0",
this will signal that no characters have been consumed and the function
will be called repeatedly in a loop indefinitely. Fix this by returning
number of supplied characters to indicate that the whole input string has
been consumed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: cd1678f96329 ("iio: frequency: New driver for AD9523 SPI Low Jitter =
Clock Generator")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.=
c
index 99eba524f6dd..26caf7cc1db9 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -508,7 +508,7 @@ static ssize_t ad9523_store(struct device *dev,
 		return ret;
=20
 	if (!state)
-		return 0;
+		return len;
=20
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32)this_attr->address) {
--=20
2.17.1
