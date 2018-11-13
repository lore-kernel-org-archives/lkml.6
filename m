Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D49C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA0223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pBVAEblz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA0223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeKNAqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:01 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29739 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbeKNAqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:01 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="22763947"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 07:47:32 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 07:47:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8pMBFZBFc+bk2SeiaW6iLpi6ZHSKGfKJXKofdnWkhc=;
 b=pBVAEblzr8EIhbnz8idVRTmfZoysjeb+pkqvTJ/UbWy1YL+ouVbeQeISh2wUdwTxakJwVEnOgzoa6eaqmSD3bi4Ce9N1iNpKSwZe1t82wJr1iechiPGFmDaOgWx1jK3itA0CJuQ2aQO9exsIwsfw8MmlTIMpMbd0Wkv8Fk7NNy0=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2131.namprd11.prod.outlook.com (10.174.112.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 14:47:29 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 14:47:29 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 0/2] set regulator constraints for standby state
Thread-Topic: [PATCH 0/2] set regulator constraints for standby state
Thread-Index: AQHUe1/MgNIcF0nVbU+jtd4cXVtnSA==
Date:   Tue, 13 Nov 2018 14:47:29 +0000
Message-ID: <1542120469-15450-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0057.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::19) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2131;6:3ABpvArL9sPgQJQSEyBmh5P0/1NB2tgK1YPZ63kJTJ6XISYl0N/g3ubxvLvFfWTSnz2IZemXYHqxcvDRhILlqN1+SPyhIsFqK/rEV8Hz+8h7t9zz1xN4i/gxz2ChOxfeo43H3amj9obqrkrrDgHphdQJsn7vETXEZnClrdorABCRvcFTtALmoi7ECC8MkQzWk2XlRhbsytBGhC8JzOnax5q3fcA1qTcJcUrJ+qooaFPB2b3GUBHkV/1meE60bIxrOJbQ/oNtXuOJ+FiASui0kV8UwlQ1PabShD/Bk8j1Vy2arPrV3DdJwEifniwXkO7dfmnIf5YSmIUJB+U2TmWHBIfYFSfw5aJzJE7kr1X13+r0PwXs20jlb00+KVouYtKC3MxL6cMwKwEyStpVAUjdosq4316ksUEio9XgdGRGTrW7ns1j6ctlZIKFIqqigYVZ6XJSo8+Z0YHSJ2pt0czu3A==;5:JsqwRPpN3oXilX5Gjx3Nf+J9oVfXclTztdCjepK71EqUwmpi+ySwtIKUYw5hdP6DFEFWZupfEmtg+auSzpE0p/1U35UqcAKOoq0OckvBImGHHIwEsB8gyEBurpZe2MAkjq7MTHnmYISerkhrKr6+Xe6lPsMvOY+ntIkzdxbBmgk=;7:bi6R23dOOf7eoOspv6aIFZoEZ28faMcdLMBsGYSwESk9OhdyXCMXCV+TLGqFZZ1EjjKP4usDXexDokXuZpiNEJKG6tx8BZb4uh11YbhZYVtIdw51Sg5wvsANEdzi0i20/eBJwokWhL7fhyPmCWhM6Q==
x-ms-office365-filtering-correlation-id: 0d04746e-2136-4fe7-8e2a-08d64976ef0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2131;
x-ms-traffictypediagnostic: BN6PR1101MB2131:
x-microsoft-antispam-prvs: <BN6PR1101MB213106B9E73C27C68255FC6BEDC20@BN6PR1101MB2131.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2131;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2131;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(39060400002)(2906002)(110136005)(54906003)(106356001)(72206003)(99286004)(4326008)(26005)(97736004)(386003)(52116002)(25786009)(486006)(2616005)(6506007)(14444005)(476003)(105586002)(102836004)(256004)(478600001)(3846002)(6486002)(86362001)(6436002)(8936002)(81166006)(66066001)(81156014)(107886003)(36756003)(71200400001)(71190400001)(305945005)(7736002)(68736007)(5660300001)(316002)(186003)(6512007)(2501003)(6116002)(14454004)(8676002)(2900100001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2131;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KQ1VfRqsS4qhDvCnMm8MNkAQccWs4LHcSLCka+EZ+5bAHXF/YMMmCj9vVTW/LJAFdbnwOEZ77/kIhRgCcs4k/Eq2DbuQES/cTsDgy+NUX2AwHmaKH0km7pzXi1bERhgxEMy9pIku0uuoPKXFZw9rHIdSBB+lTIAe+9W7QXw6RDeT93hsE5ERemYbFnz1jk0HLpcZFjsmxaUxsxgZVzFoAeUDnhdFFGZkPlp0dcwdPhuOV4EUKieIrRkAXIAcnVqrIbXInnh4G8VWYbkm7B7vVSLxB2xjWZlVa4bEhy9X4wVGZq68G4HRoCDeDe2alysExGq2NfzyUM8sePhGYZAszKqEj02GtGEPczO0j4F85TE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d04746e-2136-4fe7-8e2a-08d64976ef0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 14:47:29.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2131
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for setting the regulator constraints
when entering standby Linux state.

The new bindings are called regulator-state-standby and have
the same syntax as regulator-state-mem/disk.

Before this patch, if the regulator driver implemented
set_suspend_voltage/mode the rdev_warn message: "No configuration"
(drivers/regulator/core.c:suspend_set_state) would be issued when
resuming from standby.

Andrei Stefanescu (2):
  regulator: dt-bindings: add regulator-state-standby bindings
  regulator: of: add support for parsing regulator-state-standby

 Documentation/devicetree/bindings/regulator/regulator.txt | 5 ++++-
 drivers/regulator/of_regulator.c                          | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--=20
2.7.4

