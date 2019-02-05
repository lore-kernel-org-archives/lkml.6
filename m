Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5609C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F422081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gVw3RmNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfBEQlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:41:37 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:39802 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfBEQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:41:36 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c59bcbc0000>; Wed, 06 Feb 2019 00:41:33 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 08:41:31 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 05 Feb 2019 08:41:31 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 16:41:30 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 16:41:23 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 5 Feb 2019 16:41:23 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2903.namprd12.prod.outlook.com (20.179.91.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 16:41:20 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Tue, 5 Feb 2019
 16:41:20 +0000
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
Subject: RE: [PATCH V11 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V11 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvTDCDPnIVpzHqk6xXRbmupPKeqXRQyqAgAAa3MA=
Date:   Tue, 5 Feb 2019 16:41:20 +0000
Message-ID: <BYAPR12MB339828E77EB4D67906A5F0AEC26E0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
In-Reply-To: <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2903;6:nZwzuDi5TXWtkso1azAwrDzUdaMDeZdaD9ACKNpEBbjwn3j316CwN1catPwWfVlfL0o9iJvpcCFiKLSfcFL4d1JFHzfQmEhgmMqkPK0TL6CTB49SOxjFmLSqf9h1RPmeoY4+Lh6tbPs80xVbNkcZuXp9og5+ZB6uyZV018MsRsEYg44M9PgiMVTtPNhcJH/bD+168K1nf1r0OhVmZRd2XwgAZZ9Jleo6cSfUQes/yaMT05UnCnZ2SHfAaizKDd+tZAHIz/WHS5YaLJuMGjiI0JJHLKKMRRx5IYZGRa2WFOKvOjFUhxzFNGw3C90P883ocv5QrtaWdekiaKzcJgghXXsqB63+HJLoRw65xsrwz/LulGCoW1Kl4fLaoC9g+6DuZYlg+M7KUIXgYrzumErNK7dFeOKJZgaJNAvwntH3gYpCgUGNdOMvDinIa6PTmyRMgK7v8CbthOf5scMLPygq1w==;5:wISRcMVpxpCBxxvEW2csl7pyVm4WZTiYQziyt6iEikK82+hfplKKjZICYAzpPip+/XRIzVLh0AKsL2n+vVM4A1NCpI9p+UQhAnJaXQbk9n6I20rv3IZ2ancRqhIHER9dPdbyRMYWVJyeBTeDFUqk17NDmIp9A4NhyPyOP7mSYvzCn0qIFCXcOGrA8hG5aZk1dzeeQJgBXX/DEM+RXjeDNA==;7:zGNgZjvs/yhjrIsU0nlmcvtmsFWbJMG0W+3eyVb33/3r2t5lfK5njQ6e0Sp3WqNHuYhpi03uPvh53JnrGJxtqKJTJ5yJDA9MA4L2c6lp2vK/VTfCPbFh1fQhYPW0nyr6CfuM/KXvRn3TmDn1atB6ew==
x-ms-office365-filtering-correlation-id: ebdcce45-aa7a-41e2-d10e-08d68b88c22d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2903;
x-ms-traffictypediagnostic: BYAPR12MB2903:
x-microsoft-antispam-prvs: <BYAPR12MB290367814E3C9075B89BB31FC26E0@BYAPR12MB2903.namprd12.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(446003)(81166006)(6506007)(66066001)(14454004)(6116002)(478600001)(25786009)(3846002)(86362001)(256004)(14444005)(2501003)(2906002)(11346002)(6436002)(7736002)(54906003)(106356001)(110136005)(105586002)(33656002)(55016002)(316002)(486006)(71200400001)(99286004)(71190400001)(4326008)(476003)(53936002)(6636002)(8936002)(7696005)(74316002)(76176011)(305945005)(97736004)(6246003)(68736007)(186003)(81156014)(26005)(8676002)(9686003)(102836004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2903;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hiNTrWRBC49Z9zi5Ck3mUaA/YZNgh3gCZwo92Z5Q9MBtndprLkcV8jKXNuOFQBon2e0FrOQvuwKlPggGsXMF38NyugqNEyJXnT8hFwiyCRNu92qvJty3W89uG14IjupWOx0bevzG0OxBX/WrdPjswsSdI/MBAUzR0GFPIDryydzPlFhr1f/XY5BYKytU2+kXXRmMVGWcpjE5RLjY6Cnl0ORFTKA/816OgDToKQ6av7p5kxxODEVIQiJoeorh3jeGNw6drEbMde9CQDrW/eyH+lLKF++1iYFoW7AGs7/oWusjE7zmzGrdGNEBWmx1dWUUJKgPYI0fz69fbp2wIY4N8Namx5dgbFvhpdBfgZrTWJbOz+8sbEWs+JNNR611jFINwVTTArdqCavaBtQGdCDP6/683mrJ8ECbPo2hmooqVXA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdcce45-aa7a-41e2-d10e-08d68b88c22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:41:20.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2903
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549384893; bh=PkgnPxxQYxMRWsPjCyV+YbSPbo3yaDuRi1XGlXt9dWM=;
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
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=gVw3RmNUBlsJ73W8tedej29gXjkxNQhlwa6iK5t/7gTYvm8Doks8yAnwaOSWU1Uqk
         W0gVl709IHA5xfkMvkBe+9xbI3r8h0Wjir1GZYX+QzDzvksDu7vzGBSpcXzvkZ0St/
         C+ORkO8Sfz/ctR6aMY8fiUgySCeLZE914F8Alt5rX9PGQ2wpmw35LQEaxOb5rhe9kM
         iXlrjb3iwrJro9nbA3T74KiOWo3NcMFCx6dBSgCKgYTkabrg94sbRTbUcOcqJMndqS
         48L7O81ROpSavQiFhJP7PxR3gEWEigkXeAIFvJJ4N3gWTDAV8/H8T9q0OzOEpFv4pT
         WGbsC8lT8gO0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBQbGVhc2UgdXNlICIuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCAqLnBhdGNoIiBh
bmQgZml4IGFsbCBpdHMgY29tcGxhaW5zLCBidXQgb25seSB0aG9zZSB0aGF0IHJlYWxseSBtYWtl
IHNlbnNlLiBGb3IgZXhhbXBsZSBpZ25vcmUgdGhlICJDSEVDSzogTGluZXMgc2hvdWxkIG5vdCBl
bmQgd2l0aCBhICcoJyIgd2FybmluZ3MuIA0KPg0KPkhlcmUgY2hlY2twYXRjaCByZWNvbW1lbmRz
IHRvIHVzZSB0aGUgQklUKCkgbWFjcm86DQo+DQo+IENIRUNLOiBQcmVmZXIgdXNpbmcgdGhlIEJJ
VCBtYWNybw0KPiAjMzk0OiBGSUxFOiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmM6MTM2
Og0KPiArI2RlZmluZSBEQVRBX0RNQV9ESVJfVFggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICgxIDw8IDApDQo+DQo+IENIRUNLOiBQcmVmZXIgdXNpbmcgdGhlIEJJVCBtYWNybw0KPiAj
Mzk1OiBGSUxFOiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmM6MTM3Og0KPiArI2RlZmlu
ZSBEQVRBX0RNQV9ESVJfUlggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IDEp
DQoNCkkgdXNlZCBjaGVja3BhdGNoIHNjcmlwdCwgYW5kIGl0IGRpZG7igJl0IHNob3dlZCB0aGVz
ZSBlcnJvcnMuIFByb2JhYmx5IGNoZWNrcGF0Y2ggc2NyaXB0IHZlcnNpb25zIGFyZSBkaWZmZXJl
bnQuIEkgYW0gdXNpbmcgdGhlIG9uZSBmcm9tIDUuMC1yYzQNCg0KPiArc3RhdGljIGludCB0ZWdy
YV9pMmNfZG1hX3N1Ym1pdChzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2Rldiwgc2l6ZV90IA0K
PiArbGVuKSB7DQo+ICsJc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICpkbWFfZGVzYzsN
Cj4gKwllbnVtIGRtYV90cmFuc2Zlcl9kaXJlY3Rpb24gZGlyOw0KPiArCXN0cnVjdCBkbWFfY2hh
biAqY2hhbjsNCj4gKw0KPiArCWRldl9kYmcoaTJjX2Rldi0+ZGV2LCAic3RhcnRpbmcgRE1BIGZv
ciBsZW5ndGg6ICV6dVxuIiwgbGVuKTsNCj4gKwlyZWluaXRfY29tcGxldGlvbigmaTJjX2Rldi0+
ZG1hX2NvbXBsZXRlKTsNCj4gKwlkaXIgPSBpMmNfZGV2LT5tc2dfcmVhZCA/IERNQV9ERVZfVE9f
TUVNIDogRE1BX01FTV9UT19ERVY7DQo+ICsJY2hhbiA9IGkyY19kZXYtPm1zZ19yZWFkID8gaTJj
X2Rldi0+cnhfZG1hX2NoYW4gOiBpMmNfZGV2LT50eF9kbWFfY2hhbjsNCj4gKwlkbWFfZGVzYyA9
IGRtYWVuZ2luZV9wcmVwX3NsYXZlX3NpbmdsZShjaGFuLCBpMmNfZGV2LT5kbWFfcGh5cywNCj4g
KwkJCQkJICAgICAgIGxlbiwgZGlyLCBETUFfUFJFUF9JTlRFUlJVUFQgfA0KPiArCQkJCQkgICAg
ICAgRE1BX0NUUkxfQUNLKTsNCj4gKwlpZiAoIWRtYV9kZXNjKSB7DQo+ICsJCWRldl9lcnIoaTJj
X2Rldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBETUEgZGVzY3JpcHRvclxuIik7DQo+ICsJCXJldHVy
biAtRUlPOw0KPg0KPiBSZXR1cm5pbmcgdGhlIC1FSU8gaXMgdGVjaG5pY2FsbHkgaW5jb3JyZWN0
IGJlY2F1c2UgdGhlcmUgaXMgbm8gaGFyZHdhcmUgZmFpbHVyZSBoZXJlLiBUaGUgZG1hZW5naW5l
X3ByZXBfc2xhdmVfc2luZ2xlKCkgbWVyZWx5IGFsbG9jYXRlcyB0aGUgRE1BIGRlc2NyaXB0b3Is
IGhlbmNlIGl0IHNob3VsZCBiZSBlaXRoZXIgLUVJTlZBTCAocHJlZmVyYWJseSkgb3IgYXQgbGVh
c3QgLUVOT01FTS4NCj4NCj4gT2gsIGFub3RoZXIgaW1wb3J0YW50IG1vbWVudCBpcyB0aGF0IHBo
eXNpY2FsbHkgY29udGlndW91cyBkbWFfYnVmIGFsbG9jYXRpb24gaXNuJ3QgZ3VhcmFudGVlZCBi
eSB0aGUgRE1BIEFQSS4gVGhpcyBtYXkgYmVjb21lIGEgcHJvYmxlbSBmb3IgVDE4NisgdGhhdCBj
YW4gdHJhbnNmZXIgdXAgdG8gNjRLLiBXZSBuZWVkIHRvIGVuZm9yY2UgdGhlIGNvbnRpZ3VvdXMt
YWxsb2NhdGlvbiByZXF1aXJlbWVudCBieSB1c2luZyA+IGRtYV9hbGxvY19hdHRycyhETUFfQVRU
Ul9GT1JDRV9DT05USUdVT1VTKSBpbnN0ZWFkIG9mIHRoZSBkbWFfYWxsb2NfY29oZXJlbnQoKSwg
cGxlYXNlIHNlZSBteSBvdGhlciBjb21tZW50IGJlbG93Lg0KDQpGYWlsdXJlIHJldHVybmVkIGZy
b20gZG1hIHN1Ym1pdCB3aWxsIGJlIHJldHVybmVkIGJ5IGkyYyB4ZmVyIG1lc3NhZ2UgYW5kIHVz
aW5nIEVJTyBoZXJlIGFzIGRtYWVuZ2luZV9wcmVwX3NsYXZlX3NpbmdsZSBjYW4gcmVzdWx0IGlu
IG11bHRpcGxlIGZhaWx1cmVzIChpbnZhbGlkIHNlZ21lbnQgbGVuZ3RoLCAgZmFpbGluZyBkbWEg
ZGVzYyBhbGxvY2F0aW9uLCBkbWEgbGVuZ3RoL21lbW9yeSBjaGVjaywgbm8gYXZhaWxhYmxlIGRt
YSBzZy1yZWcpDQpBcyBwZXIgSTJDIGZhdWx0IGNvZGVzLCBFSU8gY2FuIGJlIHVzZWQgaW5kaWNh
dGluZyB3aGVuIHNvbWV0aGluZyB3ZW50IHdyb25nIGR1cmluZyBwZXJmb3JtaW5nIElPIG9wZXJh
dGlvbi4NCg0KVXNpbmcgRUlOVkFMIGRvZXNu4oCZdCBzdWl0IGlmIGZhaWx1cmUgaXMgZnJvbSBh
bGxvY2F0aW9uIGFuZCB1c2luZyBFTk9NRU0gZG9lc27igJl0IHN1aXQgaWYgZmFpbHVyZSBpcyBk
dWUgdG8gbGVuZ3RoL21lbW9yeSwgc2VnbWVudCBsZW5ndGggY2hlY2suDQoNCldpbGwgdXNlIEZP
UkNFX0NPTlRJR1VPVVMuDQoNCg0KDQo+ID4gKwlkbWFfYnVmID0gZG1hX2FsbG9jX2NvaGVyZW50
KGkyY19kZXYtPmRldiwgaTJjX2Rldi0+ZG1hX2J1Zl9zaXplLA0KPiA+ICsJCQkJICAgICAmZG1h
X3BoeXMsIEdGUF9LRVJORUwgfCBfX0dGUF9OT1dBUk4pOw0KPiANCj4gUGxlYXNlIHVzZSBkbWFf
YWxsb2NfYXR0cnMoKSBpbnN0ZWFkIG9mIGRtYV9hbGxvY19jb2hlcmVudCgpIGJlY2F1c2UgaXQg
Y291bGQgcmV0dXJuIGEgc3BhcnNlIGFsbG9jYXRpb24uIFRoaXMgaXMgZXNwZWNpYWxseSB0cm91
Ymxlc29tZSA+IGZvciBBUk02NCBwbGF0Zm9ybXMgYmVjYXVzZSBJT01NVV9ET01BSU5fRE1BIGlz
IHVzZWQgYnkgZGVmYXVsdCB0aGVyZS4gV2UgbmVlZCB0byBleHBsaWNpdGx5IGFzayBmb3IgdGhl
IGNvbnRpZ3VvdXMgYWxsb2NhdGlvbjoNCj4gDQo+DQo+CWRtYV9idWYgPSBkbWFfYWxsb2NfYXR0
cnMoaTJjX2Rldi0+ZGV2LCBpMmNfZGV2LT5kbWFfYnVmX3NpemUsDQo+CQkJCSAgJmRtYV9waHlz
LCBHRlBfS0VSTkVMLA0KPgkJCQkgIERNQV9BVFRSX0ZPUkNFX0NPTlRJR1VPVVMgfA0KPgkJCQkg
IERNQV9BVFRSX05PX1dBUk4pOw0KPg0KV2lsbCBzd2l0Y2ggdG8gdXNlIGRtYV9hbGxvY19hdHRy
cyB3aXRoIENPTlRJR1VPVVMNCj4NCj4NCj4NCj4NCj4gQ0hFQ0s6IG11bHRpcGxlIGFzc2lnbm1l
bnRzIHNob3VsZCBiZSBhdm9pZGVkDQo+ICM3NjM6IEZJTEU6IGRyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtdGVncmEuYzo5OTM6DQo+ICsgICAgICAgICAgICAgICBpMmNfZGV2LT5pc19jdXJyX2RtYV94
ZmVyID0gZG1hID0gZmFsc2UNCj4NCj4gQ0hFQ0s6IFVubmVjZXNzYXJ5IHBhcmVudGhlc2VzIGFy
b3VuZCAnaTJjX2Rldi0+bXNnX2VyciA9PSBJMkNfRVJSX05PTkUnDQo+ICM4Nzc6IEZJTEU6IGRy
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYzoxMTA1Og0KPiArICAgICAgICAgICAgICAgaWYg
KGkyY19kZXYtPm1zZ19yZWFkICYmIChpMmNfZGV2LT5tc2dfZXJyID09IA0KPiArIEkyQ19FUlJf
Tk9ORSkpIHsNCj4gQ0hFQ0s6IEFsaWdubWVudCBzaG91bGQgbWF0Y2ggb3BlbiBwYXJlbnRoZXNp
cw0KPiAjODgzOiBGSUxFOiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmM6MTExMToNCj4g
DQo+DQpTb21laG93IENoZWNrc2NyaXB0IGRpZG7igJl0IHNob3dlZCB0aGlzIGVpdGhlciB3aGVu
IEkgcmFuLiBQcm9iYWJseSBkdWUgdG8gZGlmZiBzY3JpcHQgdmVyc2lvbnMuIEkgYW0gdXNpbmcg
dGhlIG9uZSBmcm9tIDUuMC1yYzQuDQoNCg==
