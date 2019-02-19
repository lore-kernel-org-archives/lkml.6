Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC695C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DF21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3bwYU6c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfBSQcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:24 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54007 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBSQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="24901195"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 09:32:23 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 09:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcz+BNrqHUGO7J0JVov0pMOK5qxc37GRiYfEeUeIr28=;
 b=3bwYU6c9q7RHqU4EuvoS1kJR0VJiFnjUl/1CubTYqQpYl/prJKmgFfdQh5v0MPi2U07FnZC8LQvDE9cOQAC0J17zHO+wjK1uB6LRMFzWO3Ba2zfSLJcTDYhrDAZg+0QDL1LfNy6hnpwTHuVNuOLQInCrDd4qjEOc9t09gz+Vb6U=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1749.namprd11.prod.outlook.com (10.175.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 16:29:12 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 16:29:12 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <m-stecklein@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_SCALE()
Thread-Topic: [PATCH v2 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_SCALE()
Thread-Index: AQHUyHA/YMTuyHOEaUug6TBFL754tg==
Date:   Tue, 19 Feb 2019 16:29:12 +0000
Message-ID: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcaad6dd-4ddf-4bd4-4372-08d696876189
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1749;
x-ms-traffictypediagnostic: CY4PR11MB1749:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1749;23:GOChd5HY4UZxhmFEF3WcCW3pnWKo/Zk8oQ58blY?=
 =?iso-8859-1?Q?/vOsgA+ajzYC5QwrURG/nmyL5wnZbzPEhI6p0fz0X1IOrh+2LC/iMiLv5e?=
 =?iso-8859-1?Q?OU5dajZvY/q+kZK5aMxxmeovB0z7P7RhczyCHSeMKfzg60Kzb8MXoI3WqN?=
 =?iso-8859-1?Q?ap11AHtbuuJiZed32a1eXIyqmg8ZQqAZdYpnAN9CcH5gd230Owd5iZPTMj?=
 =?iso-8859-1?Q?H4LOexGBGslj3yluZmLPH6szxRdE9pNM24TDFzDroe0Hwh2wtu9Nv+TU3A?=
 =?iso-8859-1?Q?+RNFONQJjzB+EKG8hb5slh38pLYZhwbmlov1ivjIVaGnqJlNx9MiNoCE3Q?=
 =?iso-8859-1?Q?DqubvA+O12Dwr28ie5yxBJ9qOM5SVl0lvPILaw505+DSp1otHC6Q+dVO2o?=
 =?iso-8859-1?Q?1rVGN/O6oShnsME8HLyYkCVymXLG4x08mggvLA5wilf8JWxlbcDSkPXsnk?=
 =?iso-8859-1?Q?Z8Y5wi9eVwaK51l6zxF3MuMjWineeH6alFZ1blf7L+dzDj4hdRK2lPlTdF?=
 =?iso-8859-1?Q?yAQ5EIFjXj6kco5Jtuy5hjSypeZM2rglehbb9IUd5FpsPr+N5LCMJwKinO?=
 =?iso-8859-1?Q?ISN42GL5FeSJXGTfKgmTc/DLnzfl9QYwLLxUcsEU65HBFSEBpzmY3m9tI3?=
 =?iso-8859-1?Q?XD0KPU7bpzLkp/WKR2ltsVbXxGZo8KOeCCtjwi+1cvmNyvlfHZ2o69Iaxv?=
 =?iso-8859-1?Q?/w4FawTRlxKfwI/LtVFCzXoe21hLkHlH6RzV/U8X+0f8pLzWwVjJqNDwKL?=
 =?iso-8859-1?Q?r+g6pkbU28CGGrQnZhe+H/Fhm4JxdNZ3onrUXd/NKa8k7tNvaTQVZh0YmX?=
 =?iso-8859-1?Q?XIDI5Tr/M42WIPJe3dERvXIoafNTRfDIfQlcPQZIB1R07Br8pZ+moVwIgs?=
 =?iso-8859-1?Q?KdXTbRrScWUn4jOd9mPa38oq7cbIEnQOODUrkkPw4kkfPCkl+UrgIj6qju?=
 =?iso-8859-1?Q?QmXng7pfCONcZ/aizfQqRL6bmznndMr3rxkrDQJivxfXlLZF2XtpUNZmWs?=
 =?iso-8859-1?Q?Unc3/iuMc1N8zDMlpmKe5o1ePrnCuvmdHJhcwOp7Do1eBOm+c7VrIfOUEY?=
 =?iso-8859-1?Q?uYDej2rAVvmpTqO6ZSlPVfBmMyJDK8h8mBddbDbSV7aT79CY6IuLksRhOe?=
 =?iso-8859-1?Q?kd1VVSG+6c26Eg7H1GNFqOOabL6MMpOXzyafO+AEtginr0SWewhMHa+Atr?=
 =?iso-8859-1?Q?59vSFEwXuUlpaukI1r1ThGhFGN8eaVdffSdzhXif6clzgBJ2ziSssbApr2?=
 =?iso-8859-1?Q?r5WLbLINSOefvq3/7tvkmATi8rT2VpbwDsNdtn/qF3wnKiZA+AjjYjpYup?=
 =?iso-8859-1?Q?p4=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1749BD9E9A708E49FCF07AE3E77C0@CY4PR11MB1749.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(8676002)(3846002)(6506007)(8936002)(81166006)(81156014)(4744005)(386003)(36756003)(50226002)(6436002)(71190400001)(71200400001)(478600001)(6116002)(53936002)(72206003)(1076003)(102836004)(5660300002)(305945005)(6512007)(7736002)(66066001)(6486002)(68736007)(2616005)(476003)(25786009)(486006)(106356001)(4326008)(105586002)(52116002)(97736004)(86362001)(14454004)(26005)(14444005)(256004)(186003)(2501003)(107886003)(2906002)(316002)(54906003)(110136005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1749;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DOcRoZuFMF250k/0dnmRCY6OyREGh9DQkhjLf/oVaqMcJrt/HGYkNE6T1ih09fNTKru4YLdFMrlDAAqT9RKwEhN/oL/8E1Ozu7gng3mQC+qSBi3BTGHfLZhyQkQoDPWH1oHJiYmuEWfCcim4kMqM1tN4Ag1JD24nuNZMlHf3holTT9IRanSLOvnqxNdd9gi4IIDRpz8zVIKvPR/665f6GydoGDz1dIJGxcLh8mwP4j1qqNdjLzMb0FojPKPn0wqIwXh7hQO6BUzO5FY1MRtaH7CJLuxC/P5AC0Iyppko8fvZCQOhJ7PLiF1JnNBxelM2NxwQqnCaJShLfMGFfUJ+2Qk0OrJqSvL2xRBJiEDzqISHOf0aQZ1vDs1ZBCiZv+hfiQNbTNlTmVa0zmNev5Jkntweh6iv0TsLbkotqvJM0CE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaad6dd-4ddf-4bd4-4372-08d696876189
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 16:29:10.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1749
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - fixed title - added correct macro;
 - revert the removal of a new line;

 sound/soc/codecs/pcm186x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 809b7e9f03ca..c36a391fec8a 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -42,7 +42,7 @@ struct pcm186x_priv {
 	bool is_master_mode;
 };
=20
-static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
+static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
=20
 static const struct snd_kcontrol_new pcm1863_snd_controls[] =3D {
 	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,
--=20
2.17.1

