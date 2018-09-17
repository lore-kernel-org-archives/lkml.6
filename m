Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A89ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642320693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="orRs2nZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4642320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeIQIc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:27 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbeIQIc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiE2oacbkq6stPOHb33LVTjyGjPngWuWt6vzS0jDSfw=;
 b=orRs2nZ5T+XLqQi9AtyZUQWaIDxrwt9Mg4NZoyogacFD+HLHQCP7f0TqASFC70PqPAk2IFKhnu8NXh43MhkFL79J7hsN+1E9rAQIdHck0Bdq+v1hDqu4goTQfcwtqvGT64AEf78v+jSb0XOuCzKAZru308KVB7DM4uWQF/zMloY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 20/43] usb: wusbcore: security: cast sizeof to int
 for comparison
Thread-Topic: [PATCH AUTOSEL 4.4 20/43] usb: wusbcore: security: cast sizeof
 to int for comparison
Thread-Index: AQHUTjM5RQFqd1FaAUunDVoisp0Nlw==
Date:   Mon, 17 Sep 2018 03:05:01 +0000
Message-ID: <20180917030445.484-20-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:CkL7kUtjpuIxYxnZqMfKxmHzE5NKIyRUgidW5cO9U4y4lTLwNptX+Ud/1oG1UOGTZj6CjhSlFbVtff9q5c8yizjFWBI6/7RDu138lMxeK7WH5wSlc20fTJhvz6BtZOrrTotle9JUgdTaodgaraO64xSvE92RCdrybemwW56HnGyfwG5spoQ0F9ADDA7z1fEfXCjpIB4MdTonIcmUxgf/rmwKocGukTZL+T8CAnIWFLBiv+Xl1NrPmVU/vxO+YfJJOlJTZua+0oA6MHFeJI9IjhLV2Vz6ueBpfcbzkYQ88ZvgL32vFToLmqbiSyenoCuNtNY73h05mKydHUOpvFNYv32+1//TQUeJtwOlPdNFlVswqxDCs58p++qWqkeI3r+FuKRfS7ZuVroYG7l7TSUXMki+DKeIPG3sAQoBuwR1OIUNQAIMGGbbStEa/+bIyIgToY1UkJnigvhkQDXuZ6+pZA==;5:7THnVAFocXK412fk1w9/PWCKJ0U9cNztiesiuGFMRINfda+i80+xaWo2aFCKAja1mGUiExTLyBogZROYgMPsWCP75f3fVebWyeKi45oMgpFlPmQVCHwKfoPTWqgKjWAE83M+qakUQKZYWD9StPCL9qC/fOsdTx3qKg6ibeKkQvo=;7:lVBYZaAyyZnnKu6wLt4kUImLMyVAaH+6bp+bKuUe5+TW/vRNFaijh0bGyP6ShsXSnGFcYZf0tC8F/rCn1aVYbtQZUOai0s802ZbNOLQNsR0/Xk8jqC5yhXTJMVAQh27+orbmLuBK3+mU35l33JQlg6DIukQDw7rxALIHifsHIDDnWWN58n/v2vHbYJ0w+6kSp7PjS3K7jhetukDlqCFnorhfcfdCLKfhyg1Lezok3FoElKJDXtLmep4anftwPNKU
x-ms-office365-filtering-correlation-id: e3d046be-ebcc-4ecb-a498-08d61c4aa804
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759119B578B224ED531898FFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(7110500001)(305945005)(7736002)(5250100002)(2420400007)(6436002)(15650500001)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(10710500007)(6666003)(6486002)(6306002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8D8PiyL/Fw503noazm/Wphk5NDnHTK0Vsy1DQc33LcjwKZyId+ljP4+NumsgPNPz+9atdepThbw96ZVYSREpQFBRZ2LwKGVcYMxItFd4iV8e/gQSFvRUXjU5A7/sb51I2e8/aDio8bHgsBeEoH0/JnL6nv/6xI8h+7OcATJsVZodRS2jDkIwJk3EnWpj7axITFbofRXV920LyDU2ozcqhQhUe4zIFDyS//68gWn2eDXn8bl9hQC+jE5/z6veGTKpy7fK/ZYcu7tZSQdRpwS5qeDqFICnD6r/tf3zlLyiNSYiHEbL1CMFmEcJrCaP/9AYNvPUg3bScJfnXjo9Rcohc51kMVypYFYG4fGfGPSrr3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d046be-ebcc-4ecb-a498-08d61c4aa804
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:01.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index b66faaf3e842..4019c11f24e2 100644
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
