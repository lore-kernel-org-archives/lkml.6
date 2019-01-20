Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36844C676ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09222087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UQjyP8Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfATP2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:28:44 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:13586 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfATP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:28:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,499,1539673200"; 
   d="scan'208";a="25548231"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 20 Jan 2019 08:28:43 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 20 Jan 2019 08:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXfMB9d3m9ilpWm3ndn7RYQk/dWNul9beq1VL2Rrk2w=;
 b=UQjyP8Me/aJVoJ6NMtJNOYwuB1qn8kYM9E2rShgEKAEVvCVeNdZ5ysa46jGHJqFgdH6HpBWXXNYNxttq9gA8Db/PYeoTePMgTej+R030dVu175pRlCvsyXkvS5sKLb1MBSpOO94dOLpcS+j+fBBFfJefmwmdiejLobjBDZ+pQZU=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB0074.namprd11.prod.outlook.com (10.164.155.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Sun, 20 Jan 2019 15:28:41 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%10]) with mapi id 15.20.1537.031; Sun, 20 Jan
 2019 15:28:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <bbrezillon@kernel.org>
CC:     <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Thread-Index: AQHUrYaDrXUj68GKYkqwbPlWtM/dE6W4RZ4AgAAI8IA=
Date:   Sun, 20 Jan 2019 15:28:41 +0000
Message-ID: <353a011e-920a-ddb3-4eef-e3256555ac93@microchip.com>
References: <20190116103027.22657-1-vigneshr@ti.com>
 <20190116103027.22657-3-vigneshr@ti.com>
 <6e6f7c3a-4772-1a17-0f5f-547ea9809283@microchip.com>
In-Reply-To: <6e6f7c3a-4772-1a17-0f5f-547ea9809283@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0110.eurprd09.prod.outlook.com
 (2603:10a6:803:78::33) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.121.188.235]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0074;6:NC2dR0CVFCMWWla1c9yg/SCAq63N3UYHG8HLSfwFr7qAMZDhR6EpStSlKcZk49DL9/ifv4yTqum8P4s8rhXpoZ+/JV24JtwkgvJZZJr/HHEmwNh43sj0LJ7VHldSdDU3j322zLamfUGilGktb25VrMCA/Ug8PUcv6yjJF8ojtbX+3Mj+UwXeICu+o+jdmkGvY1D9ghpF+XepSoq7NKYAHLrd+HeFPy6I4pRanFYWzsy60YUJuC2Y+wjpgn1fGlU6IjLTV8shOBMCQ4UuVA1m3IggjveexAf7sNajFYnSOXxW3WvKJJY/hV8PF7BVTzKukj3BYC1VrE6u/0ExrcjX5lUw1Dq16yzxVLy4LqUtjB/mKdSzC5hi4VomGG5g85eMjrRMl7iY7XRrxzP3bk626ApIN0a/ON2a8PZeDvjsp42vWlBbS6UFjh8cRaJWVRjxO0mKbmG9MyAakP33imGCew==;5:SSf2anu+QRoTQLUYTn4is4wYeyNOELkBdxZ6Jy1x1r060A2xfICUs84hsfAVzNR0wwrTeEd48yZNRcGWdoXvVbpN15EmPNa280gICeGuVmnU5SzSXAE/XPlyEt1uXKGBZVlLTUQdYcuaqVCc9144gH3Z9fsy5p4aon8eAkYGI4KGIBI9dBmbM4uz+uBs+PumoI/CDjFMSvtqY8GqomcC5A==;7:2JhgGy8H9fUUaRMXEFrRd2F07q+AQFe0+Vv9EwchYYr71xw1rm1dYu6xHurvi+wJtXmrveC7xOSmTmleDv0coCGgauAT+diVcJsRjuxu2Zw7jnw/vC4WBMqgzYRcXqVIWLrsjEL+/MFYkDCp+VUBLw==
x-ms-office365-filtering-correlation-id: 484cd0df-2bcf-45ee-55c2-08d67eebf4ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0074;
x-ms-traffictypediagnostic: DM5PR11MB0074:
x-microsoft-antispam-prvs: <DM5PR11MB007403D01A89C4A03FB02489F09E0@DM5PR11MB0074.namprd11.prod.outlook.com>
x-forefront-prvs: 0923977CCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39850400004)(189003)(199004)(53936002)(7736002)(4326008)(305945005)(72206003)(39060400002)(8936002)(8676002)(2501003)(81156014)(81166006)(14454004)(66066001)(97736004)(6486002)(6436002)(3846002)(6246003)(6512007)(68736007)(229853002)(25786009)(6116002)(478600001)(31696002)(86362001)(256004)(486006)(446003)(476003)(2616005)(54906003)(110136005)(11346002)(71200400001)(71190400001)(99286004)(102836004)(26005)(386003)(53546011)(6506007)(2906002)(76176011)(52116002)(316002)(186003)(105586002)(4744005)(106356001)(36756003)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0074;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cqpnR9/R0Iw1DUeOlQV5W9q2GyeTjpfouop0upKzoSW+jHZAF0nBbgqnz2Yd1IIMKnQ+O41hdf71JrkGBHe4seu+lIWMgo3NnVNW6S2p/hZ/6wYHtGKi7fKQH1R3yfOF/p0BK0HD1IA5Cui1z3UM6GiIAIhpOjTZY5oVELbvBC9R+Rfgh/n/DGNEopBP+j+Wxwh77AZlSxUBhER8xxgM6nQk/SVuuEF6H+cCh7SjSmV5ZG51/jj0sLIw92N1TSgMEY4CtV1gJD8cftUv21SKCKXVg/ivRpmXGWESu7gJxPJTd+1dcFsPgRUBksN6LPvxgANtPLic9/u1p3Rd4RyvqFCpJ2wroxWbNvpfiSVgVaHUlajgAUrfuRil/q3ZJ/APoq7NrMRk/nC5eaVDzYTlTF/PqIdOqSaAYzZboJI+hi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5903957AF0BB3B43B3CC4DD8CDE1F107@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 484cd0df-2bcf-45ee-55c2-08d67eebf4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2019 15:28:39.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0074
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmlnbmVzaCwNCg0KT24gMDEvMjAvMjAxOSAwNDo1NiBQTSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tIHdyb3RlOg0KPiBMb29rcyBnb29kLg0KDQpvbmUgbW9yZSB0aGluZzogaW4gY3FzcGlf
cmVhZF9zZXR1cCgpIEkgc2VlIHRoYXQgdGhlIGR1bW15IGN5Y2xlcyBhcmUgYWRqdXN0ZWQNCmlm
IChmX3BkYXRhLT5pbnN0X3dpZHRoICE9IENRU1BJX0lOU1RfVFlQRV9RVUFEKS4NCg0KU2hvdWxk
IHlvdSBhZGp1c3QgdGhlIGR1bW15IGN5Y2xlcyBmb3Igb2N0byB0b28/IEkgdHJpZWQgdG8gZmlu
ZCBhIGRhdGFzaGVldCBmb3INCnRoZSBjb250cm9sbGVyLCB3aXRob3V0IHN1Y2Nlc3MgdGhvdWdo
IC4uLg0KDQp0YQ0K
