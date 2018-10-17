Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D047ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67221526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdvTMnXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA67221526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJQQPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:15:15 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:64704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbeJQQPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8tXoopXEJr7aOF33kChe0R70VpBl1el9F4SqEPWRvg=;
 b=JdvTMnXFgFdrLzAWlmM/KgfjJh5U1M0PqQJPwhL9PNle/oBZASYQ+UUsQjePwbyVQWRBAPpf6KUlQnsEgrIVeJ/nrF0mUjtNnb3rIkQ2ffAObYJ1rRY/oLVXYOlcWnMh0J5zglEHeLZFeh/1EYs1cjxwHFx9+oSL/XBXufsoZsk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB0893.eurprd04.prod.outlook.com (10.161.106.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 08:20:20 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 08:20:19 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAAAZfAIAABMJQ
Date:   Wed, 17 Oct 2018 08:20:19 +0000
Message-ID: <VI1PR04MB1038987B053C31099A76344699FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon> <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <47586729-d711-cd38-a4b2-bef09f64cba3@microchip.com>
In-Reply-To: <47586729-d711-cd38-a4b2-bef09f64cba3@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0893;6:ovMb7GqmJzZYNqSSWie5VnTqTmwU3Jc5GlZjDpgBE2CN+fb7NfOd2QKydctA5WtS4gFSelvlYgSTyMFjHGXau21YRyaQORIIFfjAM/Txers3NmVw0gTH8EXOYX4WQIxU9dO4Q3za+lnFeSGZ08xYo225PvMGN8x4weisrSlVLeV6iPEs6Az5A995sEj3FvE/Tbfe96CJkhT3sHXj4k/T+DLz4h46w237M6dmiRh7naqDBFcQcAak95SVLydFnyaVVXdHI2B3O/+W2zK5DvklCePmynCDlVmYubnoUsF3iSXX+sjbZQrVvr7ync+hOWVVqVucld/XmcreM/4jTQVyq/EYsaMz8xy3E7Z6IZhrZFkfKypA9k2piqXxOUwtGKdEEW2EayMuLCyko5iH1aqclIShQYYwc+KB/RVkzVjK7L9y1SrUGkoS+CNwj5V3V8DFSSxjzsrIFjvq0pYj1gR07Q==;5:Gn7PnIU14lHlIIfTld6mNrpE/7MpNg5HeFo9XPzn1dWiwjtS7Q8fIzDpDXohRPtnJ2lsXqA5Y88XAzbn+CHl1n5eyaesvD1cXpsbei21KfF+DfVtbjIZTF1KWh92ZBOv23rscSzBWKZk8xRoCevqL5SmiY3rOC0d2pV0sSK1UVw=;7:PCfszhsqPq+GQPu1uWx6rOSIfGIl6qPMm7j+n6TgW9HlRLvVbjl5SeM1URCQtMRRMnF/k1GcweB9yLnZ07feD4PYeIGCpx8hRJx3Jr4wyHhHhKSu3ch8gN49hhtVujib8LXPYW8IOKrPIv1XIolVmitebk31l6jzIyrlrBRA21YQk6oMsqUIOwSj4rU7BKItqnNG7pgOi+wO56KOvC/JnUp+t5RPPQ6EJyzP0Nck7skMx2T7Fp1BTKtaJpNlbOT2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4dbcfe46-e1f8-43a6-8fda-08d634096097
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0893;
x-ms-traffictypediagnostic: VI1PR04MB0893:
x-microsoft-antispam-prvs: <VI1PR04MB0893B2DDE5980A6DADBCA5A599FF0@VI1PR04MB0893.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB0893;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0893;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(13464003)(486006)(186003)(106356001)(26005)(76176011)(97736004)(105586002)(53936002)(81166006)(6116002)(86362001)(476003)(99286004)(81156014)(11346002)(6506007)(8676002)(55016002)(9686003)(3846002)(6246003)(25786009)(305945005)(33656002)(7736002)(446003)(6436002)(5250100002)(74316002)(7696005)(55236004)(14444005)(53546011)(2906002)(39060400002)(229853002)(478600001)(14454004)(217873002)(256004)(4326008)(8936002)(71200400001)(2900100001)(102836004)(93886005)(54906003)(5660300001)(110136005)(71190400001)(78486010)(66066001)(7416002)(316002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0893;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A1RXumSfDeip0eB2djdppuDcQx8QYLbVMoY/QE95B22Irq39s3BhXnU4/JatAe272oqs8e0U2/V5wu/dF4ygBhRq2u+uniC0PYEJH5UAsJ7ySsgErDemiXg73NKHtd/qojbQ3BDLbmpwla98nv7MvRPNdO9cp95yAKJQl6eOu7ndVZms/jmgmxwI4wX9wIRKrtrmBVFHe7aHLA4hT2ixNH9d9AKHowgGWOic+qhTaO1Tuqed2Rm9UVzue8dj5UcDRdrrO7VL6iaFdnrO1lvESHAjC+3s+FVoteoLasg65aIosVY9zAvLUPSMeaVb8fTRMBh/jH8Dg3WPeoo/8Q0Dcjxpj6/bD14oftJu/nUU3TQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbcfe46-e1f8-43a6-8fda-08d634096097
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 08:20:19.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0893
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Ig
QW1iYXJ1cyBbbWFpbHRvOnR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbV0NCj4gU2VudDogV2Vk
bmVzZGF5LCBPY3RvYmVyIDE3LCAyMDE4IDE6MzEgUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFuIEdh
dXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgQm9yaXMgQnJlemlsbG9uDQo+IDxib3Jp
cy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IENjOiBDeXJpbGxlIFBpdGNoZW4gPGN5cmlsbGUu
cGl0Y2hlbkB3ZWRldjR1LmZyPjsgbWFyZWsudmFzdXRAZ21haWwuY29tOw0KPiBkd213MkBpbmZy
YWRlYWQub3JnOyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IHJpY2hhcmRAbm9kLmF0Ow0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5j
b207DQo+IGN5cmlsbGUucGl0Y2hlbkBtaWNyb2NoaXAuY29tOyBsaW51eC1tdGRAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQ3Jp
c3RpYW4uQmlyc2FuQG1pY3JvY2hpcC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJd
IG10ZDogc3BpLW5vcjogYWRkIHN1cHBvcnQgdG8gbm9uLXVuaWZvcm0gU0ZEUCBTUEkNCj4gTk9S
IGZsYXNoIG1lbW9yaWVzDQo+IA0KPiBIaSwgWW9nZXNoLA0KPiANCj4gT24gMTAvMTcvMjAxOCAx
MDo0NiBBTSwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90ZToNCj4gPiBIaSBCb3JpcywNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBCb3JpcyBCcmV6aWxs
b24gW21haWx0bzpib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb21dDQo+ID4+IFNlbnQ6IFdlZG5l
c2RheSwgT2N0b2JlciAxNywgMjAxOCAxOjAwIFBNDQo+ID4+IFRvOiBZb2dlc2ggTmFyYXlhbiBH
YXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPj4gQ2M6IEN5cmlsbGUgUGl0Y2hl
biA8Y3lyaWxsZS5waXRjaGVuQHdlZGV2NHUuZnI+OyBUdWRvciBBbWJhcnVzDQo+ID4+IDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+OyBtYXJlay52YXN1dEBnbWFpbC5jb207DQo+ID4+IGR3
bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgcmljaGFyZEBu
b2QuYXQ7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5pY29sYXMuZmVycmVA
bWljcm9jaGlwLmNvbTsNCj4gPj4gY3lyaWxsZS5waXRjaGVuQG1pY3JvY2hpcC5jb207IGxpbnV4
LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1hcm0tIGtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBDcmlzdGlhbi5CaXJzYW5AbWljcm9jaGlwLmNvbQ0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDEvMl0gbXRkOiBzcGktbm9yOiBhZGQgc3VwcG9ydCB0byBub24tdW5p
Zm9ybQ0KPiA+PiBTRkRQIFNQSSBOT1IgZmxhc2ggbWVtb3JpZXMNCj4gPj4NCj4gPj4gT24gV2Vk
LCAxNyBPY3QgMjAxOCAwOToxMDo0NSArMDIwMA0KPiA+PiBCb3JpcyBCcmV6aWxsb24gPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+PiBPbiBXZWQsIDE3IE9j
dCAyMDE4IDA5OjA3OjI0ICswMjAwDQo+ID4+PiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXpp
bGxvbkBib290bGluLmNvbT4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IE9uIFdlZCwgMTcgT2N0IDIw
MTggMDI6MDc6NDMgKzAwMDANCj4gPj4+PiBZb2dlc2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJh
eWFuLmdhdXJAbnhwLmNvbT4gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+IEFjdHVh
bGx5IHRoZXJlIGlzIG5vIGVudHJ5IG9mIHMyNWZzNTEycyBpbiBjdXJyZW50IHNwaS1ub3IuYyBm
aWxlLg0KPiA+Pj4+PiBGb3IgbXkgY29ubmVjdGVkIGZsYXNoIHBhcnQsIGplZGVjIElEIHJlYWQg
cG9pbnRzIHRvIHMyNWZsNTEycy4gSQ0KPiA+Pj4+PiBoYXZlIGFza2VkIG15IGJvYXJkIHRlYW0g
dG8gY29uZmlybSB0aGUgbmFtZSBvZiBleGFjdCBjb25uZWN0ZWQNCj4gPj4+Pj4gZmxhc2ggcGFy
dC4gV2hlbiBJIGNoZWNrIHRoZSBkYXRhIHNoZWV0IG9mIHMyNWZzNTEycywgaXQgYWxzbw0KPiA+
Pj4+PiBwb2ludHMgdG8gdGhlIHNhbWUgSmVkZWMgSUQgaW5mb3JtYXRpb24uIHsgInMyNWZsNTEy
cyIsDQo+ID4+Pj4+IElORk8oMHgwMTAyMjAsIDB4NGQwMCwgMjU2DQo+ID4+Pj4+ICogMTAyNCwg
MjU2LCAuLi4ufQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBCdXQgYXMgc3RhdGVkIGVhcmxpZXIsIGlmIEkg
c2tpcCByZWFkaW5nIFNGRFAgb3IgcmVhZCB1c2luZyAxLTEtMQ0KPiA+Pj4+PiBwcm90b2NvbCB0
aGVuIHJlYWQgYXJlIGFsd2F5cyBjb3JyZWN0LiBGb3IgMS00LTQgcHJvdG9jb2wgcmVhZCBhcmUN
Cj4gPj4+Pj4gd3JvbmcgYW5kIG9uIGZ1cnRoZXIgZGVidWdnaW5nIGZvdW5kIHRoYXQgUmVhZCBj
b2RlIG9mIDB4NkMgaXMNCj4gPj4+Pj4gYmVpbmcgc2VuZCBhcyBvcGNvZGUgaW5zdGVhZCBvZiAw
eEVDLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJZiBJIHJldmVydCB0aGlzIHBhdGNoLCByZWFkcyBhcmUg
d29ya2luZyBmaW5lLg0KPiA+Pj4+DQo+ID4+Pj4gQ2FuIHlvdSB0cnkgd2l0aCB0aGUgZm9sbG93
aW5nIHBhdGNoPw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSG0sIG5ldmVybWluZC4gVGhlIHByb2Js
ZW0gaXMgYWN0dWFsbHkgbm90IHJlbGF0ZWQgdG8gNEIgdnMgbm9uLTRCDQo+ID4+PiBtb2RlIGJ1
dCAxLTEtNCB2cyAxLTQtNCBtb2Rlcy4NCj4gPiBZZXMsIHRoYXQncyBvbmx5IEkgaGF2ZSBzdGF0
ZWQgaW4gbXkgZmlyc3QgbWFpbCB0aGF0IGluc3RlYWQgb2YgMS00LTQgbW9kZSByZWFkDQo+IG9w
Y29kZSBpcyBiZWluZyBzZW50IGZvciAxLTEtNCBtb2RlLg0KPiA+Pj4NCj4gPj4NCj4gPj4gQ2Fu
IHlvdSB0cnkgd2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQ/DQo+ID4+DQo+ID4gV2l0aCBzdWdnZXN0
ZWQgcGF0Y2gsIHJlYWQgZm9yIHByb3RvY29sIDEtNC00IHdvcmtpbmcgY29ycmVjdGx5Lg0KPiA+
DQo+ID4gCVsgICAgMS42MjUzNjBdIG0yNXA4MCBzcGkwLjA6IGZvdW5kIHMyNWZsNTEycywgZXhw
ZWN0ZWQgbTI1cDgwDQo+ID4gCVsgICAgMS42MzEwOTRdIG0yNXA4MCBzcGkwLjA6IGZhaWxlZCB0
byBwYXJzZSBTTVBUIChlcnIgPSAtMjIpDQo+ID4gCVsgICAgMS42MzY2NjFdIDI2MSA4YzRjNzgw
IG9wY29kZShyZWFkOmViLCBwcDoyLCBlcmFzZTpkOCkNCj4gPiAJWyAgICAxLjY0MTg3OF0gMjY2
IDhjNGM3ODAgb3Bjb2RlKHJlYWQ6ZWMsIHBwOjEyLCBlcmFzZTpkYykNCj4gPiAJWyAgICAxLjY0
NzIwMF0gbTI1cDgwIHNwaTAuMDogczI1Zmw1MTJzICg2NTUzNiBLYnl0ZXMpDQo+ID4NCj4gPiBX
aXRob3V0IHRoaXMgcGF0Y2gsIHBhcmFtX2hlYWRlcnMgYXJlIGdldHRpbmcgZnJlZWQgYW5kIHJl
c3RvcmluZyBwcmV2aW91cw0KPiBlcmFzZSBtYXAgaS5lLiBvcGNvZGUgcmVsYXRlZCB0byAxLTEt
NCBwcm90b2NvbC4NCj4gPg0KPiANCj4gQ2FuIHlvdSBhZGQgc29tZSBwcmludHMgaW4gc3BpX25v
cl9wYXJzZV9zbXB0KCkgdG8gaXNvbGF0ZSB3aGF0J3MgZmFpbGluZz8gV2UNCj4gc2hvdWxkIHVu
ZGVyc3RhbmQgd2hldGhlciBpdCdzIHNvbWV0aGluZyB3cm9uZyBpbiBzcGlfbm9yX3BhcnNlX3Nt
cHQoKSBvciB0aGUNCj4gczI1ZnM1MTJzIHNtcHQgdGFibGUgZG9lcyBub3QgcmVzcGVjdCB0aGUg
c3RhbmRhcmQuDQo+IA0KDQpJdCdzIHJldHVybmluZyBmYWlsdXJlIGZyb20gYmVsb3cgcG9pbnQg
aW4gZnVuYyBzcGlfbm9yX2dldF9tYXBfaW5fdXNlKCkNCg0KICAgICAgICAvKiBGaW5kIHRoZSBt
YXRjaGluZyBjb25maWd1cmF0aW9uIG1hcCAqLw0KICAgICAgICB3aGlsZSAoU01QVF9NQVBfSUQo
c21wdFtpXSkgIT0gbWFwX2lkKSB7DQogICAgICAgICAgICAgICAgaWYgKHNtcHRbaV0gJiBTTVBU
X0RFU0NfRU5EKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoIiVkICVzIFxuIiwg
X19MSU5FX18sIF9fZnVuY19fKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
ICAgICAgICAgICAgICAgIH0NCi0tDQpSZWdhcmRzDQpZb2dlc2ggR2F1ci4NCg0KPiBUaGFua3Ms
DQo+IHRhDQo+IA0KDQo=
