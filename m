Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BA921019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fEE5SHaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfAHK42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:56:28 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28496 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHK42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:56:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="23118873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 03:56:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 03:56:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBhzeiq+wc7kA0tjwTg8O2rWiUCCpBEfQ9lTSrsd3mQ=;
 b=fEE5SHaQtnn/VFnn0MwwLPrhlpCCx04EBfkkzwy7uF5eLOKnPsrPgrQgFa9FrhN93m2Dbly6ppvtSClr75eY8NxUVq8GbCahKsbrWg0BbyeW8kawJ4KawEkqPz/NIi9Ofs0GjP3oQ6Jt/qt1cHxkQ7bdw/HJJpAGUeuAJ5ZGFGI=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1399.namprd11.prod.outlook.com (10.173.17.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 10:56:25 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e%9]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 10:56:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/3] add support for power off check in suspend
Thread-Topic: [PATCH v2 0/3] add support for power off check in suspend
Thread-Index: AQHUp0DMK00T01NVNECI4VrUGS192w==
Date:   Tue, 8 Jan 2019 10:56:25 +0000
Message-ID: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1399;6:FHYnrGD6uYsprzMhS696lyJIqfttbWsl6zplpNNW3iPPjVBiVTGjZ38qtwJg16HP2HDVEvWpLUPicXcsWTn+Twr4tYdqIFHmA5hAAw0tfoTMn7NzPkBXe4fEWK+wg5ns49A/f3+PjwX0pe8Inl1LvDe/P8kvmMYW39otHMfpLOcnsVmScHNva0ph/kLJFVuo1AwB3HkQj1g+Q5F+gLSoZTK0QxdgrsgL94spCS5sfy7/74ufyJAdYXpLbgnIBZsYl/iVHgctMWnRhfgJDVQ0E0vV2Uy50yj9hyKQSuW7ppuYF2eeiebYe6RLE6yaJZWAP9EDvi4HheLk+X4MykKYVmkwceKMi5/TT6bUUjfPD78KBSOwL5WRN79u4BkozXTo4mzKSkOG97QwPqYXLjdbhHgI7QKJT3WewGsiCajZowSJaU1wGPLco6YBpGyTNg1QG07JWN2+OWp4ZfhFl/YzYA==;5:9XdVJJN7BUKwPYHkbyE3VjKfhgeAXuIxCDAR6pBzw5e6BFlJEVYt493KBOIJw6Gks3DlMd2wvMnnizh1u3DyE/rs7ZwFuvhkG5fNd49dL5YhadYUDyiZuFdQxvghDt4sumZV0HcCMbK9UUBfxTI1JJEci1zaRGVB1Poll1s1O023HLgSDgymWujOgvT/U4ZtY6rXtBQ3a4BsyJ1SxdQgEQ==;7:0t9Zm4RvcjU8d3CRyUiodfDv8F6OdMLgqe/bvGeSFP4lBx77H6T5guDqr+HJpFI7NINBjbmmiyCpv5MNklbHAh3iChRbmYkQlB+jFYnupU6jvG3Z+9KajHDjtaEnvBOtzcnI78fztovQy89RRC7hdg==
x-ms-office365-filtering-correlation-id: 8b81da9f-eda0-4331-ff62-08d67557ef15
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1399;
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB1399E9FE5FE3932ECE5A169C878A0@CY4PR11MB1399.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(6512007)(966005)(72206003)(8936002)(2616005)(476003)(102836004)(478600001)(97736004)(36756003)(256004)(14444005)(86362001)(71190400001)(2906002)(71200400001)(66066001)(3846002)(6116002)(2201001)(316002)(54906003)(186003)(2501003)(110136005)(305945005)(7736002)(14454004)(6486002)(6436002)(8676002)(7416002)(6506007)(386003)(81156014)(81166006)(5660300001)(25786009)(99286004)(26005)(39060400002)(107886003)(15650500001)(106356001)(105586002)(6306002)(52116002)(68736007)(4326008)(486006)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1399;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7dR9cfVlszI56Xc1M2xtr+ECIgNJAuna2nKF5UT23NaeTn4Kk7ebVL6RSK2bYhLgIwHrToYpqmLLGJb71/HSsSBv2eM4vIqwM8XSROw2KEZKpMFi3BIDd2QB9pWs+ehgrpwXbEcpanj45wqZz4ka3r5L92MrSsh3VZa6+fOjIdQk7u1/eoJkYjV9ipZhvpCuUfOuk7oOpP4Ib+k3Oozs005Pz/7IuTTJU4nbpq5FNQLkP44roGpL9YW+rLlKTocCWYIsu0O9UeFC7wDYacb/FwIwB39CugPyD4tGmOn+lIVT9r1wrpTV5ujLlYxsyByi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b81da9f-eda0-4331-ff62-08d67557ef15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:56:25.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

AT91 platforms support a power saving mode where SoC's power is cut off (we=
 call
it backup mode). The resume is done with the help of bootloaders. To be abl=
e to
suspend/resume Linux to/from this mode all the drivers suspend/resume callb=
acks
should save/restore the content of all the active registers. We have 2 prob=
lems
we are trying to solve:
- some of these drivers are shared with other non Microchip SoCs (e.g. macb
  driver) and we don't want to disturbe other users of corresponding IPs wi=
th
  all the register save/restore operations;
- the suspend/resume time for the rest of the power saving mode we are usin=
g
  could be improved if we would know in drivers the suspend mode the platfo=
rm
  is switched to.

A solution that would have been solve our problems was proposed in [1] but =
in
the end it wasn't accepted. It ended up with the introduction of
pm_suspend_target_state variable that could be used along with the changes =
in
this series.

While the discussion of [1] progressed it has been proposed (in [2]) to
implement a function that would tell if the platform's power would be cut o=
ff
at the end of the suspend procedure.

The patches in this series does as follows:
1/3 - add a new member to platform_suspend_ops that will tell if platform's
      power will be cut off at the end of the suspend procedure; drivers co=
uld
      use it via platform_off_in_suspend()
2/3 - add a new function to regulator's core that could be used to check if=
 a
      proper regulator has been configured (via DT) to be powered off in
      suspend. This is used on this series to check the CPU's regulator is
      properly configured in DT to be turned off in suspend.
3/3 - fill .off_in_suspend member of at91_pm_ops; the functionality in patc=
h 2/3
      is used to double check CPU's regulator would be turned off in suspen=
d.

Thank you,
Claudiu Beznea

[1] https://lkml.org/lkml/2017/6/22/938
[2] https://lkml.org/lkml/2017/7/16/457

Changes in v2:
- remove !! instruction in regulator_is_disabled_in_suspend() and
  at91_pm_state_allowed()
- s/weather/wether in patch 1/1

Claudiu Beznea (3):
  PM / Suspend: Add support to check if platform's power is off in
    suspend
  regulator: core: add helper to check if regulator is disabled in
    suspend
  ARM: at91: pm: add support for .off_in_suspend

 arch/arm/mach-at91/pm.c            | 61 ++++++++++++++++++++++++++++++++++=
+---
 drivers/regulator/core.c           | 17 +++++++++++
 include/linux/regulator/consumer.h |  7 +++++
 include/linux/suspend.h            |  6 ++++
 kernel/power/suspend.c             | 13 ++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

--=20
2.7.4

