Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B76ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C5A2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="eyC8UfpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C5A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJQOt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:49:58 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com ([40.107.1.110]:48496
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeJQOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mwl1U1VBwfb8UHQjKvDrPhATHXnK61k3YUl91UVADo=;
 b=eyC8UfpUkA+iJAURGRwO0HMwrD0tIY4FQptf1j3bA0J3MX3RYPOroFGtRzwVKSSAKmvcjoo9Fz4KsUVaaFGF+8iTE/tMKAbkrK3Q3JVBhAYT5ODFfHJU6cwwHw36UpPOLqx1N5woNuvY1c5pJL8tbFZUFWubHyP7JTgCRwT0PiY=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2222.eurprd02.prod.outlook.com (10.169.132.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 17 Oct 2018 06:55:40 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::cc66:95d8:ffea:e7a7]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::cc66:95d8:ffea:e7a7%6]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 06:55:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Topic: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Index: AQHUXy1dR3DPrllFh0W6+gqsRwwRKqUV8hIAgAcy34CAAE0dgIABjrYAgALAG4CAAU2XgA==
Date:   Wed, 17 Oct 2018 06:55:40 +0000
Message-ID: <f9e34759-0c6b-d69f-a255-34b87d7db8e2@axentia.se>
References: <20181008173528.GA31787@embeddedor.com>
 <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
 <20181013133831.7dbd31e8@archlinux>
 <43e89449-d693-3e1b-711c-7c9c139d288d@axentia.se>
 <20181014180134.287c0a66@archlinux>
 <6fe3f1f5-5bf6-2552-b322-90e766e6e5a2@embeddedor.com>
In-Reply-To: <6fe3f1f5-5bf6-2552-b322-90e766e6e5a2@embeddedor.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::11) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2222;6:3U05oMTgTBUlEF6MJaSZj2y8yBFnh3oXS98ocIAgQooKrcGOohq/34M75gnpG1moNvhVkeSHnRNIbrzRTh4UBM+6Y1+8Vfr+FGvbEKhNq7RGwwODJv0VaU7OYrqOGkOy6n8NM0dip6otyQJrkmM05yw8iP6Ss7lSK5hzUoBiB+HO5T6xiTUqGQ2LIEds8V/z0VEQ3eLsF5OC8u58PhfVZHRYfUfyGrbVhlSKUFOoEopN9IAymMaZA73poTqAtseDGcH6VfDLWOSrkogRlOMl2cPGWAJLRMMqBKlFIkIsxczH2yGOuah/zQ68Sdnh2x+XImy3du5MJ83Fpkw5rUMvnw5aS6RHobvian6n4FsnV77f11iGJHWaDNE/QpEPv8atIncglJdqoOQeyUPmN9k0Nz1fZw+WqAm675HBPlTLbPN1WhIXAZHLZgWRjhbpEcvMUx5xW5V8Lzm94F/CiP4B6A==;5:iNSMxvHS8dMKX0UfEIzeboCs19WY0CYCWLMElAwrenwriF4u3fcq5hKVV0VZkxt9q1V/Nen8FG1beP2X6CK77rjw18hbtKz6AdTs5rglqxfu2A4jCCeMU7vF4iCLlNyQ1aOQO+42ymIfVLsI/zPPUFfdftcttdWVke2SMlTrkSg=;7:abI23qjiYwPKwR/kNv0jzQ0TABcWyPdjs99zknVGXJds0MJ3z+knNGGZbGzceXUGBC7o0Sn6Eoi4wYHIYo7GhUz/EDUBuSeyAMqK8ezDW8pkL2DMcTS3gkAPctNtADJC4ORrS5wugXY1PxwN29UwH1bq6oHVdq2y+BIYKNWmpBioulW6QviDQ5YVetDhWx1ciFh/6JBbPgQx9O6G5+2b+QT4FUn2FlwNeDiGHs5PnqQ09DR7ViMW9djY8j9t3M6h
x-ms-office365-filtering-correlation-id: 9a43c137-4c27-4b51-9be5-08d633fd8c55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2222;
x-ms-traffictypediagnostic: VI1PR0201MB2222:
x-microsoft-antispam-prvs: <VI1PR0201MB2222236B6897DEE0D042F5E3BCFF0@VI1PR0201MB2222.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991094);SRVR:VI1PR0201MB2222;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2222;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39830400003)(189003)(199004)(2900100001)(5660300001)(106356001)(105586002)(31686004)(58126008)(110136005)(54906003)(446003)(53936002)(86362001)(11346002)(31696002)(186003)(2616005)(476003)(486006)(36756003)(65826007)(26005)(256004)(8676002)(2906002)(6246003)(102836004)(6512007)(305945005)(229853002)(7736002)(65956001)(68736007)(71190400001)(71200400001)(3846002)(8936002)(65806001)(66066001)(53546011)(74482002)(64126003)(6486002)(25786009)(6436002)(6506007)(386003)(6116002)(81166006)(81156014)(316002)(52116002)(99286004)(76176011)(508600001)(93886005)(97736004)(558084003)(3260700006)(5250100002)(4001150100001)(4326008)(14454004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2222;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LajcS0ZsP6ZxwH6dIP8IxlXRX6wJcomq9R88SWbyT8OaA9lKlPbJp18mBgnFnETJgrBuStOpPoG6L8Q4oSWi0TfxhffA/z+a61mvfK/elwQE8ASzRUJqmSUn5xPBbzPxRqTiaZneIXhuYUaZ5I+kuGlF6362J+/Z7Pebpu5puQJCCc9QdiXouEINT5S6Qk7PCV9AyCB5Kxq00ecYPGQw/c51696/Pk3LDuVAzgKOaGFsjQDvXG/u/0giBsCblb7HvuX0yAOJatryPAIqSKq3dbgrNfvWFqPKnrfxlgrg9aMarvF2mVSycZ2BLwDIyHsA2Y2qQjoFLAe8tWY33ggr7Ux5D+SQ9ybxkLoDv3pPrkQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6752C91EAC18A46952C22ACD564FB91@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43c137-4c27-4b51-9be5-08d633fd8c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 06:55:40.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0xNiAxMzowMSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gT24gMTAv
MTQvMTggNzowMSBQTSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+IERvbmUgdGhlIGZpcnN0
IG9mIHRoZSBhYm92ZS4uLg0KPiANCj4gVGhhbmsgeW91LCBKb25hdGhhbi4NCg0KSW5kZWVkLiBJ
IG1lYW50IHRvIHJlc3BvbmQgZWFybGllciwgYnV0IHRoZW4gZm9yZ290Li4uIFRoYW5rIHlvdSEN
Cg0KQ2hlZXJzLA0KUGV0ZXINCg0K
