Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58FC65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAC7206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aLRBUAzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAC7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJFASW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:18:22 -0400
Received: from mail-dm3nam03on0061.outbound.protection.outlook.com ([104.47.41.61]:20288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbeJFASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC6L/4EG+8+sCc4GqkVwECu46gMLIg5PRtFw4Fpb+AM=;
 b=aLRBUAzyPrV3V59sbz8chl4DKzPe/fthqv+9pjHVx5Za8gwueNu5aK1YwfvlMi+oV3szTMEQemNjM5tvj+6LYN6pEmzdKI7gXkSBFgaFMW6lIPhCyYdXL//w46cUboSMc5xkFmnKh6LyOXbxmX3IQJgiGpHFVchy8SI2x+plZjg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1817.namprd12.prod.outlook.com (10.175.91.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Fri, 5 Oct 2018 17:18:35 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 17:18:35 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     James Morse <james.morse@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUVDt7FEaq7WNkoUWHOChzTz42MaUQ5kYAgAAQIIA=
Date:   Fri, 5 Oct 2018 17:18:35 +0000
Message-ID: <51b0b05e-800a-86ad-799e-6b8d1ff1ae14@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-11-babu.moger@amd.com>
 <81d5c963-0f00-29fa-2259-2b7fc26da123@arm.com>
In-Reply-To: <81d5c963-0f00-29fa-2259-2b7fc26da123@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:404:5f::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1817;20:VVZji8wuGmQqjTzoE5MtqOpI1N3RpN8/Mhf+hkC9deTgZ+q1wXxlVX08WcL5YvZ83Zn/OAxgZsbNuNfiavXO/I8oAcuzuyJX+Y4BtEzSpkSRFjnKuy482ftbHkPAKu+zmxfg5ZsBzsHDJLSFu8iVN6W0te9lNLlwEboDD+SoLhk9z4lTbCw5f310u0fq5PrRSYbK7aputtS/fnhgrA8noz1V6dsnsOlYpsFmvO6pQdy2lCYf6lNgJWZcXMWVisiq
x-ms-office365-filtering-correlation-id: 85a08939-c4ac-4b9b-6d68-08d62ae694ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1817;
x-ms-traffictypediagnostic: DM5PR12MB1817:
x-microsoft-antispam-prvs: <DM5PR12MB1817A363D290C36B162ADA1A95EB0@DM5PR12MB1817.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM5PR12MB1817;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1817;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(43544003)(106356001)(105586002)(52116002)(6506007)(6116002)(386003)(76176011)(3846002)(54906003)(53546011)(316002)(2906002)(99286004)(68736007)(97736004)(4326008)(6436002)(31686004)(5250100002)(14454004)(6246003)(6916009)(2900100001)(6512007)(36756003)(72206003)(6486002)(305945005)(229853002)(81166006)(7736002)(81156014)(53936002)(478600001)(8676002)(5660300001)(8936002)(446003)(476003)(2616005)(486006)(25786009)(102836004)(11346002)(71190400001)(71200400001)(7416002)(86362001)(26005)(186003)(31696002)(256004)(66066001)(217873002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1817;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K++Pn5LQmI0MDkOSIqHSn7YtPr1y18EFUvSN1tx2dNyYWPbERZ1hFXO3NE5lwtfMQ7I+J8Xv1R5yiosjX3TBXxfX7Y7lnu7faEdM3TxWaIfd5eXjsepWgc4fTqDWaCam7YSDB6ALxbGHB/CO6m+tr1AtNkzqVfKDF3eA0PLgIw3Bd4RXBjBwphNpskgZkgyX4/v2/OHuTvigUfghqVf1b2F68sgBEMXwUpK+ro6aACW1iE6Fp+zUvy/OeUYk98lWHI7kEpRs/xRPJYq72kKtORmeaLwaMcbD0DEbfLCeVYv/N8Dv5SjQ3/9aAuXbzLNWlEoVRdsCy13vklsmv8St2whkanck24JWbHsPvTFbE5g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA18247CFA92344E8EC473D0767871E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a08939-c4ac-4b9b-6d68-08d62ae694ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 17:18:35.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCk9uIDEwLzA1LzIwMTggMTE6MjAgQU0sIEphbWVzIE1vcnNlIHdyb3RlOg0K
PiBIaSBCYWJ1LA0KPiANCj4gT24gMjQvMDkvMTggMjA6MTksIE1vZ2VyLCBCYWJ1IHdyb3RlOg0K
Pj4gRW5hYmxlcyBRT1MgZmVhdHVyZSBvbiBBTUQuDQo+PiBGb2xsb3dpbmcgUW9TIHN1Yi1mZWF0
dXJlcyBhcmUgc3VwcG9ydGVkIGluIEFNRCBpZiB0aGUgdW5kZXJseWluZw0KPj4gaGFyZHdhcmUg
c3VwcG9ydHMgaXQuDQo+PiAgLSBMMyBDYWNoZSBhbGxvY2F0aW9uIGVuZm9yY2VtZW50DQo+PiAg
LSBMMyBDYWNoZSBvY2N1cGFuY3kgbW9uaXRvcmluZw0KPj4gIC0gTDMgQ29kZS1EYXRhIFByaW9y
aXRpemF0aW9uIHN1cHBvcnQNCj4+ICAtIE1lbW9yeSBCYW5kd2lkdGggRW5mb3JjZW1lbnQoQWxs
b2NhdGlvbikNCj4+DQo+PiBUaGVyZSBhcmUgZGlmZmVyZW5jZXMgaW4gdGhlIHdheSBzb21lIG9m
IHRoZSBmZWF0dXJlcyBhcmUgaW1wbGVtZW50ZWQuDQo+PiBTZXBhcmF0ZSB0aG9zZSBmdW5jdGlv
bnMgYW5kIGFkZCB0aG9zZSBhcyB2ZW5kb3Igc3BlY2lmaWMgZnVuY3Rpb25zLg0KPj4gVGhlIG1h
am9yIGRpZmZlcmVuY2UgaXMgaW4gTUJBIGZlYXR1cmUuDQo+PiAgLSBBTUQgdXNlcyBDUFVJRCBs
ZWFmIDB4ODAwMDAwMjAgdG8gaW5pdGlhbGl6ZSB0aGUgTUJBIGZlYXR1cmVzLg0KPj4gIC0gQU1E
IHVzZXMgZGlyZWN0IGJhbmR3aWR0aCB2YWx1ZSBpbnN0ZWFkIG9mIGRlbGF5IGJhc2VkIG9uIGJh
bmR3aWR0aA0KPj4gICAgdmFsdWVzLg0KPj4gIC0gTVNSIHJlZ2lzdGVyIGJhc2UgYWRkcmVzc2Vz
IGFyZSBkaWZmZXJlbnQgZm9yIE1CQS4NCj4gDQo+PiAgLSBBbHNvIEFNRCBhbGxvd3Mgbm9uLWNv
bnRpZ3VvdXMgTDMgY2FjaGUgYml0IG1hc2tzLg0KPiANCj4gTmljZSENCj4gDQo+IFRoaXMgaXMg
dmlzaWJsZSB0byB1c2VyLXNwYWNlLCB0aGUgJ0NhY2hlIEJpdCBNYXNrcyAoQ0JNKScgc2VjdGlv
biBvZg0KPiBEb2N1bWVudGF0aW9uL3g4Ni9pbnRlbF9yZHRfdWkudHh0IGN1cnJlbnRseSBzYXlz
ICdYODYgaGFyZHdhcmUgcmVxdWlyZXMgLi4uIGENCj4gY29udGlndW91cyBibG9jaycuDQo+IA0K
PiBEb2VzIHVzZXItc3BhY2UgbmVlZCB0byBrbm93IGl0IGNhbiBkbyB0aGlzIGluIGFkdmFuY2Us
IG9yIGlzIGl0IGEgdHJ5LWl0LWFuZC1zZWU/DQoNCkl0IGlzIHRyeS1pdC1hbmQtc2VlLg0KPiAN
Cj4gQXJtJ3MgTVBBTSBzdHVmZiBjYW4gZG8gdGhpcyB0b28sIGJ1dCBJJ20gYWdhaW5zdCBoYXZp
bmcgdGhlIEFCSSB2YXJ5IGJldHdlZW4NCj4gYXJjaGl0ZWN0dXJlcy4gSWYgdGhpcyBpcyBnb2lu
ZyB0byBiZSBkaXNjb3ZlcmFibGUsIEknZCBsaWtlIGl0IHRvIHdvcmsgb24gQXJtIHRvby4NCg0K
SXQgbm90IGRpc2NvdmVyYWJsZSBhdCB0aGlzIHBvaW50LiBNb3N0bHkgcHJlZGVmaW5lZC4gWWVz
LiBJdCB3aWxsIGJlIGJpdA0Kb2YgYSBjaGFsbGVuZ2UgaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2Vz
LiBXZSBtYXkgaGF2ZSB0byBjb21lIHVwIHdpdGggc29tZQ0Ka2luZCBvZiBhIGZsYWcob3Igc29t
ZXRoaW5nKSB0byBtYWtlIGl0IGxvb2sgc2ltaWxhciBvbiB0aGUgQUJJIHNpZGUuDQoNCj4gDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBKYW1lcw0KPiANCj4+IEFkZHMgZm9sbG93aW5nIGZ1bmN0aW9u
cyB0byB0YWtlIGNhcmUgb2YgdGhlIGRpZmZlcmVuY2VzLg0KPj4gcmR0X2dldF9tZW1fY29uZmln
X2FtZCA6IE1CQSBpbml0aWFsaXphdGlvbiBmdW5jdGlvbg0KPj4gcGFyc2VfYndfYW1kIDogQmFu
ZHdpZHRoIHBhcnNpbmcNCj4+IG1iYV93cm1zcl9hbWQ6IFdyaXRlcyBiYW5kd2lkdGggdmFsdWUN
Cj4+IGNibV92YWxpZGF0ZV9hbWQgOiBMMyBjYWNoZSBiaXRtYXNrIHZhbGlkYXRpb24NCj4gDQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZHRfY3RybG1vbmRhdGEuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvcmR0X2N0cmxtb25kYXRhLmMNCj4+IGluZGV4IDVhMjgyYjZjNGJk
Ny4uMWU0NjMxZjg4Njk2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZHRf
Y3RybG1vbmRhdGEuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZHRfY3RybG1vbmRh
dGEuYw0KPj4gQEAgLTEyMyw2ICsxNjksNDEgQEAgYm9vbCBjYm1fdmFsaWRhdGUoY2hhciAqYnVm
LCB1MzIgKmRhdGEsIHN0cnVjdCByZHRfcmVzb3VyY2UgKnIpDQo+PiAgCXJldHVybiB0cnVlOw0K
Pj4gIH0NCj4+ICANCj4+ICsvKg0KPj4gKyAqIENoZWNrIHdoZXRoZXIgYSBjYWNoZSBiaXQgbWFz
ayBpcyB2YWxpZC4gQU1EIGFsbG93cw0KPj4gKyAqIG5vbi1jb250aWd1b3VzIG1hc2tzLg0KPj4g
KyAqLw0KPj4gK2Jvb2wgY2JtX3ZhbGlkYXRlX2FtZChjaGFyICpidWYsIHUzMiAqZGF0YSwgc3Ry
dWN0IHJkdF9yZXNvdXJjZSAqcikNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGxvbmcgZmlyc3RfYml0
LCB6ZXJvX2JpdCwgdmFsOw0KPj4gKwl1bnNpZ25lZCBpbnQgY2JtX2xlbiA9IHItPmNhY2hlLmNi
bV9sZW47DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCXJldCA9IGtzdHJ0b3VsKGJ1ZiwgMTYs
ICZ2YWwpOw0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlyZHRfbGFzdF9jbWRfcHJpbnRmKCJub24t
aGV4IGNoYXJhY3RlciBpbiBtYXNrICVzXG4iLCBidWYpOw0KPj4gKwkJcmV0dXJuIGZhbHNlOw0K
Pj4gKwl9DQo+PiArDQo+PiArCWlmICh2YWwgPT0gMCB8fCB2YWwgPiByLT5kZWZhdWx0X2N0cmwp
IHsNCj4+ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJtYXNrIG91dCBvZiByYW5nZVxuIik7DQo+PiAr
CQlyZXR1cm4gZmFsc2U7DQo+PiArCX0NCj4+ICsNCj4+ICsJZmlyc3RfYml0ID0gZmluZF9maXJz
dF9iaXQoJnZhbCwgY2JtX2xlbik7DQo+PiArCXplcm9fYml0ID0gZmluZF9uZXh0X3plcm9fYml0
KCZ2YWwsIGNibV9sZW4sIGZpcnN0X2JpdCk7DQo+PiArDQo+PiArDQo+PiArCWlmICgoemVyb19i
aXQgLSBmaXJzdF9iaXQpIDwgci0+Y2FjaGUubWluX2NibV9iaXRzKSB7DQo+PiArCQlyZHRfbGFz
dF9jbWRfcHJpbnRmKCJOZWVkIGF0IGxlYXN0ICVkIGJpdHMgaW4gbWFza1xuIiwNCj4+ICsJCQkJ
ICAgIHItPmNhY2hlLm1pbl9jYm1fYml0cyk7DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCX0N
Cj4+ICsNCj4+ICsJKmRhdGEgPSB2YWw7DQo+PiArCXJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsN
Cj4+ICBzdHJ1Y3QgcmR0X2NibV9wYXJzZV9kYXRhIHsNCj4+ICAJc3RydWN0IHJkdGdyb3VwCQkq
cmR0Z3JwOw0KPj4gIAljaGFyCQkJKmJ1ZjsNCj4+DQo+IA0K
