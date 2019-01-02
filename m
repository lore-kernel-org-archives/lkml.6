Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E8C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE65218FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UDgjsFyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfABRYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:24:03 -0500
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:46086
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729749AbfABRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6xcbeJA1f53Tvd/u8rwfWHjfnXpe6TqYAB98V0JON8=;
 b=UDgjsFyPKYdNriSpv9hmdMrQQRo4Pwbbo4IE/ADxElvKUTtHAIFY31q7jWzLGnEMmR+aj3tkx5bZxtsRZLnPd48zNIyp//Eyx4PT4h94pTsbXZOdMlcxDVJnXPvdxMPHM9x4uhCfsiizWzHObM/r9rOaU6a4JU73hH8rWFGsJSg=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4994.namprd05.prod.outlook.com (20.177.241.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.5; Wed, 2 Jan 2019 17:23:20 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::4cb4:35db:ba27:ad10]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::4cb4:35db:ba27:ad10%4]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 17:23:20 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/retpoline: change RETPOLINE into CONFIG_RETPOLINE
Thread-Topic: [PATCH] x86/retpoline: change RETPOLINE into CONFIG_RETPOLINE
Thread-Index: AQHUoWKNsH5TA64VKUGjil3dFlomUKWbLvSAgAEN+gA=
Date:   Wed, 2 Jan 2019 17:23:19 +0000
Message-ID: <DE796CE1-11EB-42B7-904E-A20CA9AC3699@vmware.com>
References: <20181231234253.2724-1-namit@vmware.com>
 <f09d61a6-21ff-1557-d3f7-209944a4308d@oracle.com>
In-Reply-To: <f09d61a6-21ff-1557-d3f7-209944a4308d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4994;20:m8kpDDd3kAOSNlcDaWmcjYudNG814MgqupgV7kB5SDps5HK682Oyg2+xgEXoB5OjeJAuB8nF428a+Kqc6A5cgA3XLFckjswGBPkcOTx+uTJBOF6o3+vnBiK73rcKqi6CyVHp8u1bxbXnTjY8Zv+lJvQgnLh19L2+glT70Ijanc8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a7662e24-002c-4f9a-0c1b-08d670d6fdaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4994;
x-ms-traffictypediagnostic: BL0PR05MB4994:
x-microsoft-antispam-prvs: <BL0PR05MB49941E2F697F1D1D93ED5778D08C0@BL0PR05MB4994.namprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR05MB4994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4994;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(86362001)(575784001)(66066001)(81166006)(102836004)(8676002)(2906002)(478600001)(8936002)(76176011)(97736004)(105586002)(256004)(106356001)(6506007)(53546011)(81156014)(7736002)(316002)(6916009)(305945005)(14454004)(25786009)(6246003)(82746002)(99286004)(476003)(33656002)(2616005)(36756003)(11346002)(6512007)(486006)(6436002)(5660300001)(53936002)(83716004)(446003)(71200400001)(71190400001)(7416002)(6486002)(68736007)(26005)(54906003)(3846002)(6116002)(186003)(4326008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4994;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L+Sfi+Dlnd15YoIJ+MjUfraxgp8snH7OP5lu2YyFG3J3nIgSi0CTPLby8ELvvVTQZnxzlh8+OJjMx3kCL1yX/f6sqw8dCEHv+8rBvrJGaI+TerhpNoK9rOajw9qZfVSuuPCETIqcUZwZ7Mcw5PlH77KlGe6l3pZlMsGWZU5y4Rd0CLi/YKBVjZn5lOmNZqGDZu6GhDI4t5HXy576fxnTCKSSIhLz2J2DS1hiMq1bfbHA4FBr6f1GeEjNn5KBqufwfWeXwaXI2mix0txj/yDLudb8JomIHvf7dM27h/yLDZUSmHyhu2ziUBjpCOPVCDOg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <19502404D3B5F5418E86D9F2A18B132D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7662e24-002c-4f9a-0c1b-08d670d6fdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 17:23:19.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMSwgMjAxOSwgYXQgNToxNyBQTSwgWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IE9uIDIwMTkvMS8xIDc6NDIsIE5hZGF2
IEFtaXQgd3JvdGU6DQo+PiBBIHJlY2VudCBlbmhhbmNlbWVudCBpbnRlbnRpb25hbGx5IGZhaWxz
IHRoZSBrZXJuZWwgYnVpbGQgaWYgdGhlDQo+PiBjb21waWxlciBkb2VzIG5vdCBzdXBwb3J0IHJl
dHBvbGluZXMgYW5kIENPTkZJR19SRVRQT0xJTkUgaXMgc2V0Lg0KPj4gDQo+PiBIb3dldmVyLCB0
aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VkIGl0IGRpZCBub3QgY2hhbmdlIFJFVFBPTElORSBtYWNy
bw0KPj4gcmVmZXJlbmNlcyBpbnRvIENPTkZJR19SRVRQT0xJTkUgb25lcy4gQXMgYSByZXN1bHQs
IGluZGlyZWN0IGJyYW5jaGVzDQo+PiB0aGF0IGFyZSB1c2VkIGJ5IGluaXQgZnVuY3Rpb25zIGFy
ZSBub3Qga2VwdCAoaS5lLiwgdGhleSB1c2UNCj4+IHJldHBvbGluZXMpLCBhbmQgbW9kdWxlcyB0
aGF0IGRvIG5vdCB1c2UgcmV0cG9saW5lcyBhcmUgbWFya2VkIGFzDQo+PiByZXRwb2xpbmUtc2Fm
ZS4NCj4+IA0KPj4gRml4IGl0IGJlIGNoYW5naW5nIFJFVFBPTElORSBpbnRvIENPTkZJR19SRVRQ
T0xJTkUuDQo+PiANCj4+IEZpeGVzOiA0Y2QyNGRlM2EwOTggKCJ4ODYvcmV0cG9saW5lOiBNYWtl
IENPTkZJR19SRVRQT0xJTkUgZGVwZW5kIG9uIGNvbXBpbGVyIHN1cHBvcnQiKQ0KPj4gQ2M6IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4+IENjOiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5Ab3JhY2xlLmNvbT4NCj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4NCj4+IENjOiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNv
LnVrPg0KPj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPj4gQ2M6IE1h
c2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+DQo+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRA
dm13YXJlLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jICAgfCAy
ICstDQo+PiAgaW5jbHVkZS9saW51eC9jb21waWxlci1nY2MuaCB8IDIgKy0NCj4+ICBpbmNsdWRl
L2xpbnV4L21vZHVsZS5oICAgICAgIHwgMiArLQ0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2NwdS9idWdzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPj4gaW5kZXgg
ODY1NGI4YjBjODQ4Li4xZGUwZjQxNzAxNzggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L2J1Z3MuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4+IEBA
IC0yMTUsNyArMjE1LDcgQEAgc3RhdGljIGVudW0gc3BlY3RyZV92Ml9taXRpZ2F0aW9uIHNwZWN0
cmVfdjJfZW5hYmxlZCBfX3JvX2FmdGVyX2luaXQgPQ0KPj4gIHN0YXRpYyBlbnVtIHNwZWN0cmVf
djJfdXNlcl9taXRpZ2F0aW9uIHNwZWN0cmVfdjJfdXNlciBfX3JvX2FmdGVyX2luaXQgPQ0KPj4g
IAlTUEVDVFJFX1YyX1VTRVJfTk9ORTsNCj4+ICAtI2lmZGVmIFJFVFBPTElORQ0KPj4gKyNpZmRl
ZiBDT05GSUdfUkVUUE9MSU5FDQo+PiAgc3RhdGljIGJvb2wgc3BlY3RyZV92Ml9iYWRfbW9kdWxl
Ow0KPj4gICAgYm9vbCByZXRwb2xpbmVfbW9kdWxlX29rKGJvb2wgaGFzX3JldHBvbGluZSkNCj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdjYy5oIGIvaW5jbHVkZS9saW51
eC9jb21waWxlci1nY2MuaA0KPj4gaW5kZXggMjAxMDQ5M2UxMDQwLi45NzdkZGYyNzc0ZjkgMTAw
NjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdjYy5oDQo+PiArKysgYi9pbmNs
dWRlL2xpbnV4L2NvbXBpbGVyLWdjYy5oDQo+PiBAQCAtNjgsNyArNjgsNyBAQA0KPj4gICAqLw0K
Pj4gICNkZWZpbmUgdW5pbml0aWFsaXplZF92YXIoeCkgeCA9IHgNCj4+ICAtI2lmZGVmIFJFVFBP
TElORQ0KPj4gKyNpZmRlZiBDT05GSUdfUkVUUE9MSU5FDQo+PiAgI2RlZmluZSBfX25vcmV0cG9s
aW5lIF9fYXR0cmlidXRlX18oKF9faW5kaXJlY3RfYnJhbmNoX18oImtlZXAiKSkpDQo+PiAgI2Vu
ZGlmDQo+PiAgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmggYi9pbmNsdWRlL2xp
bnV4L21vZHVsZS5oDQo+PiBpbmRleCBmY2U2YjQzMzVlMzYuLjBjNTc1ZjUxZmU1NyAxMDA2NDQN
Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
bW9kdWxlLmgNCj4+IEBAIC04MTcsNyArODE3LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG1vZHVs
ZV9idWdfZmluYWxpemUoY29uc3QgRWxmX0VoZHIgKmhkciwNCj4+ICBzdGF0aWMgaW5saW5lIHZv
aWQgbW9kdWxlX2J1Z19jbGVhbnVwKHN0cnVjdCBtb2R1bGUgKm1vZCkge30NCj4+ICAjZW5kaWYJ
LyogQ09ORklHX0dFTkVSSUNfQlVHICovDQo+PiAgLSNpZmRlZiBSRVRQT0xJTkUNCj4+ICsjaWZk
ZWYgQ09ORklHX1JFVFBPTElORQ0KPj4gIGV4dGVybiBib29sIHJldHBvbGluZV9tb2R1bGVfb2so
Ym9vbCBoYXNfcmV0cG9saW5lKTsNCj4+ICAjZWxzZQ0KPj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBy
ZXRwb2xpbmVfbW9kdWxlX29rKGJvb2wgaGFzX3JldHBvbGluZSkNCj4gDQo+IFNvbWVvbmUgc2Vu
dCBhIHNpbWlsYXIgcGF0Y2ggbGFzdCBtb250aCwgc2VlIGJlbG93IGxpbmssICB5b3UgbWlzc2Vk
IHRoZSBjaGFuZ2UgaW4gc2NyaXB0cy9tb2QvbW9kcG9zdC5jDQoNCkluZGVlZC4gSSBtaXNzZWQg
dGhpcyBwYXRjaCBzaW5jZSBpdCB3YXNu4oCZdCBvbiB0aXAgKGFuZCBHb29nbGUgd2FzbuKAmXQN
CmhlbHBmdWwgZWl0aGVyKS4NCg0KSSB3b25kZXIgd2h5IGl0IGhhcyBzdGlsbCBub3QgYmVlbiBh
cHBsaWVkLg0KDQo=
