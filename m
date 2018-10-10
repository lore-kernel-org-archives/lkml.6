Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65974C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D792087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UcG0pQGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D792087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJJVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:33:55 -0400
Received: from mail-eopbgr710083.outbound.protection.outlook.com ([40.107.71.83]:30123
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeJJVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfoRu6XTTBDENntRYyAdvAjRCInFwXOofLX+yrBLSBw=;
 b=UcG0pQGvAsa3AlFvE+3Vz0TuUL0JRgnOUythq7KQcFqe0spi3sAhXOUROSGHndPneUmCjvRQewYeX7i2xHszlowqGipmMcdzoyjCQSytl/Ms2CSiq7JEhQOSvguLQE/yCZ0Tiqtht2s7JXu5bfDJzxkeMlJO59TPmvCviXZTmmk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2407.namprd12.prod.outlook.com (52.132.141.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 10 Oct 2018 14:11:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 14:11:13 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v2 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUXO3FhE3rddQXr0iDhqiTp63CXqUXI24A///5xICAAGAdgIABDwGA
Date:   Wed, 10 Oct 2018 14:11:13 +0000
Message-ID: <b2e7630a-db5c-9f69-5d7e-cac3e2bb4014@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-2-babu.moger@amd.com>
 <2fe2e853-47ef-af2a-6906-9ad7a7b8bba9@intel.com>
 <ddec0530-59d1-fee0-eb67-528b887ca3f5@amd.com>
 <ab692687-6398-cf9a-a027-b9ff4b3ffd5f@intel.com>
In-Reply-To: <ab692687-6398-cf9a-a027-b9ff4b3ffd5f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:404:b4::23) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2407;20:7sYDdi7pujEpApyO3o/zGK1r72QiVMdMa6LKYIxi0tCsDqxpWuRVsl+W5ilaK+Q8lBEyN1wA72CIPRNm3K3PiYWYyhYGd9PUjAXrSKZLgiyvUIT9w3/bKeJdP1wiGInVcAhrmtIF/CNnrAg5PhZW99pcMUPyafgL1biMMXiyHjiZycJ5DOYjtwb+B8m9SYyQLI71fxCyjGkuXviNiV5Ecqd+Q/QZedd/o6tmkOL+Nw4KKMwBUXmLh7dvgN/qk11u
x-ms-office365-filtering-correlation-id: 83f37336-ba5f-4b8e-0277-08d62eba3c4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2407;
x-ms-traffictypediagnostic: DM5PR12MB2407:
x-microsoft-antispam-prvs: <DM5PR12MB24078678EFA22F296260BEB895E00@DM5PR12MB2407.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB2407;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2407;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(43544003)(189003)(199004)(86362001)(2616005)(31696002)(476003)(81166006)(76176011)(478600001)(6506007)(386003)(446003)(81156014)(102836004)(31686004)(93886005)(2201001)(52116002)(53546011)(6486002)(5250100002)(2501003)(8676002)(11346002)(97736004)(66066001)(6436002)(14454004)(316002)(72206003)(14444005)(256004)(53936002)(2906002)(6512007)(4326008)(229853002)(3846002)(2900100001)(71190400001)(71200400001)(6246003)(105586002)(6116002)(486006)(68736007)(7416002)(26005)(106356001)(186003)(8936002)(110136005)(7736002)(25786009)(99286004)(54906003)(305945005)(5660300001)(36756003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2407;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xPiJ4vkbbDXHaRaP5pGnOB6+mSXkI8rTrXu4c6/8VpiaWMK3CI2p3i4eH8O/hIUL1KxPCdujjqlunoTCAzCM3N2qzi93PMP4DIa6VfdNrJajpxi5MFwHxwYcf9yHhUCPantbvdsCuYMMXNAgif2PBB7h+MhvASPpITgeoSBbFJUJ4oRAiL7VQy2FbWgG1XV/NunvmOFGUGgyMB5B9ggfVOiZ6exfcorkFA7NbBSzq6X2VqgJ11Z0vySjSOUwCDPkkemHv8AuXlvWIPBO6io+CZzg6gDpZeE8FMzA8FPIDpSHWl40fSA5qV2gm6ZO3IAZF9WldlG0Yc7OKX/GazYzNTPrg4Gu7kOofiZlgfGfWso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <453C648E627E3849BE60E6537DB1E2D6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f37336-ba5f-4b8e-0277-08d62eba3c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 14:11:13.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCk9uIDEwLzA5LzIwMTggMDU6MDEgUE0sIFJlaW5ldHRlIENoYXRyZSB3
cm90ZToNCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEwLzkvMjAxOCAyOjE3IFBNLCBNb2dlciwgQmFi
dSB3cm90ZToNCj4+IE9uIDEwLzA5LzIwMTggMTE6MzkgQU0sIFJlaW5ldHRlIENoYXRyZSB3cm90
ZToNCj4+PiBIaSBCYWJ1LA0KPj4+DQo+Pj4gT24gMTAvNS8yMDE4IDE6NTUgUE0sIE1vZ2VyLCBC
YWJ1IHdyb3RlOg0KPj4+PiBOZXcgZ2VuZXJhdGlvbiBvZiBBTUQgcHJvY2Vzc29ycyBzdGFydCBz
dXBwb3J0IFJEVChvciBRT1MpIGZlYXR1cmVzLg0KPj4+PiBXaXRoIG1vcmUgdGhhbiBvbmUgdmVu
ZG9ycyBzdXBwb3J0aW5nIHRoZXNlIGZlYXR1cmVzLCBpdCBzZWVtcyBtb3JlDQo+Pj4+IGFwcHJv
cHJpYXRlIHRvIHJlbmFtZSB0aGVzZSBmaWxlcy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
QmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3tpbnRlbF9yZHRfc2NoZWQuaCA9PiByZHRfc2NoZWQuaH0gICAgIHwgMA0K
Pj4+PiAgYXJjaC94ODYva2VybmVsL2NwdS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA2ICsrKy0tLQ0KPj4+PiAgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0
LmMgPT4gcmR0LmN9ICAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4+Pj4gIGFyY2gveDg2L2tl
cm5lbC9jcHUve2ludGVsX3JkdC5oID0+IHJkdC5ofSAgICAgICAgICAgICAgICAgIHwgMA0KPj4+
PiAgLi4uL2NwdS97aW50ZWxfcmR0X2N0cmxtb25kYXRhLmMgPT4gcmR0X2N0cmxtb25kYXRhLmN9
ICAgICAgfCAyICstDQo+Pj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfbW9uaXRv
ci5jID0+IHJkdF9tb25pdG9yLmN9ICB8IDIgKy0NCj4+Pj4gIC4uLi9jcHUve2ludGVsX3JkdF9w
c2V1ZG9fbG9jay5jID0+IHJkdF9wc2V1ZG9fbG9jay5jfSAgICAgIHwgNiArKystLS0NCj4+Pj4g
IC4uLm50ZWxfcmR0X3BzZXVkb19sb2NrX2V2ZW50LmggPT4gcmR0X3BzZXVkb19sb2NrX2V2ZW50
Lmh9IHwgMiArLQ0KPj4+PiAgLi4uL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfcmR0Z3JvdXAu
YyA9PiByZHRfcmR0Z3JvdXAuY30gfCA0ICsrLS0NCj4+Pj4gIGFyY2gveDg2L2tlcm5lbC9wcm9j
ZXNzXzMyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgYXJj
aC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAyICstDQo+Pj4+ICAxMSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkNCj4+Pj4gIHJlbmFtZSBhcmNoL3g4Ni9pbmNsdWRlL2FzbS97aW50ZWxfcmR0X3Nj
aGVkLmggPT4gcmR0X3NjaGVkLmh9ICgxMDAlKQ0KPj4+PiAgcmVuYW1lIGFyY2gveDg2L2tlcm5l
bC9jcHUve2ludGVsX3JkdC5jID0+IHJkdC5jfSAoOTklKQ0KPj4+PiAgcmVuYW1lIGFyY2gveDg2
L2tlcm5lbC9jcHUve2ludGVsX3JkdC5oID0+IHJkdC5ofSAoMTAwJSkNCj4+Pj4gIHJlbmFtZSBh
cmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfY3RybG1vbmRhdGEuYyA9PiByZHRfY3RybG1v
bmRhdGEuY30gKDk5JSkNCj4+Pj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9y
ZHRfbW9uaXRvci5jID0+IHJkdF9tb25pdG9yLmN9ICg5OSUpDQo+Pj4+ICByZW5hbWUgYXJjaC94
ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3BzZXVkb19sb2NrLmMgPT4gcmR0X3BzZXVkb19sb2Nr
LmN9ICg5OSUpDQo+Pj4+ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3Bz
ZXVkb19sb2NrX2V2ZW50LmggPT4gcmR0X3BzZXVkb19sb2NrX2V2ZW50Lmh9ICg5NSUpDQo+Pj4+
ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3JkdGdyb3VwLmMgPT4gcmR0
X3JkdGdyb3VwLmN9ICg5OSUpDQo+Pj4NCj4+PiBEdXJpbmcgdGhlIFJGQyBpdCB3YXMgYWdyZWVk
IHRoYXQgInJlc2N0cmwiIHdpbGwgYmUgdGhlIG5ldXRyYWwgbmFtZSBhbmQNCj4+PiAiaW50ZWxf
cmR0IiwgImFtZF9xb3MiLCBvciAiYXJtIG1wYW0iIHdvdWxkIGJlIHRoZSB2ZW5kb3Igc3BlY2lm
aWMgbmFtZXMuDQo+Pj4NCj4+PiBJdCBpcyBvayB0byBkZWxheSB0aGF0IHJlbmFtaW5nIGJ1dCBJ
IHRoaW5rIGFueSByZW5hbWluZyBkb25lIGZyb20gdGhpcw0KPj4+IHBvaW50IHNob3VsZCByZXNw
ZWN0IHRoaXMgYWdyZWVtZW50Lg0KPj4+DQo+Pj4gRm9yIGV4YW1wbGUsIGlmIHlvdSB3YW50IHRv
IHJlbmFtZSBpbnRlbF9yZHQuYyB0aGVuIHBsZWFzZSByZW5hbWUgaXQgdG8NCj4+PiByZXNjdHJs
LmMgaW5zdGVhZCBvZiBqdXN0IHJkdC5jIHdoaWNoIGRvZXMgbm90IHJlcHJlc2VudCBhIGdlbmVy
aWMgbmFtZQ0KPj4+IGFzIGV4cHJlc3NlZCBhcyBhIGdvYWwgaW4gdGhlIHN1YmplY3Qgb2YgdGhp
cyBwYXRjaC4NCj4+DQo+PiBJIGtuZXcgdGhpcyB3YXMgZ29pbmcgdG8gYml0IHRyaWNreS4gSSBj
YW4gY2hhbmdlIGFsbCB0aGUgcGxhY2VzIHdoZXJlIEkNCj4+IGFtIHRvdWNoaW5nIHRoZSBjb2Rl
IHRvIGdlbmVyaWMgbmFtZXMoY2hhbmdlIGZyb20gaW50ZWxfcmR0IHRvICJyZXNjdHJsIikuDQo+
IA0KPiBZZXMsICJpbnRlbF9yZHQiIGNhbiBiZSBjaGFuZ2VkIHRvIHRoZSBnZW5lcmljICJyZXNj
dHJsIiB3aGVuIGl0IGlzIG5vdA0KPiB2ZW5kb3Igc3BlY2lmaWMuDQoNCk9rLiBzdXJlLg0KDQo+
IA0KPiBBcyBmYXIgYXMgYWxsIHRoZSBjb2RlIHlvdSB0b3VjaCBpcyBjb25jZXJuZWQgaXQgbWF5
IGJlIGVhc2llciBhbmQgY2F1c2UNCj4gbGVzcyBjb25mdXNpb24gZm9yIG5vdyB0byBqdXN0IGZv
bGxvdyB0aGUgY3VycmVudCBuYW1pbmcgY29udmVudGlvbnMgYXMNCj4geW91IGhhdmUgZG9uZSBp
biBwYXRjaGVzIDMgb253YXJkcyBhbmQgaGF2ZSBpdCBiZSBpbmNsdWRlZCBpbiB0aGUgbGF0ZXIN
Cj4gbGFyZ2VyIHJlc3RydWN0dXJpbmcuDQoNClllcy4gSSBhbSBtYWtpbmcgc3VyZSBmaXJzdCAz
IHBhdGNoZXMgYXJlIHJlbmFtZWQgdG8gInJlc2N0cmwiIHdoZXJldmVyDQphcHBsaWNhYmxlLiBX
aWxsIHNlbmQgdGhlIHBhdGNoZXMgc29vbi4NCg0KQnV0IEkgYW0gY29uZnVzZWQgYWJvdXQgd2hh
dCB5b3UgbWVhbnQgYnkgImhhdmUgaXQgYmUgaW5jbHVkZWQgaW4gdGhlDQpsYXRlciBsYXJnZXIg
cmVzdHJ1Y3R1cmluZyIuIENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZT8NCg0KPiANCj4+IEFsc28g
bGV0cyBjaGFuZ2UgdGhlICJ0ZXh0cyIgd2hpY2ggYXJlIHZpc2libGUgdG8gdXNlciB0byBtYWtl
IGl0IG1vcmUNCj4+IGdlbmVyaWMuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3
aGF0IHlvdSBtZWFuIHdpdGggInRleHRzIiBoZXJlPyBBcmUgeW91DQo+IHJlZmVycmluZyB0byB0
aGUgcHJfaW5mbygpIGZvdW5kIGluIGludGVsX3JkdF9sYXRlX2luaXQoKT8gSGVyZSBpdCBtYXkN
Cj4gYmUgZ29vZCB0byBhbHNvIGNoYW5nZSB0byBwcmludCAiUkVTQ1RSTCAlcyBhbGxvY2F0aW9u
DQo+IGRldGVjdGVkIi8iUkVTQ1RSTCAlcyBtb25pdG9yaW5nIGRldGVjdGVkIiAtIHRoZSByZXNv
dXJjZSBuYW1lcyBwcmludGVkDQo+IGFyZSBhbHJlYWR5IGdlbmVyaWMuDQoNClllcy4gSSBtZWFu
dCBwcl9pbmZvIHRleHQuICBXaWxsIGNoYW5nZSBpdCB0byBwcmludCAiUkVTQ1RSTCINCg0KPiAN
Cj4+IEJ1dCAicmR0IiBoYXMgYmVlbiB1c2VkIGdlbmVyb3VzbHkgaW4gbXVsdGlwbGUgZmlsZXMo
bGlrZSByZHRfcmVzb3VyY2UsDQo+PiByZHRfZG9tYWluIGV0YykuIENoYW5naW5nIHRob3NlIGRl
ZmluaXRpb25zIGFuZCBmdW5jdGlvbnMgd2lsbCBiZSBtZXNzaWVyLg0KPj4gSSB3aWxsIG5vdCB3
b3JyeSBhYm91dCBpdCBub3cuIFRob3VnaHRzPw0KPiANCj4gSSBhZ3JlZS4gTXkgY29tbWVudHMg
d2VyZSBzcGVjaWZpYyB0byB0aGUgZmlyc3QgdHdvIHBhdGNoZXMgb2YgdGhpcw0KPiBzZXJpZXMg
dGhhdCBzdGFydGVkIGRvaW5nIHRoZSByZW5hbWluZyBidXQgbm90IHVzaW5nIHRoZSBhZ3JlZWQg
dXBvbg0KPiBuYW1pbmcgLSBlc3BlY2lhbGx5IHNpbmNlIGJvdGggdGhvc2UgcGF0Y2hlcyBjbGFp
bSB0byB0cmFuc2l0aW9uIHRvDQo+IGdlbmVyaWMgbmFtZXMuIENvdWxkIGp1c3QgdGhlc2UgdHdv
IHBhdGNoZXMgYmUgbW9kaWZpZWQgdG8gY2hhbmdlDQo+ICJpbnRlbF9yZHQiIHRvICJyZXNjdHJs
IiBpbnN0ZWFkIG9mICJpbnRlbF9yZHQiIHRvICJyZHQiIGFzIGl0IGN1cnJlbnRseQ0KPiBkb2Vz
Pw0KDQpTdXJlLiAgV2lsbCB0YWtlIGNhcmUgb2YgdGhhdC4NCg0KPiANCj4gUmVpbmV0dGUNCj4g
DQo+IA0K
