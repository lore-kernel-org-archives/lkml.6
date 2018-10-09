Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC46C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65660213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sJ5NErWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65660213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJJEgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:36:14 -0400
Received: from mail-cys01nam02on0072.outbound.protection.outlook.com ([104.47.37.72]:15104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeJJEgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omAa6+1CMpVAHL0l0igpjo6pFoKH35RUUMf/gqApGfc=;
 b=sJ5NErWEk7xqFSCDBNt+9m+kpoK26lkNDx5th6l6UNQDnjPezW4dw5tnupL1TBMxk18biVRvjsDylEPxpkjh0BmdSfvwYVlBAQzPcpWaYKZfa+LlPH5G4upY6542I+xxL+yLP3vgys5G4TG/7aPTLmKMRYmZT0oj2MLZC9sejpM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1612.namprd12.prod.outlook.com (10.172.40.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Tue, 9 Oct 2018 21:17:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Tue, 9 Oct 2018
 21:17:16 +0000
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
Thread-Index: AQHUXO3FhE3rddQXr0iDhqiTp63CXqUXI24AgABNloA=
Date:   Tue, 9 Oct 2018 21:17:16 +0000
Message-ID: <ddec0530-59d1-fee0-eb67-528b887ca3f5@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-2-babu.moger@amd.com>
 <2fe2e853-47ef-af2a-6906-9ad7a7b8bba9@intel.com>
In-Reply-To: <2fe2e853-47ef-af2a-6906-9ad7a7b8bba9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:300:ef::13) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1612;20:KE6jtDkx8fS2zrlKX6QgGNFsuPks4qNAbfxOptl5TXsoefRv/hjVeIK0k1OCH6xrXHt3XM1sI29aj9DDf1XnBcqSAJgOI7bFqSCj6Mc1PZ34LGHF0ZlDhLIozU4tPoZUeYrW5SB1BB5Y3QN14QvSjhbqIi0TIv8Dd2jNtJpCl/R7nuO39uLCwsGTUHaIzHttQu5CrdwGoHQdc32fEftEun6vWvDkIrG/rCnR4qAxaMmQAsSbKjTBWAtPuM6QqWzK
x-ms-office365-filtering-correlation-id: 7f5784fd-c697-407b-19d1-08d62e2c968d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1612;
x-ms-traffictypediagnostic: DM5PR12MB1612:
x-microsoft-antispam-prvs: <DM5PR12MB16126CA5F5A9D1EFCB0A878B95E70@DM5PR12MB1612.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1612;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(7736002)(2906002)(102836004)(66066001)(26005)(305945005)(6512007)(86362001)(2201001)(31696002)(316002)(3846002)(71200400001)(2900100001)(6116002)(7416002)(186003)(97736004)(71190400001)(106356001)(72206003)(68736007)(8676002)(52116002)(31686004)(53936002)(478600001)(486006)(81166006)(53546011)(5250100002)(476003)(81156014)(76176011)(6486002)(11346002)(99286004)(2616005)(386003)(6506007)(105586002)(25786009)(446003)(229853002)(8936002)(14444005)(256004)(36756003)(4326008)(54906003)(2501003)(6436002)(110136005)(14454004)(6246003)(5660300001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1612;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GeR0R46bqIiTgFMiaWjXCulIB+byc2rGXFRSFhorO8v8tOjPEXvulER48X9Sm9B6Mp8u8uwHGfUY2ghWMYAzLTS0836tgr4zg27SHNb+k5kkFDhFWPIveY+bl0JQqGfD7Keh8Wn6a8eHTe6J8OEwsdRfRijWakxux36wQP4/+vsc5ZQuLMW48Zmh2iyl/CPwvATJr5z+2J8dq2g2KZsS15iIEH67+Leuz2cBizrEbAjIeB1E2lioeN3hCsy76WfkBDAJoqzsZ8P46Uu+S9xI9yZJBlWqVGmlaug529udDWl706Ep9XBbQIwe6CClQ8dFxc6fJ0T7luAJJDJ7FPI7yCHph2Mhvcr3wEXQ2HecUe4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE7A0E9D8E8C0479B9BCBAD443622A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5784fd-c697-407b-19d1-08d62e2c968d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 21:17:16.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCk9uIDEwLzA5LzIwMTggMTE6MzkgQU0sIFJlaW5ldHRlIENoYXRyZSB3
cm90ZToNCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEwLzUvMjAxOCAxOjU1IFBNLCBNb2dlciwgQmFi
dSB3cm90ZToNCj4+IE5ldyBnZW5lcmF0aW9uIG9mIEFNRCBwcm9jZXNzb3JzIHN0YXJ0IHN1cHBv
cnQgUkRUKG9yIFFPUykgZmVhdHVyZXMuDQo+PiBXaXRoIG1vcmUgdGhhbiBvbmUgdmVuZG9ycyBz
dXBwb3J0aW5nIHRoZXNlIGZlYXR1cmVzLCBpdCBzZWVtcyBtb3JlDQo+PiBhcHByb3ByaWF0ZSB0
byByZW5hbWUgdGhlc2UgZmlsZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8
YmFidS5tb2dlckBhbWQuY29tPg0KPj4gLS0tDQo+PiAgYXJjaC94ODYvaW5jbHVkZS9hc20ve2lu
dGVsX3JkdF9zY2hlZC5oID0+IHJkdF9zY2hlZC5ofSAgICAgfCAwDQo+PiAgYXJjaC94ODYva2Vy
bmVsL2NwdS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2ICsrKy0t
LQ0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdC5jID0+IHJkdC5jfSAgICAgICAg
ICAgICAgICAgIHwgNCArKy0tDQo+PiAgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0Lmgg
PT4gcmR0Lmh9ICAgICAgICAgICAgICAgICAgfCAwDQo+PiAgLi4uL2NwdS97aW50ZWxfcmR0X2N0
cmxtb25kYXRhLmMgPT4gcmR0X2N0cmxtb25kYXRhLmN9ICAgICAgfCAyICstDQo+PiAgYXJjaC94
ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X21vbml0b3IuYyA9PiByZHRfbW9uaXRvci5jfSAgfCAy
ICstDQo+PiAgLi4uL2NwdS97aW50ZWxfcmR0X3BzZXVkb19sb2NrLmMgPT4gcmR0X3BzZXVkb19s
b2NrLmN9ICAgICAgfCA2ICsrKy0tLQ0KPj4gIC4uLm50ZWxfcmR0X3BzZXVkb19sb2NrX2V2ZW50
LmggPT4gcmR0X3BzZXVkb19sb2NrX2V2ZW50Lmh9IHwgMiArLQ0KPj4gIC4uLi94ODYva2VybmVs
L2NwdS97aW50ZWxfcmR0X3JkdGdyb3VwLmMgPT4gcmR0X3JkdGdyb3VwLmN9IHwgNCArKy0tDQo+
PiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfMzIuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAyICstDQo+PiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+PiAgMTEgZmlsZXMgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+PiAgcmVuYW1lIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3tpbnRlbF9yZHRfc2NoZWQuaCA9PiByZHRfc2NoZWQuaH0gKDEwMCUpDQo+PiAgcmVuYW1l
IGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdC5jID0+IHJkdC5jfSAoOTklKQ0KPj4gIHJl
bmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHQuaCA9PiByZHQuaH0gKDEwMCUpDQo+
PiAgcmVuYW1lIGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdF9jdHJsbW9uZGF0YS5jID0+
IHJkdF9jdHJsbW9uZGF0YS5jfSAoOTklKQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1
L3tpbnRlbF9yZHRfbW9uaXRvci5jID0+IHJkdF9tb25pdG9yLmN9ICg5OSUpDQo+PiAgcmVuYW1l
IGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdF9wc2V1ZG9fbG9jay5jID0+IHJkdF9wc2V1
ZG9fbG9jay5jfSAoOTklKQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9y
ZHRfcHNldWRvX2xvY2tfZXZlbnQuaCA9PiByZHRfcHNldWRvX2xvY2tfZXZlbnQuaH0gKDk1JSkN
Cj4+ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3JkdGdyb3VwLmMgPT4g
cmR0X3JkdGdyb3VwLmN9ICg5OSUpDQo+IA0KPiBEdXJpbmcgdGhlIFJGQyBpdCB3YXMgYWdyZWVk
IHRoYXQgInJlc2N0cmwiIHdpbGwgYmUgdGhlIG5ldXRyYWwgbmFtZSBhbmQNCj4gImludGVsX3Jk
dCIsICJhbWRfcW9zIiwgb3IgImFybSBtcGFtIiB3b3VsZCBiZSB0aGUgdmVuZG9yIHNwZWNpZmlj
IG5hbWVzLg0KPiANCj4gSXQgaXMgb2sgdG8gZGVsYXkgdGhhdCByZW5hbWluZyBidXQgSSB0aGlu
ayBhbnkgcmVuYW1pbmcgZG9uZSBmcm9tIHRoaXMNCj4gcG9pbnQgc2hvdWxkIHJlc3BlY3QgdGhp
cyBhZ3JlZW1lbnQuDQo+IA0KPiBGb3IgZXhhbXBsZSwgaWYgeW91IHdhbnQgdG8gcmVuYW1lIGlu
dGVsX3JkdC5jIHRoZW4gcGxlYXNlIHJlbmFtZSBpdCB0bw0KPiByZXNjdHJsLmMgaW5zdGVhZCBv
ZiBqdXN0IHJkdC5jIHdoaWNoIGRvZXMgbm90IHJlcHJlc2VudCBhIGdlbmVyaWMgbmFtZQ0KPiBh
cyBleHByZXNzZWQgYXMgYSBnb2FsIGluIHRoZSBzdWJqZWN0IG9mIHRoaXMgcGF0Y2guDQoNCkkg
a25ldyB0aGlzIHdhcyBnb2luZyB0byBiaXQgdHJpY2t5LiBJIGNhbiBjaGFuZ2UgYWxsIHRoZSBw
bGFjZXMgd2hlcmUgSQ0KYW0gdG91Y2hpbmcgdGhlIGNvZGUgdG8gZ2VuZXJpYyBuYW1lcyhjaGFu
Z2UgZnJvbSBpbnRlbF9yZHQgdG8gInJlc2N0cmwiKS4NCkFsc28gbGV0cyBjaGFuZ2UgdGhlICJ0
ZXh0cyIgd2hpY2ggYXJlIHZpc2libGUgdG8gdXNlciB0byBtYWtlIGl0IG1vcmUNCmdlbmVyaWMu
DQoNCkJ1dCAicmR0IiBoYXMgYmVlbiB1c2VkIGdlbmVyb3VzbHkgaW4gbXVsdGlwbGUgZmlsZXMo
bGlrZSByZHRfcmVzb3VyY2UsDQpyZHRfZG9tYWluIGV0YykuIENoYW5naW5nIHRob3NlIGRlZmlu
aXRpb25zIGFuZCBmdW5jdGlvbnMgd2lsbCBiZSBtZXNzaWVyLg0KSSB3aWxsIG5vdCB3b3JyeSBh
Ym91dCBpdCBub3cuIFRob3VnaHRzPw0KDQo+IA0KPiBSZWluZXR0ZQ0KPiANCg==
