Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208362080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Oi1auStJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfBUNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:45:49 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48368 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBUNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:45:49 -0500
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; 
   d="scan'208";a="26664942"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2019 06:45:48 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 06:45:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THBY4Yi+rszutxqdRfVhErufWvIhiThaMuapsO8zFos=;
 b=Oi1auStJ3A1SECVLHg+Y65Y6yXc8vZqWqiz6jNlI/qEb1E0a9jk07/d24DTdB0m1y59bmfQlGCiVcgr9OJgoFRvpHia7UR63b2wdDaZ4+Tn0Ba9mF61t5UXcajh7Rb/eJH6/eAZ9WuwcY8P7FHZxuaFn5nXoXbC/WX1tuziDazw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1677.namprd11.prod.outlook.com (10.172.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:45:45 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 13:45:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/3] add support for SAM9X60's shutdown controller
Thread-Topic: [PATCH v2 0/3] add support for SAM9X60's shutdown controller
Thread-Index: AQHUyeu+va/R5VdQpUeP/sCJumt1Iw==
Date:   Thu, 21 Feb 2019 13:45:44 +0000
Message-ID: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6af1c15e-a344-4cb7-1385-08d69802e087
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1677;
x-ms-traffictypediagnostic: MWHPR11MB1677:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1677;23:j9dGiRzsfNQvSAgtbKdtAvHQn8xOD+oRgV69v0+?=
 =?iso-8859-1?Q?OIBCSsHi5Iy6zZJYCZjyv6sk/IgBw08PLP2vvXBGSfxuqqkzprPqMbipWW?=
 =?iso-8859-1?Q?FHMTWRVItp8S4oA1MboZP1FcFT43/n+eXeoogOe1ORQJlAEPe/BblVTxhM?=
 =?iso-8859-1?Q?WhrA7w3nQqOGRrnD9v8ukgdVu1bRupGosjmSNddYlEsp4IRaEzHE0RgqHz?=
 =?iso-8859-1?Q?FwmG6bS7Sl3mFTT1aJcxPt4ZBv6Fa1373rbvCvOqKXEKM6//ealZThuf3l?=
 =?iso-8859-1?Q?M2hlIYUwx/OSr5KaUud5NFGLhNHvNTZz9B0R6l3wqxZFtvB4AEN//MOe7J?=
 =?iso-8859-1?Q?C4O7c9fj/vp2buzyS1d0lS71RFz5jnI2+f8C8nEy7wTiWO4nIoQOWuF5vA?=
 =?iso-8859-1?Q?BBV4mcnEonbJvOonCU6D0bbwrEkPDl9PV2GBy1cIJp1SDpxTt/h7V0WLMc?=
 =?iso-8859-1?Q?MOhchmc8VnyJTSrAdTahK4+5MtuB4Sj5P7ugqAgRADFXCYBKMWaQ2/0IBG?=
 =?iso-8859-1?Q?VeyZUOLAqsTDh92g47hlEiF76oDSLtQjajQu1YzdUevVK3TMpkAGa8yeKq?=
 =?iso-8859-1?Q?7uEur8S3IIrQs8gTpZRoE/j9Hby4N8+1M1/f0s2s2qh+AhGkMggxdJCG/h?=
 =?iso-8859-1?Q?bQRkGpJQlBZt5efXg4QwXTdLvphe94TOphX3R2jt5yTYcpWbAf100930r3?=
 =?iso-8859-1?Q?N+euCUhYHzyvYtqMe8g0f/sbXPvuo5DWVrP35ALU3mb0UhVNoxfZhpSqxD?=
 =?iso-8859-1?Q?1ddODJ9mEI+VdI5cHCtoBTpe5Q89b3W5I9rSpL401emtwEeFmC6UbcsBL3?=
 =?iso-8859-1?Q?b+fr89XpVwgsz+kWdmgzCsr4CQiMgNQI6ZPbxMzUCY2+YfAeNj/Lm/jk7w?=
 =?iso-8859-1?Q?wQDigO+/adRsUKOjvqPzl5o3pe/ynEt1y2A617c4FphzHh7H17dyfuQJJh?=
 =?iso-8859-1?Q?4GyrQh4mSZWXi10+HYoE2aJ2Ne8nCrLtU0cmY1dkamio28XTN3mpfJWFG1?=
 =?iso-8859-1?Q?K5nNebgxnm7LQLqwcE7vWc/fkro4H6QSmNuBzuyLmt4JIGPiN1Mr7tpbyO?=
 =?iso-8859-1?Q?hlfZAT9oB4yCcGvFs0PbXjAmPYmEI/GZiz8hN40m7/P+NZNBRWb278Dm3G?=
 =?iso-8859-1?Q?Sp0ZdqG5Yl8slHTpr5yy8tkq07pYD8HDVz20nNggCBiInu8r1hjNaCap6l?=
 =?iso-8859-1?Q?p/te7WzsMq8G/+quO/tQYN0cGsb9s6OGHPXHQM9/yprJJjPszaNjDHxInm?=
 =?iso-8859-1?Q?Aka7mgdOWWUVdIAtWjplZl0b2EUj1Y7k7CztqIw=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB16777280EAE9EBA1050EAE1E877E0@MWHPR11MB1677.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(6436002)(6486002)(66066001)(36756003)(107886003)(5660300002)(81166006)(97736004)(8676002)(25786009)(4744005)(2501003)(4326008)(81156014)(7736002)(305945005)(8936002)(26005)(50226002)(53936002)(186003)(6506007)(386003)(102836004)(6116002)(3846002)(14454004)(316002)(478600001)(72206003)(2906002)(106356001)(14444005)(54906003)(256004)(110136005)(6512007)(486006)(71200400001)(71190400001)(68736007)(86362001)(476003)(52116002)(99286004)(2616005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1677;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LaFXQ9adpZ1welcRXnjpoGT9NhGwL5A3GiX8T+hQJDIHTDN3eXby12UtaIqgTdLMfyLh6tgVrN5Hxh6R993fCswIG3S5IvWp27urrbjb9kCdjYZogzYAJVIho3hHoTvDuihgpLfrqnwyGdv7sHgWxbEYM7FHtqCme1jpbmztDZDm3TLSbeCASyPh2Ntk/wWi6ZgQFfiZT5RJYNfBhJmX9Ytp/+hZrDuusAJ7BLSW0lsJ0X0gliziekNymwGNg4p/971mdRxwG8uy1kW7L6DWvqdKfW2zgiYzxh4114QsouIXfBReqWV/GzppsgSFunGnNrFtpM/UpRTPbC2CrP9mixDuak0vRpQhX/VkmwFSoq8TQWjiPwz6KshGSM2CC7csimfzHdrfNxP4O8YBqK3oUyAkA6d8t9AKl8LjVkc5RVE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af1c15e-a344-4cb7-1385-08d69802e087
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:45:41.0131
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

Hi,

This series adapt SAMA5D2's shutdown controller driver to work for
SAM9X60's shutdown controller. The difference is that SAM9X60 have
option for RTT timer wakeup.

Thank you,
Claudiu Beznea

Changes in v2:
- collect Acked-by tags
- in patch 3/3 use "optional microchip,sam9x60-shdwc properties"
  string to specify that the introduced property is only for
  microchip,sam9x60-shdwc as specified above in case of
  atmel,<chip>-shdwc shutdown controllers
- in patch 3/3 keep only the optional property introduced by
  microchip,sam9x60-shwdwc (atmel,wakeup-rtt-timer)

Claudiu Beznea (3):
  power: reset: at91-poweroff: add RTT wakeup capability
  power: reset: at91-poweroff: add support for SAM9X60
  dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  6 +++++-
 drivers/power/reset/at91-sama5d2_shdwc.c           | 25 ++++++++++++++++++=
++++
 2 files changed, 30 insertions(+), 1 deletion(-)

--=20
2.7.4

