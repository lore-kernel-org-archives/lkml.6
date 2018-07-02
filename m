Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C787C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23D4254E0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q9dgB9EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23D4254E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeGBBT2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:19:28 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:1376
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932217AbeGBBTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAV+FbmtiswLUQj6JJ4jzT3RUmMjzVGB9iF7LJay1ws=;
 b=q9dgB9EQYQcu5vHMf0lCss4HNlzgGHDP4VBm5ZODzc5ypOv5GdxzbRU3EOyZJ+g2aIOTauvpkhcgl/mT43WABpSo3YXOdqpBJGiMlvT+OcatgmTo5UMrtGgvUT0qdfKhnxOUJVQ1JgiqSEUnXlpr3syXsy1XRrP68IdXprV7qi4=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1492.eurprd04.prod.outlook.com (10.163.186.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 01:19:20 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 01:19:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4IAAAL2AgAAAQsCAAAFKgIAAAEyQgAABDACAAACgsIAAAsCAgAAAPzA=
Date:   Mon, 2 Jul 2018 01:19:20 +0000
Message-ID: <AM3PR04MB1315D8EF80847B4AF1FF4BA5F5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
In-Reply-To: <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1492;7:TMN2g9WEni/VkMrX4BSRYIeNYvBbeJQYirc63rJUOm7kvu5ck5nGbvx3d4Blex4W8xy7yvxVXIcwT9Qw/a3950N8FTrygs67RP6dj8GCMdWVLxgJ4yI6Dy/pzBDZ3dGW24dRuGJpnCI3pmqBGilMulftGLC1qf2jPdyKeOtiPknqB7ofIpdrSWoia+H12UzhsulGtBMxjC24G3AqInrg5qOGr2bjPBTo7YYRjVhBuNyS3TjrB+84xFhrbX80XVxm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: add91c96-a10a-496b-72d1-08d5dfb9d677
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1492;
x-ms-traffictypediagnostic: AM3PR04MB1492:
x-microsoft-antispam-prvs: <AM3PR04MB149207495BD76F9CC1133772F5430@AM3PR04MB1492.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1492;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1492;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(13464003)(6246003)(2906002)(54906003)(7696005)(1411001)(316002)(39060400002)(53936002)(99286004)(86362001)(76176011)(102836004)(55016002)(6506007)(93886005)(186003)(9686003)(66066001)(26005)(25786009)(11346002)(446003)(14454004)(44832011)(4326008)(53546011)(486006)(476003)(3846002)(2900100001)(106356001)(229853002)(6436002)(105586002)(5660300001)(33656002)(97736004)(8676002)(8936002)(81166006)(256004)(81156014)(7736002)(305945005)(74316002)(68736007)(5250100002)(478600001)(6916009)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1492;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wQlL3VCMncW5MDK2sPXNScJ7SQDNpdDqipRFYGYeqOwJsJ8Lxr8AexveXrj8OLF9TrhxRrJRuWBFd57OMAfm5z3qBgJNB/UDnUmkj/qZGCMNY3kxf63CyXkJg4krXc83taAjbYfN3OnUh/Njdu1D1ruBRhA+CVFV4aGg8e7vSUzTbpnHjJ6CEL/I6XCQU8O0SPZ7Fx7o4kcrSmqEa2vR13bSF3swKcoGqRHhv3l5BnHojlvarlnaW32yw4CCEEXO6ZiBChPpe0sHPt23aWj7uOT6/hVrhs/vJjJzWnTuSf6DntqNJl4gxxSzUBA56Wvit+ibej7XVO10QGAe1nxbz98yB1/KHe8YsKVNkAyMWMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add91c96-a10a-496b-72d1-08d5dfb9d677
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 01:19:20.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29t
XQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA5OjE3IEFNDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47DQo+IE1hcmsgUnV0bGFuZCA8
bWFyay5ydXRsYW5kQGFybS5jb20+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQNCj4gRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
DQo+IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJvYiBIZXJy
aW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsgU2FzY2hhIEhhdWVyDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVND
QUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBpbXg2
c2wtZXZrOiBrZWVwIHN3NCBhbHdheXMgb24NCj4gDQo+IE9uIFN1biwgSnVsIDEsIDIwMTggYXQg
MTA6MDkgUE0sIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4g
DQo+ID4gT24gc29tZSBuZXcgaS5NWCBwbGF0Zm9ybXMsIFBGdXplIHN3aXRjaGVzIGFyZSB1c2Vk
IGZvciBzdXBwbHlpbmcNCj4gPiBHUFUvVlBVIG9yIG90aGVyIG5vbi1jcml0aWNhbCBtb2R1bGVz
IG9ubHksIHRoZXNlIHN3aXRjaGVzIG5lZWQgdG8gYmUNCj4gPiB0dXJuZWQgb2ZmIGJ5IHJ1bnRp
bWUgUE0gdG8gYXZvaWQgdmVyeSBoaWdoIHBvd2VyIGxlYWthZ2UsIGxpa2Ugb24NCj4gbVNjYWxl
ODUwRC4NCj4gDQo+IE9rLCBpbiB0aGlzIGNhc2UgSSBzdWdnZXN0IGFkZGluZyBhIG5ldyBwcm9w
ZXJ0eSBzbyB0aGF0IHRoZSBzd2l0Y2hlcyBjYW4gYmUNCj4gdHVybmVkIG9mZiBvbmx5IHdoZW4g
dGhlIG5ldyBwcm9wZXJ0eSBpcyBwcmVzZW50Lg0KPiANCj4gV2hlbiB0aGlzIG5ldyBwcm9wZXJ0
eSBpcyBhYnNlbnQsIHRoZW4gd2Uga2VlcCB0aGUgY3VycmVudCBiZWhhdmlvciBhbmQgYXZvaWQN
Cj4gZHRiIGJyZWFrYWdlLg0KPiANCj4gU2luY2UgTVg4TSBzdXBwb3J0IGlzIG5vdCBpbiBwbGFj
ZSB5ZXQsIHRoaXMgaXMgbm90IHVyZ2VudCwgc28gSSB3aWxsIHNlbmQgYSByZXZlcnQNCj4gYW5k
IHRoZW4geW91IGNhbiByZS13b3JrIHRoZSBwYXRjaCBzbyB0aGF0IGl0IGRvZXMgbm90IGFmZmVj
dCB0aGUgb2xkIGR0YnMuDQo+IA0KPiBEbyB5b3UgYWdyZWUgd2l0aCBzdWNoIGFwcHJvYWNoPw0K
DQpTdXJlLCBJIGFncmVlIGZvciBub3cuIEFzIEkgZGlkIE5PVCB3YW50IHRvIGhhdmUgYW55IGJy
ZWFrYWdlLiBUaGFua3MuDQogDQpBbnNvbi4NCg0KDQo=
