Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D0A2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Kvwi95Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfAHOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:07:45 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:63347 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfAHOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:07:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; 
   d="scan'208";a="25057062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 07:07:43 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 07:07:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skzF4QF0/3HriWd90RlrEVTek3ke+hpiqhZbrbbnVAU=;
 b=Kvwi95Sf0OR2ZuDP+1W53RiJUEu7mSvK4kJOdM58zKTOU8yD3t2lrrNnXfMfXg3K7jzmO+xoo+5p12gTSuy0O7uq5rRGu9FwJfvh37UynvgRgNft6yhALxODot8OkTxJTDCdMtLo1mLIyTi5RE2z9/0JSwsc26GmoSDUr0PSKGA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1520.namprd11.prod.outlook.com (10.172.54.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 14:07:35 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 14:07:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <rafael@kernel.org>
CC:     <len.brown@intel.com>, <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lgirdwood@gmail.com>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <pavel@ucw.cz>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
Thread-Topic: [PATCH v2 0/3] add support for power off check in suspend
Thread-Index: AQHUp0DMK00T01NVNECI4VrUGS1926WlQQqAgAAnaoA=
Date:   Tue, 8 Jan 2019 14:07:35 +0000
Message-ID: <c749ad04-1f95-1f8d-7fd8-93b228ace10c@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1520;6:62bc7W7NFwbeXDWy7ug+zpYNwyFQClqosW/PcXfk17zBOJXtvqAjdzKN5i953lTZQxRpZImCLYbLVxiYI7v0l8RsVPYivPUucXRmfZV99esYh6qweJuXveIqbDQHmK6QBQ54jj85g4g8XKJrYh4HN+Gcpsd146lHkaxO+peJp+xSgw1hRByxM800TzNonATQaz4KeqffvcXMLiaBClbazZGLKw6uwlrmHyyBduBEFIOQU4Irj1vEigKNniExGt/r5J2V9vB4RtWj7unGKcKKO1vT3fiJIUPnxo3Z+R+mjAr9CYSn5iOPUQkmadBJ6KjQnXzsArx2eIweywFw4YneDDQE8NzSIAawWOCxw0hEC6nWi0Gk/LGxK+1F55MczyNzWRR+1xZg4dciQoSBn0ORHBo/ouyo9aepdEkc5MO+zN7S/nlZGSsaoVLk2umuVKqQ3u/wABzWSjZ+ct66HpgdBA==;5:eTFmgVLBTSD2TosuzwojJCyopak1fYM/dNkn+NjswjxiTFqyuXyWe2MuGDJdhUJ7IhEkq7BN4+mykJixTDFZFY5WnG2ifuKYwDULTtTG8LbVgFSLkTY+hQwmc9OjleX4EJB2XRXLHn9JXsS83pFPFhirA/Mj3uL9HMvMtwuP5CweBcott5LrW+M+HnZ5UKiNwwPiqsVZi6RDART5DdhYBQ==;7:i5YArOSGZEak7++NJFlVZcy+axcH3dSikZ0+CUTFZ9YiUOy72lqu75FQQGouyZM0C1Vg/SUdhEU3aZOTs5Hd1YIcwAzVufzUIBTVYpUFUj6OVVRczgLSjWImABxX2vNvrKNzJIc921R6infLgElcZg==
x-ms-office365-filtering-correlation-id: 2bea0500-a0b3-41a8-3253-08d67572a3cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1520;
x-ms-traffictypediagnostic: MWHPR11MB1520:
x-microsoft-antispam-prvs: <MWHPR11MB15200B5AFD24090641B87B55878A0@MWHPR11MB1520.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(305945005)(186003)(316002)(7736002)(7416002)(105586002)(99286004)(106356001)(26005)(229853002)(6306002)(36756003)(86362001)(31686004)(6916009)(53936002)(102836004)(66066001)(31696002)(54906003)(6512007)(8936002)(2420400007)(15650500001)(97736004)(14444005)(256004)(966005)(39060400002)(25786009)(6116002)(8676002)(3846002)(72206003)(386003)(6506007)(53546011)(476003)(2616005)(478600001)(11346002)(2906002)(10710500007)(6246003)(14454004)(52116002)(4326008)(76176011)(71190400001)(71200400001)(68736007)(446003)(6486002)(5660300001)(81156014)(81166006)(6436002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1520;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFaFT7/7i0GrTF1N81/v+npyrm48zP4tRhaOjG56cXA8MCeiHjoFLjSlQ7smuxg5iy6F7CjbORonO9KTrALYfw/QdoBoWxodRwGxr3dQF+7i3QKNtJWEmDoxhS1lnSaD6XAc5xCi16XEXvFOjt6sG7YuBgOWbzX9FC/k2ckztg0gyTddQ03oJg36mX5SrupqzA+Wc16LVwl40q01WY6v3skx/8JOLwuUhsz+NCixUNYs2Izlbct9/5TgVvvLHJ9DhCvChWey8GnCipfjd7JXUKHPGxrplviJ1wDh4/aXGf50gefQhv+kUJDCmdvTljoB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABC9D277420DB4F8F8565D6707197FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea0500-a0b3-41a8-3253-08d67572a3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:07:35.6620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1520
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LjAxLjIwMTkgMTM6NDYsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBU
dWUsIEphbiA4LCAyMDE5IGF0IDExOjU2IEFNIDxDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4+DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCj4+DQo+PiBIaSwNCj4+DQo+PiBBVDkxIHBsYXRmb3JtcyBzdXBwb3J0IGEg
cG93ZXIgc2F2aW5nIG1vZGUgd2hlcmUgU29DJ3MgcG93ZXIgaXMgY3V0IG9mZiAod2UgY2FsbA0K
Pj4gaXQgYmFja3VwIG1vZGUpLiBUaGUgcmVzdW1lIGlzIGRvbmUgd2l0aCB0aGUgaGVscCBvZiBi
b290bG9hZGVycy4NCj4gDQo+IEJ1dCBzdGlsbCB0aGUgY29udGVudHMgb2YgUkFNIGFyZSBwcmVz
ZXJ2ZWQ/DQoNClllcywgdGhlIFJBTSBpcyBrZXB0IGFsaXZlLCBpbiBzZWxmLXJlZnJlc2ggKGZv
cmdvdCB0byBtZW50aW9uKS4NCkJlc2lkZXMgdGhpcywgdGhlcmUgaXMgdGhlIHNvIGNhbGxlZCBi
YWNrdXAgYXJlYSB3aGljaCBjb250YWlucyBSVEMNCnNodXRkb3duIGNvbnRyb2xsZXIsIFJDIG9z
Y2lsbGF0b3Igd2hpY2ggcmVtYWlucyBwb3dlcmVkLiBUaGUgcmVzdCBpcyBvZmYuDQoNCj4gDQo+
IFRoYXQgd291bGQgcmVxdWlyZSBhdCBsZWFzdCB0aGUgbWVtb3J5IGNvbnRyb2xsZXIgdG8gYmUg
dW5kZXIgcG93ZXIgQUZBSUNTLg0KDQpZZXMsIHRoaXMgaXMgcG93ZXJlZCBieSBhIGRpZmZlcmVu
dCByZWd1bGF0b3IuDQoNCj4gDQo+PiBUbyBiZSBhYmxlIHRvDQo+PiBzdXNwZW5kL3Jlc3VtZSBM
aW51eCB0by9mcm9tIHRoaXMgbW9kZSBhbGwgdGhlIGRyaXZlcnMgc3VzcGVuZC9yZXN1bWUgY2Fs
bGJhY2tzDQo+PiBzaG91bGQgc2F2ZS9yZXN0b3JlIHRoZSBjb250ZW50IG9mIGFsbCB0aGUgYWN0
aXZlIHJlZ2lzdGVycy4gV2UgaGF2ZSAyIHByb2JsZW1zDQo+PiB3ZSBhcmUgdHJ5aW5nIHRvIHNv
bHZlOg0KPj4gLSBzb21lIG9mIHRoZXNlIGRyaXZlcnMgYXJlIHNoYXJlZCB3aXRoIG90aGVyIG5v
biBNaWNyb2NoaXAgU29DcyAoZS5nLiBtYWNiDQo+PiAgIGRyaXZlcikgYW5kIHdlIGRvbid0IHdh
bnQgdG8gZGlzdHVyYmUgb3RoZXIgdXNlcnMgb2YgY29ycmVzcG9uZGluZyBJUHMgd2l0aA0KPj4g
ICBhbGwgdGhlIHJlZ2lzdGVyIHNhdmUvcmVzdG9yZSBvcGVyYXRpb25zOw0KPj4gLSB0aGUgc3Vz
cGVuZC9yZXN1bWUgdGltZSBmb3IgdGhlIHJlc3Qgb2YgdGhlIHBvd2VyIHNhdmluZyBtb2RlIHdl
IGFyZSB1c2luZw0KPj4gICBjb3VsZCBiZSBpbXByb3ZlZCBpZiB3ZSB3b3VsZCBrbm93IGluIGRy
aXZlcnMgdGhlIHN1c3BlbmQgbW9kZSB0aGUgcGxhdGZvcm0NCj4+ICAgaXMgc3dpdGNoZWQgdG8u
DQo+Pg0KPj4gQSBzb2x1dGlvbiB0aGF0IHdvdWxkIGhhdmUgYmVlbiBzb2x2ZSBvdXIgcHJvYmxl
bXMgd2FzIHByb3Bvc2VkIGluIFsxXSBidXQgaW4NCj4+IHRoZSBlbmQgaXQgd2Fzbid0IGFjY2Vw
dGVkLiBJdCBlbmRlZCB1cCB3aXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCj4+IHBtX3N1c3BlbmRf
dGFyZ2V0X3N0YXRlIHZhcmlhYmxlIHRoYXQgY291bGQgYmUgdXNlZCBhbG9uZyB3aXRoIHRoZSBj
aGFuZ2VzIGluDQo+PiB0aGlzIHNlcmllcy4NCj4+DQo+PiBXaGlsZSB0aGUgZGlzY3Vzc2lvbiBv
ZiBbMV0gcHJvZ3Jlc3NlZCBpdCBoYXMgYmVlbiBwcm9wb3NlZCAoaW4gWzJdKSB0bw0KPj4gaW1w
bGVtZW50IGEgZnVuY3Rpb24gdGhhdCB3b3VsZCB0ZWxsIGlmIHRoZSBwbGF0Zm9ybSdzIHBvd2Vy
IHdvdWxkIGJlIGN1dCBvZmYNCj4+IGF0IHRoZSBlbmQgb2YgdGhlIHN1c3BlbmQgcHJvY2VkdXJl
Lg0KPj4NCj4+IFRoZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGRvZXMgYXMgZm9sbG93czoNCj4+
IDEvMyAtIGFkZCBhIG5ldyBtZW1iZXIgdG8gcGxhdGZvcm1fc3VzcGVuZF9vcHMgdGhhdCB3aWxs
IHRlbGwgaWYgcGxhdGZvcm0ncw0KPj4gICAgICAgcG93ZXIgd2lsbCBiZSBjdXQgb2ZmIGF0IHRo
ZSBlbmQgb2YgdGhlIHN1c3BlbmQgcHJvY2VkdXJlOyBkcml2ZXJzIGNvdWxkDQo+PiAgICAgICB1
c2UgaXQgdmlhIHBsYXRmb3JtX29mZl9pbl9zdXNwZW5kKCkNCj4gDQo+IEkgd291bGQgcmF0aGVy
IGF2b2lkIGRvaW5nIHRoaXMgaWYgcG9zc2libGUuDQoNCkhhdmluZyB0aGlzIG1lY2hhbmlzbSBh
cyBwYXJ0IG9mIHBsYXRmb3JtX3N1c3BlbmRfb3BzPyBPciB0aGlzIG1lY2hhbmlzbSBhdA0KYWxs
Pw0KQ291bGQgeW91IGdpdmUgbWUgc29tZSBoaW50cyBvbiBob3cgd291bGQgeW91IHByZWZlciB0
byBkbyBpdCwgaWYgYW55Pw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiBU
aGFua3MsDQo+IFJhZmFlbA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiANCg==
