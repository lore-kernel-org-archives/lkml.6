Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB02C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2321741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cms8nkI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeL0GjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:39:21 -0500
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:57010
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbeL0GjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5VciiXVH5QHyXmqnJRs56EzJRqmOdzyBXmN6itc3E0=;
 b=Cms8nkI7va4NPRoUpMdkHtkB2DsFOAGR0Ee9Wn1s9Il2wIVZXClt96TUEupL5mlcY/W92cuRzUH5WQ0xFwgsFqI9w2uvacDCpfOcwBmsc8t4gxXe72Unvv1K6CN7kLYTlpM3Cu7GZHs2/ClZYHf5ysnB+AAjmipTjAZX97Nyszg=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0184.eurprd08.prod.outlook.com (10.161.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 27 Dec 2018 06:39:14 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 06:39:14 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v3 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUmRPTBdPt1uc570uDsKJLIqlNSA==
Date:   Thu, 27 Dec 2018 06:39:14 +0000
Message-ID: <20181227063900.GB26908@james-ThinkStation-P300>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-3-james.qian.wang@arm.com>
 <20181224120049.GD22341@e110455-lin.cambridge.arm.com>
In-Reply-To: <20181224120049.GD22341@e110455-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0174.ausprd01.prod.outlook.com
 (2603:10c6:10:52::18) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0184;6:O05gyInmdJ15+EoIR+UQQut6N1vGRvE4FwZK4qMjuFJiLBU5CHZda/OMkdZ62oe91JndJyqpULdAyvmDb54oVYO1E7xHDcr4nt6zeeGHhV/Ur5ZVRRSBQEJoj7cutPqR7nh2Kv+EkluwhPB6kl3x2fskAWflgbZpm2VOG3FkcfuJBW7stH+1VQcRF6M9jIRZP+b9fJnTSOXhZ+cTiMjfrINgsEHIAqMenhNaXic9g/iBRKL2VVJy/r0A/PDS/kpQD6+wE9teC9eguBGHT8SQlZgKwgFnrR+HluXkSftc943qPNeS9UAMNN38naHNgV/AaV3DXcn20I4+h5vQjcjAgoeTRxta244qBgB14GG+mPNWwb7oSQB6rdOc3h0vTmpBzJzNowffYa6vXFMcwjmjBdqkfjbchLOxKL8Lf4Ak/NwCEez+LcOYGfvH1hGpKp7W06kk1B7Qu/WaOSaHN7L7JA==;5:Gy2psX1cYN6XiWfRNZWXYceM7Y4i6o3o625pAVae9SYxCooyQYd+jNZTNKZ1MsCcUDQwc+/s8H1y05BQ9J/Mm4f6Ng6S6M2hMbygFk8SqjzNXoY8cBesD9tWujn80FhpkqUfsvIB4DH4Z8BFPtSJb1DQq+0utZ94iNKXyYHnoMw=;7:v1IY5ui+oiKiZTl11VshAsC5wfpHOwh4mWsRNQTGsHTNCriJ7I3d6mEov5jn9EwkQz7e1YMBYn8NAplh2fIMW3ffl0BhzquDmKMn/+rQza63ue9rWL1dQm+Im8YNfjj2dIHOOX4wvMXBWl6WuMoQCQ==
x-ms-office365-filtering-correlation-id: 78fc824b-bb8f-40ee-cf2e-08d66bc6047b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0184;
x-ms-traffictypediagnostic: AM3PR08MB0184:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0184D6C6D3D75BE87EB454F0B3B60@AM3PR08MB0184.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0184;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0184;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(52314003)(199004)(189003)(5660300001)(25786009)(106356001)(76176011)(68736007)(7736002)(33656002)(8676002)(81156014)(81166006)(55236004)(102836004)(99286004)(71190400001)(386003)(6506007)(58126008)(26005)(316002)(54906003)(52116002)(7416002)(8936002)(71200400001)(105586002)(33896004)(66066001)(97736004)(186003)(14454004)(6246003)(6436002)(476003)(486006)(6512007)(3846002)(11346002)(446003)(6862004)(86362001)(6636002)(1076003)(53936002)(229853002)(33716001)(305945005)(6116002)(9686003)(6486002)(478600001)(2906002)(256004)(4326008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0184;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8wW1FHNfBIGpI9vhvJRpEPJDz39tpVWviDxs1lLRqErBA3fA6AMBz9734869zzxjuor3vt8s+GqOsiWgYzE56D2c2yPX/q3aLPKX9tHaz3xEuCVK0rxxE8ZBZZYU22ePEiZAWMLA7Q49gB8dUtDNkaZJklhUEX278s7+oxMSgw+HmPUF+pddaFWyOPsjdZv47vwVTT9NVUXj4rTtMhd4cfkDcpDUT2SRgjdm9FKFM0v9uDDVT4di3kARSl1awxPH1NVbCN27WL1RBvPnfgvYbT4Pp/dcnwS68tKWQEjowxbpNVran5wbpHHcFjrEm3d/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6BAA680A006BF44A6774F4F5D9E325B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fc824b-bb8f-40ee-cf2e-08d66bc6047b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 06:39:14.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBEZWMgMjQsIDIwMTggYXQgMDg6MDA6NTFQTSArMDgwMCwgTGl2aXUgRHVkYXUgd3Jv
dGU6DQo+IE9uIEZyaSwgRGVjIDIxLCAyMDE4IGF0IDA5OjU5OjEyQU0gKzAwMDAsIGphbWVzIHFp
YW4gd2FuZyAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIHdyb3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5n
cyBkb2N1bWVudGF0aW9uIGZvciB0aGUgQVJNIGRpc3BsYXkgcHJvY2Vzc29yIEQ3MSBhbmQgbGF0
ZXINCj4gPiBJUHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtZXMgKFFpYW4pIFdhbmcg
PGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4g
LSBEZWxldGVkIHVubmVjZXNzYXJ5IHByb3BlcnR5OiBpbnRlcnJ1cHQtbmFtZXMuDQo+ID4gLSBE
cm9wcGVkICdwb3J0cycgYW5kIG1vdmluZyAncG9ydCcgdXAgYSBsZXZlbC4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvYXJtL2FybSxrb21lZGEudHh0ICAgICAgIHwgNzkgKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvYXJtL2FybSxrb21lZGEudHh0DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2FybS9hcm0sa29tZWRhLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2FybS9hcm0sa29tZWRh
LnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5i
NGU0NTAyNDNjN2QNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYXJtL2FybSxrb21lZGEudHh0DQo+ID4gQEAgLTAs
MCArMSw3OSBAQA0KPiA+ICtEZXZpY2UgVHJlZSBiaW5kaW5ncyBmb3IgQVJNIEtvbWVkYSBkaXNw
bGF5IGRyaXZlcg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21w
YXRpYmxlOiBTaG91bGQgYmUgImFybSxtYWxpLWQ3MSINCj4gPiArLSByZWc6IFBoeXNpY2FsIGJh
c2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlcnMgaW4gdGhlIHN5c3RlbQ0KPiA+
ICstIGludGVycnVwdHM6IHRoZSBpbnRlcnJ1cHQgbGluZSBudW1iZXIgb2YgdGhlIGRldmljZSBp
biB0aGUgc3lzdGVtDQo+ID4gKy0gY2xvY2tzOiBBIGxpc3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNw
ZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoIGVudHJ5DQo+ID4gKyAgICBpbiAnY2xvY2stbmFt
ZXMnDQo+ID4gKy0gY2xvY2stbmFtZXM6IEEgbGlzdCBvZiBjbG9jayBuYW1lcy4gSXQgc2hvdWxk
IGNvbnRhaW46DQo+ID4gKyAgICAgIC0gIm1jbGsiOiBmb3IgdGhlIG1haW4gcHJvY2Vzc29yIGNs
b2NrDQo+ID4gKyAgICAgIC0gInBjbGsiOiBmb3IgdGhlIEFQQiBpbnRlcmZhY2UgY2xvY2sNCj4g
PiArLSAjYWRkcmVzcy1jZWxsczogTXVzdCBiZSAxDQo+ID4gKy0gI3NpemUtY2VsbHM6IE11c3Qg
YmUgMA0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllcyBmb3Igc3ViLW5vZGU6IHBpcGVs
aW5lQG5xDQo+ID4gK0VhY2ggZGV2aWNlIGNvbnRhaW5zIG9uZSBvciB0d28gcGlwZWxpbmUgc3Vi
LW5vZGVzIChhdCBsZWFzdCBvbmUpLCBlYWNoDQo+ID4gK3BpcGVsaW5lIG5vZGUgc2hvdWxkIHBy
b3ZpZGUgcHJvcGVydGllczoNCj4gPiArLSByZWc6IFplcm8taW5kZXhlZCBpZGVudGlmaWVyIGZv
ciB0aGUgcGlwZWxpbmUNCj4gPiArLSBjbG9ja3M6IEEgbGlzdCBvZiBwaGFuZGxlICsgY2xvY2st
c3BlY2lmaWVyIHBhaXJzLCBvbmUgZm9yIGVhY2ggZW50cnkNCj4gPiArICAgIGluICdjbG9jay1u
YW1lcycNCj4gPiArLSBjbG9jay1uYW1lczogc2hvdWxkIGNvbnRhaW46DQo+ID4gKyAgICAgIC0g
InB4Y2xrIjogcGl4ZWwgY2xvY2sNCj4gPiArICAgICAgLSAiYWNsayI6IEFYSSBpbnRlcmZhY2Ug
Y2xvY2sNCj4gPiArDQo+ID4gKy0gcG9ydDogZWFjaCBwaXBlbGluZSBjb25uZWN0IHRvIGFuIGVu
Y29kZXIgaW5wdXQgcG9ydC4gVGhlIGNvbm5lY3Rpb24gaXMNCj4gPiArICAgIG1vZGVsZWQgdXNp
bmcgdGhlIE9GIGdyYXBoIGJpbmRpbmdzIHNwZWNpZmllZCBpbg0KPiA+ICsgICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dyYXBoLnR4dA0KPiA+ICsNCj4gPiArT3B0aW9uYWwg
cHJvcGVydGllczoNCj4gPiArICAtIG1lbW9yeS1yZWdpb246IHBoYW5kbGUgdG8gYSBub2RlIGRl
c2NyaWJpbmcgbWVtb3J5IChzZWUNCj4gPiArICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvcmVzZXJ2ZWQtbWVtb3J5LnR4dCkNCj4gPiArICAgIHRv
IGJlIHVzZWQgZm9yIHRoZSBmcmFtZWJ1ZmZlcjsgaWYgbm90IHByZXNlbnQsIHRoZSBmcmFtZWJ1
ZmZlciBtYXkNCj4gPiArICAgIGJlIGxvY2F0ZWQgYW55d2hlcmUgaW4gbWVtb3J5Lg0KPiA+ICsN
Cj4gPiArRXhhbXBsZToNCj4gPiArLyB7DQo+ID4gKwkuLi4NCj4gPiArDQo+ID4gKwlkcDA6IGRp
c3BsYXlAYzAwMDAwIHsNCj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCj4gPiArCQljb21wYXRpYmxlID0gImFybSxtYWxpLWQ3MSI7DQo+ID4g
KwkJcmVnID0gPDB4YzAwMDAwIDB4MjAwMDA+Ow0KPiA+ICsJCWludGVycnVwdHMgPSA8MCAxNjgg
ND47DQo+ID4gKwkJY2xvY2tzID0gPCZkcHVfbWNsaz4sIDwmZHB1X2FjbGs+Ow0KPiA+ICsJCWNs
b2NrLW5hbWVzID0gIm1jbGsiLCAicGNsayI7DQo+ID4gKw0KPiA+ICsJCWRwMF9waXBlMDogcGlw
ZWxpbmVAMCB7DQo+ID4gKwkJCWNsb2NrcyA9IDwmZnBnYW9zYzI+LCA8JmRwdV9hY2xrPjsNCj4g
PiArCQkJY2xvY2stbmFtZXMgPSAicHhjbGsiLCAiYWNsayI7DQo+ID4gKwkJCXJlZyA9IDwwPjsN
Cj4gPiArDQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQkjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4gDQo+IFRoZXNlIGFyZSB1bmRvY3VtZW50ZWQgYW5kIG5vdCBuZWNlc3Nhcnkg
YW55d2F5LCBhcyB0aGUgcGlwZWxpbmVzIHdpbGwNCj4gaW5oZXJpdCBkaXNwbGF5J3MgYXR0cmli
dXRlcy4NCg0KdGhhbmsgeW91LCB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+
ID4gKw0KPiA+ICsJCQlwb3J0QDAgew0KPiA+ICsJCQkJZHAwX3BpcGUwX291dDogZW5kcG9pbnQg
ew0KPiA+ICsJCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmZGJfZHZpMF9pbj47DQo+ID4gKwkJCQl9
Ow0KPiA+ICsJCQl9Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCWRwMF9waXBlMTogcGlwZWxp
bmVAMSB7DQo+ID4gKwkJCWNsb2NrcyA9IDwmZnBnYW9zYzI+LCA8JmRwdV9hY2xrPjsNCj4gPiAr
CQkJY2xvY2stbmFtZXMgPSAicHhjbGsiLCAiYWNsayI7DQo+ID4gKwkJCXJlZyA9IDwxPjsNCj4g
PiArDQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQkjc2l6ZS1jZWxscyA9
IDwwPjsNCj4gDQo+IHNhbWUgaGVyZS4NCg0KT0suDQoNCj4gDQo+ID4gKw0KPiA+ICsJCQlwb3J0
QDAgew0KPiA+ICsJCQkJZHAwX3BpcGUxX291dDogZW5kcG9pbnQgew0KPiA+ICsJCQkJCXJlbW90
ZS1lbmRwb2ludCA9IDwmZGJfZHZpMV9pbj47DQo+ID4gKwkJCQl9Ow0KPiA+ICsJCQl9Ow0KPiA+
ICsJCX07DQo+ID4gKwl9Ow0KPiA+ICsJLi4uDQo+ID4gK307DQo+ID4gLS0gDQo+ID4gMi4xNy4x
DQo+ID4gDQo+IA0KPiBXaXRoIHRoZXNlIGNoYW5nZXM6DQo+IA0KPiBSZXZpZXdlZC1ieTogTGl2
aXUgRHVkYXUgPGxpdml1LmR1ZGF1QGFybS5jb20+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IExp
dml1DQo+IA0KPiANCj4gLS0gDQo+ID09PT09PT09PT09PT09PT09PT09DQo+IHwgSSB3b3VsZCBs
aWtlIHRvIHwNCj4gfCBmaXggdGhlIHdvcmxkLCAgfA0KPiB8IGJ1dCB0aGV5J3JlIG5vdCB8DQo+
IHwgZ2l2aW5nIG1lIHRoZSAgIHwNCj4gIFwgc291cmNlIGNvZGUhICAvDQo+ICAgLS0tLS0tLS0t
LS0tLS0tDQo+ICAgICDCr1xfKOODhClfL8KvDQo=
