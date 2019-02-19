Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A297DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3xJGdxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfBSUHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:07:31 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:3776
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfBSUHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlnu2xq850A9e5tFnHYaGTbGQryzXqdqu0hi8yKWlMQ=;
 b=D3xJGdxAFnegCPidRjOMdSgzg9ZrpAMhMvIFaYj579JXeSISew9NXaEL9aKgIk2rsUDKjQn46RAoTTUD0G4nJPukZkoOcfj1q/uB+3rcRHRmlKlC49VJI5RuUHaXnMjZurS/90kHiltZpQaUoX5PD05pyVK0pbDOQFrbbEjlpZY=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB3973.eurprd04.prod.outlook.com (52.135.160.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 20:07:27 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 20:07:27 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Peter Rosin <peda@axentia.se>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH] drivers: mux: Generic register bitfield-based multiplexer
 driver
Thread-Topic: [PATCH] drivers: mux: Generic register bitfield-based
 multiplexer driver
Thread-Index: AQHUx0xz2hlFfSdjRkyo3ywwDF+eo6XlTzmAgAADfWCAAErjAIAAbmmQgAArf4CAAVNNAA==
Date:   Tue, 19 Feb 2019 20:07:27 +0000
Message-ID: <AM6PR04MB5863258E5168DD5115AEBDA88F7C0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190218110509.28225-1-pankaj.bansal@nxp.com>
 <3d8168fa-d71a-bcb7-6a1a-a82fad1a01f4@axentia.se>
 <VI1PR0401MB2496C7B8250C4E760108F6FFF1630@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <a653de12-4785-615a-670e-2cf68bee1372@axentia.se>
 <AM0PR04MB58588DDADE24F3612E5EF5108F630@AM0PR04MB5858.eurprd04.prod.outlook.com>
 <bfe3fd9c-7375-1c53-5692-7cdea3c9b670@axentia.se>
In-Reply-To: <bfe3fd9c-7375-1c53-5692-7cdea3c9b670@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dae1890-638f-4a89-916c-08d696a5defd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB3973;
x-ms-traffictypediagnostic: AM6PR04MB3973:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUIzOTczOzIzOkl0Y0hqK0t4Mjlja3AzMloxRFpBb0VOWlNu?=
 =?utf-8?B?ZHVzKzlXS2dIczhlVXR0a0pPTEY2WWVYRkdxaStybDd0ZThOaDJPOE5DMEtz?=
 =?utf-8?B?UzkrblZLWDlONTN4dmZDRCtZSVozQmVBNEVUWlhaQWxheFd6eVl5UFVPOW5T?=
 =?utf-8?B?RXdWZk9RWDZLSFpZMzE2UllrNGh5cS9tQWZMOXdOcVVuTThHQ2NwU3VYYS8v?=
 =?utf-8?B?VnhKVndwb0UzZ0srcUI2ak9saVh5SGw3T2RlKzVlazV6QzFHSWRCNHpKUjBO?=
 =?utf-8?B?OVl2SjV1UFVSeFkyMXY2VVh2RHo3cmhXYXMrV21LRlhhbVFkYUR1OHprS3NX?=
 =?utf-8?B?NERTUHlHUzZsN1VGeG4xWTJCL0tlS3FZV3AxNXYrUjFHTDVsa1pNeWhaZnBE?=
 =?utf-8?B?ZS9ORU9adDlvYm5LeFFFbTZmSWN5aE9Sa3p0U2J6QkxXTEZxMmExRjZYdkJv?=
 =?utf-8?B?ZkdxV25VOG1Wd09pamZvamloSTZield1NXhCcW5qaG1XZEtFS29QUWNJdEVz?=
 =?utf-8?B?OHVHQWZLaDlWVlBvSGxxNEJDRHlnS2VoYkhJZXR4TkZ2dld1TUNuSDhKTTN2?=
 =?utf-8?B?Nk93Rm5rdkNFRWFTNmdRbkhwRktXeURWeFZGVWZvaFlOVkZ4NWFNWVlpUzEx?=
 =?utf-8?B?djY3SGhmd0FLV2Z6cTh2VE9QelQ5c3haTEh5VUxPQUlOWU82MGtnRStZNG9u?=
 =?utf-8?B?cUs5QW5sZUxTNzF5TUl5TWUvakxZMTJLSlRzV1ZqZk5tSjh3YU5DSXVwSEkr?=
 =?utf-8?B?dW95WER1RVVibTlEYTVvbWlUM1kwbnN6dmp6UVZlYWs1N1BoczZzOGtMcHBv?=
 =?utf-8?B?RzUrVDRxckEyb0tRVytvSmdHZUs0a3pUM29qTHg4NisrVy80dnZqanBUZlJp?=
 =?utf-8?B?TG5RTXh4K05Ha3pSaFZSUmJSbHRTMFN2Vm5YeS9hZmN3M3YrL3FjcFl5Sm9n?=
 =?utf-8?B?aHVFb01mNUF0dlpIbWc4dkJROThrdVZYQktCbWNBbmo5ODVVNFVIQndnOS84?=
 =?utf-8?B?QVpESStaL1REK0dBbjV4V1dzeGZ0NUdSMk53L2ZhcHg1WHl6R0RUZU93dUk2?=
 =?utf-8?B?ZnhjUzlqY0FqV2NzaVpmTnk1UktQOWVreEI5OTc3cUtwWGZUbS9XbFZhMzZE?=
 =?utf-8?B?WGRtY1V6eUlPTEtZL08zTkVNNVFLUzVuWE8rNW50ei9RWS9ybkh5SXBTSzQ3?=
 =?utf-8?B?ZWpDOFFqWERubXdEVjJrcnRUcFZHUU9FdDdZSmJ3b0ZoQWIzR1luay9qemRY?=
 =?utf-8?B?RUNRZjNQYWhheEh5a0prNTJRTHc1SkczQ1JRbGRqaFF1THlNV3JqWXMyaDZY?=
 =?utf-8?B?clFOVlpja2hGdW1DdTV0RklHcmVUZW53MEtJV3RubTVVWHp0NFJpTUFHMlZP?=
 =?utf-8?B?RE5nQ2xsZkZSSVYyeUJLTDJFWjlkdFdBZVdWMnU4aEdnNlNLb21KZkk3Slpi?=
 =?utf-8?B?NmFFbllmeUVLNjdHekZ0alVuaGE1OFV5NHVldEZkUDZjbmp1S09kdkpIVDJq?=
 =?utf-8?B?enhublRseGpyTzg4YVZOdTd0TG5CMThwS0hvcXI2WDZGQWh3SUNIcFRBdHZM?=
 =?utf-8?B?YW5haUtsZWI3aU5HV01OVXVzWEk3bUxoSTg0Z01EaU9kc3VLVXJIb3JYbkdD?=
 =?utf-8?B?eDdWTE1lS29mZjJESURvRkFjTWlXeWptc3ZXVjhycnRNenZiSVdqNldHcGVW?=
 =?utf-8?B?RWtKa21yZyttNkxyWU5LK0g5VjV3bXZFamNzdkFRQStmNUl6dUJOQ2YvVWVo?=
 =?utf-8?B?cSsvSzBYcGZlODJ1U2xFQT09?=
x-microsoft-antispam-prvs: <AM6PR04MB3973C2AD71030EB1768A5E4D8F7C0@AM6PR04MB3973.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(189003)(199004)(13464003)(52314003)(6116002)(3846002)(14454004)(316002)(229853002)(93886005)(66066001)(68736007)(97736004)(71200400001)(71190400001)(5660300002)(74316002)(86362001)(26005)(99286004)(105586002)(2501003)(305945005)(7736002)(256004)(14444005)(33656002)(25786009)(102836004)(446003)(53546011)(6506007)(76176011)(478600001)(106356001)(476003)(486006)(11346002)(186003)(6246003)(8676002)(81156014)(81166006)(53936002)(8936002)(2906002)(55016002)(9686003)(110136005)(6436002)(7696005)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3973;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mJztLjHoJzSXA5DWkSQWaNgPJKlC5o+z0vddeANU9X9pWnlWHIH6UubCkeebyqQcrCaG9sjhprzsdYxBVyAcJSe2/WOPn21qC23q7TlpA6ZqhRMR2FV7mAK96Bz4nVnParkXcSvYNo/1ufsyQMpVVO1q8h5p758cPPlRE1jwTAXMR5ZegqXLLeJC4WDs+G1KJCaZwscz0T+ONmA9IzWXZkZ2LCSAY4ZLh41XuOZJ5euKANqebALXgdNcWO2wGuahlCg99+UbPREKBCm9KsraSQklnysU7qEPP2xwOEMH0G5nZ+NeeQ+GSQ5zA24ri/vAgvja0T/UkxMYf61OwYBw4WyrTlHAZhGbDjZayXcK+Rm1IhSY1l/uYLvnv6cpBoN1uWSNNGHNQYHdyJGKgQS61YeMG6XFFbNU60H8nwaurVA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dae1890-638f-4a89-916c-08d696a5defd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:07:27.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgUm9zaW4gPHBl
ZGFAYXhlbnRpYS5zZT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxOCwgMjAxOSA1OjM5IFBN
DQo+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFBhbmthaiBCYW5zYWwgPHBhbmth
ai5iYW5zYWxAbnhwLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBoaWxp
cHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRyaXZlcnM6IG11eDogR2VuZXJpYyByZWdpc3RlciBiaXRmaWVsZC1iYXNlZA0KPiBtdWx0aXBs
ZXhlciBkcml2ZXINCj4gDQo+IE9uIDIwMTktMDItMTggMjI6MDcsIExlbyBMaSB3cm90ZToNCj4g
PiBGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPiA+PiBPbiAyMDE5LTAyLTE4
IDExOjIwLCBQYW5rYWogQmFuc2FsIHdyb3RlOg0KPiA+Pj4gRnJvbTogUGV0ZXIgUm9zaW4gW21h
aWx0bzpwZWRhQGF4ZW50aWEuc2VdDQo+ID4+Pj4gQW55d2F5LCBJIHdvdWxkIHByZWZlciBpZiB5
b3UgY291bGQgZXh0ZW5kIGRyaXZlcnMvbXV4L21taW8uYyB0bw0KPiA+Pj4+IHN1cHBvcnQgYm90
aCBjb21wYXRpYmxlcywgYW5kIHVzaW5nIHRoZSBjb21wYXRpYmxlIHRvIHNlbGVjdCBpZg0KPiA+
Pj4+DQo+ID4+Pj4gCXJlZ21hcCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChucC0+cGFyZW50KTsN
Cj4gPj4+Pg0KPiA+Pj4+IG9yDQo+ID4+Pj4NCj4gPj4+PiAJcmVnbWFwID0gZGV2X2dldF9yZWdt
YXAoZGV2LT5wYXJlbnQsIE5VTEwpOw0KPiA+Pj4+DQo+ID4+Pj4gaXMgY2FsbGVkIHRvIGdldCB0
byB0aGUgZGVzaXJlZCByZWdtYXAuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBjYW4gYmUgZG9uZS4gVGhl
IG5hbWUgbW1pby5jIGhvd2V2ZXIgc3VnZ2VzdHMgdGhhdCBtdXggaXMNCj4gPj4+IGNvbnRyb2xs
ZWQgYnkgYSBNZW1vcnkgbWFwcGVkIGRldmljZS4NCj4gPj4+IElNTywgaWYgdGhlIGdlbmVyaWMg
cmVnbWFwIEFQSSBpcyB0byBiZSBhZGRlZCB0byBpdCwgdGhlIG5hbWUgbmVlZHMNCj4gPj4+IHRv
IGNoYW5nZWQuIEFueSBzdWdnZXN0aW9ucyA/DQo+ID4+DQo+ID4+IEp1c3Qga2VlcCB0aGUgZHJp
dmVyIG5hbWUgYXMgaXMsIHRoZXJlIGlzIG5vIHNob3J0YWdlIG9mIGRyaXZlcnMNCj4gPj4gc3Vw
cG9ydGluZyBtb3JlIHRoYW4gb25lIHRoaW5nLi4uDQo+ID4NCj4gPiBZb3UgYXJlIHJpZ2h0IHRo
YXQgYSBsb3Qgb2YgZHJpdmVycyBzdXBwb3J0IG11bHRpcGxlIGZ1bmN0aW9ucy4gQnV0DQo+ID4g
dGhlIHByb2JsZW0gaGVyZSBpcyB0aGF0IHRoZSBjdXJyZW50IG5hbWUgbW1pbyBpcyBvbmx5IGEg
c3Vic2V0IG9mDQo+ID4gd2hhdCB0aGUgdXBkYXRlZCBkcml2ZXIgd2lsbCBoYW5kbGUsIHdoaWNo
IGNhbiBjcmVhdGUgY29uZnVzaW9uLg0KPiANCj4gSSByZWZ1c2UgdGhlIGR1cGxpY2F0aW9uLiBU
aGlzIG5ldyBkcml2ZXIgaXMgZG9pbmcgdGhlIGV4YWN0IHNhbWUgdGhpbmcgKC1pc2gpDQo+IGFz
IHRoZSBvbGQgb25lLiBIYXZpbmcgdGhlIHNhbWUgY29kZSBpbiB0d28gcGxhY2VzIGlzIGp1c3Qg
YSByZWNpcGUgZm9yIGZ1dHVyZQ0KPiBkaXZlcmdlbmNlIHdoZW4gZXZlcnlvbmUgaGF2ZSBmb3Jn
b3R0ZW4gdGhhdCB0aGVyZSBhcmUgdHdvIG5lYXJseQ0KPiBpZGVudGljYWwgZHJpdmVycyB0aGF0
IGJvdGggbmVlZCBwYXRjaGluZy4gU3RhdGluZyB0aGlzIGluIGEgY29tbWVudA0KPiBzb21ld2hl
cmUgaW4gdGhlIGRyaXZlcnMgd2lsbCBub3QgaGVscCBhbGwgdGhhdCBtdWNoIGluIG15IGV4cGVy
aWVuY2UuIFRoZQ0KPiBjb21tZW50IHdpbGwgYmUgbWlzc2luZyBmcm9tIHRoZSBjb250ZXh0IGlu
IHNvbWUgc2VlbWluZ2x5IHRyaXZpYWwgcGF0Y2gsDQo+IGFuZCB0aGVyZSB5b3UgZ28uIFRoZXJl
ICp3aWxsKiBiZSB3ZWVkIGRvd24gdGhlIGxpbmUsIGlmIGR1cGxpY2F0aW9uIGlzDQo+IGFsbG93
ZWQuDQoNCkkgYWdyZWUgdGhhdCB3ZSBzaG91bGQgYXZvaWQgdGhlIGR1cGxpY2F0aW9uLg0KDQo+
IA0KPiBJIGNhbiBhZ3JlZSB0aGF0IG11eC1yZWdtYXAuYyBhbmQgQ09ORklHX01VWF9SRUdNQVAg
d291bGQgaGF2ZQ0KPiBiZWVuIGJldHRlciBuYW1lcywgYnV0IG11eC1tbWlvIGlzIGFscmVhZHkg
dGhlcmUuIFNvIGl0IGlzIHdoYXQgaXQgaXMuIEJ1dCBpZg0KPiB5b3UgY2FuIGNvbnZpbmNlIG1l
IHRoYXQgY2hhbmdpbmcgdGhlIG5hbWUgd2lsbCBub3QgY2F1c2UgYW55IHRyb3VibGUNCj4gYW55
d2hlcmUgZm9yIGFueSBleGlzdGluZyBtdXgtbW1pbyB1c2VycywgSSBzdXBwb3NlIHdlIGNhbiBk
byBhIHJlbmFtZS4NCj4gQnV0IEkgYmV0IHRoZXJlIHdpbGwgYmUgc29tZSBuYXN0eSBjb3JuZXIg
Y2FzZXMgYW5kIG9kZCB1c2UgY2FzZXMsIHNvIHlvdSB3aWxsDQo+IGhhdmUgdG8gcHJlc2VudCBz
dHJvbmcgYXJndW1lbnRzLg0KDQpJIGRvbid0IHRoaW5rIHRoYXQgaXQgaXMgaGFyZCB0byBtYWlu
dGFpbiB0aGUgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIHRoZSByZW5hbWUuICBUaGUgdXBk
YXRlZCBkcml2ZXIgY2FuIGtlZXAgaGFuZGxpbmcgdGhlICJtbWlvLW11eCIgZGV2aWNlIHRyZWUg
Y29tcGF0aWJsZSBzdHJpbmcuICBBbmQgd2UgY2FuIGFsc28gaGF2ZSBNVVhfTU1JTyBzZWxlY3Rz
IHRoZSBuZXcgTVVYX1JFR01BUCBpZiB3ZSB3YW50IHRvIGtlZXAgdGhlIGNvbXBhdGliaWxpdHkg
d2l0aCBvbGQga2VybmVsIGNvbmZpZyBmaWxlLg0KDQo+IA0KPiBKdXN0IHVwZGF0ZSB0aGUgS2Nv
bmZpZyB0byBkb2N1bWVudCB0aGUgZHVhbCBuYXR1cmUgYW5kIHJlbW92ZSB0aGUNCj4gTUZEX1NZ
U0NPTiBkZXBlbmRlbmN5LiBJIHN1cHBvc2UgeW91IGFsc28gbmVlZCB0byBoYW5kbGUgdGhlIHBv
c3NpYmx5DQo+IG1pc3Npbmcgc3lzY29uIGluIHRoZSAuYyBmaWxlLCBkZXRhaWxzLCBkZXRhaWxz
LiBCdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBwZXJoYXBzOg0KPiANCj4gY29uZmlnIE1VWF9NTUlP
DQo+IAl0cmlzdGF0ZSAiTU1JTy9SZWdtYXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBN
dWx0aXBsZXhlciINCj4gCWRlcGVuZHMgb24gT0YgfHwgQ09NUElMRV9URVNUDQo+IAloZWxwDQo+
IAkgIE1NSU8vUmVnbWFwIHJlZ2lzdGVyIGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIg
Y29udHJvbGxlci4NCj4gDQo+IAkgIFRoZSBkcml2ZXIgYnVpbGRzIG11bHRpcGxleGVyIGNvbnRy
b2xsZXJzIGZvciBiaXRmaWVsZHMgaW4gZWl0aGVyDQo+IAkgIGEgc3lzY29uIHJlZ2lzdGVyIG9y
IGEgZHJpdmVyIHJlZ21hcCByZWdpc3Rlci4gRm9yIE4gYml0IHdpZGUNCj4gCSAgYml0ZmllbGRz
LCB0aGVyZSB3aWxsIGJlIDJeTiBwb3NzaWJsZSBtdWx0aXBsZXhlciBzdGF0ZXMuDQo+IA0KPiAJ
ICBUbyBjb21waWxlIHRoZSBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBt
b2R1bGUgd2lsbA0KPiAJICBiZSBjYWxsZWQgbXV4LW1taW8uDQo+IA0KPiBDaGVlcnMsDQo+IFBl
dGVyDQo=
