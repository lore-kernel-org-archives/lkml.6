Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2F32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bsND2ktD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2F32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJHXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:09:48 -0400
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:2080
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbeJHXJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkCu5zM3pSE58xZ4zO6wLpvKlDuFierCP6ucB2zWoYk=;
 b=bsND2ktDvJceuaArxVpSGSqygM6WfEWS7Il1Bu2KkvG+AV+WAZi7r+kr5Sphta6vyHn3f3UpvMIuJx+I2gZ8+SmGSADN4/jfh8je2vRA5a+HX8dCNIsCbFizZxOkNRBdYQ8TrzQ9xZiAn7flbuoIQgXJapGKtqMuxQXAjD3GlrU=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1492.namprd12.prod.outlook.com (10.172.24.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Mon, 8 Oct 2018 15:57:08 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 15:57:07 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXIN383FhdjKNYUusyRZ1bKnVkaUQVG0AgASscICAAFz5gIAABCqAgAAGWICAAB1qkA==
Date:   Mon, 8 Oct 2018 15:57:07 +0000
Message-ID: <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
In-Reply-To: <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1492;20:RyjdxC4H8DWZnpzhyK0QSCS+CIEWN8cI936FsbcQJAs+1iylN4rlewwjRNjmWvO0H8PlOARFAXUsnUZVvh1DAytVS/N+DJkouVpsCo0g3WeB5nr4Q+hu6CS6dGRTE4CjLS8G7Be3VujW49m5FsMsWYHjJTIkCb0K16/ulVM56QyAMRLFVubCOp62xHsc13GKfBX258c67oz4j8LMJ0sMTCjnbYkPmmnX7xyeoxgNebFUzRLdISxSwJ2VG/92C9uY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(13464003)(199004)(189003)(52314003)(81156014)(81166006)(33656002)(8936002)(5250100002)(8676002)(5660300001)(229853002)(55016002)(6436002)(110136005)(9686003)(93886005)(68736007)(256004)(25786009)(54906003)(4326008)(105586002)(14444005)(53936002)(106356001)(316002)(6246003)(3846002)(6116002)(14454004)(99286004)(478600001)(2906002)(72206003)(86362001)(26005)(76176011)(97736004)(66066001)(7696005)(102836004)(486006)(74316002)(11346002)(6506007)(53546011)(476003)(186003)(71200400001)(71190400001)(305945005)(446003)(2900100001)(66574009)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1492;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 5a25cf35-c135-4853-d52b-08d62d36b2ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1492;
x-ms-traffictypediagnostic: BN6PR12MB1492:
x-microsoft-antispam-prvs: <BN6PR12MB149245AD673A7E75D9C1B552F7E60@BN6PR12MB1492.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(217544274631240)(209352067349851)(788757137089)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR12MB1492;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1492;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ghuRHU9/PNeFNvfaPfardnN1Ey/paJNlNW/OOe8VK00zYsj+1xbj6Rg6GSED0vozlIRluUNgGVg34pj7vcRbE6pSoXo1BdHcDbfA52OGrT99Si8QdoIGwHVYLkbthSulPmNmooSln9CjlYrPc5K6nfYV9rm8NURwHbgQqhRSUwurxzab/pQfOtV4Xnr6KfYKTyT9hd6i4d4ZspgZIGYo1pbyXmc60iSat+2X6CYYUaxYbkUf3dDLl9YfKkb6pPYo5UvltW6YG4wfSy9+F1MM3UqcjaiGpj3grfhgsCPm2cUSmJ0xgKyE8Q4etLve12yo5UjHXYT3gIg0OwUobgvqc/sOKFfLoLpU4DXasFQkoVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a25cf35-c135-4853-d52b-08d62d36b2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 15:57:07.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9l
Y2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNCj4gU2VudDogTW9uZGF5
LCBPY3RvYmVyIDgsIDIwMTggMTA6MTEgQU0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBQZW5nIEhhbw0KPiA8cGVuZy5oYW8yQHp0ZS5jb20uY24+
DQo+IENjOiBhaXJsaWVkQGxpbnV4LmllOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBk
cmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IERldWNoZXIsDQo+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYW1kZ3B1L2dtYyA6IGZpeCBjb21waWxlIHdhcm5p
bmcNCj4gDQo+IE9uIDEwLzA4LzIwMTggMDY6NDcgQU0sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3Rl
Og0KPiA+IEFtIDA4LjEwLjIwMTggdW0gMTU6MzMgc2NocmllYiBHdWVudGVyIFJvZWNrOg0KPiA+
PiBPbiAxMC8wOC8yMDE4IDAxOjAwIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+Pj4g
QW0gMDUuMTAuMjAxOCB1bSAxMDozOCBzY2hyaWViIEd1ZW50ZXIgUm9lY2s6DQo+ID4+Pj4gT24g
MTAvMDUvMjAxOCAwMToxNCBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+ID4+Pj4+IEFt
IDA0LjEwLjIwMTggdW0gMjA6NTIgc2NocmllYiBHdWVudGVyIFJvZWNrOg0KPiA+Pj4+Pj4gSGks
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gRnJpLCBTZXAgMTQsIDIwMTggYXQgMDY6MDU6NTJQTSAr
MDgwMCwgUGVuZyBIYW8gd3JvdGU6DQo+ID4+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y4XzAuYzoNCj4gPj4+Pj4+PiAgwqDCoMKgwqDCoCBJbiBmdW5jdGlvbiDigJhnbWNf
djhfMF9wcm9jZXNzX2ludGVycnVwdOKAmToNCj4gPj4+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjhfMC5jOjE0NDc6MTA6DQo+ID4+Pj4+Pj4gIMKgwqDCoMKgwqAgd2Fybmlu
ZzogbWlzc2luZyBicmFjZXMgYXJvdW5kIGluaXRpYWxpemVyDQo+ID4+Pj4+Pj4gWy1XbWlzc2lu
Zy1icmFjZXNdDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhbyA8
cGVuZy5oYW8yQHp0ZS5jb20uY24+DQo+ID4+Pj4+PiBXYXMgdGhlcmUgYW55IGZlZWRiYWNrIG9u
IHRoaXMgcGF0Y2ggPyBUaGUgcHJvYmxlbSBkb2VzIGFmZmVjdA0KPiA+Pj4+Pj4gdXMsIGFuZCB3
ZSdsbCBuZWVkIGEgZml4Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBXZWxsIGFzIGRpc2N1c3NlZCB1c2lu
ZyAieyB7IDAgfSB9IiBpcyBhcyB3cm9uZyBhcyB1c2luZyAieyAwIH0iLg0KPiA+Pj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4gQWgsIHNvcnJ5LCBJIG11c3QgaGF2ZSBtaXNzZWQgdGhlIGRpc2N1c3Npb24u
DQo+ID4+Pj4NCj4gPj4+PiBJdCBpcyBmb3Igc3VyZSBub3QgdGhlIGJlc3Qgc29sdXRpb24sIGJ1
dCBhdCBsZWFzdCBpdCBjb21waWxlcywgYW5kDQo+ID4+Pj4gaXQgc2VlbXMgdG8gYmUgcHJvbGlm
ZXJhdGluZy4NCj4gPj4+DQo+ID4+PiBZZWFoLCBhbmQgZXhhY3RseSB0aGF0J3MgdGhlIHByb2Js
ZW0uIEFzIHRoZSBkaXNjdXNzaW9uIHNob3dlZCAieyB7DQo+ID4+PiAwIH0gfSIgaXMgYnVnZ3kg
YmVjYXVzZSBpdCB0ZWxscyB0aGUgY29tcGlsZXIgdG8gb25seSBpbml0aWFsaXplIHRoZQ0KPiA+
Pj4gZmlyc3QgbWVtYmVyIG9mIHRoZSBzdHJ1Y3R1cmUsIGJ1dCBub3QgYWxsIG9mIGl0Lg0KPiA+
Pj4NCj4gPj4+IFRoYXQgaXMgaW5jb3JyZWN0IGFuZCByYXRoZXIgZGFuZ2Vyb3VzIGNhdXNlIGl0
IGNhbiBsZWFkIHRvDQo+ID4+PiB1bmZvcmVzZWVuIHJlc3VsdHMgYW5kIHNob3VsZCBwcm9iYWJs
eSB0cmlnZ2VyIGEgd2FybmluZy4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiAkIGdpdCBncmVwICJ7
ICp7ICowICp9ICp9IiB8IHdjDQo+ID4+Pj4gIMKgwqDCoCAxNDTCoMKgwqAgMTE4MMKgwqAgMTE4
MDINCj4gPj4+PiAkIGdpdCBncmVwICJ7ICp7ICowICp9ICp9IiBkcml2ZXJzL2dwdS9kcm0vYW1k
LyB8IHdjDQo+ID4+Pj4gIMKgwqDCoMKgIDUwwqDCoMKgwqAgNDU5wqDCoMKgIDUyMzkNCj4gPj4+
Pg0KPiA+Pj4+PiBXZSBzaG91bGQgZWl0aGVyIHVzZSBvbmx5ICJ7IH0iIG9yIGV2ZW4gYmV0dGVy
IG1ha2UgbmFpbHMgd2l0aA0KPiA+Pj4+PiBoZWFkcyBhbmQgdXNlIG1lbXNldCgpLg0KPiA+Pj4+
DQo+ID4+Pj4gSSdkIHJhdGhlciBsZWF2ZSBpdCB1cCB0byB0aGUgY29tcGlsZXIgdG8gZGVjaWRl
IHdoYXQgaXMgbW9zdA0KPiA+Pj4+IGVmZmljaWVudC4NCj4gPj4+DQo+ID4+PiBBbmQgSSB3b3Vs
ZCByYXRoZXIgcHJlZmVyIHRvIGhhdmUgYSB3b3JraW5nIGRyaXZlciA6KQ0KPiA+Pj4NCj4gPj4N
Cj4gPj4gU28geyB9IGlzbid0IGNvcnJlY3QgZWl0aGVyID8NCj4gPg0KPiA+IFllcywgaW5pdGlh
bGl6aW5nIHN0cnVjdHVyZXMgd2l0aCB7IH0gaXMga25vd24gdG8gYmUgcHJvYmxlbWF0aWMgYXMg
d2VsbC4NCj4gPg0KPiA+IEl0IGRvZXNuJ3QgbmVjZXNzYXJ5IGluaXRpYWxpemUgYWxsIGJ5dGVz
IHdoZW4geW91IGhhdmUgcGFkZGluZw0KPiA+IGNhdXNpbmcgcmFuZG9tIGZhaWx1cmVzIHdoZW4g
c3RydWN0dXJlcyBhcmUgbWVtY21wKCkuDQo+ID4NCj4gPj4NCj4gPj4gT25lIHRoaW5nIEkgZm91
bmQgbWlzc2luZyBpbiB0aGUgZGlzY3Vzc2lvbiB3YXMgdGhlIHJlZmVyZW5jZSB0byB0aGUNCj4g
Pj4gQyBzdGFuZGFyZC4NCj4gPj4gVGhlIEM5OSBzdGFuZGFyZCBzdGF0ZXMgaW4gc2VjdGlvbiA2
LjcuOCAoSW5pdGlhbGl6YXRpb24pIGNsYXVzZSAxOToNCj4gPj4gIi4uLiBhbGwNCj4gPj4gc3Vi
b2JqZWN0cyB0aGF0IGFyZSBub3QgaW5pdGlhbGl6ZWQgZXhwbGljaXRseSBzaGFsbCBiZSBpbml0
aWFsaXplZA0KPiA+PiBpbXBsaWNpdGx5IHRoZSBzYW1lIGFzIG9iamVjdHMgdGhhdCBoYXZlIHN0
YXRpYyBzdG9yYWdlIGR1cmF0aW9uIi4NCj4gPj4gQ2xhdXNlIDIxIG1ha2VzIGZ1cnRoZXIgcmVm
ZXJlbmNlIHRvIHBhcnRpYWwgaW5pdGlhbGl6YXRpb24sDQo+ID4+IHN1Z2dlc3RpbmcgdGhlIHNh
bWUuIFZhcmlvdXMgb25saW5lIHJlc291cmNlcywgaW5jbHVkaW5nIHRoZSBnY2MNCj4gPj4gZG9j
dW1lbnRhdGlvbiwgYWxsIHN0YXRlIHRoZSBzYW1lLiBJIGRvbid0IGZpbmQgYW55IHJlZmVyZW5j
ZSB0byBhDQo+ID4+IHBhcnRpYWwgaW5pdGlhbGl6YXRpb24gd2hpY2ggd291bGQgbGVhdmUgbWVt
YmVycyBvZiBhIHN0cnVjdHVyZQ0KPiA+PiB1bmRlZmluZWQuIEl0IHdvdWxkIGJlIGludGVyZXN0
aW5nIGZvciBtZSB0byB1bmRlcnN0YW5kIGhvdyBhbmQgd2h5DQo+ID4+IHRoaXMgZG9lcyBub3Qg
YXBwbHkgaGVyZS4NCj4gPj4NCj4gPj4gSW4gdGhpcyBjb250ZXh0LCBpdCBpcyBpbnRlcmVzdGlu
ZyB0aGF0IHRoZSBvdGhlciA0OCBpbnN0YW5jZXMgb2YgdGhlDQo+ID4+IHsgeyAwIH0gfSBpbml0
aWFsaXphdGlvbiBpbiB0aGUgc2FtZSBkcml2ZXIgZG9uJ3QgcmFpc2Ugc2ltaWxhcg0KPiA+PiBj
b25jZXJucywgbm9yIHNlZW1lZCB0byBoYXZlIGNhdXNlZCBhbnkgb3BlcmF0aW9uYWwgcHJvYmxl
bXMuDQo+ID4NCj4gPiBGZWVsIGZyZWUgdG8gcHJvdmlkZSBwYXRjaGVzIHRvIHJlcGxhY2UgdGhv
c2Ugd2l0aCBtZW1zZXQoKS4NCj4gPg0KPiANCj4gTm90IG1lLiBBcyBJIHNlZSBpdCwgdGhlIHBy
b2JsZW0sIGlmIGl0IGV4aXN0cywgd291bGQgYmUgYSB2aW9sYXRpb24gb2YgdGhlIEMNCj4gc3Rh
bmRhcmQuIEkgZG9uJ3QgYmVsaWV2ZSBoYWNraW5nIGFyb3VuZCBiYWQgQyBjb21waWxlcnMuIEkg
d291bGQgcmF0aGVyDQo+IGJsYWNrbGlzdCBzdWNoIGNvbXBpbGVycy4NCj4gDQo+ID4+DQo+ID4+
IEFueXdheSwgSSBmaXhlZCB1cCB0aGUgY29kZSBpbiBvdXIgdHJlZSAod2l0aCB7IH0pLCBzbyBJ
J2xsIGxlYXZlIGl0DQo+ID4+IHVwIHRvIHlvdSBmb2xrcyB0byBkZWNpZGUgd2hhdCBpZiBhbnl0
aGluZyB0byBkbyBhYm91dCBpdC4NCj4gPg0KPiA+IFdlbGwgY29uc2lkZXJpbmcgdGhlIGtub3du
IHByb2JsZW1zIHdpdGgge30gaW5pdGlhbGl6YXRpb24gSSdtDQo+ID4gY2VydGFpbmx5IHJlamVj
dGluZyBhbGwgcGF0Y2hlcyB3aGljaCB0dXJucyBtZW1zZXQoKSBpbnRvIHt9Lg0KPiA+DQo+IA0K
PiBQbGVhc2UgcG9pbnQgbWUgdG8gc3BlY2lmaWMgaW5zdGFuY2VzIG9mIHRoaXMgcHJvYmxlbS4N
Cg0KSSB0aGluayB0aGVyZSBhcmUgYSBudW1iZXIgb2YgcGxhY2VzIGluIERDIChkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkpIHdoZXJlIHdlIGFwcGxpZWQgdGhlIG9yaWdpbmFsIHByb3Bvc2Vk
IHNvbHV0aW9uIGJlZm9yZSByZWFsaXppbmcgdGhhdCBpdCB3b3VsZCBvbmx5IGluaXRpYWxpemUg
dGhlIGZpcnN0IGVsZW1lbnQuICBJdCB3b3VsZCBiZSBuaWNlIHRvIGdldCB0aGVtIGZpeGVkIHVw
Lg0KDQpBbGV4DQoNCg==
