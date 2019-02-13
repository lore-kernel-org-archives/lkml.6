Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28458C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF156222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="q16M2HkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfBMQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:34:15 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:53888
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404089AbfBMQeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQxKQEOMowc5il8kU6p0+Zyri9i+tFTzck1eNSyR9f0=;
 b=q16M2HkGKuVWXo20o8llKiUBX3vNbqc5ZPZD446x/8/wf3XovVwYhsP0Hg35xaIPQPWwpQdgbHARBbCNjE6M2fERqdGEI+6tYdVNa3n6o9LjxQMGzva2DZXea8KuMFVOMyZafs2ymmBNwXX1lBk79ujjSCbIB95VsHnDXrdvXwY=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4679.eurprd05.prod.outlook.com (10.168.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 16:33:56 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 16:33:56 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Index: AQHUty7nX2Y1uMtpWUOt6Q3VbGI486XGz4AAgBc0j0A=
Date:   Wed, 13 Feb 2019 16:33:55 +0000
Message-ID: <DB6PR05MB32233A6D87495E66687806C5A1660@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1548696487-8840-1-git-send-email-lsun@mellanox.com>
 <1548696487-8840-2-git-send-email-lsun@mellanox.com>
 <CAHp75VeByqLAr3hakCTSO_M3xjUyt=A0bPgpWeSV62Vomcrsog@mail.gmail.com>
In-Reply-To: <CAHp75VeByqLAr3hakCTSO_M3xjUyt=A0bPgpWeSV62Vomcrsog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4320ff5-1e78-4239-3c3e-08d691d10c70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4679;
x-ms-traffictypediagnostic: DB6PR05MB4679:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjZQUjA1TUI0Njc5OzIzOmVhWHZJemFwbmdtRzc2eHRlbThqNGZMU2JJ?=
 =?utf-8?B?QnNPT0lCK2xSRUZoTm13elhJRDE1Q2hqKzRlVXBudE1sNEFrTmtsT2d1RFAv?=
 =?utf-8?B?TmtKU3BtVVRSdk5tUWtBWlowL2pET0hiTTFzN1JnSTJvV3VuMGU2MW5uaWg4?=
 =?utf-8?B?cXAxMTArQkozUS8zdWx3YVJjNUtkYTFHaU14bGNENUszQnNEdmdUcEJVK2JR?=
 =?utf-8?B?encwRDFxRDdtNmdMVlVoUHJDL28waGtxR25rSzFnRG5BVWZuaEt2WXF6emJj?=
 =?utf-8?B?TFRyc0lOT0g4eld4MkNEaDBjUDdZMjdCVVlNcGJMQXA4Q01UZXRDZ3pXbjl0?=
 =?utf-8?B?QUM4dHpVWVVGR1pVM1RCcTduUThMT2Y0NG0wMkxIRTBGa3paR2FFNnp1ZUVu?=
 =?utf-8?B?Rmt2UHRIYzFUYi9YUFZoaUpZMnZyNDkyMG5XdFd2ajhPUjF0UENvYkd2am80?=
 =?utf-8?B?aTl3M0RQMjlsNGV0dC9wUloyUDFDVDJmak9hSE8zRnMyTldnOTl6dllpeUNF?=
 =?utf-8?B?UUNRMHUwTEk2U2MzbkMreWVLMlVPTWZDVnRuUmFvTmlyK2UwSlRxRkhvcksw?=
 =?utf-8?B?UXpHeEtKRkRwWVljbUh1aWF4MkdmZldrZzc1RkszL3hQVllTbThNYVdob2xV?=
 =?utf-8?B?M0dDVTlCRlFXVW84Z0laS2JYV3FpWkFnRDFGanRlcXJTR3I3ODFleUpZQjkw?=
 =?utf-8?B?YWQvMGd1SGZCaTNrU0RUR1R4SENtOTIvZ0hQZllHQ0pZYnpsa1k0TVhkeUdi?=
 =?utf-8?B?aFBEdFpSdC9QS2VteVdqV2lMQytYUnVhajhTaC9qR3UwbUpPV2p2bk05VE1E?=
 =?utf-8?B?bVZQZGYyeVQ0dmNiS3hCdzZwVXdXQ0lDaVFUZWl5QUgydUkyV0pGOWRCSDc0?=
 =?utf-8?B?b1NXSjZyRHdxMVpWMVpEVE4rV0ZITjUxSzBDeDd5Q3ROSG10bWlHdFhtQ1JW?=
 =?utf-8?B?cW82T3pCM3ZNTmp4WXBBUjI0Y0hpVHQrc0RKd0lPOVlmTEx3SEhJQUorUkhX?=
 =?utf-8?B?TzIranBOZHZsSVhidGFuemVYM292QXZ4cWxQRlEwdEhSdEJUMTZibHZhUnVw?=
 =?utf-8?B?bFArc00rZEVwaUtjRUVjM2hRK290ZENKeVdZV1d0S3NhS3JKZHNCRFpFYXcr?=
 =?utf-8?B?bGdKbDd3RnBtRzA0NEdUN0RRbCtFTDh4TTJidzBQWkQxbEJ1R2lrTURjR2Uz?=
 =?utf-8?B?aWZ0TTl5OThTZFkwYnRkUE9NOTBuY3J0MllSclZFa21wS0pDK0dJSXNpQ25Y?=
 =?utf-8?B?V0U1SzloMkh4N29tODZ1V1pjZTFld1hRM2ZpaVpkelg0NVlFditZZEFHcm1r?=
 =?utf-8?B?ekgreEwzVStLYk5IeTY5QlptcUhNWTIvQXhIa0h2VnNxWTFCejZiakhxN0R5?=
 =?utf-8?B?YmNYVnMyVlJFY2V1ZjVSWGFrNERWSjlOTHFpaXlpRmN0bk9yam1QRDAwNHpi?=
 =?utf-8?B?eXUxMGhzd1RmZktCWjJ6T2ZXbTdnaGNGZlFKZVpLZGtIY09pRUR2VUJzbHdU?=
 =?utf-8?B?VUVzRnorYmtnQUo2QWZkZlpGazFMRjI0dmFpNERSdTFPSUlCVFJMd2RsVGlx?=
 =?utf-8?B?TWJSWDJvcG5qVXNQRHRFRkZVb3BGMXJsMGFPc1IxNFRtb1J3eTRGM0lWZkpW?=
 =?utf-8?B?U1lVMjZrcDBkcEFmdlpGcUl4SDRRWTl0T1o0S1FETFpra3h3dnZHenF5Z3Ji?=
 =?utf-8?B?SSs1R0M4YkR0c1N6RHQ3ZTB1SlZCT2VDdkRFRTZmOSttSnhVT1hjWGFsY1h1?=
 =?utf-8?B?V014TUpxUU04RmxvS2J6Zz09?=
x-microsoft-antispam-prvs: <DB6PR05MB46793AA40A7D9F12B320818EA1660@DB6PR05MB4679.eurprd05.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(13464003)(476003)(14454004)(256004)(66066001)(478600001)(14444005)(68736007)(2906002)(305945005)(3846002)(6346003)(486006)(229853002)(74316002)(446003)(8676002)(7736002)(81156014)(8936002)(81166006)(11346002)(33656002)(6916009)(55016002)(9686003)(86362001)(6116002)(6436002)(7696005)(53546011)(93886005)(71190400001)(97736004)(71200400001)(6246003)(6506007)(102836004)(76176011)(186003)(25786009)(54906003)(4326008)(26005)(316002)(99286004)(53936002)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4679;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eddtnCmGoY22Y04ciJxv7wGKYjVI1UduPLIIcC7dkJNpxXsuuNB1GQChi75YuUGwbdZJ4k1BEnWiyRWqL5ZLbm1ZE1GwyXQqjr0iUnFCTKJvHF+Bam2fhdMqbJkHtrxEOwnrbXGJWLt+Qhw/Z+M0Rni+0HnZfmJf+guyLSpUCLeG4URI4BZCWvFE6p+qFpG3GsSbCWuHbckwr4jg4klJQ9jsVxh+Zhqmjg4Pchb9wkMmjTtFVFPWFHrWsRfkVZUbTI93Xwxst/+X947P3Bst/uLrcH9zuSh46gVeyu9q/Jj/NcZFybRpErwxZjY7mgil5iPCdELMOZpkbMJUsZDriswkSZYhC5uiQBONRivre26/4nXOw9COBMtSDQP82dvCYXd7cD8SZscJo5toS9JqPalbvewCGMhGsyuCi1D6dPo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4320ff5-1e78-4239-3c3e-08d691d10c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:33:56.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHkuIFNvcnJ5IEkgaGFkIGVtYWlsIGlzc3VlIGVhcmxpZXIgdG9kYXkuIE5vdCBz
dXJlIHRoZSByZXBseSB3YXMgc2VudCBvdXQgb3Igbm90LiBTbyBzZW50IGFub3RoZXIgb25lIGp1
c3QgaW4gY2FzZS4uLg0KDQp2OSBvZiB0aGlzIHBhdGNoIGhhcyBiZWVuIHBvc3RlZCB0byBhZGRy
ZXNzIHRoZSAnZGV2bV8nIGNvbW1lbnQuIEl0IGFsc28gaGFzIHRoZSBjb2Rpbmctc3R5bGUgY2hh
bmdlcyBhY2NvcmRpbmcgdG8gdGhlIGNvbW1lbnRzIEkgZ290IGZvciBhbm90aGVyIHBhdGNoLg0K
DQpSZWdhcmRzLA0KTGltaW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBKYW51YXJ5IDI5LCAyMDE5IDU6MDcgUE0NCj4gVG86IExpbWluZyBTdW4gPGxzdW5A
bWVsbGFub3guY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPjsgRGF2aWQgV29vZHMNCj4gPGR3b29kc0BtZWxsYW5veC5jb20+OyBBbmR5IFNoZXZj
aGVua28gPGFuZHlAaW5mcmFkZWFkLm9yZz47IERhcnJlbiBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFk
Lm9yZz47IFZhZGltIFBhc3Rlcm5haw0KPiA8dmFkaW1wQG1lbGxhbm94LmNvbT47IGRldmljZXRy
ZWUgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IFBsYXRmb3JtIERyaXZlciA8cGxh
dGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djggMS8yXSBwbGF0Zm9ybS9tZWxsYW5veDogQWRkIFRtRmlmbyBkcml2ZXIgZm9yIE1lbGxhbm94
IEJsdWVGaWVsZCBTb2MNCj4gDQo+IE9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDc6MjggUE0gTGlt
aW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBjb21taXQg
YWRkcyB0aGUgVG1GaWZvIHBsYXRmb3JtIGRyaXZlciBmb3IgTWVsbGFub3ggQmx1ZUZpZWxkDQo+
ID4gU29jLiBUbUZpZm8gaXMgYSBzaGFyZWQgRklGTyB3aGljaCBlbmFibGVzIGV4dGVybmFsIGhv
c3QgbWFjaGluZQ0KPiA+IHRvIGV4Y2hhbmdlIGRhdGEgd2l0aCB0aGUgU29DIHZpYSBVU0Igb3Ig
UENJZS4gVGhlIGRyaXZlciBpcyBiYXNlZA0KPiA+IG9uIHZpcnRpbyBmcmFtZXdvcmsgYW5kIGhh
cyBjb25zb2xlIGFuZCBuZXR3b3JrIGFjY2VzcyBlbmFibGVkLg0KPiA+DQo+ID4gUmV2aWV3ZWQt
Ynk6IERhdmlkIFdvb2RzIDxkd29vZHNAbWVsbGFub3guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IExpbWluZyBTdW4gPGxzdW5AbWVsbGFub3guY29tPg0KPiANCj4gDQo+IFBsZWFzZSwgZ28gdGhy
b3VnaCB0aGlzIHNlcmllcyB0YWtpbmcgaW50byBhY2NvdW50IHJldmlldyBJIGp1c3QgZGlkDQo+
IGZvciB5b3VyIGFub3RoZXIgcGF0Y2guDQo+IA0KPiBPbiB0b3Agb2YgdGhhdCwgc2VlIHJlY2Vu
dCAoZm9yIGZldyB5ZWFycyBJIHRoaW5rKSBkcml2ZXJzIHdoYXQgbW9kZXJuDQo+IEFQSXMgdGhl
eSBhcmUgdXNpbmcsIGUuZy4gZGV2bV8uDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywN
Cj4gQW5keSBTaGV2Y2hlbmtvDQo=
