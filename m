Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89AF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KXnKTah2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89AF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLDWTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:19:19 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:2832
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbeLDWTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQpN+d7ljx7bWdvvs8LBuXQ8EkirqxkyLoP8kTd6zpo=;
 b=KXnKTah2W5Pr+4L2Ex9PIMAK0qYa9t8k601f4vg/hqy+vKEGI3Ikw1yEI+rJpAObf3ILqNFK0ryMEIt+MWtgg0f/8Mkd8ycUfR9Se7woieFyFZLE1ZD5G4AzTriGB+e7fMWHGk1vS5r1fe9tI3xkg18Ezc0HdPuX4PFPXwHoPpI=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3205.eurprd05.prod.outlook.com (10.170.223.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 22:19:14 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d16b:3dcb:b890:1504]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d16b:3dcb:b890:1504%2]) with mapi id 15.20.1404.019; Tue, 4 Dec 2018
 22:19:14 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Alex Lemberg <Alex.Lemberg@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device
 tree
Thread-Topic: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device
 tree
Thread-Index: AQHUgQyZnqIDHcsLeUecjxbJwIaWO6Vu2iGAgABiAFA=
Date:   Tue, 4 Dec 2018 22:19:14 +0000
Message-ID: <DB6PR05MB32239F8202BF9FA1840C1942A1AF0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
 <99DF0CBE-2879-4869-861D-06097D9E12CB@wdc.com>
In-Reply-To: <99DF0CBE-2879-4869-861D-06097D9E12CB@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3205;6:kv8V0fnSCA8v4mpP1XZE/2/HSwk704pyRROARbpu9MDq99VdAS4JX2/zrDLsk43KC/DywGkXeN09j01ktRoJsCbyXQwl0a+/7EGSa0TXyhjE/WNNZzGOOpSpDSbGW6c+lUC5QDEyd/UA49gYJwWKj09QM+DJO3aZZAW8kmv3eoLm+yVyVDCGaFA8Ghs4L88O5kmiaYSO4G/rJQJbtvOHQQVnz6oIaHE77XBYMUdU+TO9NBPcn5PN6+QweJ7kUYcTIwP5pAw1/X1PeURlEhmThnIcknu7EFUyzV0igZGk3n8kQMxCcS6FGb1OC9hgkNwZH5XeymmKTJSgU7j1XLxF3dDoenR3uVaSXZ9YB7IsX4UuNzY900u1VDT8J8wTp1U+y6qj2kxgfmErpja/l153dkL6vjBI/+AEtn+X2t6JCo1/z6mCRwSTysuwUbld61ZmQcKEbBmwKWAggkgFklAL9A==;5:9cD/hn+ng5q0MUrMjCacK6Cf+vpe37Z8Mp0xofRqjRDYcYJqCuwzeQtDDdkq3MpB4lf+MDacT1bFItvkAuAJ4Jc+rVED6T5mb+ZlHK5XUvJG+CmTwVHshaetWw6yMvGjQ4h96nft4TuFj8G9DPOs2l/+NyH+0ypCxuqTFfPH4ok=;7:eQR2n1+Au/Lwwr8weG1pJOTC6QuXx4RtxMDp2qWytOP2yys8RpK05IRNQQ9f8hW4yn5TeAHGKyBODlSwbaxgv4Ep4Y0AmaIVkc739hIROlNvI1WwQAMWvpwWYZafrksTvOnWB4XkgjoLHcybyTBzYQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55063884-f107-45e7-05b2-08d65a368625
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3205;
x-ms-traffictypediagnostic: DB6PR05MB3205:
x-microsoft-antispam-prvs: <DB6PR05MB3205DF833FAC229A396D53E5A1AF0@DB6PR05MB3205.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501514)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB6PR05MB3205;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3205;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(51914003)(13464003)(199004)(189003)(4326008)(14444005)(2906002)(102836004)(316002)(55016002)(6506007)(53546011)(54906003)(6246003)(110136005)(76176011)(105586002)(6116002)(53936002)(7696005)(3846002)(9686003)(99286004)(11346002)(8936002)(256004)(86362001)(6436002)(14454004)(7736002)(486006)(68736007)(305945005)(5660300001)(8676002)(66066001)(446003)(25786009)(229853002)(106356001)(33656002)(71190400001)(71200400001)(81166006)(26005)(74316002)(478600001)(476003)(186003)(81156014)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3205;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TVyhLX9yPlpTFM2H6TdApc+NMM7nQrl4Djk8u67i6wYEdGac6qcfHIr6R0OvG7/myz3XXziZ7nRVqmEsTYRM+L3JKcMpBFYJMyZVvkaMVoZyaGOypjxBsv+InilWkBJMJs33stgznZHFvroh13kKr3wQQysjgDNdGUjPOj8LkpfHiWBXH5rJTO6g/EUiPMDhBU9BWr2p3G7/znueuXU5GxzFFWBDp1SqDLzfL/+4gv/ed6wmFZI4RxEMeXQ9/x6e/DgkHw3DN/HlICLsQ3vph7Y15LRRwnQLXe9Nmqd9+b/VQ5avFzpjuuXWoXHppyZPdvgUxtPDY8rUueAxykkPh/Mx1XauTek4pC7Ktl8Pncs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55063884-f107-45e7-05b2-08d65a368625
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 22:19:14.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudC4gWWVzLCBJIGFjdHVhbGx5IGhhdmUgdGhlIHNhbWUgcXVl
c3Rpb24uDQpUaGUgY2hhbmdlIGhlcmUgaXMgdG8gZml4IGEgY29uZGl0aW9uIGJhc2VkIG9uIHRo
ZSBleGlzdGluZyBjb2RlLiBQcm9iYWJseSBhIGJldHRlciBmaXggaXMgdG8gZ2V0IHJpZCBvZiB0
aGUgJ2Nvbm5lY3Rpb24nLi4uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBB
bGV4IExlbWJlcmcgPEFsZXguTGVtYmVyZ0B3ZGMuY29tPiANClNlbnQ6IFR1ZXNkYXksIERlY2Vt
YmVyIDQsIDIwMTggMTE6MjcgQU0NClRvOiBMaW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT47
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgSmFlaG9vbiBDaHVuZyA8amg4
MC5jaHVuZ0BzYW1zdW5nLmNvbT47IERhdmlkIFdvb2RzIDxkd29vZHNAbWVsbGFub3guY29tPjsg
U2hhd24gTGluIDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+DQpDYzogbGludXgtbW1jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxLzFdIG1tYzogY29yZTogY29udHJvbCBFWFRfQ1NEX0NBQ0hFX0NUUkwgZnJvbSBk
ZXZpY2UgdHJlZQ0KDQoNCkhpLA0KDQoNCu+7v09uIDExLzIwLzE4LCAxMDowNyBQTSwgImxpbnV4
LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgb24gYmVoYWxmIG9mIExpbWluZyBTdW4iIDxsaW51
eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnIG9uIGJlaGFsZiBvZiBsc3VuQG1lbGxhbm94LmNv
bT4gd3JvdGU6DQoNCiAgICBDdXJyZW50bHkgdGhlIEVYVF9DU0RfQ0FDSEVfQ1RSTCByZWdpc3Rl
ciBpcyBjb250cm9sbGVkIGJ5IEFQSQ0KICAgIG1tY19jYXJkX2Jyb2tlbl9ocGkoKSwgd2hpY2gg
b25seSB3b3JrcyBmb3IgdGhlIHF1aXJrcyBzZXR0aW5ncy4NCiAgICBUaGlzIGNvbW1pdCBlbmhh
bmNlcyBpdCB0byB1c2UgY2FyZC0+ZXh0X2NzZC5ocGkgaW5zdGVhZC4gVGhpcw0KICAgIGZsYWcg
d29ya3MgZm9yIGJvdGggdGhlIHF1aXJrcyBhbmQgdGhlIGJyb2tlbi1ocGkgY29uZmlndXJhdGlv
bg0KICAgIGluIHRoZSBkZXZpY2UgdHJlZS4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBMaW1p
bmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9tbWMvY29y
ZS9tbWMuYyB8IDMgKy0tDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkNCiAgICANCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMu
YyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCiAgICBpbmRleCBiYzFiZDJjLi4yZjJiNjVjIDEw
MDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCiAgICArKysgYi9kcml2ZXJz
L21tYy9jb3JlL21tYy5jDQogICAgQEAgLTE3OTEsOCArMTc5MSw3IEBAIHN0YXRpYyBpbnQgbW1j
X2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IsDQogICAgIAkgKiBJZiBj
YWNoZSBzaXplIGlzIGhpZ2hlciB0aGFuIDAsIHRoaXMgaW5kaWNhdGVzDQogICAgIAkgKiB0aGUg
ZXhpc3RlbmNlIG9mIGNhY2hlIGFuZCBpdCBjYW4gYmUgdHVybmVkIG9uLg0KICAgICAJICovDQog
ICAgLQlpZiAoIW1tY19jYXJkX2Jyb2tlbl9ocGkoY2FyZCkgJiYNCiAgICAtCSAgICBjYXJkLT5l
eHRfY3NkLmNhY2hlX3NpemUgPiAwKSB7DQogICAgKwlpZiAoY2FyZC0+ZXh0X2NzZC5ocGkgJiYg
Y2FyZC0+ZXh0X2NzZC5jYWNoZV9zaXplID4gMCkgew0KDQoNCkFueSByZWFzb24gZm9yIG1ha2lu
ZyBhIGNvbm5lY3Rpb24gYmV0d2VlbiBIUEkgYW5kIENhY2hlIGluIGN1cnJlbnQgZHJpdmVyIGlt
cGxlbWVudGF0aW9uPw0KQlRXLCBJIG1pc3NlZCBpdCBiZWZvcmUsIGJ1dCB0aGUgcHJldmlvdXMg
Y29tbWl0IG1ha2luZyB0aGlzIGNvbm5lY3Rpb24gLSBpcyBhbHNvIGRvZXNuJ3QgbWFrZSBhbnkg
c2Vuc2UuDQpBbHRob3VnaCBieSB0aGUgc3BlYyBGTFVTSF9DQUNIRSBpcyBpbnRlcnJ1cHRpYmxl
IGNvbW1hbmQsIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIHByZXZlbnQgZGV2aWNlcyB3aXRoIG5v
IEhQSSBzdXBwb3J0LCB1c2luZyB0aGUgQ2FjaGUuDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIHdy
b25nLCBidXQgdGhlIGN1cnJlbnQgZHJpdmVyIGltcGxlbWVudGF0aW9uIGFsbG93cyB0byBzZW5k
IEhQSSBmb3IgQktPUFMgYW5kIFNhbml0aXplIChvbiB0aW1lb3V0IGVycm9yKSBjb21tYW5kcyBv
bmx5IC0gc28gd2h5IHdlIHNob3VsZCBsaW1pdCB0aGUgRkxVU0hfQ0FDSEUgY29tbWFuZD8NCg0K
DQogICAgIAkJZXJyID0gbW1jX3N3aXRjaChjYXJkLCBFWFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0K
ICAgICAJCQkJRVhUX0NTRF9DQUNIRV9DVFJMLCAxLA0KICAgICAJCQkJY2FyZC0+ZXh0X2NzZC5n
ZW5lcmljX2NtZDZfdGltZSk7DQogICAgLS0gDQogICAgMS44LjMuMQ0KICAgIA0KICAgIA0KDQo=
