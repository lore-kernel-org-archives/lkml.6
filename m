Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E36C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1295F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="DoUlq7Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1295F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJKFdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:33:12 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:57888
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeJKFdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At6t09LOHNgCTgg9oY72+EuJ9dVQsgbfCVhuHjmOAio=;
 b=DoUlq7XyqL0WY3lsl3KtANiX50GnrSK8x0xheo8Cr1I0b+nDb1JhHjnU5ikhQy+J2+OoUtmC19hmOKCemdK7yh505onmYgXtnonJel2uFpo7hMZiHGVOHBGEwTbYe/wDHobKJUCIMpijbllO6XsaH13ctrqrPlG/grd/B45pM8I=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 22:09:00 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 22:08:59 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "talel@amazon.com" <talel@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>
Subject: Re: [PATCH 2/2] dw: spi: add support for Alpine spi controller
Thread-Topic: [PATCH 2/2] dw: spi: add support for Alpine spi controller
Thread-Index: AQHUYKworteDz6TUsU2sT2AWYXx806UZCleA
Date:   Wed, 10 Oct 2018 22:08:59 +0000
Message-ID: <1539209339.1944.23.camel@impinj.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
         <1539184516-8200-1-git-send-email-talel@amazon.com>
         <1539184516-8200-2-git-send-email-talel@amazon.com>
In-Reply-To: <1539184516-8200-2-git-send-email-talel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3708;6:/sWdp8oll49ipMMtK7NVbT09emYs8rxYZJhZdwVgwPVnbnf1OEvkFTgg4jeXWSMM0GhG4hV8qGYTdaV0CG2UgGju7ALq2joVeG673pjne4ewy3WIYDZUKOhSNV607EBDn31DuNtGsSEfwsGARBnscOYDBPYB/7cTkABA7gis2KMXqD+uc37Nb2zi4QcVgk/FHZogbD7yEe7q7DRkFI7cxdwjsSF3tKnBOCngr4jEzLwGMjAYd+zf/GCRnLM5Qgzau1yrcWnqn4XzcesH55mPGhQfUvj2bvJNpmvdJBggTPu0Fr80SlYMkimzKULbjIDmLZi7gxHCS8FMBV3n9KleNsckuE/Pc1FLeXbGXZNv6E6BCwmjwHKRoXBSaUz8zw0JfoMhmKrCeYZ/5B7oIRjT9wMtALKfyzpDmZnVEgQl7iKB8aZU5GZZTUld/Rezb3xlmGwDNeQCE1/ZWzTdaPjL1A==;5:wOIa9H1LgJEl7XSRnsMs8ym8FWUKhT6bLvgOp2vG2xSjxzBtIlevompS0N9xOFghoGBe9pL9pUIIDiFx/r64sy2pkFSrsuwXFVzJhGD/lH7E92wZ8xMYUNJSli9qwEfYls2SkQoWNuHGop+W7ROUjRrzdLx68vZAiVcXd+v1RM4=;7:Hr/aiXX2cqyZUPAZj4cS/CrABe1Uck+apySJwvzHgBDjcGr2HUqLjOSyL2uySHe0z7722CzsrUbNoRgTDT/K6DdWJib89VMNLkE5yUpWpQsHZImIf07aowfOt0Vmon10o7bIDIU8glmhYUrdul7WV3STF9/QWhXL1QUE4aRtW6pD4z0lVcZK/9Q+ZqVlfWg1GPT1ZNBMICXVrgRyCT5ZEAwJhYKE5rS1J4XEktAtP9VvBzFjy9RTBhzaJdQlzN9K
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e856041-ac4e-45a4-be93-08d62efcfb22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3708;
x-ms-traffictypediagnostic: MWHPR0601MB3708:
x-microsoft-antispam-prvs: <MWHPR0601MB37082ECAF4408BB52288A49DD3E00@MWHPR0601MB3708.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(146755900322472);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:MWHPR0601MB3708;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3708;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(97736004)(106356001)(5660300001)(71200400001)(68736007)(81156014)(103116003)(8936002)(81166006)(6246003)(36756003)(71190400001)(2900100001)(4326008)(2501003)(105586002)(8676002)(6486002)(4001150100001)(6436002)(5250100002)(53936002)(316002)(305945005)(14454004)(6512007)(25786009)(478600001)(66066001)(110136005)(229853002)(26005)(2201001)(99286004)(186003)(256004)(76176011)(6116002)(486006)(3846002)(7416002)(476003)(6506007)(11346002)(2616005)(86362001)(2906002)(102836004)(7736002)(54906003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3708;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SVhjZH8DO/0sNg7mEKGpc0MaXmbPnhZsCHMNAAbRiatwie99DGFK/nqeGpfgzJvQJknRF/2vIhw89O2mtMkGuK+fqwd0J8a8u7so8nMp+zBADHB9DjXV9JHR3AthW71CMhoIlj3VcbhP4lhjAym6TtfcGNphYoKuTEFK3ktAdJmdvpInJ+9n0gBByFOh4zKsPixqCOwdMVdpsOXp2sqa7UrRX2dr+c1VWKqFZ/X8ANrcNF1OXBbE10QnZqYl3XK2l9exXEsFUWhbbBmwd40NedAGjtG+Kr+dw+9ktjik/ZGEXFz+ZpwIwuiveaGxd2Z2xUAt+1TVwAtO07Ardj4q41TfVc5BgeMXwho0Q3XxCKk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AD18A7C81131C4095171349CF82D59C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e856041-ac4e-45a4-be93-08d62efcfb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 22:08:59.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTEwIGF0IDE4OjE1ICswMzAwLCBUYWxlbCBTaGVuaGFyIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgYSBuZXcgZGV2aWNldHJlZSBjb21wYXRpYmxlIHN0cmluZyBjYWxs
ZWQNCj4gJ2FsLGFscGluZS1hcGItc3NpJywgd2hpY2ggaXMgbmVjZXNzYXJ5IGZvciB0aGUgQW1h
em9uIEFscGluZSBzcGkNCj4gY29udHJvbGxlci4gJ2FsLGFscGluZS1kdy1hcGItc3NpJyBpcyB1
c2VkIGluIHRoZSBkdyBzcGkgZHJpdmVyIGlmDQo+IHNwZWNpZmllZCBpbiB0aGUgZGV2aWNldHJl
ZS4gIE90aGVyd2lzZSwgZmFsbCBiYWNrIHRvIGRyaXZlciBkZWZhdWx0DQo+IGJlaGF2aW9yLCBp
LmUuIG9yaWdpbmFsIGR3IElQIGh3IGRyaXZlciBiZWhhdmlvci4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFRhbGVsIFNoZW5oYXIgPHRhbGVsQGFtYXpvbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+DQoNClNob3VsZG4ndCB0aGlzIGJlICJh
bXpuLGFscGluZS1hcGItc3NpIj8gIFRoZSBjb252ZW50aW9uLCBhbmQgdGhpcyBJUw0KZG9jdW1l
bnRlZCwgaXMgdG8gdGhlIHVzZSBjb21wYW55J3Mgc3RvY2sgdGlja2VyIHN5bWJvbCBhcyB0aGUg
cHJlZml4LA0Kc28gYXMgdG8gaGF2ZSBzb21ldGhpbmcgZ3JvdW5kZWQgaW4gdGhlIHJlYWwgd29y
bGQuICBJIGRvbid0IGtub3cgb2YNCmFueW9uZSBlbHNlIHVzaW5nIGEgcHJvZHVjdCBsaW5lIG5h
bWUgYXMgdGhlIGNvbXBhbnkgbmFtZSBpbiB0aGVpciBkdA0KYmluZGluZ3MuICBFeGFtcGxlLCAi
c25wcyxkdy1hcGItc3NpIiwgaXMgbmFtZWQgZm9yIFN5bm9wc2lzLCBub3QgdGhlDQpEZXNpZ253
YXJlIGxpbmUuDQoNCg==
