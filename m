Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313B22150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FrlrS4xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313B22150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeISTHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:07:31 -0400
Received: from mail-eopbgr730054.outbound.protection.outlook.com ([40.107.73.54]:64432
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731330AbeISTHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjlSxj37HaiCz3znz4KbH/0ix5yXa8+A+5oA64QQKPE=;
 b=FrlrS4xm+DrXRGyL9/GpoiPaLR4BAQUWNhYE6RhhRNMNinpPavmF7jDite0rUYIq++fIQw4DimuzN63Jq5ov6gn+/TvQGnRjRaZrhUO4uXXX3poNIpE5Bfp4l//CHKd1V7b2MKfINfKoe6mM16EcJApJTyD2lEIzxadYPX7Yobc=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0607.namprd12.prod.outlook.com (10.163.208.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 13:29:30 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:29:30 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] Allow SEV firmware to be chosen based on Family and
 Model
Thread-Topic: [PATCH 2/2] Allow SEV firmware to be chosen based on Family and
 Model
Thread-Index: AQHUTHrcPgiFH6NduUedtQfbSYr40KT3oJqA
Date:   Wed, 19 Sep 2018 13:29:30 +0000
Message-ID: <85155459-44ef-b200-f442-fc5fde75a1ae@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <5c58c32c0ce89c35a95e151734f5d43a3ed0dca0.1536959537.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <5c58c32c0ce89c35a95e151734f5d43a3ed0dca0.1536959537.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0607;20:ulOs2fB0XJ2rFC7P84PtXatuf9J60QGFQLlHRZt5km8heixVnT/meXntD7si1liJTrCm6Z2tIszBdo4RKZz5n+wNi2Nk+qeUhCau5Gb46qfc0SLHEk4ieU7agPQCNEI0WF11Q1wRQvxPqjBkKm5fLOwqiWiyNL662ullVTKD0nEgaQH2Y0r7NjziC5Ei6i8PMEmnVfp5y4veeJf5ms1Vc8WLQ0tt/grRXNXVuwXgxdETctKGpT3hAMNsSj/Lkk1X
x-ms-office365-filtering-correlation-id: 33a12820-32fd-4c3a-fec5-08d61e33ed3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0607;
x-ms-traffictypediagnostic: SN1PR12MB0607:
x-microsoft-antispam-prvs: <SN1PR12MB06079620E528703FF24C76A2EC1C0@SN1PR12MB0607.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN1PR12MB0607;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0607;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(36756003)(2501003)(2900100001)(25786009)(4326008)(5250100002)(6246003)(3846002)(6116002)(76176011)(99286004)(2906002)(7736002)(305945005)(52116002)(256004)(14444005)(110136005)(54906003)(8936002)(8676002)(86362001)(575784001)(6436002)(105586002)(316002)(5660300001)(102836004)(81166006)(81156014)(478600001)(2201001)(106356001)(6486002)(229853002)(72206003)(14454004)(53936002)(31686004)(68736007)(53546011)(476003)(2616005)(31696002)(26005)(446003)(66066001)(486006)(6506007)(386003)(11346002)(6512007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0607;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FNNhTnWcXCr0g+et1PTui5GjfFokFmZCvKKSeVOQusDZe5UDrQ1dIY4R0w/SM/WQYo9E+FRAjzsUWww1l3rAaJUA1pozQwCOAHDl+K2+IXsOEVa019CHkOPITt33g5CPtoT76e8ZwJoVzuCO3qD52DlUXFdhSTmMC7GS2oFgvzsUcqsn/vG3d/O1q6HiAETH5O3zH3722StnkGYPx3VHGkJ4/8Hmxua+FC2NTOYAyL9E/C7BzxyFwCdOR95fSsODeHZeHA0/8M0CHzlBddfRsrbvnwWyt9SyU2UO/6vXIWoWrBPkYZ/r2b7jmxRiL95fHm/ag5bNpwXr8+S2NfpIXauQcA9qvVN039WpGL0mbF0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4730B51C1681B44AAC99B2A4747D6F9A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a12820-32fd-4c3a-fec5-08d61e33ed3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:29:30.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE0LzIwMTggMDU6MzIgUE0sIEphbmFrYXJhamFuIE5hdGFyYWphbiB3cm90ZToN
Cj4gRHVyaW5nIFBTUCBpbml0aWFsaXphdGlvbiwgdGhlcmUgaXMgYW4gYXR0ZW1wdCB0byB1cGRh
dGUgdGhlIFNFViBmaXJtd2FyZQ0KPiBieSBsb29raW5nIGluIC9saWIvZmlybXdhcmUvYW1kLy4g
Q3VycmVudGx5LCBzZXYuZncgaXMgdGhlIGV4cGVjdGVkIG5hbWUNCj4gb2YgdGhlIGZpcm13YXJl
IGJsb2IuDQo+IA0KPiBUaGlzIHBhdGNoIHdpbGwgYWxsb3cgZm9yIGZpcm13YXJlIGZpbGVuYW1l
cyBiYXNlZCBvbiB0aGUgZmFtaWx5IGFuZA0KPiBtb2RlbCBvZiB0aGUgcHJvY2Vzc29yLg0KPiAN
Cj4gTW9kZWwgc3BlY2lmaWMgZmlybXdhcmUgZmlsZXMgYXJlIGdpdmVuIGhpZ2hlc3QgcHJpb3Jp
dHkuIEZvbGxvd2VkIGJ5DQo+IGZpcm13YXJlIGZvciBhIHN1YnNldCBvZiBtb2RlbHMuIExhc3Rs
eSwgZmFpbGluZyB0aGUgcHJldmlvdXMgdHdvIG9wdGlvbnMsDQo+IGZhbGxiYWNrIHRvIGxvb2tp
bmcgZm9yIHNldi5mdy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbmFrYXJhamFuIE5hdGFyYWph
biA8SmFuYWthcmFqYW4uTmF0YXJhamFuQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBUb20gTGVu
ZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jcnlw
dG8vY2NwL3BzcC1kZXYuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5jIGIv
ZHJpdmVycy9jcnlwdG8vY2NwL3BzcC1kZXYuYw0KPiBpbmRleCBmNTQxZTYwLi4zYjMzODYzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5jDQo+ICsrKyBiL2RyaXZl
cnMvY3J5cHRvL2NjcC9wc3AtZGV2LmMNCj4gQEAgLTMxLDggKzMxLDkgQEANCj4gIAkJKChwc3Bf
bWFzdGVyLT5hcGlfbWFqb3IpID49IF9tYWogJiYJXA0KPiAgCQkgKHBzcF9tYXN0ZXItPmFwaV9t
aW5vcikgPj0gX21pbikNCj4gIA0KPiAtI2RlZmluZSBERVZJQ0VfTkFNRQkic2V2Ig0KPiAtI2Rl
ZmluZSBTRVZfRldfRklMRQkiYW1kL3Nldi5mdyINCj4gKyNkZWZpbmUgREVWSUNFX05BTUUJCSJz
ZXYiDQo+ICsjZGVmaW5lIFNFVl9GV19GSUxFCQkiYW1kL3Nldi5mdyINCj4gKyNkZWZpbmUgU0VW
X0ZXX05BTUVfU0laRQk2NA0KPiAgDQo+ICBzdGF0aWMgREVGSU5FX01VVEVYKHNldl9jbWRfbXV0
ZXgpOw0KPiAgc3RhdGljIHN0cnVjdCBzZXZfbWlzY19kZXYgKm1pc2NfZGV2Ow0KPiBAQCAtNDQw
LDYgKzQ0MSw0MCBAQCBzdGF0aWMgaW50IHNldl9nZXRfYXBpX3ZlcnNpb24odm9pZCkNCj4gIAly
ZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAraW50IHNldl9nZXRfZmlybXdhcmUoc3RydWN0IGRldmlj
ZSAqZGV2LCBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKipmaXJtd2FyZSkNCj4gK3sNCj4gKwljaGFy
IGZ3X25hbWVfc3BlY2lmaWNbU0VWX0ZXX05BTUVfU0laRV07DQo+ICsJY2hhciBmd19uYW1lX3N1
YnNldFtTRVZfRldfTkFNRV9TSVpFXTsNCj4gKw0KPiArCXNucHJpbnRmKGZ3X25hbWVfc3BlY2lm
aWMsIHNpemVvZihmd19uYW1lX3NwZWNpZmljKSwNCj4gKwkJICJhbWQvYW1kX3Nldl9mYW0lLjJ4
aF9tb2RlbCUuMnhoLnNiaW4iLA0KPiArCQkgYm9vdF9jcHVfZGF0YS54ODYsIGJvb3RfY3B1X2Rh
dGEueDg2X21vZGVsKTsNCj4gKw0KPiArCXNucHJpbnRmKGZ3X25hbWVfc3Vic2V0LCBzaXplb2Yo
ZndfbmFtZV9zdWJzZXQpLA0KPiArCQkgImFtZC9hbWRfc2V2X2ZhbSUuMnhoX21vZGVsJS4xeHho
LnNiaW4iLA0KPiArCQkgYm9vdF9jcHVfZGF0YS54ODYsIChib290X2NwdV9kYXRhLng4Nl9tb2Rl
bCAmIDB4ZjApID4+IDQpOw0KPiArDQo+ICsJLyogQ2hlY2sgZm9yIFNFViBGVyBmb3IgYSBwYXJ0
aWN1bGFyIG1vZGVsLg0KPiArCSAqIEV4LiBhbWRfc2V2X2ZhbTE3aF9tb2RlbDAwaC5zYmluIGZv
ciBGYW1pbHkgMTdoIE1vZGVsIDAwaA0KPiArCSAqDQo+ICsJICogb3INCj4gKwkgKg0KPiArCSAq
IENoZWNrIGZvciBTRVYgRlcgY29tbW9uIHRvIGEgc3Vic2V0IG9mIG1vZGVscy4NCj4gKwkgKiBF
eC4gYW1kX3Nldl9mYW0xN2hfbW9kZWwweGguc2JpbiBmb3INCj4gKwkgKiAgICAgRmFtaWx5IDE3
aCBNb2RlbCAwMGggLS0gRmFtaWx5IDE3aCBNb2RlbCAwRmgNCj4gKwkgKg0KPiArCSAqIG9yDQo+
ICsJICoNCj4gKwkgKiBGYWxsLWJhY2sgdG8gdXNpbmcgZ2VuZXJpYyBuYW1lOiBzZXYuZncNCj4g
KwkgKi8NCj4gKwlpZiAoKGZpcm13YXJlX3JlcXVlc3Rfbm93YXJuKGZpcm13YXJlLCBmd19uYW1l
X3NwZWNpZmljLCBkZXYpID49IDApIHx8DQo+ICsJICAgIChmaXJtd2FyZV9yZXF1ZXN0X25vd2Fy
bihmaXJtd2FyZSwgZndfbmFtZV9zdWJzZXQsIGRldikgPj0gMCkgfHwNCj4gKwkgICAgKGZpcm13
YXJlX3JlcXVlc3Rfbm93YXJuKGZpcm13YXJlLCBTRVZfRldfRklMRSwgZGV2KSA+PSAwKSkNCj4g
KwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlyZXR1cm4gLUVOT0VOVDsNCj4gK30NCj4gKw0KPiAgLyog
RG9uJ3QgZmFpbCBpZiBTRVYgRlcgY291bGRuJ3QgYmUgdXBkYXRlZC4gQ29udGludWUgd2l0aCBl
eGlzdGluZyBTRVYgRlcgKi8NCj4gIHN0YXRpYyBpbnQgc2V2X3VwZGF0ZV9maXJtd2FyZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+IEBAIC00NDksOSArNDg0LDEwIEBAIHN0YXRpYyBpbnQg
c2V2X3VwZGF0ZV9maXJtd2FyZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJc3RydWN0IHBhZ2Ug
KnA7DQo+ICAJdTY0IGRhdGFfc2l6ZTsNCj4gIA0KPiAtCXJldCA9IHJlcXVlc3RfZmlybXdhcmUo
JmZpcm13YXJlLCBTRVZfRldfRklMRSwgZGV2KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gKwlpZiAo
c2V2X2dldF9maXJtd2FyZShkZXYsICZmaXJtd2FyZSkgPT0gLUVOT0VOVCkgew0KPiArCQlkZXZf
ZGJnKGRldiwgIk5vIFNFViBmaXJtd2FyZSBmaWxlIHByZXNlbnRcbiIpOw0KPiAgCQlyZXR1cm4g
LTE7DQo+ICsJfQ0KPiAgDQo+ICAJLyoNCj4gIAkgKiBTRVYgRlcgZXhwZWN0cyB0aGUgcGh5c2lj
YWwgYWRkcmVzcyBnaXZlbiB0byBpdCB0byBiZSAzMg0KPiANCg==
