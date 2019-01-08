Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B935C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F047A20896
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qk9QM7dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAHJwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:52:53 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:54210 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:52:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="24774160"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 02:52:51 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 02:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeOVviJMx8m7zy3apbORG52Dq+C/y6Zu7yEfnujdE3o=;
 b=qk9QM7dLhzLXFCGva2U0MNaWq0UyLJz9pGLDakbA8cWBhnGp93jYsZlUks16dNN0U6xRjx+LPswnfaqiwLyih8Qn0uLWKl822MF6kHOt2ogOxcdPJbNi10gsD2vBghnAmbicPnmd8iGmpsst4npYAUXkvFssBhUMeRhy0VVmLgY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1838.namprd11.prod.outlook.com (10.175.53.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 09:52:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 09:52:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/3] add support for power off check in suspend
Thread-Topic: [PATCH 0/3] add support for power off check in suspend
Thread-Index: AQHUpzfpJUVpc7v5lUyWjyJaRbbJfg==
Date:   Tue, 8 Jan 2019 09:52:48 +0000
Message-ID: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1838;6:cNk6721wx+4JZ1CcueHCKckbszTojYtuuRiywq1wTB8HO9firD19E/C6yjXRXxjwM1VIPoPCrWqWtxRoVSJq7pGpv11IEYVVou+nxDhlVuKZYk7oosNknBsjmlltStDrSju9DpL4JgqjvLV1K36Exlm90tG53yHgJDDl6Ys7p0mMz3RqMvRjFwNAc+NzmTHO4G37LdOhDuIGxfd65pNjOeW941erHWMh/r/EONrej44Jh+87FvhT7JJlRfX0crEdAXd/fvNLNywgjyyS3bQktWrhJKWSswVeDN9qELBp2mXTiFyewTF0TUeTc21XTq05o46XY6b+OE2UtZ6IX2+qL7afe1+rf+NVeNiIXle5WhvWXgyZ5ivLCBjhM+g9mm4PuLcOx8rW3lBkHLUx9MNjeM5zc6VUD2xCYR7hsbjgi2bQJiUD4bEgrvfd0N8sLznIGn2L6Ts6b65mhq+7kjP0pQ==;5:eJDUA2Yp3p8ynKxKzhmLXbYNh7zWRacCjoCR8j3SPjv7t1Ao1SNrJfIUFPozKncXkeMlb+K0LFa360AJJwuG88MXF//Jk4Zs6pidhNnSiXCg37447DDXow5ICRfEV1tzmwGIEmFkf5xg/TbuO9imOE1FklpQEFZNz7HExDRYpEcVOydGMbBnQ+i4HmTW9LJ1N9D+6UshBp4+dk6D/M+SPw==;7:xh+jHwgjHNoC/MUCg1EjNMmyvzPg43x0YZC5UNZaB2HV7r58Z3u+Rk5+VKlP0KEBVVSLzbk4x72yUYg3vclrxMg0II6J2JfTmG3eX0yYHjEWZ1eNkmYZbQyf+z1DbpQOUzAbKkF5Djzjioq6K5g1bg==
x-ms-office365-filtering-correlation-id: 3d892e5c-22e9-42a9-abc6-08d6754f0bf2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1838;
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-microsoft-antispam-prvs: <MWHPR11MB1838F988819145A501775550878A0@MWHPR11MB1838.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6436002)(110136005)(305945005)(107886003)(54906003)(6512007)(6306002)(52116002)(99286004)(8936002)(105586002)(53936002)(5660300001)(81166006)(7416002)(81156014)(8676002)(4326008)(39060400002)(7736002)(316002)(106356001)(25786009)(97736004)(36756003)(14454004)(966005)(72206003)(478600001)(6486002)(66066001)(68736007)(2501003)(15650500001)(486006)(386003)(6506007)(86362001)(476003)(2616005)(2906002)(71190400001)(71200400001)(186003)(14444005)(6116002)(3846002)(2201001)(102836004)(6346003)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1838;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +RQf8J8p0VOrVeZ4RlOgWQsYJUS+npslX+rd3MCKw1lIKrkQ/GToYVTfibJL5a8e+tWhDc0YQnBFWLAfpZWPMhUtbFv8Ut6f12I0p1n4G0Nz8h0RCv1NHNZojcp7iGv59Ggh0JNM5/xuGwKMwgLimszJHf0DcsQm/cmN24zwPDOBHTWgvgQB3IQCScT+E0HMbaO5e/HXvIlQfquB+Kl0HP7zh7mNT9OHAIHrlv5JBrHU6rgAqqLDrREQBDvG6E1uEoIJ4QEdvvdveT4rw4SWwYEF9T3WS4uB/fUy5f2VfoO1Eu63fMbdGuI9HemUtSwl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d892e5c-22e9-42a9-abc6-08d6754f0bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:52:48.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1838
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

