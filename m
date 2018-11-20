Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3EC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B795220C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cQ2cDPIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B795220C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeKTU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:59:48 -0500
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:39488
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbeKTU7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llil1x22VV55W4AIcbu/SNTxkGxENzp8eBTNjtapXaM=;
 b=cQ2cDPIw2lSI4xJO58PR0kZKFqofrIpGCsM6w2b2CcySfjV7IGtqsQ+rbDfdoNbZ4kpgTq0IJDGF3hcS2PwtohCHvSR2eMXrlJl8QCZwV8R+c8XLniINxzVznVHAWogb7A22aVlTTO5BuURfkN08VW8lv2J/aPbyPF5mSwA9pIU=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1753.jpnprd01.prod.outlook.com (52.133.163.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 10:30:58 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Tue, 20 Nov 2018
 10:30:58 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Topic: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Thread-Index: AQHUe1IdnqpGsbqZdUmUDVBl2HljTKVUDjSAgALLZWCAANOUgIAA03AA
Date:   Tue, 20 Nov 2018 10:30:58 +0000
Message-ID: <TY1PR01MB1769AD7F2D11DB06E1B0CC0DF5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
 <20181113130910.22130-2-phil.edworthy@renesas.com>
 <20181117143253.GA27381@bogus>
 <TY1PR01MB176917D755CB102AB5FD6BEAF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAL_JsqJca7mXS_9msTbCovnXpFxC0VY81COk98x-c1Ug5a=jQQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJca7mXS_9msTbCovnXpFxC0VY81COk98x-c1Ug5a=jQQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1753;20:3l4nK/E9UWNaYN5zjMqnhQ3MDh3LN/oU4LyGH/sRVaX006+sAzLDNrvZ5qYLLjOAXLwL6lFAzJbNycPRQ+x5W7HTwezhD/8kojo0kJ859f8ZTySQKyuNAEswgB6x0TB9JqebmopcYyWHniJvjmuWF4L1JEMXurAdGqtn+IZGEgE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 775c4424-9399-4927-a3e7-08d64ed342fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1753;
x-ms-traffictypediagnostic: TY1PR01MB1753:
x-microsoft-antispam-prvs: <TY1PR01MB1753C1AB9509286AEA8619EAF5D90@TY1PR01MB1753.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1753;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1753;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(51914003)(99286004)(8936002)(6436002)(9686003)(68736007)(81166006)(81156014)(44832011)(33656002)(102836004)(8676002)(54906003)(6246003)(316002)(55016002)(105586002)(53936002)(2900100001)(106356001)(7696005)(486006)(76176011)(74316002)(478600001)(53546011)(25786009)(7736002)(305945005)(66066001)(4326008)(229853002)(3846002)(6506007)(6916009)(11346002)(2906002)(446003)(476003)(71190400001)(86362001)(6116002)(186003)(5660300001)(71200400001)(14454004)(26005)(93886005)(97736004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1753;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uCt4ON2beyp0SDpbg0bQwcGrqjlb/V5pKN+dPx7mboR29Giqou6vJdMKG7OszRwtRyc3xawn6SUNZT0sWs9DFsEUs05r+omwayITpfgd2jGNLHgdFHt40KNUyuLiBojOst9O5x0UrhjhK/+EusPKdkiyHcOTs1EZhLC9ny4n/tzGfxgUds9Sr3MqWMYgut6cggDhMjjt8Qk97KIWQQCU/5Yr2p9JqsH4zrnJCnh40AAYxJRqTxHJx0D2Ix1OY6uezJOE+J118zhualCofEZeU+C2yJCI+oTYpbOdD4Kl4k6Hrjj7CyOlqTpC904FU/jxdoRLdVO905lCVyjgYnNEJteZKn28wEtO+NrKEnudk8s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c4424-9399-4927-a3e7-08d64ed342fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:30:58.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAxOSBOb3ZlbWJlciAyMDE4IDIxOjUxLCBSb2IgSGVycmluZyB3cm90ZToN
Cj4gT24gTW9uLCBOb3YgMTksIDIwMTggYXQgMzozOSBBTSBQaGlsIEVkd29ydGh5DQo+IDxwaGls
LmVkd29ydGh5QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFJvYiwNCj4gPg0KPiA+
IE9uIDE3IE5vdmVtYmVyIDIwMTggMTQ6MzMgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIE5vdiAxMywgMjAxOCBhdCAwMTowOTowOVBNICswMDAwLCBQaGlsIEVkd29ydGh5IHdyb3Rl
Og0KPiA+ID4gPiBBZGQgZGV2aWNlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIFJlbmVz
YXMgUlovTjEgR1BJTw0KPiA+ID4gPiBpbnRlcnJ1cHQgbXVsdGlwbGV4ZXIuDQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNh
cy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiB2MzoNCj4gPiA+ID4gIC0gVXNlICdpbnRlcnJ1
cHQtbWFwJyBEVCBwcm9wZXJ0eSBjb3JyZWN0bHkuDQo+ID4gPiA+IHYyOg0KPiA+ID4gPiAgLSBV
c2UgaW50ZXJydXB0LW1hcCB0byBhbGxvdyB0aGUgR1BJTyBjb250cm9sbGVyIGluZm8gdG8gYmUg
c3BlY2lmaWVkDQo+ID4gPiA+ICAgIGFzIHBhcnQgb2YgdGhlIGlycS4NCj4gPiA+ID4gIC0gRG9u
J3Qgc2hvdyBzdGF0dXMgaW4gYmluZGluZyBleGFtcGxlcy4NCj4gPiA+ID4gIC0gRG9uJ3Qgc2hv
dyB0aGUgc29jL2JvYXJkIHNwbGl0IGluIGJpbmRpbmcgZG9jLg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIC4uLi9pbnRlcnJ1cHQtY29udHJvbGxlci9yZW5lc2FzLHJ6bjEtbXV4LnR4dCB8IDczDQo+
ID4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MyBp
bnNlcnRpb25zKCspDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3JlbmVzYXMs
cnpuDQo+ID4gPiA+IDEtbXUNCj4gPiA+ID4geC50eHQNCj4gPiA+DQo+ID4gPiBBIGZldyBuaXRz
LCBvdGhlcndpc2U6DQo+ID4gPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvcmVuZXNhcyxyDQo+ID4gPiA+IHpuMS0NCj4gPiA+
ID4gbXV4LnR4dA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9yZW5lc2FzLHINCj4gPiA+ID4gem4xLQ0KPiA+ID4gPiBtdXgu
dHh0DQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNjUxNTg4MGUyNWNjDQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL3Jl
bmVzDQo+ID4gPiA+ICsrKyBhcyxyDQo+ID4gPiA+ICsrKyB6bjEtbXV4LnR4dA0KPiA+ID4gPiBA
QCAtMCwwICsxLDczIEBADQo+ID4gPiA+ICsqIFJlbmVzYXMgUlovTjEgR1BJTyBJbnRlcnJ1cHQg
TXVsdGlwbGV4ZXINCj4gPiA+ID4gKw0KPiA+ID4gPiArT24gUmVuZXNhcyBSWi9OMSBkZXZpY2Vz
LCB0aGVyZSBhcmUgc2V2ZXJhbCBHUElPIENvbnRyb2xsZXJzIGVhY2gNCj4gPiA+ID4gK3dpdGgg
YSBudW1iZXIgb2YgaW50ZXJydXB0IG91dHB1dHMuIEFsbCBvZiB0aGUgaW50ZXJydXB0cyBmcm9t
DQo+ID4gPiA+ICt0aGUgR1BJTyBDb250cm9sbGVycyBhcmUgcGFzc2VkIHRvIHRoZSBHUElPIElu
dGVycnVwdA0KPiA+ID4gPiArTXVsdGlwbGV4ZXIsIHdoaWNoIHNlbGVjdHMgYSBzdWItc2V0IG9m
IHRoZSBpbnRlcnJ1cHRzIHRvIHBhc3MNCj4gPiA+ID4gK29udG8gdGhlIHN5c3RlbSBpbnRlcnJ1
cHQNCj4gPiA+IGNvbnRyb2xsZXIuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK0Egc2luZ2xlIG5vZGUg
aW4gdGhlIGRldmljZSB0cmVlIGlzIHVzZWQgdG8gZGVzY3JpYmUgdGhlIEdQSU8gSVJRDQo+IE11
eGVyLg0KPiA+ID4gPiArDQo+ID4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAr
LSBjb21wYXRpYmxlOiBTb0Mtc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcNCj4gPiA+ID4gKyJy
ZW5lc2FzLDxzb2Mtc3BlY2lmaWM+LQ0KPiA+ID4gZ3Bpb2lycW11eCINCj4gPiA+ID4gKyAgZm9s
bG93ZWQgYnkgInJlbmVzYXMscnpuMS1ncGlvaXJxbXV4IiBhcyBmYWxsYmFjay4gVGhlDQo+ID4g
PiA+ICtTb0Mtc3BlY2lmaWMgY29tcGF0aWJsZQ0KPiA+ID4gPiArICBzdHJpbmdzIG11c3QgYmUg
b25lIG9mOg0KPiA+ID4gPiArICAgInJlbmVzYXMscjlhMDZnMDMyLWdwaW9pcnFtdXgiIGZvciBS
Wi9OMUQNCj4gPiA+ID4gKyAgICJyZW5lc2FzLHI5YTA2ZzAzMy1ncGlvaXJxbXV4IiBmb3IgUlov
TjFTDQo+ID4gPiA+ICstIHJlZzogQmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIEdQSU8gSVJRIE11
eGVyIHJlZ2lzdGVycy4NCj4gPiA+ID4gKy0gaW50ZXJydXB0czogTGlzdCBvZiBvdXRwdXQgaW50
ZXJydXB0cy4NCj4gPiA+ID4gKy0gI2ludGVycnVwdC1jZWxsczogTnVtZGVyIG9mIGNlbGxzIGlu
IHRoZSBpbnB1dCBpbnRlcnJ1cHQNCj4gPiA+ID4gK3NwZWNpZmllciwgbXVzdCBiZQ0KPiA+ID4g
MS4NCj4gPiA+ID4gKy0gI2FkZHJlc3MtY2VsbHM6IE11c3QgYmUgMC4NCj4gPiA+ID4gKy0gaW50
ZXJydXB0LW1hcC1tYXNrOiBtdXN0IGJlIDEyNy4NCj4gPiA+ID4gKy0gaW50ZXJydXB0LW1hcDog
U3RhbmRhcmQgcHJvcGVydHkgZGV0YWlsaW5nIHRoZSBtYXBzIGJldHdlZW4NCj4gPiA+ID4gK2lu
cHV0IGlycXMgYW5kIHRoZQ0KPiA+ID4gPiArICBjb3JyZXNwb25kaW5nIG91dHB1dCBpcnEuIFRo
aXMgY29uc2lzdCBvZiBhIGxpc3Qgb2Y6DQo+ID4gPiA+ICsgICA8aW5wdXQtaXJxLXNwZWMgcGhh
bmRsZS10by1pbnRlcnJ1cHQtY29udHJvbGxlcg0KPiA+ID4gPiArb3V0cHV0LWlycS1zcGVjPg0K
PiA+ID4gPiArICBUaGUgaW5wdXQtaXJxLXNwZWMgaXMgZnJvbSAwIHRvIDk1LCBjb3JyZXNwb25k
aW5nIHRvIHRoZQ0KPiA+ID4gPiArb3V0cHV0cyBvZiB0aGUgR1BJTw0KPiA+ID4gPiArICBDb250
cm9sbGVycy4NCj4gPiA+ID4gKw0KPiA+ID4gPiArRXhhbXBsZToNCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgVGhlIGZvbGxvd2luZyBpcyBhbiBleGFtcGxlIGZvciB0aGUgUlovTjFEIFNvQy4NCj4g
PiA+ID4gKw0KPiA+ID4gPiArICAgZ3Bpb2lycW11eDogZ3Bpb2lycW11eEA1MTAwMDQ4MCB7DQo+
ID4gPg0KPiA+ID4gaW50ZXJydXB0LWNvbnRyb2xsZXJALi4uDQo+ID4gU3VyZQ0KPiA+DQo+ID4g
PiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEwNmcwMzItZ3Bpb2lycW11
eCIsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAicmVuZXNhcyxyem4xLWdw
aW9pcnFtdXgiOw0KPiA+ID4gPiArICAgICAgICAgICByZWcgPSA8MHg1MTAwMDQ4MCAweDIwPjsN
Cj4gPiA+ID4gKyAgICAgICAgICAgaW50ZXJydXB0cyA9DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgPEdJQ19TUEkgMTAzIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgIDxHSUNfU1BJIDEwNCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiA+DQo+
ID4gPiBUaGlzIGlzIGEgYml0IHJlZHVuZGFudCBhcyB0aGUgc2FtZSBpbmZvcm1hdGlvbiBpcyBp
biBpbnRlcnJ1cHQtbWFwLA0KPiA+ID4gYnV0IEkgZ3Vlc3MgeW91IG5lZWQgaXQgdG8gZ2V0IHRo
ZSBpcnEgcmVzb3VyY2VzLg0KPiA+IFRoYXQncyByaWdodC4NCj4gPg0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4gPiA+ICsgICAgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KPiA+ID4gPiArICAgICAgICAgICBpbnRlcnJ1cHQt
bWFwLW1hc2sgPSA8MTI3PjsNCj4gPiA+DQo+ID4gPiBVc2UgaGV4IGZvciBtYXNrcy4NCj4gPiBP
ay4NCj4gPg0KPiA+ID4gPiArICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0NCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAvKiBncGlvMmEgMjQsIHBpbiAxNDY6IEVUSCBQb3J0IDEgSVJRICov
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgPDg4ICZnaWMgR0lDX1NQSSAxMDMgSVJRX1RZ
UEVfTEVWRUxfSElHSD4sDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgLyogZ3BpbzJhIDI2
LCBwaW4gMTQ4OiBUb3VjaFNDUk5fSVJRICovDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
PDkwICZnaWMgR0lDX1NQSSAxMDQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gPiA+ICsgICB9
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICBncGlvMjogZ3Bpb0A1MDAwZDAwMCB7DQo+ID4gPiA+
ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItZ3BpbyI7DQo+ID4gPiA+ICsg
ICAgICAgICAgIHJlZyA9IDwweDUwMDBkMDAwIDB4ODA+Ow0KPiA+ID4gPiArICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiA+ID4gKyAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MD47DQo+ID4gPiA+ICsgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImJ1cyI7DQo+ID4gPiA+ICsg
ICAgICAgICAgIGNsb2NrcyA9IDwmc3lzY3RybCBSOUEwNkcwMzJfSENMS19HUElPMj47DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgZ3BpbzJhOiBncGlvLWNvbnRyb2xsZXJAMCB7DQo+
ID4gPg0KPiA+ID4gZ3Bpb0AwDQo+ID4gQXJlIHlvdSBzdXJlIGFib3V0IHRoaXM/DQo+IA0KPiBZ
ZXMsICdncGlvJyBpcyB3aGF0IHRoZSBEVCBzcGVjIHNheXMuIEl0IGlzIHRoZSBvZGRiYWxsIHRo
b3VnaCBhbmQgSSBhbHdheXMgaGF2ZQ0KPiB0byB0aGluayBhYm91dCBpdC4NCk9LLCBnb3QgaXQu
DQoNCj4gPiBUaGUgYmluZGluZ3MgaW4NCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZ3Bpby9zbnBzLWR3YXBiLWdwaW8udHh0DQo+ID4gc2hvdyBhbiBleGFtcGxlIHdoZXJl
IHRoZSBzdWItbm9kZXMgZm9yIGdwaW8gYmFua3MgYXJlIGdwaW8tDQo+IGNvbnRyb2xsZXJALg0K
PiA+IFRoaXMgaXMgYWxzbyBpbiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bp
by9ncGlvLnR4dC4NCj4gDQo+IEluZGVlZC4gVGhvc2Ugc2hvdWxkIGJlIGZpeGVkLiBJIHdvdWxk
IGJlIGVhc2lseSBwZXJzdWFkZWQgdG8ganVzdCBjaGFuZ2UNCj4gdGhlIHNwZWMsIGJ1dCAnZ3Bp
b0AnIGlzIG11Y2ggbW9yZSB3aWRlbHkgdXNlZDoNCj4gDQo+ICQgZ2l0IGdyZXAgZ3Bpb0AgLS0g
YXJjaC8gfCB3Yw0KPiAgICAxMTEwICAgIDQzNzggICA2Nzc2Ng0KPiAkIGdpdCBncmVwIGdwaW8t
Y29udHJvbGxlckAgLS0gYXJjaC8gfCB3Yw0KPiAgICAgIDYwICAgICAyMzIgICAgNDI3MA0KPiAN
ClllcywgaW5kZWVkLg0KDQpUaGFua3MNClBoaWwNCg==
