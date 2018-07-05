Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E17C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1882224B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="DH7qdEPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1882224B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeGEIng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:43:36 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:46818
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753216AbeGEInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3sNwecg9gUhb83oQk5zI3YQRWs0M5rHFpQivrqUMGU=;
 b=DH7qdEPDpRpdwxRChh8yp4wGATd6XZPVc2YaFHhqEKX3RrcBgL/YunoIHtGOItwbUCoArOaSE9KsBgVJZiM8jseIBFCTZksfA9uyzizg1hfo+9wwbs1py+osNBTtas+jD6RyZ5O9Mv6eydHAhZxx/UxIbrztkmTJVXy8NVx4Qto=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1164.namprd02.prod.outlook.com (10.162.108.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 5 Jul 2018 08:43:27 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%4]) with mapi id 15.20.0906.027; Thu, 5 Jul 2018
 08:43:27 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Mark Brown <broonie@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?utf-8?B?TWljaGFlbCBSw7ZkZXI=?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Steve deRosier <derosier@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>
Subject: RE: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Topic: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Index: AQHUESvvwSr5pLbXbkmh3lgaa2XdVqR8HL0AgAAWvYCAADBOgIAAc8UAgAN7D8A=
Date:   Thu, 5 Jul 2018 08:43:27 +0000
Message-ID: <BY1PR02MB111404D586D88AB2F93FDA03E7400@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <BY1PR02MB111481D94EB0D68AD5FCA689E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
 <8d514feb-41c7-8ec4-ace2-94e627187a0b@suse.de>
In-Reply-To: <8d514feb-41c7-8ec4-ace2-94e627187a0b@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [81.148.136.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1164;7:V08GfosRsPhGz/Q8OZWdoCfKP6LaDx5Kv5f6n9kirnznRAkjJw6hh287X4Tor3teKXeniiX9yS1o0/4kqS/ksobB6tNfc3jdiOSR/DDB/nMw4yr7IH2JwUmVNw8vqRNUMRKY6Iri3DwU4jHkQUe8eVoUZL3XcOCv6mSSejlIZx3aLmPiWsxz8oyfD38ET/0qFGs4UjFHkyGxDGq8crKFmin6OPkq4n5SYkKjCX2PcqQCwKJaxlnuIjz45ObkIRGn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f57521dd-c921-4cfa-112c-08d5e25360b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1164;
x-ms-traffictypediagnostic: BY1PR02MB1164:
x-microsoft-antispam-prvs: <BY1PR02MB116490A064A5C49B2BFFA84BE7400@BY1PR02MB1164.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1164;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1164;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(366004)(136003)(396003)(376002)(78114003)(199004)(189003)(14454004)(6436002)(9686003)(6306002)(8936002)(55016002)(486006)(7696005)(76176011)(6506007)(99286004)(4326008)(6246003)(39060400002)(53936002)(102836004)(551934003)(54906003)(229853002)(33656002)(316002)(97736004)(25786009)(186003)(26005)(66066001)(105586002)(8676002)(86362001)(2906002)(81166006)(81156014)(74316002)(72206003)(11346002)(5250100002)(478600001)(2900100001)(68736007)(3846002)(6116002)(256004)(305945005)(14444005)(5024004)(446003)(7736002)(7416002)(6916009)(966005)(106356001)(476003)(5660300001)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1164;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: URgP1LoDCTs8MZ6S+bnqPmq3DEgr7x3Ja8LV8WAaKiBhvJ/Crt+nyWlVQMtEjxXS4QaDpnQbQ2ZeLKv8NWJsD/K2DwnnAm4JTUlTbtUaXZCHlmEUe9O7hGOOsP97epepzRIMLVc2oTdQGEAfgFvGrlR58K1aYDTMymNoU9rxegMtZirteaExzGHwtelOy7MJIDmRfna+ZAjY+ghJC6pEFRAUxHLTIAANpuQpYJ5PKnOmfXbupZ+c86HIed7k2zZnTNhFndMO5A5A5VT/Nz1a5iWKhhTMYs92rlGPZKjTfUNi0IU/EekeKymi45/muZRxBdKPxCiapig0gCkMY2Upu8/l7RllL2spTXYJEErJkD8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57521dd-c921-4cfa-112c-08d5e25360b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 08:43:27.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQyBuZXQtbmV4dCAxNS8xNV0gbmV0OiBsb3JhOiBBZGQgU2VtdGVj
aCBTWDEzMDENCj4gDQo+IEhpIEJlbiwNCj4gDQo+IEFtIDAyLjA3LjIwMTggdW0gMjI6NDMgc2No
cmllYiBCZW4gV2hpdHRlbjoNCj4gPj4gMikgVGhpcyBTUEkgZGV2aWNlIGlzIGluIHR1cm4gZXhw
b3NpbmcgdGhlIHR3byBTUEkgbWFzdGVycyB0aGF0IHlvdQ0KPiA+PiBhbHJlYWR5IGZvdW5kIGJl
bG93LCBhbmQgSSBkaWRuJ3Qgc2VlIGEgc2FuZSB3YXkgdG8gc3BsaXQgdGhhdCBjb2RlIG91dA0K
PiA+PiBpbnRvIGRyaXZlcnMvc3BpLywgc28gaXQncyBpbiBkcml2ZXJzL25ldC9sb3JhLyBoZXJl
IC0gaGFzIHRoZXJlIGJlZW4NCj4gPj4gYW55IHByZWNlZGVuY2UgZWl0aGVyIHdheT8NCj4gPg0K
PiA+IEluIG15IHdvcmsgaW4gcHJvZ3Jlc3MgZHJpdmVyIEkganVzdCByZWdpc3RlciBvbmUgY29u
dHJvbGxlciBmb3IgdGhlIHN4MTMwMQ0KPiB3aXRoIHR3byBjaGlwIHNlbGVjdHMgYW5kIHVzZSB0
aGUgY2hpcCBzZWxlY3QgaW5mb3JtYXRpb24gdG8gY2hvb3NlIHRoZQ0KPiBjb3JyZWN0IHJhZGlv
IHRvIHNlbmQgdG8sIHRoaXMgaXMgYmFzZWQgb24gdGhlIERUIHJlZyBpbmZvcm1hdGlvbi4gTm8g
bmVlZCB0bw0KPiByZWdpc3RlciB0d28gc2VwYXJhdGUgbWFzdGVycy4NCj4gDQo+IEkgaGFkIGNv
bnNpZGVyZWQgdGhhdCBhbmQgZGlzY2FyZGVkIGl0LiBUaGUgU1gxMzAxIGhhcyBub3QganVzdCB0
d28gQ1MNCj4gcmVnaXN0ZXJzIHRob3VnaCBidXQgYWxzbyB0d28gcGFpcnMgb2YgYWRkciwgZGF0
YSByZWdpc3RlcnMuIFRoYXQgc3BlYWtzDQo+IGZvciB0d28gbWFzdGVycyB3aXRoIGEgc2luZ2xl
IGNoaXAtc2VsZWN0IGVhY2gsIHVubGVzcyBJJ20NCj4gbWlzdW5kZXJzdGFuZGluZyB0aGUgbWVh
bmluZyBvZiB0aGUgcmVnaXN0ZXJzLg0KDQpCYXNlZCBvbiBNYXJrcyBzdWdnZXN0aW9uIEkgYW0g
ZXhwZXJpbWVudGluZyB3aXRoIHVzaW5nIHRoZSBTWDEzMDEgdG8gZXhwb3NlIGEgcmVnbWFwX2J1
cyB0aGF0IHRoZSB1bmRlcmx5aW5nIFNYMTI1NyBjYW4gYXR0YWNoIHRvLCBzbyB0aGUgcmFkaW8g
aGFzIGEgY29yZSBjb21wb25lbnQsIGEgU1BJIGNvbXBvbmVudCBmb3IgZGlyZWN0IGNvbm5lY3Rp
b24gYW5kIHRoaXMgY29uY2VudHJhdG9yIGNvbm5lY3Rpb24gY29tcG9uZW50LiANCg0KPiA+PiBB
bSAwMi4wNy4yMDE4IHVtIDE4OjEyIHNjaHJpZWIgTWFyayBCcm93bjoNCj4gPj4+IE9uIFN1biwg
SnVsIDAxLCAyMDE4IGF0IDAxOjA4OjA0UE0gKzAyMDAsIEFuZHJlYXMgRsOkcmJlciB3cm90ZToN
Cj4gPj4+DQo+ID4+Pj4gK3N0YXRpYyB2b2lkIHN4MTMwMV9yYWRpb19zcGlfc2V0X2NzKHN0cnVj
dCBzcGlfZGV2aWNlICpzcGksIGJvb2wNCj4gZW5hYmxlKQ0KPiA+Pj4+ICt7DQo+ID4+Pj4gKwlp
bnQgcmV0Ow0KPiA+Pj4+ICsNCj4gPj4+PiArCWRldl9kYmcoJnNwaS0+ZGV2LCAic2V0dGluZyBT
UEkgQ1MgdG8gJXNcbiIsIGVuYWJsZSA/ICIxIiA6ICIwIik7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJ
aWYgKGVuYWJsZSkNCj4gPj4+PiArCQlyZXR1cm47DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJcmV0ID0g
c3gxMzAxX3JhZGlvX3NldF9jcyhzcGktPmNvbnRyb2xsZXIsIGVuYWJsZSk7DQo+ID4+Pj4gKwlp
ZiAocmV0KQ0KPiA+Pj4+ICsJCWRldl93YXJuKCZzcGktPmRldiwgImZhaWxlZCB0byB3cml0ZSBD
UyAoJWQpXG4iLCByZXQpOw0KPiA+Pj4+ICt9DQo+ID4+Pg0KPiA+Pj4gU28gd2UgbmV2ZXIgZGlz
YWJsZSBjaGlwIHNlbGVjdD8NCj4gPj4NCj4gPj4gTm90IGhlcmUsIEkgaW5zdGVhZCBkaWQgdGhh
dCBpbiB0cmFuc2Zlcl9vbmUgYmVsb3cuDQo+ID4+DQo+ID4+IFVuZm9ydHVuYXRlbHkgdGhlcmUg
c2VlbXMgdG8gYmUgbm8gZG9jdW1lbnRhdGlvbiwgb25seSByZWZlcmVuY2UNCj4gY29kZToNCj4g
Pj4NCj4gPj4gaHR0cHM6Ly9naXRodWIuY29tL0xvcmEtDQo+ID4+IG5ldC9sb3JhX2dhdGV3YXkv
YmxvYi9tYXN0ZXIvbGlibG9yYWd3L3NyYy9sb3JhZ3dfcmFkaW8uYyNMMTIxDQo+ID4+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9Mb3JhLQ0KPiA+PiBuZXQvbG9yYV9nYXRld2F5L2Jsb2IvbWFzdGVyL2xp
YmxvcmFndy9zcmMvbG9yYWd3X3JhZGlvLmMjTDE2NQ0KPiA+Pg0KPiA+PiBJdCBzZXRzIENTIHRv
IDAgYmVmb3JlIHdyaXRpbmcgdG8gYWRkcmVzcyBhbmQgZGF0YSByZWdpc3RlcnMsIHRoZW4NCj4g
Pj4gaW1tZWRpYXRlbHkgc2V0cyBDUyB0byAxIGFuZCBiYWNrIHRvIDAgYmVmb3JlIHJlYWRpbmcg
b3IgZW5kaW5nIHRoZQ0KPiA+PiB3cml0ZSB0cmFuc2FjdGlvbi4gSSd2ZSB0cmllZCB0byBmb3Jj
ZSB0aGUgc2FtZSBiZWhhdmlvciBpbiB0aGlzIGRyaXZlci4NCj4gPj4gTXkgZ3Vlc3Mgd2FzIHRo
YXQgQ1MgaXMgaGlnaC1hY3RpdmUgZHVyaW5nIHRoZSBzaG9ydCAxLTAgY3ljbGUsIGJlY2F1c2UN
Cj4gPj4gaWYgaXQncyBsb3ctYWN0aXZlIGR1cmluZyB0aGUgcmVnaXN0ZXIgd3JpdGVzIHRoZW4g
d2h5IHRoZSBoZWNrIGlzIGl0DQo+ID4+IHNldCB0byAwIGFnYWluIGluIHRoZSBlbmQgaW5zdGVh
ZCBvZiBrZWVwaW5nIGF0IDEuLi4gY29uZnVzaW5nLg0KPiA+Pg0KPiA+PiBNYXliZSB0aGUgU2Vt
dGVjaCBmb2xrcyBDQydlZCBjYW4gY29tbWVudCBob3cgdGhlc2UgcmVnaXN0ZXJzIHdvcms/DQo+
ID4+DQo+ID4+Pj4gKwlpZiAodHhfYnVmKSB7DQo+ID4+Pj4gKwkJcmV0ID0gc3gxMzAxX3dyaXRl
KHNzeC0+cGFyZW50LCBzc3gtPnJlZ3MgKw0KPiA+PiBSRUdfUkFESU9fWF9BRERSLCB0eF9idWYg
PyB0eF9idWZbMF0gOiAwKTsNCj4gPj4+DQo+ID4+PiBUaGlzIGxvb2tzIGNvbmZ1c2VkLiAgV2Un
cmUgaW4gYW4gaWYgKHR4X2J1ZikgYmxvY2sgYnV0IHRoZXJlJ3MgYSB1c2Ugb2YNCj4gPj4+IHRo
ZSB0ZXJuZXJ5IG9wZXJhdG9yIHRoYXQgYXBwZWFycyB0byBiZSBjaGVja2luZyBpZiB3ZSBoYXZl
IGEgdHhfYnVmPw0KPiA+Pg0KPiA+PiBZZWFoLCBhcyBtZW50aW9uZWQgdGhpcyBSRkMgaXMgbm90
IHJlYWR5IGZvciBtZXJnaW5nIC0gY2hlY2twYXRjaC5wbA0KPiA+PiB3aWxsIGNvbXBsYWluIGFi
b3V0IGxpbmVzIHRvbyBsb25nLCBhbmQgVE9ET3MgYXJlIHNwcmlua2xlZCBhbGwgb3ZlciBvcg0K
PiA+PiBub3QgZXZlbiBtZW50aW9uZWQuIEl0J3MgYSBQcm9vZiBvZiBDb25jZXB0IHRoYXQgYSBu
ZXRfZGV2aWNlIGNvdWxkIHdvcmsNCj4gPj4gZm9yIGEgd2lkZSByYW5nZSBvZiBzcGkgYW5kIHNl
cmRldiBiYXNlZCBkcml2ZXJzLCBhbmQgb24gdG9wIHRoaXMgZGV2aWNlDQo+ID4+IGhhcyBtb3Jl
IHRoYW4gb25lIGNoYW5uZWwsIHdoaWNoIG1heSBpbmZsdWVuY2UgbmV0d29yay1sZXZlbCBkZXNp
Z24NCj4gPj4gZGlzY3Vzc2lvbnMuDQo+ID4+DQo+ID4+IFRoYXQgc2FpZCwgSSdsbCBoYXBwaWx5
IGRyb3AgdGhlIHNlY29uZCBjaGVjay4gVGhhbmtzIGZvciBzcG90dGluZyENCj4gPj4NCj4gPj4+
PiArCQlpZiAocmV0KSB7DQo+ID4+Pj4gKwkJCWRldl9lcnIoJnNwaS0+ZGV2LCAiU1BJIHJhZGlv
IGFkZHJlc3Mgd3JpdGUNCj4gPj4gZmFpbGVkXG4iKTsNCj4gPj4+PiArCQkJcmV0dXJuIHJldDsN
Cj4gPj4+PiArCQl9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJCXJldCA9IHN4MTMwMV93cml0ZShzc3gt
PnBhcmVudCwgc3N4LT5yZWdzICsNCj4gPj4gUkVHX1JBRElPX1hfREFUQSwgKHR4X2J1ZiAmJiB4
ZnItPmxlbiA+PSAyKSA/IHR4X2J1ZlsxXSA6IDApOw0KPiA+Pj4+ICsJCWlmIChyZXQpIHsNCj4g
Pj4+PiArCQkJZGV2X2Vycigmc3BpLT5kZXYsICJTUEkgcmFkaW8gZGF0YSB3cml0ZSBmYWlsZWRc
biIpOw0KPiA+Pj4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+Pj4+ICsJCX0NCj4gPj4+DQo+ID4+PiBU
aGlzIGxvb2tzIGF3ZnVsbHkgbGlrZSB5b3UncmUgY29taW5nIGluIGF0IHRoZSB3cm9uZyBhYnN0
cmFjdGlvbiBsYXllcg0KPiA+Pj4gYW5kIHRoZSBoYXJkd2FyZSBhY3R1YWxseSBpbXBsZW1lbnRz
IGEgcmVnaXN0ZXIgYWJzdHJhY3Rpb24gcmF0aGVyIHRoYW4NCj4gPj4+IGEgU1BJIG9uZSBzbyB5
b3Ugc2hvdWxkIGJlIHVzaW5nIHJlZ21hcCBhcyB0aGUgYWJzdHJhY3Rpb24uDQo+ID4+DQo+ID4+
IEkgZG9uJ3QgdW5kZXJzdGFuZC4gQmVuIGhhcyBzdWdnZXN0ZWQgdXNpbmcgcmVnbWFwIGZvciB0
aGUgU1BJIF9kZXZpY2VfDQo+ID4+IHRoYXQgd2UncmUgdGFsa2luZyB0bywgd2hpY2ggbWF5IGJl
IGEgZ29vZCBpZGVhLiBCdXQgdGhpcyBTWDEzMDEgZGV2aWNlDQo+ID4+IGluIHR1cm4gaGFzIHR3
byBTUEkgX21hc3RlcnNfIHRhbGtpbmcgdG8gYW4gU1gxMjV4IHNsYXZlIGVhY2guIEkgZG9uJ3QN
Cj4gPj4gc2VlIGhvdyB1c2luZyByZWdtYXAgaW5zdGVhZCBvZiBteSB3cmFwcGVycyBhdm9pZHMg
dGhpcyBzcGlfY29udHJvbGxlcj8NCj4gPj4gVGhlIHdob2xlIHBvaW50IG9mIHRoaXMgc3BpX2Nv
bnRyb2xsZXIgaXMgdG8gYWJzdHJhY3QgYW5kIHNlcGFyYXRlIHRoZQ0KPiA+PiBTWDEyNTUgdnMu
IFNYMTI1NyB2cy4gd2hhdGV2ZXItcmFkaW8tYXR0YWNoZWQgaW50byBhIHNlcGFyYXRlIGRyaXZl
ciwNCj4gPj4gaW5zdGVhZCBvZiBtaXhpbmcgaXQgaW50byB0aGUgU1gxMzAxIGRyaXZlciAtIHRv
IG1lIHRoYXQgbG9va3MgY2xlYW5lcg0KPiA+PiBhbmQgbW9yZSBleHRlbnNpYmxlLiBJdCBhbHNv
IGhhcyB0aGUgc2lkZS1lZmZlY3QgdGhhdCB3ZSBjb3VsZCBjb25maWd1cmUNCj4gPj4gdGhlIHR3
byByYWRpb3MgdmlhIERUIChmcmVxdWVuY2llcywgY2xrIG91dHB1dCwgZXRjLikuDQo+ID4NCj4g
PiBZb3Ugd2FudCBhbiBTUEkgY29udHJvbGxlciBpbiB0aGUgU1gxMzAxIGFzIHRoZSBkb3duIHN0
cmVhbSByYWRpb3MgYXJlIFNQSQ0KPiBhbmQgY291bGQgYmUgYXR0YWNoZWQgZGlyZWN0bHkgdG8g
YSBob3N0IFNQSSBidXMsIG1ha2VzIHNlbnNlIHRvIGhhdmUgb25lDQo+IHJhZGlvIGRyaXZlciBh
bmQgdGFsayB0aHJvdWdoIHRoZSBTWDEzMDEuDQo+ID4gQnV0IHlvdSBzaG91bGQgdXNlIHRoZSBy
ZWdtYXAgdG8gYWNjZXNzIHRoZSBTWDEzMDEgbWFzdGVyIGNvbnRyb2xsZXINCj4gcmVnaXN0ZXJz
Lg0KPiA+IEV4YW1wbGUgSSB1c2Ugd2l0aCBvbmUgU1BJIG1hc3RlciBhbmQgc29tZSBjbG9jayBp
bmZvOg0KPiA+IGVnOg0KPiA+IAlzeDEzMDE6IHN4MTMwMUAwIHsNCj4gDQo+IE5vZGUgbmFtZXMg
c2hvdWxkIG5vdCByZXBlYXQgdGhlIGNoaXBzZXQsIHRoYXQgZ29lcyBpbnRvIGNvbXBhdGlibGUu
DQo+IA0KPiBsb3JhLWNvbmNlbnRyYXRvckAwPw0KPiANClN1cmUNCg0KPiA+IAkJY29tcGF0aWJs
ZSA9ICJzZW10ZWNoLHN4MTMwMSI7DQo+ID4gCQlyZWcgPSA8MD47DQo+ID4gCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4gPiAJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiANCj4gSSB3b3VsZCBzdGls
bCBmaW5kIGl0IGNsZWFuZXIgdG8gaGF2ZSAoYSkgc3ViLW5vZGUocykgZm9yIHRoZSByYWRpb3Mu
DQpIb3cgZG8geW91IG1lYW4/DQoNCj4gPiAJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDgwMDAwMDA+
Ow0KPiANCj4gRGF0YXNoZWV0IHNheXMgMTAgTUh6LCB3aHkgOCBNSHo/DQo+IA0KPiA+IAkJZ3Bp
b3MtcmVzZXQgPSA8JnBpb0EgMjYgR1BJT19BQ1RJVkVfSElHSD47DQo+IA0KPiByZXNldC1ncGlv
cz8NCkFncmVlZCwgdGhpcyBzZWVtcyBtb3JlIGNvbW1vbi4NCg0KPiA+IAkJY2xvY2tzID0gPCZy
YWRpbzEgMD4sIDwmY2xraHMgMD47DQo+ID4gCQljbG9jay1uYW1lcyA9ICJjbGszMm0iLCAiY2xr
aHMiOw0KPiA+DQo+ID4gCQlyYWRpbzA6IHN4MTI1N0AwIHsNCj4gDQo+IGxvcmFAMD8NCj4gDQo+
ID4gCQkJY29tcGF0aWJsZSA9ICJzZW10ZWNoLHN4MTI1eCI7DQo+IA0KPiBObyB3aWxkY2FyZHMg
aW4gYmluZGluZ3MgcGxlYXNlLCB1c2UgY29uY3JldGUgInNlbXRlY2gsc3gxMjU3Ii4NClN1cmUN
Cg0KPiA+IAkJCXJlZyA9IDwwPjsNCj4gPiAJCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw4MDAwMDAw
PjsNCj4gDQo+IERhdGFzaGVldCBzYXlzIDEwIG5zIC0gSSByZXBvcnRlZCB0byBTZW10ZWNoIHRo
YXQgaXQgc2hvdWxkIHByb2JhYmx5IHNheQ0KPiAxMCBNSHosIHRvby4NCj4gDQo+ID4gCQkJdHg7
DQo+IA0KPiBNaWdodCB3ZSBjb25maWd1cmUgdGhhdCBvbiB0aGUgc3gxMzAxIGluc3RlYWQ/DQoN
CldlbGwgdGhlIGFiaWxpdHkgZm9yIGEgcmFkaW8gdG8gVFggaXMgYSByYWRpbyBwcm9wZXJ0eSBy
ZWFsbHkuIEl0IGRlcGVuZHMgb24gdGhlIGJvYXJkIHdoaWNoIGNoYWluIGhhcyB0aGUgUEFzIG9u
LiBJIGRvbuKAmXQgdGhpbmsgdGhhdCBpdHMgYXBwcm9wcmlhdGUgdG8gY29uZmlndXJlIHRoaXMg
YXQgdGhlIGNvbmNlbnRyYXRvciwgaXQgY2FuIGluc3RlYWQgZGlzY292ZXIgdGhpcyBmcm9tIHRo
ZSByYWRpb3MuDQoNCj4gPiAJCQljbG9ja3MgPSA8JnRjeG8gMD47DQo+ID4gCQkJY2xvY2stbmFt
ZXMgPSAidGN4byI7DQo+ID4gCQl9Ow0KPiA+DQo+ID4gCQlyYWRpbzE6IHN4MTI1N0AxIHsNCj4g
PiAJCQljb21wYXRpYmxlID0gInNlbXRlY2gsc3gxMjV4IjsNCj4gPiAJCQlyZWcgPSA8MT47DQo+
ID4gCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAwMDAwMD47DQo+ID4gCQkJI2Nsb2NrLWNlbGxz
ID0gPDA+Ow0KPiA+IAkJCWNsb2NrcyA9IDwmdGN4byAwPjsNCj4gPiAJCQljbG9jay1uYW1lcyA9
ICJ0Y3hvIjsNCj4gPiAJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAiY2xrMzJtIjsNCj4gPiAJCX07
DQo+ID4gfTsNCj4gW3NuaXBdDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmRyZWFzDQo+IA0KPiAtLQ0K
PiBTVVNFIExpbnV4IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFu
eQ0KPiBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9u
DQo+IEhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQ0K
