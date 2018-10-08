Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3E72064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZnDTTDGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3E72064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIBhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:37:46 -0400
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:61159
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbeJIBhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd1FevEHgW14ZRu7NoHhq2SLMsUAIR7DS6FeDStab+s=;
 b=ZnDTTDGuCxfAb3e6ulYjhJxwgghB2s3f8LuDT51TjSdF7iCW2/+nePET3IpPmKTy/ap/5nltq7/WM/0Px9F9691OM2i1n9T+AefkGOuafICFetknar3G3jv37KGw2hhsDzTD/XQhMKSfdCii5jEmOJJ6yIoxnyHBz4ZJa7hkh+k=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1346.namprd12.prod.outlook.com (10.168.228.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 18:24:42 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:24:42 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXIN383FhdjKNYUusyRZ1bKnVkaUQVG0AgASscICAAFz5gIAABCqAgAAGWICAAB1qkIAAHWAAgAAKx0A=
Date:   Mon, 8 Oct 2018 18:24:41 +0000
Message-ID: <BN6PR12MB1809DC986E6B04F525581955F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008174102.GA11442@roeck-us.net>
In-Reply-To: <20181008174102.GA11442@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1346;20:VqLvlYNLKxh84e7a4kuGmanHwAiTTVT7MaG9plcoxAVtGQzlQdXZ0hBkn/j+mAZaibw3JHiTt3igiueabZ8nbFqXpLmVk4VRDfxPOrzg6IkpaJTyENyZgUbT0p5o7W5WEkbDquPNuUuS655O3tDIfAPGsRXjXrZmvJwavUqadfTFeNMJko6vLhkxaxIpym0Ywz48nCaU7klBMIYHpyJDKR15ADwqc9m9NillX1CBQan1VEa4uv1VxDw+znCTksvE
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(13464003)(52314003)(199004)(189003)(7696005)(99286004)(316002)(9686003)(55016002)(478600001)(6436002)(6116002)(33656002)(6506007)(53546011)(3846002)(2900100001)(2906002)(54906003)(5250100002)(229853002)(105586002)(26005)(76176011)(8936002)(97736004)(93886005)(102836004)(81156014)(81166006)(8676002)(186003)(74316002)(68736007)(256004)(14444005)(72206003)(11346002)(476003)(446003)(486006)(71190400001)(71200400001)(66574009)(53936002)(14454004)(66066001)(5660300001)(25786009)(305945005)(4326008)(6246003)(7736002)(6916009)(106356001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1346;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 66a5c332-0892-41a3-3650-08d62d4b50d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1346;
x-ms-traffictypediagnostic: BN6PR12MB1346:
x-microsoft-antispam-prvs: <BN6PR12MB1346E2FA4E96D7D0B5180E7EF7E60@BN6PR12MB1346.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(217544274631240)(209352067349851)(788757137089)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:BN6PR12MB1346;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1346;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 02tkEFehEwjgcBZPMO7/HaI0sQ/tLO84//ukABHCZBZdSVgIs05XpLAJi5SMtHLmWsgTzNEzRiVvcHCTm/8Fas+F1smlcKIsayWwHV0KmJYnWIcIqwgvpcaN1NrfI++d42bBblrFBgjr9voxKXBmzxhYfc1jsejpNOZ3ZLi6cGT6cmI4DoxM4EemtuhrdcUgRPTLCEwONamtKhamHDePAHy22lzuhDgIiV/O3kItJgM43moivrbOmR/phxFlovNRV9PeDJrjp5fSYSbR4yq/CmWXFN4i9QKu7jxJ9/fdSIotnUdk89/wEGmDloaEv9/dIvhdi08A4GVRSLMw6A2g7qitiZNS4cq8X8HiwcJtVX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a5c332-0892-41a3-3650-08d62d4b50d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:24:41.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9l
Y2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNCj4gU2VudDogTW9uZGF5
LCBPY3RvYmVyIDgsIDIwMTggMTo0MSBQTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IFBlbmcgSGFvDQo+IDxwZW5nLmhhbzJAenRlLmNvbS5jbj47IGFp
cmxpZWRAbGludXguaWU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFtZGdwdS9nbWMgOiBmaXggY29tcGlsZSB3YXJuaW5nDQo+
IA0KPiBPbiBNb24sIE9jdCAwOCwgMjAxOCBhdCAwMzo1NzowN1BNICswMDAwLCBEZXVjaGVyLCBB
bGV4YW5kZXIgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogR3VlbnRlciBSb2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVu
dGVyDQo+IFJvZWNrDQo+ID4gPiBTZW50OiBNb25kYXksIE9jdG9iZXIgOCwgMjAxOCAxMDoxMSBB
TQ0KPiA+ID4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
OyBQZW5nIEhhbw0KPiA+ID4gPHBlbmcuaGFvMkB6dGUuY29tLmNuPg0KPiA+ID4gQ2M6IGFpcmxp
ZWRAbGludXguaWU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRyaS0NCj4gPiA+IGRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IERldWNoZXIsDQo+ID4gPiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhbWRncHUvZ21jIDogZml4IGNvbXBpbGUgd2Fybmlu
Zw0KPiA+ID4NCj4gPiA+IE9uIDEwLzA4LzIwMTggMDY6NDcgQU0sIEtvZW5pZywgQ2hyaXN0aWFu
IHdyb3RlOg0KPiA+ID4gPiBBbSAwOC4xMC4yMDE4IHVtIDE1OjMzIHNjaHJpZWIgR3VlbnRlciBS
b2VjazoNCj4gPiA+ID4+IE9uIDEwLzA4LzIwMTggMDE6MDAgQU0sIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6DQo+ID4gPiA+Pj4gQW0gMDUuMTAuMjAxOCB1bSAxMDozOCBzY2hyaWViIEd1ZW50ZXIg
Um9lY2s6DQo+ID4gPiA+Pj4+IE9uIDEwLzA1LzIwMTggMDE6MTQgQU0sIEtvZW5pZywgQ2hyaXN0
aWFuIHdyb3RlOg0KPiA+ID4gPj4+Pj4gQW0gMDQuMTAuMjAxOCB1bSAyMDo1MiBzY2hyaWViIEd1
ZW50ZXIgUm9lY2s6DQo+ID4gPiA+Pj4+Pj4gSGksDQo+ID4gPiA+Pj4+Pj4NCj4gPiA+ID4+Pj4+
PiBPbiBGcmksIFNlcCAxNCwgMjAxOCBhdCAwNjowNTo1MlBNICswODAwLCBQZW5nIEhhbyB3cm90
ZToNCj4gPiA+ID4+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYzoN
Cj4gPiA+ID4+Pj4+Pj4gIMKgwqDCoMKgwqAgSW4gZnVuY3Rpb24g4oCYZ21jX3Y4XzBfcHJvY2Vz
c19pbnRlcnJ1cHTigJk6DQo+ID4gPiA+Pj4+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OF8wLmM6MTQ0NzoxMDoNCj4gPiA+ID4+Pj4+Pj4gIMKgwqDCoMKgwqAgd2FybmluZzog
bWlzc2luZyBicmFjZXMgYXJvdW5kIGluaXRpYWxpemVyDQo+ID4gPiA+Pj4+Pj4+IFstV21pc3Np
bmctYnJhY2VzXQ0KPiA+ID4gPj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQ
ZW5nIEhhbyA8cGVuZy5oYW8yQHp0ZS5jb20uY24+DQo+ID4gPiA+Pj4+Pj4gV2FzIHRoZXJlIGFu
eSBmZWVkYmFjayBvbiB0aGlzIHBhdGNoID8gVGhlIHByb2JsZW0gZG9lcw0KPiA+ID4gPj4+Pj4+
IGFmZmVjdCB1cywgYW5kIHdlJ2xsIG5lZWQgYSBmaXguDQo+ID4gPiA+Pj4+Pg0KPiA+ID4gPj4+
Pj4gV2VsbCBhcyBkaXNjdXNzZWQgdXNpbmcgInsgeyAwIH0gfSIgaXMgYXMgd3JvbmcgYXMgdXNp
bmcgInsgMCB9Ii4NCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+IEFoLCBzb3Jy
eSwgSSBtdXN0IGhhdmUgbWlzc2VkIHRoZSBkaXNjdXNzaW9uLg0KPiA+ID4gPj4+Pg0KPiA+ID4g
Pj4+PiBJdCBpcyBmb3Igc3VyZSBub3QgdGhlIGJlc3Qgc29sdXRpb24sIGJ1dCBhdCBsZWFzdCBp
dCBjb21waWxlcywNCj4gPiA+ID4+Pj4gYW5kIGl0IHNlZW1zIHRvIGJlIHByb2xpZmVyYXRpbmcu
DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBZZWFoLCBhbmQgZXhhY3RseSB0aGF0J3MgdGhlIHByb2Js
ZW0uIEFzIHRoZSBkaXNjdXNzaW9uIHNob3dlZA0KPiA+ID4gPj4+ICJ7IHsNCj4gPiA+ID4+PiAw
IH0gfSIgaXMgYnVnZ3kgYmVjYXVzZSBpdCB0ZWxscyB0aGUgY29tcGlsZXIgdG8gb25seSBpbml0
aWFsaXplDQo+ID4gPiA+Pj4gdGhlIGZpcnN0IG1lbWJlciBvZiB0aGUgc3RydWN0dXJlLCBidXQg
bm90IGFsbCBvZiBpdC4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IFRoYXQgaXMgaW5jb3JyZWN0IGFu
ZCByYXRoZXIgZGFuZ2Vyb3VzIGNhdXNlIGl0IGNhbiBsZWFkIHRvDQo+ID4gPiA+Pj4gdW5mb3Jl
c2VlbiByZXN1bHRzIGFuZCBzaG91bGQgcHJvYmFibHkgdHJpZ2dlciBhIHdhcm5pbmcuDQo+ID4g
PiA+Pj4NCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gJCBnaXQgZ3JlcCAieyAqeyAqMCAqfSAqfSIg
fCB3Yw0KPiA+ID4gPj4+PiAgwqDCoMKgIDE0NMKgwqDCoCAxMTgwwqDCoCAxMTgwMg0KPiA+ID4g
Pj4+PiAkIGdpdCBncmVwICJ7ICp7ICowICp9ICp9IiBkcml2ZXJzL2dwdS9kcm0vYW1kLyB8IHdj
DQo+ID4gPiA+Pj4+ICDCoMKgwqDCoCA1MMKgwqDCoMKgIDQ1OcKgwqDCoCA1MjM5DQo+ID4gPiA+
Pj4+DQo+ID4gPiA+Pj4+PiBXZSBzaG91bGQgZWl0aGVyIHVzZSBvbmx5ICJ7IH0iIG9yIGV2ZW4g
YmV0dGVyIG1ha2UgbmFpbHMgd2l0aA0KPiA+ID4gPj4+Pj4gaGVhZHMgYW5kIHVzZSBtZW1zZXQo
KS4NCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gSSdkIHJhdGhlciBsZWF2ZSBpdCB1cCB0byB0aGUg
Y29tcGlsZXIgdG8gZGVjaWRlIHdoYXQgaXMgbW9zdA0KPiA+ID4gPj4+PiBlZmZpY2llbnQuDQo+
ID4gPiA+Pj4NCj4gPiA+ID4+PiBBbmQgSSB3b3VsZCByYXRoZXIgcHJlZmVyIHRvIGhhdmUgYSB3
b3JraW5nIGRyaXZlciA6KQ0KPiA+ID4gPj4+DQo+ID4gPiA+Pg0KPiA+ID4gPj4gU28geyB9IGlz
bid0IGNvcnJlY3QgZWl0aGVyID8NCj4gPiA+ID4NCj4gPiA+ID4gWWVzLCBpbml0aWFsaXppbmcg
c3RydWN0dXJlcyB3aXRoIHsgfSBpcyBrbm93biB0byBiZSBwcm9ibGVtYXRpYyBhcyB3ZWxsLg0K
PiA+ID4gPg0KPiA+ID4gPiBJdCBkb2Vzbid0IG5lY2Vzc2FyeSBpbml0aWFsaXplIGFsbCBieXRl
cyB3aGVuIHlvdSBoYXZlIHBhZGRpbmcNCj4gPiA+ID4gY2F1c2luZyByYW5kb20gZmFpbHVyZXMg
d2hlbiBzdHJ1Y3R1cmVzIGFyZSBtZW1jbXAoKS4NCj4gPiA+ID4NCj4gPiA+ID4+DQo+ID4gPiA+
PiBPbmUgdGhpbmcgSSBmb3VuZCBtaXNzaW5nIGluIHRoZSBkaXNjdXNzaW9uIHdhcyB0aGUgcmVm
ZXJlbmNlIHRvDQo+ID4gPiA+PiB0aGUgQyBzdGFuZGFyZC4NCj4gPiA+ID4+IFRoZSBDOTkgc3Rh
bmRhcmQgc3RhdGVzIGluIHNlY3Rpb24gNi43LjggKEluaXRpYWxpemF0aW9uKSBjbGF1c2UgMTk6
DQo+ID4gPiA+PiAiLi4uIGFsbA0KPiA+ID4gPj4gc3Vib2JqZWN0cyB0aGF0IGFyZSBub3QgaW5p
dGlhbGl6ZWQgZXhwbGljaXRseSBzaGFsbCBiZQ0KPiA+ID4gPj4gaW5pdGlhbGl6ZWQgaW1wbGlj
aXRseSB0aGUgc2FtZSBhcyBvYmplY3RzIHRoYXQgaGF2ZSBzdGF0aWMgc3RvcmFnZQ0KPiBkdXJh
dGlvbiIuDQo+ID4gPiA+PiBDbGF1c2UgMjEgbWFrZXMgZnVydGhlciByZWZlcmVuY2UgdG8gcGFy
dGlhbCBpbml0aWFsaXphdGlvbiwNCj4gPiA+ID4+IHN1Z2dlc3RpbmcgdGhlIHNhbWUuIFZhcmlv
dXMgb25saW5lIHJlc291cmNlcywgaW5jbHVkaW5nIHRoZSBnY2MNCj4gPiA+ID4+IGRvY3VtZW50
YXRpb24sIGFsbCBzdGF0ZSB0aGUgc2FtZS4gSSBkb24ndCBmaW5kIGFueSByZWZlcmVuY2UgdG8N
Cj4gPiA+ID4+IGEgcGFydGlhbCBpbml0aWFsaXphdGlvbiB3aGljaCB3b3VsZCBsZWF2ZSBtZW1i
ZXJzIG9mIGEgc3RydWN0dXJlDQo+ID4gPiA+PiB1bmRlZmluZWQuIEl0IHdvdWxkIGJlIGludGVy
ZXN0aW5nIGZvciBtZSB0byB1bmRlcnN0YW5kIGhvdyBhbmQNCj4gPiA+ID4+IHdoeSB0aGlzIGRv
ZXMgbm90IGFwcGx5IGhlcmUuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gSW4gdGhpcyBjb250ZXh0LCBp
dCBpcyBpbnRlcmVzdGluZyB0aGF0IHRoZSBvdGhlciA0OCBpbnN0YW5jZXMgb2YNCj4gPiA+ID4+
IHRoZSB7IHsgMCB9IH0gaW5pdGlhbGl6YXRpb24gaW4gdGhlIHNhbWUgZHJpdmVyIGRvbid0IHJh
aXNlDQo+ID4gPiA+PiBzaW1pbGFyIGNvbmNlcm5zLCBub3Igc2VlbWVkIHRvIGhhdmUgY2F1c2Vk
IGFueSBvcGVyYXRpb25hbA0KPiBwcm9ibGVtcy4NCj4gPiA+ID4NCj4gPiA+ID4gRmVlbCBmcmVl
IHRvIHByb3ZpZGUgcGF0Y2hlcyB0byByZXBsYWNlIHRob3NlIHdpdGggbWVtc2V0KCkuDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gTm90IG1lLiBBcyBJIHNlZSBpdCwgdGhlIHByb2JsZW0sIGlmIGl0
IGV4aXN0cywgd291bGQgYmUgYSB2aW9sYXRpb24NCj4gPiA+IG9mIHRoZSBDIHN0YW5kYXJkLiBJ
IGRvbid0IGJlbGlldmUgaGFja2luZyBhcm91bmQgYmFkIEMgY29tcGlsZXJzLiBJDQo+ID4gPiB3
b3VsZCByYXRoZXIgYmxhY2tsaXN0IHN1Y2ggY29tcGlsZXJzLg0KPiA+ID4NCj4gPiA+ID4+DQo+
ID4gPiA+PiBBbnl3YXksIEkgZml4ZWQgdXAgdGhlIGNvZGUgaW4gb3VyIHRyZWUgKHdpdGggeyB9
KSwgc28gSSdsbCBsZWF2ZQ0KPiA+ID4gPj4gaXQgdXAgdG8geW91IGZvbGtzIHRvIGRlY2lkZSB3
aGF0IGlmIGFueXRoaW5nIHRvIGRvIGFib3V0IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBXZWxsIGNv
bnNpZGVyaW5nIHRoZSBrbm93biBwcm9ibGVtcyB3aXRoIHt9IGluaXRpYWxpemF0aW9uIEknbQ0K
PiA+ID4gPiBjZXJ0YWlubHkgcmVqZWN0aW5nIGFsbCBwYXRjaGVzIHdoaWNoIHR1cm5zIG1lbXNl
dCgpIGludG8ge30uDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gUGxlYXNlIHBvaW50IG1lIHRvIHNw
ZWNpZmljIGluc3RhbmNlcyBvZiB0aGlzIHByb2JsZW0uDQo+ID4NCj4gPiBJIHRoaW5rIHRoZXJl
IGFyZSBhIG51bWJlciBvZiBwbGFjZXMgaW4gREMgKGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eSkNCj4gd2hlcmUgd2UgYXBwbGllZCB0aGUgb3JpZ2luYWwgcHJvcG9zZWQgc29sdXRpb24gYmVm
b3JlIHJlYWxpemluZyB0aGF0IGl0DQo+IHdvdWxkIG9ubHkgaW5pdGlhbGl6ZSB0aGUgZmlyc3Qg
ZWxlbWVudC4gIEl0IHdvdWxkIGJlIG5pY2UgdG8gZ2V0IHRoZW0gZml4ZWQgdXAuDQo+ID4NCj4g
DQo+IEkgdGhpbmsgdGhpcyBpcyBmYWN0dWFsbHkgaW5jb3JyZWN0LiBXaGF0IHlvdSBtaWdodCB3
YW50IHRvIHRyeSB0byBzYXkgaXMgdGhhdA0KPiBwYWRkaW5nIG1heSBub3QgYmUgaW5pdGlhbGl6
ZWQgd2hlbiB1c2luZyBhbnl0aGluZyBidXQgbWVtc2V0KCkuDQo+IEJ1dCB0aGF0IGlzIGEgZGlm
ZmVyZW50IHByb2JsZW0uDQo+DQoNCkkganVzdCBtZWFudCB0aGF0IHRoZXJlIGFyZSBhIG51bWJl
ciBvZiBwbGFjZXMgd2VyZSB3YXJuaW5nIGZpeCBwYXRjaGVzIGdvdCBhcHBsaWVkIHRoYXQgZGlk
IHRoZSBzYW1lIHRoaW5nIHRoaXMgcGF0Y2ggYXR0ZW1wdGVkIHRvIGRvICggcmVwbGFjZSB7IDAg
fSB3aXRoIHsgeyAwIH0gfSkgd2hpY2ggbWF5IGhhdmUgaW50cm9kdWNlZCBzdWJ0bGUgaXNzdWVz
Lg0KDQpBbGV4DQoNCg==
