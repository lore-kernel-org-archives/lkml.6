Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F25C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB1824619
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1824619
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935039AbeF0QNr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:13:47 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:50038 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934758AbeF0QNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:13:44 -0400
Received: from G4W9119.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 052CC7F;
        Wed, 27 Jun 2018 16:13:41 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 27 Jun 2018 16:13:25 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 27 Jun 2018 16:13:24 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1044.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Wed, 27 Jun 2018 16:13:22 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.018; Wed, 27 Jun 2018
 16:13:22 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Topic: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Thread-Index: AQHUDiFnEX50gQPXr0aGJMF/fXfE2KR0QpSAgAAEJ4A=
Date:   Wed, 27 Jun 2018 16:13:22 +0000
Message-ID: <1530115885.14039.295.camel@hpe.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
         <20180627141348.21777-3-toshi.kani@hpe.com>
         <20180627155632.GH30631@arm.com>
In-Reply-To: <20180627155632.GH30631@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1044;7:jnRQFctSEFaA7PUrL0s1fl25+BVtA/b5tbVIy/KKlulGIiHjQg6/0GNNlgkbB2TGki0hkElfg/h8fiI+0fdwC/tC2xwJG9L4xVW4k+RUxlku1xvNYCSIKUPwGSXb7BagdP2E8oAa0O9qM9HDUUmnjAiGILJarzELU3zdNFSlBwlprMwpda5TXb1RdVzuN5nnQm9suXMF1Zbebl7G7/Bp+cfLYDSS4ihktgMjoe2ayJC+NWtmPjR+sbX0NsVoFIoa
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b28d698e-3410-4821-df9a-08d5dc48e7db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1044;
x-ms-traffictypediagnostic: AT5PR8401MB1044:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB1044271AAD716494D1FD5F4082480@AT5PR8401MB1044.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1044;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1044;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(86362001)(6246003)(11346002)(99286004)(446003)(486006)(3846002)(966005)(6116002)(476003)(5640700003)(14454004)(6512007)(66066001)(2616005)(6486002)(14444005)(256004)(36756003)(53936002)(4326008)(25786009)(229853002)(6306002)(6436002)(26005)(7416002)(97736004)(5660300001)(6916009)(8676002)(106356001)(8936002)(81156014)(68736007)(6506007)(76176011)(2420400007)(81166006)(186003)(102836004)(2351001)(2501003)(2900100001)(478600001)(54906003)(7736002)(15650500001)(105586002)(10710500007)(2906002)(305945005)(316002)(5250100002)(7110500001)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1044;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kfdpEBR2GoreQW7TNbAhlBwfG+NYJ9Vpv91e6HH45+KjYmt6tXqSc8lFYAXld6unymC9E67AgaWDdtzd2ZbmtyTfRXciXLqxBB36sonJq5ROT6sa3w2fHSveoyFqF9o955n4W5lRqDkgXQMZY1soulY47Rc9Lja+U37iq59d+HlYtfGHql8Zp4RtCS0l/DHpY4Kp9Hz93efLsFswBnF6t5pN0qwMD3L+3MOD89vgLYTJ0YrT0kunYRTINbFsjputA4TNgoIn6VReSSqyHKAPId2AAGf4+4poEGD9p6CpvB97Qf+GdAgRgMaDvjjjCCLS6KcgM/Pz5b6gRVrWAydlHv4cxk8Jw9eQVwUGOb/v8ZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <397C5A88CFE1164E80BA21374D6CCD34@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d698e-3410-4821-df9a-08d5dc48e7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 16:13:22.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1044
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTI3IGF0IDE2OjU2ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
SGkgVG9zaGksDQo+IA0KPiBPbiBXZWQsIEp1biAyNywgMjAxOCBhdCAwODoxMzo0N0FNIC0wNjAw
LCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+IEZyb206IENoaW50YW4gUGFuZHlhIDxjcGFuZHlhQGNv
ZGVhdXJvcmEub3JnPg0KPiA+IA0KPiA+IFRoZSBmb2xsb3dpbmcga2VybmVsIHBhbmljIHdhcyBv
YnNlcnZlZCBvbiBBUk02NCBwbGF0Zm9ybSBkdWUgdG8gYSBzdGFsZQ0KPiA+IFRMQiBlbnRyeS4N
Cj4gPiANCj4gPiAgMS4gaW9yZW1hcCB3aXRoIDRLIHNpemUsIGEgdmFsaWQgcHRlIHBhZ2UgdGFi
bGUgaXMgc2V0Lg0KPiA+ICAyLiBpb3VubWFwIGl0LCBpdHMgcHRlIGVudHJ5IGlzIHNldCB0byAw
Lg0KPiA+ICAzLiBpb3JlbWFwIHRoZSBzYW1lIGFkZHJlc3Mgd2l0aCAyTSBzaXplLCB1cGRhdGUg
aXRzIHBtZCBlbnRyeSB3aXRoDQo+ID4gICAgIGEgbmV3IHZhbHVlLg0KPiA+ICA0LiBDUFUgbWF5
IGhpdCBhbiBleGNlcHRpb24gYmVjYXVzZSB0aGUgb2xkIHBtZCBlbnRyeSBpcyBzdGlsbCBpbiBU
TEIsDQo+ID4gICAgIHdoaWNoIGxlYWRzIHRvIGEga2VybmVsIHBhbmljLg0KPiA+IA0KPiA+IENv
bW1pdCBiNmJkYjc1MTdjM2QgKCJtbS92bWFsbG9jOiBhZGQgaW50ZXJmYWNlcyB0byBmcmVlIHVu
bWFwcGVkIHBhZ2UNCj4gPiB0YWJsZSIpIGhhcyBhZGRyZXNzZWQgdGhpcyBwYW5pYyBieSBmYWxs
aW5nIHRvIHB0ZSBtYXBwaW5ncyBpbiB0aGUgYWJvdmUNCj4gPiBjYXNlIG9uIEFSTTY0Lg0KPiA+
IA0KPiA+IFRvIHN1cHBvcnQgcG1kIG1hcHBpbmdzIGluIGFsbCBjYXNlcywgVExCIHB1cmdlIG5l
ZWRzIHRvIGJlIHBlcmZvcm1lZA0KPiA+IGluIHRoaXMgY2FzZSBvbiBBUk02NC4NCj4gPiANCj4g
PiBBZGQgYSBuZXcgYXJnLCAnYWRkcicsIHRvIHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9m
cmVlX3B0ZV9wYWdlKCkNCj4gPiBzbyB0aGF0IFRMQiBwdXJnZSBjYW4gYmUgYWRkZWQgbGF0ZXIg
aW4gc2VwcmF0ZSBwYXRjaGVzLg0KPiANCj4gU28gSSBhY2tlZCB2MTMgb2YgQ2hpbnRhbidzIHNl
cmllcyBwb3N0ZWQgaGVyZToNCj4gDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVy
bWFpbC9saW51eC1hcm0ta2VybmVsLzIwMTgtSnVuZS81ODI5NTMuaHRtbA0KPiANCj4gYW55IGNo
YW5jZSB0aGlzIGxvdCBjb3VsZCBhbGwgYmUgbWVyZ2VkIHRvZ2V0aGVyLCBwbGVhc2U/DQoNCkhp
IFdpbGwsDQoNCkNoaW50YW4ncyBwYXRjaCAyLzMgYW5kIDMvMyBhcHBseSBjbGVhbmx5IG9uIHRv
cCBvZiBteSBzZXJpZXMuIENhbiB5b3UNCnBsZWFzZSBjb29yZGluYXRlIHdpdGggVGhvbWFzIG9u
IHRoZSBsb2dpc3RpY3M/DQoNClRoYW5rcywNCi1Ub3NoaQ0K
