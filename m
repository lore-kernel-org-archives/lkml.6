Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3FDECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0AA206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BoYuWw+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0AA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKICZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:25:12 -0500
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:57300
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeKICZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNPPmvB8JYwElZsHHHv54A1gmluCUlEA1Rs5IotHmgo=;
 b=BoYuWw+lyzxreG97aY3ctcleICQrgwiQ+fMF+vebZTzlYkBihzVMnDWj4gwnvCrPZuXsPSQ1oU9GASV6r/YzFEMZSURpUZ0kXi1YJrBKI2leyGyddqn3/fDGZZo1m3yvoAiKEnPQOiLrZLlFnyH8I/XwHt7NiERdSglmHLj02Mk=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1396.namprd12.prod.outlook.com (10.168.228.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 16:48:48 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 16:48:48 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
Thread-Topic: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
Thread-Index: AQHUd3y6io7m8AE8QUWtBmK5h9zRj6VGDBOAgAACrICAAAgXAA==
Date:   Thu, 8 Nov 2018 16:48:48 +0000
Message-ID: <da2b3215-9904-b7f6-4f45-4e5e4242fa12@amd.com>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-2-eric@anholt.net>
 <2f577af9-9ff7-4e9d-b198-02727a995393@amd.com> <875zx7o82m.fsf@anholt.net>
In-Reply-To: <875zx7o82m.fsf@anholt.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM5PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:203:51::22) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1396;20:VM9pXAA5SLbIItCPhBOAjl36lNc/wmitL1jOciUIj/JqZ0bBOvnydqp4SzHlI7iEM0DczrULBtDNVeu5LNAGIAK1wuY3W6GD+swKfX1O5J+kr4VwZHg2YT4V1mlW/tcx9nn05R1FgJEfPp/EO95c7q/K0yx7BojyXkZ+pKu5DxQo13bOzFiEnWWEtXVRmsfG7DK5QtFFCRo5JQpmGh4WAljGa819K7zBX/nOZy/4zwlIw+lYFLcreutcY37HG38P
x-ms-office365-filtering-correlation-id: 282a1e95-2536-4129-c9a7-08d6459a0dee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1396;
x-ms-traffictypediagnostic: BN6PR12MB1396:
x-microsoft-antispam-prvs: <BN6PR12MB13960D3C9FB3DDD70E6A70B283C50@BN6PR12MB1396.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1396;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1396;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(51234002)(97736004)(31686004)(14454004)(72206003)(6512007)(36756003)(316002)(2900100001)(93886005)(2501003)(53936002)(6246003)(99286004)(446003)(6436002)(14444005)(256004)(86362001)(6486002)(64126003)(71200400001)(25786009)(31696002)(65826007)(71190400001)(5660300001)(305945005)(186003)(4326008)(65956001)(7736002)(46003)(65806001)(39060400002)(478600001)(45080400002)(66574009)(8936002)(486006)(6116002)(54906003)(110136005)(52116002)(229853002)(2616005)(2906002)(58126008)(105586002)(106356001)(8676002)(102836004)(76176011)(81156014)(68736007)(476003)(11346002)(81166006)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1396;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: POa/bRPthFzAYMyoa/xl6oSpKWY9DDMoIitiOy52KWHDnvUGdsTnG2lQUgzVabUfdpc8yZVNEoV+4LQkaaoiMT4a64dUmJ71XtFn/i0oL/TTBl4m+Q20JEyRqtWJaUvjlZDM2vBKxV2Ygxnj2ZAYsPv/gDr4bVQFgn7MC0LnzSatbVfE2/rLGAMXzzawefnE/28oPkhTZjNY5eqcdgB2+W1SJkJzNBRAEf51Qx2cMNIOb36FJsSRJkhlst/8r4kn2AFoBH9YgiWL2j5JJRiRQ/IWdTVdQrQ4E7t4Ds/s8xFw5Mgf8xNdBrJReccGZ+goHR7VsJqS2jfMab0PVlXjoU2O/m7ulHOKw/LnzOznwJU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E896E5AE0E4114C85A3DFFC6F4B3C81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282a1e95-2536-4129-c9a7-08d6459a0dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 16:48:48.6491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTEuMTggdW0gMTc6MTkgc2NocmllYiBFcmljIEFuaG9sdDoNCj4gIktvZW5pZywgQ2hy
aXN0aWFuIiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiB3cml0ZXM6DQo+DQo+PiBBbSAwOC4x
MS4xOCB1bSAxNzowNCBzY2hyaWViIEVyaWMgQW5ob2x0Og0KPj4+IFRoaXMgcmV2ZXJ0cyBjb21t
aXQgMGVmZDJkMmY2OGNkNWRiZGRmNGVjZDk3NGMzMzEzMzI1N2QxNmE4ZS4gIEZpeGVzDQo+Pj4g
dGhpcyBmYWlsdXJlIGluIFYzRCBHUFUgcmVzZXQ6DQo+Pj4NCj4+PiBbIDE0MTguMjI3Nzk2XSBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVh
bCBhZGRyZXNzIDAwMDAwMDE4DQo+Pj4gWyAxNDE4LjIzNTk0N10gcGdkID0gZGM0YzU1Y2ENCj4+
PiBbIDE0MTguMjM4Njk1XSBbMDAwMDAwMThdICpwZ2Q9ODAwMDAwNDAwMDQwMDMsICpwbWQ9MDAw
MDAwMDANCj4+PiBbIDE0MTguMjQ0MTMyXSBJbnRlcm5hbCBlcnJvcjogT29wczogMjA2IFsjMV0g
U01QIEFSTQ0KPj4+IFsgMTQxOC4yNDg5MzRdIE1vZHVsZXMgbGlua2VkIGluOg0KPj4+IFsgMTQx
OC4yNTIwMDFdIENQVTogMCBQSUQ6IDEwMjUzIENvbW06IGt3b3JrZXIvMDowIE5vdCB0YWludGVk
IDQuMTkuMC1yYzYrICM0ODYNCj4+PiBbIDE0MTguMjU5MDU4XSBIYXJkd2FyZSBuYW1lOiBCcm9h
ZGNvbSBTVEIgKEZsYXR0ZW5lZCBEZXZpY2UgVHJlZSkNCj4+PiBbIDE0MTguMjY1MDAyXSBXb3Jr
cXVldWU6IGV2ZW50cyBkcm1fc2NoZWRfam9iX3RpbWVkb3V0DQo+Pj4gWyAxNDE4LjI2OTk4Nl0g
UEMgaXMgYXQgZG1hX2ZlbmNlX3JlbW92ZV9jYWxsYmFjaysweDgvMHg1MA0KPj4+IFsgMTQxOC4y
NzUyMThdIExSIGlzIGF0IGRybV9zY2hlZF9qb2JfdGltZWRvdXQrMHg0Yy8weDExOA0KPj4+IC4u
Lg0KPj4+IFsgMTQxOC40MTU4OTFdIFs8YzA4NmI3NTQ+XSAoZG1hX2ZlbmNlX3JlbW92ZV9jYWxs
YmFjaykgZnJvbSBbPGMwNmU3ZTZjPl0gKGRybV9zY2hlZF9qb2JfdGltZWRvdXQrMHg0Yy8weDEx
OCkNCj4+PiBbIDE0MTguNDI1NTcxXSBbPGMwNmU3ZTZjPl0gKGRybV9zY2hlZF9qb2JfdGltZWRv
dXQpIGZyb20gWzxjMDI0MjUwMD5dIChwcm9jZXNzX29uZV93b3JrKzB4MmM4LzB4N2JjKQ0KPj4+
IFsgMTQxOC40MzQ1NTJdIFs8YzAyNDI1MDA+XSAocHJvY2Vzc19vbmVfd29yaykgZnJvbSBbPGMw
MjQyYTM4Pl0gKHdvcmtlcl90aHJlYWQrMHg0NC8weDU5MCkNCj4+PiBbIDE0MTguNDQyNjYzXSBb
PGMwMjQyYTM4Pl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxjMDI0OWIxMD5dIChrdGhyZWFkKzB4
MTYwLzB4MTY4KQ0KPj4+IFsgMTQxOC40NTAwNzZdIFs8YzAyNDliMTA+XSAoa3RocmVhZCkgZnJv
bSBbPGMwMjAxMGFjPl0gKHJldF9mcm9tX2ZvcmsrMHgxNC8weDI4KQ0KPj4+DQo+Pj4gQ2M6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+PiBDYzogTmF5YW4g
RGVzaG11a2ggPG5heWFuMjZkZXNobXVraEBnbWFpbC5jb20+DQo+Pj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEFu
aG9sdCA8ZXJpY0BhbmhvbHQubmV0Pg0KPj4gV2VsbCBOQUsuIFRoZSBwcm9ibGVtIGhlcmUgaXMg
dGhhdCBmZW5jZS0+cGFyZW50IGlzIE5VTEwgd2hpY2ggaXMgbW9zdA0KPj4gbGlrZWx5IGNhdXNl
ZCBieSBhbiBpc3N1ZSBzb21ld2hlcmUgZWxzZS4NCj4+DQo+PiBXZSBjb3VsZCBlYXNpbHkgd29y
ayBhcm91bmQgdGhhdCB3aXRoIGFuIGV4dHJhIE5VTEwgY2hlY2ssIGJ1dCByZXZlcnRpbmcNCj4+
IHRoZSBwYXRjaCB3b3VsZCBicmVhayBHUFUgcmVjb3ZlcnkgYWdhaW4uDQo+IE15IEdQVSByZWNv
dmVyeSB3b3JrcyB3aXRoIHRoZSByZXZlcnQgYW5kIHJlbGlhYmx5IGRvZXNuJ3Qgd29yayB3aXRo
b3V0DQo+IGl0LCBzbyBteSBpZGVhIG9mICJicmVhayBHUFUgcmVjb3ZlcnkiIGlzIHRoZSBvcHBv
c2l0ZSBvZiB5b3Vycy4gIENhbg0KPiB5b3UgaGVscCBmaWd1cmUgb3V0IHdoYXQgaW4gdGhpcyBj
aGFuZ2UgYnJva2UgbXkgZHJpdmVyPw0KDQpUaGUgcHJvYmxlbSBpcyBoZXJlOg0KDQo+IC0JbGlz
dF9mb3JfZWFjaF9lbnRyeV9yZXZlcnNlKGpvYiwgJnNjaGVkLT5yaW5nX21pcnJvcl9saXN0LCBu
b2RlKSB7DQo+IC0JCXN0cnVjdCBkcm1fc2NoZWRfZmVuY2UgKmZlbmNlID0gam9iLT5zX2ZlbmNl
Ow0KPiAtDQo+IC0JCWlmICghZG1hX2ZlbmNlX3JlbW92ZV9jYWxsYmFjayhmZW5jZS0+cGFyZW50
LCAmZmVuY2UtPmNiKSkNCj4gLQkJCWdvdG8gYWxyZWFkeV9zaWduYWxlZDsNCg0KZG1hX2ZlbmNl
X3JlbW92ZV9jYWxsYmFjaygpIHdpbGwgZmF1bHQgaWYgZmVuY2UtPnBhcmVudCBpcyBOVUxMLiBB
IA0Kc2ltcGxlICJpZiAoIWZlbmNlLT5wYXJlbnQpIGNvbnRpbnVlOyIgc2hvdWxkIGJlIGVub3Vn
aCB0byB3b3JrIGFyb3VuZCB0aGF0Lg0KDQpCdXQgSSdtIG5vdCBzdXJlIGhvdyBleGFjdGx5IGZl
bmNlLT5wYXJlbnQgYmVjYW1lIE5VTEwgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpHb2luZyB0byBk
b3VibGUgY2hlY2sgdGhlIGNvZGUgb25jZSBtb3JlLA0KQ2hyaXN0aWFuLg0K
