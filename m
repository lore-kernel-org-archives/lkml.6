Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9160DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y1scfjXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BA320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIJJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:42:00 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:20400
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeIJJmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr9JorHl8VmO6e6pc5u331IH1/xJMw8xObopQwcmA4U=;
 b=Y1scfjXTyK2jWicsdtE47XlWgerZ/JPhQJAiuYtOvuFeoOs2wsU4wmnQd7uJwQMCS7CThD/pyIv7QjYG4zlL8Mp5fnapeyBYRgfGMnbwO6Fn6KGmB++ssbXvMVY6rbDLzedXcnhWGEvXYBmWDXJL3WYZ0xb5zQeyGcoumbWBjYo=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4392.namprd02.prod.outlook.com (52.135.237.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 04:49:50 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e%4]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 04:49:50 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
Thread-Topic: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for
 Xilinx zynqmp reset controller.
Thread-Index: AQHUROdpnRxEXgNu/0+PknW1P/5qmqThfPeAgAd77DA=
Date:   Mon, 10 Sep 2018 04:49:50 +0000
Message-ID: <BYAPR02MB47101009A8B5F7E1BB20C7A2C2050@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
 <1536143395.4084.5.camel@pengutronix.de>
In-Reply-To: <1536143395.4084.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4392;6:GHxrooJe2mC2h6GqhIVPymFgk6NVaOQV3bv/XRFAGccUfZoB+Oc+FslDcjHhAZhCJ+UDR/L9tqeZTwImEQrICj+lyIBagddkoVLJM8QzYjB+/yfsLiQkKiOJjlGXW5p7Ah/A+bGhr82RInpX1kloaZSApcSL/PsbQaBJqoma2aCQgslSSjBpB/iB2AZS7Cj/v9pkyHHAaVlJghosHFRE0+MfQFiQrRjORM4eiHwbiK9/ddYsjm8sfCtHhTJGcQzBVTd20WT/8+AKA8xe3xozWE9uMBRo1XbpMy+ogOhr13rVujkD19VGky8Qpe9l2iQch79y7nDGYlFrfgGt63fZKK68dN+TVcoY9cUNMLeywz9uT7NIh6IKGY8H1r94tWDuvkHs59ze/9TK+yfZw27LAxEeOv0SrFNUsbh0JjEVPK0yBVK4WO++TPJhdl+8RS/4/U4g2lhV+IqoVpoq+0x0Mw==;5:AIhiHbi1WmOeQFbn+HQU/RYambIUcQNFflv34CNnaxaqJGMzMBK7ZvcolWVvXsxYE4sfepi2+Hef/d2zmjK8ICbRNFYUvKcR8epX27siMs0srFkAXv0MUrCBbjYWCWx08n7UrvdX3UX6InewwLEo9W+cj9Ce0+FeqvGwZpkqfpQ=;7:a+fBRwm/jjWgGK+wj6w7NqSdP6YKqmvbuHaAa30v54h8oDBZqqlIVydmBTljnKiou1zRs5/ValSTMRu0bRl1udn/erjH6wR7pDLggrShsZxeoia7VuKOUsK9lwan2UAmR4X5c+5yB1h1suc2XsPwN4nOa8an4PHtU5c4NcWMXGmWoAhMIYXTPPL/BJ9Ia5TOjtlgEuY+f8l8RMpTLfCe3+pbIZ+YF7fzvdJp3uVRGJ5desr6/FtKkwCjAIrExE6h
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 54689a5e-eb5a-4af2-12c2-08d616d8d77a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4392;
x-ms-traffictypediagnostic: BYAPR02MB4392:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB43921B7E07463F95DFB13F5CC2050@BYAPR02MB4392.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4392;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4392;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(376002)(366004)(136003)(51914003)(189003)(199004)(13464003)(68736007)(2201001)(5250100002)(8676002)(86362001)(105586002)(229853002)(8936002)(316002)(110136005)(345774005)(106356001)(25786009)(99286004)(66066001)(76176011)(5660300001)(81156014)(81166006)(7696005)(33656002)(9686003)(97736004)(6116002)(55016002)(2900100001)(6506007)(102836004)(186003)(7736002)(3846002)(305945005)(53936002)(53546011)(26005)(2501003)(14454004)(446003)(486006)(11346002)(256004)(6436002)(476003)(217873002)(6246003)(2906002)(478600001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4392;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ov5lOv8+kmRRLMl90SeidfJK2z4JXN4Po8GpBzUac1i34HWvyBHBYH0MB3prEgTGaQl/B3mfFwSWlVhDBkPsT/1MR1jVF9ZvgiFtkW/592vWeSw/DXwU2BYq4GYFwoyA9gJYn++Jz399yH4i4oNl0eMrlX2yqWhBUiWcIM/noOq792/BZ7Hb08KpUctPl/q6TNlqIAwy/KEDsqhccbHruQ4aAmXHXQPkU2fMqwZ0sGlHv4lrB64BZJ6qaJol3M4wq2LK6yqpQ/x77JsNajsw6FAhjzTGiWXosJHjnB6tQrQTX/t7yHfY0UhVEc0BB0j281VM/pW304uWdztc8OBB8DOS/AMyr3vsgwG98xQUxkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54689a5e-eb5a-4af2-12c2-08d616d8d77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 04:49:50.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4uLg0KUGxlYXNlIGZp
bmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFBoaWxpcHAgWmFiZWwgW21haWx0bzpwLnphYmVsQHBlbmd1dHJvbml4LmRlXQ0KPiBT
ZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciA1LCAyMDE4IDQ6MDAgUE0NCj4gVG86IE5hdmEga2lz
aG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFy
ay5ydXRsYW5kQGFybS5jb207IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgUmFq
YW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54
LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDMvM10gcmVzZXQ6IHJlc2V0LXp5bnFtcDogQWRkaW5n
IHN1cHBvcnQgZm9yIFhpbGlueA0KPiB6eW5xbXAgcmVzZXQgY29udHJvbGxlci4NCj4gDQo+IEhp
LA0KPiANCj4gdGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIEkgaGF2ZSBhIGZldyBjb21tZW50cyBi
ZWxvdzoNCj4gDQo+IE9uIFdlZCwgMjAxOC0wOS0wNSBhdCAxMjozOSArMDUzMCwgTmF2YSBraXNo
b3JlIE1hbm5lIHdyb3RlOg0KPiA+IEFkZCBhIHJlc2V0IGNvbnRyb2xsZXIgZHJpdmVyIGZvciBY
aWxpbnggWnlucSBVbHRyYVNjYWxlKyBNUFNvQy4NCj4gPiBUaGUgenlucW1wIHJlc2V0LWNvbnRy
b2xsZXIgaGFzIHRoZSBhYmlsaXR5IHRvIHJlc2V0IGxpbmVzIGNvbm5lY3RlZA0KPiA+IHRvIGRp
ZmZlcmVudCBibG9ja3MgYW5kIHBlcmlwaGVyYWwgaW4gdGhlIFNvYy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+
IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+IAkJLU5vbmUuDQo+ID4gQ2hhbmdlcyBmb3Ig
djI6DQo+ID4gCQktTW92ZWQgZWVtaV9vcHMgaW50byBhIHByaXYgc3RydWN0IGFzIHN1Z2dlc3Rl
ZA0KPiA+IAkJIGJ5IHBoaWxpcHAuDQo+ID4NCj4gPiAgZHJpdmVycy9yZXNldC9NYWtlZmlsZSAg
ICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcmVzZXQvcmVzZXQtenlucW1wLmMgfCAxMTUNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvcmVzZXQvcmVzZXQtenlucW1wLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Jlc2V0L01ha2VmaWxlIGIvZHJpdmVycy9yZXNldC9NYWtlZmlsZSBpbmRleA0KPiA+IGMxMjYx
ZGMuLjI3ZTRhMzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9NYWtlZmlsZQ0KPiA+
ICsrKyBiL2RyaXZlcnMvcmVzZXQvTWFrZWZpbGUNCj4gPiBAQCAtMjEsNCArMjEsNSBAQCBvYmot
JChDT05GSUdfUkVTRVRfVElfU0NJKSArPSByZXNldC10aS1zY2kubw0KPiA+ICBvYmotJChDT05G
SUdfUkVTRVRfVElfU1lTQ09OKSArPSByZXNldC10aS1zeXNjb24ubw0KPiA+ICBvYmotJChDT05G
SUdfUkVTRVRfVU5JUEhJRVIpICs9IHJlc2V0LXVuaXBoaWVyLm8NCj4gPiAgb2JqLSQoQ09ORklH
X1JFU0VUX1pZTlEpICs9IHJlc2V0LXp5bnEubw0KPiA+ICtvYmotJChDT05GSUdfQVJDSF9aWU5R
TVApICs9IHJlc2V0LXp5bnFtcC5vDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNl
dC9yZXNldC16eW5xbXAuYw0KPiA+IGIvZHJpdmVycy9yZXNldC9yZXNldC16eW5xbXAuYyBuZXcg
ZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAwMDAwMDAuLmY5MDg0OTINCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC16eW5xbXAuYw0KPiA+IEBAIC0w
LDAgKzEsMTE1IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggWGlsaW54LCBJbmMuDQo+ID4gKyAq
DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+IA0KPiBJIHRo
aW5rIGluY2x1ZGluZyBpby5oIGlzIG5vdCBuZWNlc3NhcnkuDQo+IA0KPiBbLi4uXQ0KDQpXaWxs
IGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gK3N0YXRpYyBpbnQgenlucW1wX3Jlc2V0
X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+ICsJCQkgICAg
ICAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IHp5bnFtcF9yZXNldF9k
YXRhICpwcml2ID0gdG9fenlucW1wX3Jlc2V0X2RhdGEocmNkZXYpOw0KPiA+ICsJaW50IHZhbCwg
ZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9IHByaXYtPmVlbWlfb3BzLT5yZXNldF9nZXRfc3RhdHVz
KFpZTlFNUF9SRVNFVF9JRCArIGlkLCAmdmFsKTsNCj4gPiArCWlmICghZXJyKQ0KPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGl0IHNob3VsZCBiZQ0KPiANCj4g
CWlmIChlcnIpDQo+IAkJcmV0dXJuIGVycjsNCj4gDQo+IGluc3RlYWQuDQo+IA0KPiBbLi4uXQ0K
V2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+ICtzdGF0aWMgc3RydWN0IHJlc2V0
X2NvbnRyb2xfb3BzIHp5bnFtcF9yZXNldF9vcHMgPSB7DQo+IA0KPiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJlc2V0X2NvbnRyb2xfb3BzIHp5bnFtcF9yZXNldF9vcHMgPSB7DQo+IA0KV2lsbCBmaXgg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+ICsJLnJlc2V0ID0genlucW1wX3Jlc2V0X3Jlc2V0
LA0KPiA+ICsJLmFzc2VydCA9IHp5bnFtcF9yZXNldF9hc3NlcnQsDQo+ID4gKwkuZGVhc3NlcnQg
PSB6eW5xbXBfcmVzZXRfZGVhc3NlcnQsDQo+ID4gKwkuc3RhdHVzID0genlucW1wX3Jlc2V0X3N0
YXR1cywNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgenlucW1wX3Jlc2V0X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArCXN0cnVjdCB6eW5xbXBfcmVz
ZXRfZGF0YSAqcHJpdjsNCj4gPiArDQo+ID4gKwlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5k
ZXYsDQo+ID4gKwkJCSAgICBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gDQo+IFRoaXMg
c2hvdWxkIGZpdCBvbiBvbmUgbGluZS4NCj4gDQpXaWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
