Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B1CC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C7E20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sch46lXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C7E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJMDpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:45:46 -0400
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:10142
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbeJMDpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVr8dso+gobE2pPbng0xDrg38kmYHnfb8el7n+PLB2w=;
 b=Sch46lXhr6aIa17zw9OQHc6yIzH7CNDCRbgUPcFemd6ZMMU7bmPOCNOdhXgeo2LGmCNJPxkWrm9B/gLvKS0EBZP892VX2Q4Ulh6PXxO32a4/HR7naXbDmAM1PyGrf9QQabaPheES8NG8En9A2o2FuycjHS4nUyKxCX/yQdoFvZk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1627.namprd12.prod.outlook.com (10.172.40.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Fri, 12 Oct 2018 20:11:32 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 20:11:32 +0000
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
Subject: Re: [PATCH v3 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v3 01/11] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Index: AQHUYaGcaAGO/aAeYUywomcD6x+ZkKUb+m0AgAAR1AA=
Date:   Fri, 12 Oct 2018 20:11:32 +0000
Message-ID: <9014dc5c-434c-2cab-b229-599925138f21@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
 <20181011203223.18157-2-babu.moger@amd.com>
 <9c0e5be7-20e7-39dd-0852-e9b22d1df156@intel.com>
In-Reply-To: <9c0e5be7-20e7-39dd-0852-e9b22d1df156@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0135.namprd05.prod.outlook.com
 (2603:10b6:803:2c::13) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1627;20:3cK4/+d+PligMXUC1K3CNp8YVRriwj1/SzDPfmJDOYOheEO4kBu0hpXSAL2zFbWWYQ0TrHh6tr/d7hCFp5k7Kz+HBO1rK0AGSo2U2OHTv5VA5AUfta7KzROXP1sCknNddJubymmoMisTnpN2nBcpJPwTSqTXmQGYr0cgUo+KmbOfi4XRbEju2CdyNW1IVOKIiAtNC0ePRgTZc5MGw1yfXtoRbbd/qvDFWRk+gjXkghqSrEtGR+cu9QtFaSnPcgHz
x-ms-office365-filtering-correlation-id: 25b2cff0-3267-4d2c-b84d-08d6307ee6f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1627;
x-ms-traffictypediagnostic: DM5PR12MB1627:
x-microsoft-antispam-prvs: <DM5PR12MB16276827607384D893D4843895E20@DM5PR12MB1627.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1627;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1627;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(43544003)(189003)(11346002)(2616005)(66066001)(99286004)(446003)(476003)(7416002)(186003)(26005)(6246003)(229853002)(2900100001)(2906002)(6486002)(31686004)(6436002)(316002)(305945005)(54906003)(110136005)(7736002)(6512007)(71200400001)(71190400001)(53936002)(3846002)(5660300001)(52116002)(6116002)(8676002)(31696002)(81156014)(86362001)(81166006)(68736007)(2201001)(106356001)(105586002)(256004)(14444005)(5250100002)(36756003)(2501003)(102836004)(6506007)(53546011)(4326008)(386003)(25786009)(97736004)(72206003)(76176011)(14454004)(486006)(8936002)(478600001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1627;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XlPNHEBHb+VmkxLVO8UVSPWGoFYuY8GYrC9wjJyweMYnbxihBHslJvx3h0vJx1qP3E7/BZbnjalL1Rv7pXSoMu5LHf/pHx3eB6QjN/7F5+gzwX+4kGmSxY/cC6OyLsSlbI77/KBemKL06wfCOd+AMcOpVfOkM9sCpRmTFZicTVd71SO38gI7TCIWi6dV9xUBI/PCzopBMLO+ARG7yg5/Yt9c9fQ1B1ysB60M+8EGaUFs3T1iX3opOZhrtFnsa/QY1IXufCUna0/5vOGaCkb0989WGnlN4dwe3a54WXneQ0VEeNe5boFhraXCAJqJ1Q0gN3JYaDvNl1+QFQeapFMPBvJk+9tHDpZfRGHmStY35ic=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7691432E8B5D844CA0DEC96ADFFF6800@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b2cff0-3267-4d2c-b84d-08d6307ee6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 20:11:32.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCk9uIDEwLzEyLzIwMTggMDI6MDcgUE0sIFJlaW5ldHRlIENoYXRyZSB3
cm90ZToNCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEwLzExLzIwMTggMTozMyBQTSwgTW9nZXIsIEJh
YnUgd3JvdGU6DQo+PiBOZXcgZ2VuZXJhdGlvbiBvZiBBTUQgcHJvY2Vzc29ycyBzdGFydCBzdXBw
b3J0aW5nIFJEVChvciBRT1MpIGZlYXR1cmVzLg0KPj4gV2l0aCBtb3JlIHRoYW4gb25lIHZlbmRv
cnMgc3VwcG9ydGluZyB0aGVzZSBmZWF0dXJlcywgaXQgc2VlbXMgbW9yZQ0KPj4gYXBwcm9wcmlh
dGUgdG8gcmVuYW1lIHRoZXNlIGZpbGVzLg0KPj4NCj4+IENoYW5nZWQgaW50ZWxfcmR0IHRvIHJl
c2N0cmwgd2hlcmUgYXBwbGljYWJsZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2Vy
IDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS97
aW50ZWxfcmR0X3NjaGVkLmggPT4gcmVzY3RybF9zY2hlZC5ofSB8IDANCj4+ICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYgKysr
LS0tDQo+PiAgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0LmMgPT4gcmVzY3RybC5jfSAg
ICAgICAgICAgICAgfCA0ICsrLS0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHQu
aCA9PiByZXNjdHJsLmh9ICAgICAgICAgICAgICB8IDYgKysrLS0tDQo+PiAgLi4uL2NwdS97aW50
ZWxfcmR0X2N0cmxtb25kYXRhLmMgPT4gcmVzY3RybF9jdHJsbW9uZGF0YS5jfSAgfCAyICstDQo+
PiAgLi4uL2tlcm5lbC9jcHUve2ludGVsX3JkdF9tb25pdG9yLmMgPT4gcmVzY3RybF9tb25pdG9y
LmN9ICAgfCAyICstDQo+PiAgLi4uL2NwdS97aW50ZWxfcmR0X3BzZXVkb19sb2NrLmMgPT4gcmVz
Y3RybF9wc2V1ZG9fbG9jay5jfSAgfCA2ICsrKy0tLQ0KPj4gIC4uLl9yZHRfcHNldWRvX2xvY2tf
ZXZlbnQuaCA9PiByZXNjdHJsX3BzZXVkb19sb2NrX2V2ZW50Lmh9IHwgMiArLQ0KPj4gIC4uLi9r
ZXJuZWwvY3B1L3tpbnRlbF9yZHRfcmR0Z3JvdXAuYyA9PiByZXNjdHJsX3JkdGdyb3VwLmN9IHwg
NCArKy0tDQo+PiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfMzIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyICstDQo+PiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+PiAgMTEgZmlsZXMgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+PiAgcmVuYW1lIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3tpbnRlbF9yZHRfc2NoZWQuaCA9PiByZXNjdHJsX3NjaGVkLmh9ICgxMDAl
KQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHQuYyA9PiByZXNjdHJs
LmN9ICg5OSUpDQo+PiAgcmVuYW1lIGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdC5oID0+
IHJlc2N0cmwuaH0gKDk5JSkNCj4+ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxf
cmR0X2N0cmxtb25kYXRhLmMgPT4gcmVzY3RybF9jdHJsbW9uZGF0YS5jfSAoOTklKQ0KPj4gIHJl
bmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfbW9uaXRvci5jID0+IHJlc2N0cmxf
bW9uaXRvci5jfSAoOTklKQ0KPj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9y
ZHRfcHNldWRvX2xvY2suYyA9PiByZXNjdHJsX3BzZXVkb19sb2NrLmN9ICg5OSUpDQo+PiAgcmVu
YW1lIGFyY2gveDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdF9wc2V1ZG9fbG9ja19ldmVudC5oID0+
IHJlc2N0cmxfcHNldWRvX2xvY2tfZXZlbnQuaH0gKDk1JSkNCj4+ICByZW5hbWUgYXJjaC94ODYv
a2VybmVsL2NwdS97aW50ZWxfcmR0X3JkdGdyb3VwLmMgPT4gcmVzY3RybF9yZHRncm91cC5jfSAo
OTklKQ0KPj4NCj4gDQo+IEkgbWlzc2VkIHRoaXMgZWFybGllciAuLi4gdGhpcyBjaGFuZ2UgY3Jl
YXRlcyBhIG5lZWQgdG8gY2hhbmdlIHRoZQ0KPiBNQUlOVEFJTkVSUyBmaWxlLiBUaGVyZSB3ZXJl
IHNvbWUgb3RoZXIgdGhpbmdzIHRoYXQgYSBydW4gb2YNCg0KWWVzLiBJIHNlZSB0aGF0IG5vdy4g
V2UgbmVlZCB0byB1cGRhdGUgTUFJTlRBSU5FUlMgZmlsZS4NClRoZSBmaWxlIG5hbWUgRG9jdW1l
bnRhdGlvbi94ODYvaW50ZWxfcmR0X3VpLnR4dCBuZWVkcyByZW5hbWUuIEFsc28NCmNvbnRlbnRz
IG9mIHRoZSBmaWxlIG5lZWRzIHNvbWUgbWlub3IgY2hhbmdlcy4gV2lsbCB0YWtlIGNhcmUgb2Yg
aXQgaW4NCm5leHQgcmV2aXNpb24uDQoNCj4gImNoZWNrcGF0Y2gucGwgLS1zdHJpY3QiIHBpY2tl
ZCB1cCBpbiB0aGUgb3RoZXIgcGF0Y2hlcyB0aGF0IHlvdSBjb3VsZA0KPiBjb25zaWRlci4NCg0K
WWVzLiBXaXRoIC0tc3RyaWN0IEkgc2VlIHNvbWUgbW9yZSB3YXJuaW5ncy4gV2lsbCB0cnkgdG8g
Zml4IG1vc3Qgb2YgaXQuDQpTb3JyeSwgSSBkaWQgbm90IHJ1biAtLXN0cmljdCBiZWZvcmUuIFRo
ZXJlIGFyZSBjb3VwbGUgb2YgImxpbmUgb3ZlciA4MA0KY2hhcmFjdGVycyIgd2FybmluZ3Mgd2hp
Y2ggYXJlIGRpZmZpY3VsdCB0byBoYW5kbGUuIEkgd2lsbCBza2lwIHRob3NlLg0KDQo+IA0KPiBS
ZWluZXR0ZQ0KPiANCg==
