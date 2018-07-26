Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F959C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264EF20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="otztVLBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264EF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeGZSTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:19:22 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:19290
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731864AbeGZSTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxZiP3wBpaFxehTOemmOnkILtdf9PPUk2IIMCkliXUk=;
 b=otztVLBlCOgfhQDozyfvSShXgztuWWGbk/rSLmlGg0Ka0h2UuGlY9A5oY34Cyued79ZHUCV9HqRAOhiO2PTTwmHYvQQqKZgK51FLePQa7tWRR5Vp7dgGjh6Tl5tMa6hKsv96sRDEp4jxGdlI0mP20ihP6MsoSFADmZwQPFQ6AKk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3674.namprd06.prod.outlook.com (10.167.236.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 17:01:36 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96%4]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 17:01:36 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "hayashibara.keiji@socionext.com" <hayashibara.keiji@socionext.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "masami.hiramatsu@linaro.org" <masami.hiramatsu@linaro.org>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Thread-Topic: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Thread-Index: AQHUJK+RltE82GCdEEK5TUYdy6rM8KShMNYAgACKaYA=
Date:   Thu, 26 Jul 2018 17:01:36 +0000
Message-ID: <1532624495.2283.197.camel@impinj.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
         <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
         <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
In-Reply-To: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3674;6:xIyxVw+Knb7xykuRbSd9ksiMdWjPTF/adDprEh5TpHII7uTttsxsKGpcjdxrMCsttgwEUayIdb42yA4aEIEr/I5fVpiFnolJdgRd0iaTEvCx5JHsJkgJfo8eGTieWwXd9xqGzfjY7nI4/RKb+f8oKux7LUD7kR9rhds3NkebxfF8v1JirmpKDYYjHnld7PfBrnnx3Az8Y6R9UUCGLtj2/fzj/rJPcE+X6qnRsdbjj0rERl7h0VkibqY1oeCKbzXWW3TLXsdkGzFI6gg9uuxZty812rrK74kMyoTlXNSMe9+VCR0o/3PNJ0/pgx1MRuhFWJksFGamtyl/HKPclFJB1eWwbVeYzf2RF2sI2RLnmMPtOx/D1fPnqw7X5YS5HBDDMk84ajP/W5/Lgz7ZGj/HKSp/dI9OIh/KDGrmmIMY82Wr6Np2OIp2/w7vimkUzJrPQ9M57s9sx26KJQVQnADq+Q==;5:RfqFXa7ChBozPbYTqLQpkiJtJ5dlgh8O9oLdYGVxXdOn+uHWCY/Ud/zfVja9P3mSUPrlz+qwd8ew5HrGRvbYJyYYSYci2qhRRUOMTS+YoZ7NflLISbhyuqyadX1OCPlO9hQ0/I/yFN9pgScHd9Kyg7DLw0pD2FuTQ4j/iLiTCoM=;7:qkqoXiuK6iClWDLag3o4in8Tuy/szCoaQFc1nA6p1OBVyfSpKEv4hXM78VykXumSqwglaSORKMEay2i0VBez579wHW0caMXFEOtmKT2jCBU9EVwSK5R0jt2wU1ItBbwGs1lvrgv6VZmEb+LO2juWkHYBt59EPMrZrFuKq43xt0vaImHPunjB4CvEz9cjhAglp1VVkMUlVzGUPzYceMhzke+JRPeBgQQVGEzD90Wyo2xvYbjBKpauds2urVhDhRTo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8301d275-ae02-413d-93d0-08d5f31972a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3674;
x-ms-traffictypediagnostic: MWHPR0601MB3674:
x-microsoft-antispam-prvs: <MWHPR0601MB3674C0E6FF3F7BDF991AB29ED32B0@MWHPR0601MB3674.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3674;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3674;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39850400004)(396003)(136003)(376002)(189003)(199004)(26005)(81156014)(186003)(6246003)(11346002)(81166006)(446003)(102836004)(6506007)(256004)(305945005)(25786009)(7736002)(2501003)(53936002)(8676002)(8936002)(99286004)(2616005)(6116002)(3846002)(39060400002)(5250100002)(110136005)(54906003)(76176011)(476003)(486006)(103116003)(316002)(6512007)(86362001)(5660300001)(7416002)(478600001)(68736007)(66066001)(36756003)(97736004)(2900100001)(4326008)(14454004)(6436002)(106356001)(105586002)(229853002)(2906002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3674;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nqczNsZffKfhD5UtzUEiJMGPT9PqqYd8M6CJBr6ld5EEpCU2zalEGKnJiLnwqhmAqDQLJQ0dVJDG7L2k0wmxHdtZEij6cp1EaRF2Ys3hCCvx14p4xli4ao9Lxhnh+h3DLhLvWrn0CizP52+NA2tbEARqjHOxoCTJaZN5bd5nh0xdwQNXHCUfIbYwznmNkK+6HpOtR/0CUJGBc2P9EIwu2FbE2s9AM6Mu1uPUYZuKmiFLqpvHX2Wm9AZXPJU56UhgrcbfoCvLRCeNH+U1WGI1fiVYeQopx9VzLWbcH/icRct/CvWKHBCVPJD5l6aqsX50u10Rdnf25HelnQfakC52AB0rutSs+koD7lAvTvK4NL4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43B4CBB91F26E4188170557B0AB47F8@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8301d275-ae02-413d-93d0-08d5f31972a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 17:01:36.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTI2IGF0IDExOjQ2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+ID4gKw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIHRoZSBzdXBwb3J0ZWQgcmF0
ZXMgYXJlIGV2ZW4gbnVtYmVycyBmcm9tIDQgdG8gMjU0LiAoNCw2LDguLi4yNTQpDQo+ID4gKyAg
ICAgICAgKiByb3VuZCB1cCBhcyB3ZSBsb29rIGZvciBlcXVhbCBvciBsZXNzIHNwZWVkDQo+ID4g
KyAgICAgICAgKi8NCj4gPiArICAgICAgIGNrcmF0ID0gRElWX1JPVU5EX1VQKGNsa19nZXRfcmF0
ZShwcml2LT5jbGspLCBzcGVlZCk7DQo+ID4gKyAgICAgICBja3JhdCA9IHJvdW5kdXAoY2tyYXQs
IDIpOw0KPiANCj4gY2tyYXQgKz0gY2tyYXQgJiAxOw0KDQpFaXRoZXIgd2F5LCB0aGUgY29tcGls
ZXIgcHJvZHVjZXMgdGhlIHNhbWUgY29kZToNCg0KIGFkZCByMCwgcjAsICMxDQogYmljIHIwLCBy
MCwgIzENCg0KSS5lLiwgY2tyYXQgPSAoY2tyYXQgKyAxKSAmIH4xLCBvbmUgImFkZCIgYW5kIG9u
ZSAiYW5kIi4NCg0KTWlnaHQgYXMgd2VsbCB1c2UgdGhlIG1hY3JvIHNvIGl0J3MgY2xlYXIuIFRo
ZXJlIGlzIGFsc28gcm91bmRfdXAoeCx5KSwNCndoaWNoIEkgYmVsaWV2ZSBpcyBpbnRlbmRlZCB0
byBiZSB1c2VkIG9ubHkgd2l0aCBwb3dlciBvZiAyIHZhbHVlcyBvZg0KeS4NCg==
