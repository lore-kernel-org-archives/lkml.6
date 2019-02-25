Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DE2C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076E220578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BsQlSaAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfBYX6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:58:54 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:24545
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfBYX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqSv9gS8+N6qd43CVNXi91kEss1FMTAs7SNKwZch72w=;
 b=BsQlSaAqmURSsNZFz8MdcXgY9Ta6eB2+oqJ9UpPWjJ6+DF9FsuHTVZzYV9TEIDhKb05sF57vpgHF5K6nQudFcNpLVvs1ROn7PBzJyU3OXRibOmoFvk/Vp6+fhkOZboDlcj624X6QxbUb+N2LIQhmVyRtm+vKRawsJ/N22j8lmfI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5953.eurprd04.prod.outlook.com (20.178.112.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 23:58:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 23:58:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 1/2] percpu: km: remove SMP check
Thread-Topic: [PATCH 1/2] percpu: km: remove SMP check
Thread-Index: AQHUzELEXhV7UVWfi0W/HwwXYpeEX6XwoM8AgACQv1A=
Date:   Mon, 25 Feb 2019 23:58:50 +0000
Message-ID: <AM0PR04MB4481CCD46C5BE5F6B7A11846887A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68450282-1f4a-4d6e-4489-08d69b7d3055
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5953;
x-ms-traffictypediagnostic: AM0PR04MB5953:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTBQUjA0TUI1OTUzOzIzOjdyb3RJMGJPTUlFbUdJMDJxRmFmNHN4bHU1?=
 =?gb2312?B?TmpWSlpDNWF3cTNCMUlYMTg0eWR2OXNnS28xUEdCWVZHbS9hWnR5NW9ZVGEv?=
 =?gb2312?B?NFBCdHZZRlQ3UGp1b0QrbTc1c01EeGtSc0Y3em01ZjltSHJ1cEVzMmNlQXlK?=
 =?gb2312?B?RXFKR3B5N2Y1T0VnTXJuMVpmNEdnRG9iQ1loSTVHNnBBNnE2bXlPbVZJbFRk?=
 =?gb2312?B?VjJiWUcvb3Y1eWN3NjdGanhFMktzL2ZlL290Rm04S3daVWk2RE44RVpWODZL?=
 =?gb2312?B?Z2RMRkNoQUdVUXBJNmVRUGVtSklCZ3BiUEdGZktneTcyMk12Y2doTzRaMHRo?=
 =?gb2312?B?ZSt5a3VtOTNDWitiZDRVMG0yeUczSWlzV2hlSlBHUE1hR1dPZmh0NXFWL3JQ?=
 =?gb2312?B?M3Z2bkJ2c1pQZE1kNnhob0I3QWpENmwzN2Q1a3BUK05JbWdWSEJFZEVLMWdF?=
 =?gb2312?B?RXg0Vms1QkxZVVcxcTkzZ3lhMGRzSEgreTAvSm5HWDZ4bGpsazJFT1dLSjI3?=
 =?gb2312?B?SjRVTFpVNDJPbGxUVXdBR0U4NUM4YURLamUzUEkzSGxqSC9aUU9zSlVCcUls?=
 =?gb2312?B?YWVKWVZRRXluRVY5c1J5KzBjb1RtazI5LzZvNk5VMU1BU1RiRG1BV2gzd2Ju?=
 =?gb2312?B?dWhUVTJOaGlqR0M3OFUrTXl0UjJCcVBwTnFDODBKT1czeEgxVHBHd1NDM3Jq?=
 =?gb2312?B?QUhSUGRYck5FNnY3KzBseWNrNkF3cFhSbkVob0FNbjI5cWxyZXJyVjZnMnFm?=
 =?gb2312?B?bVpSdmMrRkgwajNEeUNIOGt1SkorS0hKSyswdmpKNWR5V1FWbnBxSFVvV3lk?=
 =?gb2312?B?cGExaHRxNTlQTnhhYk4wNDB6WENTRXBRYk05K0ZGY0xSS3plN3JlVlJaTGlU?=
 =?gb2312?B?d045WmVzanNodTFUemxIVGlNQndBeVlKakVZSWNYcVkyeTF4RGkwUWdtWVhF?=
 =?gb2312?B?ZHFNSUlJUGFoK2ErZ2w4ZEUwWUZLeHViY3k5YWd3WldKV3QrL0IxOGliOEJh?=
 =?gb2312?B?ZDFYUU5RNXJwUEI2STZ2SXJrR0hseFpyZmIyd0pITmZxYXZFbDBOQU1OM0tm?=
 =?gb2312?B?REQzd0JoTjA2dXhBQ2x3QWFsVkY4eUlvekIxSnFXamNNcEYwTW5LZjdsbkxM?=
 =?gb2312?B?MEErNUhNazV0WEVER3dkZVg4cXFGVElJQ3IycjFxTW81cXJYYjBOYnErQ01O?=
 =?gb2312?B?ZGNkdkVJQzZQYUtLOGdxc2h3ZzdpMFJnNzQ5SUppc1dsYk13WXlYK3RQejFO?=
 =?gb2312?B?cXpOUTUxUE1zL2lsOWVid1ZEeUNCdkdIZzMva3ZzU20wYXorb1BaMWkwWXlx?=
 =?gb2312?B?UzF1ci9rNEFOQU95OVZhWFZaRG1GVVBXTjI2bm9TWlF2N2pwQXo3M0E0bjdF?=
 =?gb2312?B?Mm9peVVLMTRzQnk2Z1pMWFdraWVNRWpKbXdRWUpkWUozYlp0VXgwNE1XZXpL?=
 =?gb2312?B?cGNpd3cwb2FLZmZubnBvcHVQSzUwLzdQTjdBaG9CNlJiRE1GUno5bUR2REFy?=
 =?gb2312?B?aEIyQTh1ZXN5Q1d5QWZPbHg3WGxvam44WDdZQmNMc0tiTW90QzJ6c1RPRE44?=
 =?gb2312?B?YllJc3d6YW5PMkQyajZvRFNQOTNLMGRIc0FNL3VaVjdMTnZOMGhYV0JQZlRt?=
 =?gb2312?B?ZEpDa1JWUVBFTGIva1VTMFdIMGRXRWVpZ3IrYTlUaVZLTEdnM0I2ZExhSlpi?=
 =?gb2312?B?LzcrNjBoaW40Y094VnVjS0xIMXQycHBlQVJ0R1BOdnZhaWVRN3dqbkxnQmFx?=
 =?gb2312?B?Wm5Zd3I3MkxvNkpxSjZMZz09?=
x-microsoft-antispam-prvs: <AM0PR04MB5953BA9A3A6991CF8ACC1CA2887A0@AM0PR04MB5953.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(13464003)(199004)(26005)(2906002)(106356001)(105586002)(33656002)(54906003)(66066001)(6246003)(68736007)(4326008)(25786009)(6436002)(55016002)(14454004)(476003)(53936002)(316002)(44832011)(486006)(9686003)(11346002)(446003)(478600001)(186003)(8676002)(8936002)(81156014)(74316002)(81166006)(7736002)(305945005)(3846002)(97736004)(14444005)(6916009)(6506007)(53546011)(229853002)(102836004)(7696005)(256004)(99286004)(86362001)(76176011)(5660300002)(52536013)(71200400001)(71190400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5953;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jm43aaLyjnH3Ps3LfA5adnnFyhyw0oWlVlyIMcHiutjKtR+0fonPz+253xbYTQ604wUosB9pLiamiUAtk8jDOHGLxMRfayOWhdh8bH3J0kqo3FAI52pCi4uUipzZ5Fhjl7TeXzx/+Sus8sLNMYIGXJbNaO889ILAnDZ5QqATjsGWShxF5iWORNOIQgeO+Vmip6RdjVqmna3KyrUorJhj78whOcRKlTgaWQXJ16w+tZXhTubLrQgs1opsUlt77fLNhcyQzAXdVeqzU6iS5sU/GUo/bdp8jNTuVmj6BWzhA14PYwbp26BLhI2FbsUwwTuRr1F0B36E6qTpYB2GXa8ThDiMlZuIQvr8raS0XN87SiJTm2tQzdQHlYcijd2X6jsHVuY6hh9R2ore2vePQ21+zloFbN329GP0N/x5Mg9F3SM=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68450282-1f4a-4d6e-4489-08d69b7d3055
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 23:58:50.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5953
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGVubmlzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERlbm5p
cyBaaG91IFttYWlsdG86ZGVubmlzQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnE6jLUwjI1yNUg
MjM6MTQNCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogZGVubmlzQGtl
cm5lbC5vcmc7IHRqQGtlcm5lbC5vcmc7IGNsQGxpbnV4LmNvbTsgbGludXgtbW1Aa3ZhY2sub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2YW4uZnJlZW5peEBnbWFpbC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBlcmNwdToga206IHJlbW92ZSBTTVAgY2hlY2sN
Cj4gDQo+IE9uIFN1biwgRmViIDI0LCAyMDE5IGF0IDAxOjEzOjQzUE0gKzAwMDAsIFBlbmcgRmFu
IHdyb3RlOg0KPiA+IHBlcmNwdS1rbSBjb3VsZCBvbmx5IGJlIHNlbGVjdGVkIGJ5IE5FRURfUEVS
X0NQVV9LTSB3aGljaCBkZXBlbmRzDQo+IG9uDQo+ID4gIVNNUCwgc28gQ09ORklHX1NNUCB3aWxs
IGJlIGZhbHNlIHdoZW4gY2hvb3NlIHBlcmNwdS1rbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9wZXJjcHUta20u
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vcGVyY3B1LWttLmMgYi9tbS9wZXJjcHUta20u
YyBpbmRleA0KPiA+IDBmNjQzZGMyZGM2NS4uNjZlNTU5OGJlODc2IDEwMDY0NA0KPiA+IC0tLSBh
L21tL3BlcmNwdS1rbS5jDQo+ID4gKysrIGIvbW0vcGVyY3B1LWttLmMNCj4gPiBAQCAtMjcsNyAr
MjcsNyBAQA0KPiA+ICAgKiAgIGNodW5rIHNpemUgaXMgbm90IGFsaWduZWQuICBwZXJjcHUta20g
Y29kZSB3aWxsIHdoaW5lIGFib3V0IGl0Lg0KPiA+ICAgKi8NCj4gPg0KPiA+IC0jaWYgZGVmaW5l
ZChDT05GSUdfU01QKSAmJg0KPiA+IGRlZmluZWQoQ09ORklHX05FRURfUEVSX0NQVV9QQUdFX0ZJ
UlNUX0NIVU5LKQ0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfTkVFRF9QRVJfQ1BVX1BBR0VfRklS
U1RfQ0hVTkspDQo+ID4gICNlcnJvciAiY29udGlndW91cyBwZXJjcHUgYWxsb2NhdGlvbiBpcyBp
bmNvbXBhdGlibGUgd2l0aCBwYWdlZCBmaXJzdA0KPiBjaHVuayINCj4gPiAgI2VuZGlmDQo+ID4N
Cj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo+IA0KPiBIaSwNCj4gDQo+IEkgdGhpbmsga2VlcGlu
ZyBDT05GSUdfU01QIG1ha2VzIHRoaXMgZWFzaWVyIHRvIHJlbWVtYmVyIGRlcGVuZGVuY2llcw0K
PiByYXRoZXIgdGhhbiBoYXZpbmcgdG8gZGlnIGludG8gdGhlIGNvbmZpZy4gU28gdGhpcyBpcyBh
IE5BQ0sgZnJvbSBtZS4NCg0KWW91IG1pZ2h0IGJlIHdyb25nIGhlcmUuDQpJbiBtbS9LY29uZmln
LCBORUVEX1BFUl9DUFVfS00gZGVmYXVsdCB5IGRlcGVuZHMgb24gIVNNUC4gU28gaWYgQ09ORklH
X1NNUA0KaXMgbm90IGRlZmluZWQsIE5FRURfUEVSX0NQVV9LTSB3aWxsIGJlIHRydWUuIElmIHdl
IGFsc28gZGVmaW5lDQpDT05GSUdfTkVFRF9QRVJfQ1BVX1BBR0VfRklSU1RfQ0hVTkssIHRoZSAj
ZXJyb3Igd2lsbCBoYXZlIG5vIGNoYW5jZQ0KdG8gYmUgZGV0ZWN0ZWQgYmVjYXVzZSBDT05GSUdf
U01QIGFscmVhZHkgYmUgZmFsc2UuDQpUaGF0IG1lYW5zIENPTkZJR19TTVAgd2lsbCBhbHdheXMg
YmUgZmFsc2UgaWYgcGVyY3B1LWttIGlzIHVzZWQuDQpTbyBuZWVkIHRvIGRyb3AgdGhlIENPTkZJ
R19TTVAgY2hlY2sgaGVyZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBE
ZW5uaXMNCg==
