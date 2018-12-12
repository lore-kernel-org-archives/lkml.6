Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C36AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA1C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPxjabiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA1C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLLHYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:24:14 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:48865
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeLLHYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4W3PgYOzPj2/SPpjn5f+Yik6KaEoL7uLwnZnk45mhU=;
 b=PPxjabiL8N3Uv+Qrz6WmOkIShWwrffoepkkYMFzOo87oTG0d42LEEGCeXremiQU2AFN3u2lM0p+tiYf2W9Vt6cXHCZJL28i1ZElGsVEX0n+sZ6KKdxOMDV6Ix/LQSyCEwoaunADQdHfRiv9Vn0qsEHj1cd3k/pDWYxgqQ+tIO0g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 07:24:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:24:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUgwxVBuGAoI3VnkSnA7uAJmUIDaV6LKgAgACjpzA=
Date:   Wed, 12 Dec 2018 07:24:06 +0000
Message-ID: <DB3PR0402MB3916976645E416F7A7A0BDD1F5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1542963884-20823-1-git-send-email-Anson.Huang@nxp.com>
 <20181211213504.GA29643@bogus>
In-Reply-To: <20181211213504.GA29643@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3641;6:iqCJ9W64nefbnW1Q1l+wyuJTH9Htbfhwv0tZbP/IADng2uuyqGlRYtPnpKbv8V4OIo9zNL3XN4ywoNaf44lZ679+/UjYOB0wzrXV8IkqvAmyxEBWv2lxcuAzhJVsx+aKtcVJSceUXYGMMUz8l/FBW8Im56nnQ88xCcKEd3kzrDZ1SNaWQI5Wxb7yde19Il3+MUtqWrTT0kCdKjU3D+DbK8FC/DgpYVnWUIA4OIhIpH3OgxUVwLz16aKSxiq3ru2UNyqbvaX7iio1cGbRDjH7YzCq9/18jZN5Bn9BeTgoBaRV47nwKO/4fuQyhX526OzIC+XeqcYWQkmqHcr6IJVSaL9usuwGadEj7GpKHz9ZuPhAw7XH0Tw87JCDvTAAwlDbZ8p6FDzpY1nI1jfpXRz+tMLeiIx1GgK7GOB2MKVTaiVSV/DEVLOwXElhueG9Bl4nlkj/GADTqfrSup6gG4H3/g==;5:60b0tXt7foPoC1XlaBTDz3V0slaQVgg5OyGEde5sxanCZeUcUE0yW5+HuZs/XotBS/cXNBy6WVefdc4cgCE/XJIJtOBAKGJAfcnTm3tOn0swXUKt/esNMWU67SrVQ5ednzU3Xa5AdvevASlVYLYx8uxW/YFkEJmpZsUNZ9ZfYeI=;7:h23f93AtJnpJM/cTYyNcICMDKrp9cNRkciUJxJNHxcqriVTbOqG6x+b3au9TbY7bfPsAh3kbcXstr3GnpAX2ZEJn5WjJgkGOGvvZogXQyxCoZzgM6sOTXrVW7gXGsg64CRsxD+OZWTjXhfDa67B68Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c5a11b7f-c521-4c10-b9c9-08d66002cd47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-microsoft-antispam-prvs: <DB3PR0402MB3641B9BE93804AD97625EEA0F5A70@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231472)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3641;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3641;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(13464003)(102836004)(26005)(6436002)(71200400001)(71190400001)(54906003)(53936002)(53546011)(6506007)(229853002)(15650500001)(478600001)(186003)(7696005)(68736007)(305945005)(81156014)(33656002)(81166006)(8676002)(55016002)(76176011)(105586002)(74316002)(106356001)(14454004)(9686003)(7736002)(6246003)(8936002)(476003)(316002)(446003)(4326008)(11346002)(99286004)(256004)(2906002)(14444005)(97736004)(25786009)(5660300001)(486006)(86362001)(66066001)(6916009)(44832011)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jXa+Ib9yzsSDctF9STuw16scBlJvW2nzWPfwb9MYjlodsHTkLHX6KAE0LNeHXhh+s2LrsdmHXjg5wESKO6mV2yHxNAnnHOgJJw+xBuVFQ4XrLJUzNMK0aemV2XjkEgCjhAHrTdEVqxmJl8jWCTXPq2QEtk/3UC0D8g3rU1U4re9eLpdLH6YG0F5WbH0ZmkEhxqtA5yJLegwfltiettHYVW3eDdB/RtY8JMU2dDnoZOUWANMuQjl0lc9xoLQ0NykTM7iVhdxBUNde7idY6IMCjrHLQ30T/1AyzT1dcjRO+iPOYp7mcn3zw1zM7Fe5kv7z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a11b7f-c521-4c10-b9c9-08d66002cd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:24:06.8754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE4xOoxMtTCMTLI1SA1OjM1DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IHRnbHhAbGlu
dXRyb25peC5kZTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogdGlt
ZXI6IGdwdDogdXBkYXRlIGJpbmRpbmcgZG9jDQo+IA0KPiBPbiBGcmksIE5vdiAyMywgMjAxOCBh
dCAwOToxMDowOUFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBUaGUgaS5NWCBHUFQg
dGltZXIgZHJpdmVyIGJpbmRpbmcgZG9jIGlzIG91dCBvZiBkYXRlLCB0aGUNCj4gPiAiaW50ZXJy
dXB0cyIsICJjbG9ja3MiIGFuZCAiY2xvY2stbmFtZXMiIGRvIE5PVCBtYXRjaCBjdXJyZW50IEdQ
VA0KPiA+IGRyaXZlciBpbXBsZW1lbnRhdGlvbiwgdXBkYXRlIGl0IGFuZCB1c2UgaS5NWDZTWCBh
cyBleGFtcGxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVy
L2ZzbCxpbXhncHQudHh0ICAgICAgIHwgMjINCj4gKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIv
ZnNsLGlteGdwdC50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aW1lci9mc2wsaW14Z3B0LnR4dA0KPiA+IGluZGV4IDk4MDliMTEuLjRlOWZhMTYgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhn
cHQudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVy
L2ZzbCxpbXhncHQudHh0DQo+ID4gQEAgLTIsMTcgKzIsMjEgQEAgRnJlZXNjYWxlIGkuTVggR2Vu
ZXJhbCBQdXJwb3NlIFRpbWVyIChHUFQpDQo+ID4NCj4gPiAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gPg0KPiA+IC0tIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgImZzbCw8c29jPi1ncHQiDQo+ID4g
LS0gcmVnIDogU3BlY2lmaWVzIGJhc2UgcGh5c2ljYWwgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUg
cmVnaXN0ZXJzLg0KPiA+IC0tIGludGVycnVwdHMgOiBBIGxpc3Qgb2YgNCBpbnRlcnJ1cHRzOyBv
bmUgcGVyIHRpbWVyIGNoYW5uZWwuDQo+ID4gLS0gY2xvY2tzIDogVGhlIGNsb2NrcyBwcm92aWRl
ZCBieSB0aGUgU29DIHRvIGRyaXZlIHRoZSB0aW1lci4NCj4gPiArLSBjb21wYXRpYmxlIDogc2hv
dWxkIGJlICJmc2wsPHNvYz4tZ3B0Ii4NCj4gDQo+IFRoaXMgc2hvdWxkIGVudW1lcmF0ZSB2YWxp
ZCA8c29jPiB2YWx1ZXMuDQoNCkFncmVlLCBJIGxpc3QgYWxsIHRoZSBhdmFpbGFibGUgY29tcGF0
aWJsZSBzdHJpbmdzIGluIEdQVCBkcml2ZXIgaGVyZSBpbiBWMiBwYXRjaC4NCg0KPiANCj4gPiAr
LSByZWcgOiBzcGVjaWZpZXMgYmFzZSBwaHlzaWNhbCBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBy
ZWdpc3RlcnMuDQo+ID4gKy0gaW50ZXJydXB0cyA6IHNob3VsZCBiZSB0aGUgY2xvY2sgZXZlbnQg
ZGV2aWNlIGludGVycnVwdC4NCj4gPiArLSBjbG9ja3MgOiB0aGUgY2xvY2tzIHByb3ZpZGVkIGJ5
IHRoZSBTb0MgdG8gZHJpdmUgdGhlIHRpbWVyLCBtdXN0IGNvbnRhaW4NCj4gPiArICAgICAgICAg
ICBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1lcy4NCj4gPiArLSBjbG9jay1u
YW1lcyA6IG11c3QgaW5jbHVkZSBhbiAicGVyIiBvciAib3NjX3BlciIgZW50cnksIGFuZCAiaXBn
IiBlbnRyeQ0KPiA+ICsgICAgICAgICAgICAgICAgaXMgb3B0aW9uYWwgYWNjb3JkaW5nIHRvIFNv
QyBkZXNpZ24uDQo+IA0KPiBOZWVkIHRvIGRlZmluZSB0aGUgb3JkZXIuIElkZWFsbHkgdGhlIG9w
dGlvbmFsIGNsb2NrIHNob3VsZCBiZSBsYXN0LCBidXQgdGhhdCdzDQo+IG5vdCB3aGF0IHRoZSBl
eGFtcGxlIGhhcy4NCg0KQ3VycmVudCBHUFQgZHJpdmVyIGRvZXMgTk9UIGhhdmUgdGhlIG9yZGVy
IHJlcXVpcmVtZW50IHNpbmNlIGl0IGFsbCBnZXRzIGNsayBieSBuYW1lLCBidXQNCkkgdGhpbmsg
c3BlY2lmeWluZyB0aGUgb3JkZXIgaXMgYmV0dGVyLCBJIHVwZGF0ZSBpdCBpbiBWMiBwYXRjaC4N
Cg0KPiANCj4gPg0KPiA+ICBFeGFtcGxlOg0KPiA+DQo+ID4gLWdwdDE6IHRpbWVyQDEwMDAzMDAw
IHsNCj4gPiAtCWNvbXBhdGlibGUgPSAiZnNsLGlteDI3LWdwdCIsICJmc2wsaW14MS1ncHQiOw0K
PiA+IC0JcmVnID0gPDB4MTAwMDMwMDAgMHgxMDAwPjsNCj4gPiAtCWludGVycnVwdHMgPSA8MjY+
Ow0KPiA+IC0JY2xvY2tzID0gPCZjbGtzIDQ2PiwgPCZjbGtzIDYxPjsNCj4gPiArZ3B0OiBncHRA
MjA5ODAwMCB7DQo+IA0KPiB0aW1lckAuLi4NCj4gDQo+ID4gKwljb21wYXRpYmxlID0gImZzbCxp
bXg2c3gtZ3B0IiwgImZzbCxpbXgzMS1ncHQiOw0KPiANCj4gWW91IGhhdmVuJ3QgZG9jdW1lbnRl
ZCAiZnNsLGlteDMxLWdwdCIgaXMgYSB2YWxpZCBmYWxsYmFjay4gSXMgdGhlIG9sZCBleGFtcGxl
DQo+IG5vdCBzdGlsbCB2YWxpZCBmb3IgaW14Mjc/DQo+IA0KPiA+ICsJcmVnID0gPDB4MDIwOTgw
MDAgMHg0MDAwPjsNCj4gDQo+IFVzaW5nIGEgc2l6ZSA+IDRLQiBqdXN0IHdhc3RlcyB2aXJ0dWFs
IHNwYWNlIHdoaWNoIGlzIHZhbHVhYmxlIG9uIDMyLWJpdCBzeXN0ZW1zDQo+IHdpdGggPj0gMUdC
IFJBTS4NCg0KSSBmb3Jnb3QgdGhhdCBvbGQgZXhhbXBsZSBpcyBzdGlsbCB2YWxpZCwgc28gSSB3
aWxsIGp1c3QgdXNlIG9sZCBleGFtcGxlIGhlcmUsIGJ1dCB0aGUgb2xkDQpleGFtcGxlIG9mIGku
TVgyNyBHUFQgYWxyZWFkeSBOT1QgbWF0Y2ggd2l0aCBsYXRlc3QgaS5NWDI3IGR0c2kgR1BUIG5v
ZGUsIEkgdXBkYXRlDQppdCB3aXRoIGxhdGVzdCBHUFQgbm9kZSBpbiBpLk1YMjcgZHRzaSBpbiBW
MiBwYXRjaCwgcGxlYXNlIGhlbHAgcmV2aWV3IGl0LCB0aGFua3MuDQoNCkFuc29uLiANCg0KPiAN
Cj4gPiArCWludGVycnVwdHMgPSA8R0lDX1NQSSA1NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4g
PiArCWNsb2NrcyA9IDwmY2xrcyBJTVg2U1hfQ0xLX0dQVF9CVVM+LA0KPiA+ICsJCSA8JmNsa3Mg
SU1YNlNYX0NMS19HUFRfM00+Ow0KPiA+ICAJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+
ID4gIH07DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
