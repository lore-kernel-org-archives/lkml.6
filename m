Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947CBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBE21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K3DRaJtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECBE21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJQWny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:43:54 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:40224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbeJQWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W/4inWGGhBYbVJ4EtJiUstvmcM2vW/pUE+6mFj0yu0=;
 b=K3DRaJtp9roWXDMq3yT9fZjQUEjdna+LXNnwO1ekwHjpFoHYjafHGlkjZbMCsSjpduf/Peb0d1MEhIJ2bEH3/3pimgGXXRiU+Bchu0JUyc/YA8JlsZaXLSgJR2PIAoJfpqAqFqtJ0mp4QLA9L/bS+rsLULJTZ1Gni79E3+7Ei5U=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31; Wed, 17 Oct 2018 14:47:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 14:47:45 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v4 10/13] arch/x86: Add AMD feature bit X86_FEATURE_MBA in
 cpuid bits array
Thread-Topic: [PATCH v4 10/13] arch/x86: Add AMD feature bit X86_FEATURE_MBA
 in cpuid bits array
Thread-Index: AQHUZMl2o0cgAdsuCk6D5ka1F0ADS6Uii84AgAD7UwA=
Date:   Wed, 17 Oct 2018 14:47:45 +0000
Message-ID: <99c568d8-7c1b-b840-b51d-fe8c987cd52f@amd.com>
References: <20181015205514.25387-1-babu.moger@amd.com>
 <20181015205514.25387-11-babu.moger@amd.com>
 <20181016234807.GC39177@romley-ivt3.sc.intel.com>
In-Reply-To: <20181016234807.GC39177@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1705;20:ylfc3DW6pApihE3icLyYhfv4AehmIgVKaFy9HZhK1Z2e83PEmia7HouETUyXH32scoLhqW0M2gNonr1XpTGqUJLwcx/T8IC0laA8umRINKNFN1n5n3OdLwz/bXmih4iGYsXsh1/KsM3uzN0Wopl3jmmsea0bMrGrXGL2SwggnKAt+RLMOeczmBdhZtVOoi8wUgL2aRO31QFNzm9N1FsvcpHHrHTzy3F/svHJBp0Nk7RdzRhBxNOMjzH2maDHlN05
x-ms-office365-filtering-correlation-id: d18aadff-4775-4491-3fa2-08d6343f7fd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1705;
x-ms-traffictypediagnostic: DM5PR12MB1705:
x-microsoft-antispam-prvs: <DM5PR12MB170556E3CE4C28AEB99B6CE095FF0@DM5PR12MB1705.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1705;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1705;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(229853002)(5660300001)(4326008)(71200400001)(72206003)(478600001)(71190400001)(86362001)(97736004)(256004)(6916009)(14454004)(6486002)(6246003)(316002)(102836004)(25786009)(3846002)(36756003)(2906002)(446003)(5250100002)(8936002)(81166006)(99286004)(2616005)(2900100001)(66066001)(11346002)(386003)(81156014)(68736007)(54906003)(305945005)(6116002)(6436002)(8676002)(105586002)(486006)(476003)(186003)(6506007)(31696002)(7416002)(26005)(106356001)(7736002)(7406005)(52116002)(31686004)(53936002)(76176011)(53546011)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1705;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K8kqbzQcWf+dpia/anr7NNZT1SUGr2rnNAGO2OPUtVFxTVFzqBRUNWGmC0UwZ3ROXW0iGOVlXj+h1cQCO2y103W8Dy7ubcEzjKfAegGf8/B+38vz5T0sXxWD4HwCLvzHSGoyW7+aB0uzQ4G4AX/FmAHG22Ck/z3uQa3uWrpTNk7AQN7lJiuV0/wbvRpohhbvvLxSNJMfVtqv3Kv2IUD4s7iBq/OCsXsAiLCpRJj0ThX5coW9VNqy80H+qzfZavl0vUkZYKmO1WvDJ2EBZlVoNMPYzmhh9CE8tgzV93iro7/7WZkrIdVgokGPVldK1CBppOKIaBI5Ll7o+AregHSIfCp4SVsVvWalpCvObjwplfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBBFE11004941D41B00BF4523590FA10@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18aadff-4775-4491-3fa2-08d6343f7fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 14:47:45.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzE2LzIwMTggMDY6NDggUE0sIEZlbmdodWEgWXUgd3JvdGU6DQo+IE9uIE1vbiwg
T2N0IDE1LCAyMDE4IGF0IDA4OjU1OjU0UE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4g
RnJvbTogU2hlcnJ5IEh1cndpdHogPHNoZXJyeS5odXJ3aXR6QGFtZC5jb20+DQo+Pg0KPj4gVGhl
IGZlYXR1cmUgYml0IFg4Nl9GRUFUVVJFX01CQSBpcyBkZXRlY3RlZCB2aWEgQ1BVSUQgbGVhZiAw
eDgwMDAwMDA4DQo+PiBFQlggQml0IDA2LiBUaGlzIGJpdCBpbmRpY2F0ZXMgdGhlIHN1cHBvcnQg
b2YgQU1EJ3MgTUJBIGZlYXR1cmUuDQo+Pg0KPj4gVGhpcyBmZWF0dXJlIGlzIHN1cHBvcnRlZCBi
eSBib3RoIEludGVsIGFuZCBBTUQuIEJ1dCB0aGV5IGFyZSBkZXRlY3RlZA0KPj4gZGlmZmVyZW50
IENQVUlEIGxlYXZlcy4NCj4gDQo+IFNob3VsZCBiZSAiaW4gZGlmZmVyZW50Li4uIg0KDQpPay4g
V2lsbCBjb3JyZWN0IGl0LiBUaGFua3MNCg0KPiANCj4gVGhhbmtzLg0KPiANCj4gLUZlbmdodWEN
Cj4gDQo=
