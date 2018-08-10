Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644E22444
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="g2h1o0uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A644E22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeHJU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:26:47 -0400
Received: from mail-dm3nam03on0133.outbound.protection.outlook.com ([104.47.41.133]:56276
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJU0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1+KaVjXY1XFW71vcsf040ciTLCy4Gr8kwl7n0TXgMU=;
 b=g2h1o0uAQtVYn8/FzHUxZJYGOMZkAU+z06Fbmu7/0m0RiozpE+kXeZNrxHiU/hMLwb6eCxihy/9VmseAgExtapPntwFl4ZOfg4UYhAI6/OGIGgZYQqwEajEbv2K8IE6oRQlDm2geyyaKtNnRUx840Cb1KhlirhoyXx3VWWOl2Xs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3675.namprd06.prod.outlook.com (10.167.236.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Fri, 10 Aug 2018 17:55:50 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864%2]) with mapi id 15.20.1038.023; Fri, 10 Aug 2018
 17:55:50 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Thread-Topic: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Thread-Index: AQHT4yafyeQn7soaS0qz4ku89UJpHKQrKQSAgA9INYCAAaFigIAADB0AgAMSxQCAAAEJAIBvT2e2gAnOcoCAARmtgIAAUIaAgAAJR4CAAASMAIAAGAuA
Date:   Fri, 10 Aug 2018 17:55:50 +0000
Message-ID: <1533923749.2283.330.camel@impinj.com>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
         <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
         <20180522173000.GG24776@sirena.org.uk>
         <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
         <20180524162940.GA4828@sirena.org.uk>
         <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
         <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
         <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
         <20180810105205.GC20971@sirena.org.uk>
         <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
         <20180810161329.GF20971@sirena.org.uk>
         <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3675;6:7+uOSMgFtw5k2J5WvHQqLdhVkxpJOpEizLhqXIl+rnS4W/KiH5svV9lI9dOvbOmobKD/C8VLC5BxRFAKhXmwdCe/epF+6FuryXwy2Wn44cYBqaKHwvJMbqdbr6W1lnQkBxJp/whzO4QQxEx2LXIFAzGBVi0cVrKwlCqJngfqCZW4iyAvJXJ+Cw6BZ/CBeVoUh2coVeSeJtYDx8lOg0MHSukf/LWh20fdTc1lgW0l//s19HmtX4eXk1UUPHY0UDWMXYJMsvg6AYq8EHd+4nEHIIPVxH5S2WlNwPUX4BI+3K+g1bBP5C0cjPK7zPxwGK/NNUx3by438yMnH4sEzLc1xG23xnUjfp393XeYu3+kD43+/O31Myd/mNBTW9G2MX0cIre9tmq+QT+01gFsp2nSSPTJuwjlQCrCAafoz8AjYqXoZVR7qzTCVm/L6wdnb5AKvHcjoNedXedWAMgu0Ji9SA==;5:2KqhtbSXxdHjjvANQwroSSvvCWDmanwY9W8Db1w+AJsxX6c/5ukOk0BMb4k2IhgoP/bo1s8Do3TcVoVX62CIi3frkNanawqImOZwOPOaMESlHtaHWAYahRp8flG5XSbLZSS9AIZiSR5kYgWWaL6cs8JgXK62Ubm2mgFd9giRr2A=;7:/cvqZYLujLfzLulSTDge8Spe6tI9VLr/inzWAFi1taHVn1nQ+1UkuD6pqAkVLZLQ/R84J4mWUilD7Myi6M3uk15zqpUhB0uIvI0CNJxnlZyByQOH36r6aVTyxQAuxlbbDOTc2yeG25w0EM9TxPeInGwqfr+z0XNz5o5uc00z7C3Rmw7MW+JvaSNzOdSSzCX3ETRAy59JjF6CEWmJWobwSK4ebZ3Pc0l9iV4LCsECOalqgDGI5Am2EB+pcBob9l+R
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c6203aa3-9a97-4496-95fe-08d5feea8271
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3675;
x-ms-traffictypediagnostic: MWHPR0601MB3675:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <MWHPR0601MB3675C9C8FAF827F392851A1CD3240@MWHPR0601MB3675.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3675;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3675;
x-forefront-prvs: 07607ED19A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39850400004)(376002)(366004)(396003)(189003)(199004)(2201001)(86362001)(25786009)(97736004)(102836004)(256004)(229853002)(478600001)(305945005)(7736002)(68736007)(6116002)(3846002)(106356001)(14454004)(105586002)(11346002)(8936002)(81156014)(476003)(186003)(486006)(81166006)(2616005)(4326008)(6506007)(26005)(76176011)(446003)(99286004)(36756003)(2906002)(6436002)(103116003)(2900100001)(2501003)(5250100002)(8676002)(54906003)(53936002)(6246003)(6512007)(7416002)(6486002)(5660300001)(93886005)(110136005)(316002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3675;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WMeR+teu+tmgalpWtD4LPGiACYEusUnFz9EY+S2zcBDG+DxPTDdZjkCc7URZoeVsiSoY9/tpR+WfZtPW7aSgWf9zRLZM6/RHeUE/JhbXsQMNgS7KoJ2jRCsgXdo83n0BnlOveucMM8eJDNojpBHbTjysQ70v7baFBaoR+e6K2Wg/pFuyCFxFKytr7dbXUXxdhYHnlZBIg7oYo2jpkEugnpzmLQiC/LrVFiUDnIGsEwMYt+Z1QT/IgEyrL7n9hzOEWr8tEWNGRyMF0GK7KxvH1oXVmdScDPujgap+80jWDO6b2YRo3Eq/rQ4SgV7w5XjgGiWyBz8mn1E4IngtrQmy0HIzSvIggcaMVmzlqrhLZJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDAB15AE04AEB94090DBD4692C1F106F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6203aa3-9a97-4496-95fe-08d5feea8271
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2018 17:55:50.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTEwIGF0IDIxOjU5ICswNTMwLCBka290YUBjb2RlYXVyb3JhLm9yZyB3
cm90ZToNCj4gDQo+IEhlcmUgYXJlIG15IGNvdXBsZSBvZiBjZW50czoNCj4gU1BJIGNvbnRyb2xs
ZXIgbWF4aW11bSBmcmVxdWVuY3kgY2FuIGJlIGxlc3NlciB0aGFuIG9yIGVxdWFsIHRvIENsb2Nr
IA0KPiBmcmFtZXdvcmsncyBtYXhpbXVtDQo+IGZyZXF1ZW5jeSwgc28gc2hvdWxkIG5vdCByZWx5
IG9uIHRoZSBDbG9jayBmcmFtZXdvcmsuDQoNCkJ1dCB0aGVyZSBpcyBwcm9iYWJseSBzb21lIG1l
YW5zLCB2aWEgdGhlIGNvbnRyb2xsZXIncyBJUCBibG9jayBpbnB1dA0KY2xvY2ssIGNvbWJpbmVk
IHdpdGggdGhlIGNvbnRyb2xsZXIncyBJUCB2ZXJzaW9uIChmcm9tIHRoZSBjb21wYXRpYmxlDQpz
dHJpbmcgYW5kIGEgZGV2aWNlIGRhdGEgdGFibGUpLCB0byBkZXJpdmUgdGhlIGNvbnRyb2xsZXIn
cyBtYXggY2xvY2suDQoNCkF0IGxlYXN0LCBBRkFJQ1QsIHRoaXMgaGFzIGJlZW4gdGhlIGNhc2Ug
Zm9yIGFsbCBleGlzdGluZyBtYXN0ZXINCmRyaXZlcnMuDQoNCj4gDQo+IE5vdyB0aGUgbmVlZCBp
cywgaG93IHRvIGNvbW11bmljYXRlIHRoZSBTUEkgY29udHJvbGxlciBtYXhpbXVtIGZyZXF1ZW5j
eSANCj4gdG8gU1BJIGNvcmUgZnJhbWV3b3JrPw0KPiBJcyBpdCBieSBEVFNJIGVudHJ5IG9yIGhh
cmRjb2RpbmcgaW4gdGhlIFNQSSBjb250cm9sbGVyIGRyaXZlcj8NCj4gDQo+IE15IHN0YW5kIGlz
IGZvciBwcm92aWRpbmcgdGhlIERUU0kgZW50cnkuDQo+IFdoeSBiZWNhdXNlLCB0aGlzIGtlZXBz
IFNQSSBjb250cm9sbGVyIGRyaXZlciBnZW5lcmljIGFjcm9zcyB0aGUgYm9hcmRzIA0KPiBhbmQg
cG9ydGFibGUuDQo+IEFsc28gaXQgaXMgbm90IGFnYWluc3QgdG8gRGV2aWNlIHRyZWUgdXNhZ2Ug
YmVjYXVzZSBtYXhpbXVtIGZyZXF1ZW5jeQ0KPiBpcyBkZXNjcmliaW5nIHRoZSBwcm9wZXJ0eSBv
ZiB0aGUgaGFyZHdhcmUuDQoNCk15IHBvaW50IGlzIHRoYXQgbm90IGV2ZXJ5dGhpbmcgdGhhdCBw
b3NzaWJseSBjYW4gZ28gaW4gdGhlIGRldmljZSB0cmVlDQpzaG91bGQgYmUgcGxhY2VkIHRoZXJl
LCBqdXN0IGJlY2F1c2UgaXQgY2FuIGJlLiAgSWYgdGhlIG1hc3RlciBkcml2ZXINCmNhbiBmaWd1
cmUgb3V0IGl0cyBtYXggc3BlZWQsIGxldCBpdCBkbyB0aGF0Lg0K
