Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA9C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EACF21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ArvH6x9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfA1Ju3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:50:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:17906 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1Ju2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:50:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="26000825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jan 2019 02:50:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 28 Jan 2019 02:50:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCNGsme7gBtFuFuB905T1siPVp34hXJnbrx1Od0T23w=;
 b=ArvH6x9Xxbzf54otwBKYdpbjiVb5D8qZhhz8dccVDQ/27S0GI7MR30aqUT1imMN6PXabo2thfLJAycYYiJRm3wmTfu4LmbTLdvgqLeWA4L4+e+uPIyqAPHw9HO9Lunf4WWsXT5VluO64Z+ozEfYXYeCpmhb3ixtWqj889Rwa224=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2013.namprd11.prod.outlook.com (10.169.234.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 09:50:23 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 09:50:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
Thread-Topic: [PATCH v2 0/3] add support for power off check in suspend
Thread-Index: AQHUp0DMK00T01NVNECI4VrUGS1926XEjziA
Date:   Mon, 28 Jan 2019 09:50:23 +0000
Message-ID: <5f0cf9d1-9a6a-4c97-8f56-6c5ae8af1564@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0026.eurprd05.prod.outlook.com
 (2603:10a6:803:1::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190128115013432
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2013;6:/cekhKRKPs4m0V/5yuUdfwcieKK4LvnwWq09JdQO/fqWOznaCSpz0cM++20eXe54SXriTTimN3hJQYI50JX2/UOB9OwlOnb+2Zauff7uVODV+pyGEkd9G6tGI67svDCEOC+3BGorIyJi+WQ9mOOQMcy6jxWSZ8vLxXaqAsvf90WxrlrqsQEaCGG+HJy5IvGuJNjhMD4PeC5J4SasVqcAlIqJ80bDulyCNTy12Zkj2bZjY/RFKLi3mDUTv4ogQlEEVHEq8SGM9nAjefWUxsMf8iab10ZWZ92j53F2AqMeKvQVoe9veAvdXXY3dtdPNUhJrVq3r0VuMFQz0nOeSATDpAwxrtZBbuxrutRDOth+sRaglhNt7RQFrRKcANQX6+4QkvueWI5i06Le67WdKrlqrBHjCnoy8kFuY72pt6h7tsoqDM3M2QM7dXhmTBaReEabzlx3Ko4uB4PEFA/NEdYZAA==;5:0gUwW5K3H6DF0+tBsDpabcO6QFi/nYuFRVXtdPdPc8fPxA6PABlua1JJNXu2n9lcj5AXbDZ/U1pp5ep4mY5F1u1OhyuRkc8lAitX7iWWjcmcL5FS6Zq1Ln5Wq/0jdqH266SOhkdeI1UG1pS4EBnIDY6trbrXRsPmOWbJ7SQZLOZbCa4wBDQg0W9aQrifi6iXblW0hkF0Zmoid1S6sgPM4g==;7:zcHMR+hNMeTJscQzLmtrll05adpHLaLjYsC/lKrAoJwwwUlQyA7lswOLrZ+UcfJisg5TP2OcquT3o1G1soBZ6I7n3MxOOTQn6j+0/l3c8YH+AjfSt7nc2NV6KSLGaGWc1XFGJUKAOWHirRUb40omKQ==
x-ms-office365-filtering-correlation-id: 7a0050bb-adaa-4354-3c08-08d6850605d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2013;
x-ms-traffictypediagnostic: MWHPR11MB2013:
x-microsoft-antispam-prvs: <MWHPR11MB20130D769F0D788CAC77C2DF87960@MWHPR11MB2013.namprd11.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(105586002)(316002)(14444005)(966005)(72206003)(31686004)(14454004)(478600001)(66066001)(97736004)(110136005)(2906002)(15650500001)(256004)(54906003)(81156014)(71190400001)(8676002)(106356001)(81166006)(71200400001)(7416002)(8936002)(229853002)(486006)(446003)(476003)(2616005)(11346002)(386003)(6506007)(53546011)(102836004)(76176011)(52116002)(26005)(39060400002)(99286004)(6246003)(6306002)(6486002)(6436002)(3846002)(6116002)(36756003)(6512007)(53936002)(305945005)(31696002)(86362001)(68736007)(25786009)(186003)(2201001)(2501003)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2013;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sYmOLev/DEFnBmwkhsfHny3S6ssGDk30dAitod+jWDkzoU50qCzwjetKVBe3aiXa+vRsIEDk9U8ASf4+naBthzVX7crgRWL7T5dlJCG2jA0pKNA8tTohZMQUGc1SvcHMOpbzOtFMnSVjhxMTocGmScKQ9N13fXISqobkoZ9DDCDkFbZzZApQ6ck1NKaXeJhef8ubqngkde+YNhir2QUIAXkbaQ9XKXZeDYnMrAoGo7Hso0PxmB3eFf6DG354+5CwGgFOdlKfBC38Yw0tajM881P7kV6eD24zCWiHbLUuQ9t5Py9IHwXgd/EHpaAiEIiWaxvkzBv4C2ovqT52j6pIIVJp3XU6ZXc5BZUmzJkh6sk17GqLVbk8bT8ZNEiuAe9aPgQtBkAGNJrbzkn18S9xbt22SRvrUJMKw345vEnh9QM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F04E4E280C7C1419279A256779218F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0050bb-adaa-4354-3c08-08d6850605d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 09:50:19.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2013
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF2ZWwsIFJhZmFlbCwNCg0KRG8geW91IGhhdmUgc29tZSBvdGhlciBoaW50cyBJIGNvdWxk
IGZvbGxvdyBpbiBvcmRlciB0byBzb2x2ZSB0aGUNCnNjZW5hcmlvIEkgdHJpZWQgdG8gY292ZXIg
d2l0aCB0aGVzZSBwYXRjaGVzLCBpZiB0aGVzZSBhcmUgbm90DQphIHByb3BlciBmaXQgZm9yIHRo
ZSBjdXJyZW50IGNvZGU/DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCk9uIDA4LjAx
LjIwMTkgMTI6NTYsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEhpLA0KPiAN
Cj4gQVQ5MSBwbGF0Zm9ybXMgc3VwcG9ydCBhIHBvd2VyIHNhdmluZyBtb2RlIHdoZXJlIFNvQydz
IHBvd2VyIGlzIGN1dCBvZmYgKHdlIGNhbGwNCj4gaXQgYmFja3VwIG1vZGUpLiBUaGUgcmVzdW1l
IGlzIGRvbmUgd2l0aCB0aGUgaGVscCBvZiBib290bG9hZGVycy4gVG8gYmUgYWJsZSB0bw0KPiBz
dXNwZW5kL3Jlc3VtZSBMaW51eCB0by9mcm9tIHRoaXMgbW9kZSBhbGwgdGhlIGRyaXZlcnMgc3Vz
cGVuZC9yZXN1bWUgY2FsbGJhY2tzDQo+IHNob3VsZCBzYXZlL3Jlc3RvcmUgdGhlIGNvbnRlbnQg
b2YgYWxsIHRoZSBhY3RpdmUgcmVnaXN0ZXJzLiBXZSBoYXZlIDIgcHJvYmxlbXMNCj4gd2UgYXJl
IHRyeWluZyB0byBzb2x2ZToNCj4gLSBzb21lIG9mIHRoZXNlIGRyaXZlcnMgYXJlIHNoYXJlZCB3
aXRoIG90aGVyIG5vbiBNaWNyb2NoaXAgU29DcyAoZS5nLiBtYWNiDQo+ICAgZHJpdmVyKSBhbmQg
d2UgZG9uJ3Qgd2FudCB0byBkaXN0dXJiZSBvdGhlciB1c2VycyBvZiBjb3JyZXNwb25kaW5nIElQ
cyB3aXRoDQo+ICAgYWxsIHRoZSByZWdpc3RlciBzYXZlL3Jlc3RvcmUgb3BlcmF0aW9uczsNCj4g
LSB0aGUgc3VzcGVuZC9yZXN1bWUgdGltZSBmb3IgdGhlIHJlc3Qgb2YgdGhlIHBvd2VyIHNhdmlu
ZyBtb2RlIHdlIGFyZSB1c2luZw0KPiAgIGNvdWxkIGJlIGltcHJvdmVkIGlmIHdlIHdvdWxkIGtu
b3cgaW4gZHJpdmVycyB0aGUgc3VzcGVuZCBtb2RlIHRoZSBwbGF0Zm9ybQ0KPiAgIGlzIHN3aXRj
aGVkIHRvLg0KPiANCj4gQSBzb2x1dGlvbiB0aGF0IHdvdWxkIGhhdmUgYmVlbiBzb2x2ZSBvdXIg
cHJvYmxlbXMgd2FzIHByb3Bvc2VkIGluIFsxXSBidXQgaW4NCj4gdGhlIGVuZCBpdCB3YXNuJ3Qg
YWNjZXB0ZWQuIEl0IGVuZGVkIHVwIHdpdGggdGhlIGludHJvZHVjdGlvbiBvZg0KPiBwbV9zdXNw
ZW5kX3RhcmdldF9zdGF0ZSB2YXJpYWJsZSB0aGF0IGNvdWxkIGJlIHVzZWQgYWxvbmcgd2l0aCB0
aGUgY2hhbmdlcyBpbg0KPiB0aGlzIHNlcmllcy4NCj4gDQo+IFdoaWxlIHRoZSBkaXNjdXNzaW9u
IG9mIFsxXSBwcm9ncmVzc2VkIGl0IGhhcyBiZWVuIHByb3Bvc2VkIChpbiBbMl0pIHRvDQo+IGlt
cGxlbWVudCBhIGZ1bmN0aW9uIHRoYXQgd291bGQgdGVsbCBpZiB0aGUgcGxhdGZvcm0ncyBwb3dl
ciB3b3VsZCBiZSBjdXQgb2ZmDQo+IGF0IHRoZSBlbmQgb2YgdGhlIHN1c3BlbmQgcHJvY2VkdXJl
Lg0KPiANCj4gVGhlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgZG9lcyBhcyBmb2xsb3dzOg0KPiAx
LzMgLSBhZGQgYSBuZXcgbWVtYmVyIHRvIHBsYXRmb3JtX3N1c3BlbmRfb3BzIHRoYXQgd2lsbCB0
ZWxsIGlmIHBsYXRmb3JtJ3MNCj4gICAgICAgcG93ZXIgd2lsbCBiZSBjdXQgb2ZmIGF0IHRoZSBl
bmQgb2YgdGhlIHN1c3BlbmQgcHJvY2VkdXJlOyBkcml2ZXJzIGNvdWxkDQo+ICAgICAgIHVzZSBp
dCB2aWEgcGxhdGZvcm1fb2ZmX2luX3N1c3BlbmQoKQ0KPiAyLzMgLSBhZGQgYSBuZXcgZnVuY3Rp
b24gdG8gcmVndWxhdG9yJ3MgY29yZSB0aGF0IGNvdWxkIGJlIHVzZWQgdG8gY2hlY2sgaWYgYQ0K
PiAgICAgICBwcm9wZXIgcmVndWxhdG9yIGhhcyBiZWVuIGNvbmZpZ3VyZWQgKHZpYSBEVCkgdG8g
YmUgcG93ZXJlZCBvZmYgaW4NCj4gICAgICAgc3VzcGVuZC4gVGhpcyBpcyB1c2VkIG9uIHRoaXMg
c2VyaWVzIHRvIGNoZWNrIHRoZSBDUFUncyByZWd1bGF0b3IgaXMNCj4gICAgICAgcHJvcGVybHkg
Y29uZmlndXJlZCBpbiBEVCB0byBiZSB0dXJuZWQgb2ZmIGluIHN1c3BlbmQuDQo+IDMvMyAtIGZp
bGwgLm9mZl9pbl9zdXNwZW5kIG1lbWJlciBvZiBhdDkxX3BtX29wczsgdGhlIGZ1bmN0aW9uYWxp
dHkgaW4gcGF0Y2ggMi8zDQo+ICAgICAgIGlzIHVzZWQgdG8gZG91YmxlIGNoZWNrIENQVSdzIHJl
Z3VsYXRvciB3b3VsZCBiZSB0dXJuZWQgb2ZmIGluIHN1c3BlbmQuDQo+IA0KPiBUaGFuayB5b3Us
DQo+IENsYXVkaXUgQmV6bmVhDQo+IA0KPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcv
Ni8yMi85MzgNCj4gWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3LzcvMTYvNDU3DQo+IA0K
PiBDaGFuZ2VzIGluIHYyOg0KPiAtIHJlbW92ZSAhISBpbnN0cnVjdGlvbiBpbiByZWd1bGF0b3Jf
aXNfZGlzYWJsZWRfaW5fc3VzcGVuZCgpIGFuZA0KPiAgIGF0OTFfcG1fc3RhdGVfYWxsb3dlZCgp
DQo+IC0gcy93ZWF0aGVyL3dldGhlciBpbiBwYXRjaCAxLzENCj4gDQo+IENsYXVkaXUgQmV6bmVh
ICgzKToNCj4gICBQTSAvIFN1c3BlbmQ6IEFkZCBzdXBwb3J0IHRvIGNoZWNrIGlmIHBsYXRmb3Jt
J3MgcG93ZXIgaXMgb2ZmIGluDQo+ICAgICBzdXNwZW5kDQo+ICAgcmVndWxhdG9yOiBjb3JlOiBh
ZGQgaGVscGVyIHRvIGNoZWNrIGlmIHJlZ3VsYXRvciBpcyBkaXNhYmxlZCBpbg0KPiAgICAgc3Vz
cGVuZA0KPiAgIEFSTTogYXQ5MTogcG06IGFkZCBzdXBwb3J0IGZvciAub2ZmX2luX3N1c3BlbmQN
Cj4gDQo+ICBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYyAgICAgICAgICAgIHwgNjEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gIGRyaXZlcnMvcmVndWxhdG9yL2NvcmUu
YyAgICAgICAgICAgfCAxNyArKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9yZWd1bGF0b3Iv
Y29uc3VtZXIuaCB8ICA3ICsrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3N1c3BlbmQuaCAgICAgICAg
ICAgIHwgIDYgKysrKw0KPiAga2VybmVsL3Bvd2VyL3N1c3BlbmQuYyAgICAgICAgICAgICB8IDEz
ICsrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCg==
