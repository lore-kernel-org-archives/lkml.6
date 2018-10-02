Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732EC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690DF206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JRAH171h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690DF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJCG1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:27:14 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:63856
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725198AbeJCG1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erIHPXjx1mTJrGRsybd9tHzez4Vx97OE24M8yiVBrgc=;
 b=JRAH171hwINFEbJxZUCC+psXFGlhdE4vpqlqzg2g5fHjmA0+Ned8DR+BZV9I8waU23wyg3CQ+H7tkS0CrfPhdBqJjDXjllGh0jrl9RcFjTuACG7QiEGnC2SXmGb+HSG7Uq+1jhBOtOSMWFdkkh+INuJ6x2UbAZ0Pi2eFv2o5P/0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2360.namprd12.prod.outlook.com (52.132.141.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Tue, 2 Oct 2018 23:41:18 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Tue, 2 Oct 2018
 23:41:18 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
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
Subject: Re: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Topic: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUVDtyokQlIS2+10uA6u2YvHhBgaUMYa6AgABIqgA=
Date:   Tue, 2 Oct 2018 23:41:18 +0000
Message-ID: <ec7ea236-adca-246c-2d2a-56dc68a146f8@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-4-babu.moger@amd.com>
 <09e1f4dc-7882-9bb4-f5a7-e9e7caafee84@intel.com>
In-Reply-To: <09e1f4dc-7882-9bb4-f5a7-e9e7caafee84@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR0401CA0040.namprd04.prod.outlook.com
 (2603:10b6:4:73::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2360;20:P/6rJB1ZHr+ytO9ofV8sefHa4+cvLt/uLReJL3JDvBELp6ypcx7Hwvkta7z6cIBcRMHRR5nKFq/jvJ2mY3Sdai2UjW9+49ayJ017He9H0uco8YQWQaVfT3WIIRC79hsNgXPxsPbK6N9IR/6mJPDfg8/r+hcy3ovPImLipX7LbU94DnTq3WQfNVymyHxCelCREzIxUcWYWSn5xBDJTVqywPY0cC60V09WgJj/3jtpjBT3/oZDR0ynZrn4oA6GgvoH
x-ms-office365-filtering-correlation-id: 14a3b55a-b596-43f0-1c80-08d628c08cbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-microsoft-antispam-prvs: <DM5PR12MB23600098EE273B5550E13AEB95E80@DM5PR12MB2360.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991045);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(51914003)(199004)(189003)(36756003)(66066001)(26005)(54906003)(14444005)(6116002)(68736007)(5250100002)(6436002)(81156014)(76176011)(6486002)(81166006)(256004)(2900100001)(3846002)(2501003)(7416002)(229853002)(8676002)(105586002)(7736002)(6246003)(106356001)(31686004)(8936002)(52116002)(6512007)(186003)(31696002)(99286004)(486006)(2201001)(86362001)(102836004)(316002)(53546011)(305945005)(478600001)(217873002)(5660300001)(4326008)(72206003)(71200400001)(110136005)(2616005)(53936002)(97736004)(71190400001)(476003)(2906002)(11346002)(25786009)(14454004)(6506007)(386003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P8rCThDrFh+akNaCaHESPL3FeRNl2PfGWTgNIvPhfKyO6Yi6nEEVHVBTFPB8zFGf+SVHymaVdkYFW7om1WV/yVcKy1vFuqgE/1U+oIFYRf0R1LnRa/27JSHbFfv0NZCaYRE8R1IFxRwCqJEUlhshMMtTaIylzGh40YBOGhiZRUbH8kWkDN9lIMobuG+1KMYWbaLzpjDM25gGx1D7Iv6LQIYPlkO5hCME4IXlaCVWR0IUBUhk6HDfz6svJ2pEEW6BMDGFCAXKGgXBoLyxmX68s5N0krrM5S216U/dJ+bnUdFK69eBlfbX5lZpsPQkDQb83Hnr9k6oKn77MWIrC7aE6y4oqeWxJoHpfm6JytMM6UA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <116CB68CC6194B47A1374910DCD81777@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a3b55a-b596-43f0-1c80-08d628c08cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 23:41:18.7195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIE15IHJlc3BvbnNlIGJlbG93Lg0K
DQpPbiAxMC8wMi8yMDE4IDAyOjIxIFBNLCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6DQo+IEhpIEJh
YnUsDQo+IA0KPiBPbiA5LzI0LzIwMTggMTI6MTkgUE0sIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4g
UmUtb3JnYW5pemUgdGhlIFJEVCBpbml0IGNvZGUuIFNlcGFyYXRlIHRoZSBjYWxsIHNlcXVlbmNl
IGZvciBlYWNoDQo+PiBmZWF0dXJlLiBUaGF0IHdheSwgaXQgaXMgZWFzeSB0byBjYWxsIHF1aXJr
cyBvciBmZWF0dXJlcyBzZXBhcmF0ZWx5DQo+PiBmb3IgZWFjaCB2ZW5kb3IgaWYgdGhlcmUgYXJl
IGRpZmZlcmVuY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9n
ZXJAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMgfCA0NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdC5jDQo+
PiBpbmRleCBiMzYxYzYzMTcwZDcuLjczNjcxNWI4MWZkOCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmR0LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMN
Cj4+IEBAIC04MTMsMTAgKzgxMyw2IEBAIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X2FsbG9j
X3Jlc291cmNlcyh2b2lkKQ0KPj4gIAkJcmV0ID0gdHJ1ZTsNCj4+ICAJfQ0KPj4gIA0KPj4gLQlp
ZiAocmR0X2NwdV9oYXMoWDg2X0ZFQVRVUkVfTUJBKSkgew0KPj4gLQkJaWYgKHJkdF9nZXRfbWVt
X2NvbmZpZygmcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX01CQV0pKQ0KPj4gLQkJCXJl
dCA9IHRydWU7DQo+PiAtCX0NCj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSBtZW50aW9ucyB0aGF0
IHRoZSBjYWxsIHNlcXVlbmNlIGZvciBlYWNoIGZlYXR1cmUgaXMNCj4gc2VwYXJhdGVkLCBidXQg
aGVyZSBvbmx5IHRoZSBNQkEgZmVhdHVyZSBpcyBzZXBhcmF0ZWQuDQoNClllcy4gTUJBIGFuZCBx
dWlya3MgYXJlIHNlcGFyYXRlZC4gSSB3aWxsIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2UuIEkNCm92
ZXJsb29rZWQgc29tZSBvZiB0aGUgZXJyb3JzIHJldHVybmVkIGJ5IHRoZXNlIGZ1bmN0aW9ucy4g
TGV0IG1lIGdvIGJhY2sNCmFuZCB1cGRhdGUgdGhpcyBwYXRjaC4gV2lsbCBrZWVwIG1vc3RseSBh
cyBpcy4gT25seSBzZXBhcmF0ZSBNQkEgYW5kDQpxdWlya3Mgd2hpY2ggYXJlIGltcG9ydGFudC4g
V2lsbCBtYWtlIHN1cmUgZXJyb3JzIGFyZSBwcm9wYWdhdGVkIHByb3Blcmx5Lg0KDQo+IA0KPiBU
aGUgTUJBIGZlYXR1cmUgZGV0ZWN0aW9uIGlzIHJlbW92ZWQgYWJvdmUgLi4uLiAobW9yZSBsYXRl
cikNCj4gDQo+PiAgCXJldHVybiByZXQ7DQo+PiAgfQ0KPj4gIA0KPj4gQEAgLTgzMSwxMSArODI3
LDEyIEBAIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X21vbl9yZXNvdXJjZXModm9pZCkNCj4+
ICANCj4+ICAJaWYgKCFyZHRfbW9uX2ZlYXR1cmVzKQ0KPj4gIAkJcmV0dXJuIGZhbHNlOw0KPj4g
KwllbHNlDQo+PiArCQlyZXR1cm4gdHJ1ZTsNCj4+ICANCj4+IC0JcmV0dXJuICFyZHRfZ2V0X21v
bl9sM19jb25maWcoJnJkdF9yZXNvdXJjZXNfYWxsW1JEVF9SRVNPVVJDRV9MM10pOw0KPj4gIH0N
Cj4+ICANCj4+IC1zdGF0aWMgX19pbml0IHZvaWQgcmR0X3F1aXJrcyh2b2lkKQ0KPj4gK3N0YXRp
YyBfX2luaXQgdm9pZCByZHRfcXVpcmtzX2ludGVsKHZvaWQpDQo+PiAgew0KPj4gIAlzd2l0Y2gg
KGJvb3RfY3B1X2RhdGEueDg2X21vZGVsKSB7DQo+PiAgCWNhc2UgSU5URUxfRkFNNl9IQVNXRUxM
X1g6DQo+PiBAQCAtODUwLDEzICs4NDcsMjIgQEAgc3RhdGljIF9faW5pdCB2b2lkIHJkdF9xdWly
a3Modm9pZCkNCj4+ICAJfQ0KPj4gIH0NCj4+ICANCj4+IC1zdGF0aWMgX19pbml0IGJvb2wgZ2V0
X3JkdF9yZXNvdXJjZXModm9pZCkNCj4+ICtzdGF0aWMgX19pbml0IHZvaWQgcmR0X3F1aXJrcyh2
b2lkKQ0KPj4gIHsNCj4+IC0JcmR0X3F1aXJrcygpOw0KPj4gLQlyZHRfYWxsb2NfY2FwYWJsZSA9
IGdldF9yZHRfYWxsb2NfcmVzb3VyY2VzKCk7DQo+PiAtCXJkdF9tb25fY2FwYWJsZSA9IGdldF9y
ZHRfbW9uX3Jlc291cmNlcygpOw0KPj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09
IFg4Nl9WRU5ET1JfSU5URUwpDQo+PiArCQlyZHRfcXVpcmtzX2ludGVsKCk7DQo+PiArfQ0KPj4g
Kw0KPj4gK3N0YXRpYyBfX2luaXQgdm9pZCByZHRfZGV0ZWN0X2wzX21vbih2b2lkKQ0KPj4gK3sN
Cj4+ICsJaWYgKHJkdF9tb25fY2FwYWJsZSkNCj4+ICsJCXJkdF9nZXRfbW9uX2wzX2NvbmZpZygm
cmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX0wzXSk7DQo+IA0KPiBUaGUgcG9zc2libGUg
ZXJyb3JzIGZyb20gdGhpcyBjb25maWd1cmF0aW9uIGlzIG5vdyBsb3N0Lg0KDQpZZXMuIEkgb3Zl
cmxvb2tlZCBpdC4gU2FtZSBjb21tZW50IGFzIGFib3ZlLiBMZXQgbWUgZ28gYmFjayBhbmQgdXBk
YXRlDQp0aGlzIHBhdGNoLg0KPiANCj4+ICt9DQo+PiAgDQo+PiAtCXJldHVybiAocmR0X21vbl9j
YXBhYmxlIHx8IHJkdF9hbGxvY19jYXBhYmxlKTsNCj4+ICtzdGF0aWMgX19pbml0IHZvaWQgcmR0
X2NoZWNrX21iYSh2b2lkKQ0KPj4gK3sNCj4+ICsJaWYgKHJkdF9jcHVfaGFzKFg4Nl9GRUFUVVJF
X01CQSkpDQo+PiArCQlyZHRfZ2V0X21lbV9jb25maWcoJnJkdF9yZXNvdXJjZXNfYWxsW1JEVF9S
RVNPVVJDRV9NQkFdKTsNCj4gDQo+IEhlcmUgdG9vIHRoZSBwb3NzaWJsZSBmYWlsdXJlIG9mIHRo
aXMgY29uZmlndXJhdGlvbiBpcyBub3cgbG9zdC4NCg0KRGl0dG8uLiBMZXQgbWUgZ28gYmFjayBh
bmQgdXBkYXRlIHRoaXMgcGF0Y2guDQoNCj4gDQo+PiAgfQ0KPj4gIA0KPj4gIHN0YXRpYyBlbnVt
IGNwdWhwX3N0YXRlIHJkdF9vbmxpbmU7DQo+PiBAQCAtODY2LDggKzg3MiwyMiBAQCBzdGF0aWMg
aW50IF9faW5pdCByZHRfbGF0ZV9pbml0KHZvaWQpDQo+PiAgCXN0cnVjdCByZHRfcmVzb3VyY2Ug
KnI7DQo+PiAgCWludCBzdGF0ZSwgcmV0Ow0KPj4gIA0KPj4gLQlpZiAoIWdldF9yZHRfcmVzb3Vy
Y2VzKCkpDQo+PiArCS8qIFJ1biBxdWlya3MgZmlyc3QgKi8NCj4+ICsJcmR0X3F1aXJrcygpOw0K
Pj4gKw0KPj4gKwlyZHRfYWxsb2NfY2FwYWJsZSA9IGdldF9yZHRfYWxsb2NfcmVzb3VyY2VzKCk7
DQo+PiArCXJkdF9tb25fY2FwYWJsZSA9IGdldF9yZHRfbW9uX3Jlc291cmNlcygpOw0KPj4gKw0K
Pj4gKwlpZiAoIShyZHRfYWxsb2NfY2FwYWJsZSB8fCByZHRfbW9uX2NhcGFibGUpKSB7DQo+PiAr
CQlwcl9pbmZvKCJSRFQgYWxsb2NhdGlvbiBvciBtb25pdG9yaW5nIG5vdCBkZXRlY3RlZFxuIik7
DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGVuZHMgd2l0aCBhIGxvZyBlbnRyeSBmb3IgZXZlcnkgcmVz
b3VyY2UgZGlzY292ZXJlZC4gSXMNCj4gdGhpcyBuZXcgbG9nIGVudHJ5IG5lZWRlZCB0byBpbmRp
Y2F0ZSB0aGF0IHN1Y2ggcmVzb3VyY2VzIGhhdmUgbm90IGJlZW4NCj4gZm91bmQ/IENvdWxkIGl0
IG5vdCBqdXN0IGJlIHRoZSBhYnNlbmNlIG9mIHRoZSBvdGhlciBtZXNzYWdlPw0KDQpBcyB0aGlz
IGlzIHJlbGF0aXZlbHkgbmV3IGZlYXR1cmUsIHNvIEkgYWRkZWQgdGhpcyBpbmZvIG1lc3NhZ2Uu
IEl0IGhlbHBlZA0KbWUgZGVidWcgd2hhdCB3ZW50IHdyb25nLiBPdGhlcndpc2UsIEkgZG9uJ3Qg
c2VlIGFueXRoaW5nLiBJIGNhbiByZW1vdmUgaXQNCmlmIHRoZSBtZXNzYWdlIGlzIHRvbyBhbm5v
eWluZyB0byB0aGUgdXNlci4NCg0KPiANCj4+ICAJCXJldHVybiAtRU5PREVWOw0KPj4gKwl9DQo+
IA0KPiAuLi4gKGNvbnRpbnVlZCBmcm9tIGFib3ZlKSAuLi4gc2luY2UgdGhlIE1CQSBmZWF0dXJl
IGRldGVjdGlvbiB3YXMNCj4gcmVtb3ZlZCBmcm9tIGdldF9yZHRfYWxsb2NfcmVzb3VyY2VzKCkg
d291bGQgdGhlIGFib3ZlIG5vdCBjYXVzZSBmYWlsdXJlDQo+IG9uIHN5c3RlbXMgdGhhdCBvbmx5
IHN1cHBvcnQgTUJBPw0KDQp5ZXMuIExldCBtZSBnbyBiYWNrIGFuZCB1cGRhdGUgdGhpcyBwYXRj
aC4NCj4gDQo+PiArDQo+PiArCS8qIERldGVjdCBsMyBtb25pdG9yaW5nIHJlc291cmNlcyAqLw0K
PiANCj4gSSBkbyBub3QgdGhpbmsgdGhpcyBjb21tZW50IGlzIGFjY3VyYXRlIC4uLiBoYXMgdGhl
IG1vbml0b3JpbmcgcmVzb3VyY2VzDQo+IG5vdCBiZWVuIGRldGVjdGVkIGVhcmxpZXIgaW4gZ2V0
X3JkdF9tb25fcmVzb3VyY2VzKCkgYW5kIG5vdyB0aGV5IHdpbGwNCj4gYmUgY29uZmlndXJlZD8N
Cj4gDQo+PiArCXJkdF9kZXRlY3RfbDNfbW9uKCk7DQo+PiArDQo+PiArCS8qIENoZWNrIGZvciBN
ZW1vcnkgQmFuZHdpZHRoIEFsbG9jYXRpb24gKi8NCj4+ICsJcmR0X2NoZWNrX21iYSgpOw0KPiAN
Cj4gVG8gZm9sbG93IHVwIG9uIGFib3ZlIC4uIHRoZSBwb3RlbnRpYWwgZmFpbHVyZSBvZiB0aGVz
ZSBjb25maWd1cmF0aW9ucw0KPiBhcmUgbm93IGxvc3QgaGVyZS4gSW5pdGlhbGl6YXRpb24gc2hv
dWxkIG5vdCBjb250aW51ZSBpZiB0aGVzZQ0KPiBjb25maWd1cmF0aW9ucyBmYWlsZWQuDQoNClll
cy4gTGV0IG1lIGdvIGJhY2sgYW5kIHVwZGF0ZSB0aGlzIHBhdGNoLg0KDQo+IA0KPj4gIA0KPj4g
IAlyZHRfaW5pdF9wYWRkaW5nKCk7DQo+PiAgDQo+Pg0KPiANCj4gUmVpbmV0dGUNCj4gDQo=
