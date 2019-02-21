Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08038C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10792084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c0Z1AXhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfBUNp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:45:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52150 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBUNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:45:55 -0500
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; 
   d="scan'208";a="26924331"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2019 06:45:54 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 06:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoBjoqp0PUM+hVkIf667bQaUmQdvzgwEf12H2arTXGE=;
 b=c0Z1AXhMfvFbk1bPSaUwJ1+GQQiGkVConkf9Ddyo4vWCa2lZlPDRy0D1JnuwuuDrEwzRVfCUpA6Ya9nnokHYrymVSotzbbweFtX7L1bMKdhoropaqd/kKK5y59gQmURMaQiY6W5slTg08ZglFmi9HtUoX61/Bsxhza5WdqbbFtI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1677.namprd11.prod.outlook.com (10.172.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:45:52 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 13:45:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/3] power: reset: at91-poweroff: add support for SAM9X60
Thread-Topic: [PATCH v2 2/3] power: reset: at91-poweroff: add support for
 SAM9X60
Thread-Index: AQHUyevC+XfzIbxbM0yYZ6tVu9cVKA==
Date:   Thu, 21 Feb 2019 13:45:51 +0000
Message-ID: <1550756716-3032-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61f572e-e926-4eca-a081-08d69802e4af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1677;
x-ms-traffictypediagnostic: MWHPR11MB1677:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1677;23:wiRnu9Pg1sDr/SwQ2Q4kv3hHBfDwle2jKaJA+KU?=
 =?iso-8859-1?Q?LszHNNYOPGSc62yG4dJtDYniEZwAZk2Dq23gglcD/o7qGJQ/YipnazttcG?=
 =?iso-8859-1?Q?1OSF2FbpF3+GONDrW8L2kI7QQVgF0dt1O5GhRA9jtIeIxVFhJa/e+3dG03?=
 =?iso-8859-1?Q?UrKW7cHdP966eiprk2KF8wdVgNKuHaOV3AR5177EmbDXwMIFMwy67OcSPm?=
 =?iso-8859-1?Q?TZf6fQ3DcOmry3E7CwouQcYMD+oUOinv/pNVE59pnxk33cW1Rs919Oq2n1?=
 =?iso-8859-1?Q?6KDs0yeHYt7ZPvqigpK1/YU/4ZbICI2UnCZ4cTFEVVDRUkJBFOiVAcOPi+?=
 =?iso-8859-1?Q?ETVh3fGk92bnQ9vOn0QMAs1D3i0iF4nFbZrGcCGUl+aqNuDH1gaKe82uHC?=
 =?iso-8859-1?Q?NAIo6lTFeYbEO/P/i7prJeu+TREvXWMuQ5qaXflAqbDRaCzKhOTmZMIT4A?=
 =?iso-8859-1?Q?PZyOzlDwTHfP7MUZajhb5/M2sMoUvJYg6U5gsSQVZqKorf+vEMngxeLFuq?=
 =?iso-8859-1?Q?CvONGwLnv/QPDRl++TsRGWlPBrIEANu/jjw9KUyfp876te06VFpKPTmHvT?=
 =?iso-8859-1?Q?BLABaUjc6z3snfA7C0q6pmSuzcJQ65UAPydaloTXl2lgO5sz4DI+wlq8VF?=
 =?iso-8859-1?Q?Pcp6kXtlS16abCwny55A70ymVSYL0bkq6WS1BKDYvf4xr8Mjw+49I3h2VR?=
 =?iso-8859-1?Q?oV/laOcBIEMxEicPX9ghkgxUDyfR9jOP0h5m+1RtPGQ9AZd4yUku7HS7Qq?=
 =?iso-8859-1?Q?6GILSk4UBALfTLJsykmORZVpVVMmSj8J800vyxvdQV5hZzpQLv2Q2Xh6XA?=
 =?iso-8859-1?Q?KruzP3IMB/awu9ewXEOxL9Rr/Qxfzj2xc9z9dfwtLQ4/mZajcx7/Iots5A?=
 =?iso-8859-1?Q?POT/NWkQob1x+NBKf2efHrvo1cdP8fde0QbE7L6kjAVTpjPrrbbBuHy6LQ?=
 =?iso-8859-1?Q?736t52agoajrQWbVRKVJ4coQ2AJGKDTHOyIjdMM7PTOKboikLyT3bFTfwH?=
 =?iso-8859-1?Q?nqsPQrcYKaLJJ9FswfO5HzJ0Swh1rbuXI9GfsOA+Nj/HmkFGlOUuueTEtL?=
 =?iso-8859-1?Q?9rASbNOqKjDSIWPyjcLQLYgRpub+AsU/nnvvcpkN+JERkK3lsssUNc+P8V?=
 =?iso-8859-1?Q?AQxMY4qTVhU7VNC6pD4Mjr2w2UH807G7GtFZiDkwsNVLXr9qzYd6sgGFS6?=
 =?iso-8859-1?Q?Fg+nY48OP3Z3tqG8lgsPZK/Ol9PnjSzPwKXtxJJhCKSoTBHy4BPnGsdbq/?=
 =?iso-8859-1?Q?bPAmHXxleNzYgEwDOnS3rBF6WayWUNwsI4V5lmUy/i1iZ6oHhkgNbdaeXV?=
 =?iso-8859-1?Q?kWro18s86esDkIQt7GKt+J4?=
x-microsoft-antispam-prvs: <MWHPR11MB1677C12BDDB2AAE1DE0CF8C7877E0@MWHPR11MB1677.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(6436002)(6486002)(66066001)(36756003)(107886003)(5660300002)(81166006)(97736004)(8676002)(25786009)(4744005)(2501003)(4326008)(81156014)(7736002)(305945005)(8936002)(26005)(50226002)(53936002)(186003)(6506007)(386003)(102836004)(6116002)(3846002)(14454004)(316002)(478600001)(72206003)(2906002)(106356001)(54906003)(256004)(110136005)(6512007)(486006)(71200400001)(71190400001)(68736007)(86362001)(476003)(52116002)(446003)(11346002)(99286004)(2616005)(105586002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1677;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Su3WFMPQ5nKmIAzfmiPhxeYK18Y+cOVj5oe0z7we6BXl0Zw8jM/PzpJaRKxlTfju4H9Djh6nT72KkKGD0N3oC5m2nUdFuXy+ysSWxbgCxpnhLwSEzvJ1FWiGWzth9f+YcSzkGkgHOEznb46ghmNLhX8ZAqZtefb3WaJB1sjZ1+Tzo0gAHlYhbFq8Lcl/cQ62wUdypXYNV20yzIvaMSu8b5d4gmgNVQgHcBLq4no3L0b71gpgbqoch7ZsqIT6CA78LxCuhl3Yz0w2kpQJJI/U0oCd3cxchoMOeyTF3c3yln33uF+AWGh5Qapvtk3pvw8/YiIqWX21oNNFy7Cfy3VLn5WHc9FV95fBkh33nOtHUHhqCMhAxUqgIUM8oNVQ4bFdWSRwa6Pb6l/vO1hwJ7bBMFxz7MjoZzcun5nFfQ4hds=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a61f572e-e926-4eca-a081-08d69802e4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:45:48.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1677
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60 shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

