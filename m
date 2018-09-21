Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A71C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A62159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="anzGlHbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6A62159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbeIUVd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:33:57 -0400
Received: from mail-co1nam03on0043.outbound.protection.outlook.com ([104.47.40.43]:36736
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390086AbeIUVd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehkVZbwN4DHqylWQvoGtnk2Ud+pX78uy/rXxWPFrUf0=;
 b=anzGlHbHZZDfZHVBNk1J7V8njFvwgrpIJFc0tL8Sa8v+Exe0i07ut7Pd4gz7OaCBr1mzOWWT5ZqP3KI7CtC+zVqBKBhJq1BkCHaNZ8OCjFEIm5GPEkShvTL1YEF9EeqRHiBdvA2SiGjTPwIkcL3Mr1s0lqaipS7hVaBUCd8PV7s=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0909.namprd12.prod.outlook.com (10.164.27.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 15:44:22 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 15:44:21 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Topic: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Index: AQHUUGV5bSUg7rHX5kCrUgywYzutiqT5YAsAgAGDC4A=
Date:   Fri, 21 Sep 2018 15:44:21 +0000
Message-ID: <52076088-a97e-d43e-7a75-40059fc394da@amd.com>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
 <3609a852-1477-a5b2-3858-c2cbfb3999a9@amd.com>
In-Reply-To: <3609a852-1477-a5b2-3858-c2cbfb3999a9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:404:b4::22) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0909;20:1SLljrAKF07pFYFZ3/A4iODg8rVO3d0+5OwYFQnQ+PaAWAf1x999733bjZx1Rd05lBXVMD5F2ijfMga/FY6Y1DvFLif5RSXMajTclEkBsSNVGBor8olrgq+PPDgCXpeQ2wyg4MiXYydMS+aeXo/+PU7WMRgoUJHEs1NbEOr6XO/L610E+VeV60az4V2pGP49b+zXKyCKG53QMl+Pm6FypkF2TdJ8+B3msnjiNZbZR9HVt9k+hEaX479+UueKBgnB
x-ms-office365-filtering-correlation-id: ccb760f1-aa9e-434f-b10e-08d61fd91923
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0909;
x-ms-traffictypediagnostic: SN1PR12MB0909:
x-microsoft-antispam-prvs: <SN1PR12MB0909D687CE21C857C45A3202EC120@SN1PR12MB0909.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:SN1PR12MB0909;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0909;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(102836004)(26005)(3846002)(36756003)(6116002)(68736007)(99286004)(2906002)(6246003)(71200400001)(71190400001)(5250100002)(31686004)(105586002)(6506007)(386003)(97736004)(106356001)(8936002)(53546011)(52116002)(81166006)(81156014)(4326008)(76176011)(446003)(476003)(66066001)(11346002)(6436002)(2616005)(305945005)(14454004)(7736002)(486006)(256004)(14444005)(229853002)(8676002)(72206003)(478600001)(6486002)(316002)(86362001)(2900100001)(186003)(110136005)(25786009)(53936002)(7416002)(5660300001)(31696002)(6512007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0909;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zl/GMcaqdfbgMmJkf8FKOi7Yu6ZMoJKEGOTGLX8R9GZvbYIUhzHp1fd6O9Hnw036AvRAcPQ6DrSgvacIsWjtJTvlcU0R/im04xxdoEhBWTS/6NOd6tII644xTxNY1xwUJ6HKAx3hurEIJUomYmt26XVgJC3X5q9bqHMZp05CQtS2V0kGGXUIzOlVk0QFlcCkLU98E+NJNI617z82CdMHdG3ryEqMNqlr3iGvY3o+j92EFQedCz0r2FuRCvGwyo1QPR5IifLgQJtkET8o1DdU7pTlFV+7OQdSkE1HJ/rv4Aq51Kp4NtWFQ0VDgwLaivi9RAwqDoCWdeD3U+jLWX5zfkC+SINgKlQs9qZPoRYvKEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DA3697DBB8C654884B915BB58DD82E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb760f1-aa9e-434f-b10e-08d61fd91923
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 15:44:21.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjAvMjAxOCAwNDozOCBQTSwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4gT24gMDkv
MTkvMjAxOCAwNDozNSBQTSwgVGltIENoZW4gd3JvdGU6DQo+PiBUaGlzIHBhdGNoc2V0IHByb3Zp
ZGVzIGFuIG9wdGlvbiB0byBhcHBseSBJQlBCIGFuZCBTVElCUCBtaXRpZ2F0aW9uDQo+PiB0byBv
bmx5IG5vbi1kdW1wYWJsZSBwcm9jZXNzZXMuDQo+Pg0KPj4gSmlyaSdzIHBhdGNoIHRvIGhhcmRl
biBzcGVjdHJlX3YyIG1ha2VzIElCUEIgYW5kIFNUSUJQIGF2YWlsYWJsZSBmb3INCj4+IGdlbmVy
YWwgc3BlY3RyZSB2MiBhcHAgdG8gYXBwIG1pdGlnYXRpb24uICBJQlBCIHdpbGwgYmUgaXNzdWVk
IGZvcg0KPj4gc3dpdGNoaW5nIHRvIGFuIGFwcCB0aGF0J3Mgbm90IHB0cmFjZWFibGUgYnkgdGhl
IHByZXZpb3VzDQo+PiBhcHAgYW5kIFNUSUJQIHdpbGwgYmUgYWx3YXlzIHR1cm5lZCBvbi4NCj4+
DQo+PiBIb3dldmVyLCBsZWF2aW5nIFNUSUJQIG9uIGFsbCB0aGUgdGltZSBpcyBleHBlbnNpdmUg
Zm9yIGNlcnRhaW4NCj4+IGFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgZnJlcXVlbnQgaW5kaXJlY3Qg
YnJhbmNoZXMuIE9uZSBzdWNoIGFwcGxpY2F0aW9uDQo+PiBpcyBwZXJsYmVuY2ggaW4gdGhlIFNw
ZWNJbnQgUmF0ZSAyMDA2IHRlc3Qgc3VpdGUgd2hpY2ggc2hvd3MgYQ0KPj4gMjElIHJlZHVjdGlv
biBpbiB0aHJvdWdocHV0LiAgT3RoZXIgYXBwbGljYXRpb24gbGlrZSBiemlwMiBpbg0KPj4gdGhl
IHNhbWUgdGVzdCBzdWl0ZSB3aXRoICBtaW5pbWFsIGluZGlyY3QgYnJhbmNoZXMgaGF2ZQ0KPj4g
b25seSBhIDAuNyUgcmVkdWN0aW9uIGluIHRocm91Z2hwdXQuIElCUEIgd2lsbCBhbHNvIGltcG9z
ZQ0KPj4gb3ZlcmhlYWQgZHVyaW5nIGNvbnRleHQgc3dpdGNoZXMuDQo+Pg0KPj4gQXBwIHRvIGFw
cCBleHBsb2l0IGlzIGluIGdlbmVyYWwgZGlmZmljdWx0DQo+PiBkdWUgdG8gYWRkcmVzcyBzcGFj
ZSBsYXlvdXQgcmFuZG9taXphdGlvbiBpbiBhcHBzIGFuZA0KPj4gdGhlIG5lZWQgdG8ga25vdyBh
biBhcHAncyBhZGRyZXNzIHNwYWNlIGxheW91dCBhaGVhZCBvZiB0aW1lLg0KPj4gVXNlcnMgbWF5
IG5vdCB3aXNoIHRvIGluY3VyIGFwcCB0byBhcHAgcGVyZm9ybWFuY2UNCj4+IG92ZXJoZWFkIGZy
b20gSUJQQiBhbmQgU1RJQlAgZm9yIGdlbmVyYWwgbm9uIHNlY3VyaXR5IHNlbnNpdGl2ZSBhcHBz
DQo+PiBhbmQgdXNlIHRoZXNlIG1pdGlnYXRpb25zIG9ubHkgZm9yIG5vbi1kdW1wYWJsZSBhcHBz
Lg0KPj4NCj4+IFRoZSBmaXJzdCBwYXRjaCBwcm92aWRlcyBhIGxpdGUgb3B0aW9uIGZvciBzcGVj
dHJlX3YyIGFwcCB0byBhcHANCj4+IG1pdGlnYXRpb24gd2hlcmUgSUJQQiBpcyBvbmx5IGlzc3Vl
ZCBmb3Igc2VjdXJpdHkgc2Vuc2l0aXZlDQo+PiBub24tZHVtcGFibGUgYXBwLiAgVGhlIHNlY29u
ZCBwYXRjaCBleHRlbmRzIHRoaXMgb3B0aW9uDQo+PiB3aGVyZSBTVElCUCBpcyBvbmx5IGlzc3Vl
ZCBmb3Igbm9uLWR1bXBhYmxlIGFwcC4NCj4+DQo+PiBUaGUgY2hhbmdlcyBhcHBseSB0byBpbnRl
bCBjcHVzIGFmZmVjdGVkIGJ5IHNwZWN0cmVfdjIuIFRvbSwNCj4+IGNhbiB5b3UgdXBkYXRlIHRo
ZSBTVElCUCBjaGFuZ2VzIGZvciBBTUQgY3B1cyBvbiAgDQo+PiBfX3NwZWN1bGF0aXZlX3N0b3Jl
X2J5cGFzc191cGRhdGUgYW5kIHg4Nl92aXJ0X3NwZWNfY3RybA0KPj4gdG8gdXBkYXRlIHRoZSBT
UEVDX0NUUkwgbXNyIGZvciBBTUQgY3B1Pw0KPiANCj4gSGkgVGltLA0KPiANCj4gTGV0IG1lIHRo
aW5rIGFib3V0IHRoaXMgYSBiaXQsIHNpbmNlIGl0IGNhbiBnZXQgYSBiaXQgdHJpY2t5IGlmDQo+
IEkgd2FudCB0byBhdm9pZCBtdWx0aXBsZSBNU1Igd3JpdGVzIHdoZW4gb25seSBvbmUgbWF5IGhh
dmUgYmVlbg0KPiBuZWVkZWQgKGFzc3VtaW5nIFNTQkQgaXMgbm90IHVzaW5nIHRoZSBTUEVDX0NU
UkwgTVNSKS4NCg0KSSB0aGluayBzb21ldGhpbmcgYWxvbmcgdGhlIGxpbmVzIG9mIHRoZSBmb2xs
b3dpbmcgd291bGQgd29yayBhbmQNCnByZXZlbnQgYW55IGV4dHJhIE1TUiB3cml0ZXMgZm9yIEFN
RCB3aGVuIFNTQkQgaXMgbm90IHVzaW5nIHRoZQ0KU1BFQ19DVFJMIE1TUi4gTGV0IG1lIGtub3cg
d2hhdCB5b3UgdGhpbmsgKHRnbHgsIGVzcGVjaWFsbHksIHNpbmNlDQpoZSB3YXMgaGVhdmlseSBp
bnZvbHZlZCBpbiB0aGlzIHBhcnQpOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3By
b2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCmluZGV4IDg3ODMwMWQuLmQwOTNk
ODUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvcHJvY2Vzcy5jDQpAQCAtMzk3LDI2ICszOTcsNTkgQEAgc3RhdGljIF9fYWx3YXlz
X2lubGluZSB2b2lkIGFtZF9zZXRfc3NiX3ZpcnRfc3RhdGUodW5zaWduZWQgbG9uZyB0aWZuKQ0K
IA0KIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBpbnRlbF9zZXRfc3BlY19jdHJsX3N0YXRl
KHVuc2lnbmVkIGxvbmcgdGlmbikNCiB7DQotCXU2NCBtc3IgPSB4ODZfc3BlY19jdHJsX2Jhc2Ug
fCBzc2JkX3RpZl90b19zcGVjX2N0cmwodGlmbikNCi0JCQkJICAgICB8IHN0aWJwX3RpZl90b19z
cGVjX2N0cmwodGlmbik7DQorCXU2NCBtc3IgPSB4ODZfc3BlY19jdHJsX2Jhc2U7DQorDQorCS8q
DQorCSAqIEFNRCB3ZSBtYXkgaGF2ZSB1c2VkIGEgZGlmZmVyZW50IG1ldGhvZCB0byB1cGRhdGUg
U1NCRCwgc28NCisJICogd2UgbmVlZCB0byBiZSBzdXJlIHdlIGFyZSB1c2luZyB0aGUgU1BFQ19D
VFJMIE1TUiBmb3IgU1NCRC4NCisJICovDQorCWlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVS
RV9TU0JEKSkNCisJCXg4Nl9zcGVjX2N0cmxfYmFzZSB8PSBzc2JkX3RpZl90b19zcGVjX2N0cmwo
dGlmbik7DQorDQorCXg4Nl9zcGVjX2N0cmxfYmFzZSB8PSBzdGlicF90aWZfdG9fc3BlY19jdHJs
KHRpZm4pOw0KIA0KIAl3cm1zcmwoTVNSX0lBMzJfU1BFQ19DVFJMLCBtc3IpOw0KIH0NCiANCi1z
dGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBk
YXRlKHVuc2lnbmVkIGxvbmcgdGlmbikNCitzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgX19z
cGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBkYXRlKHVuc2lnbmVkIGxvbmcgdGlmcCwNCisJCQkJ
CQkJICAgICAgdW5zaWduZWQgbG9uZyB0aWZuKQ0KIHsNCi0JaWYgKHN0YXRpY19jcHVfaGFzKFg4
Nl9GRUFUVVJFX1ZJUlRfU1NCRCkpDQotCQlhbWRfc2V0X3NzYl92aXJ0X3N0YXRlKHRpZm4pOw0K
LQllbHNlIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9MU19DRkdfU1NCRCkpDQotCQlh
bWRfc2V0X2NvcmVfc3NiX3N0YXRlKHRpZm4pOw0KLQllbHNlDQotCQlpbnRlbF9zZXRfc3BlY19j
dHJsX3N0YXRlKHRpZm4pOw0KKwlib29sIHN0aWJwID0gISEoKHRpZnAgXiB0aWZuKSAmIF9USUZf
U1RJQlApOw0KKwlib29sIHNzYmQgPSAhISgodGlmcCBeIHRpZm4pICYgX1RJRl9TU0JEKTsNCisN
CisJaWYgKCFzc2JkICYmICFzdGlicCkNCisJCXJldHVybjsNCisNCisJaWYgKHNzYmQpIHsNCisJ
CS8qDQorCQkgKiBGb3IgQU1ELCB0cnkgdGhlc2UgbWV0aG9kcyBmaXJzdC4gIFRoZSBzc2JkIHZh
cmlhYmxlIHdpbGwNCisJCSAqIHJlZmxlY3QgaWYgdGhlIFNQRUNfQ1RSTCBNU1IgbWV0aG9kIGlz
IG5lZWRlZC4NCisJCSAqLw0KKwkJc3NiZCA9IGZhbHNlOw0KKw0KKwkJaWYgKHN0YXRpY19jcHVf
aGFzKFg4Nl9GRUFUVVJFX1ZJUlRfU1NCRCkpDQorCQkJYW1kX3NldF9zc2JfdmlydF9zdGF0ZSh0
aWZuKTsNCisJCWVsc2UgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0xTX0NGR19TU0JE
KSkNCisJCQlhbWRfc2V0X2NvcmVfc3NiX3N0YXRlKHRpZm4pOw0KKwkJZWxzZQ0KKwkJCXNzYmQg
PSB0cnVlOw0KKwl9DQorDQorCS8qIEF2b2lkIGEgcG9zc2libGUgZXh0cmEgTVNSIHdyaXRlLCBy
ZWNoZWNrIHRoZSBmbGFncyAqLw0KKwlpZiAoIXNzYmQgJiYgIXN0aWJwKQ0KKwkJcmV0dXJuOw0K
Kw0KKwlpbnRlbF9zZXRfc3BlY19jdHJsX3N0YXRlKHRpZm4pOw0KIH0NCiANCiB2b2lkIHNwZWN1
bGF0aXZlX3N0b3JlX2J5cGFzc191cGRhdGUodW5zaWduZWQgbG9uZyB0aWYpDQogew0KKwkvKg0K
KwkgKiBPbiB0aGlzIHBhdGggd2UncmUgZm9yY2luZyB0aGUgdXBkYXRlLCBzbyB1c2UgfnRpZiBh
cyB0aGUNCisJICogcHJldmlvdXMgZmxhZ3MuDQorCSAqLw0KIAlwcmVlbXB0X2Rpc2FibGUoKTsN
Ci0JX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBkYXRlKHRpZik7DQorCV9fc3BlY3VsYXRp
dmVfc3RvcmVfYnlwYXNzX3VwZGF0ZSh+dGlmLCB0aWYpOw0KIAlwcmVlbXB0X2VuYWJsZSgpOw0K
IH0NCiANCkBAIC00NTIsOCArNDg1LDcgQEAgdm9pZCBfX3N3aXRjaF90b194dHJhKHN0cnVjdCB0
YXNrX3N0cnVjdCAqcHJldl9wLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHRfcCwNCiAJaWYgKCh0
aWZwIF4gdGlmbikgJiBfVElGX05PQ1BVSUQpDQogCQlzZXRfY3B1aWRfZmF1bHRpbmcoISEodGlm
biAmIF9USUZfTk9DUFVJRCkpOw0KIA0KLQlpZiAoKHRpZnAgXiB0aWZuKSAmIChfVElGX1NTQkQg
fCBfVElGX1NUSUJQKSkNCi0JCV9fc3BlY3VsYXRpdmVfc3RvcmVfYnlwYXNzX3VwZGF0ZSh0aWZu
KTsNCisJX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBkYXRlKHRpZnAsIHRpZm4pOw0KIH0N
CiANCiAvKg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gVGhhbmtzLA0KPiBUb20NCj4gDQo+Pg0K
Pj4gVGhhbmtzLg0KPj4NCj4+IFRpbQ0KPj4NCj4+IFRpbSBDaGVuICgyKToNCj4+ICAgeDg2L3Nw
ZWN1bGF0aW9uOiBPcHRpb24gdG8gc2VsZWN0IGFwcCB0byBhcHAgbWl0aWdhdGlvbiBmb3Igc3Bl
Y3RyZV92Mg0KPj4gICB4ODYvc3BlY3VsYXRpb246IFByb3ZpZGUgYXBwbGljYXRpb24gcHJvcGVy
dHkgYmFzZWQgU1RJQlAgcHJvdGVjdGlvbg0KPj4NCj4+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICAxMSArKysNCj4+ICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9tc3ItaW5kZXguaCAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPj4gIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL25vc3BlYy1icmFuY2guaCAgICAgICAgICAgIHwgICA5ICsrDQo+PiAgYXJjaC94
ODYvaW5jbHVkZS9hc20vc3BlYy1jdHJsLmggICAgICAgICAgICAgICAgfCAgMTIgKysrDQo+PiAg
YXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaCAgICAgICAgICAgICAgfCAgIDQgKy0N
Cj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyAgICAgICAgICAgICAgICAgICAgICB8IDEw
NSArKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5j
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQ0KPj4gIGFyY2gveDg2L21tL3RsYi5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQxICsrKysrKysrLQ0KPj4gIDggZmlsZXMg
Y2hhbmdlZCwgMTc5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCg==
