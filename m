Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCFC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163320811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E163320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeLLVPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:15:16 -0500
Received: from mail-eopbgr720082.outbound.protection.outlook.com ([40.107.72.82]:49818
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbeLLVPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRk61jUcz7JrsgC7p0QfC/+7cR2VNqLMqhA+sMqaxi8=;
 b=LK1bjHQ3woGvJ+44573qCYPTcHBKUyAjfh5sGz8hPShab5ecQoB5L204bQ1ceVLHhrCrSf1Z8/wacMVDHrEBfF0ZQdy0ALrFSIZqaj6ENv5Ldhk0d59G1waCuluVtCEzEHvF2gCBsSbchbBVj4jNNVpqRzStvInuUojSjTaboQo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5128.namprd05.prod.outlook.com (20.177.231.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.12; Wed, 12 Dec 2018 21:15:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 21:15:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Edward Cree <ecree@solarflare.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 0/4] Static calls
Thread-Topic: [PATCH v2 0/4] Static calls
Thread-Index: AQHUkXwZUa+u7sLIDUq4r+bCTWcEL6V6nNUAgAC7gQCAABGZgIAABVSAgAAtSIA=
Date:   Wed, 12 Dec 2018 21:15:08 +0000
Message-ID: <B83BB5F6-4EBB-4BCA-9AA2-18EEB6483E7A@vmware.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
 <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
 <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
 <496ba248-eca5-d432-0ec9-95b2e0d775a1@solarflare.com>
In-Reply-To: <496ba248-eca5-d432-0ec9-95b2e0d775a1@solarflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5128;20:UDtWUtmrJq3YHZ4AKG+sbUMrDuzCuziUifJmGtycSwFBPDlxpGaKMXn14CkHa1WJND2YsfPe4uLsOcnkTUOkUTxWFGGR6qQNjtPvVSss6qD9c5dEePF+YvQm+1aCTi5WyrYAS9GR1wMbpzY7hkpVoMx4akGFTIVyxmD+prAHOQY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9b3eb7b2-8b02-41e8-9382-08d66076e528
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5128;
x-ms-traffictypediagnostic: BYAPR05MB5128:
x-microsoft-antispam-prvs: <BYAPR05MB5128F7E97251A4409D3B625CD0A70@BYAPR05MB5128.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5128;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5128;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(476003)(6506007)(2616005)(446003)(5660300001)(11346002)(83716004)(486006)(8936002)(82746002)(71200400001)(6512007)(93886005)(102836004)(97736004)(71190400001)(76176011)(26005)(186003)(53546011)(6486002)(53936002)(229853002)(4326008)(6246003)(33656002)(81156014)(54906003)(106356001)(6116002)(3846002)(305945005)(25786009)(6436002)(8676002)(36756003)(316002)(86362001)(81166006)(66066001)(256004)(14454004)(14444005)(68736007)(6916009)(478600001)(7736002)(105586002)(99286004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5128;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CUr4OI/04icggFiCx5T9wi6Dvg9g7dxaCdzZAnp8y4Te6V6MgsE4O942Lj//a15x++33xoqX0C9dooX0o8Pt1tYt5wwhaPOzRn2SQSCI+B4gkA27bvFhbGstIlUuhcSGO0NPHKFyuzBcdzWEQL+a+a262GUExOuou4Xb3M32hiWjgJPrLg+QxZprSuxb+Jt0XJ8y4w77Uc+GwalgVSkz3KKfzcFhvkIZOIe2nfiy47vtyEfP90Um6OGrTtZ9Bzp7EClvvx39wXShwA0tDrjExGdtxv+bpu3WXsZianqTbC/1CgPqhLdyEh4Aniobydu2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D2F44F7A7955B47A4FCF4E49AC73916@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3eb7b2-8b02-41e8-9382-08d66076e528
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 21:15:08.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTIsIDIwMTgsIGF0IDEwOjMzIEFNLCBFZHdhcmQgQ3JlZSA8ZWNyZWVAc29sYXJm
bGFyZS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTIvMTIvMTggMTg6MTQsIE5hZGF2IEFtaXQgd3Jv
dGU6DQo+PiBTZWNvbmQsICgyaSkgaXMgbm90IHZlcnkgaW50dWl0aXZlIGZvciBtZS4gVXNpbmcg
dGhlIG91dC1vZi1saW5lIHN0YXRpYw0KPj4gY2FsbHMgc2VlbXMgdG8gbWUgYXMgbGVzcyBwZXJm
b3JtYW50IHRoYW4gdGhlIGlubGluZSAocG90ZW50aWFsbHksIEkgZGlkbuKAmXQNCj4+IGNoZWNr
KS4NCj4+IA0KPj4gQW55aG93LCB0aGUgdXNlIG9mIG91dC1vZi1saW5lIHN0YXRpYyBjYWxscyBz
ZWVtcyB0byBtZSBhcw0KPj4gY291bnRlci1pbnR1aXRpdmUuIEkgdGhpbmsgKGRpZG7igJl0IG1l
YXN1cmUpIHRoYXQgaXQgbWF5IGFkZCBtb3JlIG92ZXJoZWFkDQo+PiB0aGFuIGl0IHNhdmVzIGR1
ZSB0byB0aGUgYWRkaXRpb25hbCBjYWxsLCByZXQsIGFuZCBzbyBvbg0KPiBBSVVJIHRoZSBvdXRs
aW5lIHZlcnNpb24gdXNlcyBhIHRhaWwtY2FsbCAoaS5lLiBqbXBxICp0YXJnZXQpIHJhdGhlciB0
aGFuIGFuDQo+ICBhZGRpdGlvbmFsIGNhbGwgYW5kIHJldC4gIFNvIEkgd291bGRuJ3QgZXhwZWN0
IGl0IHRvIGJlIHRvbyBleHBlbnNpdmUuDQo+IE1vcmUgdG8gdGhlIHBvaW50LCBpdCBzZWVtcyBs
aWtlIGl0J3MgZWFzaWVyIHRvIGdldCByaWdodCB0aGFuIHRoZSBpbmxpbmUNCj4gIHZlcnNpb24s
IGFuZCBpZiB3ZSBnZXQgdGhlIGlubGluZSB2ZXJzaW9uIHdvcmtpbmcgbGF0ZXIgd2UgY2FuIGlu
dHJvZHVjZSBpdA0KPiAgd2l0aG91dCBhbnkgQVBJIGNoYW5nZSwgbXVjaCBhcyBKb3NoJ3MgZXhp
c3RpbmcgcGF0Y2hlcyBoYXZlIGJvdGggdmVyc2lvbnMNCj4gIGJlaGluZCBhIEtjb25maWcgc3dp
dGNoLg0KDQpJIHNlZS4gRm9yIG15IG91dGxpbmVkIGJsb2NrcyBJIHVzZWQgdGhlIG9wcG9zaXRl
IGFwcHJvYWNoIC0gYSBjYWxsIGZvbGxvd2VkDQpieSBqbXAgKGluc3RlYWQgb2Ygam1wIGZvbGxv
d2VkIGJ5IGNhbGwgdGhhdCBKb3NoIGRpZCkuIERvZXMgdGhlIHN0YWNrIGxvb2sNCmNvcnJlY3Qg
d2hlbiB5b3UgZmlyc3QgZG8gdGhlIGptcD8gSXQgc2VlbXMgdG8gbWUgdGhhdCB5b3Ugd2lsbCBu
b3Qgc2VlIHRoZQ0KY2FsbGluZyBmdW5jdGlvbiBvbiB0aGUgc3RhY2sgaW4gdGhpcyBjYXNlLiBD
YW4gaXQgaGF2ZSBhbiBlZmZlY3Qgb24NCmxpdmUtcGF0Y2hpbmcsIGRlYnVnZ2luZz8NCg0KPj4g
SSB0cmllZCB0byBhdm9pZCByZWFkaW5nIHRvDQo+PiBjb21wYXJlZCB0YXJnZXQgZnJvbSBtZW1v
cnkgYW5kIHRoZXJlZm9yZSB1c2VkIGFuIGltbWVkaWF0ZS4gVGhpcyBzaG91bGQNCj4+IHByZXZl
bnQgZGF0YSBjYWNoZSBtaXNzZXMgYW5kIGV2ZW4gd2hlbiB0aGUgZGF0YSBpcyBhdmFpbGFibGUg
aXMgZmFzdGVyIGJ5DQo+PiBvbmUgY3ljbGUuIEJ1dCBpdCByZXF1aXJlcyB0aGUgcGF0Y2hpbmcg
b2YgYm90aCB0aGUg4oCcY21wICV0YXJnZXQtcmVnLCBpbW3igJ0NCj4+IGFuZCDigJxjYWxsIHJl
bC10YXJnZXTigJ0gdG8gYmUgcGF0Y2hlZCDigJxhdG9taWNhbGx54oCdLiBTbyB0aGUgc3RhdGlj
LWNhbGxzDQo+PiBtZWNoYW5pc20gd291bGRu4oCZdCBiZSBzdWZmaWNpZW50Lg0KPiBUaGUgYXBw
cm9hY2ggSSB0b29rIHRvIGRlYWwgd2l0aCB0aGF0IChzaW5jZSB0aG91Z2ggSSdtIGRvaW5nIGEg
cmVhZCBmcm9tDQo+ICBtZW1vcnksIGl0J3Mga2V5LT5mdW5jIGluIC5kYXRhIHJhdGhlciB0aGFu
IHRoZSBqbXAgaW1tZWRpYXRlIGluIC50ZXh0KSB3YXMNCj4gIHRvIGhhdmUgYW5vdGhlciBzdGF0
aWNfY2FsbCAodGhvdWdoIGEgcGxhaW4gc3RhdGljX2tleSBjb3VsZCBhbHNvIGJlIHVzZWQpDQo+
ICB0byAnc2tpcCcgdGhlIGZhc3QtcGF0aCB3aGlsZSBpdCdzIGFjdHVhbGx5IGJlaW5nIHBhdGNo
ZWQuICBUaGVuLCBzaW5jZSBhbGwNCj4gIG15IGNhbGxlcnMgd2VyZSB1bmRlciB0aGUgcmN1X3Jl
YWRfbG9jaywgSSBqdXN0IG5lZWRlZCB0byBzeW5jaHJvbml6ZV9yY3UoKQ0KPiAgYWZ0ZXIgc3dp
dGNoaW5nIG9mZiB0aGUgZmFzdC1wYXRoIHRvIG1ha2Ugc3VyZSBubyB0aHJlYWRzIHdlcmUgc3Rp
bGwgaW4gaXQuDQo+IEknbSBub3Qgc3VyZSBob3cgdGhhdCB3b3VsZCBiZSBnZW5lcmFsaXNlZCB0
byBhbGwgY2FzZXMsIHRob3VnaDsgd2UgZG9uJ3QNCj4gIHdhbnQgdG8gZm9yY2UgZXZlcnkgaW5k
aXJlY3QgY2FsbCB0byB0YWtlIHRoZSByY3VfcmVhZF9sb2NrIGFzIHRoYXQgbWVhbnMNCj4gIG5v
IGNhbGxlZSBjYW4gZXZlciBzeW5jaHJvbml6ZV9yY3UoKS4gIEkgZ3Vlc3Mgd2UgY291bGQgaGF2
ZSBvdXIgb3duDQo+ICBzZXBhcmF0ZSBSQ1UgcmVhZCBsb2NrIGp1c3QgZm9yIGluZGlyZWN0IGNh
bGwgcGF0Y2hpbmc/ICAoV2hhdCBkb2VzIGtncmFmdA0KPiAgZG8/KQ0KDQpJIHVzZWQgYSBzaW1p
bGFyIGFwcHJvYWNoIHRvIGEgY2VydGFpbiBleHRlbnQuIChJ4oCZbSBnb2luZyB0byBkZXNjcmli
ZSB0aGUNCmltcGxlbWVudGF0aW9uIGZvbGxvd2luZyB0aGUgZGlzY3Vzc2lvbiB3aXRoIEFuZHkg
THV0b21pcnNraSk6IFdlIHVzZSBhDQrigJxyZXN0YXJ0YWJsZSBzZWN0aW9u4oCdIHRoYXQgaWYg
d2UgbmVlZCB0byBiZSBwcmVlbXB0ZWQgaW4gdGhpcyBibG9jayBvZiBjb2RlLA0Kd2UgcmVzdGFy
dCB0aGUgZW50aXJlIHNlY3Rpb24uIFRoZW4sIHdlIHVzZSBzeW5jaHJvbml6ZV9yY3UoKSBsaWtl
IHlvdSBkbw0KYWZ0ZXIgcGF0Y2hpbmcuDQoNCj4+IEJhc2VkIG9uIEpvc2jigJlzIHByZXZpb3Vz
IGZlZWRiYWNrLCBJIHRob3VnaHQgb2YgaW1wcm92aW5nIHRoZSBsZWFybmluZyB1c2luZw0KPj4g
c29tZSBoeXN0ZXJlc2lzLiBBbnlob3csIG5vdGUgdGhhdCB0aGVyZSBhcmUgcXVpdGUgYSBmZXcg
Y2FzZXMgaW4gd2hpY2ggeW91DQo+PiB3b3VsZG7igJl0IHdhbnQgb3B0cG9saW5lcy4gVGhlIHF1
ZXN0aW9uIGlzIHdoZXRoZXIgaW4gZ2VuZXJhbCBpdCB3b3VsZCBiZSBhbg0KPj4gb3B0LWluIG9y
IG9wdC1vdXQgbWVjaGFuaXNtLg0KPiBJIHdhcyB3b3JraW5nIG9uIHRoZSBhc3N1bXB0aW9uIHRo
YXQgaXQgd291bGQgYmUgb3B0LWluLCB3cmFwcGluZyBhIG1hY3JvDQo+ICBhcm91bmQgaW5kaXJl
Y3QgY2FsbHMgdGhhdCBhcmUga25vd24gdG8gaGF2ZSBhIGZhaXJseSBzbWFsbCBudW1iZXIgb2Yg
aG90DQo+ICB0YXJnZXRzLiAgVGhlcmUgYXJlIHBsZW50eSBvZiBpbmRpcmVjdCBjYWxscyBpbiB0
aGUga2VybmVsIHRoYXQgYXJlIG9ubHkNCj4gIGNhbGxlZCBvbmNlIGluIGEgYmx1ZSBtb29uLCBl
LmcuIGluIGNvbnRyb2wtcGxhbmUgb3BlcmF0aW9ucyBsaWtlIGV0aHRvb2w7DQo+ICB3ZSBkb24n
dCByZWFsbHkgbmVlZCB0byBidWxrIHVwIC50ZXh0IHdpdGggdHJhbXBvbGluZXMgZm9yIGFsbCBv
ZiB0aGVtLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgSeKAmW0gbm90IHN1cmUgdGhlIHN0YXRpY19j
YWxsIGludGVyZmFjZSBpcyBzbyBpbnR1aXRpdmUuDQpBbmQgZXh0ZW5kaW5nIGl0IGludG8g4oCc
ZHluYW1pY19jYWxs4oCdIG1pZ2h0IGJlIGV2ZW4gd29yc2UuIEFzIEkgaW5pdGlhbGx5DQp1c2Vk
IGFuIG9wdC1pbiBhcHByb2FjaCwgSSBjYW4gdGVsbCB5b3UgdGhhdCBpdCB3YXMgdmVyeSBleGhh
dXN0aW5nLg0KDQo=
