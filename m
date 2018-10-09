Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AF3C65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1822F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bSwyDREK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1822F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJJEES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:04:18 -0400
Received: from mail-by2nam03on0089.outbound.protection.outlook.com ([104.47.42.89]:45050
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbeJJEES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOJriWRj9tjH57dJvx5p7V2EyhnBGwo14AynNybLmOo=;
 b=bSwyDREK+VWr0cMgh8DRddPrIoXONrUzFgEO0+hNPPJzRUrYvUj6kbKhdSH4biOnAcXKRorThZwpa5TSXp0kku61RGmQTadu8474Munb1cC+S6m5few9W/FNMbrvIddtMDavJzU5JZk5nzXzYd76cS+obtbo7Pc+w1Qz4ZoO+Wk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2581.namprd12.prod.outlook.com (52.132.141.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Tue, 9 Oct 2018 20:45:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Tue, 9 Oct 2018
 20:45:30 +0000
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
Subject: Re: [PATCH v2 07/11] arch/x86: Initialize the resource functions that
 are different
Thread-Topic: [PATCH v2 07/11] arch/x86: Initialize the resource functions
 that are different
Thread-Index: AQHUXO3RKpKecNr1j0SojII0eXo5EKUXLmwAgAA5uIA=
Date:   Tue, 9 Oct 2018 20:45:30 +0000
Message-ID: <9834f9b1-d997-4842-6dac-321c6ec85311@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-8-babu.moger@amd.com>
 <1d3b42db-4651-2bb0-4632-a084d1df5991@intel.com>
In-Reply-To: <1d3b42db-4651-2bb0-4632-a084d1df5991@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2581;20:xZvxijFwoib06Rc/ja6Ewqi3imzYCPThXZRLe/GSIMdkNRjM8eC6CXytg18XS9sFDwUIpVmFQRKCvB64TfG/QIuLx0sOV24VhNB+8IeVSMM0DTrkXqOO6+ru5O9SjwiYkrULslAICFmGgalMlbjK0HePy7LowDI0ZBeyUdz34hPVa5JgpwtYmBR89Hny95KWqDsNApgzwj9ea6CvH81yxIuay+CxGZio7Hxn6JLyEBDJg1KPhPY7KJHVYA7UAQml
x-ms-office365-filtering-correlation-id: 0137333c-d109-4016-e14a-08d62e282681
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2581;
x-ms-traffictypediagnostic: DM5PR12MB2581:
x-microsoft-antispam-prvs: <DM5PR12MB2581F3D2C31E224F1B2CB6A995E70@DM5PR12MB2581.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR12MB2581;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2581;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(376002)(396003)(43544003)(189003)(199004)(86362001)(2501003)(229853002)(6116002)(3846002)(54906003)(486006)(99286004)(446003)(6506007)(31696002)(53936002)(5660300001)(5250100002)(11346002)(14444005)(110136005)(2201001)(52116002)(256004)(106356001)(386003)(6246003)(478600001)(36756003)(305945005)(6512007)(25786009)(2900100001)(7736002)(97736004)(316002)(102836004)(71190400001)(7416002)(14454004)(2616005)(6486002)(105586002)(31686004)(4326008)(8936002)(6436002)(81166006)(8676002)(26005)(72206003)(53546011)(76176011)(68736007)(66066001)(71200400001)(476003)(81156014)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2581;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ju1JJei9VOMyBuNboazAVKqsN6/L0ixopf0lEpTUFd2IDM1e4qsZMqgW7kSDohdZqQGNnhodEYSC0mhXyA0pVgBtnIykbABsSmbJ0B4/gUSWL0yX6EFpG18fLiFH65LxaE4Td1Tv2FdeJAahH41MnOUfORT0tB9QP20oM5TRUSqNneeuxaNEEOE+TZVSgNZ9g6MBugsk/xrXWsq8eOGoJtU5J4E4w+iEmnERs3QajwXYYMZOAt9dq3wsGb9S9HYSDkGhib9CWKAXKtcBdNwlIipJeiUICITzC0xzbY2pCQo5Gsh5VAcVd4j4sY6PCEbCua26DgL4hSb3KBxNmoO1qT0o5ALtShvZf8OIZgoUK9Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1E095693FED8244BC4090751EFEC154@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0137333c-d109-4016-e14a-08d62e282681
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 20:45:30.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzA5LzIwMTggMTI6MTggUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gSGkg
QmFidSwNCj4gDQo+IE9uIDEwLzUvMjAxOCAxOjU1IFBNLCBNb2dlciwgQmFidSB3cm90ZToNCj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdF9jdHJsbW9uZGF0YS5jIGIvYXJj
aC94ODYva2VybmVsL2NwdS9yZHRfY3RybG1vbmRhdGEuYw0KPj4gaW5kZXggODEyY2M1YzVlMzll
Li5lZTNlODM4OWQ4ZDIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdF9j
dHJsbW9uZGF0YS5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdF9jdHJsbW9uZGF0
YS5jDQo+PiBAQCAtNjQsNyArNjQsNyBAQCBzdGF0aWMgYm9vbCBid192YWxpZGF0ZShjaGFyICpi
dWYsIHVuc2lnbmVkIGxvbmcgKmRhdGEsIHN0cnVjdCByZHRfcmVzb3VyY2UgKnIpDQo+PiAgCXJl
dHVybiB0cnVlOw0KPj4gIH0NCj4+ICANCj4+IC1pbnQgcGFyc2VfYncoc3RydWN0IHJkdF9wYXJz
ZV9kYXRhICpkYXRhLCBzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLA0KPj4gK2ludCBwYXJzZV9id19p
bnRlbChzdHJ1Y3QgcmR0X3BhcnNlX2RhdGEgKmRhdGEsIHN0cnVjdCByZHRfcmVzb3VyY2UgKnIs
DQo+PiAgCSAgICAgc3RydWN0IHJkdF9kb21haW4gKmQpDQo+PiAgew0KPj4gIAl1bnNpZ25lZCBs
b25nIGJ3X3ZhbDsNCj4+DQo+IA0KPiBKdXN0IGEgc21hbGwgbml0IC0gY291bGQgeW91IHBsZWFz
ZSBjaGVjayB0aGF0IHRoZSBhbGlnbm1lbnQgbWF0Y2hlcyB0aGUNCj4gb3BlbiBwYXJlbnRoZXNp
cyBhcyB5b3UgaGF2ZSBkb25lIHdpdGggYWxsIHRoZSBvdGhlciBzaW1pbGFyIGNoYW5nZXMgaW4N
Cj4gdGhpcyBwYXRjaD8NCg0KT2suIFN1cmUuIHdpbGwgdGFrZSBjYXJlIG9mIGl0LiBUaGFua3Mu
DQoNCj4gDQo+IFJlaW5ldHRlDQo+IA0K
