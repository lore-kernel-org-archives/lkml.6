Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N/eggYHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B82EE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeFFFgp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:36:45 -0400
Received: from mail-pu1apc01hn0203.outbound.protection.outlook.com ([104.47.126.203]:35776
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeFFFgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:36:44 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [RFC Patch 1/3] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHT++OW1TQj7xYFtUGQsOkMiGidAaRR5UWAgADTjAA=
Date: Wed, 6 Jun 2018 05:36:29 +0000
Message-ID: <46d5e9d3-9891-07b0-7af9-95f016dc7a10@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
 <20180604090749.489-2-Tianyu.Lan@microsoft.com>
 <SN6PR2101MB11204AF2E43FF4C91B326FFDDC660@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB11204AF2E43FF4C91B326FFDDC660@SN6PR2101MB1120.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0015;7:8aTG4qE2LUL5nFmLoa46i2Ec7r89cvMhmcz2xeTkK9DCOqZVOtgHI/LTyf7BywKMBHyMUgIGu9EKqwbbWeflbR5ny9oaCHEBUJq6qS+tLtmeKYKsuTStj6uj5CuYtApH5/UIyvgv3FvXT95vLH4zYSmFfjEr00bShi2fUueAhZIgWX7vtfPVySkq3wOWLjGNDncy+f/nZ8qt5kQY7XTGnYDFF/ll6xNwFG3W00c11FnsGVZUY+yPkhrGJdWe6XHO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SG2P15301MB0015;
x-ms-traffictypediagnostic: SG2P15301MB0015:
x-microsoft-antispam-prvs: <SG2P15301MB00153F7C7BA1968B65BCF93792650@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0015;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0015;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(6029001)(366004)(346002)(396003)(39380400002)(39860400002)(376002)(189003)(13464003)(199004)(486006)(7416002)(3660700001)(446003)(3280700002)(11346002)(10290500003)(2616005)(8676002)(81166006)(66066001)(81156014)(99286004)(22452003)(2906002)(36756003)(5660300001)(316002)(3846002)(6116002)(1511001)(72206003)(478600001)(476003)(97736004)(6512007)(105586002)(25786009)(575784001)(86362001)(6436002)(31686004)(7736002)(5250100002)(86612001)(106356001)(10090500001)(54906003)(6246003)(76176011)(26005)(305945005)(229853002)(59450400001)(53546011)(102836004)(14454004)(53936002)(6506007)(85306007)(110136005)(2900100001)(4326008)(68736007)(6486002)(8936002)(31696002)(22906009)(49343001)(213903007);DIR:OUT;SFP:1501;SCL:5;SRVR:SG2P15301MB0015;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iEneVDRiOIUWoa4t4J0JSxQIxwxisH3TK7zo+2KJ/HFIgJYgQD31JgRTcdc+MwDcnqEbO173Cj2m4ErbP5WQASSSSiq4OKTBH7WnlVDCrEJ4KGWWM3RzaZMkUhxgQoMPvC0Mj6Hb6J8Cqzgx39Fvkd69SMP4tO+GczsEvywbGRnxk0eAa5OSydF356I2VRr1liaPGuI5F7ZGyVs+P25Tvv5IW8DIvSmkv8Vpv6+/YmfpDWxn2bn8jy46bliV5jDg32GyJZ+g2KlQXXHB9pP1ilRyRjYQPQXY2g0nxcGgqP9hIJtsLAPzErSSabhy3Sb221mrgI4ZdGevHa3Zn5FhBXiy6xK7nWV3goV9mzsVSKJqY76n0vrqDEcpLkoI5+KjamYmNCXYF6QCNe/ZWwubM9WcrsDwsHSIT3W5Uy3rsJw=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1FA23BFF76F949ADD104D46266AB39@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 05b252b9-7638-4a7b-6807-08d5cb6f74da
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b252b9-7638-4a7b-6807-08d5cb6f74da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 05:36:29.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbDoNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiA2LzYvMjAxOCAxMjo1
OSBBTSwgTWljaGFlbCBLZWxsZXkgKEVPU0cpIHdyb3RlOg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+IEZyb206IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxp
bnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZg0KPj4gT2YgVGlhbnl1
IExhbg0KPj4gU2VudDogTW9uZGF5LCBKdW5lIDQsIDIwMTggMjowOCBBTQ0KPj4gQ2M6IFRpYW55
dSBMYW4gPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNy
b3NvZnQuY29tPjsgSGFpeWFuZw0KPj4gWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBT
dGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47DQo+PiB0Z2x4QGxpbnV0
cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGhwYUB6eXRvci5jb207IHg4NkBrZXJuZWwub3Jn
Ow0KPj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgcmtyY21hckByZWRoYXQuY29tOyBkZXZlbEBsaW51
eGRyaXZlcnByb2plY3Qub3JnOyBsaW51eC0NCj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt2
bUB2Z2VyLmtlcm5lbC5vcmc7IHZrdXpuZXRzQHJlZGhhdC5jb20NCj4+IFN1YmplY3Q6IFtSRkMg
UGF0Y2ggMS8zXSBYODYvSHlwZXItVjogQWRkIGZsdXNoIEh2Rmx1c2hHdWVzdFBoeXNpY2FsQWRk
cmVzc1NwYWNlIGh5cGVyY2FsbA0KPj4gc3VwcG9ydA0KPj4NCj4+IEh5cGVyLVYgcHJvdmlkZXMg
YSBwdiBoeXBlcmNhbGwgSHZGbHVzaEd1ZXN0UGh5c2ljYWxBZGRyZXNzU3BhY2UgdG8gZmx1c2gN
Cj4+IG5lc3RlZCBWTSBhZGRyZXNzIHNwYWNlIG1hcHBpbmcgaW4gbDEgaHlwZXJ2aXNvciBhbmQg
aXQncyB0byByZWR1Y2Ugb3ZlcmhlYWQNCj4+IG9mIGZsdXNoaW5nIGVwdCB0bGIgYW1vbmcgdmNw
dXMuIFRoaXMgcGF0Y2ggaXMgdG8gaW1wbGVtZW50IGl0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IExhbiBUaWFueXUgPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCj4+IC0tLQ0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2h5cGVydi9uZXN0ZWQuYyBiL2FyY2gveDg2L2h5cGVydi9uZXN0ZWQu
Yw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTdmN2My
ODhlY2NjDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvbmVzdGVk
LmMNCj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL2h5cGVy
di10bGZzLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5oPg0KPj4gKyNpbmNsdWRlIDxh
c20vdGxiZmx1c2guaD4NCj4+ICsNCj4+ICtpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmco
dTY0IGFzKQ0KPj4gK3sNCj4+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2ggKipmbHVz
aF9wY3B1Ow0KPj4gKwlzdHJ1Y3QgaHZfZ3Vlc3RfbWFwcGluZ19mbHVzaCAqZmx1c2g7DQo+PiAr
CXU2NCBzdGF0dXMgPSBVNjRfTUFYOw0KPiANCj4gSW5pdGlhbGl6aW5nIHN0YXR1cyB0byBVNjRf
TUFYIGRvZXNuJ3Qgc2VlbSBuZWNlc3NhcnkuDQo+IA0KPj4gKwl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPj4gKwlpbnQgcmV0ID0gLUVGQVVMVDsNCj4+ICsNCj4+ICsJaWYgKCFodl9oeXBlcmNhbGxf
cGcpDQo+PiArCQlnb3RvIGZhdWx0Ow0KPj4gKw0KPj4gKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7
DQo+PiArDQo+PiArCWZsdXNoX3BjcHUgPSAoc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2gg
KiopDQo+PiArCQl0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4+ICsNCj4+
ICsJZmx1c2ggPSAqZmx1c2hfcGNwdTsNCj4+ICsNCj4+ICsJaWYgKHVubGlrZWx5KCFmbHVzaCkp
IHsNCj4+ICsJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+ICsJCWdvdG8gZmF1bHQ7DQo+
PiArCX0NCj4+ICsNCj4+ICsJZmx1c2gtPmFkZHJlc3Nfc3BhY2UgPSBhczsNCj4+ICsJZmx1c2gt
PmZsYWdzID0gMDsNCj4+ICsNCj4+ICsJc3RhdHVzID0gaHZfZG9faHlwZXJjYWxsKEhWQ0FMTF9G
TFVTSF9HVUVTVF9QSFlTSUNBTF9BRERSRVNTX1NQQUNFLA0KPj4gKwkJCQkgZmx1c2gsIE5VTEwp
Ow0KPj4gKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+PiArDQo+PiArCWlmICghKHN0YXR1
cyAmIEhWX0hZUEVSQ0FMTF9SRVNVTFRfTUFTSykpDQo+PiArCQlyZXQgPSAwOw0KPj4gKw0KPj4g
K2ZhdWx0Og0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTCho
eXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyk7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vaHlwZXJ2LXRsZnMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZz
LmgNCj4+IGluZGV4IGI4Yzg5MjY1YmFmMC4uNTNiYmViMDhmYWVhIDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0KPj4gQEAgLTMwOSw2ICszMDksNyBAQCBzdHJ1Y3QgbXNf
aHlwZXJ2X3RzY19wYWdlIHsNCj4+ICAgI2RlZmluZSBIVl9YNjRfTVNSX1JFRU5MSUdIVEVOTUVO
VF9DT05UUk9MCTB4NDAwMDAxMDYNCj4+DQo+PiAgIC8qIE5lc3RlZCBmZWF0dXJlcyAoQ1BVSUQg
MHg0MDAwMDAwQSkgRUFYICovDQo+PiArI2RlZmluZSBIVl9YNjRfTkVTVEVEX0dVU0VUX01BUFBJ
TkdfRkxVU0gJQklUKDE4KQ0KPiANCj4gVGhlICNkZWZpbmUgbmFtZSBpcyBtaXNzcGVsbGVkLiAg
Il9HVVNFVF8iIHNob3VsZCBiZSAiX0dVRVNUXyIuDQo+IEFuZCB0aGUgbWF0Y2hpbmcgdXNhZ2Ug
aW4gcGF0Y2ggMy8zIHdpbGwgbmVlZCB0byBiZSB1cGRhdGVkIGFzIHdlbGwuDQo+IA0KPiBNaWNo
YWVsDQo+IA0KDQpOaWNlIGNhdGNoISBXaWxsIHVwZGF0ZS4NCg==
