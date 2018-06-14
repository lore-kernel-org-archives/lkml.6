Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 520A2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA82208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="muIzLrpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA82208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755362AbeFNPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:05:01 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:56528
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755158AbeFNPE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmjIje1B75QTfN4z/g7iEQCfs5Th0QaytB3QZVnvNn8=;
 b=muIzLrpXF5w4QGm+4V8XS2f3bthM+H6/opN+yjoynJjy7AQsr3Qwb+7Fkp11ZwPj31B5PtKIVtWdM9LH0lbG6mO2lm2e7ZxWFllR/8pKOO5VpGFqayaYUfioA19LvGBsqgsB+LkY5blqdylpLApRPhfhZfF/y6HBQFdSG9K+1J8=
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com (10.175.33.150) by
 HE1PR0802MB2490.eurprd08.prod.outlook.com (10.175.31.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Thu, 14 Jun 2018 15:04:53 +0000
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686]) by HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686%8]) with mapi id 15.20.0841.021; Thu, 14 Jun 2018
 15:04:53 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Topic: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Index: AQHT+arYmPkMSE9u6k6dSv01/4gsi6RdKfkAgADZT4CAADNm5YAADK2AgAAaNZCAACEuAIAAKpaAgAAJWGCAANRmAIAAVXCAgAAKm/A=
Date:   Thu, 14 Jun 2018 15:04:52 +0000
Message-ID: <HE1PR0802MB241249AB5A90012AA6EB5235EE7D0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
 <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0802MB2490;7:o+xoVln+6iIjocc012KsbMU2xFtD1hefYATW0cYbSzn3F3QQJmXdcqKr0k7ZvRLW8pahOz/Bb9L30iPUvg35zopu8Jd2ARludJenUPgVF1ghM9EL2FrfrIDjHnZwiPHToxVZGh8fBUmKNeB6o10D8uYVZ242fN4s/VG4M0Ygvxu0apR5KybTWMEd6ikKpW3QmKAp4S/oVUp1HGCXVpFJIXG5JP9YSASzhpaj+eCjSdUGoxfJDgUO4KCJiycN8JyS
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc3bde40-3d67-4be0-e49f-08d5d2082eed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2490;
x-ms-traffictypediagnostic: HE1PR0802MB2490:
x-microsoft-antispam-prvs: <HE1PR0802MB24907724CCE4A5DCA085704BEE7D0@HE1PR0802MB2490.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0802MB2490;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2490;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(199004)(189003)(40434004)(25786009)(229853002)(99286004)(478600001)(66066001)(186003)(9686003)(6436002)(72206003)(53936002)(5660300001)(33656002)(105586002)(110136005)(55016002)(4326008)(54906003)(6246003)(6506007)(7696005)(2900100001)(102836004)(316002)(59450400001)(106356001)(39060400002)(86362001)(68736007)(74316002)(446003)(3280700002)(5250100002)(81166006)(97736004)(81156014)(5890100001)(3660700001)(8676002)(6116002)(8936002)(3846002)(2906002)(11346002)(476003)(14454004)(305945005)(486006)(26005)(6636002)(7736002)(93886005)(76176011)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2490;H:HE1PR0802MB2412.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jVNAElTgQMjeNyeHFluufnHgsz814Xo9FKSNnPQvSWebCoVMQTZMJXb3yd/fke323QNowWhBmCBmDcjtkDZ2iGB3hKKOXNYNZr1OeCllCQaRJyohjSOGiYa/f9twdQ95XwBX3fXdBfM3ljqIsDlsyCATbDVhqn5X+tgfyDOm47nLeuAHCpJU5dG9Ovmc9Pwd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3bde40-3d67-4be0-e49f-08d5d2082eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 15:04:52.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUbyB0YWtlIHRoaXMgaW4gYSBzb21ld2hhdCBkaWZmZXJlbnQgZGlyZWN0aW9u
Li4uDQoNCj4gPiBObywgdGhlIGFib3ZlIGNvbW1lbnQgaXMgYWJvdXQgdXNpbmcgInVuaXQiICgg
aWYgaXQgaXMgYSBzdGFuZGFyZA0KPiA+IHByb3BlcnR5IGZvciBzcGVjaWZ5aW5nIHNvbWV0aGlu
ZyBzcGVjaWZpYyB0byBoYXJkd2FyZSkgaW5zdGVhZCBvZg0KPiA+ICJjb3Jlc2lnaHQsaHdpZCIu
IEkgd291bGQgcHJlZmVyIHRvIHN0aWNrIHRvIHRoZSBEVCBncmFwaCBiaW5kaW5ncywNCj4gPiBi
ZWNhdXNlIDoNCj4NCj4gInVuaXQiIGlzIG5vdCBhIHN0YW5kYXJkIHByb3BlcnR5IGFuZCBJIGRv
bid0IGxpa2UgaXQgZWl0aGVyLg0KDQpGYWlyIGVub3VnaC4NCg0KPiBJZiB5b3UgaGF2ZSAiaW4t
cG9ydHMiIGFuZCAib3V0LXBvcnRzIiBub2RlcywgdGhlbiB0aGF0IGdpdmVzIHlvdQ0KPiBkaXJl
Y3Rpb24gYW5kIHlvdSBjYW4gdXNlIHJlZyBmb3IgdGhlICJoYXJkd2FyZSBwb3J0Ii4NCj4NCj4g
aW4tcG9ydHMgew0KPiAgIHBvcnRAMCB7DQo+ICAgICByZWcgPSA8MD47DQo+ICAgICBlbmRwb2lu
dCB7Li4ufTsNCj4gICB9Ow0KPiAgIHBvcnRAMSB7DQo+ICAgICByZWcgPSA8MT47DQo+ICAgICBl
bmRwb2ludCB7Li4ufTsNCj4gICB9Ow0KPiB9Ow0KPiBvdXQtcG9ydHMgew0KPiAgIHBvcnRAMCB7
DQo+ICAgICByZWcgPSA8MD47DQo+ICAgICBlbmRwb2ludCB7Li4ufTsNCj4gICB9Ow0KPiB9Ow0K
Pg0KPiBJJ2xsIG5lZWQgdG8gY2hlY2ssIGJ1dCBkdGMgbWF5IG5lZWQgYW4gdXBkYXRlIHRvIG5v
dCB3YXJuIGFib3V0IHRoaXMuDQoNCklmIHRoZSByZXF1aXJlbWVudCB0aGF0IHVuaXQtYWRkcmVz
cyBhbmQgdGhlIGxvdyAjYWRkcmVzcy1jZWxscyBvZiByZWcNCm5vdyBiZWluZyBmb3JjZWQgYnkg
YSB2YWxpZGF0aW9uIHRvb2wgaXMgc2NyZXdpbmcgdXMgb3ZlciBoZXJlLCB3ZSBjYW4ndA0KcmVh
bGx5IGNoYW5nZSB0aGUgdG9vbDsgdGhhdCdzIGEgSUVFRSAxMjc1LTE5OTQgcmVxdWlyZW1lbnQg
d2UnZCBiZQ0KaGFja2luZyBhcm91bmQuDQoNCkhlcmUncyBhIHRob3VnaHQgLSB3aHkgZG9uJ3Qg
d2UgZGVmaW5lIHRoZSBwb3J0cyBpbiBlYWNoIGNvbXBvbmVudCBpbiBhDQpzZXBhcmF0ZSBncmFw
aD8gRGVzY3JpYmluZyB0aGUgQVRCIHRvcG9sb2d5IGFzIGEgYnVzIHdpdGggYSBncmFwaCBzdHJ1
Y3R1cmUNCmFuZCB0aGVuIGhhdmluZyB0aGUgY29tcG9uZW50cyBzaW1wbHkgcmVmZXJlbmNlIHRo
ZSBwb3J0IG5vZGVzIHdvdWxkIG1ha2UNCml0IG11Y2ggZWFzaWVyIHRvIGRlc2lnbi4NCg0KUGFy
dCBvZiB0aGUgcHJvYmxlbSBpcyB0cnlpbmcgdG8gZGVzY3JpYmUgYW4gQVRCIGJ1cyB2aWEgYSBj
b21wb25lbnQgb24NCmFuIEFQQiBidXMuIFlvdSBsb3NlIGFsbCB0aGUgbmljZXRpZXMgb2YgZGVz
Y3JpYmluZyBhIGJ1cyB3aXRoIGJ1cw0Kc3ViY29tcG9uZW50cy4gTGV0cyB0YWtlIHRoZSBBVEIg
YnVzIG91dHNpZGUuLiBieSBkZXNjcmliaW5nIHRoZSBpbmdyZXNzDQphbmQgZWdyZXNzIG9mIHRo
ZSBjb21wb25lbnQgeW91IGhhdmUgbm8gaWRlYSB3aGVyZSBpbiB0aGUgZ3JhcGggeW91IGFyZQ0K
YXQgdGhlIHBvaW50IG9mIGVudHJ5ICh5b3UgY291bGQgc3RhcnQgcGFyc2luZyBhdCBhIGZ1bm5l
bCwgd2hpY2ggbWVhbnMNCnRyYXZlbGxpbmcgYXJvdW5kIGxvb2tpbmcgZm9yIG90aGVyIHVuaXRz
IHRoYXQgbWF0Y2ggb3RoZXIgY29tcGF0aWJsZXMpLg0KDQpJZiB0aGUgQ29yZVNpZ2h0IHN1YnN5
c3RlbSBjb3VsZCBoYXZlIGEgZ3JhcGggcHJlLW1hZGUgb2YgdGhlIGZ1bGwNCnRvcG9sb2d5LCB0
aGVuIHRoZSBjb21wb25lbnRzIGNhbiBwb2ludCB0byBob3cgdGhleSB3cmFwIHBhcnRzIG9mDQp0
aGF0IHRvcG9sb2d5LiBZb3UgY2FuIGFsc28gZG8gYXdheSB3aXRoIHJpZGljdWxvdXMgbm9uLXBy
b2dyYW1tYWJsZQ0KZnVubmVscyBhbmQgcmVwbGljYXRvciBub2Rlcywgc2luY2UgdGhlIHRyYWNl
IGdyYXBoIHdvdWxkIGVuY2Fwc3VsYXRlDQp0aGF0IGluZm9ybWF0aW9uIHdpdGhvdXQgaGF2aW5n
IHRvIGluc3RhbnRpYXRlIGEgc3R1YiBkcml2ZXIgZm9yIGl0Lg0KDQpUaGF0IGRvZXNuJ3Qgc29s
dmUgJ3VuaXQnIG9yICd1bml0LWFkZHJlc3MnIG9yICdyZWcnIG9yIGFueXRoaW5nIGJ1dA0KaXQg
d291bGQga2VlcCB1cyBpbiBncmFwaCBiaW5kaW5ncyBhbmQgYWJzdHJhY3QgdGhlIEFUQiB0b3Bv
bG9neSBmcm9tDQp0aGUgY29tcG9uZW50cy4gT3RoZXIgZnVuIHN0dWZmOyBkZXNjcmliaW5nIGJy
aWRnZSBjb21wb25lbnRzIGFuZCBidXMNCndpZHRocyB3aXRoaW4gdGhlIGdyYXBoIGNvdWxkIGdp
dmUgYWJpbGl0aWVzIHRvIGRlc2NyaWJlIGJhbmR3aWR0aHMNCm92ZXIgZWFjaCB0cmFjZSBwYXRo
Lg0KDQpJbiBhbnkgY2FzZSwgd2hhdCBoYXBwZW5zIHdoZW4geW91IGhhdmUgdG8gZGVjaWRlIHdo
YXQgeW91ciBmdW5uZWwNCnBvcnQgcHJpb3JpdGllcyBhcmUsIHlvdSdsbCBoYXZlIHRvIGRlZmlu
ZSBhIG5ldyBwcm9wZXJ0eSBmb3IgdGhhdCwNCmFuZCBpdCB3b24ndCBiZSAncmVnJy4NCg0KVHJ5
aW5nIG5vdCB0byBhZGQgYW55dGhpbmcgdG8gdGhlIGdyYXBoIGJpbmRpbmdzIGlzIG9uZSB0aGlu
ZyBidXQNCnRyeWluZyB0byBzaG9laG9ybiBpdCBpbiBlaXRoZXIgYnkgZG9pbmcgdGhhdCBvciBp
bnZlbnRpbmcgd2hvbGx5DQpkZXZpY2Utc3BlY2lmaWMgcHJvcGVydGllcyBhcmUganVzdCBhcyBi
YWQuDQoNClBlcmhhcHMgd2UgY2FuIHVzZSB0aGUgcGF0aEB1bml0LWFkZHJlc3M6YXJndW1lbnRz
IDwtLSBwYXJhbWV0ZXJzIGhlcmUgdG8NCmFkZCBleHRyYSBpbmZvcm1hdGlvbiBhYm91dCB0aGUg
cG9ydC4gJ215LWFyZ3MnIHdvdWxkIHB1bGwgaXQgb3V0IGluIEZvcnRoLA0KSSBkb24ndCBrbm93
IGhvdyBGRFQgY29kZSBkZWFscyB3aXRoIGl0IChidXQgdGhlcmUgc2hvdWxkIGJlIHNvbWV0aGlu
ZywNCnNpbmNlIHdlIHVzZSBpdCBmb3IgY29uc29sZSBkZWZpbml0aW9uIGluIC9jaG9zZW4pLiBU
aGV5J3JlIGVudGlyZWx5DQpzcGVjaWZpYyB0byB0aGUgbm9kZSBpbiBxdWVzdGlvbiwgYnV0IG5v
dCB1c2VkIGluIHBhdGggbWF0Y2hpbmcuDQoNCldoeSBjYW4ndCB3ZSBkZWNpZGUgb24gYSBncmFw
aC1iaW5kaW5nIHVwZGF0ZSB0aGF0IGFsbG93cyBzcGVjaWZ5aW5nDQpzb21ldGhpbmcgc2ltcGxl
IGFzIGEgZGVtdWx0aXBsZXhlciBvdXRwdXQgaW4gYSB3YXkgdGhlIGRyaXZlciBjYW4NCnVuZGVy
c3RhbmQgYW5kIG1hcCB0byB0aGUgaGFyZHdhcmU/DQoNCj4gSWYgRFQgYmluZGluZ3MgY2FuIGJl
IHJldXNlZCBmb3IgQUNQSSwgdGhhdCdzIGZpbmUNCg0KSG93ZXZlciBpbiBteSBvcGluaW9uIG5v
dCB0aGUgcHJlZmVycmVkIHdheSB0byBkbyBpdC4uDQoNCj4gYW55IERUIGJpbmRpbmdzIHRvIGJl
IGFjY2VwdGVkIHNpbXBseSBiZWNhdXNlIHRoZXkgbWF0Y2ggQUNQSQ0KPiBiaW5kaW5ncy4NCg0K
SSdtIHN1cmUgQUNQSSBoYXMgY2FwYWJpbGl0eSBvZiBhIG11Y2ggY2xhc3NpZXIgd2F5IG9mIGRl
c2NyaWJpbmcNCnRoaW5ncywgYnV0IEkgaGF2ZSBzb21lIGZlYXIgdGhhdCBpdCdzIGp1c3QgT0Yg
YmluZGluZ3Mgc3R1ZmZlZCBpbg0KYSBfRFNELi4gRFQgYW5kIEFDUEkgaGF2ZSB0aGUgcmVzcG9u
c2liaWxpdHkgb2Ygc2hvdWxkZXJpbmcgdGhlDQpidXJkZW4gb2YgZGVzY3JpYmluZyBoYXJkd2Fy
ZS4gQW55IGF0dGVtcHRzIHRvIHRyeSBhbmQgbWFrZSBzb21lDQpjb21tb25hbGl0eSB0byBwcm9t
b3RlIGJyZXZpdHkgb2YgTGludXggY29kZSBpcyB0b3RhbGx5IG91dCBvZiBzY29wZS4uDQoNCllv
dSBjYW4gYWx3YXlzIGFic3RyYWN0IHdoYXRldmVyIGRlZmluaXRpb24gaW50byB3aGF0ZXZlciB0
aGUgTGludXgNCmRyaXZlcnMgbmVlZCBhdCB0aGUgdGltZS4gVGhhdCdzIGtpbmQgb2YgdGhlIHBv
aW50LiBMb2NraW5nIGluIHRvDQonaG93IGl0J3MgY3VycmVudGx5IGNvZGVkJyBpcyBzdGlmbGlu
ZyB3aGVuIHJlYWxpemluZyB0aGUgZmlyc3QNCmF0dGVtcHQgZGlkbid0IGFjdHVhbGx5IGFkZXF1
YXRlbHkgZG8gd2hhdCBpdCB3YXMgaW50ZW5kZWQuDQoNClRhLA0KTWF0dA0KSU1QT1JUQU5UIE5P
VElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
Y29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwg
dXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24g
aW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
