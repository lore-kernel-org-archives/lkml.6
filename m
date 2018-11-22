Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF93C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D6620870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ik4J68Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D6620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbeKVP5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:57:32 -0500
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:25760
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729179AbeKVP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WIB6wzI2D3HnpzyfENJLE0D7ao8JKzj7HuYdVReuQo=;
 b=ik4J68Dzpd2+ncdhMMgvu4xDuaIOyO5dRC7iSz391QM25+NkMcwLkMwt0uO16t7DdogP1seNHlBIOkNJWO3EA78MWO3ET6peB+OPqTTkitOiVpAzpp72nTAt+EvFKSYGM1ZEGYkLoJ24a1I0Fd/EjTqU6awuPZ+c4jhRlVbVkwA=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5037.eurprd04.prod.outlook.com (20.177.50.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Thu, 22 Nov 2018 05:19:31 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:19:31 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/7] spi: add support for octo mode
Thread-Topic: [PATCH v3 0/7] spi: add support for octo mode
Thread-Index: AQHUarPy2Onn3VDDqEW4evXD57qOx6VNeHQAgA33KmA=
Date:   Thu, 22 Nov 2018 05:19:31 +0000
Message-ID: <VI1PR04MB572680334F4BF09EDFAE3E7199DB0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
In-Reply-To: <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5037;6:BKwvZsJj0OzSEOW4U3TT91p+xDYvZDQuLHlLsdtGjrNnnIThmkatWclPpvZyxMW+HgBjXgqOurmzfKHHEt1i6RnPYjQz3eSNHBPsIz4qo1Ij2i59rIc3RRKUnyuI/BCWdclQry9GEMQO6tSXoYOj8e01QuOkAd5ime5A7AKsCN+0dE+w3bcXNNYlcIo6y+aZhl+jg0pujp6am9QdwjMGp3f8UnTQK9OaWDcu0FmaROKUmgNKLvWExOiNYvg8KUvWg9eibNSmCnN9EKlmZKGKJQz5Tyd1XJFpnh3SHoUBW010vBqZNPasi8PFRA/Fo53FoUnLCfW0mTepy8PdBsDfZjBj21UQpryeiKewnrF+s7u/wI4R0gn12dM9QGv3Ejp12LLNifeYSH7fDSE0Eo8CfZmVDuTHcCP5BxCcp4WrlEjwX/DoX1BsAdXQEr0HYYzuj2SNCuIpYZLnOZpDf2kbOA==;5:IKNEhrTYtn4k2WgMGBKX9Qx7BlPKhnIBHEeyx9d1P7fhPi8hcbYeRwJeKw5/1xLHZL/0NqD3N+80fpfaRI8OHQzp2+szqRMes3y1hDyjyCewCiYkli+Gr+Bsali3+TYnVUh0T/UXlsIFcESbvYjgqbF1Gv3IyF/RpXqpddZxJxk=;7:Kguz1we+1uMFRbvcMlUz3bQjjHhhdU5BLN9AYl8YjJ0GolISVI8DyA5a6YEYD1jom4VYQ3ECUVqrZS3GIzEMxNhEUPHzJNRqbqMax8fjv7g+y6XeR5yh/eQ/z+E8aA+jGNH1KaO5nrxEYu0KWJ6nvQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4c61eb63-1999-40ea-f20e-08d6503a1563
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5037;
x-ms-traffictypediagnostic: VI1PR04MB5037:
x-microsoft-antispam-prvs: <VI1PR04MB5037C0C716A458617CED66A599DB0@VI1PR04MB5037.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5037;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(136003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(53936002)(33656002)(5660300001)(2201001)(86362001)(66066001)(3846002)(6116002)(2906002)(7736002)(81156014)(305945005)(8676002)(81166006)(7416002)(74316002)(8936002)(102836004)(6506007)(53546011)(14454004)(316002)(478600001)(99286004)(2900100001)(25786009)(6306002)(186003)(55016002)(54906003)(9686003)(6436002)(6246003)(110136005)(7696005)(26005)(11346002)(4326008)(256004)(106356001)(71200400001)(71190400001)(476003)(486006)(105586002)(446003)(39060400002)(76176011)(229853002)(966005)(68736007)(97736004)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5037;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jdDtcZ7mDBlwuSZqkKO3xTk2NsXDI80HpSijwPn7LTZe/W95sjRyAWcbAyv4hh9z8cXRqSDBbudQenrScnBX1cn54M6S/iv6jyMD1lQ+/UrGNOfgYNnG7AHT0EGj/h98g4mStgpPrdkxO/LG7anEubzg/IhNmypdHRNiZKY5smG47TW1wCUtuKGQIox7lErzsJ3V5y/7JJSWqfG4TMAuxQKRSKIs+MX++O+Dw7lkDMDdwevVn/O86CbX/qCKrigNcD2H6mbhJQvqAyTU9+zgX5ih5vUEEqz38yF70uZRcQ/7FJ8wR4CjOVg+FU3QNCa8Uk0jRkYETtfn6Cw7AeaTf1UklYVjSL5Ixplgqxh0PMI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c61eb63-1999-40ea-f20e-08d6503a1563
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:19:31.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWdu
ZXNoIFIgW21haWx0bzp2aWduZXNockB0aS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDEzLCAyMDE4IDE6MzAgUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5
YW4uZ2F1ckBueHAuY29tPjsgbGludXgtDQo+IG10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBib3Jp
cy5icmV6aWxsb25AYm9vdGxpbi5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbWFyZWsudmFz
dXRAZ21haWwuY29tOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBm
QGV4Y2VldC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDAvN10gc3BpOiBhZGQgc3VwcG9ydCBmb3Igb2N0byBtb2RlDQo+IA0KPiBIaSBZ
b2dlc2gNCj4gDQo+IE9uIDIzLzEwLzE4IDM6MDcgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3Jv
dGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIG9jdG8gbW9kZSBJTyBkYXRhIHRyYW5zZmVyLg0KPiA+
IE1pY3JvbiBmbGFzaCwgbXQzNXh1NTEyYWJhLCBzdXBwb3J0cyBvY3RhbCBtb2RlIGRhdGEgdHJh
bnNmZXIgYW5kIE5YUA0KPiA+IEZsZXhTUEkgY29udHJvbGxlciBzdXBwb3J0cyA4IGRhdGEgbGlu
ZXMgZm9yIGRhdGEgdHJhbnNmZXIgKFJ4L1R4KS4NCj4gPg0KPiA+IFBhdGNoIHNlcmllcw0KPiA+
ICogQWRkIHN1cHBvcnQgZm9yIG9jdG8gbW9kZSBmbGFncyBhbmQgcGFyc2luZyBvZiBzYW1lIGlu
IHNwaSBkcml2ZXIuDQo+ID4gKiBBZGQgcGFyc2luZyBsb2dpYyBmb3Igc3BpLW1lbSBmcmFtZXdv
cmsgYW5kIG0yNXA4MC5jIGRldmljZSBmaWxlLg0KPiA+ICogQWRkIG9wY29kZXMgZm9yIG9jdG8g
SS9PIGNvbW1hbmRzIGluIHNwaS1ub3IgZnJhbWV3b3JrLCBSZWFkIGFuZCBXcml0ZQ0KPiBwcm90
byBmb3IgKDEtMS04LzEtOC04KSBtb2RlLg0KPiA+ICAgT3Bjb2RlcyBhcmUgYWRkZWQgYXMgcGVy
IG9jdGFsIGRhdGEgSU8gY29tbWFuZHMgcmVxdWlyZWQgZm9yDQo+IG10MzV4dTUxMmFiYSBbMV0g
Zmxhc2guDQo+ID4gKiBBZGQgbW9kZSBiaXQgcmVxdWlyZWQgZm9yIG9jdG8gbW9kZSBpbiBueHAt
ZnNwaSBkcml2ZXIgWzJdLg0KPiA+ICogRGVmaW5lIGJpbmRpbmcgcHJvcGVydHkgJ3NwaS1yeC90
eC1idXMtd2lkdGgnIGZvciBMWDIxNjBBUkRCIHRhcmdldCBbMl0uDQo+ID4NCj4gDQo+IFlvdSBt
YXkgaGF2ZSB0byByZWJhc2UgdGhpcyBzZXJpZXMgdG8gYXZvaWQgY29uZmxpY3RzIHdpdGggcmVj
ZW50IHNwaS5oIGNoYW5nZXMuDQpEb25lLCBoYXZlIHNlbmQgdGhlIG5leHQgdmVyc2lvbiB3aXRo
IHJlYmFzZSBvbiB0b3Agb2YgdjQuMjAtcmMyIFsxXSBhbmQgcmVzb2x2aW5nIGNvbmZsaWN0IHdp
dGggc3BpLmggY2hhbmdlcy4NCiANCj4gQWxzbywgSSBzdWdnZXN0IG1lcmdpbmcgcGF0Y2hlcyBp
biBbMV0gd2l0aCB0aGlzIHNlcmllcyBpZiB5b3UgcGxhbiB0byBwb3N0IGFub3RoZXINCj4gdmVy
c2lvbiBzbyB0aGF0IGFsbCBiaXRzIGFyZSBhdCBvbmUgcGxhY2UuDQpQYXRjaGVzIGZvciBhZGRp
dGlvbiBvZiB0aGUgZmxhc2ggcHJvcGVydHkgaGFzIGFscmVhZHkgYmVlbiBhY2NlcHRlZC4NCg0K
LS0NClJlZ2FyZHMNCllvZ2VzaCBHYXVyLg0KDQpbMV0gICBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXgtbXRkL2xpc3QvP3Nlcmllcz03NzM5NA0KDQo+IA0KPiBSZWdh
cmRzDQo+IFZpZ25lc2gNCj4gDQpbLi4uXQ0K
