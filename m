Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4017120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZMT2Uvzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4017120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeGXMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:40:58 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:64384
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388272AbeGXMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHlOrGEuiKE6djzCa3AUOiOcVgqt879QFc9MRemHw/s=;
 b=ZMT2Uvzi1mvX6ERaAJKcRYy/NrsFeJTFUAUQxfvt5SGQR0vu3VuHcTngtTLOHJuuLuikTFw+6N7x0U4q0trY/HwDWRjStmM1VnfZAVRx9DOAUKGXrdbtjfYYUz0mvKwzabXV3rj5d/6V5MTwqOFfwhPuFQPUOfF5+0qA4tNFsVg=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4723.eurprd04.prod.outlook.com (20.176.214.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Tue, 24 Jul 2018 11:34:49 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 11:34:49 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Thread-Topic: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Thread-Index: AQHUICfkbI++9IJFu0qLZ8faDq/bh6SYPdYAgASGqwCAAGPeAIABG/gA
Date:   Tue, 24 Jul 2018 11:34:48 +0000
Message-ID: <dfad19eec11f7f3affc51f1ecc41d3f6eaa65e7c.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
         <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
         <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
         <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4723;6:auK3tS7XHYEDyeBxXyDEJWcGEqDNADTcRYcWhVzWT2/BF3pGiS596dPU9QveZePUFwKsk3oQMcoFcwItJpy4htRLuJ9fuM7SVPs9Iy4/x1ySWYz1E15QozKLJo2FWe+SFSkO5X9phNw1DT3S+fYGEt/61dPjtJkUEWMUoucEa+n2pW9aT9n6wu5r//pJgV7c6Vt+RJSx+VHpyiFshVvj7M3DneKZTNZWTlZly0PLLiPSckfTgLARLxV5S1vFyH/z9KKNCw28sTzQmdT1w4oQYHFDdvYkmIa312h7uTW6Q9kryjdoMAejSe9f4no+0cZorHIMa4GfkFfOpgR6OaYT6I+kAEqbEyOYal0CdBxyg4wlZOOoazAwcTmnTjVf6EiFzqc6oM26EA8zGjQh9IC43nhiPAxK/CVEh+Yrye1sKhuf3XEewcKNsaHHpXYWbiNbSIoc4wtlcHd9DNf8ltJ0Jw==;5:sPgVHqkymtJX3yEvQINNTKqcJO/KPAj3jMy9qmobzelmbK38S+6gVoRQV1aL7pxeOfUA78oOWwwyzKRssxWIwlTzUgrolBz6BZBN/1exJ7VvfH4jM9MLhKJdej+eK2vIHfAN56SplcAVQ+2vac4OAbAMBDaSY2JDpL9UfST9gJc=;7:H/1rjNaQQmj3QmTSXGcHEoXkjLlSxQGq6MK/H/K0SJEgWb2hcxfGzDFxc6yd0ymOEHMw4cC4O/vH8bXuIVMDipNonpsmR4y83bCNkAq5AGD723a6E37lKlDA1fJhmgQKZvKYOjNdO14xON3RmhNf6mnVycre+iFishSS66nYsZ0MLYRXJpLP3BsAc7ktqexF8m6mq+X0eHfj9mlrrFim//n4TrQR0tTt0UU4dpVFhqecAwSsTxFr034ee/EKuKPV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8b531af0-996b-4a7d-9033-08d5f15976dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4723;
x-ms-traffictypediagnostic: AM0PR04MB4723:
x-microsoft-antispam-prvs: <AM0PR04MB47236D1A168E5262F2D21898EE550@AM0PR04MB4723.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4723;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4723;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(8936002)(2900100001)(81156014)(81166006)(305945005)(97736004)(106356001)(2351001)(7736002)(105586002)(8676002)(66066001)(118296001)(6512007)(229853002)(316002)(26005)(6486002)(6436002)(99286004)(186003)(2906002)(2501003)(53546011)(5250100002)(5640700003)(6506007)(102836004)(1361003)(6246003)(5660300001)(44832011)(6116002)(478600001)(50226002)(3846002)(53936002)(93886005)(256004)(486006)(86362001)(575784001)(36756003)(14454004)(68736007)(446003)(476003)(2616005)(11346002)(54906003)(6916009)(39060400002)(7416002)(4326008)(25786009)(76176011)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4723;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wiGxvBw/1X8g5D2Mv4YHNVzLWY+rvdmGaRnCgJ7vT6wiNT0rgGc1fze/I7XkSrQgmWbPD3MAsnooHhzMgCRpfiAvn7O+CjTrGbvkSxug7MUaveO6Sc7C94Gy2dEskLkOHoPnZkwRrO1wn0k6YWjpzRsG32f0alXQd+ss7GrTgfqV5Xiny0QILLtdcJxgLi/RbQx+z1K3KFxnBekduXC+yxQa3F5ze9gCo5+d7133BsqS1cNMIM59Sa5mZfJEXUPWbnhy7xE+uc/qYcwOYJfJXRKcL/8w1FEW3Oa6FpskGF6pCS/q4KITvKQYx6s9aDWefrXaf5iqX80v1ZJqs+DXExhfe/cGVGSfr9IUrdPHimA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CB98957E755AB458DAF840794A11F46@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b531af0-996b-4a7d-9033-08d5f15976dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 11:34:49.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjM4IC0wNzAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gT24gTW9uLCBKdWwgMjMsIDIwMTggYXQgNTo0MSBBTSBMZW9uYXJkIENyZXN0ZXogPGxlb25h
cmQuY3Jlc3RlekBueHAuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTgtMDctMjAgYXQgMDg6
MzMgLTA3MDAsIEFuZHJleSBTbWlybm92IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdWwgMjAsIDIw
MTggYXQgNTo0OCBBTSBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPiB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgMWM4NmM5ZGQ4MmY4
NTliNDc0NDc0YTdmZWUwZDUxOTVkYTJjOWMxZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQgY29t
bWl0IGZvbGxvd2VkIHRoZSByZWZlcmVuY2UgbWFudWFsIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSBp
bXg3ZA0KPiA+ID4gPiBtYW51YWwgaXMgaW5jb3JyZWN0Lg0KPiA+ID4gDQo+ID4gPiBJJ2QgYWxz
byBhZGQgc2ltaWxhciBjb21tZW50IHRvIERUIGZpbGUgdG8gcHJldmVudCBwZW9wbGUgZnJvbSB0
cnlpbmcNCj4gPiA+IHRvICJmaXgiIHRoaXMgaW4gdGhlIGZ1dHVyZS4NCj4gPiANCj4gPiBJJ2xs
IHRyeSB0byBzZWUgaWYgSSBjYW4gZm9sbG93IHVwIGludGVybmFsbHkgd2l0aCBkb2NzIHRlYW0g
dG8gZ2V0DQo+ID4gdGhpcyB1cGRhdGVkIGluIHRoZSBuZXh0IHJldmlzaW9uIG9mIHRoZSByZWZl
cmVuY2UgbWFudWFsLg0KPiANCj4gTm90IHN1cmUgaWYgd2UgYXJlIG9uIHRoZSBzYW1lIHBhZ2Ug
aGVyZSwgYnV0IHdoYXQgSSBtZWFudCBpcyBhZGRpbmcNCj4gdGhlIHNhbWUgZXhwbGFuYXRpb24g
dGhhdCBpcyBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlIHRvIERldmljZSBUcmVlDQo+IGZpbGUgYXMg
d2VsbCBzbyB0aGF0IGlmIGFueW9uZSBsb29rcyBhdCBEVCBjb2RlIGFuZCBnb2VzICJIdWg/IiBp
biB0aGUNCj4gZnV0dXJlLCB0aGV5IHdvdWxkbid0IGhhdmUgdG8gcmVzZWFyY2ggY29tbWl0IGhp
c3RvcnkgdG8gc2VlIHRoZQ0KPiByZWFzb24gd2h5IHRoaW5ncyB0aGUgd2F5IHRoZXkgYXJlLg0K
DQpPSywgSSB3aWxsIGFkZCBhIGNvbW1lbnQgb24gaXJxIG1hcHBpbmdzIGluIHRoZSBuZXh0IHZl
cnNpb24gZXhwbGFpbmluZw0KdGhhdCB0aGUgcmVmZXJlbmNlIG1hbnVhbCBpcyBpbmNvcnJlY3Qu
DQoNCj4gPiA+IEFsc28sIHRoaXMgY2hhbmdlIGlzIGdvaW5nIHRvIGJyZWFrIFFFTVUncyBtYXBw
aW5nIGZvdW5kIGhlcmU6DQo+ID4gDQo+ID4gSSBoYWQgbm8gaWRlYSB0aGF0IGV4aXN0ZWQsIEkg
Z3Vlc3Mgc29tZWJvZHkgbmVlZHMgdG8gZml4IHRoYXQgYXMgd2VsbC4NCj4gDQo+IEkgdGFrZSBp
dCBpdCdzIGEgbm8gdG8gbXkgImFueSBjaGFuY2UgeW91IGNhbiBmaXggdGhhdCBhcyB3ZWxsPyIg
Oy0pLg0KPiBJJ2xsIHNlZSBpZiBJIGNhbiBmaW5kIHRpbWUgdG8gZG8gdGhhdCB0aGlzIHdlZWsu
DQoNClNvcnJ5LCBJJ20gbm90IGZhbWlsaWFyIHdpdGggcWVtdSBzb3VyY2UgYXQgYWxsLg==
