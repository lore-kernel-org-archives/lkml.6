Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A219ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="e50R4Q4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A884C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeJ0Cwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:52:41 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:50723
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbeJ0Cwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXcLdlDZmzJJv/D+g1XDg08pZjMx2Bcdm8iB8qK4fWU=;
 b=e50R4Q4IcLzhXPudGkVZJt5SIeVB6NSOwnvYqCIzQFt9dD+PixYulMwekg31J8cUI0xjuFnu9MmACoOcScGCW2VWZvfQo8/XvP3POQUIvfDDp1so2MDV9PsO5JoDDthxMMwGJQgAiZ2MFjcY9A3N4sTHrNfK4yvFLbh0IBrPAN8=
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM (10.172.129.136) by
 HE1P190MB0156.EURP190.PROD.OUTLOOK.COM (10.172.131.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 18:14:35 +0000
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f]) by HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f%11]) with mapi id 15.20.1273.022; Fri, 26 Oct
 2018 18:14:35 +0000
From:   Carlos Iglesias <carlos.iglesias@emutex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: [PATCH 0/2] iio: pressure: Add support for Honeywell HSC SPI sensors
Thread-Topic: [PATCH 0/2] iio: pressure: Add support for Honeywell HSC SPI
 sensors
Thread-Index: AQHUbVe/d0nqv6IrMUm049Sd4vpOuA==
Date:   Fri, 26 Oct 2018 18:14:35 +0000
Message-ID: <20181026181406.14545-1-carlos.iglesias@emutex.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:3:c9::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=carlos.iglesias@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1P190MB0156;6:Fyc4ByMrPTJsq8KdU8rnMQWgU8CQyX17ahEof1E16pzeqWEzPUPT5Y/ek9k0uNoAmruaIsAb+hA4NyylOHDJ3uxwH/jcXuWcm1nqJ9KEaxeHI3Ztd9LU1joLVNXX7fu57n63/lR/6LvczL/iFy0yvZstjZvae6cbu3UesySojXZ4mwG92hdHaGttZeyamDp6MbeeUXNIXKUi65IFFM9XR527ELNrxW2gJgFJhT2ih4cmdGq8imDin3DId5tnEMW8VMEywXSuT2rg39y2KqWo3b6H3dsYpoO9rNwrE/TVGgf9jLpVQjRosxGfdFJlyZeaWvWvl01mqt5KcknoggdK4qKDnApyZG2rh9/UuhdyzTVIvOGUyV0ZFqbfY0JVNxUIxO003iD2YDXwwckN5MrlZSmhqoef7P0OLcGGMbYBO3eXJiRmw/8SwSnE9GM8RPcL12wXZTsK/Ue+xro/8h48cg==;5:vl+chJCc/soyFu6jDIJ8oiRXuFdUSYh833UC35S7U4L4DZWFlwE20oU6IferCOzM4mYo0zx8R+znU7V94Ct+ARtVpDnt9z3GKwBxegKnmPM9I5Ufg5dLiNpzphRlRSk7xGMvaBSDg+fheRwKddig2e9Sh7QAMM07EfzTeQLhqxg=;7:6xvkMYosZdQEzdQuCXNVQt7/LhYJAWVkEvsNqc4uXnS68c+Xs1kAIPCnKx1k8z1po34sMnDZyaA394/qWskIe8I0eo8ZoFrkcAauDmdKGwsoN4EJqxjW5iVzfwQo4Ed6lmoCSJ6WhHQUBVXUbFdsmw==
x-ms-office365-filtering-correlation-id: f2633975-ecb4-4968-8a03-08d63b6ee20e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1P190MB0156;
x-ms-traffictypediagnostic: HE1P190MB0156:
x-microsoft-antispam-prvs: <HE1P190MB01569BA6C3AB30AF3A02A48980F00@HE1P190MB0156.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(183997775992400)(93747276172241);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(20161123555045)(201703061421075)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1P190MB0156;BCL:0;PCL:0;RULEID:;SRVR:HE1P190MB0156;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(199004)(189003)(53754006)(14454004)(53936002)(106356001)(55236004)(105586002)(71190400001)(99286004)(2900100001)(386003)(71200400001)(6506007)(8676002)(81156014)(110136005)(81166006)(8936002)(54906003)(25786009)(52116002)(4326008)(966005)(68736007)(97736004)(5660300001)(508600001)(186003)(2501003)(44832011)(66066001)(6486002)(6436002)(26005)(217873002)(2616005)(256004)(2906002)(5250100002)(102836004)(486006)(476003)(6116002)(3846002)(86362001)(305945005)(7736002)(36756003)(107886003)(6306002)(1076002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1P190MB0156;H:HE1P190MB0011.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oV4CuCJltARSK4Spq6wWUpI7WVjSod0aq/u2xPLw8aJSI89JEPu5OvniQm4Ezv+Gse+lAPydSqhks9D5U85hXqSLlyS6wXE3XJUQ8cN0MFiuf9kBkNs53veaaVqIGQDnPZ60RjNzckqEwAlZod241Em8yhxCkfIM1A4JlnD30K/AVQzPYhGF72frdDBSirfxwfWsJvkwWHj/a+AikZE9jqIyYWu0rzRwHgeIu/0t0GRFtVNptOt98xLYX7JotPy9aZF7lwyygSR+fj81yTEtgUMe+IwQBhNwKt4FVOfEGUxpcaYtOB8GbFXWwgGTRFEtno6mRuBx6JJO//k4L1sZC7KzmPP8+0LYG2Pq+w7E1Dg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2633975-ecb4-4968-8a03-08d63b6ee20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 18:14:35.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Honeywell HSC is a series of pressure sensors that provide different
pressure ranges and measurement types (absolute, differential, gauge). The
available output types are analog, I2C or SPI (see [1]).

This driver provides support for a limited set of the HSC sensor models,
namely the absolute pressure sensors with SPI interface.

References:
[1] Datasheet https://sensing.honeywell.com/honeywell-sensing-trustability-=
hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en.pdf
[2] SPI Communications with Honeywell Digital Output Pressure Sensors https=
://sensing.honeywell.com/spi-comms-digital-ouptu-pressure-sensors-tn-008202=
-3-en-final-30may12.pdf

Carlos Iglesias (2):
  dt-bindings: iio: pressure: Add support for Honeywell HSC SPI sensors
  iio: pressure: Add support for Honeywell HSC SPI sensors

 .../bindings/iio/pressure/hsc_spi.txt         |  85 +++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  10 +
 drivers/iio/pressure/Makefile                 |   2 +
 drivers/iio/pressure/hsc_spi.c                | 543 ++++++++++++++++++
 5 files changed, 646 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hsc_spi.=
txt
 create mode 100644 drivers/iio/pressure/hsc_spi.c

--=20
2.19.1

