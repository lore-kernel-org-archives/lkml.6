Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757882064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YstiATYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757882064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeJCCBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:01:21 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:60070
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbeJCCBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SIP0bK3JyrxbfO+ZbBXhVeo3+ThG93aHm6P1fh1bnk=;
 b=YstiATYbtQNehjN+FmJ9ZST5TujKcyPVp0gmOFxw1ozeMA9uidwEO/vFQFrPIdf5k92f5K758l1zVNbkeIXoOn4dK3yT1esEbSuAnKGuCWp+rURajKKSj8bg5RtTX5T5i6ck/O/Dpo3NYsDvos3f/9cZuIvZcqj9g8ksyrQjGJM=
Received: from BL0PR12MB2468.namprd12.prod.outlook.com (52.132.11.143) by
 BL0PR12MB2435.namprd12.prod.outlook.com (52.132.11.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Tue, 2 Oct 2018 19:16:24 +0000
Received: from BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::3cba:94d7:dccc:510d]) by BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::3cba:94d7:dccc:510d%5]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:16:24 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Topic: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLaUMPC4AgAAI7GCAABLSAIAACGiA
Date:   Tue, 2 Oct 2018 19:16:23 +0000
Message-ID: <2549597a-440c-ab77-2c35-01a648703b9f@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20181002170655.GA92941@romley-ivt3.sc.intel.com>
 <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com>
 <20181002184614.GC92941@romley-ivt3.sc.intel.com>
In-Reply-To: <20181002184614.GC92941@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:404:5f::19) To BL0PR12MB2468.namprd12.prod.outlook.com
 (2603:10b6:207:4e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2435;20:eGD2YlGi8GWW8zXXNsDqNPdwknvWk6Gr4mIx8oFZwlJ933zON/I0vxHxNnGtGL88P225oPxtVzYRhjIMCIf1Rrg2XWehHt4bxTtT9FhT0yentSc5pcDxAXHVB1p+VzngZ2D0VVv+CbThr+kDrObWp5Dk42tfR2NxmLTzN5PyvzMab/EhdAh3AzHxjGssqaPQf5wo71hq7klOtzNTPYTDobv4VE4C/maTOQrPFPd9iQ/zmkE0GLtUYmFK4EiIsGZr
x-ms-office365-filtering-correlation-id: 6f17a84d-0ba2-408e-9e9b-08d6289b8ae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2435;
x-ms-traffictypediagnostic: BL0PR12MB2435:
x-microsoft-antispam-prvs: <BL0PR12MB24356E22E7E162D15924125595E80@BL0PR12MB2435.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR12MB2435;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2435;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(13464003)(186003)(966005)(31686004)(7416002)(446003)(6512007)(11346002)(2906002)(2900100001)(478600001)(106356001)(2616005)(6306002)(6436002)(7736002)(105586002)(316002)(53936002)(229853002)(5660300001)(486006)(305945005)(476003)(3846002)(6486002)(4326008)(93886005)(6116002)(54906003)(102836004)(81166006)(217873002)(256004)(5250100002)(36756003)(25786009)(8676002)(8936002)(68736007)(6506007)(6916009)(386003)(76176011)(31696002)(99286004)(72206003)(86362001)(26005)(52116002)(6246003)(66066001)(14454004)(97736004)(53546011)(71190400001)(71200400001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2435;H:BL0PR12MB2468.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ub63iLupZSZL6DzrmNKr4S3TksHlRGMICM9pJxe9rX4xEmrP6FQcZBYhMlQ+rURUIfjNYEzojcM3Ndb2BL7Rlg3pPzJlpAwNC52cH4pAHh4tCzexVDjv3BudpoKie82q6JUF/xA172rRX1MWW0hj+BPs49uxlu63TVzSEzWP0R5pSIL8udettObI/PyfN45pKsq8JeXsmz8xHqYtUZsRG4nkCOI2zo+dvz89ESXxmQ1/5SzEPbUhF9GNqGYaYSHjrgFGuZaxdssJ7t1K9szmRbsOa34o3k3F8vy/uSFrS+lZ9nrOCT5USbEE0KYj1JaclTGk266WeRkIPbs44S9dii59eyIkV7FoxOPc/iEvTAI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B797F404C7F9C14B8F91A71C9AEA3D85@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f17a84d-0ba2-408e-9e9b-08d6289b8ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:16:23.8428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAyLzIwMTggMDE6NDYgUE0sIEZlbmdodWEgWXUgd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDAyLCAyMDE4IGF0IDA1OjQ0OjQ3UE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4g
SGkgRmVuZ2h1YSwNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9t
OiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4NCj4+PiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDIsIDIwMTggMTI6MDcgUE0NCj4+PiBPbiBNb24sIFNlcCAyNCwgMjAxOCBhdCAwNzox
ODo1NFBNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4+Pj4gVGhlIHB1YmxpYyBzcGVjaWZp
Y2F0aW9uIGlzIHN0aWxsIGluIHdvcmtzLiBXaWxsIGFkZCB0aGUgbGluayB3aGVuIGl0IGlzDQo+
Pj4+IGF2YWlsYWJsZS4NCj4+Pg0KPj4+IElzIHRoaXMgdGhlIHB1YmxpYyBBTUQgUW9TIHNwZWM/
DQo+Pj4gaHR0cHM6Ly9zdXBwb3J0LmFtZC5jb20vVGVjaERvY3MvNTYzNzVfUXVhbGl0eV9vZl9T
ZXJ2aWNlX0V4dGVuc2lvbnMuDQo+Pj4gcGRmDQo+Pj4NCj4+DQo+PiBZZXMuIFRoYXQgaXMgdGhl
IG9uZS4gDQo+PiBJIHdhcyBnb2luZyB0byBzZW5kIHRoZSBsaW5rIGFmdGVyIHJlZnJlc2hpbmcg
dGhlIHBhdGNoZXMgb24gNC0xOS1yYzUuICBZb3UgYWxyZWFkeSBnb3QgaXQuIFBsZWFzZSBsZXQg
a25vdyBpZiB5b3UgaGF2ZSBhbnkgZmVlZGJhY2sgb24gdGhlIHBhdGNoZXMuIA0KPiANCj4gSSBk
b24ndCBzZWUgdGhlIG5hbWUgJ1JEVCcgKFJlc291cmNlIERpcmVjdG9yIFRlY2hub2xvZ3kpIGlu
IHRoZQ0KPiBzcGVjICJBTUQ2NCBUZWNobm9sb2d5IFBsYXRmb3JtIFF1YWxpdHkgb2YgU2Vydmlj
ZSBFeHRlbnNpb25zIi4NCj4gRG9lcyBBTUQgdXNlIHRoZSBzYW1lIG5hbWUgJ1JEVCcgYXMgSW50
ZWw/DQoNCk5vLiBBTUQgdXNlcyB0aGUgd29yZCAiUGxhdGZvcm0gUXVhbGl0eSBvZiBTZXJ2aWNl
IihvciBpbiBzaG9ydCBRb1MpIHRvDQpyZWZlciB0aGlzIGZlYXR1cmUuDQoNCj4gDQo+IFRoYW5r
cy4NCj4gDQo+IC1GZW5naHVhDQo+IA0K
