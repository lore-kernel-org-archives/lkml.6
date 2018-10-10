Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29723C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D797B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JT3zlssd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D797B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJJVw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:52:56 -0400
Received: from mail-eopbgr690082.outbound.protection.outlook.com ([40.107.69.82]:47584
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbeJJVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVwINHiNawEXCZhWGI/+IBAShrLCKyNXnLmq+yQPDZI=;
 b=JT3zlssdX2bsVNxnl8rDzDfW30teICiD854XNRxhxOLQHWWfg9CoyvWK5jjY3h5+rDhkLoZNJPPOHerTxpXf0y6ynmpJbLI2+v2L64kXA4PVDEc5OKx8aI0zcbCpBG3SKK5ZVRuTvR97ERMS+tMwYKx8ot2Z2hxFcV0Q6lnJRjE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1290.namprd12.prod.outlook.com (10.168.237.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 10 Oct 2018 14:30:26 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 14:30:26 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHUXO3FhE3rddQXr0iDhqiTp63CXqUXI24A///5xICAAGAdgIABDwGAgAABeYCAAAPlgA==
Date:   Wed, 10 Oct 2018 14:30:26 +0000
Message-ID: <a65fc28a-bbed-78e6-e577-4a8dec7fb51d@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-2-babu.moger@amd.com>
 <2fe2e853-47ef-af2a-6906-9ad7a7b8bba9@intel.com>
 <ddec0530-59d1-fee0-eb67-528b887ca3f5@amd.com>
 <ab692687-6398-cf9a-a027-b9ff4b3ffd5f@intel.com>
 <b2e7630a-db5c-9f69-5d7e-cac3e2bb4014@amd.com>
 <alpine.DEB.2.21.1810101613340.15060@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810101613340.15060@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1290;20:wnAViW67HyfXb0ntk/XI8izeA3h6tYdyGVM/YbkKh6/QqSEH5IL+Q5OfT1My596PKhacWXEd3Jn3K/ePe+/8hFMah4RrC0orXNM9umE0W1ej20pxihOhVzLiSRfj1Js3HcMi/rr8Z1r7ZPfB13u8hAeeFMV6aPdRo49DjowFSWuTOYXuWjvPuI1cYq1ew2mTyEoLMAIQ5IZVu0ul7THyCXWRtloG9DqnZn8knC8Z6j/otW+RGFN9eh668oOcFpHt
x-ms-office365-filtering-correlation-id: 7a1a6024-0d24-42a6-c817-08d62ebceb8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1290;
x-ms-traffictypediagnostic: DM5PR12MB1290:
x-microsoft-antispam-prvs: <DM5PR12MB129016B80EDD6CA876CE230095E00@DM5PR12MB1290.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:DM5PR12MB1290;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1290;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(93886005)(106356001)(4326008)(25786009)(68736007)(5660300001)(446003)(11346002)(486006)(186003)(31686004)(54906003)(476003)(36756003)(81166006)(81156014)(316002)(97736004)(53546011)(5250100002)(6506007)(386003)(6116002)(71190400001)(8676002)(256004)(8936002)(3846002)(71200400001)(86362001)(6486002)(66066001)(105586002)(26005)(6512007)(102836004)(76176011)(229853002)(52116002)(31696002)(72206003)(2900100001)(7736002)(2906002)(305945005)(478600001)(14454004)(6916009)(53936002)(2616005)(6436002)(7416002)(6246003)(99286004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1290;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EcE4Bnhk6SIsZ9gMm/q1kyqeqVQ+XiqYhKRXpIgzdwNg64+1gGP4c/bbgPgAJsCjOJzmcU2TL3nslZgWWBy+iOMGgpLIDGb27N0nNXB1EyY2rP5dxUnBrkUvg74KegMOBhMFLE+2BTNE2ojknjKEUHS/lVFLCLxS3eLWlxUjj1C2BA+MD+CVpyPnQDcxDij2wKpDF7OlL/ouDVL3qsOaL+L7/fob2XEfCbHRAtLRjfj2uwnItlu9Ga1wKvlqLFUdwzCrxzb0D/XLNOZ8Zg7TU4rbRyyD2Vf+NobO4IHLwjUEmZz8/a60XA3mJlIQ7pr9mV5MACrzunxXISPh1W6dvQEbvOkHkjSG8vnM8XHTrU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2D6280FCE60D4F856B9EFE4773197F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1a6024-0d24-42a6-c817-08d62ebceb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 14:30:26.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhvbWFzLA0KDQpPbiAxMC8xMC8yMDE4IDA5OjE2IEFNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEJhYnUsDQo+IA0KPiBPbiBXZWQsIDEwIE9jdCAyMDE4LCBNb2dlciwgQmFidSB3cm90ZToN
Cj4+IE9uIDEwLzA5LzIwMTggMDU6MDEgUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4+PiBB
cyBmYXIgYXMgYWxsIHRoZSBjb2RlIHlvdSB0b3VjaCBpcyBjb25jZXJuZWQgaXQgbWF5IGJlIGVh
c2llciBhbmQgY2F1c2UNCj4+PiBsZXNzIGNvbmZ1c2lvbiBmb3Igbm93IHRvIGp1c3QgZm9sbG93
IHRoZSBjdXJyZW50IG5hbWluZyBjb252ZW50aW9ucyBhcw0KPj4+IHlvdSBoYXZlIGRvbmUgaW4g
cGF0Y2hlcyAzIG9ud2FyZHMgYW5kIGhhdmUgaXQgYmUgaW5jbHVkZWQgaW4gdGhlIGxhdGVyDQo+
Pj4gbGFyZ2VyIHJlc3RydWN0dXJpbmcuDQo+Pg0KPj4gWWVzLiBJIGFtIG1ha2luZyBzdXJlIGZp
cnN0IDMgcGF0Y2hlcyBhcmUgcmVuYW1lZCB0byAicmVzY3RybCIgd2hlcmV2ZXINCj4+IGFwcGxp
Y2FibGUuIFdpbGwgc2VuZCB0aGUgcGF0Y2hlcyBzb29uLg0KPiANCj4gUGxlYXNlIG1ha2Ugc3Vy
ZSB0aGV5IGFwcGx5IGFnYWluc3QNCj4gDQo+ICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90aXAvdGlwLmdpdCB4ODYvY2FjaGUNCj4gDQo+IHdoaWNoIGhh
cyBhbGwgdGhlIGxhdGVzdCB1cGRhdGVzIGFuZCBmaXhlcyB0byB0aGlzIGNvZGUuDQoNClN1cmUu
IEkgd2lsbCBiYXNlIG5leHQgdmVyc2lvbnMgb24gdG9wIG9mIHRoaXMuIFRoYW5rcw0KDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCg==
