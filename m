Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3C520825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BmTmIzuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3C520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeKEUdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:45 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53544 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbeKEUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:44 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="23617414"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 04:14:32 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 5 Nov 2018 04:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/c3VK6Ys11Vot9KDM5zrjLWbm6LGnqDD11Vxceug/U=;
 b=BmTmIzuDqlNAmcRSFh8/IWje9JC0uB/Klu3BBctajfPD2pK3RbLCXgaT/DbhTkSwlyBQHLhO/QE7KNoA5FeqzuX8qbYMlzbC9D8boZbdOUpzjGDjyiJMpM/IYbR80efC0zxwrcWImM2ZTCJxY1voMb4b/TEgiYajWgiyI1h9Uas=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0647.namprd11.prod.outlook.com (10.163.159.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 11:14:31 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 11:14:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 4/4] power: reset: at91-poweroff: remove at91_ramc_of_match
Thread-Topic: [PATCH 4/4] power: reset: at91-poweroff: remove
 at91_ramc_of_match
Thread-Index: AQHUdPi5lHUuequYaEebxLWNIuZPVQ==
Date:   Mon, 5 Nov 2018 11:14:31 +0000
Message-ID: <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:802:2::35) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0647;6:6v95w7LMfJ+JX/fA5R6AggineOcNuaw7+YaRnu1LxBIBRaxKBgYEGDpX+m/HixWqNAHcaS5IklyaSn6VIc366kmhaqLeqP78hbGSF8KqLstJqNAcli5BvpGi/c/TvpeclE9B1amz4frC2X6Y53dChGu57fX48aYQ61uYR+x6wQMz7fVZcnvQbwDPcAeCZPqWik/LfnMOppeQ/rLOnxMXlWsq6muI/m6gUIxWFDiECTKM++yLZPAeTikrjn4jIY+JjY8uOryguZUB0cbRW7O/ttxpWr4qB9W6AmyjtAPaYVRtCkOLfMfRTy+hN6Qr1NMO4LVlqI3sRath2l4icglcY1o1M7hcJ5R4uqrZzvlqlCQZcq23uUAtgIAh8woRU54zCGpnux9p1wxZRHBo2gxpqyIDapzFcJylIak2U9H6KbuywRZLBuI7dcorsgv8ff5VlJ3CQIABN8uAsJzNYEzAzg==;5:LqRzj85Z+600jYRBl/9aaur5U0gmTpIC4IZbqod+n12ZpwvZTSlibgE06ooT11CFiqqjDFFMSjcCgdJ/Ej+Og/nwaNxexxL02XdaB2FDDgfDziURtHE3ZgKsV/gh51oYBhDQZPxeCwvgui8PLcha/kR4fLY7I83u76OkGaJLylE=;7:tgTTjPISrUQU15jyBKwH6yCq0EcbAhIj1TWU+UDD7kfhRfrTbL8fcv1FpxFH9B7hLmOXE9QQ/e4S82gfw4s8ZkRTFTXj/r06jj5Gp4Q1omkgOs3JSyzlEC2OL/CmYLiJGpICiWz+US+UuGvjmYqf+A==
x-ms-office365-filtering-correlation-id: c5a46f57-9b42-4e57-fbb6-08d6430fdbc1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0647;
x-ms-traffictypediagnostic: BY2PR11MB0647:
x-microsoft-antispam-prvs: <BY2PR11MB0647ADD58F19F2E1F74F621587CA0@BY2PR11MB0647.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0647;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0647;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(39850400004)(396003)(136003)(366004)(189003)(199004)(54906003)(6486002)(72206003)(316002)(97736004)(110136005)(99286004)(2501003)(575784001)(86362001)(478600001)(6436002)(5660300001)(36756003)(8936002)(4326008)(66066001)(186003)(81156014)(106356001)(81166006)(8676002)(105586002)(305945005)(2906002)(25786009)(7736002)(68736007)(6116002)(11346002)(3846002)(76176011)(53936002)(26005)(102836004)(6506007)(386003)(486006)(2900100001)(6512007)(446003)(14454004)(2616005)(256004)(476003)(71200400001)(71190400001)(107886003)(52116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0647;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cuBm1hqspDShEUG6kyXh8Y6OlcZ9C14gyA4cvzDPrxq7B+ahPxEaDLuwjvbkllqcejBpFANpcv9pxoHWa43tjG2K3Hu78pA7u2WHQ3xz+qEP9mvSyfXcZ3fvkF9x1xTbTorxKfGS1SxuP+W4cqPVrgp2kUdVJhqyeN1vu/M4zSKIASdqqc83dQuu1G7uCpahAmJfADi20QYJIeDcKDVzA0lAWQE4Q9M3Onc56CPEIdAp+dbGMqb1+F6X8vsZkavvhczZ15oXMsq0TQPRn8I+Z+/lwo5fYxC53kzvftTso7c81BoVdYIIM4O0TyXu+9vr1yvQJq+apEERWi68r8wCxZw+E3oo4sQVJ6ibKc3iJJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a46f57-9b42-4e57-fbb6-08d6430fdbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:14:31.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove at91_ramc_of_match[] since it is not used anywhere in this code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index e75d8f0f0526..43b4cccb7d0c 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -232,11 +232,6 @@ static int __exit at91_poweroff_remove(struct platform=
_device *pdev)
 	return 0;
 }
=20
-static const struct of_device_id at91_ramc_of_match[] =3D {
-	{ .compatible =3D "atmel,sama5d3-ddramc", },
-	{ /* sentinel */ }
-};
-
 static const struct of_device_id at91_poweroff_of_match[] =3D {
 	{ .compatible =3D "atmel,at91sam9260-shdwc", },
 	{ .compatible =3D "atmel,at91sam9rl-shdwc", },
--=20
2.7.4

