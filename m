Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559DCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053852245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M8YMGRMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053852245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeKMFL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:11:29 -0500
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:29693
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbeKMFL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac58Kbjd3xqTUr71/9xhTS4XDG2GgWZd9xWa6t9ptAU=;
 b=M8YMGRMssJ//CRavdq2QHX/IZ3pBX2jXMRrWApybCpTU0zZJXOoLzevaU9XvFR27eXjdmXZbbEU4itFfYGIEpoEWFrs/fZ8g6Kl2Xyf1bXU4wT2BpWuJMzmxRhorpAhf9bN0K/KJ6qABnTwLcvNCB9bvbws80A0dedxhHXrmxqI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Mon, 12 Nov 2018 19:16:50 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Mon, 12 Nov 2018
 19:16:50 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: Re: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUeG4ehNbhFjGDFkObyLvWcXYs0KVMZhQAgAAhjgA=
Date:   Mon, 12 Nov 2018 19:16:49 +0000
Message-ID: <ee462962-f340-775c-4059-914a22845fea@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-2-babu.moger@amd.com> <20181112171638.GH8167@zn.tnic>
In-Reply-To: <20181112171638.GH8167@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:805:3e::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1705;20:So5beHiuW/de5ptMGBfoTYeZEz3tEmy4a36tmno6wkjf/LQuV22EMcHfF9BYjDu468LpzaPFjAqxHy9pTZoHLZw5TrOTNPg8JMqmEBqz7mCjv2i3leqvfF+xDJIrflHwSxH6p9B0Hwltl0H9dy4m/XmOGxHB4qhhBNH/oqNUPKQHeSmW9b0raRPF9/0t2rryBy22QXf1WteEjXen3R8y3cDlR2iCLvixYDUgr17d97QRHmyjWpYvpMaFDK/NLbuD
x-ms-office365-filtering-correlation-id: b1763b89-4422-4857-ef7b-08d648d364a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1705;
x-ms-traffictypediagnostic: DM5PR12MB1705:
x-microsoft-antispam-prvs: <DM5PR12MB1705E564012B753A726A1E5295C10@DM5PR12MB1705.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1705;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1705;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(86362001)(229853002)(31696002)(105586002)(6246003)(4326008)(5660300001)(14454004)(72206003)(2900100001)(2906002)(53936002)(106356001)(6486002)(25786009)(478600001)(7416002)(36756003)(7406005)(68736007)(99286004)(3846002)(76176011)(305945005)(6506007)(53546011)(52116002)(2616005)(11346002)(446003)(476003)(54906003)(386003)(6436002)(26005)(186003)(7736002)(102836004)(6512007)(6916009)(97736004)(256004)(486006)(31686004)(66066001)(71200400001)(71190400001)(8936002)(14444005)(316002)(81166006)(81156014)(8676002)(6116002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1705;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1x9u3/M+B7H8zZouOwpcITspY/YIzVKXUWcan92QdEKMpVVyi4CDN/TFpIA00rVPmJoOJPywamDt7myER8y0Xvvd0ecKefOYNMLIf902kJhg/ljknLqpix7C8yMlDVFQqMO5QkNmIoYTzUx3AaocNFdA5vjaRv1nl5CpSfstm69t/iyyXkR3FCuqCHc/TO9QSr+p9few3g7AyvmxQdHBYRjGR2iMX1FxHwKdyQGDOiIgTtsEbgLVqWLaGpnSMiygq0CtygfIWGxVMiXheAVnOBsX6o9PWu1SM1dyBRS7TKnN0e+3OuqBWS44W2xwlRh+4E8XOsbOX3IzBPY/vQrAbltq1OQayXruUUyAJtlJhd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <35E5C1EF68DE0A4D97F6DFA8FA948E5D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1763b89-4422-4857-ef7b-08d648d364a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 19:16:49.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzEyLzE4IDExOjE2IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IA0KPiAg
U3ViamVjdDogW1BBVENIIHY3IDAxLzEzXSBhcmNoL3g4NjogU3RhcnQgcmVuYW1pbmcgdGhlIHJk
dCBmaWxlcyB0byBtb3JlIGdlbmVyaWMgbmFtZXMNCj4gDQo+IEkgZ3Vlc3MgdGhlIHN1YmplY3Qg
cHJlZml4IGZvciBhbGwgdGhvc2Ugc2hvdWxkIGJlICJhcmNoL3Jlc2N0cmw6IiBvciBzbyBub3cu
DQoNCk9rLiBXaWxsIGNoYW5nZSBpdC4NCg0KPiANCj4gT24gRnJpLCBOb3YgMDksIDIwMTggYXQg
MDg6NTI6MjVQTSArMDAwMCwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+PiBOZXcgZ2VuZXJhdGlvbiBv
ZiBBTUQgcHJvY2Vzc29ycyBzdGFydCBzdXBwb3J0aW5nIFJEVChvciBRT1MpIGZlYXR1cmVzLg0K
Pj4gV2l0aCBtb3JlIHRoYW4gb25lIHZlbmRvcnMgc3VwcG9ydGluZyB0aGVzZSBmZWF0dXJlcywg
aXQgc2VlbXMgbW9yZQ0KPj4gYXBwcm9wcmlhdGUgdG8gcmVuYW1lIHRoZXNlIGZpbGVzLg0KPj4N
Cj4+IENoYW5nZWQgaW50ZWxfcmR0IHRvIHJlc2N0cmwgd2hlcmUgYXBwbGljYWJsZS4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+PiAtLS0N
Cj4+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS97aW50ZWxfcmR0X3NjaGVkLmggPT4gcmVzY3RybF9z
Y2hlZC5ofSB8IDANCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2VmaWxlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDYgKysrLS0tDQo+PiAgYXJjaC94ODYva2VybmVsL2NwdS97
aW50ZWxfcmR0LmMgPT4gcmVzY3RybC5jfSAgICAgICAgICAgICAgfCA0ICsrLS0NCj4+ICBhcmNo
L3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHQuaCA9PiByZXNjdHJsLmh9ICAgICAgICAgICAgICB8
IDYgKysrLS0tDQo+PiAgLi4uL2NwdS97aW50ZWxfcmR0X2N0cmxtb25kYXRhLmMgPT4gcmVzY3Ry
bF9jdHJsbW9uZGF0YS5jfSAgfCAyICstDQo+PiAgLi4uL2tlcm5lbC9jcHUve2ludGVsX3JkdF9t
b25pdG9yLmMgPT4gcmVzY3RybF9tb25pdG9yLmN9ICAgfCAyICstDQo+PiAgLi4uL2NwdS97aW50
ZWxfcmR0X3BzZXVkb19sb2NrLmMgPT4gcmVzY3RybF9wc2V1ZG9fbG9jay5jfSAgfCA2ICsrKy0t
LQ0KPj4gIC4uLl9yZHRfcHNldWRvX2xvY2tfZXZlbnQuaCA9PiByZXNjdHJsX3BzZXVkb19sb2Nr
X2V2ZW50Lmh9IHwgMiArLQ0KPj4gIC4uLi9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfcmR0Z3JvdXAu
YyA9PiByZXNjdHJsX3JkdGdyb3VwLmN9IHwgNCArKy0tDQo+PiAgYXJjaC94ODYva2VybmVsL3By
b2Nlc3NfMzIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+PiAgYXJj
aC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAyICstDQo+PiAgMTEgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pDQo+PiAgcmVuYW1lIGFyY2gveDg2L2luY2x1ZGUvYXNtL3tpbnRlbF9yZHRfc2NoZWQu
aCA9PiByZXNjdHJsX3NjaGVkLmh9ICgxMDAlKQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L3tpbnRlbF9yZHQuYyA9PiByZXNjdHJsLmN9ICg5OSUpDQo+PiAgcmVuYW1lIGFyY2gveDg2
L2tlcm5lbC9jcHUve2ludGVsX3JkdC5oID0+IHJlc2N0cmwuaH0gKDk5JSkNCj4+ICByZW5hbWUg
YXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X2N0cmxtb25kYXRhLmMgPT4gcmVzY3RybF9j
dHJsbW9uZGF0YS5jfSAoOTklKQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRl
bF9yZHRfbW9uaXRvci5jID0+IHJlc2N0cmxfbW9uaXRvci5jfSAoOTklKQ0KPj4gIHJlbmFtZSBh
cmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfcHNldWRvX2xvY2suYyA9PiByZXNjdHJsX3Bz
ZXVkb19sb2NrLmN9ICg5OSUpDQo+PiAgcmVuYW1lIGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVs
X3JkdF9wc2V1ZG9fbG9ja19ldmVudC5oID0+IHJlc2N0cmxfcHNldWRvX2xvY2tfZXZlbnQuaH0g
KDk1JSkNCj4+ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3JkdGdyb3Vw
LmMgPT4gcmVzY3RybF9yZHRncm91cC5jfSAoOTklKQ0KPiANCj4gT3RoZXIgdGhhbiB0aGF0IGFu
ZCBGV0lXOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4N
Cj4gDQoNClRoYW5rcw0K
