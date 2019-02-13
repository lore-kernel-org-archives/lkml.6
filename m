Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2484C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE92190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x1SKxOiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfBMKfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:35:40 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:58832
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390178AbfBMKfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU6Op/65Ct8vg7vfdm96jajPs7/C2gqZP2VsfWoqNw8=;
 b=x1SKxOiQ/3DDGQZhl+jPTN57+m7N2mFCJBpmTs2LaYGZMhZWbR1DBJjyqB4naoFQ9wEOt18Z1DEw5YVf+/+eAMN+8uEn1fMa9AyAxBFdbagHPKJThLsN5yjWd2Hb5ByY2V/85T2k41MVM6nXaFFyWwMWrfPeeaYQBl8BChRUe8E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 10:35:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 10:35:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Topic: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Index: AQHUw0mAk7D4InMTwEi38x/B8uOIA6XdT24AgAAaBPCAAAIDUIAAF+4AgAAFjbA=
Date:   Wed, 13 Feb 2019 10:35:32 +0000
Message-ID: <DB3PR0402MB39161A96602CBF6D38514164F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
In-Reply-To: <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e0ebee-2284-4610-c859-08d6919efba1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM4OTc7MjM6UlNlQ2RMUVBwZ09QZGRldFBPTnpta0pu?=
 =?gb2312?B?cnB4WGxhcGMybE5IelU2L1A4VVJCcVNDUmROYmJuQUdUMkFyWURaY3NaR2Yr?=
 =?gb2312?B?bFUrNDhDMCthM0lPSTI1UktrV3RiamVnbmpTWDYzYXB2OS9wZXRUNks4UXhn?=
 =?gb2312?B?M0p3aVpnN3RUOGpUWStKUnFvSE8vQVNBbHYxYzRRaUhCd25LRW5obmhMa1hU?=
 =?gb2312?B?ejFWV01nSmpNZ1VjTXBpM0V5STIwNWJuTE40ZlFsT2xDSkV4c0IrVERzNFdY?=
 =?gb2312?B?V0Jkam9EY3I5QUVrK2dFSVR6UXg1TTdjOVRCdTljWVpXT2dUbzhLWVl1NUk4?=
 =?gb2312?B?dkt6Nkt2dzZrTlJPTWE4WFZvUXhpazJIOVp3a0ZsSU5PVlRJeGdrVUJNWHdh?=
 =?gb2312?B?VHZnQTQwZ29CVFlRUUR3Q0V1MnVvWjlQMjBXaThSb2pNWVBJMzhNWmR1YmxR?=
 =?gb2312?B?RDJjYStTb21oMGtmRGl4YVVzZG91cHlocjIwU2E4T2lvQWR6ejVydDc3dHll?=
 =?gb2312?B?Ui8vT0hxUFVyN0ovR3YwbmRlbVRjc2NNK1pxVG5VTlR2MlBOdnA3cTJNMUc3?=
 =?gb2312?B?Y0ZnUGFBWmtjU1cycWlOaUVKQktLb0NBY1UvUmt6T3c2OXdDRE80MldLTFNM?=
 =?gb2312?B?VnlyZERVWXNaTlBRNjQ1YWVQbjVySm4wU3l0SDJ2TU50dHFMbUhJVTN1QkRI?=
 =?gb2312?B?SUhvanJRaUNrN1BvcjZDNDBBSjhBeXpLZjFVa1h5dzA1aEVpZ3dWeHdiY0xB?=
 =?gb2312?B?WFBsd0J5MWd6dis4WWFlQStlQXNwMXF0SXdNRjNBeDd2Wlc4S1F2akxrcEZN?=
 =?gb2312?B?NFVSUEdhdnltYzR3N1kxQThKemRpSExiNXJxbWtFd0VRMEVIbk5TTXVGT2Ft?=
 =?gb2312?B?NHBCVUV5cmJnOVRFWVNYMnJteUlKZEg3M0Q1NER3QjJYcmswZzB6VFd5UzFQ?=
 =?gb2312?B?ZmE4U2E1YzcvenNrUndzTVA5azJhWk9saVBmbGlKZlFnd3VBUnhkM04vd0hp?=
 =?gb2312?B?Wk9sWGsyeGM2SUdwWG85N2xIcnJoVEVBTVJMRUU0WmxXMWpyaUk5eHh6Q3Jq?=
 =?gb2312?B?a1JtWXRSU1hZMmt6ZnJaTVRlMWkwN0hIYnZJc3NzcWhJRUhmVlptUFFSd1FH?=
 =?gb2312?B?TXlnQmtML1ZYSW9veU4zWTlMcTA4UWZDSThzV1R1TkdHbko4M0ZHY3RsQVM1?=
 =?gb2312?B?ZnEvclVpSnN1T3Q2ZW9NekR6b2FEQXNwdmI1TVM0QTlTaFVUa1lIdVNrZFFu?=
 =?gb2312?B?dFBoRkpmYVFCU1Y3RTlpL01uTHVBSWtTREs4WFpKTElxQVliYSt6bW5KdXlt?=
 =?gb2312?B?bm56VURoQWIzV1VGUjhCeXhWV2l0MzIyZmtvZHowbzFuR1kxajlBSDBHNXp0?=
 =?gb2312?B?czNIOVR4QjN1ZWJ0MDhlalAzeEFYVHpiT0Rjd0FmNGtoS210UDVVak9vQVdm?=
 =?gb2312?B?Tm83OCt0a29WWXJ2YlltZGZOeU40Nm9CbDc0QXlDRkVNbEY5VXRWQzZ3RjlM?=
 =?gb2312?B?RWJPVzNTbTdXWFV4TWNxbGZhVXRuOFhGdnlhZkZHT1drZ2htYUZzUnZlYm1B?=
 =?gb2312?B?b05TRG1ESTA2K2NwOG9idDdxMFF6MkdMSCtjR200KzhXYmtIUHNLVGV0SUQ4?=
 =?gb2312?B?enNTeUpKdG5NVHVPdFRzSXNYVGc2ckpTN1VVaitIVFVqaWYvbEZXN2daS2lB?=
 =?gb2312?B?aWVIbThjZWZNSjRSZUUyRmJxajZHalJxT2N5L09IbTQvNlVhNElXdElCdUxk?=
 =?gb2312?B?cmJub3hCUmxsU1YrSzVaNDFnPT0=?=
x-microsoft-antispam-prvs: <DB3PR0402MB38979C41F2D8D5D9D6A9ECDFF5660@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(13464003)(6246003)(8936002)(81156014)(71190400001)(2906002)(71200400001)(97736004)(55016002)(3846002)(81166006)(9686003)(6116002)(7736002)(106356001)(6916009)(44832011)(186003)(8676002)(105586002)(7416002)(25786009)(7696005)(486006)(33656002)(4326008)(53936002)(76176011)(66066001)(11346002)(14454004)(305945005)(256004)(93886005)(53546011)(86362001)(476003)(26005)(6436002)(478600001)(446003)(74316002)(102836004)(54906003)(68736007)(99286004)(316002)(6506007)(229853002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QgCWeF9KG2vpPXT8hYVkW19rwLpDiaENhBSVZRjyKys3NGFrNX+E5CpRyzz4JgXMUywc9YMr5C2/WTcA6iW1vFbrJdeDi7AJXpLQDhci4WgYM2mJwJw0EkSEmtTe0O54f4VrYjUx6Rs0y/m2xUyXq1bVH9rNeHzQLgKTN8lZ7jDd3inMseGLkx0dDbsSEYYS8lgVlx/AgsIWYE4aFci1Ud7l6xuU/Mk31gNodGsVBYPbW4fSB4W7sZRadnVAQhOyZU0OQfmNYlSuK6T2yQ715mr0M3SwURalLsgIu8061+QsWqcJx6bFqg0suwQScKR14FT7VjWWa+Ed1bj5K45G2YrE5y5vlE9V62RF6nXzurlaZyglHofiW/XhhYxrFL4qIjFLJz9fwZIDwCH9Wa+LRI/hrnzdS6ce7WNKSa1og6Q=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0ebee-2284-4610-c859-08d6919efba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 10:35:33.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5v
cmddDQo+IFNlbnQ6IDIwMTnE6jLUwjEzyNUgMTg6MTUNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNv
bi5odWFuZ0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyByandAcmp3eXNvY2tpLm5ldDsNCj4g
QWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPGRh
bmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47
DQo+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0BzbnRlY2guZGU7IGFybmRAYXJu
ZGIuZGU7DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRp
b25zLmNvbTsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGNwdWZyZXE6
IGlteC1zYzogYWRkIGkubXggc3lzdGVtIGNvbnRyb2xsZXIgY3B1ZnJlcQ0KPiBzdXBwb3J0DQo+
IA0KPiBPbiAxMy0wMi0xOSwgMDg6NTMsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEZvcmdvdCB0
byBtZW50aW9uLCBpLk1YIHN5c3RlbSBjb250cm9sbGVyIGNwdWZyZXEgYWN0dWFsbHkgY2FuIE5P
VCBkbw0KPiA+IGFueSBDUFUgY2xvY2svdm9sdGFnZSBzY2FsaW5nIGZyb20gTGludXgga2VybmVs
LCB0aGV5IGFyZSBjb250cm9sbGVkDQo+ID4gYnkgc3lzdGVtIGNvbnRyb2xsZXIgZmlybXdhcmUg
YW5kIE9OTFkgY2FuIGJlIHJlcXVlc3RlZCB2aWEgUlBDIHdpdGgNCj4gPiBzZWN1cmUgbW9kZSwg
c28gTGludXgga2VybmVsIGhhcyB0byBjYWxsIFNNQyBhbmQgdHJhcCB0bw0KPiA+IEFSTS1UcnVz
dGVkLUZpcm13YXJlIHRvIGRvIGl0LCBpbiB0aGlzIGNhc2UsIGlzIGNwdWZyZXEtZHQgc3RpbGwN
Cj4gPiBzdWl0YWJsZSB0byBzdXBwb3J0IGl0PyBJIHNhdyBjcHVmcmVxLWR0IGRyaXZlciB3aWxs
IGRvIENQVSBjbG9jay92b2x0YWdlDQo+IHNjYWxpbmcgZGlyZWN0bHkuDQo+IA0KPiBXaGF0IGFi
b3V0IG1vdmluZyB0aG9zZSBTTUMgY2FsbHMgdG8gdGhlIGNsay1kcml2ZXIsIHRoZW4gaXQgd291
bGRuJ3QgbWF0dGVyDQo+IHRvIHRoZSBjcHVmcmVxIGRyaXZlciBvbiBob3cgdGhlIGNsb2NrIGlz
IGdldHRpbmcgY2hhbmdlZC4NCg0KT0ssIHRoYW5rcywgSSB3aWxsIGhhdmUgYSB0cnkgYW5kIHJl
c2VuZCB0aGUgcGF0Y2guDQoNCkFuc29uLg0KDQo+IA0KPiAtLQ0KPiB2aXJlc2gNCg==
