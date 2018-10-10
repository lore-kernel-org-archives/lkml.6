Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EAAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqcFaKhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A49C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJJKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:02:56 -0400
Received: from mail-he1eur01on0053.outbound.protection.outlook.com ([104.47.0.53]:64236
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeJJKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSGGlQ6JtfyuPm0mx5rL0wZ7Gj/EAh/gCKH6Rsnzt2w=;
 b=LqcFaKhiyZeLqYfIwti9XF2++1nkZjYIjJ6xTphEpHI72SDDUKjSJbi2owOjKcL3WLRr3f2JExspK5wB92Iw86mefoFX5amvBkY1BzMP7vG8ZQFtIrSgQuC1z2yQHdhRt5bPPKlmr0ZyV5hsIJGQTFBuydvXaPE/uB0+EfyZ/w4=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4551.eurprd04.prod.outlook.com (20.176.243.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 02:42:54 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466%3]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 02:42:54 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Esben Haabendal <esben.haabendal@gmail.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFSniAgAAAtKCAAAjOgIARcEYwgAAH+wCAAAESEIAAFBDigAEAo1A=
Date:   Wed, 10 Oct 2018 02:42:54 +0000
Message-ID: <AM6PR04MB435784E00F0C68A310CD281B97E00@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <87tvlv2wo7.fsf@gmail.com>
In-Reply-To: <87tvlv2wo7.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4551;6:ODuTOyAjTJW9TyGb275wzwRSHVwFS9GsewpUHNt8p5tCL9XYPMmiN+oefTkGXfW01DaEcww4tdHYdJvAkuLPXCxCwIs7B3K2HYAnLWGUVG1VlTYmIUqKWw+uwfKT/9oiS0dtJ6iTaEiPPAXVg8pFsar16izzTTpVAo/kGTnb3T4of9rwFbexuNQiPUxYFQqOxBKDPrX6nRfanYdi1EeaZrwSfOjxUczAKmVAdLQbjHU7i1m7gaBfSp+G5L+6SU2xwW0RqczP4Yu0SCioMIS6WCsPu8E5qzRYPgqfF2NEQaofKhp69qRHGW4CfUoH3yZNSAT8uckXV0RkeCGq0FIy7f1EtZUU4iYevgFofsazdrVdN4vRxynM7nRCoM4/QAlVvTdJjqwNLDkw/l5uNb1NVaXAYFwbiLSH40cS3mbBrkWJMnsD3n9/bsrUGI/Piz70o5PMNcuQgtmG3xdJ5Z0CNg==;5:cJ8Y+jwpdDKff72BibBUzgqjIMc/TJ3E88nK+Ck4kTeRJMS53DJlE4XrZyFT91FfeEbqsVmY3I2/ewd+kNsqkABJrwu+yoIxzhBqESkNNVaYWBzVrzZqJHDt2bkqFRjJgFzR9Omlb8tM7u7F5KktW8uMGYpa5PNv7iwfY+79xTI=;7:9JR63llTmNXIkgIOlWkrtC7mInrgMDrjqWTLNozMK2zLWebZYMkA6XasKTK3lg7EWQXE96feTSFlfJHGhYj3G78JEQgKb0G+2MxwCDZlEJ/XwVx+Z1AdJZ/4Ims1CUfvXpI5iSNGpiADlVHNBU1asCtetUci2jeuebzGUoiVCLSH59mg1aUwI2E8ucMXrpYWph61SSB2PoK3hXnmX40KIfkY6fbfXC/WEHAVgFag/9W2a9RAxUFvxxaIATwal0sK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 573c8468-2b7d-4247-e65b-08d62e5a14be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4551;
x-ms-traffictypediagnostic: AM6PR04MB4551:
x-microsoft-antispam-prvs: <AM6PR04MB4551882D7D56748BDF0D81E497E00@AM6PR04MB4551.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(17755550239193)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:AM6PR04MB4551;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4551;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(13464003)(43544003)(189003)(199004)(7696005)(71200400001)(54906003)(97736004)(446003)(11346002)(76176011)(99286004)(53936002)(5250100002)(256004)(102836004)(86362001)(186003)(93886005)(476003)(316002)(26005)(39060400002)(6916009)(5660300001)(2900100001)(4326008)(6116002)(53546011)(6506007)(2906002)(71190400001)(3846002)(25786009)(33656002)(74316002)(7736002)(305945005)(81156014)(81166006)(44832011)(8936002)(55016002)(229853002)(6436002)(14454004)(8676002)(486006)(478600001)(9686003)(66066001)(105586002)(6246003)(106356001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4551;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rW9a8qxpaZ2yGeVBh/nGaLJjONu6LJXp0ifU5ZD16evvKy9z2EneY12EZXDb5s9kaZpgFU+ADf6ijg+hB52q9npOibHpXdioQpyHYsAqXS/jIXa4kAedr762IjESOQW7TbPkhcr9QANpUdEYkdXB/cUFOSqtxySnTaQz1g6C9Wd5Ttz7jEM6XigAIHTmK1RM3Ce0tZB/G5g5qDM8y3P4qfsiSmqjsww/dQYSkGV5Bd6jpRqVhq2vVN6ERlCd4oP3NlWUb+wdzReqez2mTVVvj1TPnc7t2+ZRSlCLz+lKI6MntFDUURKOQzfwqlrUP1kuKm9UnG096/9kSSIPq6bHW+mQiSOLMT/neobDbmxks/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573c8468-2b7d-4247-e65b-08d62e5a14be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 02:42:54.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXNiZW4gSGFhYmVuZGFs
IDxlc2JlbmhhYWJlbmRhbEBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBFc2Jlbg0KPiBIYWFiZW5k
YWwNCj4gU2VudDogMjAxOOW5tDEw5pyIOeaXpSAxOToyMQ0KPiBUbzogQ2h1YW5odWEgSGFuIDxj
aHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGJvb3RsaW4uY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBsaW51eC1zcGlAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSBzcGk6IHNwaS1tZW06IEFkZCB0aGUgc3BpX3NldF94ZmVyX2JwdyBmdW5jdGlv
bg0KPiANCj4gQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQm9yaXMgQnJlemls
bG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+ID4+IFNlbnQ6IDIwMTjlubQxMOac
iDnml6UgMTg6MDUNCj4gPj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+
DQo+ID4+IENjOiBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZl
cl9icHcNCj4gPj4gZnVuY3Rpb24NCj4gPj4NCj4gPj4gT24gVHVlLCA5IE9jdCAyMDE4IDA5OjUy
OjIzICswMDAwDQo+ID4+IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+IHdyb3Rl
Og0KPiA+Pg0KPiA+PiA+IDEuIEluIHRoZSBkc3BpIGRyaXZlciAoc3BpIGNvbnRyb2xsZXIpLCBi
aXRzX3Blcl93b3JkDQo+ID4+ID4gKGRzcGktPmJpdHNfcGVyX3dvcmQgPSB0cmFuc2Zlci0+Yml0
c19wZXJfd29yZCkgcGFzc2VkIGZyb20gdGhlDQo+ID4+ID4gdXBwZXIgbGF5ZXIgKHNwaS1tZW0u
YykgaXMgdXNlZC4gSW4gdGhpcyB3YXksIEkgY2FuIG9ubHkgYXNzaWduIHRoZQ0KPiA+PiA+IGFw
cHJvcHJpYXRlIHZhbHVlIG9mIHRyYW5zZmVyLT5iaXRzX3Blcl93b3JkIGJlZm9yZSBwYXNzaW5n
IHRvIHRoZQ0KPiA+PiA+IGNvbnRyb2xsZXIsIHRoYXQgaXMsIHRoZSBjb250cm9sbGVyIGRyaXZl
ciBkb2VzIG5vdCBrbm93IHRoZSB2YWx1ZQ0KPiA+PiA+IG9mIGJpdHNfcGVyX3dvcmQsIGFuZCBp
dCB3aWxsIHVzZSB0aGlzIHZhbHVlIHdoZW4gdGhlIHVwcGVyIGxldmVsDQo+ID4+ID4gc2V0cyB3
aGF0IHZhbHVlIGlzIHBhc3NlZC4NCj4gPj4NCj4gPj4gSSB0aGluayB5b3UncmUgbWlzc2luZyBt
eSBwb2ludDogLT5iaXRzX3Blcl93b3JkIGlzIG5vdCB3aGF0IHlvdSdyZQ0KPiA+PiBsb29raW5n
IGZvciBpZiB3aGF0IHlvdSdyZSB0cnlpbmcgdG8gZG8gaXMgdXNlIDMyLWJpdHMgYWNjZXNzZXMg
d2hlbg0KPiA+PiB0aGluZ3MgYXJlIHByb3Blcmx5IGFsaWduZWQuDQo+ID4+DQo+ID4gSW4gdGhl
IGRzcGkgZHJpdmVyIChzcGkgY29udHJvbGxlciBkcml2ZXIpLCBpdCBpcyBiYXNlZCBvbiB3aGV0
aGVyDQo+ID4gLT5iaXRzX3Blcl93b3JkIGlzDQo+ID4gbGFyZ2VyIHRoYW4gMTYgdG8gZGVjaWRl
IHdoZXRoZXIgdG8gdXNlIHRoZSBYU1BJIG1vZGUgKDMyYml0KSB0byB0cmFuc2Zlcg0KPiBkYXRh
Lg0KPiANCj4gTm90IGNvbXBsZXRlbHkgdHJ1ZS4gIFhTUEkgbW9kZSBpcyBlbmFibGVkLCBhbHNv
IGZvciB3b3JkcyBzbWFsbGVyIHRoYW4gb3INCj4gZXF1YWwgdG8gMTYgYml0cy4gIEJ1dCBUWCBG
SUZPIGFuZCBDTUQgRklGTyBpcyB3cml0dGVuIHRvZ2V0aGVyLCBqdXN0IGFzIGZvcg0KPiBub24t
WFNQSSBtb2RlLg0KPiANCj4gPiBJZiAtPmJpdHNfcGVyX3dvcmQgaXMgbm90IHNldCBhbmQgdGhl
IGRlZmF1bHQgYml0c19wZXJfd29yZCA9OCBpcw0KPiA+IHBhc3NlZCB0byB0aGUgZHNwaSBkcml2
ZXIsIHRoZSBYU1BJIG1vZGUgKDMyYml0KSBpcyBub3QgdXNlZCBmb3IgZGF0YQ0KPiA+IHRyYW5z
ZmVyIGluIHRoZSBkc3BpIGRyaXZlcg0KPiANCj4gTm90IHRydWUuICBYU1BJIG1vZGUgaXMgdW5j
b25kaXRpb25hbGx5IGVuYWJsZWQgaW4gZHNwaV9pbml0KCkuICBCdXQgWFNQSQ0KPiBtb2RlIGRv
ZXMgbm90IG92ZXJydWxlIHRoZSB2YWx1ZSBvZiB0cmFuc2Zlci0+Yml0c19wZXJfd29yZC4NCj4g
VGhlIG1lYW5pbmcgb2YgWFNQSSBtb2RlIGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAxLiBGcmFt
ZSAod29yZCkgc2l6ZSBpcyBtYXggMzIgYml0cyAod2l0aCBub3JtYWwgU1BJIG1vZGUsIG1heCBp
cyAxNiBiaXRzKS4NCj4gMi4gRm9yIGZyYW1lcyAod29yZHMpIHdpdGggbW9yZSB0aGFuIDE2IGJp
dHMgcGVyIGZyYW1lICh3b3JkKSwgZWFjaCBmcmFtZQ0KPiB0cmFuc2ZlciByZXN1bHRzIGluIDIg
VFggRklGTyBwb3Agb3BlcmF0aW9ucy4NCj4gMy4gQ29tbWFuZCBjeWNsaW5nIGlzIHBvc3NpYmxl
LCBlbmFibGVkIHdoZW4gU1BJX0NUQVJFW0RUQ1BdID4gMS4NCj4gDQo+IENvbW1hbmQgY3ljbGlu
ZyBpcyBjdXJyZW50bHkgbm90IGltcGxlbWVudGVkLiAgSWYgaW1wbGVtZW50ZWQsIGl0IHdvdWxk
IGJlDQo+IHBvc3NpYmxlIHRvIHNlbmQgbXVsdGlwbGUgZnJhbWVzICh3b3JkcykgYnkgd3JpdGlu
ZyBvbmUgdGltZSB0byBDTUQgRklGTyBhbmQNCj4gbXVsdGlwbGUgdGltZXMgdG8gVFggRklGTy4g
IFRoaXMgY291bGQgcG9zc2libHkgaW1wcm92ZSBwZXJmb3JtYW5jZQ0KPiANCj4gQW5vdGhlciBw
b3NzaWJpbGl0eSB3b3VsZCBiZSB0byB1c2UgRU9RIG1vZGUsIGlmIHN1cHBvcnRlZCBieSB0aGUg
RFNQSQ0KPiBjb250cm9sbGVyIGluIHRoZSBDUFUuICBJdCBhbGxvd3MgZm9yIGZpbGxpbmcgVFgg
RklGTywgYW5kIGdldHRpbmcgSVJRIG9ubHkgYWZ0ZXINCj4gbGFzdCBUWCBGSUZPIGVudHJ5IGlz
IHNlbnQuICBUaGlzIGlzIGFsc28gYSBsaWtlbHkgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQuDQo+
IA0KPiA+PiA+IDIuIEFzIEkgdW5kZXJzdGFuZCwgYml0c19wZXJfd29yZCBkb2VzIG5vdCBleGlz
dCBmb3Igbm9uLWJ5dGUNCj4gPj4gPiBhbGlnbm1lbnQsIGJ1dCBmb3IgdGhlIG5lZWQgdG8gcmVz
ZXJ2ZSBub24tYnl0ZSB0cmFuc21pc3Npb24gbW9kZQ0KPiA+PiA+IHRoYXQgbWVldHMgdGhlIGNv
bnRyb2xsZXIuDQo+ID4+DQo+ID4+IEV4YWN0bHkuIEl0J3MgYW4gb3B0aW1pemF0aW9uIHlvdSBo
YXZlIHRvIHRha2UgY2FyZSBvZiBpbnNpZGUgeW91cg0KPiA+PiBkcml2ZXIuIFRoZSBjb3JlIGNh
bm5vdCBoZWxwIHlvdSB3aXRoIHRoYXQuDQo+ID4+DQo+ID4gVGhlIGNvcmUgbGF5ZXIgaXMgdGhl
IHVwcGVyIGxheWVyLiBJZiB5b3UgZG9uJ3Qgc2V0IC0+Yml0c19wZXJfd29yZCwNCj4gPiBiaXRz
X3Blcl93b3JkIHdpbGwgdXNlIHRoZSBkZWZhdWx0IHZhbHVlIG9mIDgsIHNvIHRoYXQgdGhlDQo+
ID4gY29udHJvbGxlcidzIHNwZWNpZmljIG1vZGUgZm9yIHRyYW5zZmVycmluZyBkYXRhIGNhbm5v
dCBiZSB1c2VkIChlZzoNCj4gPiBYU1BJIG1vZGUpLg0KPiANCj4gWFNQSSBtb2RlIGlzIGluZGVw
ZW5kZW50IG9mIGJpdHNfcGVyX3dvcmQuICBJbiBYU1BJIG1vZGUsIHlvdSBjYW4gc2VuZA0KPiBm
cmFtZXMgYXMgc21hbGwgYXMgNCBiaXRzLCBhbmQgdXAgdG8gMzIgYml0cy4gIEluIG5vcm1hbCBT
UEkgbW9kZSwgeW91IGNhbg0KPiBzZW5kIGZyYW1lcyBmcm9tIDQgdG8gMTYgYml0cy4NCj4gDQo+
ID4+ID4gMy4gSW4gYWRkaXRpb24sIG5vdyB0aGUNCj4gPj4gPiBYU1BJIG9mIGRzcGkgY2Fubm90
IHRyYW5zZmVyIGRhdGEgbm9ybWFsbHksIHNvIHRoaXMgcHJvYmxlbSBuZWVkcw0KPiA+PiA+IHRv
IGJlIHNvbHZlZC4NCj4gPj4NCj4gPj4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhl
IHByb2JsZW0gaXMuDQo+ID4+DQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBJIHRlc3RlZCB0aGUg
WFNQSSBtb2RlIGFuZCBjb3VsZCBub3Qgd29yaywgdGhhdA0KPiA+IGlzLCB0aGUgZGF0YSBjb3Vs
ZCBub3QgYmUgdHJhbnNtaXR0ZWQgbm9ybWFsbHkuDQo+IA0KPiBXaGF0IGRvZXMgImNvdWxkIG5v
dCBiZSB0cmFuc21pdHRlZCBub3JtYWxseSIgbWVhbj8NCj4gDQo+IEkgYW0gdXNpbmcgWFNQSSBt
b2RlIG9uIExTMTAyMUEsIHRhbGtpbmcgdG8gYSBsb3Qgb2YgZGlmZmVyZW50IFNQSSBkZXZpY2Vz
Lg0KPiBBbmQgdGhleSBhbGwgd29yaywgYW5kIEkgYmVsaWV2ZSBldmVyeXRoaW5nIGlzIHF1aXRl
ICJub3JtYWwiLg0KPiANClNpbmNlIEkgZG9uJ3QgaGF2ZSB0aGUgYm9hcmQgb2YgTFMxMDIxLCBJ
IGNhbid0IHRlc3QgaXQuIEkgdXNlIG90aGVyIGJvYXJkcyB3aXRoIERTUEkgKHN1Y2ggYXMgTFMx
MDQzLCBMUzIwODgsIGV0Yy4pLCANCmFuZCBJIHRlc3Qgc3AtZmxhc2ggY29ubmVjdGVkIG9uIERT
UEkuIElmIFhTUEkgbW9kZSBpcyB1c2VkIGF0IHRoaXMgdGltZSwgZGF0YSBjYW5ub3QgYmUgdHJh
bnNtaXR0ZWQgbm9ybWFsbHkuDQo+IC9Fc2Jlbg0K
