Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA4420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gUouIdBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA4420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437520AbeKWB4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:56:05 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:27048
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbeKWB4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+44qzlMkMIrDbLmT4/eBbfeTAmj+QJs2A/ZZq7sA4jc=;
 b=gUouIdBW4A2EbZxdi4GR0HriiaP5g/CLgQFN2ygpdRzVGfhOWnVQNuw4meiJE2vD57dIPiEHAA9BtIYvY7C4qC4mSEdYu/MN//KVYrdc7v1as8Mi1oRLuzc5RGMF69F51OqOVtxWGoJZGZLkEKCP3PJIput+FO4aeQBpXjyU7S0=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3461.jpnprd01.prod.outlook.com (20.178.96.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 15:16:12 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::f5b4:a8b6:2ad5:58b4%4]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 15:16:12 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device nodes
Thread-Topic: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device nodes
Thread-Index: AQHUbQZ8TtZTW3QcxUq23D537RtyIaVXCp2AgAAAbTCAAAlAgIAAS09ggAAdDICABDd14IAARakAgAAVtEA=
Date:   Thu, 22 Nov 2018 15:16:12 +0000
Message-ID: <OSBPR01MB21034E0B1AE2304A9A17DE50B8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1540542307-63158-1-git-send-email-biju.das@bp.renesas.com>
 <1be47ef6-1a92-e032-12c1-1deae5b67960@linaro.org>
 <OSBPR01MB210312547BBCBBC9FC01A616B8D80@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <67cf2385-9379-f02a-36fd-b2e07dfd5497@linaro.org>
 <TYAPR01MB2111A4092907D265493DDF3FB8D80@TYAPR01MB2111.jpnprd01.prod.outlook.com>
 <dbc5f62d-aff0-8c6a-e957-e7dea15cc002@linaro.org>
 <OSBPR01MB21030159FAA26E6C8FE492FFB8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <a82d3315-7608-3ff8-eaa1-e2a2c05c0694@linaro.org>
In-Reply-To: <a82d3315-7608-3ff8-eaa1-e2a2c05c0694@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3461;20:l9R3T9x9V0z7fNYHxjRBeBiJgqonxIH8Dz6H/4i8m15DSfAvZq4hNsyKaX1bt1xm+kK8ZwcDKt5hSupo+FLlv0W+1Sir2M26QldeU2O2/Q6Ye3iHGNYWC7jXUCxfKukWYbA82ScqyROciHyafhx5asbVHcX052MQ+SSuJMfOHkM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 119b3adf-7b93-4aa9-b0a4-08d6508d7073
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3461;
x-ms-traffictypediagnostic: OSBPR01MB3461:
x-microsoft-antispam-prvs: <OSBPR01MB346153256719A37D30163C6FB8DB0@OSBPR01MB3461.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB3461;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3461;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(51914003)(966005)(6116002)(71190400001)(71200400001)(25786009)(74316002)(486006)(44832011)(7736002)(5660300001)(55016002)(53936002)(97736004)(3846002)(7696005)(6506007)(478600001)(26005)(81156014)(8676002)(81166006)(476003)(8936002)(11346002)(305945005)(229853002)(53546011)(7416002)(76176011)(4326008)(54906003)(102836004)(86362001)(39060400002)(68736007)(105586002)(14454004)(6246003)(2906002)(106356001)(6436002)(2900100001)(9686003)(6306002)(99286004)(66066001)(186003)(316002)(446003)(33656002)(110136005)(93886005)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3461;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TsEc2a19rcU4g96PWz7+bkC7ysqtSzC7gpi3F21TokYVzLVkdaRE01KeOGyixCf+HRcN0AD1lykpBBk60tgo9uQHuAPRk7FMqb4DQKj6LH3bIe4cZn954GRDdZaCjbQsnz8qgGvPfypmTTdKK9R/UzrApQHH4WHEt1qVKgZTH6JnZ6XmPtvHfsgz3vhjes9Ot+Jf4DM9JUa1NDuoCSuluVnN6Y1CWtVzYzn6W8zKMmDbZyHYmK6GXWDKn9v2j6O9pDXDaYCDApXYrFgQbsaE0OwAVa38ZXMiyZ8brM6BtW5zCcGoeY+2LqvlRSHbBqMFwnphmN7EBFrw4ryJXSVZEXvvjXq+KtFcJJY2ieTJgQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b3adf-7b93-4aa9-b0a4-08d6508d7073
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 15:16:12.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRGFuaWVsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3Nzk2OiBBZGQgQ01UIGRldmlj
ZQ0KPiA+PiBub2Rlcw0KPiA+Pg0KPiA+PiBPbiAxOS8xMS8yMDE4IDE2OjUwLCBCaWp1IERhcyB3
cm90ZToNCj4gPj4+IEhpIERhbmllbCwNCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHRoZSBmZWVk
YmFjay4NCj4gPj4+DQo+ID4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcm02NDogZHRzOiBy
ZW5lc2FzOiByOGE3Nzk2OiBBZGQgQ01UIGRldmljZQ0KPiA+Pj4+Pj4gbm9kZXMNCj4gPj4+Pj4+
DQo+ID4+Pj4+PiBPbiAyNi8xMC8yMDE4IDEwOjI1LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+Pj4+
PiBUaGlzIHBhdGNoIGFkZHMgQ01UezB8MXwyfDN9IGRldmljZSBub2RlcyBmb3IgcjhhNzc5NiBT
b0MuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5k
YXNAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4gVGhpcyBwYXRjaCBp
cyB0ZXN0ZWQgYWdhaW5zdCByZW5lc2FzLWRldg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSSBoYXZl
IGV4ZWN1dGVkIG9uIGluY29uc2lzdGVuY3ktY2hlY2ssIG5hbm9zbGVlcCBhbmQNCj4gPj4+Pj4+
PiBjbG9ja3NvdXJjZV9zd2l0Y2ggc2VsZnRlc3RzIG9uIHRoaXMgYXJtNjQgU29DLiBUaGUNCj4g
Pj4+Pj4+PiBpbmNvbnNpc3RlbmN5LWNoZWNrIGFuZCBuYW5vc2xlZXAgdGVzdHMgYXJlIHdvcmtp
bmcgZmluZS5UaGUNCj4gPj4+Pj4+PiBjbG9ja3NvdXJjZV9zd2l0Y2ggYXN5bmNocm9ub3VzIHRl
c3QgaXMgZmFpbGluZyBkdWUgdG8NCj4gPj4+Pj4+PiBpbmNvbnNpc3RlbmN5LWNoZWNrDQo+ID4+
Pj4+PiBmYWlsdXJlIG9uICJhcmNoX3N5c19jb3VudGVyIi4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+
IEJ1dCBpZiBpIHNraXAgdGhlIGNsb2Nrc291cmNlX3N3aXRjaGluZyBvZiAiYXJjaF9zeXNfY291
bnRlciIsDQo+ID4+Pj4+Pj4gdGhlIGFzeW5jaHJvbm91cyB0ZXN0IGlzIHBhc3NpbmcgZm9yIENN
VDAvMS8yLzMgdGltZXIuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBIYXMgYW55IG9uZSBub3RpY2Vk
IHRoaXMgaXNzdWU/DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU28gbm93IHRoYXQgeW91IG1lbnRpb24g
dGhhdCwgSSd2ZSBiZWVuIHRocm91Z2ggdGhlDQo+ID4+Pj4+PiBjbG9ja3NvdXJjZV9zd2l0Y2gg
b24gYW5vdGhlciBBUk02NCBwbGF0Zm9ybSAoaGlrZXk5NjApIGFuZA0KPiA+Pj4+Pj4gZGlzYWJs
ZWQgdGhlDQo+ID4+Pj4+PiBBUk02NF9FUlJBVFVNXzg1ODkyMSBjb25maWcgb3B0aW9uLiBJIGNh
biBzZWUgdGhlIHNhbWUgaXNzdWUuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSXMgdGhpcyBvcHRpb24g
c2V0IG9uIHlvdXIgY29uZmlnID8NCj4gPj4+Pj4NCj4gPj4+Pj4gTm8uICBBcyBwZXIgICIgY29u
ZmlnIEFSTTY0X0VSUkFUVU1fODU4OTIxIiwgaXQgaXMgIldvcmthcm91bmQgZm9yDQo+ID4+Pj4g
Q29ydGV4LUE3MyBlcnJhdHVtIDg1ODkyMSINCj4gPj4+Pj4NCj4gPj4+Pj4gT3VyIFNvQyBpcyAy
eENBLTU3ICsgNCB4IENBLTUzLiAgRG9lcyAgaXQgaW1wYWN0IENBLTU3ICsgQ0FfNTM/DQo+ID4+
Pj4NCj4gPj4+PiBEdW5ubyA6Lw0KPiA+Pj4+DQo+ID4+Pj4+IEFueSB3YXkgSSB3aWxsIGVuYWJs
ZSB0aGlzIGNvbmZpZyBvcHRpb24gYW5kIHdpbGwgcHJvdmlkZSB5b3UgdGhlDQo+IHJlc3VsdHMu
DQo+ID4+Pj4NCj4gPj4+PiBPaywgdGhhbmtzIQ0KPiA+Pj4NCj4gPj4+IFRoZSBmb2xsb3dpbmcg
Y29uZmlnIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBvbiB1cHN0cmVhbQ0KPiA+Pj4ga2VybmVsKDQu
MjAtcmMzKSBDT05GSUdfQVJNX0FSQ0hfVElNRVJfRVZUU1RSRUFNPXkNCj4gPj4+IENPTkZJR19B
Uk1fQVJDSF9USU1FUl9PT0xfV09SS0FST1VORD15DQo+ID4+PiBDT05GSUdfRlNMX0VSUkFUVU1f
QTAwODU4NT15DQo+ID4+PiBDT05GSUdfSElTSUxJQ09OX0VSUkFUVU1fMTYxMDEwMTAxPXkNCj4g
Pj4+IENPTkZJR19BUk02NF9FUlJBVFVNXzg1ODkyMT15DQo+ID4+Pg0KPiA+Pj4gRm9yIGEgcXVp
Y2sgdGVzdGluZywgIEkgaGF2ZSBhY3RpdmF0ZWQgdGhlIGVycmF0dW0gdXNpbmcgdGhlDQo+ID4+
PiBwcm9wZXJ0eQ0KPiA+PiAiZnNsLGVycmF0dW0tYTAwODU4NSIgb24gZGV2aWNlIHRyZWUuDQo+
ID4+PiBXaXRoIHRoaXMgSSBjb25maXJtIHRoZSBpc3N1ZSBpcyBmaXhlZC4NCj4gPj4+DQo+ID4+
PiBJIGhhdmUgIHNvbWUgcXVlc3Rpb25zIG9uIHRoaXMuDQo+ID4+PiAxKSBCYXNlZCAgb24gdGhl
IHRlc3QgcmVzdWx0ICxkbyB5b3UgdGhpbmsgcmVuZXNhcyBzb2MgYWxzbw0KPiA+Pj4gaW1wYWN0
ZWQgYnkgdGhlDQo+ID4+IEFSTTY0X0VSUkFUVU1fODU4OTIxPw0KPiA+Pj4gMikgSXMgdGhlcmUg
YW55IHdheSB0byBmaW5kLCBpcyB0aGlzIEVycmF0dW0gYWN0dWFsbHkgY2F1c2luZyB0aGUNCj4g
Pj4gYXN5bmNocm9ub3VzIHRlc3QgdG8gZmFpbD8NCj4gPj4NCj4gPj4gSSBndWVzcywgeW91IGNh
biBoYWNrIHRoZSBfX2ZzbF9hMDA4NTg1X3JlYWRfcmVnIG1hY3JvIGFuZCBjaGVjayBpZg0KPiA+
PiB0aGUgaW52YWxpZCBjb25kaXRpb24gaXMgcmVhY2hlZC4NCj4gPj4NCj4gPj4gVGhpcyB0aHJl
YWQgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNS8xMC83NzMgd2lsbCBnaXZlIHlvdSBhbGwg
dGhlDQo+ID4+IGFuc3dlcnMgeW91IGFyZSBsb29raW5nIGZvciAod2VsbCB2ZXJ5IGxpa2VseSku
DQo+ID4+DQo+ID4+IExldCBtZSBrbm93IGlmIGl0IGhlbHBlZC4NCj4gPg0KPiA+IEluIG91ciBj
YXNlICwgRGVsdGE6IDE3NDc2MCBucw0KPiA+DQo+ID4gMTUzMDU1MzM1MToyMDU3NjIyODQNCj4g
PiAxNTMwNTUzMzUxOjIwNTc2MjQwNA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gMTUz
MDU1MzM1MToyMDU5NTEyMjYNCj4gPiAxNTMwNTUzMzUxOjIwNTc3NjQ2Ng0KPiA+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4NCj4gPiBJIGhhdmUgdHJpZWQgdGhlIHdvcmthcm91bmQgZm9yIEFS
TTY0X0VSUkFUVU1fODU4OTIxLCB0aGF0IGFsc28gZml4ZXMNCj4gdGhlIGlzc3VlLg0KPiA+DQo+
ID4gQnV0IGFsbCB0aGUgd29ya2Fyb3VuZCBkaXNhYmxlcyBBUk02NCBWRFNPLiBIb3cgZG8gd2Ug
Y29uY2x1ZGUgdGhhdCBpcw0KPiBpdCBWRFNPIGlzc3VlIG9yIEFSTTY0X0VSUkFUVU0gaXNzdWU/
DQo+DQo+IE1heSBiZSBkaXNhYmxlIGFsbCBlcnJhdGEgYW5kIHNldCB2ZHNvX2RlZmF1bHQgdG8g
ZmFsc2U/DQo+DQo+IFsgLi4uIF0NCj4NCj4gLXN0YXRpYyBib29sIHZkc29fZGVmYXVsdCA9IHRy
dWU7DQo+ICtzdGF0aWMgYm9vbCB2ZHNvX2RlZmF1bHQgPSBmYWxzZTsNCj4NCj4gWyAuLi4gXQ0K
DQpJIGhhdmUgZGlzYWJsZWQgdGhlICBhY3RpdmF0aW9uIG9mIGVycmF0YSBmcm9tIGRldmljZSB0
cmVlIGFuZCBzZXQgdmRzb19kZWZhdWx0PWZhbHNlLg0KV2l0aCB0aGlzIGFsc28gaXQgd29ya3Mg
ZmluZS4gU28gbG9va3MgbGlrZSBhcm02NCB2ZHNvIGlzIHRoZSBpc3N1ZSBpbiBvdXIgY2FzZS4N
Cg0KRG8geW91IGFncmVlIHdpdGggdGhlIGNvbmNsdXNpb24/DQoNClsgICAgMC4wMDAwMDBdIHJj
dTogQWRqdXN0aW5nIGdlb21ldHJ5IGZvciByY3VfZmFub3V0X2xlYWY9MTYsIG5yX2NwdV9pZHM9
Ng0KWyAgICAwLjAwMDAwMF0gTlJfSVJRUzogNjQsIG5yX2lycXM6IDY0LCBwcmVhbGxvY2F0ZWQg
aXJxczogMA0KWyAgICAwLjAwMDAwMF0gYXJjaF90aW1lcjogY3AxNSB0aW1lcihzKSBydW5uaW5n
IGF0IDguMzJNSHogKHZpcnQpLg0KWyAgICAwLjAwMDAwMF0gY2xvY2tzb3VyY2U6IGFyY2hfc3lz
X2NvdW50ZXI6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgxZWIzOThjMDcs
IG1heF9pZGxlX25zOiA0NDA3OTUyMDI1MDMgbnMNClsgICAgMC4wMDAwMDRdIHNjaGVkX2Nsb2Nr
OiA1NiBiaXRzIGF0IDhNSHosIHJlc29sdXRpb24gMTIwbnMsIHdyYXBzIGV2ZXJ5IDIxOTkwMjMy
NTU1MDNucw0KDQpyZWdhcmRzLA0KIEJpanUNCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVy
b3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2lu
Z2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5k
ZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
