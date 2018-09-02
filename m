Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85321C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB220837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OhkBFNkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbeIBRc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:28 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbeIBRc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz0jEB184iWd1Qy0bn0hZAGsAYA3YGrUgfrESvlx8vE=;
 b=OhkBFNkmLxO8oT2NPjpYB4N9d5CWY5sTRZItTbH0pFhOihSJJeRUjSft9ktlm3YDI0Ht1H3GbOZIeqfI3sXM/i5SZRf+G9oSpjejLHqElRFJ4aqmOJDAXnSGG1fk1dl0yQmezAwZ46zdy4+MWWppnABu2/Tuk/wULTzbS89OzEU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 28/47] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Topic: [PATCH AUTOSEL 4.4 28/47] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Index: AQHUQr8f8J4gVb4/o0KUhufZrTjphA==
Date:   Sun, 2 Sep 2018 13:16:13 +0000
Message-ID: <20180902131533.184092-28-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:iTs/shWK+JsEy6GX1/udvEC04CJRNoOIW7542wwH1XkihmfN2trL73aIPCZfAGgkpXtFR4Dut8dU4KtgyoemJ586/Qt6r7ybgveiZpTWxmKMPRiDCXbc1PyC+01sZPmFMKyHVRTdk/jS56C+3ZHzTibClrnWTg3lHfT4NSBYQwFmR+FDeG22fv6P+XrWtjV1ltIwyr3TBgnuox5vBAB4nnX1GxDCnc5vASXFgriCF/n5RZq11/UX9nQG0jPpaewfO++n9qO4B4leYDxlrTKUI6A9Lo5RrG3tt05oCED7S2bpNxSxTEU8Mfphla7wgKdgyG50CaHBj+v9pEQmLbM/ogl+zthUL32Tk2dDNvWa62j++jzlpNPEqF+EneyipOf3UF/yePhYfJUrmqupYcBrD/VJ1+AyVMSUqlNfgBKeU5oWKj3cnTQdzDDgF0zkEGtU3YNJzAzx8GAPf2tKOt5EVw==;5:48gAh58W/ksZaaAN+FZJWsWi617QsG0EPJwQWkwrcXwme4YHho9bCtux5KhDvnfcI5rlAAL3bfRmBS803BlSloT7oVDVEpddGJW6t8VvUwiGBQUUAmilCYD7BBQb478YnfEc1c0FlV9oO8R9eOl1vh90XrOxGMgdvnIWNvnnpks=;7:qbQlBC42p5Nr3Hmsf2Nwt2Rd57fT0nJsRyvmIkBHSUPL4bO1AXGMSQ1XfM/+heKCGCJw5iLpObhYbxhpB+fttFXghafZoxu/rgH5nDyTV61xGVPGNhNtg300NVEWfi6E61LscAVb4fC5AB0+PhaxMFt9latb7LG0qmvgAab4VD5kcEQJ2f0VhKeXs47Y/8AXvKA86fN6XTAV0tzaOixaD7HgUijv7OVeoEh37BjzDoz+aQWT18EATx6dNJ1ZCIB7
x-ms-office365-filtering-correlation-id: 35196ddc-0a6c-48d5-a85e-08d610d649b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062932447B98BA6CA85C7639FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 80d4CX/lXvH1y4V/JEFQL8v0zOwvOXeyKzIu46aIAhLl6etX000RH2O/7aG3LJr9UDvhXMehpljfnFN2MGQPGV3phx12ok6PU+4bc7Vo7VrJ1ITqqATsUYTxL+Ppr6ECBDrkNDtyJ/fL7OSVN1wiFfMPuOivG4X6MPNZL1e6zOCGXcogumIVUtbcedXqex4w8mfdlQwZAszw0ihLrT5HjlDDKIDmVJYGlViTwxlu4JJWpDQcVz/A+jPAokgmXpnJfXSCsAORPHAEkmbRQilE6hqxSYZ8q04VYsHBEgwkx5MYM85VKNHol8mjWXb+N07LqkM2e6e4Lt1zyhGI30BRPCYtoztxatfBbo+gQbZinUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35196ddc-0a6c-48d5-a85e-08d610d649b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:13.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 44a30f286de1..ea3c65366e00 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -507,7 +507,7 @@ static ssize_t ad9523_store(struct device *dev,
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
