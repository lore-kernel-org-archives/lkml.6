Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AAD20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cuq+MhXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfARI3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:29:08 -0500
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:24512
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfARI3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKLsyj4y2/W6fsFXaX4l7Ey8WF1Rd8T+guKTps8Lw1I=;
 b=Cuq+MhXqA44/SJ724pRqZGULKQDc0qBXU55OyyWykUTOyQmxH+LT09zQBgBJ9ZQ5oWdTbj90UVd64jIGm67yNum4HkSZkXpWqYNvUFzGoE8r1kszf1P+uTuAFEw/smAm5R0udPH1Mr957TtyWySB5eRQWbp3GxlNi5oA/1fpPcY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4993.eurprd04.prod.outlook.com (20.177.40.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.20; Fri, 18 Jan 2019 08:29:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 08:29:03 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Topic: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Index: AQHUq/LoUZ45TE6n/EyTL/waEgdjDKWu/NuAgAAFVQCABbSaMA==
Date:   Fri, 18 Jan 2019 08:29:03 +0000
Message-ID: <AM0PR04MB421101FB2B51B7AEE3855CBF809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
 <CAOMZO5CB_b3QbPQRPEW-0ybU1j1Vg1qah0xZhxynf-5d13-ogg@mail.gmail.com>
 <8b6b2967-9ca7-b7dc-49c6-1cd5cd77851f@nextfour.com>
In-Reply-To: <8b6b2967-9ca7-b7dc-49c6-1cd5cd77851f@nextfour.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4993;6:emGOJn9E8RzBqLM4qmAkx6VZvAoh40zk/GuNAM/V2Dl6CjuZ26Q4PEnwFu539qyDvLddSiTJLBjKV4A7NL4BFq6rPMBXgvl3MLl4NWMQWn9pVBacgltKwHotab+YHT33vX1rzcw1RMw15+9U6HRWgFpEehxk9CH1oYizmQvb9lidvHCjW+JGYV+CYiiQk7FUXbc/qALHf3ZeNUftUrXuA9m4nYpJQaTF3Vt+Kh9hyMjTnQfyalGiVrESC3CHw5TXCaLc483KBldDipWJ/1bLnUDUgDk0/0ixUqcBPxMGUO5/bw9LA+PGD6gdQYnq06Wuc9OvpOpUkZGG/pmZdLRRmQ99D3MmE7DN1+pMfncLT63NdRzkAFPHkQevye9gOrtdPld/sxJBgoZrTaDgKXlojRADJL9SenuvcGA+Vk4ZelAX03Ufis78LFyKvgqC0TwCDNScJ5qbalvcDmplJiImAw==;5:401jkOX+NZGnahmSX5VLA4rooq3WJoyzT/4mrVUlqKc9A3sDxndNh8lo1nhAOIWMlsWoBFPgt2dV6m7mbRT1gZnzYiR6InRRwNM+Ig1EAYbqMc1wpIcvSRTLuSmART23wTX4uxHU8ljAL5tDnhLeCsArj5eCmeBkjGtN+af6C8yFvuESBUDUNKOCSJmbLTq9rZlF5BFIwy5RsO769BaQWA==;7:33Mz66a3egvuJXqzmVPGOowFMBk4kJD+8oipm4apb1iI021c3Kks8sm66EuVGEO9iLxVJNgy7imb5gh3cvt9rHDiIu6RC+5my6IjIHgE+1UeF5ifufkC78foUzrWrYrzGBAZDE/tzCkfT3xvYJdIpw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a94e88df-672e-4761-f38c-08d67d1f012a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4993;
x-ms-traffictypediagnostic: AM0PR04MB4993:
x-microsoft-antispam-prvs: <AM0PR04MB4993704D3A6F56E818B9F50C809C0@AM0PR04MB4993.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(13464003)(74316002)(76176011)(229853002)(53546011)(7696005)(99286004)(26005)(66066001)(97736004)(102836004)(6246003)(39060400002)(25786009)(6506007)(186003)(106356001)(105586002)(9686003)(256004)(86362001)(81166006)(316002)(55016002)(8936002)(33656002)(446003)(54906003)(476003)(71190400001)(6436002)(4326008)(53936002)(486006)(14454004)(11346002)(7736002)(5660300001)(2906002)(68736007)(110136005)(44832011)(14444005)(6116002)(8676002)(478600001)(71200400001)(305945005)(81156014)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4993;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G5NGcMG/Rp1CEY/eFq8Yf5TwQ1nQJlPphhohuntbgL22YWOfYyvAzUBY62iHj6Qod83qWGp+RJSfXImuHUm0UYs8goHDYxMmoZhqzsAOKT381EJo4vWLcLqGKHTc1c+PPbejRP9YQS4+J197BcgU/Zh7wQS/yBcQIQZ1jf/LLJKLYkB7LX3hNE72fHgSBjDKb1D/5FbvU7/+i2Z5B2M1I0a+Tt8i6hxd20pSzHmw5i3rPEGuUUuE6bvgGX9a56i2o0aBJICEBQPTaopH6/cu+FMQPpYTR/fWfFwigKmT107LW6E7cbDs+wy0YBCioChIu/wkdsOjrLyK3mTiibgLjHolvmrfRu0ANCG2LMVK79IgOBKz4/ZPLVjXa6NAcY9dQIi14lWGX7LqMgsqdalebniOSDB4haEs+DDl8sSzhVc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94e88df-672e-4761-f38c-08d67d1f012a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 08:29:03.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWthIFBlbnR0aWzDpCBbbWFp
bHRvOm1pa2EucGVudHRpbGFAbmV4dGZvdXIuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDE1LCAyMDE5IDE6MTggQU0NCj4gDQo+IEhpIQ0KPiANCj4gT24gMTQuMS4yMDE5IDE4LjU4LCBG
YWJpbyBFc3RldmFtIHdyb3RlOg0KPiA+IEhpIE1pa2EsDQo+ID4NCj4gPiBPbiBNb24sIEphbiAx
NCwgMjAxOSBhdCA4OjIxIEFNIE1pa2EgUGVudHRpbMOkDQo+ID4gPG1pa2EucGVudHRpbGFAbmV4
dGZvdXIuY29tPiB3cm90ZToNCj4gPj4gSGVsbG8sDQo+ID4+DQo+ID4+DQo+ID4+IFRoZSBwYXRj
aCB0aXRsZWQgInBpbmN0cmw6IGZzbDogYWRkIHNjdSBiYXNlZCBwaW5jdHJsIHN1cHBvcnQiIGNh
dXNlcw0KPiA+PiByZWdyZXNzaW9uIG9uIGkuTVg2LiBUZXN0ZWQgb24gYSBjdXN0b20gYm9hcmQg
YmFzZWQgb24gaS5NWDZRIGFuZA0KPiA+PiBzZ3RsNTAwMCBjb2RlYywgdGhlcmUgaXMgbm8gc291
bmQsICB0ZXN0ZWQgd2l0aCBzaW1wbGUgd2F2IHBsYXlpbmcuDQo+ID4+DQo+ID4+IFJldmVydGlu
ZyB0aGUgcGF0Y2ggbWFrZXMgYXVkaW8gd29yayBhZ2Fpbi4NCj4gPiBXaGljaCBrZXJuZWwgdmVy
c2lvbiBkbyB5b3UgdXNlPw0KPiA+DQoNClsuLi5dDQoNCj4gPiBQbGVhc2UgbGV0IHVzIGtub3cg
aWYgeW91IHN0aWxsIGhhdmUgaXNzdWVzIHdpdGggc3VjaCBjb21taXQgYXBwbGllZC4NCj4gDQo+
IEkgYW0gbWVyZ2luZyBtYWlubGluZSBhbmQgdGhpcyByZWdyZXNzaW9uIGlzIHByZXNlbnQgaW4g
NS4wLXJjMiBzbyBpdCBzaG91bGQNCj4gaGF2ZSB0aGUgbWVudGlvbmVkIHBhdGNoIGFwcGxpZWQu
DQo+IA0KPiBPYnZpb3VzbHkgSSBoYWQgdG8gcmV2ZXJ0IHRoZW0gYm90aCAoInBpbmN0cmw6IGlt
eDogZml4IE5PX1BBRF9DVEwgc2V0dGluZyBmb3INCj4gTU1JTyBwYWRzIg0KPiDCoGFuZCAicGlu
Y3RybDogZnNsOiBhZGQgc2N1IGJhc2VkIHBpbmN0cmwgc3VwcG9ydCIpLCBhbmQgYWZ0ZXIgdGhh
dCBpdCB3b3Jrcy4gSXMNCj4gdGhlcmUgc29tZXRoaW5nIG1vcmUgSSBjb3VsZCB0ZXN0Pw0KPiAN
Cg0KQW55IHN0YXR1cyB1cGRhdGU/DQoNCkNhbiB5b3UgcGxlYXNlIHRyeSBlbmFibGUgQ09ORklH
X0RFQlVHX1BJTkNUUkwgd2hpY2ggY2FuIGhlbHAgeW91IGxvY2F0ZQ0KdGhlIHJvb3QgY2F1c2U/
DQpEb24ndCBmb3JnZXQgdG8gYWRkICJERUJVRyIgaW4ga2VybmVsIGJvb3QgcGFyYW0uIE9yIHlv
dSBjYW4gdXNlIGRtZXNnLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiANCj4gLS1NaWth
DQo+IA0KDQo=
