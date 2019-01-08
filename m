Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64552C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC8206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pvpkdiLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfAHOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:01:51 -0500
Received: from mail-eopbgr820043.outbound.protection.outlook.com ([40.107.82.43]:42592
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbfAHOBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGOAKKVwvygq3A4PSWQoffwPyEAvuGtJl8YpWVsHqRY=;
 b=pvpkdiLfmKflGv/hB9Zfx+daZdUKDTWUprzpdoZGbBMr2zKca5Zz/TCTk7V/Y0eMe4P3SYPU1qrCY+FsjYJdJ3bYmtKUV4cYGoiq6ESQ+rKJfF/t0oPy9SxAhtwf2BjbeDopUnKwAyHb05v2j+xtOZ1fpg8kTbI+OzIbW/MMxXI=
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (52.132.194.151) by
 SN1PR12MB2397.namprd12.prod.outlook.com (52.132.195.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 14:01:45 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::2d91:d969:bbf9:ea3f]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::2d91:d969:bbf9:ea3f%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 14:01:45 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Thread-Topic: linux-next: build failure after merge of the drm-misc tree
Thread-Index: AQHUpubjnKQUhNhscEiWXDJSTdDdgqWlDPEAgABangA=
Date:   Tue, 8 Jan 2019 14:01:45 +0000
Message-ID: <a0c98733-09fb-f589-7aa5-a4ec608de332@amd.com>
References: <20190108111230.2dd3abd9@canb.auug.org.au>
 <20190108083722.GQ21184@phenom.ffwll.local>
In-Reply-To: <20190108083722.GQ21184@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To SN1PR12MB2382.namprd12.prod.outlook.com
 (2603:10b6:802:25::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2397;20:gwG0NLw2MhAyJgKWT32PItmenaEJnfEWbCqQFMWUljVPe4sny85FRnaQt1RSLUGoWv9AQuqzeZ6HmcM0+DzrhXtBWmQaLS7K++FbV2FCeP2GE/8oKAs46iK/OgaQYJp4925sINDvbcoWLv2LOoq83qXkgS7usRg5vl3ZzaKwsUEKiPDM9lomXU3bY96EfNh8smLm5p2wLcP7Z3V+yCjDcd+0W4v0eEhBFz3dcoHSztA+44I5PtEPFPYG5E3iNuns
x-ms-office365-filtering-correlation-id: 15aef456-cc82-46d2-e0a2-08d67571d2e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2397;
x-ms-traffictypediagnostic: SN1PR12MB2397:
x-microsoft-antispam-prvs: <SN1PR12MB2397033EB02A21692F593894EC8A0@SN1PR12MB2397.namprd12.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(53754006)(36756003)(6512007)(6306002)(14454004)(39060400002)(31686004)(478600001)(25786009)(81156014)(81166006)(8676002)(53936002)(6246003)(105586002)(6486002)(106356001)(8936002)(6436002)(5660300001)(72206003)(229853002)(305945005)(7736002)(966005)(52116002)(256004)(86362001)(68736007)(110136005)(2906002)(2616005)(316002)(476003)(26005)(76176011)(97736004)(6506007)(3846002)(386003)(71190400001)(14444005)(66066001)(186003)(11346002)(486006)(53546011)(31696002)(99286004)(446003)(102836004)(6636002)(6116002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2397;H:SN1PR12MB2382.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wbYikp9zP9vqXxkhJ5ZLrxirZCVdiB6yi/kl+yF5XrAWziUX9XchYEGK7cmWgjqo4KkU+xPXzJFTo7JFTyb4N2kQXq3xVdlqdluQzDJymJ24aeMYE5uga0KgSAVDYyLVi74cilj+CNZJX2Om/A6eer7bV7CAIfBa3vOV2bG03DnhMaZuxhbGmLtXRmbcktecg3vVMXn86DpZGKxhTEkAP8vWZHqetmnkPhJAjliIeOK5FQg9+Yo3UK83xYHVknIx6ShvMoHnScuMh6J5Q1yOf3aG4ySWQC72dQ2vcSUWqQ+OXnOGUuyVujbkL7at9Lf8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <63C6C9B05D5C8248B2A8C695E67E60F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15aef456-cc82-46d2-e0a2-08d67571d2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:01:45.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS84LzE5IDM6MzcgQU0sIERhbmllbCBWZXR0ZXIgd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDA4
LCAyMDE5IGF0IDExOjEyOjQxQU0gKzExMDAsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+PiBI
aSBhbGwsDQo+Pg0KPj4gQWZ0ZXIgbWVyZ2luZyB0aGUgZHJtLW1pc2MgdHJlZSwgdG9kYXkncyBs
aW51eC1uZXh0IGJ1aWxkICh4ODZfNjQNCj4+IGFsbG1vZGNvbmZpZykgZmFpbGVkIGxpa2UgdGhp
czoNCj4+DQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYzogSW4gZnVuY3Rpb24gJ2FtZGdwdV9kbV9tb2RlX2NvbmZpZ19pbml0JzoN
Cj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jOjE2OTU6MzA6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDEgb2YgJ2RybV9hdG9taWNf
cHJpdmF0ZV9vYmpfaW5pdCcgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9y
PWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQ0KPj4gICAgZHJtX2F0b21pY19wcml2YXRlX29i
al9pbml0KCZhZGV2LT5kbS5hdG9taWNfb2JqLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5j
bHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaDoyNywNCj4+ICAgICAgICAgICAgICAgICAgIGZy
b20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaDo0NiwNCj4+ICAgICAg
ICAgICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6NTcs
DQo+PiAgICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjM0Og0KPj4gaW5jbHVkZS9kcm0vZHJtX2F0
b21pYy5oOjQzNzo1Mzogbm90ZTogZXhwZWN0ZWQgJ3N0cnVjdCBkcm1fZGV2aWNlIConIGJ1dCBh
cmd1bWVudCBpcyBvZiB0eXBlICdzdHJ1Y3QgZHJtX3ByaXZhdGVfb2JqIConDQo+PiAgIHZvaWQg
ZHJtX2F0b21pY19wcml2YXRlX29ial9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5efn4N
Cj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jOjE2OTY6OTogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiAnZHJtX2F0b21pY19w
cml2YXRlX29ial9pbml0JyBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3I9
aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdDQo+PiAgICAgICAgICAgJnN0YXRlLT5iYXNlLA0K
Pj4gICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1
ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVyLmg6MjcsDQo+PiAgICAgICAgICAgICAgICAgICBmcm9t
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmg6NDYsDQo+PiAgICAgICAg
ICAgICAgICAgICBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oOjU3LA0K
Pj4gICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzozNDoNCj4+IGluY2x1ZGUvZHJtL2RybV9hdG9t
aWMuaDo0Mzg6MzA6IG5vdGU6IGV4cGVjdGVkICdzdHJ1Y3QgZHJtX3ByaXZhdGVfb2JqIConIGJ1
dCBhcmd1bWVudCBpcyBvZiB0eXBlICdzdHJ1Y3QgZHJtX3ByaXZhdGVfc3RhdGUgKicNCj4+ICAg
ICAgICBzdHJ1Y3QgZHJtX3ByaXZhdGVfb2JqICpvYmosDQo+PiAgICAgICAgfn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Xn5+DQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYzoxNjk3Ojk6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDMg
b2YgJ2RybV9hdG9taWNfcHJpdmF0ZV9vYmpfaW5pdCcgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRl
ciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQ0KPj4gICAgICAgICAg
ICZkbV9hdG9taWNfc3RhdGVfZnVuY3MpOw0KPj4gICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2RybS9kcm1fZHBfbXN0X2hl
bHBlci5oOjI3LA0KPj4gICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfbW9kZS5oOjQ2LA0KPj4gICAgICAgICAgICAgICAgICAgZnJvbSBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaDo1NywNCj4+ICAgICAgICAgICAgICAgICAg
IGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmM6MzQ6DQo+PiBpbmNsdWRlL2RybS9kcm1fYXRvbWljLmg6NDM5OjMyOiBub3RlOiBl
eHBlY3RlZCAnc3RydWN0IGRybV9wcml2YXRlX3N0YXRlIConIGJ1dCBhcmd1bWVudCBpcyBvZiB0
eXBlICdzdHJ1Y3QgZHJtX3ByaXZhdGVfc3RhdGVfZnVuY3MgKicNCj4+ICAgICAgICBzdHJ1Y3Qg
ZHJtX3ByaXZhdGVfc3RhdGUgKnN0YXRlLA0KPj4gICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+Xn5+fn4NCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jOjE2OTU6MjogZXJyb3I6IHRvbyBmZXcgYXJndW1lbnRzIHRvIGZ1
bmN0aW9uICdkcm1fYXRvbWljX3ByaXZhdGVfb2JqX2luaXQnDQo+PiAgICBkcm1fYXRvbWljX3By
aXZhdGVfb2JqX2luaXQoJmFkZXYtPmRtLmF0b21pY19vYmosDQo+PiAgICBefn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2RybS9kcm1f
ZHBfbXN0X2hlbHBlci5oOjI3LA0KPj4gICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oOjQ2LA0KPj4gICAgICAgICAgICAgICAgICAg
ZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaDo1NywNCj4+ICAgICAgICAg
ICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmM6MzQ6DQo+PiBpbmNsdWRlL2RybS9kcm1fYXRvbWljLmg6NDM3OjY6
IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4+ICAgdm9pZCBkcm1fYXRvbWljX3ByaXZhdGVfb2JqX2lu
aXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4+ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4+DQo+PiBDYXVzZWQgYnkgY29tbWl0DQo+Pg0KPj4gICAgYjk2MmExMjA1MGEz
ICgiZHJtL2F0b21pYzogaW50ZWdyYXRlIG1vZGVzZXQgbG9jayB3aXRoIHByaXZhdGUgb2JqZWN0
cyIpDQo+Pg0KPj4gaW50ZXJhY3Rpbmcgd2l0aCBjb21taXQNCj4+DQo+PiAgICBlYjNkYzg5Nzg1
OTYgKCJkcm0vYW1kL2Rpc3BsYXk6IFVzZSBwcml2YXRlIG9iaiBoZWxwZXJzIGZvciBkbV9hdG9t
aWNfc3RhdGUiKQ0KPj4NCj4+IGZyb20gTGludXMnIHRyZWUgKG1lcmdlZCBkdXJpbmcgdGhlIG1l
cmdlIHdpbmRvdykuDQo+Pg0KPj4gSXRzIG5vdCBvYnZpb3VzIGhvdyB0byBmaXggdGhpcyB1cCwg
c28gSSBoYXZlIHVzZWQgdGhlIGRybS1taXNjIHRyZWUNCj4+IGZyb20gbmV4dC0yMDE5MDEwNyBm
b3IgdG9kYXkuDQo+IA0KPiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL2RybS10aXAvdHJl
ZS9maXh1cHMvZHJtLW1pc2MtbmV4dC5wYXRjaD9oPXJlcmVyZS1jYWNoZQ0KPiANCj4gaXMgdGhl
IGZpeHVwIHlvdSB3YW50LiBTaG91bGQgZ2V0IGJha2VkIGludG8gZHJtLW5leHQgYW55IG1vbWVu
dCwgc2luY2UNCj4gdGhlIGZpcnN0IGRybS1taXNjLW5leHQgcHVsbCBpcyBhbHJlYWR5IG91dC4N
Cj4gLURhbmllbA0KPg0KUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4NCg0KVGhhbmtzLCB0aGF0IGxpbmVzIHVwIHdpdGggdGhlIG90
aGVyIGRyaXZlciBmaXhlcyB0aGF0IHBhdGNoIGFkZGVkLg0KDQpJIG1pc3NlZCB0aGF0IHNlcmll
cyB3aGVuIEkgd2FzIGRldmVsb3BpbmcgdGhlIHByaXZhdGUgc3RhdGUgb2JqZWN0IA0KcGF0Y2gg
Zm9yIGFtZGdwdS4NCg0KSSdsbCBzdGlsbCBuZWVkIHRvIHJlbW92ZSBvdXIgZXh0cmEgbG9jayBz
aW5jZSB0aGUgb2JqZWN0cyBub3cgaGF2ZSANCnRoZWlyIG93biwgYnV0IHRoYXQgY2FuIGNvbWUg
bGF0ZXIgaW4gYW5vdGhlciBub24tZml4dXAgcGF0Y2guDQoNCk5pY2hvbGFzIEthemxhdXNrYXMN
Cg==
