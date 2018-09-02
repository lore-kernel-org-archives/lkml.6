Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A3C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC60220835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i+gwlZB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC60220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIBRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:25 -0400
Received: from mail-co1nam03on0121.outbound.protection.outlook.com ([104.47.40.121]:64374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbeIBRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpVk4KhLamJyXYvFQ8eDqQjW0nNFwRAAMgAkAXNfulU=;
 b=i+gwlZB8HuWLX4Ch8SNsN0O3j+4fjjFPyChtTP1HEJYNpfqk2O3YIPKRqCsYsQrJI/f9WAFmJ4idGiS/aOSSGMVuA5J0vAI3I4vo/aATIP0PIvfDKKGDGY1RywUzwMBxkm7qPxVwxk6eeFG5aarYLzch9WnKMonzgptlXtTxMq8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 100/131] media: helene: fix xtal frequency
 setting at power on
Thread-Topic: [PATCH AUTOSEL 4.18 100/131] media: helene: fix xtal frequency
 setting at power on
Thread-Index: AQHUQr2TgvyLL1zgfkGBE/WS+nD9cg==
Date:   Sun, 2 Sep 2018 13:05:09 +0000
Message-ID: <20180902064601.183036-100-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:mJAzpEst7bNrozizKviy8HkpuGdBVUe1yuMBvToFGZnxAFbpDqzONBlmmu76ZGIjsuuQAI43rdMekuag/6sfrF1D6QQT3qXEne0NBolqTLNBzL0Nx8Cr4Y96yy6vt0LqoI01wW8Ftidtd4EW0CyFeqfLH1UcGGHlDYo0u9dsdXZQg7I5xSFyy5uiFciVuolRNpwyHdr1lkG5W9mN/4Dm6zPbttyk1PoMmKiR8c3QHPRJLCRrMM7n4KhZl6PZdYSK/y0goZ3OZ16M5ve8Sd4CIQdYeceuT6KzcTJ9o0ruSH+fTgT+B56CVHRZHgh/58SF80sFRcgKQw6XULJVFUlw7KOGJSrHxkXnzHClnw12iHYAITN1Rjt6kJMBuLazjLs37NGWZN79jIPpw4TYM4joEzfuEhcxd3ZIn/ex0w+eMcaEjIu5KWsejhMLm6xLS3GBxD2bCn2uCKMMj9Kf1SjEgQ==;5:6FQGF/dhDOQBpRYskhc9/jugrMdPwcS8rYiAoV608tisfpVgWfq3B1dgzHkIHWwaPluhG3mX3JElFJGSThJ/9HBcQTjbuuNRi7QLrNirMfPUqLe3wLjOJZnO4VzMYwsWJy6A5hLdNVdJt6bZqQO3Ceym50XrjlbSwzoWR2sns+Q=;7:XLsAIke9r+cohn5a6V+FOX/pGhkCPjYnY9v9OYxTeAXU6r5Uq8r/XO5mT+wCOUrlgqBQYBNhclTXZP0bUK1IK4TZJnIpXwRwxeLyK4T1KVI/kMFnMDUi02dbOHImaNYA754QvKWE9aQEsPGchaMlvjlFIM7N2Qgn+SS5qGQcg8VXoJsbJiEwqJfM4yxitYysX0YWIw+AuP2YLkR2cTYYBLeEdVrDPC2jfzQAi3lc0YcqC7EBM9YsmyF+wO607YJb
x-ms-office365-filtering-correlation-id: d00e45e3-61d2-4cfd-a401-08d610d4c54b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01842A17A2F57704DBB3235AFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(4477795004)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /C+X1iRzQVpG1N2Yfr5J5uKlZyJAOX0UD4gPWOfTBGaOEGWHVsZABmeLiun080S5HVH4eEfogP1x9mHr8xxqWOnr8FvmxG2bT/n7841Q2WCFr7YEmcf6ir8TFvdW3N/SOZgGaTE3OYRUZBJMb4SH8DFrGVqYbhDLJ5V6iUlwZ/A1Tt/Lnuq30dj8u6ONDA2xq2lApvOzGOufkKMeY1+qU/XIV7OyMhyZHmCU5rlRDOnYSSepJcqjHngZxvOk2GMmJAyxsza3SGj1dGY1JaAYiTTuIS8bAVZvPWMWzaXlb93gOpzzCxlP+ElNiKuQ+LJK3TUkseYtKD+6+lwAXK49Nym8VZB9K/r/plipifAbUsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00e45e3-61d2-4cfd-a401-08d610d4c54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:09.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

[ Upstream commit a00e5f074b3f3cd39d1ccdc53d4d805b014df3f3 ]

This patch fixes crystal frequency setting when power on this device.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Abylay Ospan <aospan@netup.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/helene.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-front=
ends/helene.c
index a0d0b53c91d7..a5de65dcf784 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -897,7 +897,10 @@ static int helene_x_pon(struct helene_priv *priv)
 	helene_write_regs(priv, 0x99, cdata, sizeof(cdata));
=20
 	/* 0x81 - 0x94 */
-	data[0] =3D 0x18; /* xtal 24 MHz */
+	if (priv->xtal =3D=3D SONY_HELENE_XTAL_16000)
+		data[0] =3D 0x10; /* xtal 16 MHz */
+	else
+		data[0] =3D 0x18; /* xtal 24 MHz */
 	data[1] =3D (uint8_t)(0x80 | (0x04 & 0x1F)); /* 4 x 25 =3D 100uA */
 	data[2] =3D (uint8_t)(0x80 | (0x26 & 0x7F)); /* 38 x 0.25 =3D 9.5pF */
 	data[3] =3D 0x80; /* REFOUT signal output 500mVpp */
--=20
2.17.1
