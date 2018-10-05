Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7468FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5512098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZpJl3vdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5512098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJFADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:03:32 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:29332
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeJFADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOeVu7sBfAHUee8zKJt90OzgujHj5422ziclVgkVvQo=;
 b=ZpJl3vdYSxCQtoix3IAReADUrvgdDBKGB0BE8LdQVzdRd3kIdoO3ORbw/CCzQaO6ft34MfeMxFcxfBdyUs1J8Wi4l5cS2JRy0EfWNbYv9uDc+1IS93EUnpQB+VYDBVOS2839Etz7q3Him7I1foC0MIJneeGNds0vK47cnukgaNU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2373.namprd12.prod.outlook.com (52.132.141.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 17:03:51 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 17:03:51 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     James Morse <james.morse@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Topic: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLaUElN0AgABe+SCAC/HrAIAADIiA
Date:   Fri, 5 Oct 2018 17:03:51 +0000
Message-ID: <5fc7797c-6246-d865-9232-cbe26b833fec@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <alpine.DEB.2.21.1809272209160.8118@nanos.tec.linutronix.de>
 <DM5PR12MB24719940B13119E05738DB3495EC0@DM5PR12MB2471.namprd12.prod.outlook.com>
 <ab23dbf9-276c-73c3-933b-1354ef6da355@arm.com>
In-Reply-To: <ab23dbf9-276c-73c3-933b-1354ef6da355@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:404:5f::11) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2373;20:lNssnnGgufEX0yTuWcFxR9PZtNYm0zyfspcGDssYAjEfyfYw7Jeu/GDOrZOYlvBxnojoz8YRRxvV6ccuyOR5cIv6IGZ4zbfxDH1UKdoXE9XCVWMiDr2Fu2pMwvjvQTmKpucFSuSecj0JFyMe/48NmZm7DpGx7x3kikMAvYnF6w4sX7/LIepDxOgQPstGBhaHj+cfNpWE2hsiL1EkZrtFVXEFvW+v6HZP7NWWI8eZoqboi91107Wufhzhj2B1PvdM
x-ms-office365-filtering-correlation-id: 0380aa64-dd27-4427-ec3d-08d62ae48618
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2373;
x-ms-traffictypediagnostic: DM5PR12MB2373:
x-microsoft-antispam-prvs: <DM5PR12MB237382018E26432B1DEEB56D95EB0@DM5PR12MB2373.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2373;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2373;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(52054003)(51914003)(6436002)(217873002)(71200400001)(93886005)(99286004)(305945005)(256004)(476003)(229853002)(2900100001)(4326008)(5660300001)(11346002)(316002)(446003)(2616005)(66066001)(6486002)(7736002)(72206003)(186003)(71190400001)(14454004)(97736004)(26005)(8936002)(478600001)(8676002)(54906003)(102836004)(81166006)(81156014)(25786009)(68736007)(86362001)(31696002)(5250100002)(36756003)(6506007)(2906002)(3846002)(6116002)(6916009)(7416002)(486006)(52116002)(53936002)(106356001)(31686004)(6246003)(6512007)(76176011)(53546011)(386003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2373;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w6F1duc4TMtS4BE0uUMp5EU30ZZ7SXM8vHWoTNb6ujjQFcnNMLOnHntHodANouONmocckbzt8kZ0kTJnPPRwAnjBHWS8I9fEqkrpwm1aLTERht7bACOqzWzNMbr5R9/zeGfhINFFWeoF5UZQNtgaoU7dEfM36o9TzekmABixgqEEbr2rhaf11UXz2t/SfVLGh59JaLHA+a06/mVQHJFVo/AzqJmh/n1c3x58Nv0Q4nEKH5+LV6AQGBCIm4UAV0Q/pGVZn+C//rOc7/0P5kp0spAw1NZnYHjt2mRY6GS28zkxxHsqPtVdNWBG1F+MASYUNrO89GkBgwoUleFVARrrreEpySNWAo+wO5YdFKEcwig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA669FAC499094089B0BA744991AE06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0380aa64-dd27-4427-ec3d-08d62ae48618
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 17:03:51.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCk9uIDEwLzA1LzIwMTggMTE6MTggQU0sIEphbWVzIE1vcnNlIHdyb3RlOg0K
PiBIaSBCYWJ1LA0KPiANCj4gKFRoYW5rcyBmb3IgbG9vcGluZyBtZSBpbiEpDQo+IA0KPiBPbiAy
OC8wOS8xOCAwMjo1NywgTW9nZXIsIEJhYnUgd3JvdGU6DQo+Pj4gT24gTW9uLCAyNCBTZXAgMjAx
OCwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+Pj4NCj4+Pj4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0
IGZvciBBTUQ2NCBhcmNoaXRlY3R1cmFsIGV4dGVuc2lvbnMgZm9yIFBsYXRmb3JtDQo+Pj4+IFF1
YWxpdHkgb2YgU2VydmljZS4gVGhlc2UgZXh0ZW5zaW9ucyBhcmUgaW50ZW5kZWQgdG8gcHJvdmlk
ZSBmb3IgdGhlDQo+Pj4+IG1vbml0b3Jpbmcgb2YgdGhlIHVzYWdlIG9mIGNlcnRhaW4gc3lzdGVt
IHJlc291cmNlcyBieSBvbmUgb3IgbW9yZQ0KPj4+PiBwcm9jZXNzb3JzIGFuZCBmb3IgdGhlIHNl
cGFyYXRlIGFsbG9jYXRpb24gYW5kIGVuZm9yY2VtZW50IG9mIGxpbWl0cyBvbg0KPj4+PiB0aGUg
dXNlIG9mIGNlcnRhaW4gc3lzdGVtIHJlc291cmNlcyBieSBvbmUgb3IgbW9yZSBwcm9jZXNzb3Jz
Lg0KPj4+Pg0KPj4+PiBUaGUgbW9uaXRvcmluZyBhbmQgZW5mb3JjZW1lbnQgYXJlIG5vdCBuZWNl
c3NhcmlseSBhcHBsaWVkIGFjcm9zcyB0aGUNCj4+Pj4gZW50aXJlIHN5c3RlbSwgYnV0IGluIGdl
bmVyYWwgYXBwbHkgdG8gYSBRT1MgZG9tYWluIHdoaWNoIGNvcnJlc3BvbmRzIHRvDQo+Pj4+IHNv
bWUgc2hhcmVkIHN5c3RlbSByZXNvdXJjZS4gIFRoZSBzZXQgb2YgcmVzb3VyY2VzIHdoaWNoIGFy
ZSBtb25pdG9yZWQNCj4+PiBhbmQNCj4+Pj4gdGhlIHNldCBmb3Igd2hpY2ggdGhlIGVuZm9yY2Vt
ZW50IG9mIGxpbWl0cyBpcyBwcm92aWRlZCBhcmUgaW1wbGVtZW50YXRpb24NCj4+Pj4gZGVwZW5k
ZW50LiBQbGF0Zm9ybSBRT1MgZmVhdHVyZXMgYXJlIGltcGxlbWVudGVkIG9uIGEgbG9naWNhbCBw
cm9jZXNzb3INCj4+PiBiYXNpcy4NCj4+Pj4gVGhlcmVmb3JlLCBtdWx0aXBsZSBoYXJkd2FyZSB0
aHJlYWRzIG9mIGEgc2luZ2xlIHBoeXNpY2FsIENQVSBjb3JlIG1heQ0KPj4+IGhhdmUNCj4+Pj4g
aW5kZXBlbmRlbnQgcmVzb3VyY2UgbW9uaXRvcmluZyBhbmQgZW5mb3JjZW1lbnQgY29uZmlndXJh
dGlvbnMuDQo+Pj4+DQo+Pj4+IEFNRCdzIG5leHQgZ2VuZXJhdGlvbiBvZiBwcm9jZXNzb3JzIHN1
cHBvcnQgZm9sbG93aW5nIFFvUyBzdWItZmVhdHVyZXMuDQo+Pj4+IC0gTDMgQ2FjaGUgYWxsb2Nh
dGlvbiBlbmZvcmNlbWVudA0KPj4+PiAtIEwzIENhY2hlIG9jY3VwYW5jeSBtb25pdG9yaW5nDQo+
Pj4+IC0gTDMgQ29kZS1EYXRhIFByaW9yaXRpemF0aW9uIHN1cHBvcnQNCj4+Pj4gLSBNZW1vcnkg
QmFuZHdpZHRoIEVuZm9yY2VtZW50KEFsbG9jYXRpb24pDQo+Pj4+DQo+Pj4+IFRoZSBwdWJsaWMg
c3BlY2lmaWNhdGlvbiBpcyBzdGlsbCBpbiB3b3Jrcy4gV2lsbCBhZGQgdGhlIGxpbmsgd2hlbiBp
dCBpcw0KPj4+PiBhdmFpbGFibGUuDQo+Pj4+DQo+Pj4+IE9idmlvdXNseSwgdGhlcmUgYXJlIG11
bHRpcGxlIHdheXMgd2UgY2FuIGdvIGFib3V0IHRoZXNlIGNoYW5nZXMuIFdlIGZlbHQNCj4+Pj4g
aXQgaXMgYXBwcm9wcmlhdGUgdG8gcmVuYW1lIGFuZCByZS1vcmdhbml6ZSB0aGUgY29kZSBsaXR0
bGUgYml0IGJlZm9yZQ0KPj4+PiBtYWtpbmcgdGhlIGZ1bmN0aW9uYWwgY2hhbmdlcy4gVGhlIGZp
cnN0IGZldyBwYXRjaGVzKDEtNikgcmVuYW1lcyBhbmQNCj4+Pj4gcmUtb3JnYW5pemVzIHRoZSBz
b3VyY2VzIGluIHByZXBhcmF0aW9uLiBSZXN0IG9mIHRoZSBwYXRjaGVzKDctMTApIGFkZHMNCj4+
Pj4gc3VwcG9ydCBmb3IgQU1EIFFvUyBmZWF0dXJlcy4NCj4+Pg0KPj4+IE9uIHRoZSBmaXJzdCBn
bGFuY2UgdGhpcyBhbGwgbG9va3Mgc2Vuc2libGUsIGJ1dCB0aGVyZSBpcyB3b3JrIGluIHByb2dy
ZXNzDQo+Pj4gYnkgSmFtZXMgTW9yc2UgKENjJ2VkKSwgd2hvIHdhbnRzIHRvIGdlbmVyYWxpemUg
dGhlIHJlc2N0cmwgZmlsZXN5c3RlbSBzbw0KPj4+IGl0IGNhbiBiZSByZXVzZWQgYnkgQVJNLiBJ
IGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgdGhhdCB5b3VyIHJlb3JnYW5pemF0aW9uDQo+Pj4gaXMg
bm90IGNvbGxpZGluZyBvciBjcmVhdGluZyBkdXBsaWNhdGUgZWZmb3J0Lg0KPiANCj4gQWhhLCBz
b21lIG9mIHRoaXMgbWFrZXMgbXkgbGlmZSBlYXNpZXIuIEknbSBhZ2FpbnN0IGhhdmluZyB0aGUg
QUJJIGRpZmZlcmVudA0KPiBiZXR3ZWVuIGFyY2hpdGVjdHVyZXMuIFRoaXMgbWVhbnQgY29udGln
dW91cyBiaXRtYXBzIG9uIGFybSwgd2hpY2ggdGhlIE1QQU0NCj4gc3R1ZmYgZG9lc24ndCBhY3R1
YWxseSByZXF1aXJlLi4uDQo+IA0KPiANCj4+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQu
IEkgaGF2ZSBsb29rZWQgdGhydSBKYW1lcyBwYXRjaGVzLiBJdCBhcHBlYXJzIHRoaXMNCj4+IHNl
cmllcyBpcyBvbmx5IGEgc21hbGwgcGFydCBvZiBoaXMgbXVjaCBiaWdnZXIgY2hhbmdlLiBEb24n
dCBrbm93IHRoZSB0aW1lZnJhbWUNCj4+IG9mIGhpcyBvdmVyYWxsIGNoYW5nZXMuDQo+PiBJIHdp
bGwgbGV0IGhpbSBzcGVhayBvbiB0aGF0Lg0KPiANCj4gTG9uZ2VyLCBhcyBpdHMgbW9yZSBpbnZh
c2l2ZSwNCg0KT2suIFRoYW5rcyBmb3IgdGhlIGhlYWRzIHVwLg0KDQo+IA0KPiANCj4+IFRoYXQg
YmVpbmcgc2FpZCwgSSBkb24ndCBjb25zaWRlciBvdXIgZWZmb3J0cyBhcw0KPj4gZHVwbGljYXRl
LiBIZSBpcyB0b3VjaGluZyB0aGUgcmVzb3VyY2Ugc3RydWN0dXJlcywgYW5kIHRyeWluZyB0byBz
ZXBhcmF0ZSBhcmNoLA0KPj4gbm9uLWFyY2ggY29tcG9uZW50cy4NCj4+IE15IGNoYW5nZXMgYXJl
IG1vc3RseSBpbnNpZGUgdGhlIHJlc291cmNlIHN0cnVjdHVyZXMobW9zdGx5IHJlc291cmNlIGhh
bmRsZXJzKQ0KPiANCj4+IGFuZCB0cnlpbmcgdG8gYWNjb21tb2RhdGUgbWlub3IgZGlmZmVyZW5j
ZXMgd2l0aGluIHRoZSBhcmNoaXRlY3R1cmUuICBJdCB3aWxsDQo+PiBiZSBtb3N0bHkgaW52b2x2
ZSByZWJhc2UNCj4+IGVmZm9ydCBvbiBlaXRoZXIgc2lkZSBpbiB0aGUgZW5kIHdob2V2ZXIgZ29l
cyBmaXJzdC4NCj4gDQo+PiBKYW1lcywgV2hhdCBhcmUgeW91ciB0aG91Z2h0cz8gDQo+IA0KPiBJ
IHRoaW5rIHlvdXIgc3R1ZmYgc2hvdWxkIGdvIGZpcnN0LiBJdCBkb2Vzbid0IGxvb2sgbGlrZSB5
b3UgYXJlIGFkZGluZyBuZXcNCj4gZmVhdHVyZXMvY29udHJvbHMsIHNvIGl0cyBub3JtYWxseTpw
YWluZnVsIGZvciBtZSB0byByZWJhc2Ugb3ZlciBpdC4NCj4gKGRvaW5nIGl0IHRoZSBvdGhlci13
YXkgcm91bmQgd291bGQgYmUgaGFyZGVyISkNCg0KT2suIFNvdW5kcyBnb29kLiBJIHdpbGwgc2Vu
ZCB2MiB2ZXJzaW9uIHNvb24uIEZlZWwgZnJlZSB0byByZXZpZXcuDQoNCg0KPiANCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEphbWVzDQo+IA0K
