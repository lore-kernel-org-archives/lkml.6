Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A357C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A2E25447
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TTcAwRdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A2E25447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeGBBJK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:09:10 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:54624
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752739AbeGBBJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mKE8ZKRvAFMutadKKl5P+gtwMwCDiQ9vZLeOuwIkZE=;
 b=TTcAwRdM5+RfTg6387zxSy2uJG8uQPMPUzka6/KqFg1xWOEJLHluOiRErhD0K9ruf6g/OxBetDMVXyyXmUtePOUz4CFggSeaE04XrxFElOnTrCWNwdcKuxkWD5mgQHyB6pIlvf0VYzwuxdLnLSClav6SWPn+rJV2kq0ZO14kbKk=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB417.eurprd04.prod.outlook.com (10.242.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 01:09:02 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 01:09:02 +0000
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
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4IAAAL2AgAAAQsCAAAFKgIAAAEyQgAABDACAAACgsA==
Date:   Mon, 2 Jul 2018 01:09:02 +0000
Message-ID: <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
In-Reply-To: <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB417;7:Vb29qx39jTXfsqQ7gKRRCMMwv1dOeifRpYlBTetWWaC+zY1gMCkpPWsmL/pvohZ76+et1vaQoSQQzGUmoGJVR23BA2hkOn819QWmy8K3rZYmU26NV/5AhAsEV1wjzZ6XPe5U7jyr7OXXyzl5fEBjewl9Zv/N73wFm4XZujEpyyOJKDKH0bkFj1z56L+bVidnhk6CjZiMbd+1bjLogtHqPBdeBDk2XZbbab4qJIFb8Ifr6XgMOf0WWJDjRX0ruhnp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9f6d718-bb6d-43e8-9d9f-08d5dfb86665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB417;
x-ms-traffictypediagnostic: AM3PR04MB417:
x-microsoft-antispam-prvs: <AM3PR04MB4174DA77464E4C1FD2D5FF7F5430@AM3PR04MB417.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB417;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB417;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(13464003)(316002)(8936002)(3846002)(6436002)(99286004)(256004)(5250100002)(33656002)(2900100001)(66066001)(25786009)(6246003)(97736004)(6116002)(74316002)(54906003)(44832011)(39060400002)(1411001)(305945005)(478600001)(106356001)(102836004)(7696005)(446003)(7736002)(2906002)(55016002)(9686003)(53936002)(53546011)(5660300001)(6916009)(486006)(14454004)(26005)(8676002)(4326008)(81166006)(81156014)(186003)(68736007)(476003)(93886005)(105586002)(76176011)(229853002)(11346002)(6506007)(86362001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB417;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eZlEL1KHvCVJbFJW3NLjMVSSjJzQ3BWKx8i0YFhv/566MXsRdZ1tHY/lKAAJ2dGNxnT3CwKU4TJWvtQ1gQhqrcEOv5QBXJs58v3bo2vxLCEj0gYl7dZiBXeUtiEJoM7B8M/7dj3hR1+rDpTEu0YBDJeVeEkpVWPOTL6J3gbCFmDspJmiGkFbutHd+FP0BWGh1sNETblaVJcOlKkUli/pTmw30qVCLcXwSX82khP0Eumibkv/xqcUtU1Qv2JSWC6dYzAaWkPsYFSxa1PSWl77Iy5u7gswe+5O5l08K0LstusliJcUfJcrUmCytDRtqlQi16vxAqOngE2KbEmjSGojZ0NaXs1aQ2LZgGvLvMbxndg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f6d718-bb6d-43e8-9d9f-08d5dfb86665
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 01:09:02.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29t
XQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA5OjA1IEFNDQo+IFRvOiBBbnNvbiBIdWFu
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
MTA6MDMgUE0sIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4g
DQo+ID4gU28gdGhhdCBtZWFuIHN1Y2gga2luZCBvZiBrZXJuZWwgcGF0Y2ggd2lsbCBuZXZlciBi
ZSBpbnRvIGtlcm5lbD8gRXZlbg0KPiA+IGlmIGl0IGlzIGEgbmVjZXNzYXJ5IHBhdGNoIGZvciBm
aXhpbmcgc29tZSBvdGhlciBpc3N1ZXM/IEkganVzdCB3b25kZXINCj4gPiBob3cgdGhpcyBjYXNl
IGJlaW5nIGhhbmRsZWQuDQo+IA0KPiBXaGF0IGlzIHRoZSBpc3N1ZSB0aGF0IDVmZTE1NmYxY2Fi
NGYgZml4ZXM/IEl0IGlzIG5vdCBjbGVhciBieSBsb29raW5nIGF0IHRoZQ0KPiBjb21taXQgbG9n
Lg0KDQpPbiBzb21lIG5ldyBpLk1YIHBsYXRmb3JtcywgUEZ1emUgc3dpdGNoZXMgYXJlIHVzZWQg
Zm9yIHN1cHBseWluZyBHUFUvVlBVDQpvciBvdGhlciBub24tY3JpdGljYWwgbW9kdWxlcyBvbmx5
LCB0aGVzZSBzd2l0Y2hlcyBuZWVkIHRvIGJlIHR1cm5lZCBvZmYgYnkNCnJ1bnRpbWUgUE0gdG8g
YXZvaWQgdmVyeSBoaWdoIHBvd2VyIGxlYWthZ2UsIGxpa2Ugb24gbVNjYWxlODUwRC4NCg0KQW5z
b24NCg0K
