Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7473C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774AC2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="J7ZhAAkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774AC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeIGVQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:16:51 -0400
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:51857
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeIGVQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M29ZZ/Zqxj5valvrNJUd24+rAXvgTc/a0rh63GvOCE=;
 b=J7ZhAAkKrpD7UOegcEUPA6B2wXb1YjYF9lY5A9RcIoCi7QZwKVMFTo//3wMMj77A0aixqlztdG4c8OOjbB3IyFCbz+rFE4aF2pO4Lhkng3WEAlXu5p61o1WDY2FCYgV+4qVh0lCU0ggiZO1cqu+4cOXDxjX0PEM8uMPRqWa8jSs=
Received: from MWHPR01MB2336.prod.exchangelabs.com (10.169.237.8) by
 MWHPR01MB2367.prod.exchangelabs.com (10.168.202.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 16:35:03 +0000
Received: from MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab]) by MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab%9]) with mapi id 15.20.1101.019; Fri, 7 Sep 2018
 16:35:02 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
Subject: RE: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Topic: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Index: AQHURgwxlvsYSwD++0WmVzt64VJHs6TjrhEAgAAAOHCAATMDgIAAI46Q
Date:   Fri, 7 Sep 2018 16:35:02 +0000
Message-ID: <MWHPR01MB2336534C2B5343D4235063E3B3000@MWHPR01MB2336.prod.exchangelabs.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
 <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
 <cd3e5c60-1619-9842-6198-e36fdbaa4b4b@kernel.dk>
In-Reply-To: <cd3e5c60-1619-9842-6198-e36fdbaa4b4b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR01MB2367;6:OQgFT+w+3HLWDwFBV2/tVpNfpyIiW2XPWzMC5oQ6KdeqLqx89T9yZkcFUg+/Pwx2PWmMHrSSzfbOmR23evzNdMIvmNPva1AalO6D5grJRM4F7BSi42TrRCxPie/DvaA0bLFER+twuo1b4Mnx6/CCNMK1jNPAr4KIIjcYuaOqRi2YAz9rwkE4b+PhNtln82849Vcjc6xQvR14zbAxdrI0QsoQCk9PaYgRaaEomtDwut2SUKfjo3q2rc2StIHnSAhbj6bFPUO436AqReEFT7egFPRewWHlUab4V/AtQBEZsVQQRAozdWBNJKK2B/ouRGwH2ZV8+xfkjfkbROoOwnJfB9BLNzR2/L7kdo5yTw/LGxeEd8iBUFbz5XcYGRFZtUDEN6fO5qHhxpfgjYmP+I9DRj5x5BzsdG2bxXbxAYAdUwqA3kTjJdWc/7RaVQWFH7KlK4nIIxxtEzlbfOZCTkoiZg==;5:9BtetVgq7V/IUwDWgeTk9FxWJVUEYxDv63+22hbWDjge4kWo1lEfz5SQ/qMzrnZn2xsKcfArW/qCtS4Nv5Ur76UKA0aY/sHDMg7Z9+2Z/id2mperDi85ortNyvdCIruljSPrn6r0NJCw7UnMvKy8/o9yvBWQQwq+VqU4r1LfIu4=;7:SpSkfvE1VABYC/+RPLigXM5KlPbfo8w0+v2+NLe2HuMVyKITwTGVIiiK7kOWjs3pymHjurS57MIel14vABvwbRk8x6QdvBL6WcK8NmZhSam/QTtm5EpqPb3H5PX1nqnhPZznWsxN7I6aoxaKKPG8Qy2siQ69+M4hdCL9l7zCm+6XujirlWd6aCA4OneMQ72tnzHOmhV9WPYWP9jli3hslYA4UZ2hMpebWKMEgoWMOJ5/c+soi4nZWV+YyOYOQKCq
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(366004)(136003)(189003)(199004)(13464003)(51914003)(97736004)(14444005)(4326008)(476003)(256004)(66066001)(74316002)(5660300001)(6246003)(478600001)(6116002)(3846002)(106356001)(446003)(81166006)(14454004)(55016002)(99286004)(2906002)(217873002)(81156014)(8936002)(9686003)(305945005)(7696005)(53936002)(7736002)(76176011)(107886003)(6436002)(316002)(486006)(102836004)(54906003)(8676002)(25786009)(110136005)(93886005)(86362001)(68736007)(6506007)(5250100002)(2201001)(26005)(229853002)(186003)(105586002)(2900100001)(2501003)(11346002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2367;H:MWHPR01MB2336.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 70d0f788-fde0-41b4-a201-08d614dfdc83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2367;
x-ms-traffictypediagnostic: MWHPR01MB2367:
x-microsoft-antispam-prvs: <MWHPR01MB23672F94761B679BF20AC38BB3000@MWHPR01MB2367.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:MWHPR01MB2367;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2367;
x-forefront-prvs: 07880C4932
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: r6NAI+AWWsZbxenpz4EPdcaY+U7yM18U4WISUCoGZJKLbyeQdlz5hyvBiPD/n5Nd4NggLDofn2TQjJqFDi1KT45FDhuVfTBPzTrZb28lzGGyQfKWTe8GOer69fTGnUcxH7ZAweY8fvaUORR9Qkw5ZG6jJe4+HHp7zQQgsbXhMrwnyqMVs7YiDIYrbkMeFOiTKIfzD8AWQlfYlBic45eoblwLK5BTi93GS+pZKrkT6i2Ao97WOUOy7yvSKLVa/Hyinz8AF5Xp/usNfIq3ruBfCCFxyh/1y3uLJgQBwl6UXjMC7Y+WptnYT1UW7+KDaBFtX+RtiehPZ+gA7cYs+Kgehm+ZPCgZh+mslCLe7SDyrgk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d0f788-fde0-41b4-a201-08d614dfdc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 16:35:02.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVucw0KDQpXaXRoIHJlZ2FyZHMsDQpTdW1hbg0KDQoNCg0KPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPlNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDcsIDIwMTggNzoyNiBBTQ0KPlRvOiBTdW1hbiBUcmlwYXRoaSA8c3Ry
aXBhdGhpQGFtcGVyZWNvbXB1dGluZy5jb20+OyBIYW5zIGRlIEdvZWRlDQo+PGhkZWdvZWRlQHJl
ZGhhdC5jb20+OyB0akBrZXJuZWwub3JnOyBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj5hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+am9lQHBlcmNoZXMuY29tOyBhcm5kQGFybmRiLmRlOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZw0KPkNjOiBPcGVuIFNvdXJjZSBTdWJtaXNzaW9uIDxwYXRjaGVzQGFtcGVy
ZWNvbXB1dGluZy5jb20+OyBSYW1lc2h3YXINCj5TYWh1IDxSYW1lc2h3YXIuU2FodUBhbXBlcmVj
b21wdXRpbmcuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGF0YTogRGlzYWJsZSBBSENJ
IEFMUE0gZmVhdHVyZSBmb3IgQW1wZXJlIENvbXB1dGluZw0KPmVNQUcgU0FUQQ0KPg0KPltOT1RJ
Q0U6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIGFuIGV4dGVybmFsIHNlbmRlci4gUGxlYXNl
IGJlIG1pbmRmdWwgb2YNCj5zYWZlIGVtYWlsIGhhbmRsaW5nIGFuZCBwcm9wcmlldGFyeSBpbmZv
cm1hdGlvbiBwcm90ZWN0aW9uIHByYWN0aWNlcy5dDQo+X19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+DQo+T24gOS82LzE4
IDI6MDggUE0sIFN1bWFuIFRyaXBhdGhpIHdyb3RlOg0KPj4+IFNvcnJ5LCBidXQgdGhlIHBhdGNo
IGlzIHN0aWxsIGNvbWluZyB0aHJvdWdoIG1hbmdsZWQuIERpZCB5b3UgdXNlIGdpdA0KPj4+IHNl
bmQtZW1haWwgPw0KPj4NCj4+IFtTdW1hbiBUcmlwYXRoaV0geWVzLiBJIHJlY2hlY2tlZCBiZWZv
cmUgc2VuZGluZyB0d2ljZS4gU29ycnkgZm9yIHRoZQ0KPj4gaW5jb252ZW5pZW5jZS4gV2lsbCBm
aWd1cmUgdGhlIGlzc3VlIG91dA0KPg0KPkkgY2FuIGFwcGx5IGl0IG1hbnVhbGx5IHdoaWxlIHlv
dSB3b3JrIG91dCB0aGUga2lua3MgaW4geW91ciBlbWFpbCBzZXR1cC4gSXQgbWlnaHQNCj5ldmVu
IGJlIHlvdXIgY29tcGFueSBNVEEgbWFuZ2xpbmcgaXQsIEkndmUgc2VlbiBhbGwgc29ydHMgb2Yg
Y3JhenkgbGlrZSB0aGF0Lg0KVGhhbmtzIGZvciB0aGUgc3VwcG9ydC4gV2UgYXJlIHdvcmtpbmcg
d2l0aCBJVCB0byBmaXggdGhpcyBpc3N1ZS4NCj4NCj4tLQ0KPkplbnMgQXhib2UNCg0K
