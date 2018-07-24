Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B3B20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="a1F/GVGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B3B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbeGXRg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:36:56 -0400
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:47458
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388324AbeGXRg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHGdin8Ltgwr3K6R21cEpvFAmdC8aViVLTbEPDEsefM=;
 b=a1F/GVGbnoNk43YgyNsOdmEVVVhOdGdEeUM7bRK9mycLJLjmfBoNL9UiZIJwd320Lx6NBb0HhGmgQHL0E0VBJsMzxcYO1+GUKTd8arf2dpvd11ijQ3lcw8h+lDc/aqFxcfYipJH8poa6yqzt0EtCQNDaoF/ocn/rjKkhzbG/dzY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4005.namprd05.prod.outlook.com (52.135.199.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.13; Tue, 24 Jul 2018 16:29:38 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333%6]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 16:29:38 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v6 9/9] x86: jump-labels: use macros instead of inline
 assembly
Thread-Topic: [PATCH v6 9/9] x86: jump-labels: use macros instead of inline
 assembly
Thread-Index: AQHUCk3kI9H4sIUm8Umh+TjbNRcx+aSeoBiAgAAiUQA=
Date:   Tue, 24 Jul 2018 16:29:38 +0000
Message-ID: <C70B32A3-B1AE-4609-9EEB-858C4F15ABD9@vmware.com>
References: <20180622172212.199633-1-namit@vmware.com>
 <20180622172212.199633-10-namit@vmware.com>
 <20180724142647.GA31700@gmail.com>
In-Reply-To: <20180724142647.GA31700@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.3.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4005;20:qFPZV1T4x4AqcvIUoWzrwf3SgmqXv1V+xB6zTu0EZqcA5M5TzSSNi0Y4dW6C4v0d8BAGFNRtXzSEujc7UPawSBORF6gOE2YRYI1LrNgnHhdbJjlo0b50JdtQp7vh30CTZTGm1x6e3SEeAWil+6vEqaaIMm55PiwuIKUKMUEGFJ4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5a686307-a265-4638-bdc7-08d5f182a6c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4005;
x-ms-traffictypediagnostic: BYAPR05MB4005:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB40050620162C837F91BD7824D0550@BYAPR05MB4005.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4005;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4005;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(189003)(199004)(81156014)(446003)(81166006)(11346002)(86362001)(82746002)(97736004)(83716003)(54906003)(2906002)(8676002)(5024004)(316002)(14444005)(6436002)(5250100002)(256004)(8936002)(186003)(4326008)(25786009)(305945005)(66066001)(2900100001)(2616005)(486006)(6246003)(102836004)(6506007)(6116002)(3846002)(68736007)(53936002)(76176011)(7736002)(476003)(14454004)(26005)(33656002)(6512007)(5660300001)(478600001)(105586002)(99286004)(6486002)(229853002)(106356001)(36756003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4005;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hp2Au3cRzPOhKQDsbsxr5YdN/8J1YnHylhpZo68DBrNrpYOkwwZs5dMqNSfeGr15D6xUAy8kAlkk2K+8Y//xeUQjLxOPiIMtYGV+FWc35AD976QKc/jJR8eIejfBZtSr7gcX9AulYkCozHHUrI0iAwgOMt+IsKBqG8Jd693qi3cSw5XveA1cOKjFTx+Ha8BzLpbWB9kJykz1D7GuJTuF+7BCap3AprLWLGOcjnXsJGhFxk5t6bNvwzrlGw1tCxEhYz2Jpe9PGPlTyII2p+67IfD4/VuujXCTvz7E1dnHaMSm26eEm8XvX1CrYJuZAA7KjwkC5ITuT/60sP5eeuTsddQi6mTbBhOEEN+KLQaaPcw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C28354E7124CDC46B81F750033543F11@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a686307-a265-4638-bdc7-08d5f182a6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 16:29:38.5918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNzoyNiBBTSwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IA0K
PiAqIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPiANCj4+IFVzZSBhc3Nl
bWJseSBtYWNyb3MgZm9yIGp1bXAtbGFiZWxzIGFuZCBjYWxsIHRoZW0gZnJvbSBpbmxpbmUgYXNz
ZW1ibHkuDQo+PiBUaGlzIG5vdCBvbmx5IG1ha2VzIHRoZSBjb2RlIG1vcmUgcmVhZGFibGUsIGJ1
dCBhbHNvIGltcHJvdmVzDQo+PiBjb21waWxhdGlvbiBkZWNpc2lvbiwgc3BlY2lmaWNhbGx5IGlu
bGluZSBkZWNpc2lvbnMgd2hpY2ggR0NDIGJhc2Ugb24NCj4+IHRoZSBudW1iZXIgb2YgbmV3IGxp
bmVzIGluIGlubGluZSBhc3NlbWJseS4NCj4+IA0KPj4gQXMgYSByZXN1bHQgdGhlIGNvZGUgc2l6
ZSBpcyBzbGlnaHRseSBpbmNyZWFzZWQuDQo+PiANCj4+ICAgdGV4dAkgICBkYXRhCSAgICBic3MJ
ICAgIGRlYwkgICAgaGV4CWZpbGVuYW1lDQo+PiAxODE2MzUyOCAxMDIyNjMwMCAyOTU3MzEyIDMx
MzQ3MTQwIDFkZTUxYzQgLi92bWxpbnV4IGJlZm9yZQ0KPj4gMTgxNjM2MDggMTAyMjczNDggMjk1
NzMxMiAzMTM0ODI2OCAxZGU1NjJjIC4vdm1saW51eCBhZnRlciAoKzExMjgpDQo+PiANCj4+IEFu
ZCBmdW5jdGlvbnMgc3VjaCBhcyBpbnRlbF9wc3RhdGVfYWRqdXN0X3BvbGljeV9tYXgoKSwNCj4+
IGt2bV9jcHVfYWNjZXB0X2RtX2ludHIoKSwga3ZtX3JlZ2lzdGVyX3JlYWRsKCkgYXJlIGlubGlu
ZWQuDQo+PiANCj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4+
IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4+IENjOiAiSC4gUGV0ZXIgQW52
aW4iIDxocGFAenl0b3IuY29tPg0KPj4gQ2M6IHg4NkBrZXJuZWwub3JnDQo+PiBDYzogR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+IENjOiBLYXRlIFN0
ZXdhcnQgPGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+PiBDYzogUGhpbGlwcGUgT21i
cmVkYW5uZSA8cG9tYnJlZGFubmVAbmV4Yi5jb20+DQo+PiBBY2tlZC1ieTogUGV0ZXIgWmlqbHN0
cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYWRh
diBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gLS0tDQo+PiBhcmNoL3g4Ni9lbnRyeS9jYWxs
aW5nLmggICAgICAgICAgfCAgMiArLQ0KPj4gYXJjaC94ODYvaW5jbHVkZS9hc20vanVtcF9sYWJl
bC5oIHwgNzcgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gYXJjaC94ODYva2Vy
bmVsL21hY3Jvcy5TICAgICAgICAgIHwgIDEgKw0KPj4gMyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4gDQo+IFNvIEkgdHJpZWQgdGhlIHNlcmllcywg
YW5kIHRoaXMgcGF0Y2ggY2F1c2VzIGEgc2lsZW50IGhhcmQgaGFuZyBvbiBib290dXAsIHdpdGgg
bm8gDQo+IChlYXJseS0pY29uc29sZSBtZXNzYWdlcyB2aXNpYmxlLg0KPiANCj4gSSd2ZSBhdHRh
Y2hlZCB0aGUgY29uZmlnIHRoYXQgdHJpZ2dlcnMgdGhlIHByb2JsZW0sIGJ1aWx0IHdpdGg6DQo+
IA0KPiAgZ2NjIHZlcnNpb24gNS4zLjEgMjAxNjA0MDYgKFJlZCBIYXQgNS4zLjEtNikgKEdDQykg
DQo+IA0KPiBpdCdzIDEwMCUgcmVwcm9kdWNpYmxlIG9uIGJvdGggSW50ZWwgYW5kIEFNRCB0ZXN0
IHN5c3RlbXMuDQo+IA0KPiBJJ2xsIGNvbnRpbnVlIHRvIHRlc3QgdGhlIHNlcmllcyB3aXRoIHRo
aXMgcGF0Y2ggbGVmdCBvdXQuDQo+IA0KPiBTbyBib3RoIHRoZSB4dGVuc2EgYnVpbGQgZmFpbHVy
ZSBhbmQgdGhpcyBib290IGZhaWx1cmUgbmVlZHMgdG8gYmUgZml4ZWQgYmVmb3JlIEkgDQo+IGNh
biBhcHBseSB0aGlzIHNlcmllcy4NCg0KSeKAmWxsIGxvb2sgaW50byB0aGVzZSBpc3N1ZXMsIGJ1
dCBJIGRvbuKAmXQgc2VlIHRoZSBjb25maWcgYXR0YWNoZWQuDQoNClRoYW5rcywNCk5hZGF2
