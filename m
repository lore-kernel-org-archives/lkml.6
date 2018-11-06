Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA53C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072A620830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wPvONJFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072A620830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeKGEc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:32:27 -0500
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:41131
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730532AbeKGEc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzcweFaLqwiAYVnXPkcq3nFPGXJg7Tu53rNz4PnRggY=;
 b=wPvONJFAPmXPL5Ei8ardv8BUyO+rHP/gxeBc5K4mxdric2CR/9jTDWqGET0menDdLd/Tb957cdcNdaADPFtCCW7LHuw6FHMM11USIyz7BT/tgeUU8AKeWvWV4Qdq2iPPxcVQRIZuuVhLSlq3GZdGUZckbnHY/ZY6ySt96Hk1X+A=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1404.namprd12.prod.outlook.com (10.168.238.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 19:03:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 19:03:02 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 13/14] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Topic: [PATCH v6 13/14] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Thread-Index: AQHUdectZ4UKh59MskOOj3g4CGTUh6VC5c2AgAAeOACAABbXgA==
Date:   Tue, 6 Nov 2018 19:03:01 +0000
Message-ID: <88595cc1-804f-c697-9cba-be40b9df7e39@amd.com>
References: <20181106154034.15386-1-babu.moger@amd.com>
 <20181106154034.15386-14-babu.moger@amd.com>
 <20181106155305.GG3074@bombadil.infradead.org>
 <20181106174114.GI3074@bombadil.infradead.org>
In-Reply-To: <20181106174114.GI3074@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0059.namprd12.prod.outlook.com
 (2603:10b6:802:20::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1404;20:b4MWbFHaItaf1hXGKgD6R0fV23TD9MhcIEPudjcte+ZCktPUkiRVgEawgDmBqDM2FKoXxiUeAL+/1KZP0N6Ee6pXX0y7Bi2IO0RnBbakOcP0fZAqAPXsa2cB86JiIYeeixeZW1N7aWiTj61Hh8nyOWgCYceVlDFu5Z5UBS9VxYpF8PeJCPfpL0t8+XV3VIsk3Cu30KuUJvRiObxDjSw95jk6QRtd9D6Q/QA/CsRiUHYofhmjj6ILkZRdjT9JaURV
x-ms-office365-filtering-correlation-id: 96579434-4740-4295-8b55-08d6441a796b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1404;
x-ms-traffictypediagnostic: DM5PR12MB1404:
x-microsoft-antispam-prvs: <DM5PR12MB14044A87C4BABEDA1E32205E95CB0@DM5PR12MB1404.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1404;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1404;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(6486002)(71200400001)(7406005)(53936002)(478600001)(99286004)(71190400001)(229853002)(93886005)(54906003)(386003)(97736004)(7416002)(76176011)(6506007)(68736007)(26005)(256004)(53546011)(2616005)(486006)(6916009)(81166006)(8676002)(476003)(81156014)(36756003)(446003)(86362001)(66066001)(52116002)(11346002)(2900100001)(8936002)(31696002)(316002)(25786009)(6116002)(5660300001)(105586002)(31686004)(6246003)(106356001)(6512007)(3846002)(4326008)(15650500001)(305945005)(7736002)(6436002)(102836004)(186003)(72206003)(2906002)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1404;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NBstvmctRZp5YAiV7b1ImBypW+upmosMVi2aWmM1nFw6zukBnsOV/bMAp0kpkzcRFLV/FshEj6BRnWsG1zBe6Zp0YPMi85Y51X/YRqWdb3hD1VWqlShotc4HPvQ+a2aE5O+zYhv/xa9ibN9d5iBn0gS/CbCAI1VS0xP1TOfMfTsUObua/591PhbTsvof21OTdOlRH1qXxDSorbptse2xW38Fs+BwKOJi6bscKJ3S/ujE8Zo9D8NFSXXnCl8zAYABKC0mdtoJ27P1KtS+2OTmut0C3PLqTFuArwnyLVylAee/tkimTm4fO3AZdETOYgAGDV0Kq6MAuc3BmylIMzZomNzyN7bZMUCrEgfPkVr2tqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9163D5A69FFA24428AC40078DED9A00E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96579434-4740-4295-8b55-08d6441a796b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 19:03:01.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhldywNCg0KT24gMTEvNi8xOCAxMTo0MSBBTSwgTWF0dGhldyBXaWxjb3ggd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDA2LCAyMDE4IGF0IDA3OjUzOjA1QU0gLTA4MDAsIE1hdHRoZXcgV2ls
Y294IHdyb3RlOg0KPj4+IC1UaGlzIGZlYXR1cmUgaXMgZW5hYmxlZCBieSB0aGUgQ09ORklHX0lO
VEVMX1JEVCBLY29uZmlnIGFuZCB0aGUNCj4+PiAtWDg2IC9wcm9jL2NwdWluZm8gZmxhZyBiaXRz
Og0KPj4+ICtUaGlzIGZlYXR1cmUgaXMgZW5hYmxlZCBieSB0aGUgQ09ORklHX0lOVEVMX1JEVCBL
Y29uZmlnKGZvciBJbnRlbCkgb3INCj4+PiArQ09ORklHX0FNRF9RT1MoZm9yIEFNRCkgYW5kIHRo
ZSBYODYgL3Byb2MvY3B1aW5mbyBmbGFnIGJpdHM6DQo+Pg0KPj4gTm93IEknbSBjdXJpb3VzIHdo
eSB3ZSBoYXZlIHR3byBkaWZmZXJlbnQgS2NvbmZpZyBvcHRpb25zIGZvciB0aGUgc2FtZQ0KPj4g
ZmVhdHVyZS4gIEkgc2hvdWxkIGdvIGFuZCByZWFkIHRoZSBvdGhlciBwYXRjaGVzLCBJIHN1cHBv
c2UuDQo+IA0KPiBOb3cgdGhhdCBJJ3ZlIHJlYWQgdGhyb3VnaCB0aGVtLCBJIGZpbmQgbm93aGVy
ZSB0aGF0IHRoZSBjaG9pY2VzOg0KPiANCj4gQU1RX1FPUz15IElOVEVMX1JEVD1uDQo+IEFNRF9R
T1M9biBJTlRFTF9SRFQ9eQ0KPiBBTURfUU9TPXkgSU5URUxfUkRUPXkNCj4gDQo+IGhhdmUgYW55
IGRpZmZlcmVuY2UgdG8gdGhlIHJlc3VsdGluZyBjb2RlLiAgVGh1cywgdGhpcyBsb29rcyBsaWtl
IGENCj4gdmFuaXR5IGNvbmZpZyBvcHRpb247IHBsZWFzZSBkb24ndCBkbyB0aGlzLiAgUmVuYW1l
IHRoZSBjb25maWcgb3B0aW9uDQo+IHRvIGJlIHZlbmRvci1uZXV0cmFsIGlmIHlvdSBtdXN0LCBi
dXQgcGxlYXNlIG5vIG5ldyBvcHRpb25zIHVubGVzcw0KPiBhYnNvbHV0ZWx5IG5lY2Vzc2FyeS4N
Cj4gDQoNClllcy4gVGhhdCBpcyByaWdodC4gQ29kZSBkb2VzIG5vdCBjaGFuZ2Ugd2l0aCBhbnkg
b2YgdGhlc2UgY29tYmluYXRpb25zLg0KV2UgY2FuIGdvIHdpdGggb25seSBvbmUgbmV1dHJhbCBw
YXJhbWV0ZXIgd2hpY2ggaXMgY29uZmlnIFJFU0NUUkwuIEkgd2lsbA0KcmVtb3ZlIEFNRF9RT1Mg
YW5kIElOVEVMX1JEVC4gVGhpcyBhbHNvIHJlcXVpcmVzIHNvbWUgdGV4dCBjaGFuZ2VzIHRvDQpj
b3ZlciBib3RoIEludGVsIGFuZCBBTUQuIFdpbGwgc2VuZCB0aGUgdXBkYXRlZCBwYXRjaGVzLg0K
