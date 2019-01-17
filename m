Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CdBUwgX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfAQNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:41:07 -0500
Received: from mail-eopbgr00093.outbound.protection.outlook.com ([40.107.0.93]:6453
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbfAQNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh7cUVaTW0vmnu2rK7lKUEzCXVs3mjBHkExesBCQBlk=;
 b=CdBUwgX8UF3X7H12Ep0PQj547VdSgqq3FbEpPd0IPgwPcPS5FW7rNvpM7m1xRXEtKsPgu4QKNf9HAUaZTEFTcUUGMLLgE5KtWR69ZwVonnaf3YF8KEygNo0w4KdloMfBUjp7rSnlX4rz3NmhOMfhtzkW+QYVuPdLxC18/KvC/UM=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3784.eurprd02.prod.outlook.com (52.134.113.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 13:40:48 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 13:40:48 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a
 cmd, line option
Thread-Topic: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a
 cmd, line option
Thread-Index: AQHUpnTHhyvatHzd/0Csq85rfagf/6WyKPgAgAFepQA=
Date:   Thu, 17 Jan 2019 13:40:48 +0000
Message-ID: <672688c8-1115-1cf8-cac9-82c19219ea3a@axentia.se>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
 <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
 <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
 <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
 <CAMuHMdXMidVgtz-T8PZDUrKAwJmz9B4g1hNgw6FwrCpU-m5Gew@mail.gmail.com>
 <CGME20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1@epcas3p1.samsung.com>
 <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
 <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
In-Reply-To: <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0297.eurprd05.prod.outlook.com
 (2603:10a6:7:93::28) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3784;6:FJ85t6o6zFxhgiBFnjMX88sLNrHP3MHO6Mk3vu9hhRf6HeZZzBLKjeXeIvunf5uL6+v7O4CCHBdBJR7ZPI7AxzlG0DWMIS27sQkjmXe0qEa0uwN4Jr4xhjl4NT5eolrw9BhPykIhUWie2ZOiXdiUh+8v72XQb85IvESo1kAiG3Gq6KOImqm7OTASK3CcnQxzthsPxm5HcVB0bGAJx8edrl3X0iqlM5jh2tT+176wI/q8PtDs7Vk8id5msL51MpbZCgM2ZlPNzep4dOBaySGwaysOD5lbzs2376zYaeFVUtt2RCwvxZHaRy8GRqOS6KXrWJzqAHnobeWjGodru25LmFQjtIGomgLU1WOm6GXZ8sh8gPU4xj27KHMHpmg8/TUV7NzVvKpaslNnlGLcoM4HyXe7Ws7ldA0YNTpDhqCxswXx05f2tB8msxP8gPzFWHeussQrUHE11pEE9NbG5c05FQ==;5:wr2BVpKQzcBzP0u4ADl/6sQqqQYx/lyCu7Wi0oWljPbeXQbXBt6yodyHpSE9KaB7TtgFswlFmFuBKoqliE8Uf46hBE67OpCwyag8/NUJqUJdqczvy/WNPgVcZREdqWtviqcVUkBS2X7SuqTXHTxfrFHsFY6yRXRjw3lzomgSB4SI+LRyWswLqfmfEG3qH3V4B8rdQaQ29HcvdlhebpZWGg==;7:cUMNtnQexbbosvAZrl2TO3srWQ/3cKHg8gwZTM5bQwaeltmPB5JicdS6V/BRaR32DMs6vM3snHR6fuccFWGUmLJV+/nh26bvqqhlkIdB/c2w/JJ+6bgkqUXvdNDCSRpnjh7V4UkwOdHT+lvEj1eJog==
x-ms-office365-filtering-correlation-id: 234f000b-17d1-4d24-17ca-08d67c816363
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3784;
x-ms-traffictypediagnostic: AM6PR02MB3784:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-microsoft-antispam-prvs: <AM6PR02MB37844CAB873295E3CFEC89DDBC830@AM6PR02MB3784.eurprd02.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(316002)(54906003)(58126008)(229853002)(305945005)(68736007)(6512007)(64126003)(508600001)(71200400001)(65806001)(14454004)(86362001)(65956001)(66066001)(31686004)(14444005)(256004)(71190400001)(76176011)(476003)(446003)(6916009)(99286004)(52116002)(11346002)(2616005)(486006)(8676002)(8936002)(81156014)(81166006)(7736002)(74482002)(53936002)(53546011)(6506007)(386003)(102836004)(106356001)(105586002)(4326008)(6116002)(3846002)(25786009)(186003)(26005)(36756003)(65826007)(6246003)(97736004)(5660300001)(6436002)(2906002)(93886005)(31696002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3784;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4/tTwzHwuxjT5gDSh9YWlaWTfy0XVFIoBbjoqdXa53U8vD2HInEUzchV1tQ/O0Lpe2e724UYLGWqd+e0rd4tiiscy7YKSVt009hkVvsqE/jIaipw1Pzaf5a+lZj/Phw10PyckxAxuyRulKJCAafaKi/sJSs0fj8UkMnHYlz4DfG4GXrs/ZFzBrevjWafFphIF5pli5bqlQ6Otvr9Y9kSiP1YPU6wo3xWRYkbZQKwJU1CjsrM8ff8e/U7KSPP1qLGB60irsGyDex8oz3gwuW9lXUE3JcT7zgi6Oe87VzgYmQKC0GIIHljjsW2OXGxJIuo2g/kmz04ODGOKIEGqKix4hylVY3dRrL0PbFaSkd9sElieZWAwIxV0qD+V2w04xavmw9CR/SLneTW2hRI41AqlNH7FxEKGr1s3O0w8MEyMhM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <30DB0D08358DED4EB486AE830FAA3485@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 234f000b-17d1-4d24-17ca-08d67c816363
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 13:40:47.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xNiAxNzo0NSwgQmFydGxvbWllaiBab2xuaWVya2lld2ljeiB3cm90ZToNCj4g
T24gMDEvMDcvMjAxOSAxMTozNSBBTSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+PiBSaWdodC4gU28s
IGhlcmUncyBhbiB1cGRhdGUuLi4NCj4+DQo+PiBBZ2FpbiwgaXQgd291bGQgcHJvYmFibHkgYmUg
YmVzdCBpZiB0aGlzIHdlbnQgaW4gYmVmb3JlIDUuMCBpcyByZWxlYXNlZC4NCj4+DQo+PiBDaGFu
Z2VzIHNpbmNlIHYxOg0KPj4gLSByZW5hbWUgZnJvbSBmYmNvbj1jZW50ZXItbG9nbyBvcHRpb24g
dG8gZmJjb249bG9nby1wb3M6Y2VudGVyIChhbmQgYWRqdXN0DQo+PiAgIHRoZSBoZWxwIHRleHQg
YWNjb3JkaW5nbHkpLg0KPj4NCj4+IENoZWVycywNCj4+IFBldGVyDQo+Pg0KPj4gRnJvbSBlYmZi
MmZlYjdlYTQyOThhYzljMjIyZTZlYTZmOWM5YTkyNDUyMDg0IE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KPj4gRnJvbTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+IENjOiBCYXJ0
bG9taWVqIFpvbG5pZXJraWV3aWN6IDxiLnpvbG5pZXJraWVAc2Ftc3VuZy5jb20+DQo+PiBDYzog
Sm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4+IENjOiBQZXRlciBSb3NpbiA8cGVk
YUBheGVudGlhLnNlPg0KPj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+
IENjOiBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcNCj4+IENjOiBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnDQo+PiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gRGF0ZTog
TW9uLCA3IEphbiAyMDE5IDA4OjM1OjI2ICswMTAwDQo+PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGZi
ZGV2OiBmYm1lbTogY29udmVydCBDT05GSUdfRkJfTE9HT19DRU5URVIgaW50byBhIGNtZA0KPj4g
IGxpbmUgb3B0aW9uDQo+Pg0KPj4gQSBjb21tYW5kIGxpbmUgb3B0aW9uIGlzIG11Y2ggbW9yZSBm
bGV4aWJsZSB0aGFuIGEgY29uZmlnIG9wdGlvbiBhbmQNCj4+IHRoZSBzdXBwb3J0aW5nIGNvZGUg
aXMgc21hbGwuIEdldHMgcmlkIG9mICNpZmRlZnMgaW4gdGhlIGNvZGUgdG9vLi4uDQo+Pg0KPj4g
U3VnZ2VzdGVkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0K
Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4gDQo+IFBh
dGNoIHF1ZXVlZCBmb3IgNS4wLCB0aGFua3MuDQoNCkhtbSwgSSBzZWUgdGhlIHBhdGNoIG9uIHRo
ZSBmYmRldi1mb3ItbmV4dCBicmFuY2gsIGJ1dCB0aGF0IHNvdW5kcw0KbGlrZSBzdHVmZiBkZXN0
aW5lZCBmb3IgNS4xPyBNYXliZSB5b3Ugc2ltcGx5IGRvbid0IGhhdmUgYW55DQpmYmRldi1mb3It
Y3VycmVudCBvciBmYmRldi1maXhlcyBicmFuY2ggb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCg0K
SnVzdCBjaGVja2luZyB0byBtYWtlIHN1cmUgd2UncmUgb24gdGhlIHNhbWUgcGFnZS4uLg0KDQpD
aGVlcnMsDQpQZXRlcg0K
