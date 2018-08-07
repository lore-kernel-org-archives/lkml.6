Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F82C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B55721533
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="n5z4EP64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B55721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbeHGTZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:25:56 -0400
Received: from mail-eopbgr700131.outbound.protection.outlook.com ([40.107.70.131]:25120
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389160AbeHGTZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM7Qbh4YcVJKsdKpA1Hg9K28usjpwABEZspG4rj4ThY=;
 b=n5z4EP64ErG7ucusruA+yBWp2PaozfbxZfR2SWpdt6MKeEkanBzmUOb4xppZ1Sv/++BlDXUldtYijAaraxxiG3WKlr1nl63Ucxj4oo7XwhYeEBAwQu6jeByg0rER53q606dOPsFbbfn+VbugMYrDmfWD+4Rckoy97XYHkSR4Iuk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3660.namprd06.prod.outlook.com (10.167.236.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Tue, 7 Aug 2018 17:10:27 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96%5]) with mapi id 15.20.1017.018; Tue, 7 Aug 2018
 17:10:19 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Thread-Topic: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Thread-Index: AQHULjuRfYB0X6KwZUqouw6VboXAR6S0hpAA
Date:   Tue, 7 Aug 2018 17:10:19 +0000
Message-ID: <1533661818.2283.264.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
         <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
In-Reply-To: <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3660;6:lgS6GqH9cYqhtjo5rJNR/y0lY+in7jZdrfc3fY9F4nBMJ5qQuFeRer47BpO/VjqPdZQFVombU57dvOAvChTede+cfDXhBFpg1NvOTfCAoRmGulnfJ2mbOp/2z2bHxKovrEISyac+WP+SoGr1PCGv4vNt2tI/6E8heTdaZGXRKUzp1k5v+OWI/WbaPG40aWA/NzzPdd5gI5FFi6Nc+Ev/kCwwNXLN4Sb+wVMk0VfqpqXMVKkg4jcZE2wV5P/ymZQD5iQL5W6EQpUVKwqnW5xCHOkCsx12XuI+H3N4aPJA2vODu5I2ogsQtkHsrZ7x0QCgnHGNCQJXlWkKeOh3oUAZOT4qz62ZYf6JGf78TFTtpxpVe3tC1T0KCSMTSQsKKPxMWZkojEygIUKcYPUTARmQsMDW+8C4igaRFI/24ffEuB+b4tz/Q0lgPoNShtHscCQNNbfG+r/l+eQanREoKcGYJA==;5:pTvlI6Q/pcJtBqU47VErVg25qlpdg7Nkphh4OSR6J+LBzBb/huTworcznlhPzFdosUZc/aRPpycoNygsR2zQ/G9ZpveS+hZJqmRBTKs8dRIoRA+rN5gYEbg3CocGrFiX8c5dss0stA27IpWDnSC5bGTD2VmwG5aFOIecmNhyWN0=;7:5VaBwrCF1Vv8HcbUGtQ1oylkxY9fsZhXbOzPU2KuZ7o+t7iihaYlHLksl3k9hk0s+Uag+RRAbUcMnjctc+xz9CuehejtTu2hOTxOLsDGbjvyOYQXY26amZ1ALEqskhGPby37gZPNFcAhbR80ji49D6iKbEVZZUU2iZs29k8YZlHUMISP+WFBrRLIgO0U4Zj/GnLRIux29tL67F8TvBS0b/KqRYEe2WH1DtZpX3US4qwNAyv+ckf1UBIVgmhxCh6l
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 73c1c968-40f3-4f1c-3aa6-08d5fc88a747
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3660;
x-ms-traffictypediagnostic: MWHPR0601MB3660:
x-microsoft-antispam-prvs: <MWHPR0601MB366075269D70F8B29E6B2AC2D3270@MWHPR0601MB3660.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3660;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3660;
x-forefront-prvs: 0757EEBDCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(2501003)(105586002)(6116002)(6486002)(7416002)(39060400002)(4326008)(106356001)(229853002)(103116003)(5250100002)(36756003)(97736004)(102836004)(66066001)(11346002)(2616005)(2906002)(446003)(110136005)(6506007)(26005)(316002)(478600001)(186003)(14454004)(3846002)(6246003)(476003)(8936002)(486006)(305945005)(8676002)(68736007)(81156014)(54906003)(6512007)(76176011)(53936002)(2900100001)(7736002)(256004)(81166006)(99286004)(25786009)(2201001)(5660300001)(86362001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3660;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9iIswSMPI6YySO1k0WDC8vEIAV/2kkgTx5zcNK7L7q5wr/krNKCEnssSPBmNuQqnIRB8iNdoT3cueVrGyRKNf2Nc+WicutrCZLUkCLiZ3l3cv4nBVHv66TQnqvcUzQ+wFV3cITM2rpHwLa9Gry1LILyR46tKKY4wzYDCyjL/w+yx6IXslol5s+THCcNyHyzFjanXUuCy9d0LkTaFJ9jMFaXl3xm60X0XmOAOiUQYolPDAFSGVMrrzqYAT4bQY+QdtKKEourUYziQGEOPRWtnzShUxtIdiC3jxlkjB3Sgmvyd8+y9NsklY+bXEeROtYKJcmQQToLxzWvnimbU5ABBW8iuIM+kXBywIwzqLdLxf+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <94309D1679973546936565B367D20CB1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c1c968-40f3-4f1c-3aa6-08d5fc88a747
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 17:10:19.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTA3IGF0IDE4OjQzICswODAwLCBCYW9saW4gV2FuZyB3cm90ZToNCj4g
DQo+ICtzdGF0aWMgdTMyIHNwcmRfc3BpX3RyYW5zZmVyX21heF90aW1lb3V0KHN0cnVjdCBzcHJk
X3NwaSAqc3MsDQo+ICsJCQkJCSBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp0KQ0KPiArew0KPiArCS8q
DQo+ICsJICogVGhlIHRpbWUgc3BlbnQgb24gdHJhbnNtaXNzaW9uIG9mIHRoZSBmdWxsIEZJRk8g
ZGF0YSBpcyB0aGUgbWF4aW11bQ0KPiArCSAqIFNQSSB0cmFuc21pc3Npb24gdGltZS4NCj4gKwkg
Ki8NCj4gKwl1MzIgc2l6ZSA9IHQtPmJpdHNfcGVyX3dvcmQgKiBTUFJEX1NQSV9GSUZPX1NJWkU7
DQo+ICsJdTMyIGJpdF90aW1lX3VzID0gU1BSRF9TUElfSFogLyB0LT5zcGVlZF9oeiArIDE7DQo+
ICsJdTMyIHRvdGFsX3RpbWVfdXMgPSBzaXplICogYml0X3RpbWVfdXM7DQo+ICsJLyoNCj4gKwkg
KiBUaGVyZSBpcyBhbiBpbnRlcnZhbCBiZXR3ZWVuIGRhdGEgYW5kIHRoZSBkYXRhIGluIG91ciBT
UEkgaGFyZHdhcmUsDQo+ICsJICogc28gdGhlIHRvdGFsIHRyYW5zbWlzc2lvbiB0aW1lIG5lZWQg
YWRkIHRoZSBpbnRlcnZhbCB0aW1lLg0KPiArCSAqDQo+ICsJICogVGhlIGludGV2YWwgY2FsY3Vs
YXRpb24gZm9ybXVsYToNCj4gKwkgKiBpbnRlcnZhbCB0aW1lIChzb3VyY2UgY2xvY2sgY3ljbGVz
KSA9IGludGVydmFsICogNCArIDEwLg0KPiArCSAqLw0KPiArCXUzMiBpbnRlcnZhbF9jeWNsZSA9
IFNQUkRfU1BJX0ZJRk9fU0laRSAqICgoc3MtPmludGVydmFsIDw8IDIpICsgMTApOw0KPiArCXUz
MiBpbnRlcnZhbF90aW1lX3VzID0gaW50ZXJ2YWxfY3ljbGUgKiBTUFJEX1NQSV9IWiAvIHNzLT5z
cmNfY2xrICsgMTsNCg0KSWYgaW50ZXJ2YWwgaXMgZ3JlYXRlciB0aGFuIDMxLCB0aGlzIHdpbGwg
b3ZlcmZsb3cuDQoNCkFsc28gU1BSRF9TUElfSFogaXMgbm90IHRoZSBzcGVlZCBhbnl0aGluZyBy
dW5zIGF0LCBhcyBvbmUgbWlnaHQgdGhpbmsNCmZyb20gdGhlIG5hbWUuICBJdCdzIHRoZSBudW1i
ZXIgb2YgbWljcm9zZWNvbmRzIGluIGEgc2Vjb25kLiAgVGhlIGlzDQphbHJlYWR5IGEgTGludXgg
bWFjcm8gZm9yIHRoYXQsIFVTRUNfUEVSX1NFQywgdGhhdCB5b3Ugc2hvdWxkIHVzZQ0KaW5zdGVh
ZC4NCg0KPiArDQo+ICsJcmV0dXJuIHRvdGFsX3RpbWVfdXMgKyBpbnRlcnZhbF90aW1lX3VzOw0K
PiArfQ0KPiArDQoNCg0KPiArc3RhdGljIHZvaWQgc3ByZF9zcGlfc2V0X3NwZWVkKHN0cnVjdCBz
cHJkX3NwaSAqc3MsIHUzMiBzcGVlZF9oeikNCj4gK3sNCj4gKwkvKg0KPiArCSAqIEZyb20gU1BJ
IGRhdGFzaGVldCwgdGhlIHByZXNjYWxlIGNhbGN1bGF0aW9uIGZvcm11bGE6DQo+ICsJICogcHJl
c2NhbGUgPSBTUEkgc291cmNlIGNsb2NrIC8gKDIgKiBTUElfZnJlcSkgLSAxOw0KPiArCSAqLw0K
PiArCXUzMiBjbGtfZGl2ID0gc3MtPnNyY19jbGsgLyAoc3BlZWRfaHogPDwgMSkgLSAxOw0KDQpZ
b3Ugc2hvdWxkIHByb2JhYmx5IHJvdW5kIHVwIGhlcmUuICBUaGUgY29udmVudGlvbiBpcyB0byB1
c2UgdGhlDQpjbG9zZXN0IHNwZWVkIGxlc3MgdGhhbiBlcXVhbCB0byB0aGUgcmVxdWVzdGVkIHNw
ZWVkLCBidXQgc2luY2UgdGhpcyBpcw0KYSBkaXZpZGVyLCByb3VuZGluZyBpdCBkb3duIHdpbGwg
c2VsZWN0IHRoZSBuZXh0IGhpZ2hlc3Qgc3BlZWQuDQoNCj4gKw0KPiArCXdyaXRlbF9yZWxheGVk
KGNsa19kaXYsIHNzLT5iYXNlICsgU1BSRF9TUElfQ0xLRCk7DQo+ICt9DQo+ICsNCg0KPiArDQo+
ICtzdGF0aWMgaW50IHNwcmRfc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICt7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0K
PiArCXN0cnVjdCBzcGlfY29udHJvbGxlciAqc2N0bHI7DQo+ICsJc3RydWN0IHJlc291cmNlICpy
ZXM7DQo+ICsJc3RydWN0IHNwcmRfc3BpICpzczsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcGRl
di0+aWQgPSBvZl9hbGlhc19nZXRfaWQocGRldi0+ZGV2Lm9mX25vZGUsICJzcGkiKTsNCj4gKwlz
Y3RsciA9IHNwaV9hbGxvY19tYXN0ZXIoJnBkZXYtPmRldiwgc2l6ZW9mKCpzcykpOw0KPiArCWlm
ICghc2N0bHIpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJc3MgPSBzcGlfY29udHJv
bGxlcl9nZXRfZGV2ZGF0YShzY3Rscik7DQo+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5w
LCAic3ByZCxzcGktaW50ZXJ2YWwiLCAmc3MtPmludGVydmFsKSkNCj4gKwkJc3MtPmludGVydmFs
ID0gU1BSRF9TUElfSVRWTF9OVU07DQo+ICsNCj4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCXNzLT5iYXNlID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsJaWYgKElTX0VSUihzcy0+YmFzZSkpIHsN
Cj4gKwkJcmV0ID0gUFRSX0VSUihzcy0+YmFzZSk7DQo+ICsJCWdvdG8gZnJlZV9jb250cm9sbGVy
Ow0KPiArCX0NCj4gKw0KPiArCXNzLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiArCXNjdGxyLT5kZXYu
b2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArCXNjdGxyLT5tb2RlX2JpdHMgPSBTUElf
Q1BPTCB8IFNQSV9DUEhBIHwgU1BJXzNXSVJFIHwgU1BJX1RYX0RVQUw7DQo+ICsJc2N0bHItPmJ1
c19udW0gPSBwZGV2LT5pZDsNCj4gKwlzY3Rsci0+c2V0dXAgPSBzcHJkX3NwaV9zZXR1cDsNCj4g
KwlzY3Rsci0+c2V0X2NzID0gc3ByZF9zcGlfY2hpcHNlbGVjdDsNCj4gKwlzY3Rsci0+dHJhbnNm
ZXJfb25lID0gc3ByZF9zcGlfdHJhbnNmZXJfb25lOw0KPiArCXNjdGxyLT5tYXhfc3BlZWRfaHog
PSAoc3MtPnNyY19jbGsgLyAyKSA8IFNQUkRfU1BJX01BWF9TUEVFRF9IWiA/DQo+ICsJCXNzLT5z
cmNfY2xrIC8gMiA6IFNQUkRfU1BJX01BWF9TUEVFRF9IWjsNCg0KWW91IGNhbiB3cml0ZSB0aGlz
IGFzOg0KICAgICAgICBzY3Rsci0+bWF4X3NwZWVkX2h6ID0gbWluKHNzLT5zcmNfY2xrIC8gMiwg
U1BSRF9TUElfTUFYX1NQRUVEX0haKTsNCg==
