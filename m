Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BA420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XovoH0A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbfAPPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:54:15 -0500
Received: from mail-eopbgr720048.outbound.protection.outlook.com ([40.107.72.48]:12672
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726812AbfAPPyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBETAUDq2mwIrqMWSX7aFDxe1jXdL2yYsxqSW5O0rAs=;
 b=XovoH0A3GM19nlad1qwVE8NXxk41s0RMK+/zb3mllKDFD6R06DCBfRxzNcTnB0Xh7LZxyhBpjUAcvZEKDb39qiMPBuw6fU9/EXbr4lqQLUqHu9C4M5pRt8gad72/vie7gskK3AMjZvAdwVKw9rwmKkBM/j/i2AT2CxwumEF6zww=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1499.namprd12.prod.outlook.com (10.172.39.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 15:54:08 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:54:08 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUmYz8wtnOL0tCbku6Pwhl6uvgeqWyNFCA
Date:   Wed, 16 Jan 2019 15:54:07 +0000
Message-ID: <09e6d4f2-94c8-918c-4d54-0000c3d809b2@amd.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1499;20:OVEPQuBwuRjYrfsSIAOsfsM1k2rDAHWDUm8wvFEIvytnYwohmt99S7oaXUVxKSv7VIGGiLOmb3IVI1z4HJSRnsmmU4gGHY/dCZNT1a977br5MSTMIicZPbrWGyurazQA1Y7jgOtPXJkij2E0fSOf14nDlvb6JPuRzc2wrAaEDP029GQQ4pSUOIjXTI8DmP28Ym1ehUpCiVN2WOhpznxZ96PLhqWnZ2GTvRGAxl8wsNnWrPM9rUPlOKnD6gsR0yMJ
x-ms-office365-filtering-correlation-id: c1c4ea20-61f8-4829-abb1-08d67bcad926
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1499;
x-ms-traffictypediagnostic: DM5PR12MB1499:
x-microsoft-antispam-prvs: <DM5PR12MB149926BB6CDB87C15F6FF5EC95820@DM5PR12MB1499.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(54534003)(199004)(189003)(53936002)(36756003)(31686004)(6246003)(52116002)(2906002)(14444005)(256004)(106356001)(11346002)(446003)(66066001)(4326008)(476003)(2616005)(105586002)(486006)(316002)(6512007)(81156014)(8676002)(5660300001)(81166006)(71200400001)(305945005)(7736002)(71190400001)(110136005)(68736007)(53546011)(6506007)(386003)(6116002)(3846002)(26005)(31696002)(186003)(102836004)(76176011)(25786009)(72206003)(229853002)(478600001)(86362001)(14454004)(6436002)(97736004)(6486002)(8936002)(7416002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1499;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AP7xM8MES2V52/yKzguV5FFF3EYUtza4hCJr0cwQfgoYG1CuJArQbUY8JtbT/xcLo/61IKMVlUA3jl5dlppXz9tlZ0mkbPJVykn6kloFXJdfgXA0FcvOkxPbaoh1srTEHmqe5h//wrou5al6Ii4LB7N574h84vICCHYZsLd4H64ccPeRpg+hN2/lZV+GTY6jUCT3E8s9w1Muata3uMGgKgvosoLsBOYT/2yJzMUpN25/Ohss3ak8c9BhqbsoAJ8aoDRPDQ9JSJDtG7bISfnaezVRTadk1GGU+kNjWZsvQHQ/H77VT1bzDVThN9fXgbJs/xmPNd7yMYUsuB9Ay1TKXz6uBQjXzEKTT7CQclWw24m2KGemiu3P5A4cqU0P+JQQrpu7cQrl8r0YFx4guU+/UmXV2P2GW0byre212lB52e8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E470DC0B76A0DD4C984578789EAC7CBD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c4ea20-61f8-4829-abb1-08d67bcad926
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:54:06.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVuZ2h1YS9TYWkvQXJzaGl5YSwNCiAgV2Ugd2VyZSB0aGlua2luZyBvZiB1cGRhdGluZyB0
aGVzZSBzZWxmdGVzdHMgdG8gd29yayBvbiBib3RoIEludGVsIGFuZA0KQU1ELiBXaGF0IGRvIHlv
dSBndXlzIHRoaW5rPw0KDQpJZiB0aGF0IGlzIG9rLCBJIGNhbiB1cGRhdGUgdGhlc2UgcGF0Y2hl
cyBhbmQgcmVzdWJtaXQuIElmIHlvdSBoYXZlDQphbHJlYWR5IHVwZGF0ZWQsIHBsZWFzZSBwb3N0
IHRoZSBsYXRlc3Qgc2VyaWVzLiBJIHdpbGwgdXNlIHRoZSBsYXRlc3QNCnZlcnNpb24uIFBsZWFz
ZSBsZXQgbWUga25vdy4NClRoYW5rcw0KDQpPbiAxMi8yMS8xOCA2OjIwIFBNLCBGZW5naHVhIFl1
IHdyb3RlOg0KPiBXaXRoIG1vcmUgYW5kIG1vcmUgcmVzY3RybCBmZWF0dXJlcyBhcmUgYmVpbmcg
YWRkZWQgYnkgSW50ZWwsIEFNRA0KPiBhbmQgQVJNLCBhIHRlc3QgdG9vbCBpcyBiZWNvbWluZyBt
b3JlIGFuZCBtb3JlIHVzZWZ1bCB0byB2YWxpZGF0ZQ0KPiB0aGF0IGJvdGggaGFyZHdhcmUgYW5k
IHNvZnR3YXJlIGZ1bmN0aW9uYWxpdGllcyB3b3JrIGFzIGV4cGVjdGVkLg0KPiANCj4gV2UgaW50
cm9kdWNlIHJlc2N0cmwgc2VsZnRlc3QgdG8gY292ZXIgcmVzY3RybCBmZWF0dXJlcyBvbiBib3Ro
DQo+IFg4NiBhbmQgQVJNIGFyY2hpdGVjdHVyZXMuIEl0IGZpcnN0IGltcGxlbWVudHMgTUJNIChN
ZW1vcnkgQmFuZHdpZHRoDQo+IE1vbml0b3JpbmcpIGFuZCBNQkEgKE1lbW9yeSBCYW5kd2lkdGgg
QWxsb2NhdGlvbikgdGVzdHMuIFdlIGNhbiBlbmhhbmNlDQo+IHRoZSBzZWxmdGVzdCB0b29sIHRv
IGluY2x1ZGUgbW9yZSBmdW5jdGlvbmFsaXR5IHRlc3RzIGluIGZ1dHVyZS4NCj4gDQo+IFRoZXJl
IGlzIGFuIGV4aXN0aW5nIHJlc2N0cmwgdGVzdCBzdWl0ZSAnaW50ZWxfY210X2NhdCcuIEJ1dCB0
aGUgbWFqb3INCj4gcHVycG9zZSBvZiB0aGUgdG9vbCBpcyB0byB0ZXN0IEludGVsKFIpIFJEVCBo
YXJkd2FyZSB2aWEgd3JpdGluZyBhbmQNCj4gcmVhZGluZyBNU1IgcmVnaXN0ZXJzLiBJdCBkb2Vz
IGFjY2VzcyByZXNjdHJsIGZpbGUgc3lzdGVtOyBidXQgdGhlDQo+IGZ1bmN0aW9uYWxpdGllcyBh
cmUgdmVyeSBsaW1pdGVkLiBBbmQgaXQgZG9lc24ndCBzdXBwb3J0IGF1dG9tYXRpYyB0ZXN0DQo+
IGFuZCBhIGxvdCBvZiBtYW51YWwgdmVyaWZpY2F0aW9ucyBhcmUgaW52b2x2ZWQuDQo+IA0KPiBT
byB0aGUgc2VsZnRlc3QgdG9vbCB3ZSBhcmUgaW50cm9kdWNpbmcgaGVyZSBwcm92aWRlcyBhIGNv
bnZlbmllbnQNCj4gdG9vbCB3aGljaCBkb2VzIGF1dG9tYXRpYyByZXNjdHJsIHRlc3RpbmcsIGlz
IGVhc2lseSBhdmFpbGFibGUgaW4ga2VybmVsDQo+IHRyZWUsIGFuZCB3aWxsIGJlIGV4dGVuZGVk
IHRvIEFNRCBRb1MgYW5kIEFSTSBNUEFNLg0KPiANCj4gVGhlIHNlbGZ0ZXN0IHRvb2wgaXMgaW4g
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybCBpbiBvcmRlciB0byBoYXZlDQo+IGdlbmVy
aWMgdGVzdCBjb2RlIGZvciBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IENoYW5nZWxvZzoNCj4g
djQ6IA0KPiAtIGFkZHJlc3MgY29tbWVudHMgZnJvbSBCYWx1IGFuZCBSYW5keQ0KPiAtIEFkZCBD
QVQgYW5kIENRTSB0ZXN0cw0KPiANCj4gdjM6DQo+IC0gQ2hhbmdlIGNvZGUgYmFzZWQgb24gY29t
bWVudHMgZnJvbSBCYWJ1IE1vZ2VyDQo+IC0gUmVtb3ZlIHNvbWUgdW5uZXNzYXJ5IGNvZGUgYW5k
IHVzZSBwaXBlIHRvIGNvbW11bmljYXRlIGIvdyBwcm9jZXNzZXMNCj4gDQo+IHYyOg0KPiAtIENo
YW5nZSBjb2RlIGJhc2VkIG9uIGNvbW1lbnRzIGZyb20gQmFidSBNb2dlcg0KPiAtIENsZWFuIHVw
IG90aGVyIHBsYWNlcy4NCj4gDQo+IEFyc2hpeWEgSGF5YXRraGFuIFBhdGhhbiAoNCk6DQo+ICAg
c2VsZnRlc3RzL3Jlc2N0cmw6IEFkZCBNQk0gdGVzdA0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJsOiBB
ZGQgTUJBIHRlc3QNCj4gICBzZWxmdGVzdHMvcmVzY3RybCBBZGQgQ2FjaGUgUW9TIE1vbml0b3Jp
bmcgKENRTSkgc2VsZnRlc3QNCj4gICBzZWxmdGVzdHMvcmVzY3RybDogQWRkIENhY2hlIEFsbG9j
YXRpb24gVGVjaG5vbG9neSAoQ0FUKSBzZWxmdGVzdA0KPiANCj4gRmVuZ2h1YSBZdSAoMik6DQo+
ICAgc2VsZnRlc3RzL3Jlc2N0cmw6IEFkZCBSRUFETUUgZm9yIHJlc2N0cmwgdGVzdHMNCj4gICBz
ZWxmdGVzdHMvcmVzY3RybDogQWRkIHRoZSB0ZXN0IGluIE1BSU5UQUlORVJTDQo+IA0KPiBTYWkg
UHJhbmVldGggUHJha2h5YSAoNCk6DQo+ICAgc2VsZnRlc3RzL3Jlc2N0cmw6IEFkZCBiYXNpYyBy
ZXNjdHJsIGZpbGUgc3lzdGVtIG9wZXJhdGlvbnMgYW5kIGRhdGENCj4gICBzZWxmdGVzdHMvcmVz
Y3RybDogUmVhZCBtZW1vcnkgYmFuZHdpZHRoIGZyb20gcGVyZiBJTUMgY291bnRlciBhbmQNCj4g
ICAgIGZyb20gcmVzY3RybCBmaWxlIHN5c3RlbQ0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJsOiBBZGQg
Y2FsbGJhY2sgdG8gc3RhcnQgYSBiZW5jaG1hcmsNCj4gICBzZWxmdGVzdHMvcmVzY3RybDogQWRk
IGJ1aWx0IGluIGJlbmNobWFyaw0KPiANCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNj
dHJsL01ha2VmaWxlICAgICAgfCAgMTYgKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVz
Y3RybC9SRUFETUUgICAgICAgIHwgIDUzICsrDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL2NhY2hlLmMgICAgICAgfCAyNzUgKysrKysrKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jICAgIHwgMjQzICsrKysrKw0KPiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9jcW1fdGVzdC5jICAgIHwgMTY5ICsrKysNCj4gIHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYyAgICB8IDE5OCArKysrKw0KPiAgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jICAgIHwgMTc0ICsrKysrDQo+
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMgICAgfCAxNDYgKysr
Kw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmggICAgIHwgMTA0
ICsrKw0KPiAgLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybF90ZXN0cy5jIHwg
MTc1ICsrKysrDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdmFs
LmMgfCA3MjcgKysrKysrKysrKysrKysrKysrDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL3Jlc2N0cmxmcy5jICAgfCA2NDMgKysrKysrKysrKysrKysrKw0KPiAgMTMgZmlsZXMg
Y2hhbmdlZCwgMjkyNCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9NYWtlZmlsZQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvUkVBRE1FDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYWNoZS5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jDQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jcW1f
dGVzdC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVz
Y3RybC9maWxsX2J1Zi5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYm1fdGVzdC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmgNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYw0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVz
Y3RybF92YWwuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3Jlc2N0cmwvcmVzY3RybGZzLmMNCj4gDQo=
