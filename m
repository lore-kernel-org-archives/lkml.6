Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC4ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA0021470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GRX/w9aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA0021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeJRFal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:30:41 -0400
Received: from mail-ve1eur01on0094.outbound.protection.outlook.com ([104.47.1.94]:28688
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbeJRFal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2dgPcEEnB/KzidybN6WgiPq0Jg+9LezpgO9D/W0+tw=;
 b=GRX/w9aJpq+xMqwRi8egzDKJ9XT0r50D9JUIfnh+WP1pMuUcn9tKzeSLrTJh7fhDsvRhPcB/Sw7kCsbFY15vqj4fQyJdutGg97hccArppCY/1HOmy312ns7VNpRBYGK8tqj6nhCyDIlWjaYkhdxutH5gwfu9HX4UWnX7jhTeJPg=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2605.eurprd05.prod.outlook.com (10.168.137.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 17 Oct 2018 21:33:01 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 21:33:01 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
Thread-Topic: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
Thread-Index: AQHUZT3RvTwR5mXbA0afapHhEfD2LKUjYH2AgAAgVQCAAFCGgIAAJh4A
Date:   Wed, 17 Oct 2018 21:33:00 +0000
Message-ID: <1539811978.6233.63.camel@toradex.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
         <20181016104730.4598-10-marcel@ziswiler.com>
         <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
         <1539786500.6233.58.camel@toradex.com>
         <20181017191633.GL24097@sirena.org.uk>
In-Reply-To: <20181017191633.GL24097@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2605;6:hm180A7gMrRx1Sx5IZEjY7hZ0CeFC/9jN1zrNMDxNKw/WrWQF/O3CaYlX9hHOj8LAuSYR5rxl+b6h6+Qb95n3hvjHEiGSeYrHaCLFRWzkXoAuT0lzJyHvSGm+RQNRjOKrL0SLN+vzQd5wrlgSB1lRDBVEYUr0bH8LMB1ygOkMYbSIesOJIG1ajZ2S0BC/iS7ZrRQm96dhuyQtVv6wCvRBYDuf2WILrE0FUYm+fdaimlw9GDORsqXZ8tE+yK7x60Clbao8EaXBbfjYeOkY9PTAf4XHUKfqA1ZP0X2lombU/IXNyWB4UF9NGKErMAr54PBpc91DzqG8LjsODEYqTsM5cyEL63vnGHfmmWFUHVGpq5qi8yoIqXN4n/r3wlCjGygf+NRwUzOBxe8Ry+4ZlHrOpRifmdnkOmPlQ0B6RGyfruAxJqJTvDG0oOLLPogAWGq+MnBRYz4X45bnNtCxYIQ4Q==;5:oE9YQvNV8yfuCriqCfhmDt7bP3hjJKSBfDII6qeOFyTknWCeacP2QLD7apSNcKPqFfuylE/SEYwd71BnHoRMEAp4WhGmEC5TRCqapyDGfK5w48ruDzHdHjdPnt1sQBFaC1SLvau/7PqphmolEF+omZt/jaKmeWM0dmIEfrsc66g=;7:vKTBPQrkZbKL0/DOlUIIyoqddNHYQWGb6OvjkqZcu6Px3PIiRyFwBI1MZwGG2TxitIRJh2Lel4/kBBdrKOqcRYouYh5tfveKF5HM2RBEV9WddZXdoJasueEiWT5oItQA8x4ArHqvxGzrgSjQRgZSXZWb0/bx7dypvY8Iw8CtQGxMTc5wrqzT2DRMzt51IOw/5+yv3T6D30O2peND4rhXbMbSD76z4nLh9c+n/4kCiSsAdcHAE0MlfGTd7kl+qOjD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 41f2de4c-0ef6-4240-b44e-08d634781d36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2605;
x-ms-traffictypediagnostic: VI1PR0501MB2605:
x-microsoft-antispam-prvs: <VI1PR0501MB2605654EC3307172F6BA2DAFFBFF0@VI1PR0501MB2605.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2605;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2605;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(366004)(136003)(346002)(189003)(199004)(5250100002)(2501003)(14454004)(186003)(5660300001)(6246003)(39060400002)(6512007)(2900100001)(97736004)(4001150100001)(478600001)(106356001)(53936002)(4326008)(25786009)(68736007)(86362001)(446003)(6506007)(26005)(102836004)(105586002)(36756003)(476003)(11346002)(71190400001)(71200400001)(2616005)(8936002)(486006)(305945005)(54906003)(256004)(81156014)(66066001)(76176011)(3846002)(7736002)(316002)(8676002)(1730700003)(5640700003)(6436002)(2906002)(229853002)(6116002)(2351001)(44832011)(93886005)(6916009)(7416002)(81166006)(103116003)(6486002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2605;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lcJ3lm18IiyckgbJ1uPmXn6T0HMliPHJ4l4LULyt/uCqFgFB3MNg2AJQF8Jo0xqTiBvD3dt0J2/UobHVP6nyGaLoUPThs7QB7ospn/VNHrVyAUM1IP1uMbviCPggdUH3n9OVIbwej2OHUbXKAoDCSY/gjczn6pD1SrvNI2tuYleiZmIZb6S8ID1G39p6pP+YmLc94SavKf3I6HIJ1Xx360APmGDG85i4HP5EY3N8B6i03nTLazVRN5b3KN3Rx2fLxZOu44qKTi/Sp9z2f25TYs4Y+uYF55xk8vOxvSb6vkZxJXAt5tx3F6JH8MZnjeY1U1/YpKMphS3ta6K6h3687oelsWInGXDaN4nlzPBZJ8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06250A4EB448944599C40A443B9B117D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2de4c-0ef6-4240-b44e-08d634781d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 21:33:00.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTE3IGF0IDIwOjE2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIE9jdCAxNywgMjAxOCBhdCAwMjoyODoyMlBNICswMDAwLCBNYXJjZWwgWmlzd2lsZXIg
d3JvdGU6DQo+IA0KPiA+IFNvbWUgcXVlc3Rpb25zOg0KPiA+IC0gSG93IGV4YWN0bHkgYXJlIGRl
dm0gYWxsb2NhdGlvbnMgc3VwcG9zZWQgdG8gd29yayBjb25jZXJuaW5nDQo+ID4gcHJvYmUNCj4g
PiBkZWZlcnJhbHM/DQo+IA0KPiBQcm9iZSBkZWZlcnJhbHMgYXJlIGp1c3Qgbm9ybWFsIHByb2Jl
IGVycm9ycywgYW55IGRldm1fIGFsbG9jYXRlZA0KPiBzdHVmZg0KPiBnZXRzIHVud291bmQuDQoN
Ck9LLCB0aGF0IGlzIHdoZXJlIG15IHVuZGVyc3RhbmRpbmcgd2FzIHdlYXJ5LiBTbyB5b3UgYXJl
IHNheWluZw0KYW55dGhpbmcgc2hvdWxkIHJlYWxseSBnZXQgYWxsb2NhdGVkIGFnYWluIHVwb24g
dGhlIHNlY29uZCB0aW1lLg0KDQo+ID4gLSBEb2VzIG9yIHNob3VsZCB0aGUgcGxhdGZvcm0gZ2V0
IGNsZWFyZWQgZHVyaW5nIGEgcHJvYmUgZGVmZXJyYWwNCj4gPiBjeWNsZT8NCj4gPiAtIElmIHNv
LCB3aHkgZG9lcyB0aGF0IG5vdCB3b3JrPw0KPiANCj4gSXMgc29tZXRoaW5nIHdyaXRpbmcgdG8g
c3RhdGljIGRhdGEgd2hlbiBpdCBzaG91bGQgYmUgd3JpdGluZyB0bw0KPiBkeW5hbWljYWxseSBh
bGxvY2F0ZWQgZGF0YT8gIFRoYXQncyB3aGF0IHRoaXMgc291bmRzIGxpa2UsIHdlDQo+IHNob3Vs
ZG4ndA0KPiBiZSBtb2RpZnlpbmcgYW55IHN0YXRpYyBkYXRhIGFuZCBhbnkgZGF0YSBkeW5hbWlj
YWxseSBhbGxvY2F0ZWQNCj4gZHVyaW5nDQo+IHByb2JlIG91Z2h0IHRvIGJlIGJlaW5nIGRpc2Nh
cmRlZC4NCg0KT0ssIEkgYmVsaWV2ZSBJIHN0YXJ0IHRvIHNlZSB3aGF0IHlvdSBhcmUgc2F5aW5n
LiBJIGd1ZXNzIHRoZSBidWcgbGF5cw0KaW4gc29jLWNvcmUgdGhlbiBub3QgcHJvcGVybHkgZGlz
Y2FyZGluZyB0aGUgcGxhdGZvcm0gYW5kIHRoZSBzZWNvbmQNCnRpbWUgYXJvdW5kIGl0IGlzIHVz
aW5nIGEgc3RhbGUgcG9pbnRlciB0byB0aGF0IHdoaWNoIG5vdyBvZiBjb3Vyc2UNCnBvaW50cyB0
byB3aGF0ZXZlciBoYXBwZW5zIHRvIGJlIHRoZXJlISBMZXQgbWUgdHJ5IGEgZmV3IG1vcmUgdGhp
bmdzDQphbmQgSSB3aWxsIGNvb2sgdXAgYSBwcm9wZXIgcGF0Y2ggdG8gZml4IHRoYXQuLi4NCg0K
PiA+IC0gT3IgaXMgc29tZSBzcGVjaWFsIGltcGxpY2l0IHByb2JlIGRlZmVycmFsIGhhbmRsaW5n
IG1pc3NpbmcgaW4NCj4gPiBzb2MtDQo+ID4gY29yZT8NCj4gDQo+IExpa2UgSSBzYXkgYSBwcm9i
ZSBkZWZlcnJhbCBpcyBqdXN0IGEgbm9ybWFsIGVycm9yLg0KDQpZZWFoLCByaWdodC4gVGhhbmtz
IQ==
