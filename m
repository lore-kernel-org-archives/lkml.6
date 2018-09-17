Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA56ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014912147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ipnagu9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014912147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeIQId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:28 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731584AbeIQIdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k4aG8OPs1unbzzK5j0/7HbBaOSuH1fmo01Kghe9gEg=;
 b=ipnagu9mNmuVw66LqHZIOp8Qy0KQxaeN8isefmW7b+GTb15iVtN0sVjer4tOyvtElhXt7H8uQmtIBaG9KsTzTXs8XGh2neU+1+CNcCR6oPUN/RyYT0a92BPM51Diez7Objysa6O9FCaVrXgY6c7edu/lp8wsH18pSfpMZuzln84=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 11/29] usb: wusbcore: security: cast sizeof to
 int for comparison
Thread-Topic: [PATCH AUTOSEL 3.18 11/29] usb: wusbcore: security: cast sizeof
 to int for comparison
Thread-Index: AQHUTjNSRy/7Sub4C0qlEx9c2YypVA==
Date:   Mon, 17 Sep 2018 03:05:43 +0000
Message-ID: <20180917030533.592-11-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:2g5AeZX/yd3Y7uLyJWZYj5w8N2adVF4vsPapJyU/llL63s2gCj5rHYZbdIPSsOH4gGOCl/fu3O0lGjoF972j1eMb+0ZhZAg3SEs357+Bz10SS8GYd2CxBqyMaM22xDE77T0sKDM+YFnYdCNMrkeVqSJQwu367ZgeyRD0aWLKJuXRsHeQ5ojsg30kFu4tDb273edzUPOfagaH1kLPziDkkiN0b14hrWZ/KQoIfN+U8xG8WgwynHfuv3gtiID0sr+Sj4EOxw3yD/DFwKq7XK5NsCRS8j/GPYodLoHMMGRPM2P9CVOUCsvAMBSZC+lOxEtfopowuiVMX/alneBspQhxBCH2YpmyiCpSdISWivTCSt3JZFvAeQGjlNNdCVa8v4IXk9BJ9Te4dn6upXTEoX2uilcC8cQkFxCwPfkOV8mWxdI9/RcsnyZyUYr7JYUl/4Frn0kote/hYS6KC9Q6lq90tg==;5:ou3EPJYmUusg/N4iKjqwkVBSFF082lFKAF5SBxDrTQEIP1/tbAOewtlZdNuvnst+foa1N7LRH0GWJfBQhcSHLNizqV0OrySU+mxcHqZUs7TrmnL8fGWMjQnFU3nEnLFOFKBK4wuTqcWaflzgw2b+j+VaHyrp6LWAJcLHfbMaL6g=;7:QB3eAiMaCVHXPo0c5wEkmJTPgOMxp9HsJxxWu6U62ILQ37HD7jeSBXMYcoQuXmkPCprWivsOxe21FcJHC06z+yShSKQoTRAjbZuAaaRiQYg0y4dAiuW0AlSwKcQeRrdDaleVJ6leCIagly/3TsVT7zLSOcHXrJjYCG+Y4dvIY3o7sLGQ5d4fhhjt+FyNd6QoU9xBu5vThzNVqaWT2ilYOquXPKUYzt7dCSadBPJQlJpMFXcznTbjr83W+Tn3qO7s
x-ms-office365-filtering-correlation-id: 487b358d-3bbb-4380-36d0-08d61c4ac157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839084B0A2031A9ACF0E8BAFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(10710500007)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(7110500001)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(15650500001)(2420400007)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7LFdxRcXmCjAcBrB6iMoEj7hNajK/cUEe15/Ug3WK5aeTZUwjYtGRuYieMqkltwIUPbbvwEVKW66DK6s3lcErjjHSWfX2MBJ/PLXAI8KglqJ+ACOZj8b919jQkxSRVvtuGmXr0LGPHuYP3TitiEgtK+18sXJ0cYJDddnLR+ATe8vtjaPpyTCxCzNFM6E5iZFf6mEz5YEmUcH4qy7L5X8y8flWJr3X79C2+YY6HExKhqLfdmu0y2ycUmjfFpAdEaOb01Kqr4JNygIAkOt1OFyU/CjOC5XH9ItrRWPEuXjxhOQzQyuBLthlY29c9AQTGOEuYE5YM9O7EBB1q70imdL/C+h0LTAPQOC8xrc18Og43w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487b358d-3bbb-4380-36d0-08d61c4ac157
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:43.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit d3ac5598c5010a8999978ebbcca3b1c6188ca36b ]

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.  usb_get_descriptor can return a
negative error code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
int x;
expression e,e1;
identifier f;
@@

*x =3D f(...);
... when !=3D x =3D e1
    when !=3D if (x < 0 || ...) { ... return ...; }
*x < sizeof(e)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/wusbcore/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/wusbcore/security.c b/drivers/usb/wusbcore/securit=
y.c
index cc74d669c802..63ab92af2473 100644
--- a/drivers/usb/wusbcore/security.c
+++ b/drivers/usb/wusbcore/security.c
@@ -230,7 +230,7 @@ int wusb_dev_sec_add(struct wusbhc *wusbhc,
=20
 	result =3D usb_get_descriptor(usb_dev, USB_DT_SECURITY,
 				    0, secd, sizeof(*secd));
-	if (result < sizeof(*secd)) {
+	if (result < (int)sizeof(*secd)) {
 		dev_err(dev, "Can't read security descriptor or "
 			"not enough data: %d\n", result);
 		goto out;
--=20
2.17.1
