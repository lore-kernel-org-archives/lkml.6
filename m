Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF83C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0DA206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ioPGX1l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeLQBER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:04:17 -0500
Received: from mail-eopbgr730077.outbound.protection.outlook.com ([40.107.73.77]:30163
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbeLQBEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIHTaY5DQfQe2QF0fuwgbDNBhJpBS8fi31FOPdLnsPc=;
 b=ioPGX1l7ethH/CYbyz4/f+ARCf/ZselvrxwROM/n6vjTXKJ5FrRYtz8GTuzyCYm2o3qNLL9ZVbXtIeedKHojIHdgA05QEb5wqG2TQDMyYQgPBF/t3WC22/Cd7jOmjleAIjZSV1uykiPxviBrriDZYBiS/Soj2Sw5HU57CgndKRg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6600.namprd05.prod.outlook.com (20.178.234.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.10; Mon, 17 Dec 2018 01:00:51 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.015; Mon, 17 Dec 2018
 01:00:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Thread-Topic: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Thread-Index: AQHUksVBZzHOPXiLTkuUqtDHy4jwBqV8fiQAgAJ83gCAAa7zAIAAfOkAgAD7fYA=
Date:   Mon, 17 Dec 2018 01:00:50 +0000
Message-ID: <834EC537-EC42-4563-AA39-3326681ED968@vmware.com>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
 <20181213105146.GH5289@hirez.programming.kicks-ass.net>
 <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
 <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
 <20181216100042.GA815@zn.tnic>
In-Reply-To: <20181216100042.GA815@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:190e:5da1:31e8:24b0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6600;20:QMQSoza06V2VVZ1yaAWALXcnzwgFg1x2HBesWtuXePx5PZDo9SCCJUtYYw5VWsbggTK/Qb+H6yFwgkOLem9VihDNvJAvkpdQ26rbvC3RaOCYv16sfgAAaTLyZZK0V7JrqZV2cmg773gWY3WIcxs13kVHytGkYtrwIfaET1tEMe8=
x-ms-office365-filtering-correlation-id: b6b7b825-7eae-412d-8595-08d663bb16e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6600;
x-ms-traffictypediagnostic: BYAPR05MB6600:
x-microsoft-antispam-prvs: <BYAPR05MB660051E71DD9E9C26819ACB1D0BC0@BYAPR05MB6600.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB6600;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB6600;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(51444003)(189003)(199004)(46003)(305945005)(53936002)(86362001)(6512007)(186003)(14454004)(54906003)(446003)(316002)(11346002)(6916009)(2616005)(25786009)(229853002)(476003)(106356001)(102836004)(2906002)(39060400002)(53546011)(6116002)(4326008)(6246003)(71190400001)(71200400001)(83716004)(478600001)(105586002)(5660300001)(256004)(7416002)(14444005)(76176011)(486006)(6506007)(36756003)(68736007)(6436002)(8936002)(33656002)(6486002)(8676002)(97736004)(93886005)(81156014)(81166006)(82746002)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6600;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JPzn7/oxRoLRNzdvBmMFZ54UprNJCbZqhNjb2Ik3mKxviC+no+u03ldTieylkxGhcbmyt0C7/R/v7fuagKuSdv5O02piL9MWHxBfI7hsL754+2tNXIeS6sXV1BLtdJ5eDT3m6H9vfihZT9zmdF3GYGgsHt4Zh2d5sVJdO60PkRbEgRYpXiUi7At3k8CT7fjXzRevDxZeSQW7UB9BM9pXUIMu372cHAExOvT/UOtl6C2DDZfjqiS6pWmdjPev1I8AsnLK1zOXHvm5NvJ+4pRNNI3H6fh37owQ8txRHdx5WOIvu8cS3BCYfUrVCGCBbqBi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <89DD256D3BD73D4C90A72BA26FA76DBB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b7b825-7eae-412d-8595-08d663bb16e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 01:00:50.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTYsIDIwMTgsIGF0IDI6MDAgQU0sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFN1biwgRGVjIDE2LCAyMDE4IGF0IDAyOjMzOjM5QU0gKzAw
MDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBJbiBnZW5lcmFsLCBJIHRoaW5rIHRoYXQgZnJvbSB0
aGUgc3RhcnQgaXQgd2FzIGNsZWFyIHRoYXQgdGhlIG1vdGl2YXRpb24gZm9yDQo+PiB0aGUgcGF0
Y2gtc2V0IGlzIG5vdCBqdXN0IHBlcmZvcm1hbmNlIGFuZCBhbHNvIGJldHRlciBjb2RlLiBGb3Ig
ZXhhbXBsZSwgSQ0KPj4gc2VlIG5vIHJlYXNvbiB0byByZXZlcnQgdGhlIFBWLWNoYW5nZXMgb3Ig
dGhlIGxvY2stcHJlZml4IGNoYW5nZXMgdGhhdA0KPj4gaW1wcm92ZWQgdGhlIGNvZGUgcmVhZGFi
aWxpdHkuDQo+IA0KPiBPbmUgdGhpbmcgdGhhdCBoYXMgY2F1Z2h0IG15IGV5ZSB3aXRoIHRoZSBh
c20gbWFjcm9zLCB3aGljaCBhY3R1YWxseQ0KPiBkZWNyZWFzZXMgcmVhZGFiaWxpdHksIGlzIHRo
YXQgSSBjYW4ndCBzZWUgdGhlIG1hY3JvIHByb3Blcmx5IGV4cGFuZGVkDQo+IHdoZW4gSSBkbw0K
PiANCj4gbWFrZSA8ZmlsZW5hbWU+LnMNCj4gDQo+IEZvciBleGFtcGxlLCBJIGdldA0KPiANCj4g
I0FQUA0KPiAjIDE2NCAiLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmgiIDENCj4g
ICAgICAgIFNUQVRJQ19DUFVfSEFTIGJpdG51bT0kOCBjYXBfYnl0ZT0iYm9vdF9jcHVfZGF0YSsz
NSglcmlwKSIgZmVhdHVyZT0xMjMgdF95ZXM9Lkw3NSB0X25vPS5MNzggYWx3YXlzPTExNyAgIywg
TUVNWyhjb25zdCBjaGFyICopJmJvb3RfY3B1X2RhdGEgKyAzNUJdLCwsLA0KPiAjIDAgIiIgMg0K
PiAgICAgICAgLmxvYyAxMSAxNjQgMiB2aWV3IC5MVlU0ODANCj4gI05PX0FQUA0KPiANCj4gYnV0
IEknZCBsaWtlIHRvIHNlZSB0aGUgYWN0dWFsIGFzbSBhcyBpdCBpcyByZWFsbHkgaGVscGZ1bCB3
aGVuIGhhY2tpbmcNCj4gb24gaW5saW5lIGFzbSBzdHVmZi4gQW5kIEkgaGF2ZW4ndCBmb3VuZCBh
IHdheSB0byBtYWtlIGdjYyBleHBhbmQgYXNtDQo+IG1hY3JvcyBpbiAucyBvdXRwdXQuDQoNCllv
deKAmXJlIHJpZ2h0LCBhbHRob3VnaCB0aGVyZSB3ZXJlIGFscmVhZHkgNzIgYXNzZW1ibHkgbWFj
cm9zIGZvciBkZWZpbmVkIGluDQp4ODYgLmggZmlsZXMsIGFuZCBzb21lIG1heSBmaW5kIHRoZSB1
bmV4cGFuZGVkIG1hY3JvIGluIHRoZSDigJguc+KAmSBmaWxlIG1vcmUNCmZyaWVuZGx5ICh3ZWxs
LCBhIHNtYWxsIGNvbW1lbnQgaW4gaW5saW5lIGFzc2VtYmx5IGNvdWxkIGhhdmUgcmVzb2x2ZWQg
dGhpcw0KaXNzdWUpLg0KDQpBbnlob3csIHVzaW5nIGdudSBhc20gbGlzdGluZ3Mgc2hvdWxkIGJl
IGEgcmVsYXRpdmVseSByZWFzb25hYmxlIHdvcmthcm91bmQNCmZvciB0aGlzIGxpbWl0YXRpb24g
KHVubGVzcyB5b3Ugd2FudCB0byBoYWNrIHRoZSBjb2RlIGJlZm9yZSBhc3NlbWJseSkuDQoNCkZv
ciBleGFtcGxlLCB1c2luZyBgIGFzIC1hbG0gYXJjaC94ODYva2VybmVsL21hY3Jvcy5zIGFyY2gv
eDg2L2t2bS92bXgucyBgDQoNCndvdWxkIGdpdmUgeW91Og0KDQogNDIxICAgICAgICAgICAgICAg
ICAgICAjIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oOjE2NDogICAgICBhc21f
dm9sYXRpbGVfZ290bygiU1RBVElDX0NQVV9IQVMgYml0bnVtPSVbYml0bnVtXSAiDQogNDIyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC5maWxlIDggIi4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Y3B1ZmVhdHVyZS5oIg0KIDQyMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAubG9jIDggMTY0
IDANCiA0MjQgICAgICAgICAgICAgICAgICAgICNBUFANCiA0MjUgICAgICAgICAgICAgICAgICAg
ICMgMTY0ICIuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaCIgMQ0KIDQyNiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBTVEFUSUNfQ1BVX0hBUyBiaXRudW09JDIgY2FwX2J5dGU9
ImJvb3RfY3B1X2RhdGErMzgoJXJpcCkiIGZlYXR1cmU9MTQ1IHRfeWVzPS5MMTcgdF9ubz0uTDE4
IGFsd2F5cw0KIDQyNiAgICAgICAgICAgICAgICAgICAgPiAxOg0KIDQyNiAwMGQ4IEU5MDAwMDAw
ICAgICAgPiAgam1wIDZmDQogNDI2ICAgICAgMDANCiA0MjYgICAgICAgICAgICAgICAgICAgID4g
MjoNCiA0MjYgICAgICAgICAgICAgICAgICAgID4gIC5za2lwIC0oKCg1Zi00ZiktICgyYi0xYikp
PjApKiAoKDVmLTRmKS0gKDJiLTFiKSksMHg5MA0KIDQyNiAgICAgICAgICAgICAgICAgICAgPiAz
Og0KIDQyNiAgICAgICAgICAgICAgICAgICAgPiAgLnNlY3Rpb24gLmFsdGluc3RydWN0aW9ucywi
YSINCiA0MjYgMDAwZCAwMDAwMDAwMCAgICAgID4gIC5sb25nIDFiIC0gLg0KIDQyNiAwMDExIDAw
MDAwMDAwICAgICAgPiAgLmxvbmcgNGYgLSAuDQogNDI2IDAwMTUgNzUwMCAgICAgICAgICA+ICAu
d29yZCAxMTcNCg0K4oCmDQoNClRoaXMgY2FuIGJlIGluY29ycG9yYXRlZCBpbnRvIGEgbWFrZWZp
bGUgb3B0aW9uLCBJIHN1cHBvc2UuDQoNCg0KPiBOb3csIGFzc3VtaW5nIHRoZSBnY2MgaW5saW5l
IHBhdGNoIHdpbGwgYmUgYmFja3BvcnRlZCB0byBnY2M4LCBJIHRoaW5rDQo+IHdlIHNob3VsZCBi
ZSBjb3ZlcmVkIG9uIGFsbCBtb2Rlcm4gZGlzdHJvcyBnb2luZyBmb3J3YXJkLiBTbyBJIHRoaW5r
IHdlDQo+IHNob3VsZCByZXZlcnQgYXQgbGVhc3QgdGhlIG1vcmUgY29tcGxleCBtYWNyb3MuDQoN
CkkgdW5kZXJzdGFuZCwgYW5kIHBlcmhhcHMgU1RBVElDX0NQVV9IQVMgaXMgbm90IGEgZ29vZCB1
c2UtY2FzZSAob25jZQ0KaW5saW5pbmcgaXMgcmVzb2x2ZWQgaW4gYSBkaWZmZXJlbnQgbWFubmVy
KS4gSSB0aGluayB0aGF0IHRoZSBtYWluIHF1ZXN0aW9uDQpzaG91bGQgYmUgd2hldGhlciB0aGUg
d2hvbGUgaW5mcmFzdHJ1Y3R1cmUgc2hvdWxkIGJlIHJlbW92ZWQgb3IgdG8gYmUNCnNlbGVjdGl2
ZS4gDQoNCkluIHRoZSBjYXNlIG9mIGV4Y2VwdGlvbiB0YWJsZXMsIGZvciBpbnN0YW5jZSwgdGhl
IHJlc3VsdCBpcyBtdWNoIGNsZWFuZXIsDQphcyBpdCBhbGxvd3MgdG8gY29uc29saWRhdGUgdGhl
IEMgYW5kIGFzc2VtYmx5IGltcGxlbWVudGF0aW9ucy4gVGhlcmUgaXMgYW4NCmFsdGVybmF0aXZl
IHNvbHV0aW9uIG9mIHR1cm5pbmcgdGhlIGFzc2VtYmx5IG1hY3JvcyBpbnRvIEMgbWFjcm9zLCB3
aGljaA0Kd291bGQgbWFrZSB0aGUgTWFrZSBzeXN0ZW0gaGFja3MgZ28gYXdheSwgYnV0IHdvdWxk
IG1ha2UgdGhlIGNvZGUgbm90IGFzDQpuaWNlLg0KDQo=
