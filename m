Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA0DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587F720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="riGiGPAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587F720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGXPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:23:19 -0400
Received: from mail-eopbgr30113.outbound.protection.outlook.com ([40.107.3.113]:62047
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388358AbeGXPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoISFlNoN+wmFTn2NzxX+6e30PE3qInRsU5ffq8nA5c=;
 b=riGiGPAvIDI0IgKig+bwCzA4O2Fsfg4N+XYtH0GnTJ802dSQ5laHDGVx6SSF13dRJ+z8fDPnzJ1ztWOAfyV801sS8UXIVRMQYy2+YXtbbRjOtdPJhKPjqiKx5liNk7dSfHNaI8vL1dEhiYy1qZ80Q53PbsmYIP16cz6gVU0mEkQ=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2350.eurprd05.prod.outlook.com (10.169.135.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 14:16:33 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 14:16:33 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "digetx@gmail.com" <digetx@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Topic: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Index: AQHUIzsmvhNTA8KQdkOtPSRemoHbvqSeTBYAgAAFmoCAABmwgA==
Date:   Tue, 24 Jul 2018 14:16:33 +0000
Message-ID: <1532441791.6124.20.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
         <1532435072.6124.1.camel@toradex.com> <2532956.xKQ6NZiSWF@dimapc>
In-Reply-To: <2532956.xKQ6NZiSWF@dimapc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2350;6:WDmMWKiH+ZcB4qsHUm306ZpZJp75C1kNcPWaqdADT/TtgZG4fNtCEPJJUwp+pxY3he5BI6sphPZAhomLOvQWWNy7BXENXDIeHqGQ2yEXyRutU25lxmd49xZbkRBUEnQJ56lzYcWJmIK6W1UxAha3E2K9qA/OUUPjpaMa4c3jYDe1kj7G8fmURlQ/4f8ohb8CYQJpC4Q83cozXEUr6dS9mER5MpNBEqCa63plNpQgGnG1UOd1/FARcz8JZh8qlcOSNeg+OSCtQZqZUfxhCQXdsbryw3/CQLiKIWj84UJ4nPOTsje14+hOX0Ba3qSwtsapQVRRPa2HuJX87BAEZDkSNbjdwhbak0jPdKgMLwuBj/vr1/1i6qcL3/+Vwn02/FJVgeiVPRYGQTXner7r8wL807bp/yWFCdSpYg47zAy5f073KPS9A6KQ6xV8oYvyGEci/FBOV6nDHrjk6Cg0GfW59A==;5:vDVd2ul0+69/YjlNC05sVqEypObzXc4kb8gVRSWuPAOFp1Q9NUUfqo33yZ9QYwog8Rnrrfox1IkQP71kKiT1VY4T+4dHQZOlmFGdZYYZYyrFQ+/JrwLT7I2dVtV0ZIwjJDuyu/Gj/dGkLqOL5ETjcJvF+EEojWX1cnQMribJo0c=;7:8Z5Ljo8s2IAq5oHqtPfbt8fqyry3W312MoGz5fhIfecO8h8h9UwkpFEFlZOhBSPsbxxPCgOO4x586gR30hUbDfq8WLMnAdv3Uxtce0cGyKmDm2b20Owxfzn8/IQXFljIfRRVGw2mE+fJwZDB5fGC03NmP7CUgKb2qlTRo6Niic0JcpM3jDRg6Gwwx3vKsEOXeUrcEWnePkvmS0VwXv55EdZJDk6x18Uysa5zUaRMQuYh8KiINliRKd4tCKJLjb/j
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3c578641-d15a-4010-e69c-08d5f1700f00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2350;
x-ms-traffictypediagnostic: VI1PR0501MB2350:
x-microsoft-antispam-prvs: <VI1PR0501MB2350B932743023D9940AF3D9FB550@VI1PR0501MB2350.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2350;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2350;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(366004)(346002)(396003)(136003)(189003)(52314003)(199004)(6116002)(8676002)(6916009)(44832011)(102836004)(14444005)(81166006)(6506007)(1730700003)(186003)(3846002)(81156014)(2616005)(76176011)(1361003)(256004)(476003)(68736007)(11346002)(4326008)(26005)(99286004)(25786009)(53936002)(45080400002)(5250100002)(446003)(2501003)(36756003)(39060400002)(103116003)(6486002)(106356001)(105586002)(2351001)(97736004)(7736002)(6512007)(14454004)(478600001)(5640700003)(66066001)(2900100001)(8936002)(486006)(6436002)(6246003)(2906002)(86362001)(1411001)(316002)(5660300001)(54906003)(229853002)(305945005)(487294005)(491534004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2350;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9t6eVsO4/JrUN1iN1DsBnUEfTgAYmOf3JF807rIja8F1mdYhIDR9jfrpXNTfPF+54F4JqQIuxD6OBJkHhtUvv4H4PETgG1fD3fRDjdmJFi1K93PE5dvcJxjObWJm7LgvRudA70EFa1rGzSP+crgYNv8e2HZ57pOe/DYkVKjCygp8p6JSX9Kxn1o52EeQncRC79m5QYe+oBpEFuXNXc+rfSgV3QV3XzsDSWKJhi/1/OGeg3fL+GWwu5bpsCLDX3dtCdHdHXzFlXG5GZ9jv+UPzcDXIEli9MbOxSVuP+CBBtfMBhuK45UXXSVHIc0waDjsQPBGxpjN/kxZ7M7ux2Bwap2g3niTmyjb9pvSmh6knew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CBBE2B1DED11D4D972A2617A39218F4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c578641-d15a-4010-e69c-08d5f1700f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:16:33.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDE1OjQ0ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IE9uIFR1ZXNkYXksIDI0IEp1bHkgMjAxOCAxNToyNDozNCBNU0sgTWFyY2VsIFppc3dpbGVy
IHdyb3RlOg0KPiA+IFNvcnJ5LCBJIG1lYW50IHRvIHdyaXRlICJtaW5vciByZXZhbXAiIGluIHRo
ZSBzdWJqZWN0IGxpbmUgaGVyZSBhcw0KPiA+IEFwYWxpcyBUSzEgd2FzIGFscmVhZHkgaW4gcXVp
dGUgZ29vZCBhIHNoYXBlIGJ1dCB0aGlzIGFyZSBzdGlsbA0KPiA+IHNvbWUNCj4gPiB3b3J0aHkg
aW1wcm92ZW1lbnRzICg7LXApLg0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAxOC0wNy0yNCBhdCAxMjo0
MiArMDIwMCwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0KPiA+IA0KPiANCj4gTWFyY2VsLA0KPiAN
Cj4gQWxsIHlvdXIgZW1haWxzIHRoYXQgYXJlIHNlbnQgZnJvbSAidG9yYWRleC5jb20iIGFyZSB0
cmVhdGVkIGFzIHNwYW0NCj4gYnkgR21haWwgDQo+IGJlY2F1c2UgIlRoaXMgbWVzc2FnZSBoYXMg
YSBmcm9tIGFkZHJlc3MgaW4gdG9yYWRleC5jb20gYnV0IGhhcw0KPiBmYWlsZWQgDQo+IHRvcmFk
ZXguY29tJ3MgcmVxdWlyZWQgdGVzdHMgZm9yIGF1dGhlbnRpY2F0aW9uLiIsIGlzIHRoZXJlIGFu
eXRoaW5nDQo+IHlvdSBjb3VsZCANCj4gZG8gdG8gZml4IHRoYXQ/DQoNCkhpIERtaXRyeQ0KDQpI
bSwgdW5mb3J0dW5hdGVseSwgVG9yYWRleCB3YXMgYW4gTSQgb25seSBzaG9wIHdoZW4gSSBqb2lu
ZWQgbW9yZSB0aGVuDQo3IHllYXJzIGFnbyBhbmQgc28gZmFyIEkgd2FzIHVuYWJsZSB0byBjb252
aW5jZSBvdXIgSVQgdG8gc3dpdGNoIHRvDQpzb21lIGdyb3duIHVwIGVtYWlsIHN5c3RlbS4gVGhl
cmVmb3JlLCBJIGFtIHN0dWNrIHdpdGggRXhjaGFuZ2UsIE9mZmljZQ0KMzY1IG9yIHdoYXRldmVy
IE0kIG5vd2FkYXlzIHNlZW0gdG8gY2FsbCBpdC4gQW55d2F5LCBJIHJlYWxseSB0aG91Z2h0DQpz
ZW5kaW5nIGZyb20gQW5kcm9pZCBvciBFdm9sdXRpb24gdmlhIHRoZWlyIHJlc3AuIEV4Y2hhbmdl
IGNvbm5lY3RvcnMNCndvdWxkIHByb3Blcmx5IGRvIFNQRiwgREtJTSBhbmQgZXZlbiBETUFSQy4g
SSBqdXN0IGNvbmZpcm1lZCB0aGlzIHdoZW4NCnNlbmRpbmcgc29tZXRoaW5nIHRvIG15IGdtYWls
IGFkZHJlc3MgYW5kIGRvaW5nICJTaG93IG9yaWdpbmFsIi4NCg0KU2luY2UgTGludXMgaGltc2Vs
ZiBwb2ludGVkIG91dCBhbnkgb2YgbXkgcGF0Y2hlcyBlbmRpbmcgdXAgaW4gaGlzIHNwYW0NCmZv
bGRlciBJIGRvIHNlbmQgdGhlbSB2aWEgbXkgcHJpdmF0ZSBlbWFpbCB3aGljaCB3aGlsZSBub3Qg
aGF2aW5nIGFueQ0KYWR2YW5jZWQgc2VjdXJpdHkgY29uZmlndXJlZCBzaG91bGQgc3RpbGwgYmUg
dmFsaWQuIE1vdmluZyBpdCB0byBhDQpmdWxseSBzZWN1cmUgY29uZmlndXJhdGlvbiBpbmNsdWRp
bmcgRE5TU0VDIGFuZCBzdHVmZiBpcyBzdGlsbCBwZW5kaW5nDQpvbiBteSBzaWRlLg0KDQpDYW4g
eW91IHBsZWFzZSB0ZWxsIG1lIHdoaWNoIGV4YWN0IGVtYWlsIGl0IGlzIHRoYXQgeW91IGdvdCB0
aGlzDQpyZXBvcnRlZCBvbiBzbyBJIG1heSBmdXJ0aGVyIGludmVzdGlnYXRlIHdoYXQgaXMgZ29p
bmcgb24/DQoNCkNoZWVycw0KDQpNYXJjZWw=
