Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BE420859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="w6cfWpl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAOHeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:34:46 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:3065 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfAOHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:34:46 -0500
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="25047093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2019 00:34:45 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 15 Jan 2019 00:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F1N4KZNB3CQSGJQYTpYbatumyeMo1LOcPwy/rikmkw=;
 b=w6cfWpl7bIHsGKzOppnKwU4+Wh7FexRKgmQZ5X/Yg0OOKp4PAaWwmINsLTzoaDPKhXJ6P2WpHn8xydZcOXlCyeNjjCgvnnmEMTlKaiPNZu9/fvNzVawCqVlMR2jwv4hpCtL5472KskBtjfidrkd9KQMQgkoHL73mRXIuEDDoXX4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB0002.namprd11.prod.outlook.com (10.161.155.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 07:34:42 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 07:34:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
CC:     <robh+dt@kernel.org>, <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Topic: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
Thread-Index: AQHUq8fEBX41qj7/W0uliXm1OTJOFqWv8fKA
Date:   Tue, 15 Jan 2019 07:34:41 +0000
Message-ID: <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
In-Reply-To: <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::46) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0002;6:T+sAsiP3nlkBMlbf50XzaHe/C1ZD/idyfggomyQ0knybjaA46+wfgHatp1dCbq5rKmcrM1MUMdHpafHV+H808ATCHunhwrWuPH/5vyf/75/aFnCqhhpiVgXGiSys50VgYRhaH8yESoobRygE/R0KUitxbHvrBesnmd+s2fizVjwi+Sj9lzmeiPmk5Rrc6/rr+meDOsXObkEjfLsL6pF6aalhR8YnKXWTuXMCLWyRX8708NozOtotrNqPG/TcChJfBHRlC3Dz09wmULkzxqT3uBfbbGIX2vqW3W9OqTiILtmDsIIDcU7mWPZM8P0gAyhIMirjIkgHvRd9IvMJsB94fJXAcj+rZZv/R4bd5hlhq7/URlh2GPjQg7o2St8JA1rK5XcmN/ucgiynvOqjxqolmLk/DyJZDrrQ3YBBWbp3tJ2s20wPkxK7deXsLIZIjyGfkuIXreSiJ4+LBcqUcNZRbw==;5:OPb538sdGVns5Tm0cldmgJ5vwRS6f38zfcixSmj144N3HmomDQ/FJjBEIp6pPIA0KYyiLeR85v48j1LNNvLzPsCQRvPwMWnHBfNi6EO2xF8Xw+BNc2+99vH24+AVPHBxITFioS4pxoB04lUoa0K6Y/Iwtorj2NYQKeG0+0rD8kp/rK1ber/HKU7alIQeEcjLSQSDyh7u09dQ/hxU23A2Ow==;7:iTAyVJtPk2DNmSOSbuTK6vjIu9nWM8843GpGF3Rg9rIO7FcOYBIotx8/nCMMkdfy27g5TTCrctIeO9lcdHq6lWsVHvn27mKWVstDg3XBuTx6BU8oeZfwrQUm/w1yo8VJ997/AkhoHGC9tXoemWzssw==
x-ms-office365-filtering-correlation-id: 1927283d-ff9f-4cbd-e995-08d67abbe981
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0002;
x-ms-traffictypediagnostic: BN6PR11MB0002:
x-microsoft-antispam-prvs: <BN6PR11MB000249CC6542B55E9B17CBF9F0810@BN6PR11MB0002.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(105586002)(3846002)(486006)(25786009)(7736002)(2906002)(106356001)(446003)(476003)(86362001)(31686004)(11346002)(53936002)(31696002)(6116002)(6246003)(2616005)(6506007)(7416002)(53546011)(110136005)(186003)(6512007)(102836004)(39060400002)(26005)(305945005)(4326008)(54906003)(386003)(36756003)(76176011)(5660300001)(52116002)(99286004)(316002)(72206003)(14454004)(71190400001)(6436002)(71200400001)(68736007)(6486002)(66066001)(229853002)(8676002)(256004)(81166006)(81156014)(8936002)(14444005)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0002;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hrXj4Oxj6Dlu4yei0AOaBcF1X+Jn/31gg5tml5mj0JAU3smqV1uJPUOAw8hUI63IN8NSog2XJO6KohwJDfyNdjNpdGEdVd72pGE2b/SuVNT3G9DFTUNkBo9Y5rxOGfv1JwACuz1bHpc9qVA4tbFvgyj5oaktTYG2Of9Nr8VhO2/g09ZtiVU1kajzgIoYMQRUDNnaNWKv9314F2RG+QXswl1XZ6HB0QI68r37mojIHe3B5YSifn9SrNoh9b9WLahmeCjMy7XoUbEevrO6OXbRflKJNJDcZxcPj7ejeRiMrAZr4Hwvfr+ShQJyT8PWNB81hYlAwz5HbmcWLOVv0g0V6ZQgMMQCJgGt49p+YIBAxUEwo7SjEEpDn0Go81lRXB+tURIg7EY19ysxZPLBbrJ7kdfxfRODjV9E+jP6AE+wK/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85364684AEA374885282766A0730D1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1927283d-ff9f-4cbd-e995-08d67abbe981
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 07:34:39.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0002
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJ5ZGVyLA0KDQpPbiAwMS8xNC8yMDE5IDA3OjEyIEFNLCBSeWRlciBMZWUgd3JvdGU6DQo+
IFRoZSBxdWFkc3BpIGlzIGEgZ2VuZXJpYyBjb21tdW5pY2F0aW9uIGludGVyZmFjZSB3aGljaCBj
b3VsZCBiZSBzaGFyZWQNCj4gd2l0aCBvdGhlciBNZWRpYVRlayBTb0NzLiBIZW5jZSByZW5hbWUg
aXQgdG8gYSBjb21tb24gb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRl
ci5sZWVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSB2MTogcmViYXNlIHRv
IHY1LjAtcmMxLiANCg0KVGhlIHBhdGNoIGRvZXNuJ3QgYXBwbHkgb24gdjUuMC1yYzEgb3IgcmMy
Lg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnICB8IDE2ICsrKysrKysr
LS0tLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUgfCAgMiArLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9LY29uZmlnDQo+IGluZGV4IGI0MzNlNWYuLjk5ZDlkNTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL0tjb25m
aWcNCj4gQEAgLTcsMTQgKzcsNiBAQCBtZW51Y29uZmlnIE1URF9TUElfTk9SDQo+ICANCj4gIGlm
IE1URF9TUElfTk9SDQo+ICANCj4gLWNvbmZpZyBNVERfTVQ4MXh4X05PUg0KPiAtCXRyaXN0YXRl
ICJNZWRpYXRlayBNVDgxeHggU1BJIE5PUiBmbGFzaCBjb250cm9sbGVyIg0KPiAtCWRlcGVuZHMg
b24gSEFTX0lPTUVNDQo+IC0JaGVscA0KPiAtCSAgVGhpcyBlbmFibGVzIGFjY2VzcyB0byBTUEkg
Tk9SIGZsYXNoLCB1c2luZyBNVDgxeHggU1BJIE5PUiBmbGFzaA0KPiAtCSAgY29udHJvbGxlci4g
VGhpcyBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBvcnQgZ2VuZXJpYyBTUEkgQlVTLCBpdCBvbmx5
DQo+IC0JICBzdXBwb3J0cyBTUEkgTk9SIEZsYXNoLg0KPiAtDQo+ICBjb25maWcgTVREX1NQSV9O
T1JfVVNFXzRLX1NFQ1RPUlMNCj4gIAlib29sICJVc2Ugc21hbGwgNDA5NiBCIGVyYXNlIHNlY3Rv
cnMiDQo+ICAJZGVmYXVsdCB5DQo+IEBAIC02OCw2ICs2MCwxNCBAQCBjb25maWcgU1BJX05YUF9T
UElGSQ0KPiAgCSAgRmxhc2guIEVuYWJsZSB0aGlzIG9wdGlvbiBpZiB5b3UgaGF2ZSBhIGRldmlj
ZSB3aXRoIGEgU1BJRkkNCj4gIAkgIGNvbnRyb2xsZXIgYW5kIHdhbnQgdG8gYWNjZXNzIHRoZSBG
bGFzaCBhcyBhIG10ZCBkZXZpY2UuDQo+ICANCj4gK2NvbmZpZyBTUElfTVRLX1FVQURTUEkNCg0K
U2luY2UgeW91IGFyZSBtb3ZpbmcgdGhlIGNvbmZpZyBpbnRvIHRoZSBmaWxlLCB3b3VsZCB5b3Ug
bWluZCB0byBwdXQgeW91ciBjb25maWcNCmluIGFuIGFscGhhYmV0aWNhbCBvcmRlcj8NCg0KVGhh
bmtzLA0KdGENCg0KPiArCXRyaXN0YXRlICJNZWRpYVRlayBRdWFkIFNQSSBjb250cm9sbGVyIg0K
PiArCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+ICsJaGVscA0KPiArCSAgVGhpcyBlbmFibGVzIHN1
cHBvcnQgZm9yIHRoZSBRdWFkIFNQSSBjb250cm9sbGVyIGluIG1hc3RlciBtb2RlLg0KPiArCSAg
VGhpcyBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBvcnQgZ2VuZXJpYyBTUEkuIEl0IG9ubHkgc3Vw
cG9ydHMNCj4gKwkgIFNQSSBOT1IuDQo+ICsNCj4gIGNvbmZpZyBTUElfSU5URUxfU1BJDQo+ICAJ
dHJpc3RhdGUNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmls
ZSBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUNCj4gaW5kZXggMmFkZWRiZS4uMTg5YTE1
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZQ0KPiArKysgYi9k
cml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlDQo+IEBAIC0zLDcgKzMsNyBAQCBvYmotJChDT05G
SUdfTVREX1NQSV9OT1IpCSs9IHNwaS1ub3Iubw0KPiAgb2JqLSQoQ09ORklHX1NQSV9BU1BFRURf
U01DKQkrPSBhc3BlZWQtc21jLm8NCj4gIG9iai0kKENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJ
KQkrPSBjYWRlbmNlLXF1YWRzcGkubw0KPiAgb2JqLSQoQ09ORklHX1NQSV9ISVNJX1NGQykJKz0g
aGlzaS1zZmMubw0KPiAtb2JqLSQoQ09ORklHX01URF9NVDgxeHhfTk9SKSAgICArPSBtdGstcXVh
ZHNwaS5vDQo+ICtvYmotJChDT05GSUdfU1BJX01US19RVUFEU1BJKSAgICArPSBtdGstcXVhZHNw
aS5vDQo+ICBvYmotJChDT05GSUdfU1BJX05YUF9TUElGSSkJKz0gbnhwLXNwaWZpLm8NCj4gIG9i
ai0kKENPTkZJR19TUElfSU5URUxfU1BJKQkrPSBpbnRlbC1zcGkubw0KPiAgb2JqLSQoQ09ORklH
X1NQSV9JTlRFTF9TUElfUENJKQkrPSBpbnRlbC1zcGktcGNpLm8NCj4gDQo=
