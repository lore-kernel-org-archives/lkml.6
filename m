Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6130ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E50208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WMbLP85s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E50208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeIQIbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:08 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730739AbeIQIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwJbrGtcjt/qughVoKru4WcFDzPw8yoAx/Xs9QwoY/k=;
 b=WMbLP85s16SjO21xlMAhCP3YDFToAoEpJsGJtDFXEBGo5kmpxoNpkL3DP0ZNx6byE6+SR4JiefUIxHyHQBa5mjxSr1i5JoQzrUHQiobQZewilBq4cGnfbPKr1sV3AAFoz0v83L9CKN4zSw7CreER3uKiJTGMT9npN7CePcQsJ/I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 27/57] usb: wusbcore: security: cast sizeof to int
 for comparison
Thread-Topic: [PATCH AUTOSEL 4.9 27/57] usb: wusbcore: security: cast sizeof
 to int for comparison
Thread-Index: AQHUTjMUnt8QP0m6K0q+IxNnZeW2VQ==
Date:   Mon, 17 Sep 2018 03:04:00 +0000
Message-ID: <20180917030340.378-27-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:zRZrTZ+LqXq8IlgAgcJMpM+844AXFEYmVdI3xm6viApgw0dKAW1G6k90/HUWt1kEzxyggQgJxXiCzyMoKWj/lRl+ONXxfEKDxJq35g2r2LlWNfhAVYSxUiZJH2/2M5fL1B4KbSysbcBtGJ4Ov7HKFH2GlpGUfKSIABqdonRCDqx0lIGPcmYqovwTe2CtLXTFawCWD5ZJj2P3/yUs1os1raPW5ccBQD1+gcSU8Qxk3NIP+mPbSxX2tnwQ27LWfTHk9MuY5d2EBqx0xM6Hk0SWQa0/Cax8gs8Lr0kHDyWmA8K4YNY4IWZQrrGxjj0nSZEdiA2bEF7DQMWr9wti9uuADhzHqW1CGGPA7o2c635F2+S5yGZPnnc+R7yCRIkxAsVHfDGvuWj/QZ4glMQTwH6kUUnwlvyE1F965D0ZXr+c18Vz6D8sF2DuUEgwyERrt8BnV0OiqLRS74HWCGFTyfno7w==;5:wTxaLSJeS2FSV+njkAHuKY78tS0hXmzLNGftvpjrWoX5zTEqfEjoyaE2/XHAcQs474Jx8oDi3/Ih3utM83Y81/ZBCKRdgSJqpUYQRNE3C7GXZUDjudteCcxpQtArBQ4A88MEuc8XCrF6OyW7kKFxHJKGMjR75m8q2OHER29f0ww=;7:+H0o/PRo4ldQcRUXuG1ddzQhJm+D1GN4F3+tyIiMeGk5yjIOiyYcHPDnd95gVRL9PSKjgYHi0c3g/IQV2ZK+adtWlmYGTo2yndwrMisShiPeRcClhnTM8EpnAsjggVVJgPLlP/jMrFq364zKcqpGOzdwCicKtNqj7E+gkDvrpip9GGGbx6Haw5U4a567g0ROlnrzhB/mA2IcjIeSut3rvdjS+4IicVWIRHAfsLhij2Ks/vLDyDv8m0q4S+I8WOxy
x-ms-office365-filtering-correlation-id: 2cccf619-1252-403c-e773-08d61c4a7659
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07576494A1669BF90DC8B712FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(6306002)(1076002)(256004)(6486002)(15650500001)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(2420400007)(6116002)(86362001)(10710500007)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(7110500001)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1t7I/OKxIFXbf73WvKKKbY2XdG3bk+btMlJZgW/84KSm2HbRiJQ4nkCNVmVrW5TYo6glCqdE4xb+hvI8Wopkycwwa9mK81KwgmWpVazcOxwf9cYu6qcSv0MWhRVet5q9v6AyHJH/jVxVTtSWPgqDJb8WFM08ET3JRtTxnpeye1kb4V+VDiebyEtRuzlYcSvdt3h5gKAN+Z8h0yK7Me7oQyRHJdRyf91H6n14npLb04PqDcdCUH2Rp+/xFBB/NWYUGYzi874UsapQgXaGwjCR8PFPRYMpgoU3iklfYAJ9SEvxpvkiy4dS2HZG/4uqJS8QtDtsHZGqiTFyKvqHz/y/Rx3HtsRwD2/Z7/nxIvMGEPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cccf619-1252-403c-e773-08d61c4a7659
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:00.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 8c9421b69da0..6bf86ca950b3 100644
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
