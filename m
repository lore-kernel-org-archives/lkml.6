Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BC8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673FA206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oA1kW7FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbeLPCdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:33:52 -0500
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:44550
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbeLPCdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 21:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9a1O1SkZdz6zkrD8t8Ufawx/au+GMEZfCwl5EJ21CY=;
 b=oA1kW7FTaHU/8VGdKXeQ8vScMfeBBGCFA04Hnd2fXz7vEKvkX47UoKXC4SNXu5FRnUS/+VvfsdiwgYI0o3L3sBJtxOuRMdyjEsXfNZ7JYOmJIUldjwPrfuwDIj1I5lKexdkVOO3HcFx1gZsst2Z5Ezw78FaeOf7+qXz4ogNpMBg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4023.namprd05.prod.outlook.com (52.135.199.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.9; Sun, 16 Dec 2018 02:33:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.015; Sun, 16 Dec 2018
 02:33:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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
Thread-Index: AQHUksVBZzHOPXiLTkuUqtDHy4jwBqV8fiQAgAJ83gCAAa7zAA==
Date:   Sun, 16 Dec 2018 02:33:39 +0000
Message-ID: <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
 <20181213105146.GH5289@hirez.programming.kicks-ass.net>
 <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
In-Reply-To: <CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:a44e:3b12:f2ea:ce3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4023;20:GL4ygJekUFFnvwYoA9AvVgUvv/FyPBA0Jl65QkDGpDJiOnNJedkyk/oRNs3Y2UO66Ry8L4z/lsI9mLYWPSzKINFPXxDjwYhSNqW63sht0OpXMWYGOjscXwbaj4XvkGu+a3LZ2Mcc3eo0wTxbd15gTwRRWoGNpncUsuwRavJNBA8=
x-ms-office365-filtering-correlation-id: 967fd799-d54e-45f1-336c-08d662fee3b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4023;
x-ms-traffictypediagnostic: BYAPR05MB4023:
x-microsoft-antispam-prvs: <BYAPR05MB4023740B0B11C7CCC0CBEBC0D0A30@BYAPR05MB4023.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501517)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4023;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4023;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(51444003)(54906003)(7736002)(53936002)(6246003)(305945005)(36756003)(5660300001)(6512007)(316002)(7416002)(46003)(256004)(14444005)(102836004)(82746002)(39060400002)(4326008)(446003)(11346002)(486006)(186003)(68736007)(76176011)(476003)(2616005)(33656002)(53546011)(6506007)(478600001)(86362001)(6116002)(575784001)(25786009)(97736004)(2906002)(105586002)(106356001)(229853002)(8936002)(81166006)(81156014)(8676002)(6436002)(6486002)(14454004)(83716004)(71200400001)(71190400001)(6916009)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4023;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9EvBTbkt4hMzoXbMhSyRBDQrVqWd0RalB/JnPsQOPcOOJwOFEK0OU+loi1wRGSMAyxXMRN2Qyb5d44H/ia807AGMq3Zz3PrtN+5SRrITmjUr+nikNjkoPPMobJhFxLJIX+NIGaDwEmk5EucidAmkAbprGg2vV3MBM26O73B//unUqAD1ZNwVSJoDASC4RXxKwGh8/HCy8i4KGjoGOEgxzToc0oE0LiTN1tmtZUKCZwftEdVEzkht6k4a6jHzb/BzZTkub3noRnLWQ0iz9rQGPKfKiM7FJxXxup9RNR+nA6Qjz/SdI6Z6peafLQVb45YB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <85A242CF1B9B20409566BB977F231D11@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fd799-d54e-45f1-336c-08d662fee3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 02:33:39.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTQsIDIwMTgsIGF0IDQ6NTEgUE0sIE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiANCj4gSGkgUGV0ZXIsDQo+IA0KPiBPbiBU
aHUsIERlYyAxMywgMjAxOCBhdCA3OjUzIFBNIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6DQo+PiBPbiBUaHUsIERlYyAxMywgMjAxOCBhdCAwNjoxNzo0MVBNICsw
OTAwLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6DQo+Pj4gUmV2ZXJ0IHRoZSBmb2xsb3dpbmcgY29t
bWl0czoNCj4+PiANCj4+PiAtIDViZGNkNTEwYzJhYzllZmFmNTVjNGNiZDhkNDY0MjFkOGUyMzIw
Y2QNCj4+PiAgKCJ4ODYvanVtcC1sYWJlbHM6IE1hY3JvZnkgaW5saW5lIGFzc2VtYmx5IGNvZGUg
dG8gd29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3MiKQ0KPj4+IA0KPj4+IC0gZDVhNTgxZDg0
YWU2YjhhNGE3NDA0NjRiODBkOGQ5Y2YxZTc5NDdiMg0KPj4+ICAoIng4Ni9jcHVmZWF0dXJlOiBN
YWNyb2Z5IGlubGluZSBhc3NlbWJseSBjb2RlIHRvIHdvcmsgYXJvdW5kIEdDQyBpbmxpbmluZyBi
dWdzIikNCj4+PiANCj4+PiAtIDA0NzRkNWQ5ZDJmN2YzYjExMjYyZjdiZjg3ZDBlNzMxNGVhZDky
MDAuDQo+Pj4gICgieDg2L2V4dGFibGU6IE1hY3JvZnkgaW5saW5lIGFzc2VtYmx5IGNvZGUgdG8g
d29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3MiKQ0KPj4+IA0KPj4+IC0gNDk0YjUxNjhmMmRl
MDA5ZWI4MGYxOThmNjY4ZGEzNzQyOTUwOThkZC4NCj4+PiAgKCJ4ODYvcGFyYXZpcnQ6IFdvcmsg
YXJvdW5kIEdDQyBpbmxpbmluZyBidWdzIHdoZW4gY29tcGlsaW5nIHBhcmF2aXJ0IG9wcyIpDQo+
Pj4gDQo+Pj4gLSBmODFmOGFkNTZmZDFjN2I5OWIyZWQxYzMxNDUyN2Y3ZDlhYzQ0N2M2Lg0KPj4+
ICAoIng4Ni9idWc6IE1hY3JvZnkgdGhlIEJVRyB0YWJsZSBzZWN0aW9uIGhhbmRsaW5nLCB0byB3
b3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVncyIpDQo+Pj4gDQo+Pj4gLSA3N2Y0OGVjMjhlNGNj
ZmY5NGQyZTVmNDI2MGE4M2FjMjdhN2YzMDk5Lg0KPj4+ICAoIng4Ni9hbHRlcm5hdGl2ZXM6IE1h
Y3JvZnkgbG9jayBwcmVmaXhlcyB0byB3b3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVncyIpDQo+
Pj4gDQo+Pj4gLSA5ZTE3MjViNDEwNTk0OTExY2M1OTgxYjZjN2I0Y2VhNGVjMDU0Y2E4Lg0KPj4+
ICAoIng4Ni9yZWZjb3VudDogV29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1ZyIpDQo+Pj4gIChD
b25mbGljdHM6IGFyY2gveDg2L2luY2x1ZGUvYXNtL3JlZmNvdW50LmgpDQo+Pj4gDQo+Pj4gLSBj
MDZjNGQ4MDkwNTEzZjI5NzRkZmRiZWQyYWM5ODYzNDM1N2FjNDc1Lg0KPj4+ICAoIng4Ni9vYmp0
b29sOiBVc2UgYXNtIG1hY3JvcyB0byB3b3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVncyIpDQo+
Pj4gDQo+Pj4gLSA3N2IwYmY1NWJjNjc1MjMzZDIyY2Q1ZGY5NzYwNWQ1MTZkNjQ1MjVlLg0KPj4+
ICAoImtidWlsZC9NYWtlZmlsZTogUHJlcGFyZSBmb3IgdXNpbmcgbWFjcm9zIGluIGlubGluZSBh
c3NlbWJseSBjb2RlIHRvIHdvcmsgYXJvdW5kIGFzbSgpIHJlbGF0ZWQgR0NDIGlubGluaW5nIGJ1
Z3MiKQ0KPj4gDQo+PiBJIGRvbid0IHRoaW5rIHdlIHdhbnQgdG8gYmxpbmRseSByZXZlcnQgYWxs
IHRoYXQuIFNvbWUgb2YgdGhlbSBhY3R1YWxseQ0KPj4gbWFkZSBzZW5zZSBhbmQgZGlkIGNsZWFu
IHVwIHRoaW5ncyBpcnJlc3BlY3RpdmUgb2YgdGhlIGFzbS1pbmxpbmUgaXNzdWUuDQo+PiANCj4+
IEluIHBhcnRpY3VsYXIgSSBsaWtlIHRoZSBqdW1wLWxhYmVsIG9uZS4NCj4gDQo+IFsxXSBUaGUg
I2Vycm9yIG1lc3NhZ2UgaXMgdW5uZWNlc3NhcnkuDQo+IA0KPiBbMl0ga2VlcCBTVEFUQ19CUkFO
Q0hfTk9QL0pNUCBpbnN0ZWFkIG9mIFNUQVRJQ19KVU1QX0lGX1RSVUUvRkFMU0UNCj4gDQo+IA0K
PiANCj4gSW4gdjIsIEkgd2lsbCBtYWtlIHN1cmUgdG8gbm90IHJlLWFkZCBbMV0uDQo+IEkgYW0g
bm90IHN1cmUgYWJvdXQgWzJdLg0KPiANCj4gDQo+IERvIHlvdSBtZWFuIG9ubHkgWzFdLA0KPiBv
ciBib3RoIG9mIHRoZW0/DQo+IA0KPiANCj4gDQo+PiBUaGUgY3B1ZmVhdHVyZSBvbmUgT1RPaCwg
eWVhaCwNCj4+IEknZCBsb3ZlIHRvIGdldCB0aGF0IHJldmVydGVkLg0KPj4gDQo+PiBBbmQgYXMg
YSBub3RlOyB0aGUgbm9ybWFsIGNvbW1pdCBxdW90aW5nIHN0eWxlIGlzOg0KPj4gDQo+PiAgZDVh
NTgxZDg0YWU2ICgieDg2L2NwdWZlYXR1cmU6IE1hY3JvZnkgaW5saW5lIGFzc2VtYmx5IGNvZGUg
dG8gd29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3MiKQ0KPiANCj4gDQo+IE9LLiBJIHdpbGwg
ZG8gc28gaW4gdjIuDQoNCkkgcmVjb21tZW5kIHRvIGRvIHRoZSBmb2xsb3dpbmcgZm9yIHYyOg0K
DQoxLiBSdW4gc29tZSBzdGF0aWMgbWVhc3VyZW1lbnRzIChlLmcuLCBmdW5jdGlvbiBzaXplcywg
bnVtYmVyIG9mIGZ1bmN0aW9uDQpzeW1ib2xzKSB0byBlbnN1cmUgdGhhdCBHQ0Mgd29ya3MgYXMg
aXQgc2hvdWxkLiBJZiBwb3NzaWJsZSwgcnVuIHNtYWxsDQpwZXJmb3JtYW5jZSBldmFsdWF0aW9u
cy4gSUlSQywgSSBzYXcgc21hbGwgYnV0IGNvbnNpc3RlbnQgcGVyZm9ybWFuY2UNCmRpZmZlcmVu
Y2Ugd2hlbiBJIHJhbiBhIGxvb3Agd2l0aCBtcHJvdGVjdCgpIHRoYXQga2VwdCBjaGFuZ2luZyBw
ZXJtaXNzaW9ucy4NClRoaXMgd2FzIGR1ZSB0byBQViBNTVUgZnVuY3Rpb25zIHRoYXQgY2F1c2Vk
IGlubGluaW5nIG1lc3MuDQoNCjIuIEJyZWFrIHRoZSBwYXRjaCBpbnRvIHNlcGFyYXRlIHBhdGNo
ZXMsIGJhc2VkIG9uIHRoZSBvcmlnaW5hbCBwYXRjaC1zZXQNCm9yZGVyIChyZXZlcnNlZCkuIFRo
aXMgaXMgdGhlIGNvbW1vbiBwcmFjdGljZSwgd2hpY2ggYWxsb3dzIHBlb3BsZSB0byByZXZpZXcN
CnBhdGNoZXMsIHBlcmZvcm0gYmlzZWN0aW9ucywgYW5kIHJldmVydCB3aGVuIG5lZWRlZC4NCg0K
My4gQ2MgdGhlIHJlbGV2YW50IHBlb3BsZSB3aG8gYWNrJ2QgdGhlIG9yaWdpbmFsIHBhdGNoZXMs
IGUuZy4sIEtlZXMgQ29vaywNCndob+KAmXMgb24gdG9wIG9mIHRoZSByZWZlcmVuY2UtY291bnRl
cnMgYW5kIExpbnVzLCB3aG8gcHJvcG9zZWQgdGhpcw0KYXBwcm9hY2guDQoNCkluIGdlbmVyYWws
IEkgdGhpbmsgdGhhdCBmcm9tIHRoZSBzdGFydCBpdCB3YXMgY2xlYXIgdGhhdCB0aGUgbW90aXZh
dGlvbiBmb3INCnRoZSBwYXRjaC1zZXQgaXMgbm90IGp1c3QgcGVyZm9ybWFuY2UgYW5kIGFsc28g
YmV0dGVyIGNvZGUuIEZvciBleGFtcGxlLCBJDQpzZWUgbm8gcmVhc29uIHRvIHJldmVydCB0aGUg
UFYtY2hhbmdlcyBvciB0aGUgbG9jay1wcmVmaXggY2hhbmdlcyB0aGF0DQppbXByb3ZlZCB0aGUg
Y29kZSByZWFkYWJpbGl0eS4NCg0KUmVnYXJkcywNCk5hZGF2
