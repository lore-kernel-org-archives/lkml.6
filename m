Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309FFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2394206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mmmhh2QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2394206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeIJSNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:13:53 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:61429
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbeIJSNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SeFv1SWLAv7Q4g97QDtQA3aMpGDK9gUsEru20UchmI=;
 b=mmmhh2QU2MwQpWxHqoO1euUk9b/nMNsH4anUI2KKEWGNGHTsVzUbO9AkH9rQFnczVzjv8bT7NYnF3YpvgYmo8tbQakjooiCR4dov8OFgATtVHG/4FkHChMFm8ha33MMkShT1V7kKhhhu/c5ENpLUm3juhBYZFmpv2HoUOt214x8=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0188.namprd21.prod.outlook.com (10.173.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 13:19:45 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 13:19:45 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ville Syrjala <ville.syrjala@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Thread-Topic: [PATCH] Revert "x86/tsc: Consolidate init code"
Thread-Index: AQHUSQjxLphj/AJ98km4gIQJq7WIkg==
Date:   Mon, 10 Sep 2018 13:19:45 +0000
Message-ID: <f1aef143-3ea4-e80d-0757-e97b36b0216e@microsoft.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0188;6:dT95Pz+bxzHwQowLn6q47I8BYkQKCtnWgZWFYBVXDrkUfW2ITV1MBxKZdp03i7IiYt2egCl5B/8vA7WSSNV4BuqP1dihfQdn3MENjbbLeW5klWZhDJS3HVxySLguknmzA7qzz0JZMvDJ/QoK9ccFjZn2m9wg6D/jPMWdVRhnDs/iaW3p4lDaplfkgG3ueBA+6cg6Kho4+ib84NiqOs77HwuhHPrZTHnOJfwM23KyMbMxQfnh7iNibb6d1MQYw0Esd3LYpnYoFtER1i/dBzkr9D8HcAX2//atYpADrAG10E2/BqSGVEbZIplzkpsgs02PrwvV16UYNt2F3H57YsG2tGnIz0D5a2UTjMN5t2I9v0kjt6F1O9hNujGPrLDbfQNKZGlgLJSeMavLQVbRVjetJoANx/u78d/HxZmjQnG3qKx/bmjVpfWOvFLjl6j2NAfy1j09w+9L1YPdyAcabsG0Bw==;5:IYktBsxog3Bz/bK0O7UvMbVW1SOP97n0SAp8M8EhAPRCRaI/pYBZAaU1pzWafYJiH/3CPAjHes3V4Q/dXHtCUj2YM9Q9FO+kLtJK3E+7QrPmN5f6psJXPU2VnloZQm6D8wxx6ujYyKtgRDGhfwKJmXKgASsqRrNRu+gigX20Ml0=;7:+O0ZMDdA829jJMZr3BIermblVUYH2LTiOjXAbiMZokFQg4nvIBy8DVd7mnT91VNX+YArpFMyClAmABJDBq5vBy91WA9+WCwWzYM+FHSf1ZCr8pDBV0JBA6qcJCf7P20FQoYyWfNFrPmWTegOxeAcdqkKNyXqaybxIBkcJpzo2uJgmTmzN+WkTz+WigMq2SsHgjs/v5c7qeeW0lkAAaBs68y47YiPX3GXE4hiY8IRVTN3cEFRYTUqVBqpYWtZUN3e
x-ms-office365-filtering-correlation-id: 7c8b8b45-c5a4-4326-48d0-08d6172013be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0188;
x-ms-traffictypediagnostic: DM5PR21MB0188:
x-microsoft-antispam-prvs: <DM5PR21MB01887CCA72874844D1E542949D050@DM5PR21MB0188.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0188;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0188;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(54534003)(54094003)(3846002)(10290500003)(66066001)(81156014)(106356001)(105586002)(6436002)(6116002)(102836004)(316002)(10090500001)(186003)(478600001)(26005)(6506007)(54906003)(5250100002)(4326008)(110136005)(53546011)(81166006)(22452003)(68736007)(6512007)(14454004)(99286004)(31686004)(72206003)(2616005)(97736004)(5660300001)(8676002)(14444005)(476003)(446003)(8936002)(11346002)(305945005)(7736002)(486006)(76176011)(36756003)(6486002)(2900100001)(6346003)(229853002)(6246003)(86612001)(86362001)(2906002)(31696002)(53936002)(256004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0188;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: YaFh38WARTjQNXxp0t7n7/iDY3a4dno/Cfj2Pvp4+RotycPakCBq9SOvOfx66Tpwyp5mq8fBv2qpEUwCMTi2RwWDIPtPOnezK0MI7WKIFYqA/uW4BRqr4CjC9fxSycz8hi7k3HxDQcufZwD2zYnHQXza0UUShZmIlXad1xBPSTMsURClaXuxoLVy5wut5cTAwqWKtS6tXKsicUqVqwLAMuqmQ8JhG0RMfjKjcF5+FUlv48bONBJ9vVvOvEb5v/NjM3LxaqIDB9fzGuPGoaBj1timktB668KRtydS1daaEecMTbejbXdxTaaDmm5SXZP50YNQZfMz/aw2TUz1szINLVuiEX/SJBw35d/rJM8+Jmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <503A5B9E4878274897E2EA8E71CAAD31@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8b8b45-c5a4-4326-48d0-08d6172013be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 13:19:45.5792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlsbGUsDQoNCg0KVGhlIGZhaWx1cmUgaXMgc3VycHJpc2luZywgYmVjYXVzZSB0aGUgY29t
bWl0IGlzIHRpbnksIGFuZCBhbG1vc3QgZG9lcw0Kbm90IGNoYW5nZSB0aGUgY29kZSBsb2dpYy4N
Cg0KRnJvbSBsb29raW5nIHRocm91Z2ggdGhlIGNvbW1pdCwgdGhlIG9ubHkgZnVuY3Rpb25hbCBk
aWZmZXJlbmNlIHRoaXMNCmNvbW1pdCBtYWtlcyBpczoNCg0Kc3RhdGljX2JyYW5jaF9lbmFibGUo
Jl9fdXNlX3RzYykgd2FzIGNhbGxlZCB1bmNvbmRpdGlvbmFsbHkgZnJvbQ0KdHNjX2luaXQoKSwg
YnV0IGFmdGVyIHRoZSBjb21taXQgb25seSB3aGVuIHRzY19raHogPT0gMC4NCg0KSSB3b25kZXIg
aWYgb24gcDMgc3RhdGljX2JyYW5jaF9lbmFibGUoJl9fdXNlX3RzYykgZmFpbHMgdG8gZW5hYmxl
DQplYXJseSwgd2hlbiBpdCBzdXBwb3NlZCB0bz8gQnV0LCBJIHdvdWxkIGZpcnN0IHRyeSB0byBt
YWtlIHRoYXQNCnVuY29uZGl0aW9uYWwgY2FsbCBhZ2FpbiwgYW5kIHNlZSBpZiB0aGlzIGZpeGVz
IHRoZSBwcm9ibGVtLCBhbmQgdGhlbg0KZmlndXJlIG91dCB3aHkgaXQgd2FzIG5vdCBlbmFibGVk
IHdoZW4gaXQgd2FzIHN1cHBvc2VkIHRvLg0KDQpTbywgaW4gdHNjX2luaXQodm9pZCkNCg0KRmly
c3QgdHJ5IHRvIGFkZCB0aGlzIG9uZSBsaW5lIGJhY2s6DQoNCiAgICAgICAgY3ljMm5zX2luaXRf
c2Vjb25kYXJ5X2NwdXMoKTsNCi0gICAgICAgc3RhdGljX2JyYW5jaF9lbmFibGUoJl9fdXNlX3Rz
Yyk7DQoNCg0KU2VlIGlmIGl0IGZpeGVzIGV2ZXJ5dGhpbmcsIGFuZCBsZXRzIHdvcmsgZnJvbSB0
aGVyZS4NCg0KVGhhbmsgeW91LA0KUGF2ZWwNCg0KT24gOS8xMC8xOCA4OjQ4IEFNLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IFZpbGxlLA0KPiANCj4gT24gTW9uLCAxMCBTZXAgMjAxOCwgVmls
bGUgU3lyamFsYSB3cm90ZToNCj4gDQo+PiBGcm9tOiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5
cmphbGFAbGludXguaW50ZWwuY29tPg0KPj4NCj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgNjA4MDA4
YTQ1Nzk4ZmU5ZTJhZWUwNGY5OWI1MjcwZWE1N2MxMzc2Zi4NCj4+DQo+PiBJdCBicmVha3Mgd2lm
aSBvbiBteSBwZW50aXVtIDMgRnVqaXRzdS1TaWVtZW5zIExpZmVib29rIFM2MDEwDQo+PiBsYXB0
b3AuIFNjYW5uaW5nIGZvciBBUHMgZG9lc24ndCBzZWVtIHRvIHdvcmsgbW9zdCBvZiB0aGUgdGlt
ZSwNCj4+IGFuZCwgZXZlbiB3aGVuIGl0IG1hbmFnZXMgdG8gZmluZCBzb21lIEFQcyBpdCBuZXZl
ciBtYW5hZ2VzIHRvDQo+PiBhdXRoZW50aWNhdGUgc3VjY2Vzc2Z1bGx5LiBkbWVzZyBpcyBqdXN0
IGxpdHRlcmVkIHdpdGg6DQo+PiAid2xhbjA6IHNlbmQgYXV0aCB0byAuLi4gKHRyeSAxLzMpDQo+
PiAgd2xhbjA6IHNlbmQgYXV0aCB0byAuLi4gKHRyeSAyLzMpDQo+PiAgd2xhbjA6IHNlbmQgYXV0
aCB0byAuLi4gKHRyeSAzLzMpDQo+PiAgd2xhbjA6IGF1dGhlbnRpY2F0aW9uIHdpdGggLi4uIHRp
bWVkIG91dCINCj4gDQo+IEkgYXNrZWQgZm9yIHRoYXQgYmVmb3JlIGFuZCBJIHJlYWxseSBkbyBu
b3QgdW5kZXJzdGFuZCB3aHkgeW91IGRvIG5vdCBldmVuDQo+IG1ha2UgYW4gYXR0ZW1wdCB0byBy
ZXBvcnQgYW4gaXNzdWUgZmlyc3QgYW5kIGFsbG93IHRoZSBkZXZlbG9wZXJzIHRvIHdvcmsNCj4g
d2l0aCB5b3UgdG8gZmlndXJlIG91dCB3aGF0IGV4YWN0bHkgaXMgdGhlIHByb2JsZW0uIEFsbCB5
b3UgZG8gaXMgdG8gc2VuZA0KPiBhbiByZXZlcnQgcGF0Y2ggd2l0aCBhIGNoYW5nZWxvZyB3aGlj
aCBkZXNjcmliZXMgc3ltcHRvbXMgYW5kIHByb2JhYmx5DQo+IGJyZWFrcyBtb3JlIHRoYW4gaXQg
Y3VyZXMuIE5vdCByZWFsbHkgaGVscGZ1bCwgcmVhbGx5Lg0KPiANCj4gSXQncyBzdXJlbHkgaGVs
cGZ1bCB0byBrbm93IHRoYXQgeW91IGJpc2VjdGVkIGl0IHRvIHRoYXQgY29tbWl0IGFuZA0KPiBy
ZXZlcnRpbmcgaXQgaGVscHMuIENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWxlcyBp
bmZvcm1hdGlvbiBsaWtlDQo+IGRtZXNnIG9mIGFuIGdvb2QgYW5kIGEgYmFkIGJvb3Q/DQo+IA0K
PiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCj4gDQo+IA==
