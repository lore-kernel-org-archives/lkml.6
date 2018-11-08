Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162DBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1E120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u7+aWjC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKIBqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:46:31 -0500
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:21783
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbeKIBqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2SRWHcNyOj8KQIwOFe7sB0ujhl+3iGV1YzH5mrBkJ4=;
 b=u7+aWjC6MCTCwvhOrPPO+hHXybkdY0BzFrQ4oe4YqeXsTIoW6j713OCI3ryODRtyyuGoSsRkCWyB+SG+SNFlB49V5RkGJIiNa9aCSP6Qr0L/rKHHnhFQC45KNw/Gqj8s791f/lAHZPG7uQkQogyANadze88SdQlZPAf1x3AiOHc=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1251.namprd12.prod.outlook.com (10.168.227.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 16:10:17 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 16:10:17 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
Thread-Topic: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
Thread-Index: AQHUd3y6io7m8AE8QUWtBmK5h9zRj6VGDBOA
Date:   Thu, 8 Nov 2018 16:10:17 +0000
Message-ID: <2f577af9-9ff7-4e9d-b198-02727a995393@amd.com>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-2-eric@anholt.net>
In-Reply-To: <20181108160422.17743-2-eric@anholt.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM6PR0202CA0070.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::47) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1251;20:E7CQecQLEdOpOPN/0bhRUaWRkPegLLemTyq+5O+ShE2NkdOCQFnwR5GwZG3Uspf5EnTNb2It4Ko9Z2xSYD8kndRkCL9W0m4GF5W9pJiasVz+iYhimT9U99h7vD8iXJH/UvaY9MCbZaRFz8tKxq7GlcsMNOZLugvpVi6u1ZAr1ozbvQRr7M4M3LpOxMsq2bIvIdZi5X9PmVc50CEilWjyc6FFNbIXxGKQ1DKPTaocgj/svX5aNtRCQxRlDXXg6iLy
x-ms-office365-filtering-correlation-id: 97166fad-ddd7-4f8c-a68e-08d64594ac59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1251;
x-ms-traffictypediagnostic: BN6PR12MB1251:
x-microsoft-antispam-prvs: <BN6PR12MB12516921E4D8B36163575C6B83C50@BN6PR12MB1251.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1251;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1251;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(51234002)(65806001)(65956001)(72206003)(229853002)(31686004)(2906002)(14454004)(2501003)(5660300001)(99286004)(14444005)(71200400001)(4326008)(486006)(71190400001)(8936002)(446003)(31696002)(476003)(25786009)(305945005)(7736002)(36756003)(86362001)(65826007)(2616005)(256004)(11346002)(68736007)(52116002)(316002)(6506007)(386003)(81166006)(81156014)(45080400002)(64126003)(97736004)(2900100001)(58126008)(186003)(76176011)(54906003)(110136005)(102836004)(478600001)(8676002)(6512007)(39060400002)(6116002)(6436002)(6486002)(105586002)(6246003)(53936002)(106356001)(66574009)(46003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1251;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: saSpAJcxY6UteFbihgTErbRGSTWjo5wH/xzIJsdZgWAZOuKTop2PDqLNuyVD4qX4vlDIzYHPTVljX0DVfFIIBF/unj4GlZ7uYWhkxhk0QW1loOevGmrDdh0wIMry/crYg8e3orS2p0H81ZMMJizmXHBwPquxvywnFUboLHcjmeJQa2QHjyTm59Cz2UxPtPtlnS1ZjAWAaCxo410NOBAgxmZASaAgmFhS00ORcn6E70EHCq5okuGRT2Kvitc5dAPM5LLbub5CduUbPM3kkeMydClxGWQuQhAPqSQYb/7jNkeLR6rLxPMgMFSb73ORk6y1V/BVMi8D4PFKugcv8ym8xWjcu2Y1ctamW3zlqmNCAxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6875EBB0D62E3348BC8DE11FA3DC6CCF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97166fad-ddd7-4f8c-a68e-08d64594ac59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 16:10:17.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTEuMTggdW0gMTc6MDQgc2NocmllYiBFcmljIEFuaG9sdDoNCj4gVGhpcyByZXZlcnRz
IGNvbW1pdCAwZWZkMmQyZjY4Y2Q1ZGJkZGY0ZWNkOTc0YzMzMTMzMjU3ZDE2YThlLiAgRml4ZXMN
Cj4gdGhpcyBmYWlsdXJlIGluIFYzRCBHUFUgcmVzZXQ6DQo+DQo+IFsgMTQxOC4yMjc3OTZdIFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFs
IGFkZHJlc3MgMDAwMDAwMTgNCj4gWyAxNDE4LjIzNTk0N10gcGdkID0gZGM0YzU1Y2ENCj4gWyAx
NDE4LjIzODY5NV0gWzAwMDAwMDE4XSAqcGdkPTgwMDAwMDQwMDA0MDAzLCAqcG1kPTAwMDAwMDAw
DQo+IFsgMTQxOC4yNDQxMzJdIEludGVybmFsIGVycm9yOiBPb3BzOiAyMDYgWyMxXSBTTVAgQVJN
DQo+IFsgMTQxOC4yNDg5MzRdIE1vZHVsZXMgbGlua2VkIGluOg0KPiBbIDE0MTguMjUyMDAxXSBD
UFU6IDAgUElEOiAxMDI1MyBDb21tOiBrd29ya2VyLzA6MCBOb3QgdGFpbnRlZCA0LjE5LjAtcmM2
KyAjNDg2DQo+IFsgMTQxOC4yNTkwNThdIEhhcmR3YXJlIG5hbWU6IEJyb2FkY29tIFNUQiAoRmxh
dHRlbmVkIERldmljZSBUcmVlKQ0KPiBbIDE0MTguMjY1MDAyXSBXb3JrcXVldWU6IGV2ZW50cyBk
cm1fc2NoZWRfam9iX3RpbWVkb3V0DQo+IFsgMTQxOC4yNjk5ODZdIFBDIGlzIGF0IGRtYV9mZW5j
ZV9yZW1vdmVfY2FsbGJhY2srMHg4LzB4NTANCj4gWyAxNDE4LjI3NTIxOF0gTFIgaXMgYXQgZHJt
X3NjaGVkX2pvYl90aW1lZG91dCsweDRjLzB4MTE4DQo+IC4uLg0KPiBbIDE0MTguNDE1ODkxXSBb
PGMwODZiNzU0Pl0gKGRtYV9mZW5jZV9yZW1vdmVfY2FsbGJhY2spIGZyb20gWzxjMDZlN2U2Yz5d
IChkcm1fc2NoZWRfam9iX3RpbWVkb3V0KzB4NGMvMHgxMTgpDQo+IFsgMTQxOC40MjU1NzFdIFs8
YzA2ZTdlNmM+XSAoZHJtX3NjaGVkX2pvYl90aW1lZG91dCkgZnJvbSBbPGMwMjQyNTAwPl0gKHBy
b2Nlc3Nfb25lX3dvcmsrMHgyYzgvMHg3YmMpDQo+IFsgMTQxOC40MzQ1NTJdIFs8YzAyNDI1MDA+
XSAocHJvY2Vzc19vbmVfd29yaykgZnJvbSBbPGMwMjQyYTM4Pl0gKHdvcmtlcl90aHJlYWQrMHg0
NC8weDU5MCkNCj4gWyAxNDE4LjQ0MjY2M10gWzxjMDI0MmEzOD5dICh3b3JrZXJfdGhyZWFkKSBm
cm9tIFs8YzAyNDliMTA+XSAoa3RocmVhZCsweDE2MC8weDE2OCkNCj4gWyAxNDE4LjQ1MDA3Nl0g
WzxjMDI0OWIxMD5dIChrdGhyZWFkKSBmcm9tIFs8YzAyMDEwYWM+XSAocmV0X2Zyb21fZm9yaysw
eDE0LzB4MjgpDQo+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQo+IENjOiBOYXlhbiBEZXNobXVraCA8bmF5YW4yNmRlc2htdWtoQGdtYWlsLmNvbT4N
Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBBbmhvbHQgPGVyaWNAYW5ob2x0Lm5ldD4NCg0KV2VsbCBOQUsuIFRoZSBw
cm9ibGVtIGhlcmUgaXMgdGhhdCBmZW5jZS0+cGFyZW50IGlzIE5VTEwgd2hpY2ggaXMgbW9zdCAN
Cmxpa2VseSBjYXVzZWQgYnkgYW4gaXNzdWUgc29tZXdoZXJlIGVsc2UuDQoNCldlIGNvdWxkIGVh
c2lseSB3b3JrIGFyb3VuZCB0aGF0IHdpdGggYW4gZXh0cmEgTlVMTCBjaGVjaywgYnV0IHJldmVy
dGluZyANCnRoZSBwYXRjaCB3b3VsZCBicmVhayBHUFUgcmVjb3ZlcnkgYWdhaW4uDQoNCkNocmlz
dGlhbi4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4u
YyB8IDMwICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAyOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9tYWluLmMNCj4gaW5kZXggNDRmZTU4N2FhZWY5Li5iZDdkMTFjNDcyMDIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+IEBAIC0yNDksNDEgKzI0
OSwxMyBAQCBzdGF0aWMgdm9pZCBkcm1fc2NoZWRfam9iX3RpbWVkb3V0KHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCj4gICB7DQo+ICAgCXN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQ7
DQo+ICAgCXN0cnVjdCBkcm1fc2NoZWRfam9iICpqb2I7DQo+IC0JaW50IHI7DQo+ICAgDQo+ICAg
CXNjaGVkID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciwgd29y
a190ZHIud29yayk7DQo+IC0NCj4gLQlzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsN
Cj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JldmVyc2Uoam9iLCAmc2NoZWQtPnJpbmdfbWlycm9y
X2xpc3QsIG5vZGUpIHsNCj4gLQkJc3RydWN0IGRybV9zY2hlZF9mZW5jZSAqZmVuY2UgPSBqb2It
PnNfZmVuY2U7DQo+IC0NCj4gLQkJaWYgKCFkbWFfZmVuY2VfcmVtb3ZlX2NhbGxiYWNrKGZlbmNl
LT5wYXJlbnQsICZmZW5jZS0+Y2IpKQ0KPiAtCQkJZ290byBhbHJlYWR5X3NpZ25hbGVkOw0KPiAt
CX0NCj4gLQ0KPiAgIAlqb2IgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnNjaGVkLT5yaW5n
X21pcnJvcl9saXN0LA0KPiAgIAkJCQkgICAgICAgc3RydWN0IGRybV9zY2hlZF9qb2IsIG5vZGUp
Ow0KPiAtCXNwaW5fdW5sb2NrKCZzY2hlZC0+am9iX2xpc3RfbG9jayk7DQo+ICAgDQo+ICAgCWlm
IChqb2IpDQo+IC0JCXNjaGVkLT5vcHMtPnRpbWVkb3V0X2pvYihqb2IpOw0KPiAtDQo+IC0Jc3Bp
bl9sb2NrKCZzY2hlZC0+am9iX2xpc3RfbG9jayk7DQo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShq
b2IsICZzY2hlZC0+cmluZ19taXJyb3JfbGlzdCwgbm9kZSkgew0KPiAtCQlzdHJ1Y3QgZHJtX3Nj
aGVkX2ZlbmNlICpmZW5jZSA9IGpvYi0+c19mZW5jZTsNCj4gLQ0KPiAtCQlpZiAoIWZlbmNlLT5w
YXJlbnQgfHwgIWxpc3RfZW1wdHkoJmZlbmNlLT5jYi5ub2RlKSkNCj4gLQkJCWNvbnRpbnVlOw0K
PiAtDQo+IC0JCXIgPSBkbWFfZmVuY2VfYWRkX2NhbGxiYWNrKGZlbmNlLT5wYXJlbnQsICZmZW5j
ZS0+Y2IsDQo+IC0JCQkJCSAgIGRybV9zY2hlZF9wcm9jZXNzX2pvYik7DQo+IC0JCWlmIChyKQ0K
PiAtCQkJZHJtX3NjaGVkX3Byb2Nlc3Nfam9iKGZlbmNlLT5wYXJlbnQsICZmZW5jZS0+Y2IpOw0K
PiAtDQo+IC1hbHJlYWR5X3NpZ25hbGVkOg0KPiAtCQk7DQo+IC0JfQ0KPiAtCXNwaW5fdW5sb2Nr
KCZzY2hlZC0+am9iX2xpc3RfbG9jayk7DQo+ICsJCWpvYi0+c2NoZWQtPm9wcy0+dGltZWRvdXRf
am9iKGpvYik7DQo+ICAgfQ0KPiAgIA0KPiAgIC8qKg0KDQo=
