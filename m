Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1301C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B491B218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jeAcNsn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfBFLVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:21:04 -0500
Received: from mail-eopbgr790051.outbound.protection.outlook.com ([40.107.79.51]:59104
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727580AbfBFLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQSBqZ5ycPumGeTfnvG+B3Lse/2jKRXhOj9Y8oS6FDI=;
 b=jeAcNsn17VcKbHi32ZSB+e6ZhsNlJtyYhrjxBnw/WCB4Dq8OzFOBEjRA9IMGRhVJB01X9Bcp78zAQuWwHwRQX5couXb3c0avw6yprMLEe4gVLSY0aC1PoFPeH42cSs88BmtnE/L5IFJsMFMsu9oUyEX4ZxF0tYhWn/zJjhAlrOE=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2713.namprd12.prod.outlook.com (20.176.116.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:21:00 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 11:21:00 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>
Subject: Re: [RFC PATCH 8/8] svm: Allow AVIC with in-kernel irqchip mode
Thread-Topic: [RFC PATCH 8/8] svm: Allow AVIC with in-kernel irqchip mode
Thread-Index: AQHUvJfczoXgq9UCxES9CxFgBN3rJ6XRiY0AgAEZS4A=
Date:   Wed, 6 Feb 2019 11:20:59 +0000
Message-ID: <d57a0843-061a-231a-9d50-d7e4d4d05d73@amd.com>
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
 <20190204144128.9489-9-suravee.suthikulpanit@amd.com>
 <20190205113404.5c5382e6@w520.home>
In-Reply-To: <20190205113404.5c5382e6@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
x-originating-ip: [110.169.70.41]
x-clientproxiedby: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2713;20:WhLv4GLCVE+RWCp5xUtPOuCqNR/Ah3WfFssCjW8zQ+16eR33a++7C/Il6yn2wxRX3b9tXxEozTEfi+5OdsquZLnARmvOItAia1NRPbfHRvTnU+rq6UIL2jpKuPfNcY3vyzVNpbRFY771NuPhNYOP0CTVGwnK2wY94ExL2XNXgCT6LbnbeaMbwvUpn0eQdl2BM5XkzZ4j15gf5U6Ll//GZz43ExMQI72MB3pYW7KdomSlB9yZoNONxPx/ph6LWrW6
x-ms-office365-filtering-correlation-id: 4e0258ba-2fe2-43ee-8049-08d68c252bd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2713;
x-ms-traffictypediagnostic: DM6PR12MB2713:
x-microsoft-antispam-prvs: <DM6PR12MB2713325EDD95AB523564D02DF36F0@DM6PR12MB2713.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(7416002)(31686004)(99286004)(14454004)(6486002)(76176011)(106356001)(52116002)(6436002)(105586002)(72206003)(3846002)(6116002)(97736004)(6512007)(316002)(2906002)(478600001)(58126008)(54906003)(36756003)(217873002)(86362001)(31696002)(256004)(14444005)(65806001)(65956001)(66066001)(6246003)(53936002)(4326008)(25786009)(305945005)(7736002)(81166006)(8936002)(81156014)(6916009)(8676002)(229853002)(65826007)(102836004)(68736007)(26005)(53546011)(6506007)(386003)(11346002)(446003)(2616005)(476003)(486006)(186003)(4744005)(64126003)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2713;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxPKxwSuOmqNFTNIOeN5zxFpMIFYAqg1X3jMl0oHcGvWkfAu1fLz92wjN7mRXPbhb4yMgxnrcjWJIBHKJX+cer7CK8tpSwx7ng5URwAkOpg8oXlg0vOqwrxkYhrafxMeByuq16R9YU73bj9kx6t+7yybbn1o2CrbzDY/i0BLyKOlIJQpUmIJjkBUE5KnniGkedbtr3ObIf7z5df417z5er4JipA9OGCfuoY5W3tqPIpSbvc+zh65UWnpBAh+PyouWEx1MZuIkQQWAbTCTAMCBuE4UV5kPAONUIH9rCfKJ0D+QnxadFNsXGAT8rkWcfa4AsTW7cVu44koxCNGDwdkAbM9kciedkCs4zJX8buq5tpNU+GIzp/XvzKo6xgPPyhVd8PuKtsOEO//7krE0djFz/rzU1cUM6He3A5AkYvNMfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A6280BBB13FBA48A5A7604F238B484E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0258ba-2fe2-43ee-8049-08d68c252bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:20:55.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2713
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxleCwNCg0KT24gMi82LzE5IDE6MzQgQU0sIEFsZXggV2lsbGlhbXNvbiB3cm90ZToNCj4gT24g
TW9uLCA0IEZlYiAyMDE5IDE0OjQyOjMyICswMDAwDQo+ICJTdXRoaWt1bHBhbml0LCBTdXJhdmVl
IjxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT4gIHdyb3RlOg0KPiANCj4+IE9uY2UgdGhl
IElSUSBhY2sgbm90aWZpZXIgZm9yIGluLWtlcm5lbCBQSVQgaXMgbm8gbG9uZ2VyIHJlcXVpcmVk
DQo+PiBhbmQgcnVuLXRpbWUgQVZJQyBhY3RpdmF0ZS9kZWFjdGl2YXRlIGlzIHN1cHBvcnRlZCwg
d2UgY2FuIHJlbW92ZQ0KPj4gdGhlIGtlcm5lbCBpcnFjaGlwIHNwbGl0IG1vZGUgcmVxdWlyZW1l
bnQgZm9yIEFWSUMuDQo+Pg0KPj4gSGVuY2UsIHJlbW92ZSB0aGUgY2hlY2sgZm9yIGlycWNoaXAg
c3BsaXQgbW9kZSB3aGVuIGVuYWJsaW5nIEFWSUMuDQo+IFlheSEgIENvdWxkIHdlIGFsc28gYXQg
dGhpcyBwb2ludCBtYWtlIGF2aWMgZW5hYmxlZCBieSBkZWZhdWx0IG9yIGFyZQ0KPiB0aGVyZSBy
ZW1haW5pbmcgaW5jb21wYXRpYmlsaXRpZXM/ICBUaGFua3MsDQoNCkknbSBsb29raW5nIGludG8g
dGhhdCBuZXh0LiBJIHdvdWxkIG5lZWQgdG8gZW5zdXJlIHRoYXQgZW5hYmxpbmcNCkFWSUMgd291
bGQgbm90IGNhdXNlIGlzc3VlcyB3aXRoIG90aGVyIGZlYXR1cmVzLg0KDQpTdXJhdmVlDQo=
