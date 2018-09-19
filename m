Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB129ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A37F2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oRLtR3X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A37F2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeISTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:19:22 -0400
Received: from mail-eopbgr700078.outbound.protection.outlook.com ([40.107.70.78]:21472
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731430AbeISTTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ/AHoNIA9WN3oC4KLVXi1CcF8fFfKsUEreSPdtW2xU=;
 b=oRLtR3X0+iBVPUq9bB5ZzGtfVd3DpVR71K0RMUgYBmTNCnHpi7h6k31fpAhjniWdKTtYY97vB+/jvw2b2hBAaKVJUrVYGCpVvqQ+VmIy+FTywqnqYhpWLOo9wSHH/zU5gt6WZPideEl2tUvJmn5q0LciCHxprlFPNUOurFCINZI=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1900.namprd12.prod.outlook.com (10.175.88.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:41:19 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::891b:95e5:59d9:fcf]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::891b:95e5:59d9:fcf%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:41:19 +0000
From:   Gary R Hook <ghook@amd.com>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] Allow SEV firmware to be chosen based on Family and
 Model
Thread-Topic: [PATCH 2/2] Allow SEV firmware to be chosen based on Family and
 Model
Thread-Index: AQHUTHrpNwaRqYIjh0q+R9eDdc7BZaT3o+mA
Date:   Wed, 19 Sep 2018 13:41:19 +0000
Message-ID: <1ac0bcb0-92fd-ea8c-691f-7b80fff5e251@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <5c58c32c0ce89c35a95e151734f5d43a3ed0dca0.1536959537.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <5c58c32c0ce89c35a95e151734f5d43a3ed0dca0.1536959537.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:300:94::12) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [47.220.174.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1900;20:pMYV5ARxpjtFPFAYrk3OQr/jWyddIq+xJzRcZh+yBFvmXM7Hx7vG6RQ/qtlIq9SQfDQ7YS7L0cOGElbmMsOnydIEZiwISFYOx9hZ8JqEDyZn3BFhRPjeJgo/x9i8fegs52iqjp8KAibZzOQxHDzNcxke/iOMuVEBqo1dMT7X5TGP5JI8j9S6fV6egjsQHr56mOtevOpkZkHGfbJDcyzR8e3dnJglO59QTLGtuJI2VNljYT+YBLwpxfS//+ReTmux
x-ms-office365-filtering-correlation-id: a3968b1a-bc12-4e7f-7142-08d61e359443
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1900;
x-ms-traffictypediagnostic: DM5PR12MB1900:
x-microsoft-antispam-prvs: <DM5PR12MB190011B0E422DF4D1DC8ED78FD1C0@DM5PR12MB1900.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:DM5PR12MB1900;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1900;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(6506007)(106356001)(8676002)(2906002)(2900100001)(229853002)(8936002)(81156014)(305945005)(6436002)(81166006)(25786009)(4326008)(53936002)(7736002)(6512007)(31686004)(36756003)(5660300001)(6246003)(6116002)(68736007)(66066001)(478600001)(3846002)(6486002)(97736004)(105586002)(486006)(256004)(72206003)(5250100002)(2501003)(14454004)(446003)(575784001)(476003)(54906003)(110136005)(2201001)(53546011)(31696002)(26005)(14444005)(316002)(2616005)(386003)(99286004)(76176011)(102836004)(52116002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1900;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TIgThjMRVQMVvVQHFqh4u/RkLP+U5FmGiBFeEkp2WPrLjhBa3cN5lWeNZXt2hYoXnKSQ4JiQJzTrF0MB05QLjJM3wB91MMaCpMrvcrr11THVbNI67Ghgw7OrJv1tHQjWXPyhHSgW1ym1fDXFTx6rRBPeXXtvpNBVsVLC3GaO38XwTmksI3X4+kilygIiDLLGGVVrDCtyD6+BegD78BNSBQOrzkCdLE3WHFhg0s/ubzSF16Q7Rwt8VVjpCbOvxr7sYrKeJDosQd/fxlelU+YU4gqOyMRP01rxvOyHVqEw+bbj/1PKCnl/GT6FgB7Rvd2lMxg0VoWN7ODkA/wy/ImCvSZxq/iDyHONHqRlaEQ4ADU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EC152EDB77D3A43BDE544759DB4093C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3968b1a-bc12-4e7f-7142-08d61e359443
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:41:19.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMTQvMjAxOCAwNTozMiBQTSwgSmFuYWthcmFqYW4gTmF0YXJhamFuIHdyb3RlOg0KPiBE
dXJpbmcgUFNQIGluaXRpYWxpemF0aW9uLCB0aGVyZSBpcyBhbiBhdHRlbXB0IHRvIHVwZGF0ZSB0
aGUgU0VWIGZpcm13YXJlDQo+IGJ5IGxvb2tpbmcgaW4gL2xpYi9maXJtd2FyZS9hbWQvLiBDdXJy
ZW50bHksIHNldi5mdyBpcyB0aGUgZXhwZWN0ZWQgbmFtZQ0KPiBvZiB0aGUgZmlybXdhcmUgYmxv
Yi4NCj4gDQo+IFRoaXMgcGF0Y2ggd2lsbCBhbGxvdyBmb3IgZmlybXdhcmUgZmlsZW5hbWVzIGJh
c2VkIG9uIHRoZSBmYW1pbHkgYW5kDQo+IG1vZGVsIG9mIHRoZSBwcm9jZXNzb3IuDQo+IA0KPiBN
b2RlbCBzcGVjaWZpYyBmaXJtd2FyZSBmaWxlcyBhcmUgZ2l2ZW4gaGlnaGVzdCBwcmlvcml0eS4g
Rm9sbG93ZWQgYnkNCj4gZmlybXdhcmUgZm9yIGEgc3Vic2V0IG9mIG1vZGVscy4gTGFzdGx5LCBm
YWlsaW5nIHRoZSBwcmV2aW91cyB0d28gb3B0aW9ucywNCj4gZmFsbGJhY2sgdG8gbG9va2luZyBm
b3Igc2V2LmZ3Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuYWthcmFqYW4gTmF0YXJhamFuIDxK
YW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNvbT4NCg0KQWNrZWQtYnk6IEdhcnkgUiBIb29rIDxn
YXJ5Lmhvb2tAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRl
di5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5jIGIvZHJpdmVycy9jcnlw
dG8vY2NwL3BzcC1kZXYuYw0KPiBpbmRleCBmNTQxZTYwLi4zYjMzODYzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5jDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2Nj
cC9wc3AtZGV2LmMNCj4gQEAgLTMxLDggKzMxLDkgQEANCj4gICAJCSgocHNwX21hc3Rlci0+YXBp
X21ham9yKSA+PSBfbWFqICYmCVwNCj4gICAJCSAocHNwX21hc3Rlci0+YXBpX21pbm9yKSA+PSBf
bWluKQ0KPiAgIA0KPiAtI2RlZmluZSBERVZJQ0VfTkFNRQkic2V2Ig0KPiAtI2RlZmluZSBTRVZf
RldfRklMRQkiYW1kL3Nldi5mdyINCj4gKyNkZWZpbmUgREVWSUNFX05BTUUJCSJzZXYiDQo+ICsj
ZGVmaW5lIFNFVl9GV19GSUxFCQkiYW1kL3Nldi5mdyINCj4gKyNkZWZpbmUgU0VWX0ZXX05BTUVf
U0laRQk2NA0KPiAgIA0KPiAgIHN0YXRpYyBERUZJTkVfTVVURVgoc2V2X2NtZF9tdXRleCk7DQo+
ICAgc3RhdGljIHN0cnVjdCBzZXZfbWlzY19kZXYgKm1pc2NfZGV2Ow0KPiBAQCAtNDQwLDYgKzQ0
MSw0MCBAQCBzdGF0aWMgaW50IHNldl9nZXRfYXBpX3ZlcnNpb24odm9pZCkNCj4gICAJcmV0dXJu
IDA7DQo+ICAgfQ0KPiAgIA0KPiAraW50IHNldl9nZXRfZmlybXdhcmUoc3RydWN0IGRldmljZSAq
ZGV2LCBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKipmaXJtd2FyZSkNCj4gK3sNCj4gKwljaGFyIGZ3
X25hbWVfc3BlY2lmaWNbU0VWX0ZXX05BTUVfU0laRV07DQo+ICsJY2hhciBmd19uYW1lX3N1YnNl
dFtTRVZfRldfTkFNRV9TSVpFXTsNCj4gKw0KPiArCXNucHJpbnRmKGZ3X25hbWVfc3BlY2lmaWMs
IHNpemVvZihmd19uYW1lX3NwZWNpZmljKSwNCj4gKwkJICJhbWQvYW1kX3Nldl9mYW0lLjJ4aF9t
b2RlbCUuMnhoLnNiaW4iLA0KPiArCQkgYm9vdF9jcHVfZGF0YS54ODYsIGJvb3RfY3B1X2RhdGEu
eDg2X21vZGVsKTsNCj4gKw0KPiArCXNucHJpbnRmKGZ3X25hbWVfc3Vic2V0LCBzaXplb2YoZndf
bmFtZV9zdWJzZXQpLA0KPiArCQkgImFtZC9hbWRfc2V2X2ZhbSUuMnhoX21vZGVsJS4xeHhoLnNi
aW4iLA0KPiArCQkgYm9vdF9jcHVfZGF0YS54ODYsIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCAm
IDB4ZjApID4+IDQpOw0KPiArDQo+ICsJLyogQ2hlY2sgZm9yIFNFViBGVyBmb3IgYSBwYXJ0aWN1
bGFyIG1vZGVsLg0KPiArCSAqIEV4LiBhbWRfc2V2X2ZhbTE3aF9tb2RlbDAwaC5zYmluIGZvciBG
YW1pbHkgMTdoIE1vZGVsIDAwaA0KPiArCSAqDQo+ICsJICogb3INCj4gKwkgKg0KPiArCSAqIENo
ZWNrIGZvciBTRVYgRlcgY29tbW9uIHRvIGEgc3Vic2V0IG9mIG1vZGVscy4NCj4gKwkgKiBFeC4g
YW1kX3Nldl9mYW0xN2hfbW9kZWwweGguc2JpbiBmb3INCj4gKwkgKiAgICAgRmFtaWx5IDE3aCBN
b2RlbCAwMGggLS0gRmFtaWx5IDE3aCBNb2RlbCAwRmgNCj4gKwkgKg0KPiArCSAqIG9yDQo+ICsJ
ICoNCj4gKwkgKiBGYWxsLWJhY2sgdG8gdXNpbmcgZ2VuZXJpYyBuYW1lOiBzZXYuZncNCj4gKwkg
Ki8NCj4gKwlpZiAoKGZpcm13YXJlX3JlcXVlc3Rfbm93YXJuKGZpcm13YXJlLCBmd19uYW1lX3Nw
ZWNpZmljLCBkZXYpID49IDApIHx8DQo+ICsJICAgIChmaXJtd2FyZV9yZXF1ZXN0X25vd2Fybihm
aXJtd2FyZSwgZndfbmFtZV9zdWJzZXQsIGRldikgPj0gMCkgfHwNCj4gKwkgICAgKGZpcm13YXJl
X3JlcXVlc3Rfbm93YXJuKGZpcm13YXJlLCBTRVZfRldfRklMRSwgZGV2KSA+PSAwKSkNCj4gKwkJ
cmV0dXJuIDA7DQo+ICsNCj4gKwlyZXR1cm4gLUVOT0VOVDsNCj4gK30NCj4gKw0KPiAgIC8qIERv
bid0IGZhaWwgaWYgU0VWIEZXIGNvdWxkbid0IGJlIHVwZGF0ZWQuIENvbnRpbnVlIHdpdGggZXhp
c3RpbmcgU0VWIEZXICovDQo+ICAgc3RhdGljIGludCBzZXZfdXBkYXRlX2Zpcm13YXJlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gICB7DQo+IEBAIC00NDksOSArNDg0LDEwIEBAIHN0YXRpYyBpbnQg
c2V2X3VwZGF0ZV9maXJtd2FyZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCXN0cnVjdCBwYWdl
ICpwOw0KPiAgIAl1NjQgZGF0YV9zaXplOw0KPiAgIA0KPiAtCXJldCA9IHJlcXVlc3RfZmlybXdh
cmUoJmZpcm13YXJlLCBTRVZfRldfRklMRSwgZGV2KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gKwlp
ZiAoc2V2X2dldF9maXJtd2FyZShkZXYsICZmaXJtd2FyZSkgPT0gLUVOT0VOVCkgew0KPiArCQlk
ZXZfZGJnKGRldiwgIk5vIFNFViBmaXJtd2FyZSBmaWxlIHByZXNlbnRcbiIpOw0KPiAgIAkJcmV0
dXJuIC0xOw0KPiArCX0NCj4gICANCj4gICAJLyoNCj4gICAJICogU0VWIEZXIGV4cGVjdHMgdGhl
IHBoeXNpY2FsIGFkZHJlc3MgZ2l2ZW4gdG8gaXQgdG8gYmUgMzINCj4gDQoNCg==
