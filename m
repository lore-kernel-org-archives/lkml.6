Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73AE208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R0ZkrKk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73AE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbeKNUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:45:47 -0500
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:38909
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbeKNUpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rZTAp6OZFT3Q8hjqdhnAjS5GWpb6DmfbMOAXmWJwUM=;
 b=R0ZkrKk4/tRqaG4Il3JkvJyJny07uCzo8HTlMjif95JD1+Mv5+iyFgMy4S9DXYT2hFcviig3o0DMd0YUwQBVzKeqTETv7ycul+0g+LIUuMwCCl7xQj0JMNWmQxZLDw695PWMIBrA+lXMpqI0/dmZ775guwLrPSCOK11iypDg2n4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4095.eurprd04.prod.outlook.com (52.133.13.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 14 Nov 2018 10:43:00 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 10:43:00 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUe1duroFEkzCsFkCoS8/TUWpV/KVO8aOggAAF6ACAAAOAgIAAGyKg
Date:   Wed, 14 Nov 2018 10:43:00 +0000
Message-ID: <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
In-Reply-To: <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4095;6:AXSeVahnNyS4gp02DZFabJz1A1YEjBDCG2gn1huqW/zBkCYeSAG/g1EOyNYukS4EVK5sg3exVVHEz1HQ/J9JDxjbAGk53WRA4FRv3JlEX0iTYj+/nGPUdhFe8AMzMef/vWVsvuOPJpMvTFvFgkdKiu5vNXSFImTpgEiV+JcLobPaadU1GHPFOabZ+n2gXAAr2b3TAYa6cD4HSjnIEshgPHjR3OYJCke7wpTabRHAaMjYOj3mXf1lmQhnSJrRL14s89x27ZPJF7pyjA8QhCmLr6PxEjamr7eqgIm7zJLqMHwiBBkHegC/p4jeDpD79ZheW3Mz63FWRkMmk0L3x2KWn7MqP0CdrxWbzQhMKPra6/j/RArVb+2Gs9RcSV7kk5jl5FMs3i47eSXBVjT7eq/NAit07p2vR+9EtK3fQk0ogtx20OzPFwV7f1owSMa7IfPGCUw4ZL1nTPUeRKGGKNY1sA==;5:goXdzp8oZK00Y63SXQw86kObbTILA4Pn7C5CGflIjs7j286Zslcs8MxHxQrS/dxMy7lrWX6y6Kc90ZCgRo35OS19GtT1TslXGMkR02zPH6Ik2l9i7oE2NKioZcUVjfyVQfKc5fcX7BqcPuLPC58VPFSOIrkM4P+2yFDYcJNpLoE=;7:zie5E7N4w+FIJZZyj1Eni3hYZUNgwbBMMEKc5tbnfMlHO0/MzWLhg9z4giA0ucJ3zUcIT4KNfBPO2RFOr7ScSXUTVfD+DzYVmyOO7JJY5NPjdLyeyDCTMoAzNpER1rjNvquwDJZUejrzQltuDIKl/A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc18a1fd-8fdd-4dc7-d58d-08d64a1df2c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4095;
x-ms-traffictypediagnostic: VI1PR04MB4095:
x-microsoft-antispam-prvs: <VI1PR04MB409544F4C7FCA685FAA3DCE999C30@VI1PR04MB4095.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231410)(944501410)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4095;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4095;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(199004)(189003)(14454004)(7736002)(39060400002)(8676002)(55236004)(256004)(14444005)(76176011)(97736004)(6506007)(6246003)(305945005)(81166006)(2501003)(966005)(2201001)(8936002)(105586002)(99286004)(110136005)(86362001)(316002)(3846002)(7416002)(6116002)(68736007)(66066001)(7696005)(78486014)(4326008)(25786009)(93886005)(486006)(6306002)(55016002)(54906003)(74316002)(6636002)(2900100001)(186003)(102836004)(9686003)(229853002)(11346002)(53936002)(33656002)(106356001)(6436002)(2906002)(446003)(81156014)(71200400001)(26005)(478600001)(71190400001)(6346003)(476003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4095;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-message-info: YPLSsaTVAtwRu+m2bYMRX8JwiW153Ma0HGkdwn7GdCVmwLT0Et38Eclc3UdP/UdUuA9KZ6mm1UWm0fiRzzifMoBdcLfqaftVxM0sdh2wwP5Iigfxh6QDS+mIHFzipRu7XzhiPo7V0qUjNhyYoDJIDPfZJh4G2syXXtw+49lJVmvhpzf00PPVA900Kfsaf64dR2cTQ/7FQnQnbZcuuSDB/+vwFERAS2UKII54IBndL2ECN1dykmS713QPDnGwCR6+va0YMa1bRV0ZDwK9wkY5hs9F8U0itI1jevPMocZodjBVxeR/27iF+HADcglVgwPjxkKqHAgGw2JY0XOrG3ATQ7mH24tr47kC9sVd/1C8vyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc18a1fd-8fdd-4dc7-d58d-08d64a1df2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 10:43:00.4923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KWy4uXQ0KPiA+DQo+ID4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3
aGF0IGNvdWxkIG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4NCj4gPiBjYXNlIG9mIEFI
QiByZWFkLg0KPiANCj4gQ291bGQgeW91IHRyeSB3aXRoIHRoaXMgY2hhbmdlIGFwcGxpZWQ6DQo+
IA0KPiBAQCAtNTAzLDcgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIGZzbF9xc3BpX3NlbGVjdF9tZW0o
c3RydWN0IGZzbF9xc3BpICpxLCBzdHJ1Y3QNCj4gc3BpX2RldmljZSAqc3BpKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWFwX2FkZHIgPSBxLT5tZW1tYXBfcGh5Ow0KPiAgICAgICAgICAg
ICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9hZGRyID0gcS0+bWVt
bWFwX3BoeSArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAqIHEtPmRl
dnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0KPiANCj4gICAgICAgICAgICAg
ICAgICBxc3BpX3dyaXRlbChxLCBtYXBfYWRkciwgcS0+aW9iYXNlICsgUVVBRFNQSV9TRkExQUQg
Kw0KPiAoaSAqIDQpKTsNCj4gICAgICAgICAgfQ0KPiANCg0KSSBoYXZlIHRyaWVkIGFib3ZlIGNo
YW5nZSBhbmQgYWxzbyBoYXZlIGRvbmUgZmV3IG1vcmUgY2hhbmdlcyBidXQgc3RpbGwgQUhCIHJl
YWQgZm9yIENTMSBpcyBmYWxsaW5nLg0KDQpJIGd1ZXNzIHdlIG5lZWQgdG8gaW1wbGVtZW50IGR5
bmFtaWMgbWVtb3J5IG1hcHBpbmcgWzFdIGZvciBBSEIgUmVhZCBhcyB3YXMgYmVpbmcgZG9uZSBp
biBwcmV2aW91cyBkcml2ZXIgaW1wbGVtZW50YXRpb24uDQpXb3VsZCB0cnkgdGhpcyBhbmQgdXBk
YXRlIHlvdS4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvNTAzNjU1
Lw0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXINClsuLl0NCg==
