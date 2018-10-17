Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B241ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86121527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="QAxxOT3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E86121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeJQWY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:24:27 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:14146
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbeJQWY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1YemgcjUX/6m2xJuxZy9b4/qlGdz++Bsj1DfgW+RS4=;
 b=QAxxOT3+YmqgeLVDJmM5INl285vvmbH1mMuPzLcVe3jwvjVwXpKk0R4THwrEtBLo43uD0v9KuGyHWphSoLHdyLMDEvuC7LXIbdia5jvHjodwYGqUwF6A7NIn0ARouNdpq5gu1HjoQUCRNG+HPLWz6orazulAvbBi6rxaH1e3/0I=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB3583.eurprd05.prod.outlook.com (10.166.198.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 14:28:23 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 14:28:23 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
Thread-Topic: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
Thread-Index: AQHUZT3RvTwR5mXbA0afapHhEfD2LKUjYH2AgAAgVQA=
Date:   Wed, 17 Oct 2018 14:28:22 +0000
Message-ID: <1539786500.6233.58.camel@toradex.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
         <20181016104730.4598-10-marcel@ziswiler.com>
         <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
In-Reply-To: <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB3583;6:U8cdixxKWcvn6Slji456eJSnFVgTVwgS3kba6r8k8XaMt9QJHQ7dmdSawB5pSd3tNtGqXHS2Ck5vZLTJX2+Ap5HevJv/hLQyeQi1AFGCyvXaKsvYxE+jB778m7t5dFSv/Ajn5+H/YCsKpqA6NYZR7tArpOuyVT8TwYT/UCy7RkguQl9jSDgqmlxwdAJCr7TvkmkiVEe2xPUG60PtTDqygxN3HarShuoVCaGqQphezvAt4ZdBNx1bnxdaS3OCAL7fYrQ7inUggnRUchM30mpyN4cv6n4NQaVysrr8mVH+qxDho5Mo/1pizzemh2GbMouCByw1VXdEqr0NOgWLg1UlrqI1DdKrDOsionmnIGY740SD7KY0trahdJ2GCTcNT5BShpTG9x3len0HyvVYEBhWCJt10OZ0iByYpcm4uk2FFkeeB2vZ3JhxyZd/OvIZmW7D0VBngrZwJ8Syr53tSusPRg==;5:1uu7MVRsZa6zho7ZcqZ9K+/0PdRlaD4OLAaR9Wxqht0xZ5f06IDQY28WXxnmsIBnSNZbEO/AfAo4FoFaTEBvvI7X9EbV4gB/gIJPgno54V6LyeL2uOh41qa3SxlNO0mvOHVlEZd+/PMjRGgd7WJKwvQDdhYKqZcmMFmfnFByzaI=;7:GxNKNOFHrRWp3pCZFe8mcgRyGsjCSLOnVcR4D1aH1XpnqPrUjWduSOGWZfaNQDEEWAfVXdukPnRHOKENArXwyH+9lD2pnJP50Wvoc7Ep8OzvwJFBRLvEb0PthOfCgBx2v8YvmPpd7XW623/6zDBs735a1smvnM2j9O2HQoEesD1nyJZKduQbte+BiODWc3PRwGEqsduMeApBHOPQztI6StcPUt4AdJBskim0dWWNwviNuGf+6RxrpLH98wsOnadt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d489a36-f802-41d4-6876-08d6343ccb33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB3583;
x-ms-traffictypediagnostic: VI1PR0501MB3583:
x-microsoft-antispam-prvs: <VI1PR0501MB358302F862E9AF9BBB04EAE9FBFF0@VI1PR0501MB3583.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB3583;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB3583;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(39850400004)(396003)(199004)(189003)(2616005)(36756003)(11346002)(76176011)(6246003)(39060400002)(99286004)(54906003)(110136005)(446003)(97736004)(4326008)(305945005)(25786009)(476003)(7736002)(256004)(103116003)(4001150100001)(6506007)(486006)(2900100001)(5660300001)(316002)(53546011)(5250100002)(14444005)(53936002)(68736007)(8936002)(6436002)(6486002)(2501003)(81166006)(81156014)(8676002)(102836004)(6512007)(3846002)(6116002)(26005)(71190400001)(71200400001)(106356001)(575784001)(86362001)(14454004)(44832011)(7416002)(186003)(478600001)(66066001)(2906002)(2201001)(105586002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB3583;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lhPlPSRvMcGGTfBEyPMc7fdAzMLppWpsXuQjude44G0Ly2sAw/CL8LU63tk+2RKJpllhw/rquB/dgOD/arBut1F/WtT5ZldGb1b0uuZzElFPvRHpyTPnHXMtd8OYemRr9GIPtsoHydm6Sb4u5irHo7B9+0xhab0RnCMG0Q/SixXszcIYYTOFEKIS446fG/agMqWSBLZa1lrRB39kM5g0OOirwoQTxtpLro4ADBDuU1QOjOo/nbier7WbFpA+vZftxhw7ykN4GRTUje94y2Cky0PTYuXeuApc6oAMFzrM2lCZz9KhnqOj6IUMjiZU55O4zSrUt/N5gwkEsYs11DVEPY4vaj3/kEXOZE6gbBs4uwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <17F2C5DC477B0146A97046FCDD769914@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d489a36-f802-41d4-6876-08d6343ccb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 14:28:23.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB3583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTE3IGF0IDEzOjMyICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAxNi8xMC8yMDE4IDExOjQ3LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFy
Y2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gVGhp
cyBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yIGFzIHNlZW4gcG9zdCBjb21taXQgZGFlY2Y0NmVl
MGU1DQo+ID4gKCJBU29DOiBzb2MtY29yZTogdXNlIHNuZF9zb2NfZGFpX2xpbmtfY29tcG9uZW50
IGZvciBwbGF0Zm9ybSIpOg0KPiA+IA0KPiA+IHRlZ3JhLXNuZC1zZ3RsNTAwMCBzb3VuZDogQVNv
QzogQm90aCBwbGF0Zm9ybSBuYW1lL29mX25vZGUgYXJlIHNldA0KPiA+IGZvcg0KPiA+ICBzZ3Rs
NTAwMA0KPiA+IHRlZ3JhLXNuZC1zZ3RsNTAwMCBzb3VuZDogQVNvQzogZmFpbGVkIHRvIGluaXQg
bGluayBzZ3RsNTAwMA0KPiA+IHRlZ3JhLXNuZC1zZ3RsNTAwMCBzb3VuZDogc25kX3NvY19yZWdp
c3Rlcl9jYXJkIGZhaWxlZCAoLTIyKQ0KPiA+IHRlZ3JhLXNuZC1zZ3RsNTAwMDogcHJvYmUgb2Yg
c291bmQgZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFy
Y2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gLS0t
DQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjogTmV3IHBhdGNoDQo+ID4gDQo+ID4gIHNvdW5kL3Nv
Yy90ZWdyYS90ZWdyYV9zZ3RsNTAwMC5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy90ZWdyYS90
ZWdyYV9zZ3RsNTAwMC5jDQo+ID4gYi9zb3VuZC9zb2MvdGVncmEvdGVncmFfc2d0bDUwMDAuYw0K
PiA+IGluZGV4IDkwMTQ1N2RhMjVlYy4uZWI3MDI5MjVjYWMzIDEwMDY0NA0KPiA+IC0tLSBhL3Nv
dW5kL3NvYy90ZWdyYS90ZWdyYV9zZ3RsNTAwMC5jDQo+ID4gKysrIGIvc291bmQvc29jL3RlZ3Jh
L3RlZ3JhX3NndGw1MDAwLmMNCj4gPiBAQCAtMTY4LDYgKzE2OCwxMSBAQCBzdGF0aWMgaW50IHRl
Z3JhX3NndGw1MDAwX2RyaXZlcl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgDQo+ID4gIGVycl9maW5pX3V0aWxzOg0KPiA+ICsJ
aWYgKHRlZ3JhX3NndGw1MDAwX2RhaS5wbGF0Zm9ybSkgew0KPiA+ICsJCWRldm1fa2ZyZWUoJnBk
ZXYtPmRldiwNCj4gPiB0ZWdyYV9zZ3RsNTAwMF9kYWkucGxhdGZvcm0pOw0KPiA+ICsJCXRlZ3Jh
X3NndGw1MDAwX2RhaS5wbGF0Zm9ybSA9IE5VTEw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJdGVn
cmFfYXNvY191dGlsc19maW5pKCZtYWNoaW5lLT51dGlsX2RhdGEpOw0KPiA+ICBlcnJfcHV0X2Nw
dV9vZl9ub2RlOg0KPiA+ICAJb2Zfbm9kZV9wdXQodGVncmFfc2d0bDUwMDBfZGFpLmNwdV9vZl9u
b2RlKTsNCj4gPiANCj4gDQo+IFdoZXJlIGlzIHRoZSBhYm92ZSBhbGxvY2F0ZWQ/DQoNCnNuZF9z
b2NfaW5pdF9wbGF0Zm9ybSgpIGluIHNvdW5kL3NvYy9zb2MtY29yZS5jDQoNCj4gSSBkb24ndCBz
ZWUgaXQgYWxsb2NhdGVkIGluIHRoaXMgZHJpdmVyDQo+IEFGQUlDVC4gSWYgaXQgaXMgbm90IHRo
ZW4gaXQgZG9lcyBub3Qgc2VlbSByaWdodCB0byBmcmVlIHNvbWV0aGluZw0KPiB0aGF0DQo+IHdl
IGhhdmUgbm90IGFsbG9jYXRlZCBpbiB0aGlzIGRyaXZlci4gSSB3b3VsZCBoYXZlIGFzc3VtZWQg
aXQgd2FzDQo+IGFsbG9jYXRlZCBieSBzbmRfc29jX2luaXRfcGxhdGZvcm0oKSBpbiB3aGljaCBj
YXNlIGl0IHNob3VsZCBub3QgYmUNCj4gbmVjZXNzYXJ5IHRvIGZyZWUgYmVjYXVzZSB0aGF0IGZ1
bmN0aW9uIHVzZXMgZGV2bV9remFsbG9jKCkuDQoNClRoYXQgaXMga2luZCBvZiB3aGF0IEkgYXNz
dW1lZCBhcyB3ZWxsLg0KDQo+IFdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/DQoNClRoYXQgaXMgYWN0
dWFsbHkgYSB2ZXJ5IHZlcnkgZ29vZCBxdWVzdGlvbi4gVW5mb3J0dW5hdGVseSwgc2luY2UgYWJv
dmUNCm1lbnRpb25lZCBjb21taXQgd2hpY2ggaXMgcGFydCBvZiB0aGUgYmlnZ2VyIG11bHRpLXBs
YXRmb3JtIChvcg0Kd2hhdGV2ZXIgb25lIG1heSBjYWxsIGl0KSByZXdvcmsgZG9uZSBieSBmb2xr
cyBvbiBDQyB0aGluZ3Mgc3RhcnQNCmZhbGxpbmcgYXBhcnQuDQoNCkkgc2hvdWxkIG1heWJlIHJh
dGhlciBoYXZlIHBocmFzZWQgdGhpcyBvbmUgYXMgYW4gUkZDLg0KDQpTb21lIGZhY3RzIGZyb20g
bXkgaHVtYmxlIGludmVzdGlnYXRpb24gc28gZmFyOg0KDQotIFRoZSBpc3N1ZSBkb2VzIG5vdCBl
eGhpYml0IGl0c2VsZiBvbiBBcGFsaXMvQ29saWJyaSBUMzAgd2hlcmUNCnByb2JhYmx5IHRoZSBv
cmRlciBvZiB0aGluZ3MgYmVpbmcgaW5pdGlhbGlzZWQgaXMgc2xpZ2h0bHkgZGlmZmVyZW50Lg0K
DQotIEJpc2VjdGluZyBwb2ludHMgdG8gdGhlIGFib3ZlIG1lbnRpb25lZCBjb21taXQgYmVpbmcg
dG8gYmxhbWUuDQpIb3dldmVyIHRoZXJlIGlzIG5vIHdheSB0byBqdXN0IHJldmVydCB0aGF0IGNv
bW1pdCBhcyBpdCBpcyBwYXJ0IG9mIHRoZQ0KYmlnZ2VyIG11bHRpLXBsYXRmb3JtIHJld29yay4N
Cg0KLSBTb21laG93IGl0IGhhcyB0byBkbyB3aXRoIHByb2JlIGRlZmVycmFsLiBCYXNpY2FsbHks
IHBsYXRmb3JtIGdldHMNCmFsbG9jYXRlZCBpbiBzbmRfc29jX2luaXRfcGxhdGZvcm0oKSBidXQg
ZHVlIHRvIEdQSU8vSTJDIHdoYXRldmVyIG5vdA0KYmVpbmcgcmVhZHkgdGhlIFNHVEw1MDAwIGNv
ZGVjIGFrYSBkYWlfbGluayBjYW4gbm90IHlldCBiZSBmb3VuZCBhbmQNCnRoZXJlZm9yZSBpdCBw
cm9iZSBkZWZlcnMgYXMgZm9sbG93czoNCg0KWyAgICAyLjE2NjUxN10gdGVncmEzMC1pMnMgNzAz
MDEyMDAuaTJzOiBETUEgY2hhbm5lbHMgc291cmNlZCBmcm9tDQpkZXZpY2UgNzAzMDAwMDAuYWh1
Yg0KWyAgICAyLjE3NjA0M10gdGVncmEtc25kLXNndGw1MDAwIHNvdW5kOiBBU29DOiBDT0RFQyBE
QUkgc2d0bDUwMDAgbm90DQpyZWdpc3RlcmVkDQpbICAgIDIuMTgzMjQxXSB0ZWdyYS1zbmQtc2d0
bDUwMDAgc291bmQ6IHNuZF9zb2NfcmVnaXN0ZXJfY2FyZCBmYWlsZWQNCigtNTE3KQ0KDQotIFNv
bWV3aGVyZSB0aGVyZWFmdGVyIHBsYXRmb3JtIHNlZW1zIHRvIGdldCBzdHVtcGVkIG9udG8gKGUu
Zy4gaXRzDQpuYW1lIHJhdGhlciB0aGFuIGJlaW5nIG51bGwgbm93IGlzIGJvZ3VzLiBVbmZvcnR1
bmF0ZWx5LCBpdCBpcyBub3QganVzdA0KdGhlIG5hbWUgYXMgY2xlYXJpbmcganVzdCB0aGF0IGRp
ZCBub3QgcmVhbGx5IGhlbHAgKHNndGw1MDAwIGNvZGVjIGdldHMNCmluc3RhbnRpYXRlZCBidXQg
dHJ5aW5nIHRvIHBsYXkgYXVkaW8gYWx3YXlzIHJldHVybmVkIC1FSU5WQUwpLg0KDQotIFRoZSBz
ZWNvbmQgdGltZSBhcm91bmQgc25kX3NvY19pbml0X3BsYXRmb3JtKCkgcmUtdXNlcyBwcmV2aW91
c2x5DQphbGxvY2F0ZWQgcGxhdGZvcm0gbm93IGNvcnJ1cHQgdHJpZ2dlcmluZyBhIGNoZWNrIGlu
IHNvYy1jb3JlDQpjb25jZXJuaW5nIHBsYXRmb3JtIG5hbWUgYW5kIG9mX25vZGUgYm90aCBiZWlu
ZyBzZXQgKGFzIG5vdGVkIGluIGFib3ZlDQpjb21taXQgbWVzc2FnZSkuDQoNClNvbWUgcXVlc3Rp
b25zOg0KDQotIEhvdyBleGFjdGx5IGFyZSBkZXZtIGFsbG9jYXRpb25zIHN1cHBvc2VkIHRvIHdv
cmsgY29uY2VybmluZyBwcm9iZQ0KZGVmZXJyYWxzPw0KDQotIERvZXMgb3Igc2hvdWxkIHRoZSBw
bGF0Zm9ybSBnZXQgY2xlYXJlZCBkdXJpbmcgYSBwcm9iZSBkZWZlcnJhbA0KY3ljbGU/DQoNCi0g
SWYgc28sIHdoeSBkb2VzIHRoYXQgbm90IHdvcms/DQoNCi0gT3IgaXMgc29tZSBzcGVjaWFsIGlt
cGxpY2l0IHByb2JlIGRlZmVycmFsIGhhbmRsaW5nIG1pc3NpbmcgaW4gc29jLQ0KY29yZT8NCg0K
SSdtIGhhcHB5IHRvIHRyeSBtb3JlIHRoaW5ncyBhbmQvb3IgcHJvdmlkZSBtb3JlIGRlYnVnZ2lu
ZyBvdXRwdXQgaWYNCm5lZWRlZC4gSnVzdCBsZXQgbWUga25vdy4NCg0KVGhhbmtzIEpvbiENCg0K
PiBDaGVlcnMNCj4gSm9uDQoNCkNoZWVycw0KDQpNYXJjZWw=
