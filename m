Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CB421470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dq5Bjxit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CB421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJDC7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:59:30 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:13841
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbeJDC73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ms91qf1iC/o/uoKAQSuI+LxZZJ5npQt9tHfjhYdLy4=;
 b=Dq5BjxitCZEQvnEF4sCYxHT9FHigVep3bUOyaPpA+MZCrXsEx8DXIll7jmPQNBNgkXt5W055iJH6MP+Q/hjHz1z2QsIx14As3zxzkm8j1jhNtyJavs7P18O1D7RyYr0b6ELwMS2Awov3wYOtRdulCh9BTVlr7l/zuEFkeZaerxg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1660.namprd12.prod.outlook.com (10.172.40.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Wed, 3 Oct 2018 20:09:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 20:09:16 +0000
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
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLaUMPC4AgAAI7GCAABLSAP//tJaAgAHfZoCAABWHAA==
Date:   Wed, 3 Oct 2018 20:09:16 +0000
Message-ID: <874cdcfb-26fa-2bdb-095d-b1b5a88250b9@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20181002170655.GA92941@romley-ivt3.sc.intel.com>
 <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com>
 <20181002184614.GC92941@romley-ivt3.sc.intel.com>
 <2549597a-440c-ab77-2c35-01a648703b9f@amd.com>
 <20181003185209.GA98542@romley-ivt3.sc.intel.com>
In-Reply-To: <20181003185209.GA98542@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:910:16::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1660;20:ksV9PDW3res1sHx5rM4egHc+fokURJGOu2EmCsu7vLMB6iT1xuiWICWm/Vz2/xowyqolQ3wwV4b7JfJVzh9D1UuwIb1WAnHU8oDtxb7ozcO3JKOUUrXIwPH2FRkXP2toFtaS8eL3TQYLZ1fK3/qXIUOKkQVz8+EIzhPZJ46fgqbr6chx85otp+9F+YwBPEVwVmB31gw8yvcr8fr5qnDZy7A9DQL2Buu95PlMi1Nf4ODsVSmNFEt1M+xrQocnlrYJ
x-ms-office365-filtering-correlation-id: edc1847a-1a57-4280-c725-08d6296c1824
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1660;
x-ms-traffictypediagnostic: DM5PR12MB1660:
x-microsoft-antispam-prvs: <DM5PR12MB16609B941B5DA3B9FB4E26CE95E90@DM5PR12MB1660.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(788757137089)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR12MB1660;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1660;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(189003)(199004)(2900100001)(186003)(31686004)(11346002)(446003)(7736002)(36756003)(81166006)(316002)(81156014)(486006)(8676002)(305945005)(66066001)(105586002)(7416002)(93886005)(8936002)(106356001)(478600001)(25786009)(966005)(2616005)(72206003)(14454004)(68736007)(102836004)(71190400001)(6916009)(31696002)(54906003)(71200400001)(229853002)(6506007)(256004)(386003)(2906002)(76176011)(26005)(6486002)(52116002)(97736004)(86362001)(217873002)(4326008)(53546011)(5660300001)(6512007)(6436002)(6306002)(476003)(99286004)(53936002)(5250100002)(6116002)(6246003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1660;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CBC964DodGhhkRGBJj48c+dH8FZ+SIK+GNZsix7EM3dEhJ6YXrILGaTeePQcsDJtJhgmSSgFBYqdMoaxTd5BqzX/pPqZ2LbIGA1/c5wlCSt5ClQ0pVktQ/x4G6jj8Lb86g1Y+uQLprbROm0u41jvODDkps2V8LVeL5RrPI5Gr5ZXTicUQ4ixSF5aMmMSsjbFEENgWt5+y9BrmaMncgpRHnnCuIPCTfb8D0v6iwZP427xc+GMpMQTmmUGCoiXV1kXhTLNZre/Z9+rJfMX6x04kBFDWsTHnApQ5IN1koz3fqXJe9uaXloMXiCvvwoTyjzi00EtPI15gvNSuPgQ8H+Qn/LdqHBkMQo5H7WcJXls1cQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D95CF76A143984897849DD7250F455A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc1847a-1a57-4280-c725-08d6296c1824
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 20:09:16.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAzLzIwMTggMDE6NTIgUE0sIEZlbmdodWEgWXUgd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDAyLCAyMDE4IGF0IDA3OjE2OjIzUE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4N
Cj4+DQo+PiBPbiAxMC8wMi8yMDE4IDAxOjQ2IFBNLCBGZW5naHVhIFl1IHdyb3RlOg0KPj4+IE9u
IFR1ZSwgT2N0IDAyLCAyMDE4IGF0IDA1OjQ0OjQ3UE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3Rl
Og0KPj4+PiBIaSBGZW5naHVhLA0KPj4+Pg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+Pj4+IEZyb206IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwuY29tPg0KPj4+Pj4g
U2VudDogVHVlc2RheSwgT2N0b2JlciAyLCAyMDE4IDEyOjA3IFBNDQo+Pj4+PiBPbiBNb24sIFNl
cCAyNCwgMjAxOCBhdCAwNzoxODo1NFBNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4+Pj4+
PiBUaGUgcHVibGljIHNwZWNpZmljYXRpb24gaXMgc3RpbGwgaW4gd29ya3MuIFdpbGwgYWRkIHRo
ZSBsaW5rIHdoZW4gaXQgaXMNCj4+Pj4+PiBhdmFpbGFibGUuDQo+Pj4+Pg0KPj4+Pj4gSXMgdGhp
cyB0aGUgcHVibGljIEFNRCBRb1Mgc3BlYz8NCj4+Pj4+IGh0dHBzOi8vc3VwcG9ydC5hbWQuY29t
L1RlY2hEb2NzLzU2Mzc1X1F1YWxpdHlfb2ZfU2VydmljZV9FeHRlbnNpb25zLg0KPj4+Pj4gcGRm
DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBZZXMuIFRoYXQgaXMgdGhlIG9uZS4gDQo+Pj4+IEkgd2FzIGdv
aW5nIHRvIHNlbmQgdGhlIGxpbmsgYWZ0ZXIgcmVmcmVzaGluZyB0aGUgcGF0Y2hlcyBvbiA0LTE5
LXJjNS4gIFlvdSBhbHJlYWR5IGdvdCBpdC4gUGxlYXNlIGxldCBrbm93IGlmIHlvdSBoYXZlIGFu
eSBmZWVkYmFjayBvbiB0aGUgcGF0Y2hlcy4gDQo+Pj4NCj4+PiBJIGRvbid0IHNlZSB0aGUgbmFt
ZSAnUkRUJyAoUmVzb3VyY2UgRGlyZWN0b3IgVGVjaG5vbG9neSkgaW4gdGhlDQo+Pj4gc3BlYyAi
QU1ENjQgVGVjaG5vbG9neSBQbGF0Zm9ybSBRdWFsaXR5IG9mIFNlcnZpY2UgRXh0ZW5zaW9ucyIu
DQo+Pj4gRG9lcyBBTUQgdXNlIHRoZSBzYW1lIG5hbWUgJ1JEVCcgYXMgSW50ZWw/DQo+Pg0KPj4g
Tm8uIEFNRCB1c2VzIHRoZSB3b3JkICJQbGF0Zm9ybSBRdWFsaXR5IG9mIFNlcnZpY2UiKG9yIGlu
IHNob3J0IFFvUykgdG8NCj4+IHJlZmVyIHRoaXMgZmVhdHVyZS4NCj4gDQo+IEhpLCBUaG9tYXMs
IEJhYnUsIGFuZCBKYW1lcywNCj4gDQo+IENhbiB3ZSB1c2UgInJlc2N0cmwiIHRvIHJlcGxhY2Ug
ImludGVsX3JkdCIgYW5kICJyZHQiIGluIGtlcm5lbD8gInJlc2N0cmwiDQo+IGlzIGEgbmV1dHJh
bCBuYW1lIGFuZCBoYXMgYmVlbiB1c2VkIGluIHVzZXIgaW50ZXJmYWNlIGFscmVhZHkuIEhvcGVm
dWxseQ0KPiAicmVzY3RybCIgY2FuIGJlIGFjY2VwdGFibGUgYnkgQVJNLCBBTUQsIGFuZCBJbnRl
bC4gV2Ugb25seSB1c2UgImludGVsX3JkdCIsDQo+ICJhbWRfcW9zIiwgb3IgImFybSBtcGFtIiBm
b3IgdmVuZG9yIHNwZWNpZmljIGNvZGUuDQoNClllcy4gcmVzY3RybCBzZWVtcyBsaWtlIGEgcmVh
c29uYWJsZSBuYW1lLiA+DQo+IENhbiB3ZSBtb3ZlIGFsbCBvZiBJbnRlbCBSRFQsIEFNRCBRb1Ms
IGFuZCBBUk0gTVBBTSBjb2RlIGludG8gYSBnZW5lcmljDQo+IHBsYWNlIGZzL3Jlc2N0cmwgd2hl
cmUgYm90aCBBUk0gYW5kIFg4NiBjb2RlIGNhbiBzdGF5Pw0KDQpMb29raW5nIGF0IHRoZSBKYW1l
cyBwYXRjaGVzLCBJIHRob3VnaHQgaGUgaXMgZ29pbmcgaW4gdGhlIHNhbWUob3INCnNpbWlsYXIp
IGRpcmVjdGlvbiBldmVudHVhbGx5Lg0KDQoNCj4gIA0KPiBUaGFua3MuDQo+IA0KPiAtRmVuZ2h1
YQ0KPiANCg==
