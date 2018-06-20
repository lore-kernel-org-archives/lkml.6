Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47ACC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BA420871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ppxTAM+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BA420871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeFTD2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:28:14 -0400
Received: from mail-ve1eur01on0071.outbound.protection.outlook.com ([104.47.1.71]:50688
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753930AbeFTD2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF78TOWhYYQD4ZKvfCtLhxAd13z/wCymHqd/jiskZeY=;
 b=ppxTAM+pS4ViZmyYATZmjdQKTvnReViGt2sIFc1Y/ONDTbKEubev8WoR5hb5XwRe4mFoDw/TeOptPGjrHztIiIsJmI8JW5Bq+soefnuX2dpylbepTxQjuomFxJqcVpNJzVZqycrOg8RSPGa8VUeFHRIxA09P82dQ9bnlj9tVsIw=
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com (10.163.176.12) by
 HE1PR04MB2155.eurprd04.prod.outlook.com (10.166.76.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Wed, 20 Jun 2018 03:28:05 +0000
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449]) by HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449%4]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 03:28:05 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] usb: xhci: Two possible sleep-in-atomic-context bugs
Thread-Topic: [BUG] usb: xhci: Two possible sleep-in-atomic-context bugs
Thread-Index: AQHUCEST6+XhPWL3tEiBLZqxtL7PRKRofDPQ
Date:   Wed, 20 Jun 2018 03:28:04 +0000
Message-ID: <HE1PR04MB14501B0EC65D993623D96A168B770@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <a2f62eac-b3e1-bd1e-3993-83e2f6adef03@gmail.com>
In-Reply-To: <a2f62eac-b3e1-bd1e-3993-83e2f6adef03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB2155;7:XdUj20e1UC2xrkBxrPlsi6hvhB20vzChkv0BkDneRBiqLHkJJNF9bX4+sRx1ERuG13PW9mu0eD1Siayx7A7sP6AE97GcXYg+sM2lHrXm7PBjHYW95MfL07YYHgKt/H1Pjbs0oenX7602l1bM/vVXyyCsEGeCcn3N68tZ+PzjJQER8vF79Xn9mwsET54LX4GU1iv5UjcGncPGr7gc5RvMxzVDVTX7C3uha3ijvUBi34N3WBgIVWpIElNpCCWvTwBP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1720e1f2-0d20-4bec-1085-08d5d65dd5d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB2155;
x-ms-traffictypediagnostic: HE1PR04MB2155:
x-microsoft-antispam-prvs: <HE1PR04MB2155ADA6E60AED70E60B742D8B770@HE1PR04MB2155.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB2155;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB2155;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(229853002)(66066001)(74316002)(68736007)(39060400002)(6246003)(5660300001)(53936002)(81166006)(105586002)(81156014)(6436002)(8676002)(3280700002)(33656002)(2900100001)(25786009)(4326008)(7736002)(3660700001)(305945005)(106356001)(3846002)(6506007)(6116002)(316002)(2906002)(110136005)(54906003)(59450400001)(99286004)(7696005)(102836004)(76176011)(476003)(11346002)(446003)(2201001)(55016002)(26005)(86362001)(486006)(14454004)(186003)(44832011)(9686003)(478600001)(8936002)(97736004)(5250100002)(2501003)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB2155;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UHnI4GAg9HaFWaQ2pSBqJnIQeES52uLTMU4orba85NT4cOSVZVF6vIRTrj91EcKIhoasOsamG5qJO3H4ymfZ2ax6Lo7a9vCk7y+oKkLpmXPKByEraGSyl3FF/Xh251JD7zL3cyRJJfOcxzeIvht4pb2SX4j8lNWrd0oYvmf9z6l+TP/041oMlSbaVUUmGmQZtqFVunF0kPYF94a17vd2vH/XUOJQnaLSon+e3BvKr42hv0gZXxX/eoO0i4WYUG46bB2J2hV8S0lcvaKqNzLtJxux9HXtHBmO/6AXdzC39yClEPdjB//RuutxFxJwwuys3BmqEVa9fiiv3KiNbi6mZg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1720e1f2-0d20-4bec-1085-08d5d65dd5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 03:28:04.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gVGhlIGRyaXZlciBtYXkgc2xlZXAgd2l0aCBob2xkaW5nIGEgc3BpbmxvY2suDQo+
IFRoZSBmdW5jdGlvbiBjYWxsIHBhdGhzIChmcm9tIGJvdHRvbSB0byB0b3ApIGluIExpbnV4LTQu
MTYuNyBhcmU6DQo+IA0KPiBbRlVOQ10gc2NoZWR1bGUNCj4gZHJpdmVycy9iYXNlL3Bvd2VyL3J1
bnRpbWUuYywgNzQxOiBzY2hlZHVsZSBpbiBycG1fcmVzdW1lDQo+IGRyaXZlcnMvYmFzZS9wb3dl
ci9ydW50aW1lLmMsIDEzMjI6IHJwbV9yZXN1bWUgaW4gcG1fcnVudGltZV9mb3JiaWQNCj4gZHJp
dmVycy91c2IvaG9zdC94aGNpLWh1Yi5jLCA2NDc6IHBtX3J1bnRpbWVfZm9yYmlkIGluIHhoY2lf
ZW50ZXJfdGVzdF9tb2RlDQo+IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1odWIuYywgNjMyOiBfcmF3
X3NwaW5fbG9ja19pcnFzYXZlIGluIHhoY2lfZW50ZXJfdGVzdF9tb2RlDQo+IA0KPiBbRlVOQ10g
c2NoZWR1bGUNCj4gZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYywgNTcwOiBzY2hlZHVsZSBp
biBycG1fc3VzcGVuZA0KPiBkcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jLCA0MzQ6IHJwbV9z
dXNwZW5kIGluIHJwbV9pZGxlDQo+IGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMsIDEzNDM6
IHJwbV9pZGxlIGluIHBtX3J1bnRpbWVfYWxsb3cNCj4gZHJpdmVycy91c2IvaG9zdC94aGNpLWh1
Yi5jLCA2NzA6IHBtX3J1bnRpbWVfYWxsb3cgaW4geGhjaV9leGl0X3Rlc3RfbW9kZQ0KPiBkcml2
ZXJzL3VzYi9ob3N0L3hoY2ktaHViLmMsIDEzODc6IHhoY2lfZXhpdF90ZXN0X21vZGUgaW4geGhj
aV9odWJfY29udHJvbA0KPiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktaHViLmMsIDEwMzg6IF9yYXdf
c3Bpbl9sb2NrX2lycXNhdmUgaW4geGhjaV9odWJfY29udHJvbA0KPiANCj4gVGhlc2UgYnVncyBh
cmUgZm91bmQgYnkgbXkgc3RhdGljIGFuYWx5c2lzIHRvb2wgKERTQUMtMikgYW5kIGNoZWNrZWQg
YnkgbXkgY29kZQ0KPiByZXZpZXcuDQo+IA0KDQpJIGRvbid0IHRoaW5rIHJ1bnRpbWUgUE0gQVBJ
IGlzIG5lZWRlZCBhdCB4aGNpX2h1Yl9jb250cm9sIHNpbmNlIHRoZSBjb250cm9sbGVyIHNob3Vs
ZA0KYmUgYWx3YXlzIGFjdGl2ZSwgTWF0aGlhcywgZG8geW91IGFncmVlIEkgZGVsZXRlIHBtX3J1
bnRpbWVfZm9yYmlkIGFuZCBwbV9ydW50aW1lX2FsbG93IA0KdG8gZml4IHRoaXMgaXNzdWU/DQoN
ClBldGVyDQo=
