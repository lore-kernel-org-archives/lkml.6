Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19225C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB972070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="Kf1lPOKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfANRRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:17:43 -0500
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:32112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfANRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPnTmw/gLQBN1RTgzp2gv+w/rR3QegXHRtoJ/0T4MIw=;
 b=Kf1lPOKV8CkvvOdSWy5irPueJ94PKmGMgcZKeFP/NAQrLv6nQ4u6JvQnxupTx6S2c80qrOlAkPYSsOdWEaGqoZPafUTGPJeitRN/KxS/BZTu5TZEaw8ELktlaAMcmGCtnZ3nF7VDpVi5L72wcn2FaLJBok3luChMdGNPo/fRKcQ=
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com (52.134.26.12) by
 VI1PR03MB4046.eurprd03.prod.outlook.com (20.177.55.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Mon, 14 Jan 2019 17:17:36 +0000
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::60d5:fd33:2de5:e03d]) by VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::60d5:fd33:2de5:e03d%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:17:36 +0000
From:   =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Topic: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Index: AQHUq/LqtcLyJaAj20eSsaYGzcRoSKWu/NuAgAAFUYA=
Date:   Mon, 14 Jan 2019 17:17:36 +0000
Message-ID: <8b6b2967-9ca7-b7dc-49c6-1cd5cd77851f@nextfour.com>
References: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
 <CAOMZO5CB_b3QbPQRPEW-0ybU1j1Vg1qah0xZhxynf-5d13-ogg@mail.gmail.com>
In-Reply-To: <CAOMZO5CB_b3QbPQRPEW-0ybU1j1Vg1qah0xZhxynf-5d13-ogg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0040.eurprd09.prod.outlook.com
 (2603:10a6:7:15::29) To VI1PR03MB3775.eurprd03.prod.outlook.com
 (2603:10a6:803:34::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.193.232.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR03MB4046;6:sRGbviUymSYahPOAw98zUQa8RChVjIP1fTUZTmHUhkKPKegrLRCxBuEzYFwuLvMjbVT9xclKhQHQMhRyVUnAWGBpciGSpaC/nxgbh5P/7ABK6mGgc8lNJEzhSAKnOfJel1TBJE4uLYx5votkoTJKQD1kp5xHnRGXWQdzLJ1JWPg7UzFTl54D8hkYQ49YwYyl0QYIwQl9GN6e5e5DUFetUSmXSIjDQxjQjHy37ZL2o3W4S2ijg/c+glu2QWEQ4NGi/EcEBVMUjpbpN9Wb/huBsx1CyFq0IwnfNM0E/sJ5KKvG+gLgPPwC6mkNFGDK7IvMc4OB+87yrXsuOuWIckb3kbS1D85w++qGPbsP51bkkRYtBSlYeWaD29OWYj4L3NZX3kBzuAb91M1M13rrBgFKqNIWYnYyWq4DQUKPLne29p8JNL9CmdpGzedZTxTU9LGWHO5G8jC6giHyy7UESTIgcg==;5:HQEJ9iDmxqN+uEIovYG6IdKf5g3tf/XUJZcXSL7YMUtGeDA9/5mkO86sR3GaJUWosQXzL75Bczul3z669Qjbu/8TdH61pzsiOhc9GlPshY6by3S8c/XuEsThK0+IHkUQ7i/lH00cOzwnS+WLu5TvucoEQVv1u5iZ8Xt8ImQscMrt+GPlNpRbqyIQUMJkysuq7pF9iEfaJgAVzX9fhe2hIg==;7:Gi745Va1A4xbK9ghB/bBnAt7tH6rxTcw6Z5lS6HUVwjOLdRwzyGtR5JHaXDNk2NstwauF8vN/2NokntfjEIGGDN28o3UET/RWjKjY2lHKFDipQ+qzflo6xZyglhKwRZhx9HKRuxzDBh2UaIWjDdRxg==
x-ms-office365-filtering-correlation-id: b7514527-064a-4ee0-5ba1-08d67a442d60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR03MB4046;
x-ms-traffictypediagnostic: VI1PR03MB4046:
x-microsoft-antispam-prvs: <VI1PR03MB404697FCC9BB5EF98F3E777E83800@VI1PR03MB4046.eurprd03.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39830400003)(136003)(396003)(199004)(189003)(53936002)(3846002)(86362001)(508600001)(25786009)(36756003)(6506007)(53546011)(76176011)(4326008)(966005)(6116002)(52116002)(575784001)(1411001)(14454004)(97736004)(6246003)(386003)(6916009)(71200400001)(71190400001)(256004)(39060400002)(6306002)(31696002)(6512007)(6436002)(54906003)(316002)(6486002)(31686004)(486006)(476003)(68736007)(105586002)(106356001)(5660300001)(11346002)(66066001)(229853002)(99286004)(7736002)(85182001)(102836004)(186003)(305945005)(446003)(2616005)(2906002)(8676002)(8936002)(81156014)(26005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR03MB4046;H:VI1PR03MB3775.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Jui2Em2NA21AbWFE9h2lHrRBo0Rnnj3Fr88JBJztzJH4f5aCKVCBMALN9RuF/M+MpDRARaqGXPPISLttFAgeciyiZ4LIQ1JwW+6Zh+pbfH0SHS+FUZbBFxkby3tXaQGCLai+2Lt9p69KhuC5qx1ctFbVrbyTm1+oXOgZrZJKNlW8099zGS344jq5qUoQKxKb31XVqcODoF1nuDWa5ggFh6ZAEQTOebZTCDcgxn3+szO+BBIvyGq+j6QMvpJsiAzdOI9XMM9LGULmzBprDdHNYJD+ll/MrvxI1WYPzISJskQN0lXaLJOht6jcnks1WNQZhXS16NwdtPZqcrXvb1XNRBqfUiH8UdfNiTtmZombsr136wc5ZbySVTw12rCla6aEktyXlG+I/POzrVIR+5mkh4Oxp7OoRNax8G+vrIFP8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFC53BB895A0F14482A81F029CCEFEC5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7514527-064a-4ee0-5ba1-08d67a442d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:17:35.2835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDE0LjEuMjAxOSAxOC41OCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gSGkgTWlr
YSwNCj4NCj4gT24gTW9uLCBKYW4gMTQsIDIwMTkgYXQgODoyMSBBTSBNaWthIFBlbnR0aWzDpA0K
PiA8bWlrYS5wZW50dGlsYUBuZXh0Zm91ci5jb20+IHdyb3RlOg0KPj4gSGVsbG8sDQo+Pg0KPj4N
Cj4+IFRoZSBwYXRjaCB0aXRsZWQgInBpbmN0cmw6IGZzbDogYWRkIHNjdSBiYXNlZCBwaW5jdHJs
IHN1cHBvcnQiIGNhdXNlcw0KPj4gcmVncmVzc2lvbiBvbiBpLk1YNi4gVGVzdGVkIG9uIGEgY3Vz
dG9tIGJvYXJkIGJhc2VkIG9uDQo+PiBpLk1YNlEgYW5kIHNndGw1MDAwIGNvZGVjLCB0aGVyZSBp
cyBubyBzb3VuZCwgIHRlc3RlZCB3aXRoIHNpbXBsZSB3YXYNCj4+IHBsYXlpbmcuDQo+Pg0KPj4g
UmV2ZXJ0aW5nIHRoZSBwYXRjaCBtYWtlcyBhdWRpbyB3b3JrIGFnYWluLg0KPiBXaGljaCBrZXJu
ZWwgdmVyc2lvbiBkbyB5b3UgdXNlPw0KPg0KPiBNb3N0IGxpa2VseSB0aGlzIGhhcyBhbHJlYWR5
IGJlZW4gZml4ZWQgYnkgdGhlIGZvbGxvd2luZyBjb21taXQ6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
ZHJpdmVycy9waW5jdHJsL2ZyZWVzY2FsZS9waW5jdHJsLWlteC5jP2g9djUuMC1yYzImaWQ9NTcx
NjEwNjc4YmYzNDQwMDZhYjRjNDdjNmZkMGE4NDJlOWFjNmExYg0KPg0KPiBQbGVhc2UgbGV0IHVz
IGtub3cgaWYgeW91IHN0aWxsIGhhdmUgaXNzdWVzIHdpdGggc3VjaCBjb21taXQgYXBwbGllZC4N
Cg0KSSBhbSBtZXJnaW5nIG1haW5saW5lIGFuZCB0aGlzIHJlZ3Jlc3Npb24gaXMgcHJlc2VudCBp
biA1LjAtcmMyIHNvIGl0IHNob3VsZCBoYXZlIHRoZSBtZW50aW9uZWQgcGF0Y2ggYXBwbGllZC4N
Cg0KT2J2aW91c2x5IEkgaGFkIHRvIHJldmVydCB0aGVtIGJvdGggKCJwaW5jdHJsOiBpbXg6IGZp
eCBOT19QQURfQ1RMIHNldHRpbmcgZm9yIE1NSU8gcGFkcyINCsKgYW5kICJwaW5jdHJsOiBmc2w6
IGFkZCBzY3UgYmFzZWQgcGluY3RybCBzdXBwb3J0IiksIGFuZCBhZnRlciB0aGF0IGl0IHdvcmtz
LiBJcyB0aGVyZSBzb21ldGhpbmcgbW9yZSBJIGNvdWxkIHRlc3Q/DQoNCg0KLS1NaWthDQoNCg0K
