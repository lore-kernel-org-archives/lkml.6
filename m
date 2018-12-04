Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2487FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24BC2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oE8BYLbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24BC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLDHf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:35:28 -0500
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:60092
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeLDHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBDP7Kk02NPeC92UqLiHPjNDe9HImNDn2BeTcXyJzQo=;
 b=oE8BYLbvTq5b7ka4+NbWuKv4RZS4azWfIZXxEHmts0Wqs+kOXqIwMuaRD4ztrRwTG25PWgohUXBoOcSvyHWTWnBdxtt2Vu7CIa7nF+Xm+3RBF5bjr1spRELdvL0Fmw4f1Mn5JU++VTZdmdBmpfOYs+p9pGJ+DdysTcgqg9/Gk70=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1474.namprd12.prod.outlook.com (10.172.24.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 07:35:22 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 07:35:22 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/3] mmu notifier contextual informations
Thread-Topic: [PATCH 0/3] mmu notifier contextual informations
Thread-Index: AQHUi0Vdc/+CEnIZ60uHmIm7nwnGRqVuMUCA
Date:   Tue, 4 Dec 2018 07:35:22 +0000
Message-ID: <2c0ed01b-50f9-961b-ff08-de494e00b1b4@amd.com>
References: <20181203201817.10759-1-jglisse@redhat.com>
In-Reply-To: <20181203201817.10759-1-jglisse@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0601CA0038.eurprd06.prod.outlook.com
 (2603:10a6:203:68::24) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1474;20:92yLd+WTlweBHcW9jmquDibmB4HRIVXfzaMWDAA0AMZgEvWILwgjoJwfQYEVubfIwmiZ7rRYYveeH6H/Lihyq/OM1qoRflDufChN0YLl9rBUrcRkgjKuyaQbJ3flzgTShtmHNmjU5uyJyttLjP+vhtdcdJRinr1murCYyy4GAWQkI+Qf7kfzx2SCtbM0RuGrqz3+M9FnihpIdriatou57/0SJGKx+UeRklJNQpm+cp9WosA5KV0dg49ccsWgh9Kc
x-ms-office365-filtering-correlation-id: 6fa6de39-a9a5-4a61-b353-08d659bb0c45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1474;
x-ms-traffictypediagnostic: BN6PR12MB1474:
x-microsoft-antispam-prvs: <BN6PR12MB14740137572AE1C7BAF4F4DC83AF0@BN6PR12MB1474.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1474;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1474;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(186003)(386003)(476003)(2616005)(11346002)(446003)(52116002)(65826007)(6506007)(102836004)(4326008)(64126003)(68736007)(486006)(7736002)(65806001)(65956001)(305945005)(6246003)(66574009)(6512007)(99286004)(76176011)(81156014)(81166006)(7416002)(5660300001)(71190400001)(46003)(71200400001)(256004)(8936002)(14444005)(53936002)(8676002)(229853002)(2906002)(36756003)(31696002)(6116002)(316002)(478600001)(6436002)(54906003)(110136005)(14454004)(72206003)(6486002)(58126008)(25786009)(106356001)(105586002)(2501003)(97736004)(31686004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1474;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qNJ/4s3Q9ZUjpCThqknie00Q9w9eJnOcslsFDyfShEnJJmmYRlObFcAr27IsRpNqaIdvaG3OntUzRkOEXD554CCDw4GeJ64bMNA+b46DBOHpNjZZd9rNMLmpBqgfSuQxnFtp7EDqEDfNkYrdesD2OKG/vDywfbNNfKjoMrJ7pmxOWlrovzC8qr5VkKHKDVPO5HLLDUQvAtdpSRfINnmlI8dVdjUewDb2Nl8m0RGDl5MWQXHZV8jEnmrOdg8SSCISxoeKU1KCA/r6t3lpPUCLd2JP5dq0vZFbs8oMWBUGbR8tCRP/4QYpKl50XfZYH2Lz7sWHxtddgs8wcIZ8eiDqPO0r0KIUvZDC6SG/VDgp41M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <26511A7B4182974B950897019B73A37F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa6de39-a9a5-4a61-b353-08d659bb0c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 07:35:22.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDMuMTIuMTggdW0gMjE6MTggc2NocmllYiBqZ2xpc3NlQHJlZGhhdC5jb206DQo+IEZyb206
IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPg0KPg0KPiBUaGlzIHBhdGNoc2V0
IGFkZCBjb250ZXh0dWFsIGluZm9ybWF0aW9uLCB3aHkgYW4gaW52YWxpZGF0aW9uIGlzDQo+IGhh
cHBlbmluZywgdG8gbW11IG5vdGlmaWVyIGNhbGxiYWNrLiBUaGlzIGlzIG5lY2Vzc2FyeSBmb3Ig
dXNlcg0KPiBvZiBtbXUgbm90aWZpZXIgdGhhdCB3aXNoIHRvIG1haW50YWlucyB0aGVpciBvd24g
ZGF0YSBzdHJ1Y3R1cmUNCj4gd2l0aG91dCBoYXZpbmcgdG8gYWRkIG5ldyBmaWVsZHMgdG8gc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICh2bWEpLg0KPg0KPiBGb3IgaW5zdGFuY2UgZGV2aWNlIGNhbiBo
YXZlIHRoZXkgb3duIHBhZ2UgdGFibGUgdGhhdCBtaXJyb3IgdGhlDQo+IHByb2Nlc3MgYWRkcmVz
cyBzcGFjZS4gV2hlbiBhIHZtYSBpcyB1bm1hcCAobXVubWFwKCkgc3lzY2FsbCkgdGhlDQo+IGRl
dmljZSBkcml2ZXIgY2FuIGZyZWUgdGhlIGRldmljZSBwYWdlIHRhYmxlIGZvciB0aGUgcmFuZ2Uu
DQo+DQo+IFRvZGF5IHdlIGRvIG5vdCBoYXZlIGFueSBpbmZvcm1hdGlvbiBvbiB3aHkgYSBtbXUg
bm90aWZpZXIgY2FsbA0KPiBiYWNrIGlzIGhhcHBlbmluZyBhbmQgdGh1cyBkZXZpY2UgZHJpdmVy
IGhhdmUgdG8gYXNzdW1lIHRoYXQgaXQNCj4gaXMgYWx3YXlzIGFuIG11bm1hcCgpLiBUaGlzIGlz
IGluZWZmaWNpZW50IGF0IGl0IG1lYW5zIHRoYXQgaXQNCj4gbmVlZHMgdG8gcmUtYWxsb2NhdGUg
ZGV2aWNlIHBhZ2UgdGFibGUgb24gbmV4dCBwYWdlIGZhdWx0IGFuZA0KPiByZWJ1aWxkIHRoZSB3
aG9sZSBkZXZpY2UgZHJpdmVyIGRhdGEgc3RydWN0dXJlIGZvciB0aGUgcmFuZ2UuDQo+DQo+IE90
aGVyIHVzZSBjYXNlIGJlc2lkZSBtdW5tYXAoKSBhbHNvIGV4aXN0LCBmb3IgaW5zdGFuY2UgaXQg
aXMNCj4gcG9pbnRsZXNzIGZvciBkZXZpY2UgZHJpdmVyIHRvIGludmFsaWRhdGUgdGhlIGRldmlj
ZSBwYWdlIHRhYmxlDQo+IHdoZW4gdGhlIGludmFsaWRhdGlvbiBpcyBmb3IgdGhlIHNvZnQgZGly
dHluZXNzIHRyYWNraW5nLiBPcg0KPiBkZXZpY2UgZHJpdmVyIGNhbiBvcHRpbWl6ZSBhd2F5IG1w
cm90ZWN0KCkgdGhhdCBjaGFuZ2UgdGhlIHBhZ2UNCj4gdGFibGUgcGVybWlzc2lvbiBhY2Nlc3Mg
Zm9yIHRoZSByYW5nZS4NCj4NCj4gVGhpcyBwYXRjaHNldCBlbmFibGUgYWxsIHRoaXMgb3B0aW1p
emF0aW9ucyBmb3IgZGV2aWNlIGRyaXZlci4NCj4gSSBkbyBub3QgaW5jbHVkZSBhbnkgb2YgdGhv
c2UgaW4gdGhpcyBzZXJpZSBidXQgb3RoZXIgcGF0Y2hzZXQNCj4gaSBhbSBwb3N0aW5nIHdpbGwg
bGV2ZXJhZ2UgdGhpcy4NCj4NCj4NCj4gIEZyb20gY29kZSBwb2ludCBvZiB2aWV3IHRoZSBwYXRj
aHNldCBpcyBwcmV0dHkgc2ltcGxlLCB0aGUgZmlyc3QNCj4gdHdvIHBhdGNoZXMgY29uc29saWRh
dGUgYWxsIG1tdSBub3RpZmllciBhcmd1bWVudHMgaW50byBhIHN0cnVjdA0KPiBzbyB0aGF0IGl0
IGlzIGVhc2llciB0byBhZGQvY2hhbmdlIGFyZ3VtZW50cy4gVGhlIGxhc3QgcGF0Y2ggYWRkcw0K
PiB0aGUgY29udGV4dHVhbCBpbmZvcm1hdGlvbiAobXVubWFwLCBwcm90ZWN0aW9uLCBzb2Z0IGRp
cnR5LCBjbGVhciwNCj4gLi4uKS4NCg0KU2tpbW1pbmcgb3ZlciBpdCBhdCBsZWFzdCB0aGUgcGFy
dHMgSSdtIGZhbWlsaWFyIHdpdGggbG9vayBjb21wbGV0ZWx5IA0Kc2FuZSB0byBtZS4NCg0KV2hv
bGUgc2VyaWVzIGlzIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IENoZWVycywNCj4gSsOp
csO0bWUNCj4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+
DQo+IENjOiBNYXR0aGV3IFdpbGNveCA8bWF3aWxjb3hAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IFJv
c3MgWndpc2xlciA8endpc2xlckBrZXJuZWwub3JnPg0KPiBDYzogSmFuIEthcmEgPGphY2tAc3Vz
ZS5jej4NCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBD
YzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IFJhZGltIEtyxI1t
w6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KPiBDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Aa2Vy
bmVsLm9yZz4NCj4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPiBDYzog
UmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29tPg0KPiBDYzogSm9obiBIdWJiYXJk
IDxqaHViYmFyZEBudmlkaWEuY29tPg0KPiBDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+DQo+IErDqXLD
tG1lIEdsaXNzZSAoMyk6DQo+ICAgIG1tL21tdV9ub3RpZmllcjogdXNlIHN0cnVjdHVyZSBmb3Ig
aW52YWxpZGF0ZV9yYW5nZV9zdGFydC9lbmQgY2FsbGJhY2sNCj4gICAgbW0vbW11X25vdGlmaWVy
OiB1c2Ugc3RydWN0dXJlIGZvciBpbnZhbGlkYXRlX3JhbmdlX3N0YXJ0L2VuZCBjYWxscw0KPiAg
ICBtbS9tbXVfbm90aWZpZXI6IGNvbnRleHR1YWwgaW5mb3JtYXRpb24gZm9yIGV2ZW50IHRyaWdn
ZXJpbmcNCj4gICAgICBpbnZhbGlkYXRpb24NCj4NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfbW4uYyAgfCAgNDMgKysrKy0tLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2k5
MTUvaTkxNV9nZW1fdXNlcnB0ci5jIHwgIDE0ICsrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX21uLmMgICAgICB8ICAxNiArKy0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvdW1lbV9vZHAuYyAgICAgIHwgIDIwICsrLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L2hmaTEvbW11X3JiLmMgICAgIHwgIDEzICsrLQ0KPiAgIGRyaXZlcnMvbWlzYy9taWMvc2NpZi9z
Y2lmX2RtYS5jICAgICAgICB8ICAxMSArLS0NCj4gICBkcml2ZXJzL21pc2Mvc2dpLWdydS9ncnV0
bGJwdXJnZS5jICAgICAgfCAgMTQgKystDQo+ICAgZHJpdmVycy94ZW4vZ250ZGV2LmMgICAgICAg
ICAgICAgICAgICAgIHwgIDEyICstLQ0KPiAgIGZzL2RheC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxMSArKy0NCj4gICBmcy9wcm9jL3Rhc2tfbW11LmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgMTAgKystDQo+ICAgaW5jbHVkZS9saW51eC9tbS5oICAgICAgICAgICAgICAg
ICAgICAgIHwgICA0ICstDQo+ICAgaW5jbHVkZS9saW51eC9tbXVfbm90aWZpZXIuaCAgICAgICAg
ICAgIHwgMTA2ICsrKysrKysrKysrKysrKy0tLS0tLS0NCj4gICBrZXJuZWwvZXZlbnRzL3Vwcm9i
ZXMuYyAgICAgICAgICAgICAgICAgfCAgMTMgKy0tDQo+ICAgbW0vaG1tLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDIzICsrLS0tDQo+ICAgbW0vaHVnZV9tZW1vcnkuYyAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDU4ICsrKysrKy0tLS0tLQ0KPiAgIG1tL2h1Z2V0bGIuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2MyArKysrKysrLS0tLS0tDQo+ICAgbW0va2h1
Z2VwYWdlZC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICstLQ0KPiAgIG1tL2tzbS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNiArKystLS0NCj4gICBtbS9tYWR2
aXNlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjIgKystLS0NCj4gICBtbS9tZW1v
cnkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTIgKysrKysrKysrKysrKystLS0t
LS0tLS0tDQo+ICAgbW0vbWlncmF0ZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMw
ICsrKystLS0NCj4gICBtbS9tbXVfbm90aWZpZXIuYyAgICAgICAgICAgICAgICAgICAgICAgfCAg
MjIgKysrLS0NCj4gICBtbS9tcHJvdGVjdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MTcgKystLQ0KPiAgIG1tL21yZW1hcC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
NCArLS0NCj4gICBtbS9vb21fa2lsbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjAg
KysrLS0NCj4gICBtbS9ybWFwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzQg
KysrKy0tLQ0KPiAgIHZpcnQva3ZtL2t2bV9tYWluLmMgICAgICAgICAgICAgICAgICAgICB8ICAx
NCArKy0NCj4gICAyNyBmaWxlcyBjaGFuZ2VkLCA0MjEgaW5zZXJ0aW9ucygrKSwgMzM0IGRlbGV0
aW9ucygtKQ0KPg0KDQo=
