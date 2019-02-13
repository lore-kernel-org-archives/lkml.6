Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900AF222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="WcnCB6IL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404436AbfBMQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:59 -0500
Received: from mail-eopbgr10091.outbound.protection.outlook.com ([40.107.1.91]:36831
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404367AbfBMQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAe1Elduy/T5Ar1tkMuVGFUHWifvvP4k6dlKS2DuE+M=;
 b=WcnCB6ILMWSZSMOCdlJWhZ9+lzhTgavLot8gDMSt+KIKfALsPvea51Dc4WAmwZGigpRvdT9wxK1uJjcGsGeQX1o3XeLyiFgvJwSGzhopVE9qKt9SzTtOh1QuR0yzw9PWgpVXvgefQeiQ6LUuKEnysuUVgflNfFFmkPj8TEFL3Vc=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:39 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:39 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        "james.r.harris@intel.com" <james.r.harris@intel.com>,
        Ahsan Atta <ahsan.atta@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 8/8] Revert "uio: use request_threaded_irq instead"
Thread-Topic: [PATCH 4.14 8/8] Revert "uio: use request_threaded_irq instead"
Thread-Index: AQHUw7lQYdrg99aJzUSXCyOCy7kM5w==
Date:   Wed, 13 Feb 2019 16:29:39 +0000
Message-ID: <20190213162845.11688-9-tommi.t.rantala@nokia.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4dc6b8-14b8-4319-afff-08d691d07319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:6r1SmvC00m1l8UQdG7Ewb6aM7KWGF6zrzCTYq?=
 =?iso-8859-1?Q?CkkYcLaDi65Hd5j/CR2DGoCIaFR+6KQRtUFSLch6PbSBJwVicTE2D52GQI?=
 =?iso-8859-1?Q?6497FFV22kaWrzH6l095ZjDjdxBpynV14aoB6XJ2WvSM9qonoxcUaF8stH?=
 =?iso-8859-1?Q?ajlyYK8X9Ep68+vvsJZers3ZRPJvE4mwqjCYSckdRxYSLwqTztSAilkQkS?=
 =?iso-8859-1?Q?KbYjhWtkjkk+PFRAU3PFeFeWRxnmkLJK3Lk6XqemWSxuT6AUruiTcGejX4?=
 =?iso-8859-1?Q?390kOMZbDMg9SY9TJlyS7DwTxNTT9rsvCytxCTz85Se+1I6jck59AxLCrQ?=
 =?iso-8859-1?Q?NHsjP2uVP/Pm5p2DigdYUnhRhY7L+5ZvP3rXVoDyNJeFE3oS5uwKO2Ikoa?=
 =?iso-8859-1?Q?Db0jH60+8bsJDkIxgYITq1TwBdYf0ZUAl6oJB/Di188p7BtQMHpKKODPhP?=
 =?iso-8859-1?Q?fs0L+2a2uERnyH0ke0Glrvy4mqJMbvnDK3qJq3PNHYLoiM9iJO4JJkWdVK?=
 =?iso-8859-1?Q?b0s0E8OFw7tzmKpBGWUsMaD7XTf6I68MxkOf3KvxzbO3M6eCiEONfaECPv?=
 =?iso-8859-1?Q?Ccepbxi0njlQN79bEdBPV7Wd9Ge8EnJM6GOA3/nYoxNi1uq5T6uCB836X5?=
 =?iso-8859-1?Q?cxLetkpanDAsJcU/Y2zUrSqQ0LD25l7rBxqvP3tCj/1JzPhzrCheDHFlxJ?=
 =?iso-8859-1?Q?isWx0sXb0gsgq3xPGFzp/M0CF9KwoAz6Wrl2R9m+uoQi7FV/xHGj00y6BM?=
 =?iso-8859-1?Q?iVfq0X3nvGU+wyZtkeLh/m2UuAkJEhRBBInbaVjDK+Xedfr22QkLyOGtnZ?=
 =?iso-8859-1?Q?HNrwowbjjXhz3xI1bBQpP99TUGUlG0Skii/Mkxe3rjanhFt8z9keMN0Tby?=
 =?iso-8859-1?Q?wZCRFI9Zi/8pNMvkwOPtmMtwsUEsajwPoz5D1WMKQ6A8poCTawUYPbkkJ7?=
 =?iso-8859-1?Q?bxX3+igqr04qsCThFUixU3IVEEDwCiz6NEqV+bGUQzQzMTbIznfzaZ0zxp?=
 =?iso-8859-1?Q?BXIZn4pRJzmN7c/dLYQ2ST1NnFnFdZfhigJCSBVLwUNeUBGd5MinIkyQ9o?=
 =?iso-8859-1?Q?QTU28Nd7sze+0UWxZtE4PUcX2svZUe5xsFBOwDTQcMwq45O37Q7crcUaTE?=
 =?iso-8859-1?Q?iQ5/AqQRfIdjCeDIYSrzfXQpY7I1xPyxArkbYgeI2pd0fwl2SoY/jkvue/?=
 =?iso-8859-1?Q?cr7U8b+a/3wFhyd6gun8/RZp7dHkF6G0Damo8GWxN7ThOnDpUjC1Fk4agA?=
 =?iso-8859-1?Q?ijUTqDhAKvAa00jX3fioeiS3qp8hY6lY6eseb20A5ufU2YeuK2bwqqCd9f?=
 =?iso-8859-1?Q?6eQ2GDFv7XtlKrBHVWG9G9Onnv1w9h8I8Xm5ga9+bq7cjha3KOwlTLSpRz?=
 =?iso-8859-1?Q?9o62d3rOF8A5UpoSY43t+O3MkkPSzJx?=
x-microsoft-antispam-prvs: <HE1PR0702MB372194E070982249409A6C72B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ja4TfcTJvDkrRACO5LyZiqTGvqstUWfgYw7blBrep13XT/wkQzdBV8gvfQUKctXXhdSTCTRnrRG26nWXB9VISUUYYKCViwdwFdRP7wgRF2eqAg2TH6BUDAvtaQV+F90JCjdPsewuWiHnwNe1bbzOeF9j+WwlmJn6QlUzH1rqoVpF5cyGKAyuCTiGQCP14/Ms4RiinO8vhWPEwj3gb11+ndqlFtI53vBkDzfPWSYvAmM5j8ttmTsXAjTL64f2Z0YW2nOPxYYr+/59I1Il+66fNF/arFL+Fa7LVc9NI6HsdhH+bfqDNSxKg6AshZm7r6gEc9lqe+lGZAxWlpAsOMHlemxhXkemxdXF8k93c6MTuNi4O6+MBaIIOv3GF0HWSuFimsux0D4xZqbyIXpRQs6USMeZsTwLAlmV3PTaUgYtQlA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4dc6b8-14b8-4319-afff-08d691d07319
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:38.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 3d27c4de8d4fb2d4099ff324671792aa2578c6f9 upstream.

Since mutex lock in irq hanler is useless currently, here will
remove it together with it.

This reverts commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453.

Reported-by: james.r.harris@intel.com
CC: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 4e0cb7cdf739..fb5c9701b1fb 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -445,13 +445,10 @@ static irqreturn_t uio_interrupt(int irq, void *dev_i=
d)
 	struct uio_device *idev =3D (struct uio_device *)dev_id;
 	irqreturn_t ret;
=20
-	mutex_lock(&idev->info_lock);
-
 	ret =3D idev->info->handler(irq, idev->info);
 	if (ret =3D=3D IRQ_HANDLED)
 		uio_event_notify(idev->info);
=20
-	mutex_unlock(&idev->info_lock);
 	return ret;
 }
=20
@@ -974,9 +971,8 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret =3D request_threaded_irq(info->irq, NULL, uio_interrupt,
-					   info->irq_flags, info->name, idev);
-
+		ret =3D request_irq(info->irq, uio_interrupt,
+				  info->irq_flags, info->name, idev);
 		if (ret) {
 			info->uio_dev =3D NULL;
 			goto err_request_irq;
--=20
2.20.1

