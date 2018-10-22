Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E451C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B8D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="C/CUT0tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B8D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeJVSfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:35:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39219 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeJVSfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:35:44 -0400
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="22818543"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Oct 2018 03:17:50 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 22 Oct 2018 03:17:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIlLhVv6TK/hfk0z3NXM4T/pBFPOXGFHqCaex+rVz2Q=;
 b=C/CUT0tfBB0Oo1M7ozOMSxY1sTjNgANs7HGhMWG0sAnYGyjMfMzjPMjt2gldLaW2fgnola4eTKYk03tK0qMwEg/PPP5rt4N8KduJH9PkJQvnfwTGV/hPnYsCnVPuq+CIGpvx9Pw4eczQDW02B2PqQKECGKVDMJgc7CDCrX7mwEY=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2339.namprd11.prod.outlook.com (10.173.200.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 10:17:47 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 10:17:47 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <wsa@the-dreams.de>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <Cristian.Birsan@microchip.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Topic: [PATCH] i2c: at91: switched to resume/suspend callbacks.
Thread-Index: AQHUafB6HlYWaEsRyEeCWmEZo34VTQ==
Date:   Mon, 22 Oct 2018 10:17:47 +0000
Message-ID: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0159.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::13) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2339;6:AeJiZWy7L+DSj3jWGrXjjreVnkWSeQC5LEg0l4v8nueZzjW+cOqCAMZQZfK6M5XjKS2lrWvw6ViqjWeZsZj6PDzbc3x1mdWbU558ci92b8QIS9fEHyEIZDhGj92957PoDu/sI8upCfNaib3bsYU0oSu6yD+qqN7tuvmWLupQBfGel/yPN9DgdZRJBZ+ASVMryjyK7rKILrv++svcSevaH0bdYCQe70NEEckovTwn3oeqG+VYw5s7lTyu4VektuK4Ga0mfZySOyVfY8TWoY42gLSH0dNiW7i7+tijBRRB9ZxU2QJXk1Jd28A0YpRcdf5oNAlbz4MW6ly6HgnTYlM+bIbemKFbI6b1Ju1vQnAZLiHAMgQV58n4Iz2qvr/x2mY3I54JKrRMhTYCvmaKP1Mca+6Wktv/h3aT14v+n6YuMV6upWt6zdZn1A9mpbF0OXhO0dYdzu4Hk3hj+r5C1Pwjog==;5:aznVkGYigResbVE+E6M8MJRGHXCzao61906slpl7q7Dioxz+bKeyhJF947m9vjnYEU2hpxaOu8g2vKnaYG97p4AUwqybscg+5wWDjMNzmSnlpqckQpMefLADKrJhWYzbh88/vaIjf9/OaVm2JpOnVWyRt7kT4G7M5XJtCmaSh4M=;7:Yt0+HlDkYoC7AhayoIMRZDO2M85Xs/c5GvLCjMxl+tx0vljl+yq7KBiav2URB4vyDnqh+5EbqiAPaPzEwz+s+7bKAqW6xwly3H9Y2aabdHNJzh0q646ACDJHcC9s1sP5IIdj/UrFq+183IDV0p3LBWgqRzP1gfff8nOl2GO6+bn3jofweTxvtbIdZTr5Y1Tt3ldwNV0jedDfG2PEZ+6YsTXBIlkfAxdtOgTH2e2ilQivXKoFDhhUYKjOKECDNw4l
x-ms-office365-filtering-correlation-id: a95f97f0-fee3-4597-330f-08d638079cea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2339;
x-ms-traffictypediagnostic: BN6PR1101MB2339:
x-microsoft-antispam-prvs: <BN6PR1101MB2339FE37058039881AF6900DEDF40@BN6PR1101MB2339.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2339;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2339;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(53936002)(110136005)(71190400001)(15650500001)(86362001)(2906002)(6512007)(6486002)(6436002)(3846002)(71200400001)(6116002)(66066001)(105586002)(106356001)(7736002)(81156014)(8676002)(8936002)(81166006)(68736007)(25786009)(386003)(4326008)(478600001)(2616005)(107886003)(2501003)(52116002)(5660300001)(305945005)(6506007)(102836004)(476003)(5250100002)(14454004)(99286004)(36756003)(486006)(316002)(2900100001)(186003)(1857600001)(97736004)(72206003)(26005)(256004)(14444005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2339;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mVVuIYQAHRwYflQ55DdCn1YUU0pXitqOsu5nHKCYgGAEJGU0Q1jCTOdOoFFyJkAmx22Cjloq+iT+RHrr8MxhQT+X5y6TiDTLO61OYTQHGsYxuD2xl1t66q0PUaWC7Fqg9ohsFKs5rvPA/pQzIwwVVwWDIrpFTHwBK4Ib2wKMkLeSX2nRrhyfyuOiZZ7KIHzNu/7PCdB/Zvhs63aGQIjvwJ/bQDzpsP1mVCFuca99ZXNVB3SGWiJUsEeGOXX/VUYrBmTkgsxCWpg8fn1llc8ak6+Wttlix77DuopaiMOx1GVlcvrhh8hLLQzIgV9Jx6WHHlmPAKZdUNV5eTEJAHM2XRrsGP5Yy1DZZak8nFFbQmc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f97f0-fee3-4597-330f-08d638079cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:17:47.6149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2339
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous version of the driver resume/suspend_noirq callbacks
were used. Because of this, when resuming from suspend-to-ram,
an I2C (belonging to a FLEXCOM) would resume before FLEXCOM.
The first read on the I2C bus would then result in a timeout.

This patch switches to resume/suspend callbacks which are=20
called after FLEXCOM resumes. FLEXCOM, SPI and USART drivers use
resume/suspend callbacks.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdf..81f7b94 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1174,7 +1174,7 @@ static int at91_twi_runtime_resume(struct device *dev=
)
 	return clk_prepare_enable(twi_dev->clk);
 }
=20
-static int at91_twi_suspend_noirq(struct device *dev)
+static int at91_twi_suspend(struct device *dev)
 {
 	if (!pm_runtime_status_suspended(dev))
 		at91_twi_runtime_suspend(dev);
@@ -1182,7 +1182,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
 	return 0;
 }
=20
-static int at91_twi_resume_noirq(struct device *dev)
+static int at91_twi_resume(struct device *dev)
 {
 	struct at91_twi_dev *twi_dev =3D dev_get_drvdata(dev);
 	int ret;
@@ -1202,8 +1202,8 @@ static int at91_twi_resume_noirq(struct device *dev)
 }
=20
 static const struct dev_pm_ops at91_twi_pm =3D {
-	.suspend_noirq	=3D at91_twi_suspend_noirq,
-	.resume_noirq	=3D at91_twi_resume_noirq,
+	.suspend	=3D at91_twi_suspend,
+	.resume		=3D at91_twi_resume,
 	.runtime_suspend	=3D at91_twi_runtime_suspend,
 	.runtime_resume		=3D at91_twi_runtime_resume,
 };
--=20
2.7.4

