Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0539F21A83
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="NQKCVOgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0539F21A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeGEJAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:00:02 -0400
Received: from mail-bl2nam02on0138.outbound.protection.outlook.com ([104.47.38.138]:27120
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753357AbeGEI77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENLup6dK9Wj7HKzSJQ/FXP8zgAVezXGRcKXUY5DeYw0=;
 b=NQKCVOgcNc8x7GMen57pcaksMdyiswCRhffEdAvwvWbheBoBJPtyW6ZXZFOMdq0ULvxdESSuw//sZIfZwc1qk2WDbt1M91OrihaNYdEpbbmB6NAX68H13DYXV7IgqWOyn+TedhhT78BZe/HM47W82mzoglST9URHLZ07p6gJ6Jw=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1210.namprd02.prod.outlook.com (10.162.108.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Thu, 5 Jul 2018 08:59:54 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%4]) with mapi id 15.20.0906.027; Thu, 5 Jul 2018
 08:59:54 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>
Subject: RE: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Topic: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Index: AQHUESvvwSr5pLbXbkmh3lgaa2XdVqR70GgggAEBhICAA4RSsA==
Date:   Thu, 5 Jul 2018 08:59:54 +0000
Message-ID: <BY1PR02MB11145A00AC66E03E61607C09E7400@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <BY1PR02MB11148FFC047AE7509DD811E0E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
 <c68e5336-1647-e0e4-0a1d-3efdcfb4fe9c@suse.de>
In-Reply-To: <c68e5336-1647-e0e4-0a1d-3efdcfb4fe9c@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [81.148.136.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1210;7:jbjK/oig6yPuKRxtoElfdDRmydRdj/SvlS3pCBDXW0IxJOFjA4i/wKMLrpu2CzL2ZrdlX2TMthJD5qzPERARhFoQ6Qm0fuJnkQBpeLdnfTl1jfhU4RyBPPC4TsM+97p5tvTW+C2wvU4ar90tDiy7Oz4ZIzn4arQh+KK+W2RGGbjKqNKvZ7rWlAJxNe3KjpE3xXvMcmWvNgOpffzXFEItFjbWbGXNbnp45Snvh5WPguKfcHaG74L4I9fZwYNmd8Hx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d418c2e-c2bc-4894-eb03-08d5e255acfc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1210;
x-ms-traffictypediagnostic: BY1PR02MB1210:
x-microsoft-antispam-prvs: <BY1PR02MB1210687ED45F5E1B73611C6BE7400@BY1PR02MB1210.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(155532106045638)(21532816269658)(148717330147763);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1210;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1210;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(5660300001)(25786009)(14454004)(99286004)(66066001)(478600001)(97736004)(81166006)(81156014)(2906002)(53936002)(7736002)(186003)(8676002)(68736007)(486006)(316002)(8936002)(33656002)(6246003)(229853002)(74316002)(39060400002)(11346002)(446003)(305945005)(106356001)(105586002)(4326008)(256004)(14444005)(55016002)(476003)(6306002)(7416002)(6916009)(93886005)(26005)(5250100002)(2900100001)(76176011)(54906003)(6436002)(102836004)(3846002)(6116002)(6506007)(966005)(72206003)(86362001)(9686003)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1210;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5rzGTXtv0Fjmhtl1J6bCS5i055ni0oY2uVqG4qNiGsjbQ5w1kOkVmBxlkDPVdRczQqRQgrmExwzPfFQXLhwfVpGPtJX72limJYPuz5DgXtvFOwBD4XmUEdCLQxPzVOGGC2YZ6wW+Wk/hswQhMOy6MbVOBkIFBRI1+TsR9idRYVxmikLXiEPSZKGpQ2oVA/hkpN2dh5C3npapOCKBwEo+GlwRoMn6z3VpzqhR1K5iPrMFli2e4tFiL9JcOOzB9wFiaVcQnqMU0mMALtXd7x3L4EgNJlcYA4Vn6eZclnd7sHlVciqK9HQbv19C2eJR8FkX85iwUQgqUPZnQa2aw5r8VaAdC9VQPQ0vTXtjXQEMA1g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d418c2e-c2bc-4894-eb03-08d5e255acfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 08:59:54.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQyBuZXQtbmV4dCAxNS8xNV0gbmV0OiBsb3JhOiBBZGQgU2VtdGVj
aCBTWDEzMDENCj4gDQo+IEhpIEJlbiwNCj4gDQo+IEFtIDAyLjA3LjIwMTggdW0gMTM6NTEgc2No
cmllYiBCZW4gV2hpdHRlbjoNCj4gPiBFeGNlbGxlbnQgd29yayBvbiBkb2luZyB0aGlzIEkgaGF2
ZSBhbHNvIGJlZW4gd29ya2luZyBvbiBhbmQgb2ZmDQo+ID4gdGhpcyBwZXJzb25hbGx5IGZvciBz
b21lIHRpbWUuDQo+IA0KPiBUaGFua3MuIENvbGxpZGluZyB3b3JrIGlzIGFsd2F5cyB1bmZvcnR1
bmF0ZSwgSSBjYW4gcmVsYXRlLi4uDQo+IA0KPiA+IEhhdmUgYSBsb29rIGF0IG15IHJlcG9zaXRv
cnkgWzFdIGZvciBzeDEzMDEgYW5kIHN4MTI1NyBkcml2ZXJzLA0KPiA+IEkgdXNlIHJlZ21hcHMg
Y2FwYWJpbGl0eSBvZiBzd2l0Y2hpbmcgcGFnZXMgd2hpY2ggc2hvdWxkIHNpbXBsaWZ5DQo+ID4g
eW91ciBkcml2ZXIgY29uc2lkZXJhYmx5LCBJIGFsc28gaGF2ZSBhIGZ1bGwgcmVnaXN0ZXIgbWFw
IGFuZCBiaXQgZmllbGQuDQo+IA0KPiBQbGVhc2Ugbm90ZSB0aGF0IG15IGxvcmEtbmV4dCBicmFu
Y2ggYWxyZWFkeSBoYXMgYnVnIGZpeGVzIGFuZCBjbGVhbnVwcw0KPiBvdmVyIHRoaXMgcGF0Y2gu
IFRoZSBwcm9iZSBlcnJvciBoYW5kbGluZyB3YXMgYnJva2VuLCBhbmQgSSBpbXBsZW1lbnRlZA0K
PiB3cmFwcGVycyBmb3IgcGFnZWQgcmVhZHMgYW5kIHdyaXRlcyBhcyB3ZWxsIGFzIGJ1cnN0IG1v
ZGVzLCBwbHVzIHRoZQ0KPiBmaXJtd2FyZSBsb2FkaW5nLg0KPiANCj4gaHR0cHM6Ly9naXRodWIu
Y29tL2FmYWVyYmVyL2xpbnV4L2NvbW1pdHMvbG9yYS1uZXh0DQo+IA0KPiBJIHRvb2sgYSBxdWlj
ayBsb29rIGF0IHlvdXIgc3gxMjU3IGFuZCBub3RpY2VkIHlvdSBsaWNlbnNlZCBpdCBhcyBHUEx2
Mi4NCj4gSXMgdGhlcmUgYW55IHBhcnRpY3VsYXIgcmVhc29uIGZvciB0aGF0PyBTaW5jZSBJIHdy
b3RlIG15IGRyaXZlciB3aXRob3V0DQo+IGNvcHlpbmcgZnJvbSBHUEx2MiBjb2RlLCBJIHByZWZl
ciB0aGUgbGVzcyByZXN0cmljdGl2ZSBHUEx2MisuDQoNCkFzIEkgd2FzIGxlYXJuaW5nIGFib3V0
IHJlZ21hcCB1c2FnZSBhbmQgaG93IFNQSSBkZXZpY2VzIGNvbm5lY3QgdG8gdGhlIGJ1cyBJIGFk
b3B0ZWQgdGhlIG1vc3QgY29tbW9uIGxpY2VuY2UgZW1wbG95ZWQgaW4gdGhlc2Uga2VybmVsIGZp
bGVzLCBzZWVtZWQgYXBwcm9wcmlhdGUuDQpVbHRpbWF0ZWx5IEkgZG9u4oCZdCB3YW50IGEgbGlj
ZW5jZSBjaG9pY2UgdG8gaGFtcGVyIGluY2x1c2lvbiB0byBtYWlubGluZSwgbm90IGEgbGF3eWVy
IEkgZG9u4oCZdCBmaW5kIHRoYXQgZnVuLg0KDQo+IA0KPiBTbyBmYXIgYSB3b3JrIGRheSBoYXMg
cGFzc2VkIHdpdGggbm8gbWFpbnRhaW5lciBvYmplY3RpbmcgdG8gb3INCj4gY29tbWVudGluZyBv
biB0aGUgdW5kZXJseWluZyBQRl9MT1JBIG5ldHdvcmsgbGF5ZXIgZGVzaWduLiBNZWFud2hpbGUN
Cj4gdGhlcmUncyBhbHJlYWR5IHRocmVlIG9mIHVzIHdpdGggY29kZSBhbmQgbW9yZSBwZW9wbGUg
aGF2ZSBpbnF1aXJlZA0KPiBhYm91dCB0ZXN0aW5nIGFuZCBjb250cmlidXRpbmcsIHNvIEknbSB0
aGlua2luZyBhYm91dCBzZXR0aW5nIHVwIGENCj4gc3RhZ2luZyB0cmVlIG9uIGtlcm5lbC5vcmcg
dG8gY29sbGFib3JhdGUgb24uLi4NCj4gDQo+IFdvdWxkIHlvdSBiZSB3aWxsaW5nIHRvIGNvbnRy
aWJ1dGUgeW91ciByZWdtYXAgaWRlYXMgdG8gbXkgZHJpdmVyIGFzIGENCj4gcGF0Y2ggdG8gc3F1
YXNoPyBOZWVkcyBhIFNpZ25lZC1vZmYtYnkgb2YgY291cnNlLCB3aGljaCB5b3VyIEdpdEh1Yg0K
PiBjb21taXRzIGFyZSBsYWNraW5nLCBzbyBJIGNhbid0IG1lcmdlIHRoZW0gb24gbXkgb3duLg0K
DQpJJ20gc3VyZSB3aGljaGV2ZXIgd2F5IHdlIG1lcmdlIGl0LCB5b3VycyB0byBtaW5lIC8gbWlu
ZSB0byB5b3Vycywgd2UgY2FuIHdvcmsgdG9nZXRoZXIgb24gaXQuDQpBcyBJIGFscmVhZHkgaGF2
ZSByZWdtYXAgcnVubmluZyBhbmQgbW9zdGx5IHNwbGl0IG91dCBTWDEyNTcgZHJpdmVycyB0byBN
YXJrcyBzdWdnZXN0aW9ucyBhdm9pZGluZyB0aGUgZXh0cmEgU1BJIGxheWVyIGl0IG1heSBieSBl
YXNpZXIgdG8gcG9ydCB0aGUgdmFyaW91cyBmdW5jdGlvbnMgeW91IGhhdmUgdG8gbWluZSBhbmQg
c2hhcmUgYXV0aG9yc2hpcC4NCg0KPiA+IEkgaGF2ZSBhbHNvIGJlZW4gdHJ5aW5nIHRvIHVzZSB0
aGUgY2xrIGZyYW1ld29yayB0byBjYXB0dXJlIHRoZSB2YXJpb3VzDQo+ID4gcm91dGluZyB0aGF0
IHRoZSBjYXJkcyBoYXZlLg0KPiANCj4gSSB0aG91Z2h0IGFib3V0IGNsayB0b28sIGJ1dCB3b24n
dCB0aGF0IGNhdXNlIG5hbWUgY29uZmxpY3RzIHdoZW4NCj4gcHJvYmluZyBtdWx0aXBsZSBjb25j
ZW50cmF0b3JzPyBXb3VsZCBiZSBuaWNlIHRvIHVzZSB0aGF0IGZvcg0KPiBjb25maWd1cmluZyB0
aGUgU1gxMjU3IGNsb2NrIG91dHB1dCBpbnN0ZWFkIG9mIG15IGN1cnJlbnQgaGFjay4NCg0KUG90
ZW50aWFsbHksIGl0IG1heWJlIHRoYXQgd2UgbmVlZCB0byBhdWdtZW50IHRoZSBuYW1lcyBvZiB0
aGUgY2xrIHdpdGggdGhlIENTIG9mIHRoZSBjb25jZW50cmF0b3IgaW4gdXNlLg0KT3IgbWF5YmUg
dGhlIHJhZGlvIG9ubHkgc2VhcmNoZXMgdGhlIGNsaydzIG9mIGl0cyBwYXJlbnQgZGV2aWNlLi4u
DQpJJ3ZlIG5vdCBleHBsb3JlZCB0aGlzIGFyZWEgdG8gZmFyIHlldCBidXQgdGhlcmUgd2lsbCBi
ZSBhIHNvbHV0aW9uIEknbSBzdXJlLg0KDQo+IEFub3RoZXIgdGhvdWdodCBJIGhhdmVuJ3QgaW52
ZXN0aWdhdGVkIHlldCBpcyB3aGV0aGVyIHdlIGNvdWxkIHVzZQ0KPiByZW1vdGVwcm9jIGZvciBB
UkIgYW5kIEFHQy4gSSB3b3VsZCBhdCBsZWFzdCBwcmVmZXIgdG8gaGF2ZSB0aGUgZmlybXdhcmUN
Cj4gYXMgYSBiaW5hcnkgbG9hZGVkIHZpYSB0aGUgdXN1YWwgcmVxdWVzdF9maXJtd2FyZSgpLCBu
b3QgYXMgYnl0ZSBhcnJheS4NCj4gQnV0IHRoZW4gYWdhaW4gdGhlIEFHQyBnZXRzIGZpcm13YXJl
IGxvYWRlZCB0d2ljZSwgc28gbWF5YmUgdG9vIGNvbXBsZXgNCj4gZm9yIHJlbW90ZXByb2MuDQo+
IA0KPiBCVFcgZG8geW91IGhhdmUgYW55IGluc2lnaHRzIG9uIHdoYXQgTUNVIGlzIGluIHRoZXJl
PyBXb3VsZCBiZSBuaWNlIHRvDQo+IHVuZGVyc3RhbmQgaW4gZm9ybSBvZiBzb3VyY2UgY29kZSB3
aGF0IHRoZSBmaXJtd2FyZSBpcyBkb2luZywgdG8gYXZvaWQNCj4gdGhlIGhhcmQgZGVwZW5kZW5j
eSBvbiBhIHNwZWNpZmljIGZpcm13YXJlIHZlcnNpb24gKGltYWdpbmUgdXNlcg0KPiB1cGRhdGlu
ZyBrZXJuZWwtZmlybXdhcmUgLSBjb250YWluaW5nIHZlcnNpb25zIFgsWSxaIC0gYW5kIGtlcm5l
bCBhbmQNCj4gYm9vdGluZyB0d28gZGlmZmVyZW50IGtlcm5lbCB2ZXJzaW9ucywgdGhlIG9sZGVy
IG9uZSBzdG9wcyB3b3JraW5nKS4NCg0KSSdtIGFmcmFpZCBubyBpbnNpZ2h0IGludG8gdGhlIGlu
dGVybmFscyBvZiB0aGlzIGNoaXAsIHNvbWUgZ29vZCBndWVzc3dvcmsgYnV0IEkgdGhpbmsgYSBm
aXJtd2FyZSBibG9iIGlzIHNvbWV0aGluZyB3ZSBhcmUgZ29pbmcgdG8gaGF2ZSB0byBsaXZlIHdp
dGggZm9yIHRoZSB0aW1lIGJlaW5nLg0KDQo+IGh0dHBzOi8vd3d3LnRoZXRoaW5nc25ldHdvcmsu
b3JnL2ZvcnVtL3Qvc2VjcmV0LXByaWNlLW9mLWEtbG9yYS0NCj4gZ2F0ZXdheS81NzMwLzc0DQo+
IA0KPiBSZWdhcmRzLA0KPiBBbmRyZWFzDQo+IA0KPiA+IEkgd2lsbCBkaWcgaW50byB0aGlzIHNl
cmllcyB0aGlzIGV2ZW5pbmcuDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL0JXaGl0
dGVuL2xpbnV4LQ0KPiBzdGFibGUvdHJlZS85NzFhYWRjOGZkZmU4NDIwMjBkOTEyNDQ5YmRkNzFi
MzNkNTc2ZmUzL2RyaXZlcnMvbmV0L2xvcmENCj4gWy4uLl0NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2xvcmEvc3gxMzAxLmMgYi9kcml2ZXJzL25ldC9sb3JhL3N4MTMwMS5jDQo+ID4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNWM5MzZjMTEx
NmQxDQo+ID4+IC0tLSAvZGV2L251bGwNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvbG9yYS9zeDEz
MDEuYw0KPiA+PiBAQCAtMCwwICsxLDQ0NiBAQA0KPiA+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gW3NuaXBdDQoNCkJlbg0K
