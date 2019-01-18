Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4577BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA3C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cOrDbWQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfARJpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:16 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:49424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbfARJpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNVHL3u8SHPH/7eG4xTl4xgC78qoFLn6d3zV+LWQMv4=;
 b=cOrDbWQprrZjYpVjToJrOyD3a5sjtZ8Vob8NCCDlFigFZavdGAxL5ff8U8/6PcLeTIcWs5MfnBWOfzKlqp+JFFwRtbWY+evISTA9xIFH6TU5qrMKi1cYNUZe3aHbTk3TtaeotoM+lAw6R9qajHPe8QY/DpBEfeaGIQSvVIHS/FE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6260.eurprd04.prod.outlook.com (20.179.35.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Fri, 18 Jan 2019 09:45:11 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:45:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vOD6W0tw+AgAAPHzA=
Date:   Fri, 18 Jan 2019 09:45:11 +0000
Message-ID: <AM0PR04MB421154DA0EFFA8125F151171809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
In-Reply-To: <1547801291.2626.3.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6260;6:nb6ULgB7CJaSWUTTOSyTZqLwfmMCU4WrBD+5V1UYDxKt8LaAXU1613aMU+cBgQVMrvH0ajy7gAIF/saLMSj9Lvx3wHqcHkKPl+PGtiftAgekzBPqoqQiK/agOvWfyccC3SGwbYWUQTHiN7wVtLAI5tssIk0/vR7bs4aEGVyY48TI5KxeIt7UcIDPWzv0XEWhts5yRF3SmmQeXRKw3ldu2lqg+gOHyysoop6Vzt8HKI3fnkxy2fT7sr6gz7uFOetnHkSe0tVXzvh8lNZE0X/pqa1EW2MH7oGqPoSLM4YC6nMwKAdcgA29dcTMxymzHLiB6F4mDWDzp/8/h2uxWe6C/f0nqZfpi04fYHLp/IG+moajgxX0710NSrpoIwUVuMb5k18dH6fhNiEIjJ4+7IA2qSHaXpl4Ku2GGp/5vo0jqlRhbXeBpEqNV4NpNTql7LR+B/xiROCpql0ONdJe5Szbhg==;5:ZIIUh8kKHBB/ixHu25GgH8jdh2fa7V/ytX+hZgXjJs6riydNumqI4DJeVQiIRdPPdzokl5LgCw4Lp1sJZCjM6HsyoHNHZs0V6VxCuMfrrv9pfu5Urv2HYf83BjrVbDL48kN0b4edXw/PnXzPy6C7ZIhQ3Z/CmgAjygInE6V5stU0V8CHTPmKMi7lhrW7p0HlFXzd1N7HvVPtW5dlbKHStw==;7:BmOI+qC2KbqA9wSD6huzd6+EFZeQBp3MzAIf5fRwtuPd8raKbsA89kw30LE9cjYvtTIDwrWgOHBI2fSHwfA+LLaQuJFGIROmsM70HNHv6+o++l4ACorasqVSLVAGhwqi0pcPklBD1m/phMNayUcgXw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 036902d7-37e5-47b7-9a67-08d67d29a3e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6260;
x-ms-traffictypediagnostic: AM0PR04MB6260:
x-microsoft-antispam-prvs: <AM0PR04MB6260047F9B8462C2408F829D809C0@AM0PR04MB6260.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(13464003)(14454004)(74316002)(229853002)(68736007)(33656002)(2906002)(9686003)(97736004)(86362001)(6436002)(478600001)(446003)(11346002)(5660300001)(53936002)(256004)(486006)(2501003)(71190400001)(71200400001)(44832011)(4326008)(6346003)(26005)(6506007)(102836004)(7736002)(6246003)(55016002)(106356001)(99286004)(476003)(105586002)(3846002)(25786009)(305945005)(6116002)(76176011)(81166006)(81156014)(186003)(66066001)(8936002)(54906003)(7696005)(110136005)(8676002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6260;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q1TGkCwNy3nQqMGM2NpvrBBc5BlXFGVn6pyYsCeErUcgONE8n2v0euJokD5mx8GZvjzaCZ89LzX9Clqd7qWETAd1ZnBqrHSCV93qq8Sr0zcBT3iGjjsqGVxAsuhyGvpndYy3006VGFKkIo0lZt9HQ8qaE6fC12fIlHIP95OWDvzjppU2IRo3/tlE/KIsHRe2Uk91KeBmCRqqw8ud1zxYsh2AKUlgqWRuaE7y0cYwJn5V7TYrY8mJ7+u4GcvLxrzsJVVsIFfKRTtPdTLjaFg7QECALv1IfYlBN2gVjnUCMFyGOD+oHeFfbzzQqkvVuBF9Af3EcjXWfa0hQCrBuwgjODYFtcv1LEPFKCdrbo6mPutC9CXBlX+U0LqVxZfe+m28iUWjgHVx3qQcgDAfdMFhORK1f6p4oRMsP+U9qtO9eE4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036902d7-37e5-47b7-9a67-08d67d29a3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:45:11.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRv
Omwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxOCwgMjAx
OSA0OjQ4IFBNDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW4gMTguMDEuMjAxOSwgMDc6NTMgKzAwMDAg
c2NocmllYiBBaXNoZW5nIERvbmc6DQo+ID4gTm90IGFsbCA2NCBpbnRlcnJ1cHRzIG1heSBiZSB1
c2VkIGluIG9uZSBncm91cC4gZS5nLiBtb3N0IGlycXN0ZWVyIGluDQo+ID4gaW14OHF4cCBhbmQg
aW14OHFtIHN1YnN5c3RlbXMgc3VwcG9ydHMgb25seSAzMiBpbnRlcnJ1cHRzLg0KPiA+DQo+ID4g
QXMgdGhlIElQIGludGVncmF0aW9uIHBhcmFtZXRlcnMgYXJlIENoYW5uZWwgbnVtYmVyIGFuZCBp
bnRlcnJ1cHRzDQo+ID4gbnVtYmVyLCBsZXQncyB1c2UgZnNsLGlycXMtcGVyLWNoYW4gdG8gcmVw
cmVzZW50cyBob3cgbWFueSBpbnRlcnJ1cHRzDQo+ID4gc3VwcG9ydGVkIGJ5IHRoaXMgaXJxc3Rl
ZXIgY2hhbm5lbC4NCj4gDQo+IFNvcnJ5LCBidXQgdG90YWwgTkFDSy4gSSd2ZSBnb3QgdG8gZ3Jl
YXQgbGVuZ3RocyB3aXRoIGR1bXBpbmcgdGhlIGFjdHVhbGx5DQo+IGltcGxlbWVudGVkIHJlZ2lz
dGVyIGxheW91dCBvbiBpLk1YOE0gYW5kIEFGQUlDUyB0aGUgSVJRcyBhcmUgYWx3YXlzDQo+IG1h
bmFnZWQgaW4gZ3JvdXBzIG9mIDY0IElSUXMsIGV2ZW4gaWYgbGVzcyB0aGFuIHRoYXQgYXJlIGNv
bm5lY3RlZCBhcyBpbnB1dA0KPiBJUlFzLiBUaGlzIGlzIHdoYXQgdGhlIGFjdHVhbGx5IHByZXNl
bnQgcmVnaXN0ZXIgc2V0IG9uIGkuTVg4TSB0ZWxscyB1cy4NCj4gDQoNClRoZSByZWdpc3RlciBs
YXlvdXQgdmFyaWVzIGRlcGVuZHMgb24gdGhlIGlycSBwZXIgY2hhbm5lbCBzdXBwb3J0cy4NCkl0
J3MgdHJ1ZSA2NCBJUlFzIG9uIE1YOE0sIGJ1dCBub3QgdHJ1ZSBmb3IgUVhQIGFuZCBRTS4NClRo
YXQncyB3aHkgd2Ugc2hvdWxkbid0IHVzZSBmc2wsaXJxLWdyb3Vwcy4NCg0KUmVnYXJkcw0KRG9u
ZyBBaXNoZW5nDQoNCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gQ2M6IE1hcmMgWnluZ2ll
ciA8bWFyYy56eW5naWVyQGFybS5jb20+DQo+ID4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz4NCj4gPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5k
ZT4NCj4gPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hl
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IMKgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dMKgwqDCoMKgwqDC
oMKgfA0KPiA+IDYgKysrLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFzdGVlci4N
Cj4gPiB0eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9mc2wsaXJxc3RlZXIuDQo+ID4gdHh0DQo+ID4gaW5kZXggNDU3OTBjZS4u
ZWFhYmNkYSAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaXJxc3RlZXIuDQo+ID4gdHh0DQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2ZzbCxpcnFzdA0KPiA+ICsrKyBlZXIudHh0DQo+ID4gQEAgLTE2LDggKzE2LDggQEAgUmVx
dWlyZWQgcHJvcGVydGllczoNCj4gPiDCoC0gI2ludGVycnVwdC1jZWxsczogU3BlY2lmaWVzIHRo
ZSBudW1iZXIgb2YgY2VsbHMgbmVlZGVkIHRvIGVuY29kZSBhbg0KPiA+IMKgwqDCoGludGVycnVw
dCBzb3VyY2UuIFRoZSB2YWx1ZSBtdXN0IGJlIDEuDQo+ID4gwqAtIGZzbCxjaGFubmVsOiBUaGUg
b3V0cHV0IGNoYW5uZWwgdGhhdCBhbGwgaW5wdXQgSVJRcyBzaG91bGQgYmUgc3RlZXJlZCBpbnRv
Lg0KPiA+IC0tIGZzbCxpcnEtZ3JvdXBzOiBOdW1iZXIgb2YgSVJRIGdyb3VwcyBtYW5hZ2VkIGJ5
IHRoaXMgY29udHJvbGxlciBpbnN0YW5jZS4NCj4gPiAtwqDCoEVhY2ggZ3JvdXAgbWFuYWdlcyA2
NCBpbnB1dCBpbnRlcnJ1cHRzLg0KPiA+ICstIGZzbCxpcnFzLXBlci1jaGFuOiBOdW1iZXIgb2Yg
aW5wdXQgaW50ZXJydXB0cyBwZXIgY2hhbm5lbC4gU2hvdWxkDQo+ID4gK2JlIG11bHRpcGxlIG9m
IDMyDQo+ID4gK8KgwqBpbnB1dCBpbnRlcnJ1cHRzIGFuZCB1cCB0byA1MTIgaW50ZXJydXB0cy4N
Cj4gPg0KPiA+IMKgRXhhbXBsZToNCj4gPg0KPiA+IEBAIC0yOCw3ICsyOCw3IEBAIEV4YW1wbGU6
DQo+ID4gPiDCoAkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19ESVNQX0FQQl9ST09UPjsNCj4g
PiA+IMKgCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPiA+ID4gwqAJCWZzbCxjaGFubmVsID0gPDA+
Ow0KPiA+ID4gLQkJZnNsLGlycS1ncm91cHMgPSA8MT47DQo+ID4gPiArCQlmc2wsaXJxcy1wZXIt
Y2hhbj0gPDY0PjsNCj4gPiA+IMKgCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gPiA+IMKgCQkj
aW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ID4gwqAJfTsNCg==
