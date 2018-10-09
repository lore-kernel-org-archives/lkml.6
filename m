Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lJUm8OsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1053521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIRlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:41:07 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:42381
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeJIRlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxpJ+ECOIvZVG4cb00sYGWgHAhjF8almwUPjZHWRWrs=;
 b=lJUm8OsQVRh0hsx6swop9aTh13AxzUnWyiRh8i2UnztgSTs0GEsa/wwqysn5/jxfekGwDHDf9L2y2iPj3gxab/Bs6Vl57FpAY41IKFmrdUIHfapCu3k5aOUVTY8aKxVztBOhfEl1QP3DXqUjCpnZuLtaQq4cTg9WFOaFcwOfOjw=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4216.eurprd04.prod.outlook.com (52.135.168.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Tue, 9 Oct 2018 10:24:49 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 10:24:49 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFSniAgAAAtKCAAAjOgIARcEYwgAAH+wCAAAESEA==
Date:   Tue, 9 Oct 2018 10:24:49 +0000
Message-ID: <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20181009120522.6b2bd15a@bbrezillon>
In-Reply-To: <20181009120522.6b2bd15a@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4216;6:ZzfreM0Bhkct6Fozzjhg7Q2lKZaRBjGO4mNaXND1KK+NQpS8+a74kaiN9nJK46N94+yH1aYHenvtXM6HknUdWny6T94m1vNNO/jTWU7EAmxhBHkih2vPdz09qYxRvKsJ20RDDHXvzB15RYLIHMyRrRsuzJ/Ud4UYX/SU2wJEr4za+K4Kp4H4D538KJVfIFbuFD/A1GNFxVzOMxL7DUuAc/KxaZiYIrbQaVoZ2b3vVx4V+6qxlVHrcwTuzRD2OKVSiy+W2oYZPqMiKpw1nKOAYyszDJeRuGMSOU8E+71yO2lOLNw0ZyAjochSIGRplyGg3Y/ojiFi555UvyjWTFYg2YBNJlKJMn/K6qIzH0w5P+ZETmXD4NDD59S8u+aXxADjhTOwInCf51WuSBM427OJSOgmAQtjarLx/hkqs61OvYSJDm6kv0SDG4pymVRbJLfT20nhyftYdtxGvRW2HZAlEw==;5:OLAzRLSuGEr8y6KkntD0pytQBNaga/vR2zea9S4oO4dn95wfHKzseExgYxz8rCJov7NnO1KYMGQhxfOnrfiTsXUP3IWo5K7zP40gFOP4jKpuF5i7pFLAudGLKmH/vmjoaYgm2x8jyxuglusi9p/V6rDcwcVgd+3Ds78AlrQi/84=;7:5iLl0pJ1fX9cEoOmb5i4XaHvLetqbAvs8nA3atsvuYHo+MTuGFF1OZlD8rqDAoeq51HRRRRlSwKhzD5+AD0Pl3YFV7EqgKNi7W910GXOafOPIjmLGaVZgNiwWL76zOpbsi4gVroVLdAeJObBB0Yy1lBOFu8W/z2Gmc26B2py0ECI0TNrG56wb34sCgTLVzkOXZsDy9RUkBgk5EDiP7FIJR6DHj+u7VJuJMgtDVilD7HhwqB66tVYe5AnEB7QlNZ6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 26434bed-8cc1-46a8-25fd-08d62dd17168
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4216;
x-ms-traffictypediagnostic: AM6PR04MB4216:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB4216928849C1A986293145B997E70@AM6PR04MB4216.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:AM6PR04MB4216;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4216;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(43544003)(189003)(13464003)(199004)(6506007)(76176011)(6916009)(66066001)(7696005)(256004)(71200400001)(4326008)(86362001)(478600001)(71190400001)(54906003)(26005)(316002)(53546011)(186003)(93886005)(5250100002)(14454004)(102836004)(6246003)(5660300001)(74316002)(8676002)(8936002)(81156014)(81166006)(25786009)(305945005)(7736002)(2900100001)(229853002)(55016002)(486006)(105586002)(9686003)(6436002)(106356001)(6116002)(68736007)(2906002)(476003)(99286004)(44832011)(33656002)(97736004)(446003)(11346002)(3846002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4216;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vURn8WDo/ru7970g2xPuc84gW1eVPf7AKt7s6wD0ZIq/Uy9PdKfxLXLJO9BmkyvXcMKfVV78JQNpCe4CqDM6hrYoGcxYZQpd63xEuKbC42JPZ2vP20eSg0VBGPa9dxS1I9qHcmi4aSKdT8jLUEv/wNEgjhwu4ptr0e/ah51jczTt5pRF8ZdodT2+7LeSlC3/KwCnVR0F/KKDWtQGvPD0sDPJBay87i7v1WjfdBR0z476Ge+qALF5yj149pg3ThVlfVQAxh9jdeiiy//QMmw1Zc/AwsI1TTMfjFnHPZup1bBD+5biKWQaRhZwc3smz7sQh4Zjuyl6XbslK2ik3442aXxXlcn6AJUrTJ42X46wGrY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26434bed-8cc1-46a8-25fd-08d62dd17168
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 10:24:49.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jEw1MI5yNUgMTg6
MDUNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rpb24NCj4gDQo+
IE9uIFR1ZSwgOSBPY3QgMjAxOCAwOTo1MjoyMyArMDAwMA0KPiBDaHVhbmh1YSBIYW4gPGNodWFu
aHVhLmhhbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gMS4gSW4gdGhlIGRzcGkgZHJpdmVyIChz
cGkgY29udHJvbGxlciksIGJpdHNfcGVyX3dvcmQNCj4gPiAoZHNwaS0+Yml0c19wZXJfd29yZCA9
IHRyYW5zZmVyLT5iaXRzX3Blcl93b3JkKSBwYXNzZWQgZnJvbSB0aGUgdXBwZXINCj4gPiBsYXll
ciAoc3BpLW1lbS5jKSBpcyB1c2VkLiBJbiB0aGlzIHdheSwgSSBjYW4gb25seSBhc3NpZ24gdGhl
DQo+ID4gYXBwcm9wcmlhdGUgdmFsdWUgb2YgdHJhbnNmZXItPmJpdHNfcGVyX3dvcmQgYmVmb3Jl
IHBhc3NpbmcgdG8gdGhlDQo+ID4gY29udHJvbGxlciwgdGhhdCBpcywgdGhlIGNvbnRyb2xsZXIg
ZHJpdmVyIGRvZXMgbm90IGtub3cgdGhlIHZhbHVlIG9mDQo+ID4gYml0c19wZXJfd29yZCwgYW5k
IGl0IHdpbGwgdXNlIHRoaXMgdmFsdWUgd2hlbiB0aGUgdXBwZXIgbGV2ZWwgc2V0cw0KPiA+IHdo
YXQgdmFsdWUgaXMgcGFzc2VkLg0KPiANCj4gSSB0aGluayB5b3UncmUgbWlzc2luZyBteSBwb2lu
dDogLT5iaXRzX3Blcl93b3JkIGlzIG5vdCB3aGF0IHlvdSdyZSBsb29raW5nIGZvcg0KPiBpZiB3
aGF0IHlvdSdyZSB0cnlpbmcgdG8gZG8gaXMgdXNlIDMyLWJpdHMgYWNjZXNzZXMgd2hlbiB0aGlu
Z3MgYXJlIHByb3Blcmx5DQo+IGFsaWduZWQuDQo+IA0KSW4gdGhlIGRzcGkgZHJpdmVyIChzcGkg
Y29udHJvbGxlciBkcml2ZXIpLCBpdCBpcyBiYXNlZCBvbiB3aGV0aGVyIC0+Yml0c19wZXJfd29y
ZCBpcyANCmxhcmdlciB0aGFuIDE2IHRvIGRlY2lkZSB3aGV0aGVyIHRvIHVzZSB0aGUgWFNQSSBt
b2RlICgzMmJpdCkgdG8gdHJhbnNmZXIgZGF0YS4NCklmIC0+Yml0c19wZXJfd29yZCBpcyBub3Qg
c2V0IGFuZCB0aGUgZGVmYXVsdCBiaXRzX3Blcl93b3JkID04IGlzIHBhc3NlZCB0byB0aGUgDQpk
c3BpIGRyaXZlciwgdGhlIFhTUEkgbW9kZSAoMzJiaXQpIGlzIG5vdCB1c2VkIGZvciBkYXRhIHRy
YW5zZmVyIGluIHRoZSBkc3BpIGRyaXZlcg0KPiA+IDIuIEFzIEkgdW5kZXJzdGFuZCwgYml0c19w
ZXJfd29yZCBkb2VzIG5vdCBleGlzdCBmb3Igbm9uLWJ5dGUNCj4gPiBhbGlnbm1lbnQsIGJ1dCBm
b3IgdGhlIG5lZWQgdG8gcmVzZXJ2ZSBub24tYnl0ZSB0cmFuc21pc3Npb24gbW9kZSB0aGF0DQo+
ID4gbWVldHMgdGhlIGNvbnRyb2xsZXIuDQo+IA0KPiBFeGFjdGx5LiBJdCdzIGFuIG9wdGltaXph
dGlvbiB5b3UgaGF2ZSB0byB0YWtlIGNhcmUgb2YgaW5zaWRlIHlvdXIgZHJpdmVyLiBUaGUgY29y
ZQ0KPiBjYW5ub3QgaGVscCB5b3Ugd2l0aCB0aGF0Lg0KPiANClRoZSBjb3JlIGxheWVyIGlzIHRo
ZSB1cHBlciBsYXllci4gSWYgeW91IGRvbid0IHNldCAtPmJpdHNfcGVyX3dvcmQsIGJpdHNfcGVy
X3dvcmQNCiB3aWxsIHVzZSB0aGUgZGVmYXVsdCB2YWx1ZSBvZiA4LCBzbyB0aGF0IHRoZSBjb250
cm9sbGVyJ3Mgc3BlY2lmaWMgbW9kZSBmb3IgdHJhbnNmZXJyaW5nDQogZGF0YSBjYW5ub3QgYmUg
dXNlZCAoZWc6IFhTUEkgbW9kZSkuDQo+ID4gMy4gSW4gYWRkaXRpb24sIG5vdyB0aGUNCj4gPiBY
U1BJIG9mIGRzcGkgY2Fubm90IHRyYW5zZmVyIGRhdGEgbm9ybWFsbHksIHNvIHRoaXMgcHJvYmxl
bSBuZWVkcyB0bw0KPiA+IGJlIHNvbHZlZC4NCj4gDQo+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFu
ZCB3aGF0IHRoZSBwcm9ibGVtIGlzLg0KPiANClRoZSBwcm9ibGVtIGlzIHRoYXQgSSB0ZXN0ZWQg
dGhlIFhTUEkgbW9kZSBhbmQgY291bGQgbm90IHdvcmssIHRoYXQgaXMsIHRoZSBkYXRhIGNvdWxk
DQpub3QgYmUgdHJhbnNtaXR0ZWQgbm9ybWFsbHkuIEkgdXNlZCBzcGkgZmxhc2ggY29ubmVjdGVk
IG9uIGRzcGkgdG8gY29uZHVjdCB0aGUgdGVzdC4gDQpJbiBhbnkgY2FzZSwgdGhlIGNvbnRyb2xs
ZXIgaXMgaW5kZXBlbmRlbnQgb2YgY29ubmVjdGVkIHNsYXZlIGRldmljZXMsIGFuZCB0aGUgZGF0
YSBzaG91bGQNCmJlIHRyYW5zbWl0dGVkIGJ5IHNwaS1mbGFzaCBkZXZpY2VzIGFuZCBvdGhlciBz
cGkgZGV2aWNlcy4NCg0KPiA+IEFzIGZvciB0aGUgRE1BIHRyYW5zZmVyIG1vZGUsIHNvbWUgY29s
bGVhZ3VlcyB3aWxsIHN0dWR5IGl0Lg0KDQo=
