Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEB4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E58E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eJT64NGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406899AbfBNLYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:24:19 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:37939 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389603AbfBNLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:24:17 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="23850296"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 04:24:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 04:24:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdNbPHEQzZQY/crhHPkeYp5zK+1VSmdjf16ikwmXzBQ=;
 b=eJT64NGisenKOT4hm/NCe0cIqD/n6r/DxhV8DFRtV5+CfYxNwu+/BgVqCAuKVpJQCfzzJOzzb+8Rux+RmAJT7kswdkr5BTzqzMUznN8mz3awHncrGhEvcZjRZPgQTh5N3b2PMSnffCfD3JhZWzoFtRUluL+yTOQ73IvuraYuvHM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1661.namprd11.prod.outlook.com (10.172.55.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 14 Feb 2019 11:24:12 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:24:12 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/3] power: reset: at91-poweroff: add support for SAM9X60
Thread-Topic: [PATCH 2/3] power: reset: at91-poweroff: add support for SAM9X60
Thread-Index: AQHUxFfPG6YiVvagZUSJ4bNY2F3jzw==
Date:   Thu, 14 Feb 2019 11:24:12 +0000
Message-ID: <1550143407-26109-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841f9afc-cbf5-4f51-e098-08d6926ef1de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1661;
x-ms-traffictypediagnostic: MWHPR11MB1661:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1661;23:U4S70XVYg5DwCowAqlSwGtqvxZY2GpfYjg+yrzz?=
 =?iso-8859-1?Q?3/WyUC63ud0G9/J7I6g04/GGZWMjK3oQK9bA3rKmQw12uZ6wAPWglj8u+D?=
 =?iso-8859-1?Q?ULCcmV8trFUoTqzBtlz7RT/4f2ZGlL+ZouMcGWAJEyhaU/HHiSBA+KTt/G?=
 =?iso-8859-1?Q?90X2a6BrbHM/yubl4pli/GbRjdCYfEDn2ac1Kwim9ge9c7VpiubbiwqUd7?=
 =?iso-8859-1?Q?XinOMpjbZKqBtS9GobWm4dxcmV4LvAZc1SqUdK/urxnDTllMDZ2yzOQrGJ?=
 =?iso-8859-1?Q?yZmECFTQCD8XPlyixye3rhALphLN9Kjz+Ca9IK84vkYM3dtEaZrEcN2Ulp?=
 =?iso-8859-1?Q?/OrPKS4xQWhwHV7XOktW9+jy+u9YtnLS684rHVjfCfIsi11nhba6X+UF7j?=
 =?iso-8859-1?Q?WJzdEcdh199YOp+AvqCQpTDuRWVJt2GF7Rlo4pvtB3ozq0MAIGtVH860tb?=
 =?iso-8859-1?Q?mqUcIalU19BavMo9f19zj5YSc1quy+ibwdIe5fVslmdT3sDPGnbLrbPc62?=
 =?iso-8859-1?Q?KTpH50EELcpLmtC+Iwb7s83NDaiTITk1TouVlQTaOrE1l/hT9oPpp7U/I8?=
 =?iso-8859-1?Q?O9jFm/YiDW7kt2BczSrR6X2vjzoJCFvT58u87Ra5UmCAqUy3KQoTDBC2he?=
 =?iso-8859-1?Q?8kiRRO0Dbk04OGe9I7uaauISbc+I3QfNckRCuvB898D7pkneie173Eb+Le?=
 =?iso-8859-1?Q?7lg/bu3MlRhXA68WDPlhxVsdAIdvEtoibUnQjrKbyNiZb+/5W14YspzT4O?=
 =?iso-8859-1?Q?M1574bwnNwGuxIIijnIrNioBmtayykUIQcrx9hqH6K2ZGU6TXzJfDUTw+m?=
 =?iso-8859-1?Q?7JIEtQFw/pWLIy0q84QObDHaV0I3AL26gS48dwRdOtbavwuNqUqlVnEHo5?=
 =?iso-8859-1?Q?K/YzgRuwy852G5CK9to3+pt7PP1r4PviswamxyeEudcA5Kn3WtdiQzYnXQ?=
 =?iso-8859-1?Q?iDFd1gOxz5gz7cBATwQEvNckFBrhCghn02NvYm5NtCCCoFPHc7//DQNhLj?=
 =?iso-8859-1?Q?FVzyq0ziNcSAAKElguO1I50RhvzTwLPtRxGtovH8JdZgSNLwTq0sMeA3zc?=
 =?iso-8859-1?Q?KoMVnONynglyArrJ6rHfd3c63cF/YsctiIJuwWQWDey2I/oXqRYhffoPgx?=
 =?iso-8859-1?Q?45UwSqWBlnyMJxGPsIZGEOlyaBGUxF4MNBorDgB3tX+TXTQAmipvknIsDR?=
 =?iso-8859-1?Q?XrZMyOVkjimFDRzLSLf1x8ArKCqkkoE3NhWJ705yCeWpVNwcFqFCVijVl2?=
 =?iso-8859-1?Q?pFg7ecyHgB+1pf5MO1qmZdllRIqigswYqPXxnr+1va6EpcRi/lJG3WD07t?=
 =?iso-8859-1?Q?dQ=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB16618718760830137B85D63D87670@MWHPR11MB1661.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(68736007)(446003)(54906003)(386003)(105586002)(6506007)(106356001)(486006)(71190400001)(99286004)(71200400001)(478600001)(76176011)(36756003)(11346002)(72206003)(6436002)(110136005)(107886003)(2616005)(476003)(4326008)(4744005)(97736004)(86362001)(316002)(6512007)(53936002)(2906002)(2501003)(256004)(6486002)(305945005)(186003)(81156014)(50226002)(81166006)(66066001)(7736002)(8936002)(102836004)(52116002)(14454004)(3846002)(26005)(25786009)(6116002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1661;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6V4CWDnJ3D1qGZ3WPkFqu79Qb8pM+TziyROP9KAUW5gLWDxFTwuTjgDbScBELhg4pUe3/tsDfAMkGDKeu6thxNf8b7iSu75CHiHgsrV9pxYTA95Pbf3D7qLvVsLj/HmJxIzXUiOK/oJCvZCKsCmdqD5PlITxo1ezhiirCEBlnFCgGFFaBuR43lULDqqH9QkzOjebSas32+/Ka8H98OqQMVKxO1bvwgiYX1P1cCSMCRy+sdhmYoSTcvm6KZDQIlGgAi3Q+swKT31Z08+40LkboORRt5P7TqfVI1Z045V2mBrU0tUH6wmU4OigFHAJh3qP9S1wyzr1rbYmHJ4qjFiniPZWXKMRYEuK7Vbj8XJO8ALwG9ZHh/yDsfCXGwOc3a8jgD7/WqJJ/lFFx+E8SYDqpMxSmMSYGpbbMqL7nIxmZMw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f9afc-cbf5-4f51-e098-08d6926ef1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:24:07.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1661
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset=
/at91-sama5d2_shdwc.c
index 0747e0cdf350..e341cc5c0ea6 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -246,12 +246,23 @@ static const struct shdwc_config sama5d2_shdwc_config=
 =3D {
 	.sr_rtcwk_shift =3D 5,
 	.sr_rttwk_shift =3D SHDW_CFG_NOT_USED,
 };
+
+static const struct shdwc_config sam9x60_shdwc_config =3D {
+	.wkup_pin_input =3D 0,
+	.mr_rtcwk_shift =3D 17,
+	.mr_rttwk_shift =3D 16,
+	.sr_rtcwk_shift =3D 5,
+	.sr_rttwk_shift =3D 4,
 };
=20
 static const struct of_device_id at91_shdwc_of_match[] =3D {
 	{
 		.compatible =3D "atmel,sama5d2-shdwc",
 		.data =3D &sama5d2_shdwc_config,
+	},
+	{
+		.compatible =3D "microchip,sam9x60-shdwc",
+		.data =3D &sam9x60_shdwc_config,
 	}, {
 		/*sentinel*/
 	}
--=20
2.7.4

