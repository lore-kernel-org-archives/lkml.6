Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E6DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9644321738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aNVS6SNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfA1VkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:40:02 -0500
Received: from mail-eopbgr1310101.outbound.protection.outlook.com ([40.107.131.101]:6076
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfA1VkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqQPp4W61DOM0zUzX+OE9gBkAvFJXo2apLZukuQ5VQU=;
 b=aNVS6SNTzqmQ/DrxmgT+61RQq4wh293FgHzzX6TipB7bMgNObrUZhgRBbsApH/PWusPZuB9Lld8IxRWcX+vG3g5beduIaI4iEbC64G1B7k4ghWc/NWqDiBCwcTWocqrW+s78BwVhwsxXNxqBrSNLAIvTU/SI/r0JjO4QmrkWfVM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Mon, 28 Jan 2019 21:39:50 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.007; Mon, 28 Jan 2019
 21:39:50 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Index: AdSzXEwehYqXUZ6BQmeL43zJlZYVRgD8FF6AAADrNfA=
Date:   Mon, 28 Jan 2019 21:39:50 +0000
Message-ID: <PU1P153MB0169CE6B02AE7D67E25DDD89BF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-28T21:39:48.5849395Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4f4b6e4-b5b6-4f1a-b12e-ad5bc8c41c18;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:e868:ce4c:61e9:a83a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0105;6:vDilnm73r1YluOTIFy/bjPS/txnmQZgLzqeDERSl4fiN1FTdasth4EdI7o2Yr3Tr97bSORGjLbjb14A04EkdvYlCK/QMIhKHUO1h6mFWgy+vQDaqmKGAHCxVLBiXF6+s+Ia2m/ggsyM8xQHMtqmFSrOO3HC0L4rXC+ek0YmFSfSCuRPrx3xr2EbJ4baBSgx5ofyiJXF/UsnYB5wzuASJZ5O6793JQGXrMwlNMG30fQ8444aX1KKo8S2aeayZ4RplVYEUHDKfl6WbQlB8/WD9T+mm7eu87bMDxinxjxmJJ7QndcWEoiZwYQ5/KdM0B3zOLHZow8xE+NPadOtyKvwExf80xx6HMRlf7LqewKaIPFWkEaLxkM/+xlgwvmlyhFksusfuf4VyWpSTG0f5YHkbiIl0CwrCx3h3CoTbTrnsmm2Hw/P5DTylqao3TGdu5nm57Kp1IAC2Ga+AigOSdPfjuQ==;5:e1gh5XfsRRV0FTn4BMjsM2MMzfHBJWDos6ZcI3DBCC/46uXWCwAKRSOecEAg37NvrqBWIIxb6ro083QMsWpO4gdHmM6P7//NFZc3b9oxk0GKbKDw0IvArJwCy9iAmPjSm7XjbTNw56NAupo8R7m7XGE+xxTgJ5uc6uvtWayYTDpb6XT/PbT9fvvv5nn0qfjgRsM0U7A9qgwUN9+mM3TdLw==;7:t0wdBGvhg9heqpGP9Nxj+VNQ5eznz5yWE55RpSKvKqZZz9d4BUKW8HcLEBKCXopA/RKqjhW9czUgasbiDKEZj0YUWxzKMt5KB0WpMI8hOn6iblOJCsB7fBpavi9sHrPho8+TEWaCfQUMx3KVKQAF+A==
x-ms-office365-filtering-correlation-id: a52a097a-9339-4505-df12-08d6856921f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600126)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0105;
x-ms-traffictypediagnostic: PU1P153MB0105:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB0105D0DB7F9780DCFD23FA2BBF960@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(396003)(346002)(51914003)(189003)(199004)(53936002)(186003)(486006)(446003)(33656002)(11346002)(476003)(14454004)(46003)(68736007)(7696005)(2906002)(25786009)(76176011)(8990500004)(6246003)(4326008)(10290500003)(478600001)(53546011)(6506007)(966005)(102836004)(6116002)(105586002)(14444005)(99286004)(8936002)(86362001)(7736002)(86612001)(305945005)(97736004)(81156014)(217873002)(6436002)(55016002)(316002)(7416002)(10090500001)(22452003)(54906003)(256004)(106356001)(71200400001)(71190400001)(6916009)(74316002)(229853002)(81166006)(8676002)(9686003)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uIKQHhkc3vgheycMtYB9zKODwrF6PJ9uZN98x30Q3WTYSk/RHpJPuXJaS4TrxSleQshcvZWCIa0Vt2xB1DfA06TAVDl+MZIsYugFeTbGcHP/EoVnFdBzk8r6LsoOVOONsJOCUoDwiwHLCot4BkROxW7GZGVvc8JUVexqP81hs9WVEj50vLCHnNSFLmrVx3+0P2D1Pm716j1NpGwohj7FXZg+zrT1eUebLy0gKNkbZb8sHfeAzvKzwOyfampgz0UjIWBPxRuZRFXAN8SWTQ273Yd6wTGhSE7vQNdV7HjsGHVU1OJLcsWZCBA5SemuOb9DYj2nqaHc5GTwlns4Xf1gC4djxxcqDzsKKWZkBGoaexwF67iYiMNRI/noXPE8MvBNqBv/XrWHtdWW4QYCHVdT7mFD5mcOc7ZP1zDN3fQHIlM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52a097a-9339-4505-df12-08d6856921f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 21:39:50.3043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDI4LCAyMDE5IDE6MDEgUE0NCj4gDQo+IEhpIERleHVhbiwNCj4gTG9v
a3MgZ29vZC4gSnVzdCBvbmUgdXBkYXRlIHJlcXVlc3QgYW5kIGEgbm90ZSBiZWxvdy4uLg0KPiAN
Cj4gT24gV2VkLCBKYW4gMjMsIDIwMTkgYXQgMTI6NTEgUE0gRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4gLi4uDQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQv
Y29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ID4gQEAgLTE4NDAs
NyArMTg0MCw3IEBAIHN0YXRpYyBpbnQgYWNwaV9uZml0X2FkZF9kaW1tKHN0cnVjdA0KPiBhY3Bp
X25maXRfZGVzYyAqYWNwaV9kZXNjLA0KPiA+ICAgICAgICAgZGV2X3NldF9kcnZkYXRhKCZhZGV2
X2RpbW0tPmRldiwgbmZpdF9tZW0pOw0KPiA+DQo+ID4gICAgICAgICAvKg0KPiA+IC0gICAgICAg
ICogVW50aWwgc3RhbmRhcmRpemF0aW9uIG1hdGVyaWFsaXplcyB3ZSBuZWVkIHRvIGNvbnNpZGVy
IDQNCj4gPiArICAgICAgICAqIFVudGlsIHN0YW5kYXJkaXphdGlvbiBtYXRlcmlhbGl6ZXMgd2Ug
bmVlZCB0byBjb25zaWRlciA1DQo+ID4gICAgICAgICAgKiBkaWZmZXJlbnQgY29tbWFuZCBzZXRz
LiAgTm90ZSwgdGhhdCBjaGVja2luZyBmb3IgZnVuY3Rpb24wDQo+IChiaXQwKQ0KPiA+ICAgICAg
ICAgICogdGVsbHMgdXMgaWYgYW55IGNvbW1hbmRzIGFyZSByZWFjaGFibGUgdGhyb3VnaCB0aGlz
IEdVSUQuDQo+ID4gICAgICAgICAgKi8NCj4gDQo+IFRoaXMgY29tbWVudCBpcyBzdGFsZS4gVGhp
cyAiSFlQRVJWIiBmYW1pbHkgaXMgdGhlIGZpcnN0IGV4YW1wbGUgb2YNCj4gdGhlICJyaWdodCIg
d2F5IHRvIGRlZmluZSBhIG5ldyBOVkRJTU0gY29tbWFuZCBzZXQuIExldHMgdXBkYXRlIGl0IHRv
DQo+IG1lbnRpb24gdGhlIHByb2Nlc3MgYW5kIGNvbnNpZGVyYXRpb25zIGZvciBzdWJtaXR0aW5n
IG5ldyBjb21tYW5kIHNldHMNCj4gdG8gVUVGSSAoaHR0cDovL3d3dy51ZWZpLm9yZy9SRklDX0xJ
U1QpLiBUaGUgZmFjdCB0aGF0IHRoZXJlJ3Mgbm93IGENCj4gZGVmaW5lZCBwcm9jZXNzIGlzIGEg
c3RlcCBmb3J3YXJkIGZyb20gd2hlbiB0aGlzIGNvbW1lbnQgd2FzIGluaXRpYWxseQ0KPiB3cml0
dGVuLiBBbHNvLCB0aGUgZmFjdCB0aGF0IHRoZSBwcm9jZXNzIGVuY291cmFnZXMgImFkb3B0IiB2
cw0KPiAic3VwZXJzZWRlIiBhZGRyZXNzZXMgdGhlIG1haW4gY29uY2VybiBhYm91dCB2ZW5kb3It
c3BlY2lmaWMNCj4gY29tbWFuZC1zZXQgcHJvbGlmZXJhdGlvbi4NCg0KSSBtYWRlIHRoZSBiZWxv
dyBzaW1wbGUgY2hhbmdlLiBJcyB0aGlzIGVub3VnaD8gUGxlYXNlIHN1Z2dlc3QgdGhlIHByb3Bl
cg0Kd29yZGluZy9zZW50ZW5jZSwgYXMgSSdtIHJlbGF0aXZlbHkgbmV3IHRvIE5WRElNTSwgYW5k
IEkgZG9uJ3QgcmVhbGx5IGtub3cgdGhlDQpoaXN0b3J5IG9mIHRoZSBzdGFuZGFyZGl6YXRpb24g
cHJvY2Vzcy4NCg0KLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQorKysgYi9kcml2ZXJz
L2FjcGkvbmZpdC9jb3JlLmMNCkBAIC0xNzMyLDggKzE3MzIsMTAgQEAgc3RhdGljIGludCBhY3Bp
X25maXRfYWRkX2RpbW0oc3RydWN0IGFjcGlfbmZpdF9kZXNjICphY3BpX2Rlc2MsDQogICAgICAg
IGRldl9zZXRfZHJ2ZGF0YSgmYWRldl9kaW1tLT5kZXYsIG5maXRfbWVtKTsNCg0KICAgICAgICAv
Kg0KLSAgICAgICAgKiBVbnRpbCBzdGFuZGFyZGl6YXRpb24gbWF0ZXJpYWxpemVzIHdlIG5lZWQg
dG8gY29uc2lkZXIgNA0KLSAgICAgICAgKiBkaWZmZXJlbnQgY29tbWFuZCBzZXRzLiAgTm90ZSwg
dGhhdCBjaGVja2luZyBmb3IgZnVuY3Rpb24wIChiaXQwKQ0KKyAgICAgICAgKiBOZXcgY29tbWFu
ZCBzZXRzIHNob3VsZCBiZSBzdWJtaXR0ZWQgdG8gVUVGSQ0KKyAgICAgICAgKiBodHRwOi8vd3d3
LnVlZmkub3JnL1JGSUNfTElTVC4NCisgICAgICAgICoNCisgICAgICAgICogTm90ZSwgdGhhdCBj
aGVja2luZyBmb3IgZnVuY3Rpb24wIChiaXQwKQ0KICAgICAgICAgKiB0ZWxscyB1cyBpZiBhbnkg
Y29tbWFuZHMgYXJlIHJlYWNoYWJsZSB0aHJvdWdoIHRoaXMgR1VJRC4NCiAgICAgICAgICovDQog
ICAgICAgIGZvciAoaSA9IDA7IGkgPD0gTlZESU1NX0ZBTUlMWV9NQVg7IGkrKykNCg0KIA0KPiA+
IEBAIC0xODY1LDYgKzE4NjUsOCBAQCBzdGF0aWMgaW50IGFjcGlfbmZpdF9hZGRfZGltbShzdHJ1
Y3QNCj4gYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYywNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBkc21fbWFzayAmPSB+KDEgPDwgOCk7DQo+ID4gICAgICAgICB9IGVsc2UgaWYgKG5maXRf
bWVtLT5mYW1pbHkgPT0gTlZESU1NX0ZBTUlMWV9NU0ZUKSB7DQo+ID4gICAgICAgICAgICAgICAg
IGRzbV9tYXNrID0gMHhmZmZmZmZmZjsNCj4gPiArICAgICAgIH0gZWxzZSBpZiAobmZpdF9tZW0t
PmZhbWlseSA9PSBOVkRJTU1fRkFNSUxZX0hZUEVSVikgew0KPiA+ICsgICAgICAgICAgICAgICBk
c21fbWFzayA9IDB4MWY7DQo+IA0KPiBKdXN0IGEgbm90ZSB0aGF0IHN0YXJ0aW5nIHdpdGggY29t
bWl0IDVlOWUzOGQwZGIxZCAiYWNwaS9uZml0OiBCbG9jaw0KPiBmdW5jdGlvbiB6ZXJvIERTTXMi
LCBiaXQwIGluIHRoaXMgbWFzayB3aWxsIGJlIGNsZWFyZWQgdG8gZW5zdXJlIHRoYXQNCj4gb25s
eSB0aGUga2VybmVsIGhhcyB0aGUgYWJpbGl0eSB0byBwcm9iZSBmb3Igc3VwcG9ydGVkIERTTSBm
dW5jdGlvbnMuDQoNClRoYW5rcyBmb3IgdGhlIG5vdGUhDQoNClRoYW5rcywNCi0tIERleHVhbg0K
