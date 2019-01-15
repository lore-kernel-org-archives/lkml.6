Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14828C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9620859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rOuS4mw5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZDPCseSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbfAORpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:45:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16827 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfAORpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547574342; x=1579110342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZLYMC9VQGQqdKAc5KuQwXAbo2Ws2R0VMMZ+Zknbjaxs=;
  b=rOuS4mw5OetqFHQUBL08vnEGRx8SJtPYSdxaKfyzkNgYJXZ4p6AW9Ngf
   34B7gQMinabVnyRrE4oSyug6xO3HAG1iGuBzPdtrtoJW3ogpXmiMZ+t05
   bBcDvuy/jzb4vLbznjwdxoYm0rB0vaYwzeiW8PeqUZb5fNn3Fbuod68G3
   BN4naN/uIxso7LVYO9fP1cyt2ydBJ8COWNEt5DaatAT6oRIPA8FCf+zu0
   Ya2XBJb7e3BVkdrnBUiTzvP6Dg7vCTnoL+3cGHFfqeRjzU5HMCifq7LOh
   fNFKLYS4bYHaH1XXNd8iQ9YKJ5KrpbcN8pPqjknB0TJ2ojS6uX8Zq3vta
   w==;
X-IronPort-AV: E=Sophos;i="5.56,481,1539619200"; 
   d="scan'208";a="103782929"
Received: from mail-co1nam03lp2052.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.52])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2019 01:45:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLYMC9VQGQqdKAc5KuQwXAbo2Ws2R0VMMZ+Zknbjaxs=;
 b=ZDPCseSZz1/y371BfEkk7rv5fMduLL++7YvLsuQXJaK+GSFw7S5gEGN6JaSlIf1TKcIu/4rblWppsSN+R7yf3caGYcnOVI2dm8cjXZZXjDRPyXDVb/zoXcYeIQzvobcXkxX0fGv8DyV2Ddi7WU9D6FMe0TscfKikV0cTdG7WaFY=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0384.namprd04.prod.outlook.com (10.173.48.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Tue, 15 Jan 2019 17:45:35 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33%7]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 17:45:34 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUqg+MM4/QLJnNHUmA1qDrkrtO7aWweSWAgAAm9wA=
Date:   Tue, 15 Jan 2019 17:45:34 +0000
Message-ID: <03cbc37636be7fce21cd2af39ad8e322ca8e64e8.camel@wdc.com>
References: <20190112004117.28265-1-alistair.francis@wdc.com>
         <20190115152607.GA26443@infradead.org>
In-Reply-To: <20190115152607.GA26443@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0384;6:xUVLenfEnuIfzFEWtoWbytcJGYqB5KQUPbxjKjxL8+6nHE2dxaEexCtY/MiuCQu8td+3hpRCuEus7nwowBEFN/FdsXXLUslr1Xc+ak8PICEPkZpbVMGy43fEVFX4yuy07446N5b55pLrs6gjNkqjOSjCW0ofOteISIOPdtr+JjE8dCLBvwVAKovYYYxsgJ6DKDZedVXw2UcyRT1AXr40OALAzio2PJeUkRk7RhBpBcaZSCOdBFGGK6xiouA1fj2WgbvkDI5dTeOnoBpW6Bhq0QnFRY8EsavYiFAJFZvWsH0kkQXykkL/4Q9EIBNiAtaJuZccc7rlqajuXmkX3KxyczZ1IaWAYGTtjCN/r0iX01DhtX17eHp2BF2xya8AMnFH4AY7F0fkhpb7E/dc2NitQDvmxFNDjEjVDHoxmlYFvJJ1FkNunkmwJq+52YoU2nabQFdtUdDnidiPW0d1x/rUGw==;5:VJaVMSweXv+kgpCWvz1H/gE/BQ2V81y3nWa0B4nPeLPXPEbC+BqRv02yBbvoDT4JQyGd4bHW97igNsy9kC4/IDOfoh8PhcitLw65QKl8uWTK6vMxAaSgbqU8lbt8TM13NmkMOM20wfZi33c2041NZIHxFxoDvS1YGvckgW0hOgaEUO36MyDzPKo3RUAIzApuaKuIoSEUXZl+BKanccVG+A==;7:+FSY8GxsFI72x/sPO0tjdKN2gXRo9PTunpt8/nwxBkK2IbvGJ6XvGfWiE9SvlCoEa4klAUzyfRSyvNRh+6dZ1p3M+zDNP5+cPNoWu0CQRqQqpJn1syrqXsAwXHLIbEH3Cn4R7n8Qip+L4Ffa+ZSfgA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e9e271c3-e15d-466e-500d-08d67b1140b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0384;
x-ms-traffictypediagnostic: MWHPR04MB0384:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB03848A8C8DA192995C2C380590810@MWHPR04MB0384.namprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(66066001)(68736007)(97736004)(5660300001)(486006)(478600001)(6916009)(54906003)(7736002)(6512007)(305945005)(316002)(6506007)(6246003)(53936002)(99286004)(106356001)(4326008)(25786009)(11346002)(102836004)(72206003)(86362001)(5640700003)(8676002)(2616005)(476003)(6486002)(446003)(6436002)(186003)(4744005)(26005)(256004)(76176011)(3846002)(118296001)(71200400001)(71190400001)(14454004)(2501003)(229853002)(8936002)(81166006)(1730700003)(81156014)(2351001)(105586002)(2906002)(6116002)(36756003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0384;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O6hh6+NrgbRoYXprkQwUwzbmtlePQI5Yaim0XMRZ2QPOmizwhnFVL9KT4G4mfN/BYR/35HGHSXHA/1IFegN4a3I8gym9J+9kWqU5h5LOSD/vqkDsGbbiqj6ahj3sdvDIZrPPyRdce1wD+br+B6oOY0WCNiNUnWhebXQEhkhWDHyQX3nhKV/95zudZTCq9ZAeVOMuTtSmEbui6ppl1UUGA+bUJzDv8rtogLPi7RCgVBnEnqoFRVclhWCIbrFtGja7p66B/iyHLR6dewVd3W363lr9NW+YXcqvrF+rVnw8FNydD0mOU0fMaGNeZfPfaJsvQL3a9SXmIs6LNgddT0aRFePUN1hdmD+10rNnznxQvXcq2txZQAK3r809g0f/o020bbaqyJHbdjTNHrAkyhE6PkPwfjt3m/cHNZf8+dRMr/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <90DC464B148407488B48C64AA50D4084@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e271c3-e15d-466e-500d-08d67b1140b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 17:45:34.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTE1IGF0IDA3OjI2IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gU2F0LCBKYW4gMTIsIDIwMTkgYXQgMTI6NDE6MjZBTSArMDAwMCwgQWxpc3RhaXIg
RnJhbmNpcyB3cm90ZToNCj4gPiBFbmFibGUgZ2VuZXJpYyBQQ0llIGJ5IGRlZmF1bHQgaW4gdGhl
IFJJU0MtViBkZWZjb25maWcsIHRoaXMgYWxsb3dzDQo+ID4gdXMNCj4gPiB0byB1c2UgUUVNVSdz
IFBDSWUgc3VwcG9ydCBvdXQgb2YgdGhlIGJveC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQo+IA0KPiBMb29rcyBn
b29kOg0KPiANCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
DQpUaGFua3MhDQoNCj4gDQo+IEFsaXN0YWlyLCBpcyB0aGVyZSBhIHJlYWR5LW1hZGUgcWVtdSBt
YWNoaW5lIHdpdGggcmlzY3YgKyBwY2llPw0KPiBUaGF0IHdvdWxkIGJlIHJlYWxseSB1c2VmdWwg
Zm9yIHRlc3RpbmcuLg0KDQpZZXAsIGlmIHlvdSB1c2UgbWFzdGVyIFFFTVUgKGl0IGlzbid0IGlu
IGEgcmVsZWFzZSB5ZXQpIHRoZSB2aXJ0DQptYWNoaW5lIGhhcyBQQ0llIHN1cHBvcnQuDQoNCkFs
aXN0YWlyDQoNCg==
