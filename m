Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBAC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E720421855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bq6w6jFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAZBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:52:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15562 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:52:04 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4bbd410000>; Fri, 25 Jan 2019 17:52:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 17:52:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 25 Jan 2019 17:52:01 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 01:52:01 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 01:52:01 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Sat, 26 Jan 2019 01:52:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3431.namprd12.prod.outlook.com (20.178.196.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Sat, 26 Jan 2019 01:51:59 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Sat, 26 Jan 2019
 01:51:59 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Index: AQHUtCaoqz5N11EqJkeckmeQlifKWKXAs7AAgAAVOHA=
Date:   Sat, 26 Jan 2019 01:51:59 +0000
Message-ID: <BYAPR12MB33981C0EE06C88C9814B431EC2940@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <e782dfd3-4dc4-4f69-e360-f38e4705fdb4@gmail.com>
In-Reply-To: <e782dfd3-4dc4-4f69-e360-f38e4705fdb4@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3431;6:76E3dqdK2xhIe3ZWKCPKEsIVpHc2KvN1lzEF8Qt8iK/gz7ctsXqAG2+z8bcxOqwywO/p5NEZ7k27VvIoYQnWhmTaA7XsFep3+JYlG/t4n9iDqw8KY+qpT1yz89x6l5PmoyLvB4nnzM74nJGpzp4pLztRbfhr8eRORm4hAyk9MlnYnOz6VVuTSb1JIDo5PhFGx8UDkk6SVOo8/etBN2DT2bNsjpU9LN6pEYLZvlU2dgLYTqgQ2W4VpNTucpMt+LI6kVy1kU+lX1LTF1sVvvt5ijcXkqrjVh9egb0abayVZQjXkju/TDU8NIM1ag7wmA7TcrbhYFPZaqfMAUGYqr5gghRlTqm9zx5Gquau9UlESlhGV1TGwDEFzIAX4lnhKHKO2yBXRIAM5IeH2EiB25MU732ZO5s1GEe94279tjHahb9Fzx/XM8KV1e+9JDtWsmc4DvC9V98RApxA5UGg8KoRdA==;5:214sHNRJR+Uo7io+MzXTEn+3fAyHgSWkE3QZ/vqAvZlPYA87sr80yuBGJrhnAXw+sgFTJo1At1o2bVOcpTej6p7GuKztTWwdmTmPFct0mf0QsziR/CKEVc0PU1QAFiIUrg3gU4XyXXf/cxo3LEnZ0Q+cRlwCuLjIQEK4z1euXc64lsPaYJDihEmEisIP8FWxzIXUBZPUXTXBhksSuSEtZg==;7:ErTcggJsOE9WA1Miz5BBUo7GRqkS3FExArR22PJ1awUK1fKUJAWqYmXswkTGpWhdKyNuxej2SAtUod4+lPfiqZhcv83RMsVnLFoeQ+Dx5i8bflv/ckJGOV3g0M/0fz1GhawFK6uiINjH1vAJrGTLBA==
x-ms-office365-filtering-correlation-id: cb793e80-6807-4d93-b0c4-08d68330dc18
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3431;
x-ms-traffictypediagnostic: BYAPR12MB3431:
x-microsoft-antispam-prvs: <BYAPR12MB3431776FCA29DCF88CD3EA62C2940@BYAPR12MB3431.namprd12.prod.outlook.com>
x-forefront-prvs: 0929F1BAED
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(478600001)(55016002)(81156014)(81166006)(6436002)(6116002)(7736002)(3846002)(2906002)(486006)(8676002)(8936002)(305945005)(68736007)(86362001)(256004)(6636002)(99286004)(14444005)(54906003)(476003)(74316002)(110136005)(6246003)(66066001)(76176011)(7696005)(229853002)(33656002)(4326008)(25786009)(71200400001)(71190400001)(39060400002)(6506007)(102836004)(97736004)(14454004)(186003)(316002)(2501003)(26005)(105586002)(9686003)(106356001)(53936002)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3431;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rT7qpD1uTgdVlh5zi828jp13qVEFibDlM9gaDBeDDgeKKbPxPMaW7+26z11LXOPP8/REz2ECDY8spNIkeGsYh7mJkbaL0TMJOQ4DqOweLFmGZNeJPiNvzStI14IvyGxQYLuAwKsuy9xzQwjdWBzJnC0/xcP3zoqzj73ZIVzc0YUr4VMa00AhNVCVWuXvFTgFvoaqfHlP222lGq19P8FS5ioF+COZh+7f7l2rqiW4/OM/pkQyCj40KUQpZmuFF+XfJW1DdkCY3bRVr5zuea/XKTpmate+HPcHqMORWwzmRZTn0Ix3G2ytQizj68VEeN2MI4aDc3JDzn6W1FLUnQMazNQ7rqLRuxKwbtnqRQ/8hvyVRRuTbFhfS1S3PiKU3N0hRH+PQfo7d2Bspa5nZasConxx6YN4Up29/sH6YRhTEsw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb793e80-6807-4d93-b0c4-08d68330dc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 01:51:59.2677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548467521; bh=DOdNPBjFjIwm2M1z/2G8YDj2DGkz7f/VungmrUX9E/Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Bq6w6jFUxiv9z3nsgB+OzmxNu4jK5oEGyhx74E0yhwijsG97ye1o4pRG3OL0p/z5N
         LspFGiokrToJuLoIPGX80og+GRRCFln2med9JQEsKCDzItqU9jjmdDUWb8jneHpw1U
         sXTkW2pgiFyD9yVOA6iXkZBA4Q06mGjTIkZq3PCuhm0FdCIYsGa9+c76690vx0ZPix
         V2o302IYFDPwchlwiN6N9sbBhXnR60oVV5lZZQ+pn1YuKn1HGQjcBY/8JUWypX+Sxg
         R95qXgA18heMdhWYT1F6Q/hfo+Jlahz1a/ByCz8+fmVT1L/fji26lgSP4bnKzLzj8x
         G8hdwXsXxkaeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgaW50IHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbShzdHJ1Y3QgdGVncmFfaTJj
X2RldiAqaTJjX2RldiwNCj4gPiArCQkJCSAgICBib29sIGRtYV90b19tZW1vcnkpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBkbWFfY2hhbiAqZG1hX2NoYW47DQo+ID4gKwl1MzIgKmRtYV9idWY7DQo+
ID4gKwlkbWFfYWRkcl90IGRtYV9waHlzOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCWNvbnN0IGNo
YXIgKmNoYW5fbmFtZSA9IGRtYV90b19tZW1vcnkgPyAicngiIDogInR4IjsNCj4gPiArDQo+ID4g
KwlkbWFfY2hhbiA9IGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWxfcmVhc29uKGkyY19kZXYtPmRl
diwgY2hhbl9uYW1lKTsNCj4gPiArCWlmIChJU19FUlIoZG1hX2NoYW4pKQ0KPiA+ICsJCXJldHVy
biBQVFJfRVJSKGRtYV9jaGFuKTsNCj4NCj4gSGVyZSBzaGFsbCBiZSBhIGNoZWNrIG9mIHdoZXRo
ZXIgZG1hX2J1ZiBpcyBhbHJlYWR5IGFsbG9jYXRlZCwgb3RoZXJ3aXNlIGl0IHdpbGwgYmUgYWxs
b2NhdGVkIHR3aWNlIGFuZCB0aGUgZmlyc3QgYWxsb2NhdGlvbiB0dXJuZWQgaW50byBtZW1sZWFr
Og0KPg0KPglpZiAoaTJjX2Rldi0+ZG1hX2J1ZikNCj4JCXJldHVybiAwOw0KDQpJZiBkbWFfYnVm
IGlzIGFsbG9jYXRlZCBhbHJlYWR5IHRoZW4gZG1hIGNoYW5uZWxzIHdpbGwgYmUgYXNzaWduZWQg
YW5kIGl0IHdpbGwgbm90IHBlcmZvcm0gaW5pdCBkbWEgYWdhaW4uDQpTbyBpZiBkbWEgYnVmIGFs
bG9jYXRpb24gaGFwcGVucyBhbHJlYWR5IHRoZW4gaXQgd2lsbCBub3QgY29tZSBoZXJlIGFnYWlu
Lg0KDQo+ID4gKw0KPiA+ICsJZG1hX2J1ZiA9IGRtYV9hbGxvY19jb2hlcmVudChpMmNfZGV2LT5k
ZXYsIGkyY19kZXYtPmRtYV9idWZfc2l6ZSwNCj4gPiArCQkJCSAgICAgJmRtYV9waHlzLCBHRlBf
S0VSTkVMKTsNCj4gPiArDQo+DQo+IEknbSB3b25kZXJpbmcgd2hldGhlciBhIHdyaXRlLWNvbWJp
bmVkIERNQSBtYXBwaW5nIHdpbGwgYmUgbW9yZSBvcHRpbWFsIHRoYW4gaGF2aW5nIEwyIGZsdXNo
ZXMgLyBpbnZhbGlkYXRpb24gZm9yIHRoZSAiY29oZXJlbnQiIGFsbG9jYXRpb25zLiANCj4NCj4g
QW5kIEknbSBub3cgcXVlc3Rpb25pbmcgd2hldGhlciB0aGVyZSBpcyBhbnkgcmVhbCBiZW5lZml0
IGZyb20gdGhlIERNQSB0cmFuc2ZlcnJpbmcgYXQgYWxsLCBnaXZlbiB0aGUgRE1BIGJvdW5jZS1i
dWZmZXIgQ1BVIHJlYWQvd3JpdGUgb3ZlcmhlYWQuIEl0IGxvb2tzIHRvIG1lIHRoYXQgdGhlIHdo
b2xlIHB1cnBvc2Ugb2YgdGhlIEkyQyBETUEgdHJhbnNmZXJyaW5nIGlzIHRvIG1vdmUgZGF0YSBm
cm9tICh0bykgc29tZSBJMkMgZGV2aWNlIHRvIGEgPiA+IHNvbWUgZGV2aWNlIG9uIHRoZSBBUEIg
YnVzLCBieXBhc3NpbmcgdGhlIENQVS4gSWYgdGhhdCdzIGlzIHRoZSBjYXNlLCB0aGVuIHRoaXMg
cGF0Y2ggbWF5IG5vdCByZWFsbHkgd29ydGggdGhlIGVmZm9ydCBhbmQgaW5zdGVhZCBjb3VsZCBv
bmx5IGh1cnQgdGhlIHRyYW5zZmVycmluZyBwZXJmb3JtYW5jZS4gUGxlYXNlIHByb3ZpZGUgc29t
ZSBwZXJmb3JtYW5jZSByZXN1bHRzIG9yIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KPg0KPiBb
c25pcF0NCg0KRE1BIHRyYW5zZmVyIGhlbHBzIHRvIHJlZHVjZSBvdmVyaGVhZCBvbmx5IGR1cmlu
ZyBsYXJnZSB0cmFuc2ZlciB3aGljaCBpcyB2ZXJ5IHJhcmUgb3BlcmF0aW9uLiBXaWxsIGNoZWNr
IGFuZCBwcm92aWRlIHNvbWUgcGVyZm9ybWFuY2UgZGF0YS4uLg0KDQo+ID4gIA0KPiA+ICAJaWYg
KCFpMmNfZGV2LT5ody0+aGFzX3NpbmdsZV9jbGtfc291cmNlKSB7DQo+ID4gIAkJZmFzdF9jbGsg
PSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImZhc3QtY2xrIik7IEBAIC0xMDc5LDYgDQo+ID4g
KzE0MDIsMTUgQEAgc3RhdGljIGludCB0ZWdyYV9pMmNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJaWYgKGkyY19kZXYt
Pmhhc19kbWEpIHsNCj4gPiArCQlyZXQgPSB0ZWdyYV9pMmNfaW5pdF9kbWFfcGFyYW0oaTJjX2Rl
diwgdHJ1ZSk7DQo+ID4gKwkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlnb3Rv
IGRpc2FibGVfZGl2X2NsazsNCj4gPiArCQlyZXQgPSB0ZWdyYV9pMmNfaW5pdF9kbWFfcGFyYW0o
aTJjX2RldiwgZmFsc2UpOw0KPiA+ICsJCWlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gPiAr
CQkJZ290byBkaXNhYmxlX2Rpdl9jbGs7DQo+DQo+IE1pc3NpbmcgZG1hX2J1ZiBmcmVlaW5nIGFu
ZCBjaGFubmVsIHJlbGVhc2luZyBpbiBhIGNhc2Ugb2YgZXJyb3IuDQoNCmRtYSBidWYgZnJlZWlu
ZyBhbmQgY2hhbm5lbCByZWxlYXNlIGhhcHBlbnMgaW5zaWRlIGluaXRfZG1hIHdoZW4gYnVmZmVy
IGFsbG9jYXRpb24gZmFpbHMuDQpJZiBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNvbiBm
YWlscyBubyBuZWVkIHRvIHJlbGVhc2UgY2hhbm5lbCBidXQgaWYgY2hhbm5lbCByZXF1ZXN0IHN1
Y2NlZWRzIGFuZCBidWZmZXIgYWxsb2NhdGlvbiBmYWlscywgdGhlbiBidWZmZXIgZnJlZSBhbmQg
Y2hhbm5lbCByZWxlYXNlIHdpbGwgaGFwcGVuLg0KDQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0
ID0gdGVncmFfaTJjX2luaXQoaTJjX2Rldik7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2
X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIGluaXRpYWxpemUgaTJjIGNvbnRyb2xsZXJcbiIp
Ow0KPiA+IA0KDQo=
