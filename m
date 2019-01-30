Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89314C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E589218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="bFXrUEcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfA3KjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:39:18 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:16393 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbfA3KjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:39:18 -0500
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 62/F3-01171-1DE715C5; Wed, 30 Jan 2019 10:39:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfc85OzuGi7fp8MlSaBCktrlZ0ZG
  gkj40K0OhvpRQZ3naBtscO7M0MtbCQE2xtMDVyrxRThpYUmaZFV2M7EppN/JWoRYVraygy87O
  7PLt/76///t/nuflYUjlIzqB4YtcvNPOWdX0NMqcRizR3N+Vm6drc8exzw72EuyexgDNlvs7K
  bb74ymCfXj+CM02tJSS7Ojx28RyuaG+vdBwtDfXcMnXJjd0Trrlhk/tSTmyDTKL3VhQtFlm9n
  zvoB2vVEUX3+vcqEdVjqYxFA6QsGdyL1GOohklriWgfm+2CJR4GIH7bY9cBDRmoebmIC2COHw
  HQffIS5l4IPFTBH2VVUh0xeLV4L/wIhwVh9fAmL+GlnQ6/DixTyZqCs+FwUNnwqkKzEHZwSqq
  HDGhcix03QxbonEG1J3yhDXCiRDc7SdFTeJ4eDp6LBwPGEPThbukpFUwNvIz4ueh1zOApPv50
  Nc/GtFqaBnwyiSdCA+OVSCxf8Clcvgw/lYugWy4+uuqTALPEfQ3TxBTSZPNNZHXLDRVlFKSdo
  Dv4zdaHADwbAgG10lvq2kY6fRG/nQLfPD1RQokQWvlECWZ7pHgafMS1SjZ+8903lAWiZMhcD5
  Nup4DtRVDcm/4v2ZAb90oVY+oVrTY6LSYzC4bZ7Fq9DqdRq9P1+gzMjQLWS23Q2PU8oWa7bzg
  0ui13HZBKxTbtljztXbe1Y5Cy5XvuKE7h2obTFfQTIZQqxSrsnPzlNONBfnFZk4wb3IWWnnhC
  prNMGpQlJSE2Awnb+KLtlqsoQ2dwsDEqOMUn0SsEBycTbCYJHQLLWB6GoZ8JPPu8hsfqaTsBX
  Y+IV5xfWfIikWrudD+J2hq2x+gxIRYBYqKilLGOHinzeL6n4+jeAapYxWtYsEYi931p954qBU
  i1MqOzByxFRf3FyW4UVazvqtnd17ZIvmtrrQ7Bx5Xn/0cUGWmBocnnhDD+/3RjfTSgMGWdX3w
  xueByo7bEJ11JMfWHfyanvrk8IJtfb/4Ys/jb7NSVpm61y45+cw6r+HexNi1zPUbf76eu34N/
  aVjJKlsxcx3zacfrpzTkoxPNM6PIapKjOTEQL8/s67FsUxNCWZOn0I6Be43ClID7ugDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-282.messagelabs.com!1548844752!998422!1
X-Originating-IP: [104.47.2.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19070 invoked from network); 30 Jan 2019 10:39:13 -0000
Received: from mail-db5eur01lp2059.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.59)
  by server-7.tower-282.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 30 Jan 2019 10:39:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaUlEgf+4edMqVn6cgl//Mqp6Zat13Eb0conh76LhD0=;
 b=bFXrUEcJ7R3apZw9p5LJd45O/c83Jft2UNraYBxPgZ/J5ft8M1K6g+RMVzYg1YahsxpQmgi3TZc+TiO4EtermDqAE12pEUBX0wihDkhnEmaGq7+7tXC0ub7+JXbzEkL4nov2TBdce2pa6s7ITWzPQn83MJw833Agtsoo7aD7hiI=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB0980.EURPRD10.PROD.OUTLOOK.COM (10.169.154.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 10:39:02 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98b1:b963:cf3:a5e9]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98b1:b963:cf3:a5e9%11]) with mapi id 15.20.1558.025; Wed, 30 Jan 2019
 10:39:02 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Kyle Tso <kyletso@google.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "badhri@google.com" <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
Thread-Topic: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
Thread-Index: AQHUuEnvm81N+7FLhESfCcxKmMilCqXHkYXA
Date:   Wed, 30 Jan 2019 10:39:01 +0000
Message-ID: <AM5PR1001MB0994F9594BDDBD97BD9794D380900@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190130031353.100228-1-kyletso@google.com>
In-Reply-To: <20190130031353.100228-1-kyletso@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB0980;6:A9oRvTWsRUTGmQsO2Tj4F8mWE5nh+8BITgZHAbMYnaZaH6FpYWo7pZCNPNabe9MoArrEoGb40GNYHhv48oeW7k5OwWlydTwerOJFKvDEcddl7b0PytAJ3ZqYt6i46V5c2DLo0P4xtJ697BFZIjsk6/YXVGHGuNpMEFU+giEV/KWgZHITasxSLUj9gGvOgdI4K6BkIvEq+6o16OQ3+Q4B0+++GB8nO8CBfO+t2iZUyw0UDwI0GnqXfFN0Jhcf9X28ejFNtH4WaUWyTFM/SvtZsouK2A3Yv6rhQxQuqvJvI2r1aaBnbmtUvXVofzwdD8iNQkBwzxk3a2Acr+gHTIOGnHucO4YQlFcSudUOkASM67h+ENUuJ7WqeBGbQheSZ5iSRpDgM/1W+fpbEv9Dytr2HOAustZipOte0dpWSSoiLUcuRauIJG60kfK6amnhXvIsS0MKxK5NsI0rxv+h7IHZBg==;5:29b4iVdovL+LQ07xJQ9OiuAySYWrLlVmPPWrHFFXs+e+pJKh+C+qLw1thHRzSirQY0Pb48GrafgUv/eh53k7ZszvyJRsCsbgDtIz/yoa2aRPUYSDKjFF++WgwKbZ4T2gP36yZ5qFHujfBa5nF7kUGvQk6eQH/J/EkWRMZ1ev26aGPmYigf3Jz1OrOyLBZoV0ylAx6O9mB6T4i3fQ9ElO4w==;7:KZNOC+DeMh/21Y4GZIMDfVruQ9iIK6tfZdci0BrP5jStC2JF/AMvn635Vgbc9TIO4prGe6v2INF/KNYjA50E89gdsYMLFPbLH8a5nbzrCtMQaAq2Mnl4vC7Uq6oC5Xa7dVPqRLg8B5EM5BnDQC5WaA==
x-ms-office365-filtering-correlation-id: f380a6ba-ac3e-4681-03a0-08d6869f265e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB0980;
x-ms-traffictypediagnostic: AM5PR1001MB0980:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB098067972597EC8E71DE7B84A7900@AM5PR1001MB0980.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(76176011)(14454004)(55016002)(9686003)(33656002)(72206003)(2906002)(86362001)(6246003)(6506007)(53546011)(68736007)(478600001)(229853002)(53936002)(6436002)(25786009)(4326008)(71200400001)(71190400001)(99286004)(97736004)(3846002)(6116002)(256004)(14444005)(7696005)(305945005)(7736002)(316002)(2501003)(110136005)(105586002)(54906003)(66066001)(2201001)(106356001)(186003)(8676002)(81156014)(74316002)(81166006)(26005)(11346002)(446003)(8936002)(476003)(486006)(102836004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0980;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1BFzxA2ESMVxhM8ivN9kG4BeY5ruTbeuDj17jOS/t7euIwydgQlCNwyTDIyq51cFL8aNkWAeQMyzBjhifoehAk5c6LC0N0AobvUTX1nbSjvEjPCphP1NPdpl4NjyKS0/gTfqUIIV+ZKcFg9YUDhINplMXIIAloQhyJpO/QRG4wWsyEsSgGZxaYKw8U4nz2Z4vK7b/53rk8pmKINUj6PY3kdRpJmcl4d/a8O33xAEHlbYDIWIxHj0kB00ZCaMZ6IucxT8Gn5kb0etaVu+mr98gvkEVDrAIOX9WCPYSqzckcy7obqFOwd1tGok+spzudYZKloJbdCmBRd3zP0RtIWp5Qimnn80oYNwhllLAqnj0l0RbqHR/UdV5QI6LjDY62eu7pvWm+g+zwdyTJ760qE3bqCufB9xZACLL8M2GwZevns=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f380a6ba-ac3e-4681-03a0-08d6869f265e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 10:39:01.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAgSmFudWFyeSAyMDE5IDAzOjE0LCBLeWxlIFRzbyB3cm90ZToNCg0KPiBXaGVuIFNpbmsg
bmVnb3RpYXRlcyBQUFMsIHRoZSB2b2x0YWdlIHJhbmdlIG9mIHNlbGVjdGVkIFBQUyBBUERPIG1p
Z2h0IG5vdA0KPiBjb3ZlciB0aGUgcHJldmlvdXMgdm9sdGFnZSAob3V0X3ZvbHQpLiBJZiB0aGUg
cHJldmlvdXMgb3V0X3ZvbHQgaXMgbG93ZXIgdGhhbiB0aGUNCj4gbmV3IG1pbl92b2x0LCB0aGUg
b3V0cHV0IHZvbHRhZ2UgaW4gUkRPIG1pZ2h0IGJlIHNldCB0byBhbiBpbnZhbGlkIHZhbHVlLiBG
b3INCj4gaW5zdGFuY2UsIHN1cHBvc2VkIHRoYXQgdGhlIHByZXZpb3VzIHZvbHRhZ2UgaXMgNVYs
IGFuZCB0aGUgbmV3IHZvbHRhZ2UgcmFuZ2UgaW4NCj4gdGhlIEFQRE8gaXMgN1YtMTJWLiBUaGVu
IHRoZSBvdXRwdXQgdm9sdGFnZSBpbiB0aGUgUkRPIHNob3VsZCBub3QgYmUgc2V0IHRvIDVWDQo+
IHdoaWNoIGlzIGxvd2VyIHRoYW4gdGhlIHBvc3NpYmxlIG1pbl92b2x0IDdWLg0KPiANCj4gRml4
IHRoaXMgYnkgY2hvb3NpbmcgdGhlIG1heGltYWwgdmFsdWUgYmV0d2VlbiB0aGUgcHJldmlvdXMg
dm9sdGFnZSBhbmQgdGhlDQo+IG5ldyBtaW5fdm9sdCBmaXJzdC4gQW5kIGVuc3VyZSB0aGF0IHRo
aXMgdmFsdWUgd2lsbCBub3QgZXhjZWVkIHRoZSBuZXcgbWF4X3ZvbHQuDQo+IFRoZSBuZXcgb3V0
X3ZvbHQgd2lsbCBmYWxsIHdpdGhpbiB0aGUgbmV3IHZvbHRhZ2UgcmFuZ2Ugd2hpbGUgYmVpbmcg
dGhlIGNsb3Nlc3QNCj4gdmFsdWUgY29tcGFyZWQgdG8gdGhlIHByZXZpb3VzIG91dF92b2x0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS3lsZSBUc28gPGt5bGV0c29AZ29vZ2xlLmNvbT4NCg0KSSdk
IGJlIGludGVyZXN0ZWQgdG8gc2VlIGhvdyBtYW55IFNvdXJjZXMgZ28gb2ZmLXBpc3RlIGxpa2Ug
dGhhdCB3aXRoIGEgbW9yZQ0KdW51c3VhbCBQUFMgcmFuZ2UsIGVzcGVjaWFsbHkgd2hlbiB0aGUg
ZGVmYXVsdCBmaXhlZCBpcyA1ViwgYW5kIHRoZXkncmUgcmVxdWlyZWQNCnRvIHN1cHBvcnQgb25l
IG9mIHRoZSBkZWZpbmVkIFBQUyByYW5nZXMgd2hpY2ggd2lsbCBzdGFydCBhdCAzLjNWLiBOb3Qg
c3VyZSB3aGF0DQp0aGlzIG1pZ2h0IGdhaW4geW91LiBIb3dldmVyLCBzcGVjIHNheXMgaXQncyBw
b3NzaWJsZSBzbzoNCg0KUmV2aWV3ZWQtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29uLk9w
ZW5zb3VyY2VAZGlhc2VtaS5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi90eXBlYy90Y3Bt
L3RjcG0uYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3Bt
LmMgYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiBpbmRleCBmMWQzZTU0MjEwZGYu
LjhmMmFmMzQ4YmRhNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3Bt
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BtLmMNCj4gQEAgLTIyOTcsNyAr
MjI5Nyw4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8oc3Ry
dWN0DQo+IHRjcG1fcG9ydCAqcG9ydCkNCj4gIAkJCQkJICAgICAgcGRvX3Bwc19hcGRvX21heF92
b2x0YWdlKHNuaykpOw0KPiAgCQlwb3J0LT5wcHNfZGF0YS5tYXhfY3VyciA9IG1pbl9wcHNfYXBk
b19jdXJyZW50KHNyYywgc25rKTsNCj4gIAkJcG9ydC0+cHBzX2RhdGEub3V0X3ZvbHQgPSBtaW4o
cG9ydC0+cHBzX2RhdGEubWF4X3ZvbHQsDQo+IC0JCQkJCSAgICAgIHBvcnQtPnBwc19kYXRhLm91
dF92b2x0KTsNCj4gKwkJCQkJICAgICAgbWF4KHBvcnQtPnBwc19kYXRhLm1pbl92b2x0LA0KPiAr
CQkJCQkJICBwb3J0LT5wcHNfZGF0YS5vdXRfdm9sdCkpOw0KPiAgCQlwb3J0LT5wcHNfZGF0YS5v
cF9jdXJyID0gbWluKHBvcnQtPnBwc19kYXRhLm1heF9jdXJyLA0KPiAgCQkJCQkgICAgIHBvcnQt
PnBwc19kYXRhLm9wX2N1cnIpOw0KPiAgCX0NCj4gLS0NCj4gMi4yMC4xLjQ5NS5nYWE5NmIwY2U2
Yi1nb29nDQoNCg==
