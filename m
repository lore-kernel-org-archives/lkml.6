Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBDECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069220854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gUmAwTn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeGVUF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 16:05:57 -0400
Received: from mail-eopbgr680124.outbound.protection.outlook.com ([40.107.68.124]:9376
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730469AbeGVUF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 16:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V38KGnZO8zMFWvlJ0mcW2SUf1hyuawPLwO0ypOGzDw=;
 b=gUmAwTn+vEvfa74qxvTAh5BQeNaE8efKTS6xODA3KQ9OytemDsZpGbeY2m2ku7jHE9NyYyCyf2Yo4S9C0urx+xKG0kfp1DXfYDaZ9HsgOsT3HDyfXNB/YOs1io0bO5lSoG35KXxQ9grdERTcZrLyosvS5PyjQ2Qc3GAqIW6JY6w=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2254.namprd13.prod.outlook.com (52.135.93.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.12; Sun, 22 Jul 2018 19:08:10 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::606f:87d7:76eb:7d88]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::606f:87d7:76eb:7d88%2]) with mapi id 15.20.0995.014; Sun, 22 Jul 2018
 19:08:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Topic: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Thread-Index: AQHUIZ3nGKqZY4HtrEiF17Da3y9jp6Sbi9MAgAAF1oCAAAfGAIAAAfqA
Date:   Sun, 22 Jul 2018 19:08:09 +0000
Message-ID: <e0ee80246f7bb7587beac3f8d90f94cc6b7e6aff.camel@hammerspace.com>
References: <20180722085044.50701-1-nixiaoming@huawei.com>
         <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
         <a6be2d3bf2ff5ac43f82dcb7b29ba32faccbbdaf.camel@hammerspace.com>
         <8B9E4DFD-F651-4478-A82E-CDB759BB1A69@oracle.com>
In-Reply-To: <8B9E4DFD-F651-4478-A82E-CDB759BB1A69@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.91.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2254;6:pgTHSnb+41Rm+fOWBnik8Tn08sVMlBeRlWECtGAYihUeAuFNAEUcbvNtrvdrUxC5tZQFAKbIEXYvIVitp3pDYDVwOgcPvpvkxRZTYpWGWIZrhYouFVe3kiqESR5K35maG0v4DUkmXOcrJSZveIFVkVePmrZyQP4dXx9v6VIUdnxIgnh186IORBJQysLWi5S3bsrHjjLj1NmGN8AbRGHLtSzGQNHnQsC8kl5E3TGFKH2HaTcOKJwiY+00dlFfL3w72jeCVFKrHRtykR0eQv0QMVmw7S6rWhFOtOIHbTV6Oqdp1vvk3r0rVFJdHsfqJf0h25GOhibKIe/3jmPHAF9mlZAARnAU2MCBPNvurMwZcOhW/ITj4TyCZjyip6dWk6sF2CkRkXVVLGKZv9V8h2rzx0NQoHkoR/vBjHXVhirfAaFTncJ6yp4VjCLna++l7ZlTJzHfn+aRLyBmi39UV3YVrQ==;5:oorlmo2dCEQgbXMAQwd2P1G2wRRTA+2E5n3ReYnYkjZLLHVSIj5IKu/gIQnTe0j36U0C6X2AvWXSlvYjOdLSWe6PZzroUeStHOdH8QJi+ELFQIKKmJpwoXfGZmg6BORRqF4tRUITN8LQvcZQKpzICC5wuy0YaJyuWo5sk2NMSME=;7:4f7x6Bi/4WOzKT7HQoJqzWRVEv+MRfH5dZf7OmEALTUVZIUj2u01M7+6pGDGKf54Y09jkQNZOaDZPLe4I4Ld8p5YqSwFsVWxWnBxVOtJTTd7VhjYbTccN6lNnzsV7iGDrMc+d8ty0T6vDIb2fLNOc6wKgFRAs65iYFJ8opRJjQcKcUvDOjEsSggd6FcODmGPAr8LYB0rJYHqAdshGceYUeeluUfASG7BdEz095mOjgeqNWfZtNZzNLTjruUR8hY2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9d5c289-3e6b-4555-edf4-08d5f0067703
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2254;
x-ms-traffictypediagnostic: SN6PR13MB2254:
x-microsoft-antispam-prvs: <SN6PR13MB2254DEC8834A9466FB8D8DC0B8570@SN6PR13MB2254.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR13MB2254;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2254;
x-forefront-prvs: 0741C77572
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(366004)(39830400003)(199004)(189003)(36756003)(6916009)(97736004)(118296001)(486006)(2616005)(14444005)(5660300001)(8936002)(3846002)(6116002)(256004)(476003)(186003)(99286004)(229853002)(81156014)(26005)(478600001)(4326008)(8676002)(102836004)(81166006)(76176011)(6246003)(2351001)(6436002)(316002)(93886005)(6486002)(6512007)(86362001)(68736007)(53936002)(305945005)(15760500003)(14454004)(11346002)(446003)(66066001)(25786009)(53546011)(6506007)(5250100002)(7736002)(105586002)(2900100001)(106356001)(54906003)(5640700003)(2906002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2254;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jEzoi7a7fsa81rWcTJ1DQN5+nrugvT5dOz3fbm+WiPeksMPVYZjmwApMVxXuraSoMmuUmEl7xTZOc2IM2UD1AyNDEYrkNxJMN1JVx71LrAdSYFCQSbsyw/iJJCJU/OgVVRg7zplp+oc1mj8hvNNZ0KPDwhdyyF1e3Rn7vZ6Ind/wOacZbsv7vkKoPUpPV+CShHv77bQgLdlZw5iKYzG8YVoOWYY5hZquVxkQaDufPhmEPiWcpVvhsEbLqniXmGYgmREjzsKHtiZYc5/me4ycZPUbZJq/Uw/t3JcJD6y26okwKeADN4qV1EtU98a1Ra3Oad/NIlzjowlKqfOGeLZVTxqfsVgD8sBiyy3DLLSyWkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <886977DE1F9EFA4B92D7FCAFF6579A7E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d5c289-3e6b-4555-edf4-08d5f0067703
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2018 19:08:09.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA3LTIyIGF0IDE1OjAxIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdWwgMjIsIDIwMTgsIGF0IDI6MzMgUE0sIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFN1biwgMjAxOC0wNy0y
MiBhdCAxNDoxMiAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiA+IE9uIEp1bCAyMiwg
MjAxOCwgYXQgNDo1MCBBTSwgbml4aWFvbWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29tPg0KPiA+
ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IGR1bW15ID0gYmUzMl90b19jcHVwKHArKyk7
DQo+ID4gPiA+IGR1bW15ID0gYmUzMl90b19jcHVwKHArKyk7DQo+ID4gPiA+IEFzc2lnbmluZyB2
YWx1ZSB0byAiZHVtbXkiIGhlcmUsIGJ1dCB0aGF0IHN0b3JlZCB2YWx1ZQ0KPiA+ID4gPiBpcyBv
dmVyd3JpdHRlbiBiZWZvcmUgaXQgY2FuIGJlIHVzZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBkZWxl
dGUgaW52YWxpZCBhc3NpZ25tZW50IHN0YXRlbWVudHMgaW4NCj4gPiA+ID4gbmZzZDRfZGVjb2Rl
X2V4Y2hhbmdlX2lkDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBuMDAyMDI3NTQg
PG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGZzL25mc2QvbmZz
NHhkci5jIHwgNCArKy0tDQo+ID4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9u
ZnM0eGRyLmMgYi9mcy9uZnNkL25mczR4ZHIuYw0KPiA+ID4gPiBpbmRleCBhOTY4NDNjLi44ZTc4
NTQxIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9mcy9uZnNkL25mczR4ZHIuYw0KPiA+ID4gPiArKysg
Yi9mcy9uZnNkL25mczR4ZHIuYw0KPiA+ID4gPiBAQCAtMTM5Miw4ICsxMzkyLDggQEAgbmZzZDRf
ZGVjb2RlX2V4Y2hhbmdlX2lkKHN0cnVjdA0KPiA+ID4gPiBuZnNkNF9jb21wb3VuZGFyZ3MgKmFy
Z3AsDQo+ID4gPiA+IA0KPiA+ID4gPiAJCS8qIHNzcF93aW5kb3cgYW5kIHNzcF9udW1fZ3NzX2hh
bmRsZXMgKi8NCj4gPiA+ID4gCQlSRUFEX0JVRig4KTsNCj4gPiA+ID4gLQkJZHVtbXkgPSBiZTMy
X3RvX2NwdXAocCsrKTsNCj4gPiA+ID4gLQkJZHVtbXkgPSBiZTMyX3RvX2NwdXAocCsrKTsNCj4g
PiA+ID4gKwkJYmUzMl90b19jcHVwKHArKyk7DQo+ID4gPiA+ICsJCWJlMzJfdG9fY3B1cChwKysp
Ow0KPiA+ID4gDQo+ID4gPiBJZiB0aGVzZSB2YWx1ZXMgYXJlIG5vdCB1c2VkLCB3aGF0J3MgdGhl
IHBvaW50IG9mIGJ5dGUgc3dhcHBpbmcNCj4gPiA+IHRoZW0/DQo+ID4gPiBTdXJlbHkgInAgKz0g
MjsiIHNob3VsZCBiZSBlbm91Z2guDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiAJCWJyZWFrOw0K
PiA+ID4gPiAJZGVmYXVsdDoNCj4gPiA+ID4gCQlnb3RvIHhkcl9lcnJvcjsNCj4gPiANCj4gPiBH
aXZlbiB0aGF0IHRoZSB2YWx1ZSBvZiAncCcgaXNuJ3QgdXNlZCBlaXRoZXIsIHdoeSBub3QganVz
dCBkZWxldGUNCj4gPiB0aG9zZSB0d28gbGluZXMgYWx0b2dldGhlcj8NCj4gDQo+IFNvdW5kcyBP
SywgUkVBRF9CVUYgaXMgdHJhY2tpbmcgcHJvZ3Jlc3MgdGhyb3VnaCB0aGUgYnVmZmVyLA0KPiBh
bmQgaXQgYWxyZWFkeSB1cGRhdGVzICJwIiBhcyBhIHNpZGUtZWZmZWN0Lg0KPiANCj4gTWlnaHQg
dGhlcmUgYmUgc29tZSBuZWFyYnkgaW5zdGFuY2VzIG9mIG9wZW4tY29kZWQgInAiIHVwZGF0ZXMN
Cj4gdGhhdCBjb3VsZCBhbHNvIGJlIHJlbW92ZWQsIGZvciBzaW1pbGFyIHJlYXNvbnM/DQo+IA0K
DQpQcm9iYWJseSwgeWVzLiBJIGJlbGlldmUgdGhhdCB3ZSd2ZSBzYWlkIGJlZm9yZSAoYW5kIEJy
dWNlIGFncmVlZCBhdA0KdGhlIHRpbWUpIHRoYXQgd2Ugc2hvdWxkIGdldCByaWQgb2YgUkVBRF9C
VUYoKSBpbiBrbmZzZCBhcyBpdCB0ZW5kcyB0bw0Kb2JmdXNjYXRlIHRoZXNlIGFzc2lnbm1lbnRz
IHRvICdwJy4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgZnJlZSBjeWNsZXMgdG8NCndvcmsgb24gdGhh
dD8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
