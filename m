Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154D2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eOQh9ROf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154D2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJCWVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:21:31 -0400
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:17913
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbeJCWVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOhOA6dCsmvBYa8PLhsPF25aMgI8B1NaeZvbhFRooJU=;
 b=eOQh9ROfofQulJrNw/XbMYpDdXZT2GtH/rfJfXknpH7IzZyFoRba5Yp7DJ14E2jiWalhyrYIKC/cy2deW70QJJqq/zraNnpKYtaPAp5ERfccQS4fxK3r8oXxPaDFHtvwbkZi6vkHFHmeFpE8+eRYTZbP/HvJH3hb5Qle0OL5WQY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1739.namprd12.prod.outlook.com (10.175.89.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.19; Wed, 3 Oct 2018 15:32:29 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 15:32:29 +0000
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
Subject: Re: [RFC PATCH 07/10] arch/x86: Bring few more functions into the
 resource structure
Thread-Topic: [RFC PATCH 07/10] arch/x86: Bring few more functions into the
 resource structure
Thread-Index: AQHUVDt4YuH74QyC9kKLTMNotdmRdKUMkB8AgAEj+4A=
Date:   Wed, 3 Oct 2018 15:32:29 +0000
Message-ID: <21cf288a-d9c9-a976-863b-5bb875d01ecc@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-8-babu.moger@amd.com>
 <6a4085c8-b220-1694-eb96-e858f2a091f5@intel.com>
In-Reply-To: <6a4085c8-b220-1694-eb96-e858f2a091f5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:910:14::25) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1739;20:2c8a+YQM8Ed3V52jci94nlEp0cpk17KpQfUOOiLm6NWdmqyDZrqLq2eZqRmU2cBVWEgFRX0WNuPU4baif1G5ZUH1vmAnCdRizdqSKPENPi4WgsNlVIoe2PoksRzOWvqzrE9+Ntt14Gm+o2mr/+ckBD9tPOZ4MdyASGKf3sDOhVXeqWFGIHpZPdzcX2n774pSDWDNKd20OjWE48Bo9Vy7EhWa6ePfRQ8mI18E+ma+OU3vAut3ICQkCEdiNhXtqB5X
x-ms-office365-filtering-correlation-id: 54fa1e47-f86f-45dc-b1f1-08d629456ddb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1739;
x-ms-traffictypediagnostic: DM5PR12MB1739:
x-microsoft-antispam-prvs: <DM5PR12MB173986D60CFE4A790415AABE95E90@DM5PR12MB1739.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(72170088055959)(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM5PR12MB1739;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1739;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(8936002)(2906002)(11346002)(25786009)(486006)(8676002)(102836004)(2616005)(31686004)(229853002)(305945005)(446003)(72206003)(2900100001)(6486002)(81166006)(14454004)(81156014)(71200400001)(478600001)(7416002)(36756003)(5660300001)(476003)(7736002)(2201001)(71190400001)(3846002)(6116002)(575784001)(6436002)(256004)(110136005)(54906003)(4326008)(31696002)(68736007)(76176011)(217873002)(53546011)(386003)(6506007)(99286004)(14444005)(52116002)(26005)(5250100002)(86362001)(316002)(6512007)(2501003)(53936002)(97736004)(6246003)(186003)(105586002)(106356001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1739;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MIzl7Md75nOmdNCfHE0ot4ihBb1tx1qKC+gedWws4/6sl8tN3yLBXXTyoTpQb6UQ50UbTXON5LaE9KhUkiSUWpKDBTxjStENVSreLy2lTGF+ZdDw78NI9Yx0HSQQoKErQU9UnqOdNKQBBd9hVe8iripquSWVvrg2TdMlN1A/8Subja6tOH9IY7m+kYTN/txrnjuOewEOZTreckjL29IuR+q2mFBRZwPLxGIw/ggoVEzDiGLX8JugeQw8iqeZYzDZA1x5QNZU6X3PXIPq7amyldsMKAy5UYfiQypFd3Dcg2NBpkYOg7FHlm0J085UoGdJ2H6bWqOrHL0NZb9ushlpeIgQLs4U4vhwDEjNoyOblJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B4B4019FF2B6745A2B40364CDB68B92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fa1e47-f86f-45dc-b1f1-08d629456ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 15:32:29.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAyLzIwMTggMDU6MDcgUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gSGkg
QmFidSwNCj4gDQo+IE9uIDkvMjQvMjAxOCAxMjoxOSBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+
PiBCcmluZyBhbGwgcmVzb3VyY2UgZnVuY3Rpb25zIHRoYXQgYXJlIGRpZmZlcmVudCBiZXR3ZWVu
IHRoZSB2ZW5kb3JzDQo+PiBpbnRvIHJlc291cmNlIHN0cnVjdHVyZSBhbmQgaW5pdGlhbGl6ZSB0
aGVtIGR5bmFtaWNhbGx5Lg0KPj4NCj4+IEltcGxlbWVudCB0aGVzZSBmdW5jdGlvbnMgc2VwYXJh
dGVseSBmb3IgZWFjaCB2ZW5kb3JzLg0KPj4gdXBkYXRlX21iYV9idyA6IEZlZWRiYWNrIGxvb3Ag
YmFuZHdpZHRoIHVwZGF0ZSBmdW5jdGlvbmFsaXR5IGlzIG5vdA0KPj4gICAgICAgICAgICAgICAg
IG5lZWRlZCBmb3IgQU1ELg0KPj4gY2JtX3ZhbGlkYXRlICA6IENhY2hlIGJpdG1hc2sgdmFsaWRh
dGUgZnVuY3Rpb24uIEFNRCBhbGxvd3MNCj4+ICAgICAgICAgICAgICAgICBub24tY29udGlndW91
cyBtYXNrcy4gU28sIHVzZSBzZXBhcmF0ZSBmdW5jdGlvbnMgZm9yDQo+PiAgICAgICAgICAgICAg
ICAgSW50ZWwgYW5kIEFNRC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1
Lm1vZ2VyQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdC5jICAg
ICAgICAgICAgIHwgMTcgKysrKysrKysrKysrKy0tLS0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L3JkdC5oICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIGFyY2gveDg2
L2tlcm5lbC9jcHUvcmR0X2N0cmxtb25kYXRhLmMgfCAgNCArKy0tDQo+PiAgYXJjaC94ODYva2Vy
bmVsL2NwdS9yZHRfbW9uaXRvci5jICAgICB8IDEwICsrKysrKystLS0NCj4+ICA0IGZpbGVzIGNo
YW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZHQu
Yw0KPj4gaW5kZXggNmRlYzQ1YmY4MWQ2Li5hZTI2YjliM2ZhZmEgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3JkdC5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jk
dC5jDQo+PiBAQCAtODY3LDEwICs4NjcsMTkgQEAgc3RhdGljIF9faW5pdCB2b2lkIHJkdF9pbml0
X3Jlc19kZWZzX2ludGVsKHZvaWQpDQo+PiAgCXN0cnVjdCByZHRfcmVzb3VyY2UgKnI7DQo+PiAg
DQo+PiAgCWZvcl9lYWNoX3JkdF9yZXNvdXJjZShyKSB7DQo+PiAtCQlpZiAoci0+cmlkID09IFJE
VF9SRVNPVVJDRV9NQkEpIHsNCj4+IC0JCQlyLT5tc3JfYmFzZSA9IElBMzJfTUJBX1RIUlRMX0JB
U0U7DQo+PiAtCQkJci0+bXNyX3VwZGF0ZSA9IG1iYV93cm1zcjsNCj4+IC0JCQlyLT5wYXJzZV9j
dHJsdmFsID0gcGFyc2VfYnc7DQo+PiArCQlpZiAoKHItPnJpZCA9PSBSRFRfUkVTT1VSQ0VfTDMp
IHx8DQo+PiArCQkgICAgKHItPnJpZCA9PSBSRFRfUkVTT1VSQ0VfTDNEQVRBKSB8fA0KPj4gKwkJ
ICAgIChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX0wzQ09ERSkgfHwNCj4+ICsJCSAgICAoci0+cmlk
ID09IFJEVF9SRVNPVVJDRV9MMikgfHwNCj4+ICsJCSAgICAoci0+cmlkID09IFJEVF9SRVNPVVJD
RV9MMkRBVEEpIHx8DQo+PiArCQkgICAgKHItPnJpZCA9PSBSRFRfUkVTT1VSQ0VfTDJDT0RFKSkN
Cj4+ICsJCQlyLT5jYm1fdmFsaWRhdGUgPSBjYm1fdmFsaWRhdGU7DQo+IA0KPiBTYW1lIGNvbW1l
bnQgaGVyZSBhYm91dCBuYW1pbmcgYXMgaW4gcGF0Y2ggNi4gTGF0ZXIgY2JtX3ZhbGlkYXRlX2Ft
ZA0KPiB3b3VsZCBhcHBlYXIgd2hpbGUgdGhpcyByZW1haW5zIC0gdG8gaGVscCByZWR1Y2UgY29u
ZnVzaW9uIGl0IG1heSBoZWxwDQo+IHRvIHJlbmFtZSB0aGlzIGZ1bmN0aW9uIHRvIGNibV92YWxp
ZGF0ZV9pbnRlbCBhdCB0aGlzIHRpbWUuDQoNClN1cmUuICBXaWxsIG1ha2UgdGhpcyBjaGFuZ2Uu
DQoNCj4gDQo+PiArDQo+PiArCQllbHNlIGlmIChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX01CQSkg
ew0KPj4gKwkJCSByLT5tc3JfYmFzZSA9IElBMzJfTUJBX1RIUlRMX0JBU0U7DQo+PiArCQkJIHIt
Pm1zcl91cGRhdGUgPSBtYmFfd3Jtc3I7DQo+PiArCQkJIHItPnBhcnNlX2N0cmx2YWwgPSBwYXJz
ZV9idzsNCj4+ICsJCQkgci0+dXBkYXRlX21iYV9idyA9IHVwZGF0ZV9tYmFfYnc7DQo+IA0KPiBT
YW1lIGNvbW1lbnQgYWJvdXQgbmFtaW5nLg0KDQpZZXMuICBXaWxsIGFkZCBfaW50ZWwgdG8gdGhl
c2UgZnVuY3Rpb25zLg0KDQo+IA0KPj4gIAkJfQ0KPj4gIAl9DQo+PiAgfQ0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmggYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3JkdC5o
DQo+PiBpbmRleCAyNTY5YzEwYzM3ZjQuLjcyMDUxNTdkMzU5YiAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvcmR0LmgNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0
LmgNCj4+IEBAIC0zODYsOSArMzg2LDkgQEAgc3RhdGljIGlubGluZSBib29sIGlzX21ibV9ldmVu
dChpbnQgZSkNCj4+ICAgKiBzdHJ1Y3QgcmR0X3Jlc291cmNlIC0gYXR0cmlidXRlcyBvZiBhbiBS
RFQgcmVzb3VyY2UNCj4+ICAgKiBAcmlkOgkJVGhlIGluZGV4IG9mIHRoZSByZXNvdXJjZQ0KPj4g
ICAqIEBhbGxvY19lbmFibGVkOglJcyBhbGxvY2F0aW9uIGVuYWJsZWQgb24gdGhpcyBtYWNoaW5l
DQo+PiAtICogQG1vbl9lbmFibGVkOgkJSXMgbW9uaXRvcmluZyBlbmFibGVkIGZvciB0aGlzIGZl
YXR1cmUNCj4+ICsgKiBAbW9uX2VuYWJsZWQ6CUlzIG1vbml0b3JpbmcgZW5hYmxlZCBmb3IgdGhp
cyBmZWF0dXJlDQo+PiAgICogQGFsbG9jX2NhcGFibGU6CUlzIGFsbG9jYXRpb24gYXZhaWxhYmxl
IG9uIHRoaXMgbWFjaGluZQ0KPj4gLSAqIEBtb25fY2FwYWJsZToJCUlzIG1vbml0b3IgZmVhdHVy
ZSBhdmFpbGFibGUgb24gdGhpcyBtYWNoaW5lDQo+PiArICogQG1vbl9jYXBhYmxlOglJcyBtb25p
dG9yIGZlYXR1cmUgYXZhaWxhYmxlIG9uIHRoaXMgbWFjaGluZQ0KPj4gICAqIEBuYW1lOgkJTmFt
ZSB0byB1c2UgaW4gInNjaGVtYXRhIiBmaWxlDQo+PiAgICogQG51bV9jbG9zaWQ6CQlOdW1iZXIg
b2YgQ0xPU0lEcyBhdmFpbGFibGUNCj4+ICAgKiBAY2FjaGVfbGV2ZWw6CVdoaWNoIGNhY2hlIGxl
dmVsIGRlZmluZXMgc2NvcGUgb2YgdGhpcyByZXNvdXJjZQ0KPj4gQEAgLTQwMCwxMCArNDAwLDEy
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19tYm1fZXZlbnQoaW50IGUpDQo+PiAgICogQGNhY2hl
OgkJQ2FjaGUgYWxsb2NhdGlvbiByZWxhdGVkIGRhdGENCj4+ICAgKiBAZm9ybWF0X3N0cjoJCVBl
ciByZXNvdXJjZSBmb3JtYXQgc3RyaW5nIHRvIHNob3cgZG9tYWluIHZhbHVlDQo+PiAgICogQHBh
cnNlX2N0cmx2YWw6CVBlciByZXNvdXJjZSBmdW5jdGlvbiBwb2ludGVyIHRvIHBhcnNlIGNvbnRy
b2wgdmFsdWVzDQo+PiAtICogQGV2dF9saXN0OgkJCUxpc3Qgb2YgbW9uaXRvcmluZyBldmVudHMN
Cj4+IC0gKiBAbnVtX3JtaWQ6CQkJTnVtYmVyIG9mIFJNSURzIGF2YWlsYWJsZQ0KPj4gLSAqIEBt
b25fc2NhbGU6CQkJY3FtIGNvdW50ZXIgKiBtb25fc2NhbGUgPSBvY2N1cGFuY3kgaW4gYnl0ZXMN
Cj4+IC0gKiBAZmZsYWdzOgkJCWZsYWdzIHRvIGNob29zZSBiYXNlIGFuZCBpbmZvIGZpbGVzDQo+
PiArICogQHVwZGF0ZV9tYmFfYnc6CUZlZWRiYWNrIGxvb3AgZm9yIE1CQSBzb2Z0d2FyZSBjb250
cm9sbGVyZXIgZnVuY3Rpb24NCj4gDQo+IGNvbnRyb2xsZXJlciAtPiBjb250cm9sbGVyID8NCg0K
WWVzLiBXaWxsIGZpeCBpdC4NCg0KPiANCj4+ICsgKiBAY2JtX3ZhbGlkYXRlCUNhY2hlIGJpdG1h
c2sgdmFsaWRhdGUgZnVuY3Rpb24NCj4+ICsgKiBAZXZ0X2xpc3Q6CQlMaXN0IG9mIG1vbml0b3Jp
bmcgZXZlbnRzDQo+PiArICogQG51bV9ybWlkOgkJTnVtYmVyIG9mIFJNSURzIGF2YWlsYWJsZQ0K
Pj4gKyAqIEBtb25fc2NhbGU6CQljcW0gY291bnRlciAqIG1vbl9zY2FsZSA9IG9jY3VwYW5jeSBp
biBieXRlcw0KPj4gKyAqIEBmZmxhZ3M6CQlmbGFncyB0byBjaG9vc2UgYmFzZSBhbmQgaW5mbyBm
aWxlcw0KPj4gICAqLw0KPj4gIHN0cnVjdCByZHRfcmVzb3VyY2Ugew0KPj4gIAlpbnQJCQlyaWQ7
DQo+PiBAQCAtNDI1LDYgKzQyNyw5IEBAIHN0cnVjdCByZHRfcmVzb3VyY2Ugew0KPj4gIAljb25z
dCBjaGFyCQkqZm9ybWF0X3N0cjsNCj4+ICAJaW50ICgqcGFyc2VfY3RybHZhbCkJKHZvaWQgKmRh
dGEsIHN0cnVjdCByZHRfcmVzb3VyY2UgKnIsDQo+PiAgCQkJCSBzdHJ1Y3QgcmR0X2RvbWFpbiAq
ZCk7DQo+PiArCXZvaWQgKCp1cGRhdGVfbWJhX2J3KSAgIChzdHJ1Y3QgcmR0Z3JvdXAgKnJncnAs
DQo+PiArCQkJCSBzdHJ1Y3QgcmR0X2RvbWFpbiAqZG9tX21ibSk7DQo+PiArCWJvb2wgKCpjYm1f
dmFsaWRhdGUpICAgIChjaGFyICpidWYsIHUzMiAqZGF0YSwgc3RydWN0IHJkdF9yZXNvdXJjZSAq
cik7DQo+PiAgCXN0cnVjdCBsaXN0X2hlYWQJZXZ0X2xpc3Q7DQo+PiAgCWludAkJCW51bV9ybWlk
Ow0KPj4gIAl1bnNpZ25lZCBpbnQJCW1vbl9zY2FsZTsNCj4+IEBAIC01NjIsNSArNTY3LDcgQEAg
dm9pZCBjcW1fc2V0dXBfbGltYm9faGFuZGxlcihzdHJ1Y3QgcmR0X2RvbWFpbiAqZG9tLCB1bnNp
Z25lZCBsb25nIGRlbGF5X21zKTsNCj4+ICB2b2lkIGNxbV9oYW5kbGVfbGltYm8oc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKTsNCj4+ICBib29sIGhhc19idXN5X3JtaWQoc3RydWN0IHJkdF9yZXNv
dXJjZSAqciwgc3RydWN0IHJkdF9kb21haW4gKmQpOw0KPj4gIHZvaWQgX19jaGVja19saW1ibyhz
dHJ1Y3QgcmR0X2RvbWFpbiAqZCwgYm9vbCBmb3JjZV9mcmVlKTsNCj4+ICt2b2lkIHVwZGF0ZV9t
YmFfYncoc3RydWN0IHJkdGdyb3VwICpyZ3JwLCBzdHJ1Y3QgcmR0X2RvbWFpbiAqZG9tX21ibSk7
DQo+PiArYm9vbCBjYm1fdmFsaWRhdGUoY2hhciAqYnVmLCB1MzIgKmRhdGEsIHN0cnVjdCByZHRf
cmVzb3VyY2UgKnIpOw0KPj4gIA0KPj4gICNlbmRpZiAvKiBfQVNNX1g4Nl9SRFRfSCAqLw0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0X2N0cmxtb25kYXRhLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3JkdF9jdHJsbW9uZGF0YS5jDQo+PiBpbmRleCAwNTY1YzU2NGIyOTcu
LjVhMjgyYjZjNGJkNyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0X2N0
cmxtb25kYXRhLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0X2N0cmxtb25kYXRh
LmMNCj4+IEBAIC04OCw3ICs4OCw3IEBAIGludCBwYXJzZV9idyh2b2lkICpfYnVmLCBzdHJ1Y3Qg
cmR0X3Jlc291cmNlICpyLCBzdHJ1Y3QgcmR0X2RvbWFpbiAqZCkNCj4+ICAgKglhcmUgYWxsb3dl
ZCAoZS5nLiBGRkZGSCwgMEZGMEgsIDAwM0NILCBldGMuKS4NCj4+ICAgKiBBZGRpdGlvbmFsbHkg
SGFzd2VsbCByZXF1aXJlcyBhdCBsZWFzdCB0d28gYml0cyBzZXQuDQo+PiAgICovDQo+PiAtc3Rh
dGljIGJvb2wgY2JtX3ZhbGlkYXRlKGNoYXIgKmJ1ZiwgdTMyICpkYXRhLCBzdHJ1Y3QgcmR0X3Jl
c291cmNlICpyKQ0KPj4gK2Jvb2wgY2JtX3ZhbGlkYXRlKGNoYXIgKmJ1ZiwgdTMyICpkYXRhLCBz
dHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KPj4gIHsNCj4+ICAJdW5zaWduZWQgbG9uZyBmaXJzdF9i
aXQsIHplcm9fYml0LCB2YWw7DQo+PiAgCXVuc2lnbmVkIGludCBjYm1fbGVuID0gci0+Y2FjaGUu
Y2JtX2xlbjsNCj4+IEBAIC0xNTMsNyArMTUzLDcgQEAgaW50IHBhcnNlX2NibSh2b2lkICpfZGF0
YSwgc3RydWN0IHJkdF9yZXNvdXJjZSAqciwgc3RydWN0IHJkdF9kb21haW4gKmQpDQo+PiAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4+ICAJfQ0KPj4gIA0KPj4gLQlpZiAoIWNibV92YWxpZGF0ZShkYXRh
LT5idWYsICZjYm1fdmFsLCByKSkNCj4+ICsJaWYgKChyLT5jYm1fdmFsaWRhdGUpICYmICEoci0+
Y2JtX3ZhbGlkYXRlKGRhdGEtPmJ1ZiwgJmNibV92YWwsIHIpKSkNCj4gDQo+IEkgZG8gbm90IHRo
aW5rIHlvdSBuZWVkIGFsbCBvZiB0aG9zZSBicmFja2V0cy4NCg0KWWVzLiBXaWxsIHNpbXBsaWZ5
IHRoaXMuDQoNCj4gDQo+IFJlaW5ldHRlDQo+IA0K
