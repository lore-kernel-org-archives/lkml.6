Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A86C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BAF20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=opengear.com header.i=@opengear.com header.b="IAcf6pSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BAF20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opengear.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeJaMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:14:41 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:56928
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728726AbeJaMOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6FEqs8GSvqpIUCRGA5WvupYc4UDfU7yboh70weio+4=;
 b=IAcf6pSBvDO+mAvcYrzmpncA5p+lCMhzHE4FeLadP78zkZOblrOUJnhKpIL+mKgAD7YV99CycaoD5DqYYmA4Vv91hDVbm2lXlEmzU3qWA9s8cIgcdC08F/+TDM08PGNurdFfgD10kjCTjjSt33LNw7INQnq/Jx/WQSmzbD7kmlg=
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com (52.132.130.30) by
 DM5PR1501MB2167.namprd15.prod.outlook.com (52.132.131.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 31 Oct 2018 03:18:28 +0000
Received: from DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::ad1b:d831:4d48:1949]) by DM5PR1501MB2056.namprd15.prod.outlook.com
 ([fe80::ad1b:d831:4d48:1949%5]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 03:18:28 +0000
From:   "Grandbois, Brett" <brett.grandbois@opengear.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Thread-Topic: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Thread-Index: AQHUZOs9cFLja65s+EWijjbFGrgyH6UzTLuAgAOkAACAAJnUgIABPFOA
Date:   Wed, 31 Oct 2018 03:18:28 +0000
Message-ID: <1912426d-8189-0508-d152-8dfcf6192162@opengear.com>
References: <20181016005726.26813-1-brett.grandbois@opengear.com>
 <20181027173945.241e87b2@bbrezillon>
 <a6edf985-0d15-5b2b-a6ba-9cfcd7a67836@opengear.com>
 <20181030092605.38851906@bbrezillon>
In-Reply-To: <20181030092605.38851906@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:3:2::23) To DM5PR1501MB2056.namprd15.prod.outlook.com
 (2603:10b6:4:a2::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brett.grandbois@opengear.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [120.157.100.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1501MB2167;6:I2eHP23HZW8Bzr0Ff65ULqs/3Z/YX8qw8Fsf4WC6Tyf4RW6R/6YGiujFV5ojl/q/yiNbGkCKQOd3d+10MkVsYWEuV4cLzWGzOTn7F/I4AgVGmunbh1ooywyRXmWsmJ8Bd5xduYnxWDPPrJR3Xhmbk4AP+QZpbhADrP1azFBHbd1MUDi5WgHfCTk+NFw/Oeq2iHtc0Ea3TWr3BZZnszs8RIXM9vxOZcTu4PRJFLg3IgjRm+kFui7xKaLnOZ2c+YqekBGCl2kLmWo+vsY14H+uN9SXkEMCy04LPubTHfCfoYlAlDbzkIqcyQIBGp6XxP3lktxzOR/CdPH9ZNzRWGS9W+wCmj17usGUTsdrmUjW1uut+379Z+dURll/dP3J2XJRbDjTtPRub4BsNdce5HIPU6SPRO5a7yrif0iLVoCT2K1Eh8JoZE1wL/mFts1vGh2NYK8JajgcdJEw5XKCmaEJnA==;5:DFrV0KaFnwii2LT7Xzeur2P7JTN5L6bYuZ76CPAZKXjIXPBOtwAE/T51gFty1u5FYJfm91lEleVzs0vBlctTaJ9GxE0ehv6zSiJq1pcufdYyr2IsLaWU2628U1eFIHyZ9A9jRjOLZUz4EPg2BMri7yhsN9MKfQOD4kC58Ms6++E=;7:hcAF3a0jVP6zO8wV+EGRKDQpjg2jUJFV8lcvDzsaQnX5BeaOvHeY9aITJ+k8/wHrcRHOobei5AJDOy04KGqYwTtAvgsXQy5IvsqqIsTF1sUQwewWd9IF0OzoEIWtngPGaTglNwlM/s7Vz1qIoJeXdw==
x-ms-office365-filtering-correlation-id: 6e71955e-23d1-460d-0467-08d63edf86ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR1501MB2167;
x-ms-traffictypediagnostic: DM5PR1501MB2167:
x-microsoft-antispam-prvs: <DM5PR1501MB21673BD11A25EF94C799E28782CD0@DM5PR1501MB2167.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR1501MB2167;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1501MB2167;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(39840400004)(396003)(199004)(189003)(14444005)(68736007)(71190400001)(71200400001)(316002)(11346002)(478600001)(7736002)(446003)(2616005)(305945005)(476003)(8936002)(14454004)(486006)(256004)(6116002)(2906002)(86362001)(97736004)(66066001)(5250100002)(81166006)(81156014)(8676002)(36756003)(31696002)(93886005)(5660300001)(3846002)(53546011)(6506007)(386003)(229853002)(105586002)(99286004)(4326008)(52116002)(31686004)(26005)(54906003)(102836004)(106356001)(2900100001)(6486002)(76176011)(6916009)(39060400002)(6512007)(53936002)(25786009)(186003)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1501MB2167;H:DM5PR1501MB2056.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: opengear.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l94QBe2di1HtnQNbOWMK2zAA/5gXLOPwsAr8QuiOOy1NSkEZCpNXW/SI5/r2ct3ldnoAA2KZyhwm8BxcOcvisQTBlK1IOPcVp5KNcpkJb3QEUQ/pKx+OG/U18o9hgISnac6SPsoRALxrcTsVWX6eLTbpwsxdvo6AWtuEMcR/nMaizgMsqhvqe/57FlQyIl9X1C7uDqpDXOyLdmHB9I8WADc9mXynf2xXg8xSW/+MKo8VJFIWO0mcoCprOOlXjypyzlNlaR/zFNfNrajTL55ov61wFB7QKPkgiYCsotelu5VXIjbgVmXbmrfCwd+xdh8AznWhfUSzvuZSOlOMuumwtXmnWu7oAQMtNqU23TN1T8o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CCA30FD62C4C844A5B6A7F6097A0902@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e71955e-23d1-460d-0467-08d63edf86ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 03:18:28.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMC8xMC8xOCA2OjI2IHBtLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+IE9uIE1vbiwg
MjkgT2N0IDIwMTggMjM6MTU6NDIgKzAwMDANCj4gIkdyYW5kYm9pcywgQnJldHQiPGJyZXR0Lmdy
YW5kYm9pc0BvcGVuZ2Vhci5jb20+ICB3cm90ZToNCj4NCj4+IE9uIDI4LzEwLzE4IDE6MzkgYW0s
IEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4+PiBIaSBCcmV0dCwNCj4+Pg0KPj4+IE9uIFR1ZSwg
MTYgT2N0IDIwMTggMDA6NTc6NDEgKzAwMDANCj4+PiAiR3JhbmRib2lzLCBCcmV0dCI8YnJldHQu
Z3JhbmRib2lzQG9wZW5nZWFyLmNvbT4gICB3cm90ZToNCj4+PiAgIA0KPj4+PiBBZGQgc3VwcG9y
dCB0byBleHBvc2UgdGhlIFNQSSBib290IGZsYXNoIG9uIEFNRCBGYW1pbHkgMTZoIENQVXMgYXMN
Cj4+Pj4gYSBzdGFuZGFyZCBtdGQgZGV2aWNlIHRvIGdpdmUgdXNlcnNwYWNlIEJJT1MgdXBkYXRl
cnMgZ3JlYXRlcg0KPj4+PiBmZWF0dXJlIHN1cHBvcnQuICBUaGUgQklPUyBhbmQgS2VybmVsIERl
dmVsb3BlcidzIEd1aWRlIHJlZmVycyB0bw0KPj4+PiB0aGlzIGFzIHRoZSAnU1BJIFJPTScgY29u
dHJvbGxlciBhbmQgc28gdGhlIGRyaXZlciBmb2xsb3dzIHRoYXQNCj4+Pj4gbmFtaW5nIGNvbnZl
bnRpb24gZm9yIGNvbnNpc3RlbmN5Lg0KPj4+PiAgIA0KPj4+IFdlJ3JlIGN1cnJlbnRseSB0cnlp
bmcgdG8gY29udmVydCBzcGktbm9yIGNvbnRyb2xsZXIgZHJpdmVycyB0byB0aGUNCj4+PiBzcGkt
bWVtIGludGVyZmFjZSBbMV0uIENhbiB5b3UgbG9vayBhdCB0aGlzIG5ldyBpbnRlcmZhY2UgYW5k
IHRlbGwNCj4+PiBtZSBpZiB5b3UnZCBiZSBhYmxlIHRvIGltcGxlbWVudCBpdD8gSWYgdGhhdCdz
IG5vdCBwb3NzaWJsZSwgdGhlbg0KPj4+IEknZCBwcmVmZXIgdG8gaGF2ZSB0aGlzIGRyaXZlciBp
bXBsZW1lbnQgdGhlIG10ZF9pbmZvIGludGVyZmFjZQ0KPj4+IGRpcmVjdGx5Lg0KPj4gU28gZnJv
bSBnb2luZyBvdmVyIHRoZSBzcGktbWVtIGludGVyZmFjZSBpdCBsb29rcyBsaWtlIHRoZSBpbnRl
bnQgaXMNCj4+IGZvciB0aGVzZSBzb3J0cyBvZiBkZXZpY2VzIHRvIGJlIGEgc3RhbmRhcmQgc3Bp
X2NvbnRyb2xsZXIgd2l0aCBvbmx5DQo+PiBtZW1fb3BzIGRlZmluZWQgYW5kIHRoZSB0cmFuc2Zl
ci9fb25lL19vbmVfbWVzc2FnZSBsZWZ0IGFzIE5VTEw/ICBJcw0KPj4gdGhhdCBjb3JyZWN0Pw0K
PiBZZXMNCj4NCj4+IFRoYXQncyBhIGJpdCBvZiBhIHBpdm90IGZyb20gaG93IGl0J3MgY3VycmVu
dGx5IGRvbmUNCj4+IChpdCdzIGNvbmNlcHR1YWxseSBzaW1pbGFyIHRvIHRoZSBpbnRlbC1zcGkt
cGNpIGRyaXZlciBzbyBJIHdhcw0KPj4gZm9sbG93aW5nIHRoYXQpDQo+IFllcywgYW5kIHRoYXQn
cyBleGFjdGx5IHdoYXQgSSdkIGxpa2UgdG8gYXZvaWQuIGludGVsLXNwaS1wY2kgd2lsbA0KPiBw
cm9iYWJseSBiZSB0aGUgdHJpY2tpZXN0IGNvbnZlcnNpb24sIHNvIEknZCBsaWtlIHRvIGF2b2lk
IGhhdmluZw0KPiBhbm90aGVyIG9uZSA7LSkuDQo+DQo+PiBidXQgSSBzaG91bGQgYmUgYWJsZSB0
byByZXdvcmsgaXQgdG8gdGhlIG5ldw0KPj4gaW50ZXJmYWNlLiAgVGhpcyB0aGVuIGxpdmVzIHVu
ZGVyIGRyaXZlcnMvc3BpIGFuZCB0aHVzIHNob3VsZCBiZQ0KPj4gc3VibWl0dGVkIHRvIGxpbnV4
LXNwaT8NCj4gQWN0dWFsbHksIGlmIHRoZSBjb250cm9sbGVyIGlzIG9ubHkgZXZlciBjb25uZWN0
ZWQgdG8gdGhlIHNhbWUgU1BJIE5PUg0KPiBjaGlwIChubyBuZWVkIGZvciBhZHZhbmNlZCBkZXRl
Y3Rpb24gc2NoZW1lKSBhbmQgZG9lcyBub3Qgc3VwcG9ydA0KPiBzdXBwb3J0IE9jdG8vUXVhZC9E
dWFsIG1vZGVzIChvciBhbnkgb3RoZXIgYWR2YW5jZWQgZmVhdHVyZXMpLCB5b3UnbGwNCj4gYmUg
YmV0dGVyIG9mZiBpbXBsZW1lbnRpbmcgbXRkLT5fcmVhZC9fd3JpdGUvX2VyYXNlKCkgZGlyZWN0
bHkgKHRoZQ0KPiBkcml2ZXIgd291bGQgdGhlbiBsaXZlIGluIGRyaXZlcnMvbXRkL2RldmljZXMv
KS4NCg0KSG1tLCBjb25jZXB0dWFsbHkgdGhlIGRldmljZSBpcyBiZXR0ZXIgc3VpdGVkIHRvIHRo
ZSBtdGQgbGF5ZXIgdGhhbiB0aGUgc3BpIGxheWVyLiAgVGhlIEhXIGlzIGRlc2lnbmVkIHRvIG9u
bHkgZXZlciBhY2Nlc3Mgc3BpIGZsYXNoIGNoaXBzLCBub3QgYXMgYSBnZW5lcmFsIHNwaSBtYXN0
ZXIgY29udHJvbGxlciwgc28gcmVhbGx5IHRoZSBlbmQgcmVzdWx0IG9mIGl0IHNob3VsZCBhbHdh
eXMgb25seSBldmVyIGJlIDEgbXRkIGRldmljZS4gIFVuZm9ydHVuYXRlbHkgYXMgdGhlIGRldmlj
ZSBwcm9iaW5nIGFuZCBjb21tYW5kIHNlcXVlbmNlcyBmb3IgdGhpcyBhcmUgdGhlIHNhbWUgYXMg
aW1wbGVtZW50ZWQgaW4gc3BpLW5vciBJJ2QgZWl0aGVyIGJlIGR1cGxpY2F0aW5nIGEgbG90IG9m
IGV4aXN0aW5nIGNvZGUsIG9yIGp1c3Qgd3JhcHBpbmcgYXJvdW5kIHNwaV9ub3Jfc2NhbiB3aGlj
aCBzb3VuZHMgbGlrZSB3ZSdyZSBiYWNrIHRvIHRoZSBkZWRpY2F0ZWQgc3BpLW5vciBjb250cm9s
bGVyIHlvdSdyZSB0cnlpbmcgdG8gbW92ZSBhd2F5IGZyb20uDQoNClRoZSBzcGktbWVtIGludGVy
ZmFjZSBvcHMgZG8gbmljZWx5IG1hdGNoIHVwIHdpdGggd2hhdCB0aGUgY29udHJvbGxlciBzdXBw
b3J0cywgaW5jbHVkaW5nIHRoZSBuZXcgZGlyZWN0IG1hcHBpbmcgbW9kZSB3aGljaCBJJ2QgYmUg
YWJsZSB0byBtYWtlIHVzZSBvZiwgc28gYXMgbG9uZyBhcyB0aGVyZSBhcmVuJ3QgYW55IGlzc3Vl
cyB3aXRoIHN1cHBvcnRpbmcgb25seSBtZW1fb3BzIGFuZCBub3QgdGhlIG1lc3NhZ2UgdHJhbnNm
ZXJzIHRoZW4gaXQncyBwcm9iYWJseSB0aGUgd2F5IHRvIGdvLg0KDQogICANCg0KDQoNCiAgDQoN
Cg==
