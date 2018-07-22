Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D8FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB81920858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O74Y+kRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB81920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeGVTaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:30:55 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:12671
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729826AbeGVTaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUkGnfNsdeX2DuwyRDdesQ5q0l2wamVh4/nzHlC5SPY=;
 b=O74Y+kRwjemJ37UAV8BrlqZ80IQ+s3YKcxc1MguC9GNJXgTvnTozrDjuodMVou0Ftm/pTnexLqZcti5KIoF70VnN1ea1oBwnadaw6WVm9XsyF/3JB+opX4cwompjolcBGHU6RPgiLncEPsTpNc5/gl88Ik4s/v4Lay1zi5MCTDw=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2526.namprd13.prod.outlook.com (52.135.95.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.9; Sun, 22 Jul 2018 18:33:16 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::606f:87d7:76eb:7d88]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::606f:87d7:76eb:7d88%2]) with mapi id 15.20.0995.014; Sun, 22 Jul 2018
 18:33:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Topic: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Index: AQHUIZ3nGKqZY4HtrEiF17Da3y9jp6Sbi9MAgAAF1oA=
Date:   Sun, 22 Jul 2018 18:33:15 +0000
Message-ID: <a6be2d3bf2ff5ac43f82dcb7b29ba32faccbbdaf.camel@hammerspace.com>
References: <20180722085044.50701-1-nixiaoming@huawei.com>
         <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
In-Reply-To: <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.91.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2526;6:l2rOc6SheNI8v/n8xX4iJ+mRe6q1JXudIgVw1xguVpAusCMOucGzeeTQHy+oCMTR9864p5ZdGY+eNC1LhC1Gcs8DAigGNuocE982nOi/jYZn8/+Bf4zSayhrq2ZWAmC7DJS6Upr22CaXviaTQMdAQRhChxUiLwu3SSealvTs909pqA/MpVTcO0YG63yMDsfdV0XKoN9PIxECVX17KHYcCT2TEg9mamZ8nElFFgu0By9nAmPugZHILPmokwAo8VV/pk92ZWl1zPJdi1WD2CZIXFzvg891uZJVIF5inBQ9mxX0EWDkCw2BA3dY4HfUIw+LiQUoZE+2iwXeSZF2iABOOEbLQTuxESQvP/XHD0pqlhe4FWAAGcUPFfPXGPJ7Mg7S6Zgmtg1r+lhYlTyKCSCSPTZHT2XmsFIAArPFFBW/J4E83eZbzOilWB6hX9vwUYLW3rqcOsjfGllY6+mEc9EcUQ==;5:JCAgg/9i3UIm41ocMiWHx1P+BOpKgSpN3W/hLK1xPtFBtX2/LNuLx5oJ5fVAdiHMD2I4giv7vQ7IWRNbvm330Jqw/QT16VTapJbgFaDja9laQkA9JRU4VtgcBKnlGQzFeVEmpsjWDOpILuC4Lq7ZlTLPZXdLIlnvwOOqbK1fE7M=;7:zr8Ee9Mve0sQeOlGFqKUS+wiT8NfB9E1LHWl0sKgtlNkInsWMhxTmPfXLjm57bQw81KE2fzD7PCQYznDChgaL2CG7ytzc3x2pOGnEyviHtfgqtUQloSI+Xh/b8ranfL95Z82b+5FJWzC56fE1svt97uy95V4afVIwWM+1foIUt1a0QBnWTuXpos3d3I+DK9r/Fjy2GtdttdCcG0zEEVVd5tpnes849TkxQICv61bYA9oHn3n5A5KeKx9KUWqXQMB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd806452-8461-411d-19ad-08d5f001970c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2526;
x-ms-traffictypediagnostic: SN6PR13MB2526:
x-microsoft-antispam-prvs: <SN6PR13MB2526FF7388B0FACC845CE81DB8570@SN6PR13MB2526.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR13MB2526;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2526;
x-forefront-prvs: 0741C77572
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39830400003)(189003)(199004)(186003)(53936002)(15760500003)(2616005)(14454004)(36756003)(2900100001)(97736004)(14444005)(256004)(99286004)(26005)(478600001)(105586002)(7736002)(54906003)(110136005)(316002)(476003)(25786009)(106356001)(486006)(81166006)(66066001)(118296001)(6506007)(2906002)(6246003)(81156014)(446003)(86362001)(53546011)(229853002)(6512007)(5250100002)(5660300001)(2501003)(76176011)(6436002)(8676002)(4326008)(305945005)(6486002)(102836004)(6116002)(11346002)(8936002)(68736007)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2526;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: as3oBFlFPjdQJIOPV06W+UN7fySBrbZl55dKrsFT2gLg1SlG10Wwwua/qp5HkPiB/pphqTzW/XXIrXorzr1Ke9821mHxp7Vb72EYrh3xymjZaBOswjG86GIQN5Y+e8lUoUdbqjnIyRs1C3GgXthoPB4mu79tYalga0mBBCw7hDvYug39EZaRLDvQETEgTiDVBI34us4uragO1gUKlAlGfYpDAAswMCNm9eYG9ypaojGi2pNxaiAOZOY2nUNo8pgOqoHUT8WmqqKoS8+FD4lqN71Al/BZPuerPh5ZslU4AyYRXGW2c4APmNC3ZysJsMNh7YsnwDPfx4TX0KTJJKsQRqRhRO4c5H2iK24yMDJM55A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <31968880BB468649B06E76AA6850E644@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd806452-8461-411d-19ad-08d5f001970c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2018 18:33:16.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA3LTIyIGF0IDE0OjEyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdWwgMjIsIDIwMTgsIGF0IDQ6NTAgQU0sIG5peGlhb21pbmcgPG5peGlhb21pbmdAaHVh
d2VpLmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBkdW1teSA9IGJlMzJfdG9fY3B1cChwKysp
Ow0KPiA+IGR1bW15ID0gYmUzMl90b19jcHVwKHArKyk7DQo+ID4gQXNzaWduaW5nIHZhbHVlIHRv
ICJkdW1teSIgaGVyZSwgYnV0IHRoYXQgc3RvcmVkIHZhbHVlDQo+ID4gaXMgb3ZlcndyaXR0ZW4g
YmVmb3JlIGl0IGNhbiBiZSB1c2VkLg0KPiA+IA0KPiA+IGRlbGV0ZSBpbnZhbGlkIGFzc2lnbm1l
bnQgc3RhdGVtZW50cyBpbiBuZnNkNF9kZWNvZGVfZXhjaGFuZ2VfaWQNCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBuMDAyMDI3NTQgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4g
PiBmcy9uZnNkL25mczR4ZHIuYyB8IDQgKystLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2Qv
bmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiBpbmRleCBhOTY4NDNjLi44ZTc4NTQx
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvbmZzNHhkci5jDQo+ID4gKysrIGIvZnMvbmZzZC9u
ZnM0eGRyLmMNCj4gPiBAQCAtMTM5Miw4ICsxMzkyLDggQEAgbmZzZDRfZGVjb2RlX2V4Y2hhbmdl
X2lkKHN0cnVjdA0KPiA+IG5mc2Q0X2NvbXBvdW5kYXJncyAqYXJncCwNCj4gPiANCj4gPiAJCS8q
IHNzcF93aW5kb3cgYW5kIHNzcF9udW1fZ3NzX2hhbmRsZXMgKi8NCj4gPiAJCVJFQURfQlVGKDgp
Ow0KPiA+IC0JCWR1bW15ID0gYmUzMl90b19jcHVwKHArKyk7DQo+ID4gLQkJZHVtbXkgPSBiZTMy
X3RvX2NwdXAocCsrKTsNCj4gPiArCQliZTMyX3RvX2NwdXAocCsrKTsNCj4gPiArCQliZTMyX3Rv
X2NwdXAocCsrKTsNCj4gDQo+IElmIHRoZXNlIHZhbHVlcyBhcmUgbm90IHVzZWQsIHdoYXQncyB0
aGUgcG9pbnQgb2YgYnl0ZSBzd2FwcGluZyB0aGVtPw0KPiBTdXJlbHkgInAgKz0gMjsiIHNob3Vs
ZCBiZSBlbm91Z2guDQo+IA0KPiANCj4gPiAJCWJyZWFrOw0KPiA+IAlkZWZhdWx0Og0KPiA+IAkJ
Z290byB4ZHJfZXJyb3I7DQo+IA0KDQpHaXZlbiB0aGF0IHRoZSB2YWx1ZSBvZiAncCcgaXNuJ3Qg
dXNlZCBlaXRoZXIsIHdoeSBub3QganVzdCBkZWxldGUNCnRob3NlIHR3byBsaW5lcyBhbHRvZ2V0
aGVyPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
