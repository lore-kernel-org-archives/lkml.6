Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F00DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3722419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rmy97wDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED3722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeKMV1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:27:03 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47164 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbeKMV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:27:02 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="24030069"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 04:29:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 04:29:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daBDnN3ug48e/038GDMDyJG0vx4jS2TsNAxFsVEhaiQ=;
 b=rmy97wDNQLLXAP+Wd404tvfIvhy+AY7Pye0ZpDmsyRB0A1ikyzTG3sM14DQlSYfx77wDYxq7RWADqtue2wm+e/loN9Bq6yrXfwmz3zGuHnoh9cCZmiBW+BJNfecAuW0AZB1vVBUCHzoqmo0FgjU6stRzFmjYF+/s94+2ciXDr3w=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2353.namprd11.prod.outlook.com (10.173.200.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 13 Nov 2018 11:29:16 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 11:29:15 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 0/3] add support for MCP16502 PMIC
Thread-Topic: [PATCH 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUe0QbkWE+TnSH1Eeh4ok4lo55tQ==
Date:   Tue, 13 Nov 2018 11:29:15 +0000
Message-ID: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::29) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2353;6:TF+P4VGeIEP3dx2rnNunMWFILNC35nW4QhOmYHec7x/w6bhIIkhGx64XDceSTIV5KUlJMAEZTYZR0I4dkjgWvfAM7+6mGLK3FSIWmS1Bn9Df6ZVmKJquZabQL1bBK9kJCLtHm4opNEk8l9axus/LzSVBouorHKW+Jm4nz6tQ+d4bwdrPStGpEWavfst9t6aELHS14Mpms42PI0WI1TLk1Dy/vUbUt5baQAP5pUTBDpXF49q+r1BPcjfd/tse/R+FbLHGN5tnlZOgblRSbCP/x1+YtUE3OytH8Tbv9xXx5dlHTkQc07+JGajTynTsfLTEUF1p+zwKh4G3gOjjdr7lK4mNJR207+CZNgpGVza1oYS7uWn8FgUgirYYfzn0qUUk11i08NAGTvhHmTFgG2hw2fs2WhiovfsTNt20F5HipP+m/EsoBTSA1zO+xNN9Lv8cRIgvKMDnGFRDAdVM3+UWFw==;5:c1tnmC5ZiRqABpxPEUwpZsJzQzaLT0rh6zs9cTHcwlf+XX7vRr6JqfH4BMw1B+LWiGzNc+iZiZyVACgzGx9gVcjJgRNdV3C7bBZD40fnlJZayzS96TUkzgpeE4OThriBBRpTQ69qHoohMy5eY4soaj70DV+TRAB+LeRrwU8BfkU=;7:xy2UOyJXmNQGWeQWIIWunW9S0tf9QkJ3vYJN90CyUPqU1UXMX43B9BrzZWS9mtMrIR9I0hjAlwrSfX82W1TM7tcsv6QfUFr2zamhBIfptEyU+GEcYMnn/q0jyWWyYreI/wZ7KzCJb2+aDS2spk4h/w==
x-ms-office365-filtering-correlation-id: ff279ad0-1f2e-4a16-18d1-08d6495b3e0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2353;
x-ms-traffictypediagnostic: BN6PR1101MB2353:
x-microsoft-antispam-prvs: <BN6PR1101MB2353304D09F7BAB800934BDCEDC20@BN6PR1101MB2353.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2353;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2353;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(36756003)(72206003)(305945005)(110136005)(54906003)(107886003)(14454004)(53936002)(8676002)(478600001)(7736002)(102836004)(106356001)(26005)(316002)(105586002)(6506007)(39060400002)(4326008)(86362001)(386003)(25786009)(97736004)(6436002)(2616005)(476003)(486006)(6486002)(2900100001)(68736007)(71190400001)(71200400001)(256004)(2906002)(66066001)(6116002)(8936002)(3846002)(6636002)(5660300001)(81156014)(81166006)(52116002)(99286004)(2501003)(6512007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2353;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qb0jMyaGYbRNJ6deSPN130wmUKqo+FiIyfDrCKifF0EqLxqnVWo4d6hgKg6VKAi0naXMLirU0y3SKc6HZtP4XnwVYTbR+cJSU0Pqb7qiAsyqpDjBDctBD8HusrPvDnKcMBloW8g23uBso603AbmgORQVylBnEIX4EpUnjkJ+mjGjjXsvtcWRUTp2nW3aWuySSZsC8bqwZdZfgTLNbuGfZe4W7RWSY0F2umATyf7Pfuv0hJhKxS1+C0GvWtMGcM2A9mAsxUA2u0ZKYtr7fGSewUtQmC07c/bmGYwHLZdOBrcNl4sH+gbEV3BK3r3rnhkAuh26WmjgSDoz0uD/yk7t+acH2bi4ZE+HnHcFJ/CIa4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff279ad0-1f2e-4a16-18d1-08d6495b3e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 11:29:15.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2353
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

Andrei Stefanescu (3):
  regulator: dt-bindings: add MCP16502 regulator bindings
  MAINTAINERS: add maintainer for MCP16502 PMIC driver
  regulator: mcp16502: add regulator driver for MCP16502

 .../bindings/regulator/mcp16502-regulator.txt      | 107 +++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mcp16502.c                       | 524 +++++++++++++++++=
++++
 5 files changed, 648 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

--=20
2.7.4

