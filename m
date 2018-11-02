Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41859C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F329720657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Qu/eucca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F329720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeKBSxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:53:25 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:34656
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeKBSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8wXzuI9jAXefxCPWRYyA24AibbQ0gkuyBGoIM0qV7c=;
 b=Qu/euccawjCTvQBUH9AODE5KUkWfRNJxW8XUKJdGdPVvLSKd7BQqH4v5n4Y3Jovy8u9NWBTznrJQ5E8lZsrWw9A8RCinCA/VlprgDLyrsoHNMopd8HamcdQXlTABTIAUJTaHPphJXs+qnANXmw3nw9JMj4yRHrXb8tMct8/c3XA=
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com (10.171.191.18) by
 AM4PR08MB2772.eurprd08.prod.outlook.com (10.171.191.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Fri, 2 Nov 2018 09:46:47 +0000
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::5cb7:eb15:2e30:f981]) by AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::5cb7:eb15:2e30:f981%2]) with mapi id 15.20.1273.028; Fri, 2 Nov 2018
 09:46:47 +0000
From:   Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
To:     Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
Thread-Topic: [PATCH v5 11/17] arm64: docs: document pointer authentication
Thread-Index: AQHUXIh6gZ5zG0U/oUOGaE2HGhMkj6Ug9bQAgBtzKYA=
Date:   Fri, 2 Nov 2018 09:46:47 +0000
Message-ID: <7f9c1bc4-2e82-e930-7d00-c26791ab9eef@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
In-Reply-To: <CAGXu5j+73z1dPS13xrOgPpn47sfwzNd9BO-USr7V+7quJt7yjA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::13) To AM4PR08MB2788.eurprd08.prod.outlook.com
 (2603:10a6:205:d::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ramana.Radhakrishnan@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB2772;6:zqxrgiJ3rGBjKUHQIpU5Xf9NkdBMts6alz5pZ5HtRY02ET41kiMrhx/oz1hoUPHr8xVHs8NFlvEwVjyrnEP4L+PjprA0mZM8HMauUsEFbo6BvfNEYoYylAQWEzWQOKpe7/z2swcF6eZim1DOFswlWk+y23+ENcsZpffQIxq0VSCywECuWK+TNopNyMp7ROv3oKq2gND6PyMS9b1DcrEI5TC2MP6TRV1N2QLxThbPggbJA97hTWVAlwqcnYqi34dbrQDb9cJ097MXKi8UmpcVuMjEwevzFzDfU6LMkr2Qfvsmsx8NuBeVVorWlt2CPXX9o7SH0tyfCQoxkNOxb9OnFYT5v6BCqkC6A3Rp2lDV1JEaHBXIOhJVhc0eunpULntBlFQC4sxl4/Rj/UqNDPqgueqRrltPOAvN8HQMm2WmZ5U+Z7OMMx+duzcBHK1FZ15Ay3DVuezaZbd+Pq/FqIUA5w==;5:xS3b/CTKFB24U7C64Bmwowx+BzpVI110/ke2Xbq6tYwdhVd89bvQxTlFxz5j89mhOds10My0q2Jd4y+g9ggWKYwQZcd+NdNPthBk1jhXGI6/Q1GXqW5U2p87kDZZRATVt7hXoT3el5LO0MHq8peIu3QF1wDRmUpaDyUg3GaBLZw=;7:LI+SVwQ10DYpQwXgPZgpHG4A/83+FQQ83SAtZZ71QLwNZPFvp40Bbddu8S1AsRdMzIgu+/uhY5HZXRm7bmjmZlBb1rWn9zZye/rHpH0hjO8xBG7mnTpNLAYW+Gx6cuDcu86lxDLwjQlrjonQsYWkwQ==
x-ms-office365-filtering-correlation-id: f4e5a029-3985-4717-1e03-08d640a81ad7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2772;
x-ms-traffictypediagnostic: AM4PR08MB2772:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM4PR08MB277233F57B334A062500F3D081CF0@AM4PR08MB2772.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM4PR08MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2772;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(6116002)(31696002)(305945005)(68736007)(6506007)(8936002)(102836004)(86362001)(386003)(26005)(3846002)(76176011)(52116002)(65806001)(256004)(72206003)(71190400001)(71200400001)(97736004)(2906002)(7736002)(14454004)(8676002)(316002)(81166006)(81156014)(2900100001)(58126008)(54906003)(4326008)(110136005)(99286004)(6636002)(105586002)(186003)(25786009)(229853002)(106356001)(65826007)(5660300001)(65956001)(446003)(2616005)(11346002)(476003)(44832011)(486006)(6486002)(36756003)(64126003)(53936002)(478600001)(6246003)(6436002)(31686004)(66066001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2772;H:AM4PR08MB2788.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i3b+VK7gFBjwZ+WZ6V7CM7TSHVAIlWxPjepOXlvfsDSp1Jx1Ne8KjROnp/Rlqp32aHT5hzQm83WVgJLxPcEfawjlVj/J1hxmn4bNlS/u9FfobBugG81+1WS/7R/ikPeraLMOmv+DI5MsAftK5+M9m2yz4AAnJy3F+x1Hb/qayT+wwIVuNLGetCpCyRqBBM5ajSLWB73ac6cmNtUnwwSQ2wTIFEdMV1dq8B5x8RVOJ/0siXF3jZzpJzSkRuo3+IAgxl5Rs+LDRJc1wqvwMQ3QwZ0/aJr5TZs8rXmlQA24UBVK10exj1nar3/dfDL0XlMzGotFDoM7BTZUSC5rJ7MIoEXw1BJuyZE8fn6Dx3gOeg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC72581046359458B7C520916056EC1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e5a029-3985-4717-1e03-08d640a81ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 09:46:47.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiArDQo+PiArV2hlbiBDT05GSUdfQVJNNjRfUFRSX0FVVEggaXMgc2VsZWN0ZWQsIGFuZCBy
ZWxldmFudCBIVyBzdXBwb3J0IGlzDQo+PiArcHJlc2VudCwgdGhlIGtlcm5lbCB3aWxsIGFzc2ln
biBhIHJhbmRvbSBBUElBS2V5IHZhbHVlIHRvIGVhY2ggcHJvY2Vzcw0KPj4gK2F0IGV4ZWMqKCkg
dGltZS4gVGhpcyBrZXkgaXMgc2hhcmVkIGJ5IGFsbCB0aHJlYWRzIHdpdGhpbiB0aGUgcHJvY2Vz
cywNCj4+ICthbmQgdGhlIGtleSBpcyBwcmVzZXJ2ZWQgYWNyb3NzIGZvcmsoKS4gUHJlc2VuY2Ug
b2YgZnVuY3Rpb25hbGl0eSB1c2luZw0KPj4gK0FQSUFLZXkgaXMgYWR2ZXJ0aXNlZCB2aWEgSFdD
QVBfQVBJQS4NCj4gDQo+IEl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBpbmNsdWRlIGRvY3VtZW50YXRp
b24gaGVyZSBvbiBob3cgbWFueSBiaXRzIG9mDQo+IHRoZSBhZGRyZXNzIGFyZSBiZWluZyB1c2Vk
IGZvciB0aGUgUEFDIGJpdHMgKEknbSBhc3N1bWluZyBpdCdzIDc/KQ0KDQoNCnRoZSBudW1iZXIg
b2YgYml0cyBhdmFpbGFibGUgZGVwZW5kcyBvbiB0aGUgVkEgc2l6ZSwgc28geW91IGNhbid0IHJl
YWxseSANCmRvY3VtZW50IGEgbnVtYmVyLg0KDQpSYW1hbmENCg0KPiANCj4gLUtlZXMNCj4gDQoN
Cg==
