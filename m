Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D410C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C182920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+X00fu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C182920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJDQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:20:35 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:2976
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbeJDQUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eB3Sn+sJ6V7VKxmDLlACJ0LVEVxE0iay3+fD9zY8Vc=;
 b=G+X00fu5PUVV2P9nXZBMMECUfsszInMKvP0nWwyBhmPCk5NNxFvLNmdlMk41K3/McHaehVHQlyT9ekgnmubnW/JTmdMF0slbiZZGcm9O6Ditt4CTULLGQAXg0Mf2fatqrK+SmhJI6Hg7oHi/9UFfkbv84M900L3LDUlm3aMFsk8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5295.eurprd04.prod.outlook.com (20.177.51.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 09:28:06 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 09:28:05 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: RE: [PATCH 0/4] spi: add support for octal mode data transfer
Thread-Topic: [PATCH 0/4] spi: add support for octal mode data transfer
Thread-Index: AQHUW79Np9I4f6guoUe7T1EYEgBQmKUOz/8AgAABEFA=
Date:   Thu, 4 Oct 2018 09:28:05 +0000
Message-ID: <VI1PR04MB103828C628A6550F7E1B942E99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
In-Reply-To: <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5295;6:/oy6mK2JGjHsVkrnN6k40LuI07g8A+9oriBhssG6tyHH3UKTiM6MaJxUjA0aS3ChB1LMyOLI2iK4N5ugLsg4F4LkD+ITTPkJK7V0r5PM7O3fqu4Tf8kD39hUT/VRrFL7+iYGizKpWibH3aWtpPNEVNWUX6R9/sh+jSZ8MdnFOyQu03Hyj5/4MTApZAwz3kiGo8506jTMbouuvOtTnOq9xeVtF1eVNj62GtlokQCs01J7Z/9hTSqYc+HcAULZuqqtwMToocksJWhYhA0QrRHoZ2BlIReGRYS1lb0sjszDwL4+u4LiP8LZm8E6kllx6XeXLEfVx3APmwG6AWmriEBPmLVBQvPTmc/Yaza2o43txkuHSe/5Fa+zsVhwd8T+VhOTjq6JiJDJavVXmQ3W4fxLw8k1w/1uZqNLYqd1APtfwZ8z6AlDnHI6vlTA5wkZY7ay74MtEomHPpvwxoauGe5QWg==;5:JMfU0RFtmMtMmWnFE2JrgTYk9lvlIpe8up3rvkkQ4cQLbgNBgYJxiw2t2pG5ylTtg2E8ccThsckX6PBa1TOXYASEgwRSeJ83/0z9QM24hVIFvLqEXJBSyiOEe0B8iZCYjsaFjdB0O7kkBOe0N0vWGqb5CP/jNhCGMxWy6Ls8xm4=;7:Wklvajf3lwAiDrC57o7fKFeFfDqeC76g7XkXOho4Rnlg8ocEBTFeCxJGgl/JcFTkCopPc6ozpfM4tVF1rrRyaAfVe5dT6dIKm7alZYiaji8Rnv3/muJ+EpH50LMLSt5Bd1aUPHmiDML7hqx1K4Bbvaw2nCwLORr/BRWRnnBZQj9HsJalO+qhp9JgTN4mu+XcXZxNckR5f8lMzlqEXYAG2d/I5QbBp+k0yx+KHBc/d+/mJuSgMHkAEh6yXAPtVAbJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e1717ffc-c4a2-4189-339f-08d629dbb073
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5295;
x-ms-traffictypediagnostic: VI1PR04MB5295:
x-microsoft-antispam-prvs: <VI1PR04MB5295E4C6C3F6D1E3AC44E93B99EA0@VI1PR04MB5295.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(258649278758335)(85827821059158)(9452136761055)(180628864354917)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB5295;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5295;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(13464003)(199004)(189003)(51914003)(11346002)(446003)(53546011)(99286004)(6506007)(76176011)(256004)(14444005)(2906002)(110136005)(54906003)(476003)(3846002)(6116002)(66066001)(486006)(229853002)(102836004)(81156014)(53936002)(9686003)(74316002)(8676002)(7416002)(8936002)(7736002)(55016002)(316002)(186003)(7696005)(2900100001)(26005)(6436002)(305945005)(81166006)(6306002)(25786009)(86362001)(5250100002)(478600001)(2501003)(575784001)(2201001)(45080400002)(5660300001)(106356001)(105586002)(966005)(4326008)(14454004)(39060400002)(6246003)(68736007)(71190400001)(97736004)(71200400001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5295;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RDwEklwJ3eoU6XyqiZWDQBpe+SUYFvLm3GQflLIbQbWs0N/8+lk2SsJLdKx5Kszydm/RScAO1rJ+5IKWtlz0aqrWX4NPfNGZyE4lJbeRM9D9LRe3eO2bJAw1VN2wwZYGv4iAqfmJPSKtiqFjD73c9uL04Sf6GkI7NjxG0m93idGnnz7+fFSp7YCHP3Bnnf0DDwl1whV0cB6Wn4vYDaEMORIYk9S3h+kfR9dmoWjSvyCams3CuEf4f+Di22hC//myO8f5N+iHMmcPBx/kdsJ6q+x2lr/LyJl+psJAP121AYjVeUp647S929HpeV02bkXNIcsmAagC0xRuYLSSEoahZWnv0grtoQRJas/6sFi6dus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1717ffc-c4a2-4189-339f-08d629dbb073
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:28:05.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWdu
ZXNoIFIgW21haWx0bzp2aWduZXNockB0aS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDQsIDIwMTggMjo1MiBQTQ0KPiBUbzogWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFyYXlh
bi5nYXVyQG54cC5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOw0KPiBsaW51eC1z
cGlAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogcm9i
aEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsg
bGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY29tcHV0ZXJzZm9ycGVh
Y2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNF0gc3BpOiBhZGQgc3Vw
cG9ydCBmb3Igb2N0YWwgbW9kZSBkYXRhIHRyYW5zZmVyDQo+IA0KPiBIaSBZb2dlc2gsDQo+IA0K
PiBPbiBUaHVyc2RheSAwNCBPY3RvYmVyIDIwMTggMDI6MTggUE0sIFlvZ2VzaCBHYXVyIHdyb3Rl
Og0KPiA+IEFkZCBzdXBwb3J0IGZvciBvY3RhbCBtb2RlIElPIGRhdGEgdHJhbnNmZXIuDQo+ID4g
TWljcm9uIGZsYXNoLCBtdDM1eHU1MTJhYmEsIHN1cHBvcnRzIG9jdGFsIG1vZGUgZGF0YSB0cmFu
c2ZlciBhbmQgTlhQDQo+ID4gRmxleFNQSSBjb250cm9sbGVyIHN1cHBvcnRzIDggZGF0YSBsaW5l
cyBmb3IgZGF0YSB0cmFuc2ZlciAoUngvVHgpLg0KPiA+DQo+ID4gUGF0Y2ggc2VyaWVzDQo+ID4g
KiBBZGQgc3VwcG9ydCBmb3Igb2N0YWwgbW9kZSBmbGFncyBhbmQgcGFyc2luZyBvZiBzYW1lIGlu
IHNwaSBkcml2ZXIuDQo+ID4gKiBBZGQgb2N0YWwgZGF0YSBjb21tdW5pY2F0aW9uIGNvbW1hbmRz
IHJlcXVpcmVkIGZvciBtdDM1eHU1MTJhYmEgWzFdDQo+IGZsYXNoLg0KPiA+ICogQWRkIHN1cHBv
cnQgZm9yIFJlYWQgYW5kIFdyaXRlIHByb3RvIGZvciAoMS0xLTgvMS04LTgpIG1vZGUuDQo+ID4g
KiBBZGQgbW9kZSBiaXQgcmVxdWlyZWQgZm9yIG9jdGFsIG1vZGUgaW4gbnhwLWZzcGkgZHJpdmVy
IFsyXS4NCj4gPiAqIERlZmluZSBiaW5kaW5nIHByb3BlcnR5ICdzcGktcngvdHgtYnVzLXdpZHRo
JyBmb3IgTFgyMTYwQVJEQiB0YXJnZXQgWzJdLg0KPiA+DQo+ID4gVGVzdGVkIG9uIExYMjE2MEFS
REIgdGFyZ2V0IHdpdGggbnhwLWZzcGkgZHJpdmVyLCBiZWxvdyBhcmUgUmVhZA0KPiA+IHBlcmZv
cm1hbmNlIG51bWJlciBvZiAxLTEtMSBhbmQgMS0xLTggcmVhZCBwcm90b2NvbC4NCj4gPg0KPiA+
ICByb290QGx4eHg6fiMgY2F0IC9wcm9jL210ZA0KPiA+ICBkZXY6ICAgIHNpemUgICBlcmFzZXNp
emUgIG5hbWUNCj4gPiAgbXRkMDogMDQwMDAwMDAgMDAwMDEwMDAgInNwaTAuMCINCj4gPiAgbXRk
MTogMDQwMDAwMDAgMDAwMDEwMDAgInNwaTAuMSINCj4gPiAgcm9vdEBseHh4On4jIHRpbWUgbXRk
X2RlYnVnIHJlYWQgL2Rldi9tdGQwIDB4MCAweDEwMDAwMDAgMHJlYWQNCj4gPiBDb3BpZWQgMTY3
NzcyMTYgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2ggdG8gMHJlYWQNCj4g
Pg0KPiA+ICByZWFsICAgIDBtMi43OTJzDQo+ID4gIHVzZXIgICAgMG0wLjAwMHMNCj4gPiAgc3lz
ICAgICAwbTIuNzkwcw0KPiA+ICByb290QGx4eHg6fiMgdGltZSBtdGRfZGVidWcgcmVhZCAvZGV2
L210ZDEgMHgwIDB4MTAwMDAwMCAwcmVhZA0KPiA+IENvcGllZCAxNjc3NzIxNiBieXRlcyBmcm9t
IGFkZHJlc3MgMHgwMDAwMDAwMCBpbiBmbGFzaCB0byAwcmVhZA0KPiA+DQo+ID4gIHJlYWwgICAg
MG0wLjQ0MXMNCj4gPiAgdXNlciAgICAwbTAuMDAwcw0KPiA+ICBzeXMgICAgIDBtMC40NDBzDQo+
ID4gIHJvb3RAbHMxMDEyYXJkYjp+Iw0KPiA+DQo+ID4gIEZsYXNoIGRldmljZSBNVEQwIGNvbmZp
Z3VyZWQgaW4gMS0xLTEgcHJvdG9jb2wuDQo+ID4gIEZsYXNoIGRldmljZSBNVEQxIGNvbmZpZ3Vy
ZWQgaW4gMS0xLTggcHJvdG9jb2wuDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2VtZWEwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0DQo+
ID4gY2h3b3JrLm96bGFicy5vcmclMkZwcm9qZWN0JTJGbGludXgtDQo+IG10ZCUyRmxpc3QlMkYl
M0ZzZXJpZXMlM0Q2NjMxNyZhbXANCj4gPiA7ZGF0YT0wMiU3QzAxJTdDeW9nZXNobmFyYXlhbi5n
YXVyJTQwbnhwLmNvbSU3QzdhYWU4YmE3MWQ4MDQyMGQ0DQo+IDQ5ZjA4ZA0KPiA+DQo+IDYyOWRh
ZDQ0ZCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3NDI0
MTcNCj4gMTg5MzAwDQo+ID4NCj4gNTc0JmFtcDtzZGF0YT14c1NwbW9SekRLSjlaNk81NmtURzVw
SFBvamptVWZTejlyQjVjV1FsUEVNJTNEJmFtDQo+IHA7cmVzZXINCj4gPiB2ZWQ9MCBbMl0NCj4g
PiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGcGF0DQo+ID4gY2h3b3JrLm96bGFicy5vcmclMkZwcm9qZWN0JTJGbGludXgt
DQo+IG10ZCUyRmxpc3QlMkYlM0ZzZXJpZXMlM0Q2Njg4NyZhbXANCj4gPiA7ZGF0YT0wMiU3QzAx
JTdDeW9nZXNobmFyYXlhbi5nYXVyJTQwbnhwLmNvbSU3QzdhYWU4YmE3MWQ4MDQyMGQ0DQo+IDQ5
ZjA4ZA0KPiA+DQo+IDYyOWRhZDQ0ZCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzY3NDI0MTcNCj4gMTg5MzAwDQo+ID4NCj4gNTc0JmFtcDtzZGF0YT1vRnNm
VHRwdDBHRGkzeTBGaSUyQiUyRjlTRnA4WnZid1BQZTVxTU5GSXdWdzd3RSUzRA0KPiAmYW1wO3IN
Cj4gPiBlc2VydmVkPTANCj4gPg0KPiA+IFlvZ2VzaCBHYXVyICg0KToNCj4gPiAgIHNwaTogYWRk
IHN1cHBvcnQgZm9yIG9jdGFsIEkvTyBkYXRhIHRyYW5zZmVyDQo+ID4gICBtdGQ6IHNwaS1ub3I6
IGFkZCBzdXBwb3J0IGZvciBvY3RhbCBtb2RlIGRhdGEgdHJhbnNmZXINCj4gPiAgIHNwaTogbnhw
LWZzcGk6IGFkZCBtb2RlIGZsYWcgYml0IGZvciBvY3RhbCBzdXBwb3J0DQo+ID4gICBhcm02NDog
ZHRzOiBseDIxNjBhOiB1cGRhdGUgZnNwaSBub2RlDQo+IA0KPiBUaGlzIGlzIGEgYml0IGNvbmZ1
c2luZyBhbmQgZGlmZmljdWx0IHRvIGZvbGxvdy4gSSBzdWdnZXN0IHRvIG9yZGVyIHBhdGNoZXMg
c3VjaCB0aGF0DQo+IHNwaS1ub3IgbGF5ZXIgY2hhbmdlcyBhcmUgYXQgdGhlIGZpcnN0LCB0aGVu
IG0yNXA4MCByZWxhdGVkIHRoaW5ncywgZm9sbG93ZWQgYnkNCj4gc3BpLW1lbSAoaWYgbmVlZGVk
IHNwaSkgY2hhbmdlcyBhbmQgZmluYWxseSBzcGktbWVtIGNvbnRyb2xsZXIgZHJpdmVyIGNoYW5n
ZXMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50Lg0KV291bGQgY2hhbmdlIHRoZSBwYXRj
aCBvcmRlciBhcyBzdWdnZXN0ZWQgYW5kIGJyZWFrIHRoZSBmdW5jdGlvbmFsaXR5IGluIHNtYWxs
IHBhdGNoZXMgYXMgc3VnZ2VzdGVkIGJ5IEJvcmlzLg0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdh
dXINCg0KPiAtLQ0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCg==
