Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838EFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6D42242C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="QhblGVl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6D42242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHJVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:14:28 -0400
Received: from mail-bn3nam01on0112.outbound.protection.outlook.com ([104.47.33.112]:36122
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbeHJVO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW0tX19p1IZKe9qstx0wItLXgu+PPIbQgvnN0PKgBbw=;
 b=QhblGVl5nt+qXEz0TmWDGpUkFEb8Jwstm26zhQRxeKq/x4dQBKeX2LuWUATSf/IqzN6Y/O/q3n1VUyWIs+1czdhyIrXCAqX2PWXbFSQVqLFpPcLDXoY3GImbI+PO8ZxCMfJMJnQFHbdeBk6zV5RZTmVlwFVy7UiEMA9NpzjTnNU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.21; Fri, 10 Aug 2018 18:43:20 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864%2]) with mapi id 15.20.1038.023; Fri, 10 Aug 2018
 18:43:20 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "dianders@chromium.org" <dianders@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Thread-Topic: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Thread-Index: AQHT4yafyeQn7soaS0qz4ku89UJpHKQrKQSAgA9INYCAAaFigIAADB0AgAMSxQCAAAEJAIBvT2e2gAnOcoCAAAWfAIAAFKEAgAGDGAA=
Date:   Fri, 10 Aug 2018 18:43:20 +0000
Message-ID: <1533926600.2283.358.camel@impinj.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
         <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
         <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
         <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
         <20180522173000.GG24776@sirena.org.uk>
         <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
         <20180524162940.GA4828@sirena.org.uk>
         <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
         <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
         <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
         <1533839042.2283.305.camel@impinj.com>
         <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3771;6:H3nNFGsMi2g7B6roZzjFhfaud0qRB0UJDDVbu61hPTuv5+/teFU+SEZ87VxXFKgKGrEKmTi5mJ065WPPrbpEYhKBp3/eo/3RXwqLn7K8nJAp/+XVfURr4sSJcW3igI3xt1K9lYw7JgV9EWZDTJstWvaB7DV6+whXl1Sn6LW5CjHFWDLgy1wuTm7SIu6dckVkSUTH8x7Vs5SIflLbDlEC07qGdvWJitMP80SXY6Z7bNY4Gfk7qOdMIsm/QH2hdFxB9Zv7amr8o3YsrGy5OMF22s5XFD7vFtPKc/Yr+UTqjVFPiTAhmkz0H+zJ2Fwpj8zXEH/GGpuUAUa6Mg1fR6Cc5cUTuIVBdMk9qgApV1rcJ0KRg1JeHFdaehDYA0MpBQnwkYS9E2X12MPL1IL9stCgVDdVLBvKPaSjB0eNeNVcYtFTfc7DMcqpNg001I8kTrIKnYz8GIS7cCRM+crFCgEUug==;5:Hu0QxE8iaQGLnVSJyxaZIjZyHtrM0a0eP264xSwj5Pr6wFflsHpHGL7mZjCUuyv16OeUQxcnTt99PyeYynl+Atfg5LcpwauJX40ls9B731duqXiOMpJOmWj5UDRO1xHhWKQ00IomQ6CUu5t8gIWF3lok0in5LheP9O62Ga3Wf/s=;7:T8nuAcaW1O4AZcv4B44ufXEGVkk7BEY4XdVqBXfJeXrkKTzExfD6Zrr0ZkZXSQ07EeDvFkLtiDfCcFTB2SvCyJN0+jHR+lsFmZdIr2utm+ZcLGdjZiyB+lrnKYZgc15mL0lfMXl4E5Ub1loMU9+XUJO+7XuyzsdaP6oOzqm1Aax8yvt7D5UdC3xzuEi5HEpdeZF65q4gjDNxMr0kr5Wlz5IsI+kxfZqQW/P7um57PwhXjG087JT/2yshVk0TAf0Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b7f42c9f-75e7-4e4d-4a90-08d5fef12548
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3771;
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-antispam-prvs: <MWHPR0601MB37716637048E7A51CA756073D3240@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3771;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3771;
x-forefront-prvs: 07607ED19A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39850400004)(346002)(376002)(189003)(199004)(93886005)(99286004)(3846002)(6116002)(2501003)(103116003)(7736002)(86362001)(53546011)(54906003)(102836004)(26005)(4326008)(25786009)(106356001)(6512007)(6486002)(5250100002)(5640700003)(229853002)(6436002)(53936002)(36756003)(97736004)(2906002)(6916009)(6246003)(105586002)(316002)(66066001)(2616005)(8676002)(256004)(478600001)(14444005)(446003)(81156014)(81166006)(8936002)(68736007)(1730700003)(486006)(11346002)(76176011)(186003)(305945005)(6506007)(476003)(14454004)(2351001)(2900100001)(7416002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3771;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jSygiWGWWDfzz8/a+CasfzyZ1xneKDrxhNGsFl4oiF77aGiG5HqsoRNTUs/Eibc1aJ0JIpaTm2ELWOg8+nNDLR0ehu3Gaq5/BihBAKZE1Dh6LZd2LOEVCZEKc4hpviCKd5OISdphZVggcW4tov2N0thZ2GEmbHAJemok9u7vGZtDOhgI4CWem9QVTgvb0suJeReJUr7nnC2dzHtgJ4YE661Xhinre6f/P3HWnIxjAvZfkARUIRzQtlYPkF8KrvEOJo51mOwyiyvbChNekYSUqRuVaeTMCMP2W+vN6v215OYLvKZVOTyNc/OC5BxKzgISdraHCYPdaRMjedVqF5GrMjQ4S2veZh2eC17gZCgRhKE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <03018E91C631B542897077574CC2F32A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f42c9f-75e7-4e4d-4a90-08d5fef12548
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2018 18:43:20.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTA5IGF0IDEyOjM3IC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyA5LCAyMDE4IGF0IDExOjI0IEFNLCBUcmVudCBQaWVwaG8gPHRwaWVwaG9A
aW1waW5qLmNvbT4gd3JvdGU6DQo+ID4gDQo+IEkgdGhpbmsgd2UncmUgaW4gYWdyZWVtZW50IGJ1
dCBwZXJoYXBzIHRoZXJlJ3MgYSBtaXNjb21tdW5pY2F0aW9uIGhlcmU/DQo+IA0KPiBJJ20gc2F5
aW5nIHRoYXQgd2UgX3Nob3VsZG4ndF8gcHV0IHRoZSBtYXgtc3BlZWQgb2YgdGhlIG1hc3RlciBp
biB0aGUNCj4gZGV2aWNlIHRyZWUuICBUaGUgbWF4IHNwZWVkIGZvciB0aGUgSVAgYmxvY2sgb3Vn
aHQgdG8gYmUgaW4gY29kZQ0KPiBlaXRoZXIgaW4gdGhlIGNsb2NrIGRyaXZlciBvciBpbiB0aGUg
U1BJIGRyaXZlciBiYXNlZCBvbiB0aGUNCj4gY29tcGF0aWJsZSBzdHJpbmcuDQoNClllcywgdG90
YWxseSBhZ3JlZS4NCg0KVXN1YWxseSB0aGUgY2xvY2sgZnJhbWV3b3JrIHByb3ZpZGVzIGEgY2xv
Y2sgdG8gdGhlIFNQSSBJUCBibG9jayBhdA0Kc29tZSByYXRlLCBvciByYW5nZSBvZiByYXRlcy4g
IEJhc2VkIG9uIHRoYXQgY2xvY2ssIHRoZSBTUEkgSVAgYmxvY2sNCmhhcyBhIG1heCBTUEkgY2xv
Y2ssIGFuZCB0aGUgZHJpdmVyIGNhbiBjYWxjdWxhdGUgaXQuDQoNCldlIGRvIGhhdmUgYSBjb25j
ZXB0IG9mIGEgU1BJIG1hc3RlciBtYXggY2xvY2ssIGJ1dCBpdCdzIG5ldmVyIG5lZWRlZA0KdG8g
YmUgc3BlY2lmaWVkIGluIHRoZSBEVC4NCg0KQ29uc2lkZXIgdXNlcnNwYWNlIGFjY2VzcyB2aWEg
c3BpZGV2LiAgVGhlIHRyYW5zZmVyIGFza3MgZm9yIDEwMCBNSHosDQpidXQgdGhlIHNwaSBtYXN0
ZXIgZHJpdmVyIGNhbiBub3QgcG9zc2libHkgcHJvZ3JhbSB0aGF0IHNwZWVkIGludG8NCndoYXRl
dmVyIHJlZ2lzdGVyKHMpIGNvbnRyb2wgdGhlIHNwaSBjbG9jay4gIFRoZSBTUEkgY29yZSBoYW5k
bGVzIHRoYXQNCmNhc2Ugb2YgbGltaXRpbmcgYSB0cmFuc2ZlciB0byB0aGUgbWFzdGVyJ3MgbWF4
Lg0KDQo+IC4uLmFzIG9uZSBhcmd1bWVudCBfYWdhaW5zdF8gcHV0dGluZyBhIG1heC1zcGVlZCBm
b3IgdGhlIG1hc3RlciBpbiB0aGUNCj4gZGV2aWNlIHRyZWUgSSdtIHNheWluZyB0aGF0IHdlIGNh
biBhbHJlYWR5IHNwZWNpZnkgYSBtYXgtc3BlZWQgb2YgZWFjaA0KPiBzbGF2ZSBpbiB0aGUgZGV2
aWNlIHRyZWUuICBUaGUgbWF4IHNwZWVkIG9mIHRoZSBzbGF2ZSBzaG91bGQgdGFrZSBpbnRvDQo+
IGFjY291bnQgd2hhdGV2ZXIgZmFjdG9ycyBhcmUgc3BlY2lmaWMgdG8gdGhpcyBib2FyZCBpbmNs
dWRpbmcgdHJhY2UNCj4gbGVuZ3Rocywgbm9pc2UsIGV0Yy4gIElmIHdlIHNvbWVob3cgZGlkIG5l
ZWQgdG8gZ2V0IGEgbWF4IHNwZWVkIGluIHRoZQ0KPiBkZXZpY2UgdHJlZSBpdCBzZWVtcyBsaWtl
IHdlIGNvdWxkIGp1c3QgYWRqdXN0IHRoZSBtYXggc3BlZWQgZm9yIHRoZQ0KPiBzbGF2ZSB0byBi
ZSBzb21ldGhpbmcgbG93ZXIuICBJbiBvdGhlciB3b3JkcyBpZiB5b3Uga25vdyBhIGJvYXJkIGhh
cw0KPiBhbiBzZG04NDUgb24gaXQgYW5kIHlvdSBrbm93IHRoYXQgdGhlIFNQSSBjbG9jayBvbiBz
ZG04NDUgY2FuJ3QgZ28NCj4gb3ZlciA1MCBNSHogdGhlbiBpdCB3b3VsZCBtYWtlIG5vIHNlbnNl
IHRvIHN1Z2dlc3QgdGhhdCB3ZSBzaG91bGQgcnVuDQo+IHRoZSBTUEkgY2xvY2sgZm9yIGEgZGV2
aWNlIGF0IDEwMCBNSHouDQoNCldoYXQgeW91IG1pZ2h0IGRvIGlzIGRldGVybWluZSB0aGUgc2xh
dmUgY2FuIHJ1biBhdCAxMDAgTUh6LCBpbiBzb21lDQpjYXNlcy4gIFRoZSBib2FyZCwgdHJhY2Vz
LCBtYXN0ZXIsIGV0Yy4gY2FuIGRvIGl0LCBpbiBzb21lIGNhc2VzLiAgQnV0DQppdCdzIGFsc28g
cG9zc2libGUgdG8gY2hhbmdlIHRoZSBjbG9ja2luZyBkZXNpZ24gb3Igc2V0dGluZ3MgYXQgYQ0K
aGlnaGVyIGxldmVsLCB3aGljaCB0cmlja2xlcyBkb3duIHRvIHRoZSBTUEkgbWFzdGVyIElQIGJs
b2NrIGhhdmluZyBhDQpsb3dlciBjbG9jay4gIFRoaXMgaXMgaGFuZGxlZCBieSB0aGUgbWFzdGVy
IG1heCBzcGVlZCBiZWluZyBsZXNzIHRoZW4NCnRoZSBzbGF2ZSdzIG1heCBzcGVlZC4NCg0KVGhl
IG1hc3RlciBtYXggd291bGRuJ3QgYmUgaW4gdGhlIERULCBzaW5jZSBpdCdzIHByb2JhYmx5IGRl
dGVybWluZWQgYXQNCnJ1biB0aW1lIGJhc2VkIG9uIGlucHV0IGNsb2NrIHRvIHRoZSBtYXN0ZXIu
ICBCYXNlZCBvbiB0aGUgU29DIGNvcmUNCmNsb2NrLCB2b2x0YWdlLCBwb3dlciBtb2RlLCBldGMu
DQoNClNvIHlvdSBtaWdodCBoYXZlIGEgRFQgd2l0aCBhIHNsYXZlIGF0IDEwMCBNSHosIGV2ZW4g
aWYgaW4gc29tZSBjYXNlcw0KdGhlIG1hc3RlcidzIG1heCBpcyBsZXNzIHRoYW4gMTAwIE1Iei4g
IEl0J3Mgb2sgdG8gZGVwZW5kIG9uIHRoZSBtYXN0ZXINCnRvIGJlIHRoZSBsaW1pdGluZyBmYWN0
b3Iu
