Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC620869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="mWsOOvBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfBAIj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:39:57 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:54673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbfBAIj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKW7fgd2rQn1Nl3EBGlAqfl3NXpSY28tZFBf9i6I0eM=;
 b=mWsOOvBPA9gaCp8QdemfuppsAjaobBY7ogrKchGX5Wn5I+KhHKZC3djYp35V8Dvz0OGQoEgtVYTBkeVICjHI6aZyCns7Xo5GSW6bH5mPReLJjNHxs2m5NmzbcSQM8sZNgOdTDnrzWdjIV2pF0MsBev30jid4lV1Ao3g+QP27wAM=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4038.eurprd03.prod.outlook.com (20.177.38.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 1 Feb 2019 08:39:53 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 08:39:53 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Topic: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Index: AQHUuW2awNkJGzJtBUW2HZJ5omKh0aXJ6V2AgAC3LQA=
Date:   Fri, 1 Feb 2019 08:39:53 +0000
Message-ID: <6deaf110-44a7-59f9-a4d8-52ff9428cd9d@epam.com>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
 <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4038;6:BcpXiPoCFcWEeB8+LCp+Km082RfDCrWsHLBXuwAh+FBqAy/jHnthRcjXvtci/OU88DCsy9XaGoto6qxnxtW81Hv3ZOrFGi9vxTAFIQfgwILKCQHtVNFWxoFZzvz7Vc0rJkwmJnapyUOFGk9fjhXtIfxWnSZfezWYMAoenLOs8UXQNfJ3ZMVlrDReffFOAb+TuZFU35CGef8fqaZK/XvziQILZ7LyaZz/pA/s/AzubcDKUxqT4iMywzYqYkqr+Yx2WSzxd80aDD/KKZAYnAyZW26gou14yQ14F76dpJfn+nUsmmsFmzRgqynZ3tzkjUQgc3AZsdWUOa4xsKYLWiGscg2JzxUK020mWxIERpj1FhqBFqQQzH95aev+RBQUZ0AlEDYMe8jOAJqdog6tSGHxg6VWw3Xw0CvaqT+/+zXnZnNaGtaXEuC7sjubGBhnPlMlESQMkHvTpErRyruoffk2IA==;5:rGQwxElKpv8igk0dmKCncIYxNE2ciq253ADaQIfHTBeQnK+hIdSpV2lPqdqGXkhq3pLRa3mv6dxibDNBj/VwFYIp0GHw1/u7xqFZ8d9maBgC5pmiDw49CvJ3dUHmRWxPqLJ/VcrGfAal4QIABQJgCvZsYwkzKpyfY6ycKdYhd6Pmb5Q4SS//0sz3zLqPN5kOmmQWSZGw8BPWfSP+mEb49w==;7:DrZ90kp7ScblRkSdQfY4m9J37ayLADPyvULYXLVCwgVwcO2iPrO9j8hg2mOQ5N8yb92mIwNo7cJUoBRbSm77O+WeyhrPOtQKVpidJ8AlL9dtNfzXbfaXsX1tyaUckgzihNaAfOgJTw84YJcebLoNbw==
x-ms-office365-filtering-correlation-id: 911d088e-39f3-41c6-ee8b-08d68820d644
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4038;
x-ms-traffictypediagnostic: AM6PR03MB4038:
x-microsoft-antispam-prvs: <AM6PR03MB40384482616EAAF902F6BF8EE7920@AM6PR03MB4038.eurprd03.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(72206003)(305945005)(486006)(229853002)(14454004)(81156014)(53936002)(31686004)(81166006)(478600001)(966005)(8676002)(8936002)(2906002)(554214002)(14444005)(256004)(106356001)(7736002)(316002)(476003)(54906003)(105586002)(2616005)(11346002)(446003)(76176011)(66066001)(97736004)(31696002)(99286004)(102836004)(36756003)(55236004)(68736007)(86362001)(6916009)(186003)(4326008)(25786009)(80792005)(6436002)(6512007)(26005)(53546011)(3846002)(6116002)(6246003)(6486002)(71190400001)(6506007)(6306002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4038;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pnqu7K5RsydoaI03r97E47fT96ohbRBwo39RsgTw48sTiN/KYSmp1PMTJTGHT4Dbr0NmUFlFzj63FIQ2peAUKSV8uieKmBcZjOlPLjNatlvMPB+GypKxKqc3y/L3LZPAL9lkRlrhxP1Y39wnV+0bT/v2luM+FA9U4CloyIlBBz3gj+OSdth67HuZVqZuMeZMwn2Mv/ubKjxPvxMm74VGOH/1Hv6OnxFgT+koYoVNCRw8XTh2BIprmmmPi8zREp2o3VYP6mE/f6ZtSe3L6+wgE8V8q2O8Tb1soMmoX7x7GEN2jtB4TAi5HlGwSzQlkUL79h3QluV7ad+EY5dYFZmhRwY8IpJedyqSCt/6zNLaOKZoz+UPRp7m99fR7BrOmIAW1s2EzQcoMG7xELjzKpewmQK4iIPzh6t4lM+swGWKFV4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFB251A3CF478E46A60B076BB4E3CF5E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d088e-39f3-41c6-ee8b-08d68820d644
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 08:39:53.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMS8xOSAxMTo0NCBQTSwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPiBPbiBUaHUs
IDMxIEphbiAyMDE5LCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToNCj4+IEhlbGxvLA0K
Pj4NCj4+IEkgYW0gd29ya2luZyBvbiBwb3J0aW5nIGFuIG91dC1vZi10cmVlIGtlcm5lbCBkcml2
ZXIgdG8gdGhlIGtlcm5lbA0KPj4gNS4wIGFuZCB0aGF0IGRyaXZlciB1c2VzIGZ1bmN0aW9uYWxp
dHkgcHJvdmlkZWQgYnkNCj4+IGRyaXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5jDQo+PiBtb2R1
bGUuwqAgU2luY2UgY29tbWl0IFsxXSBpdCBpcyBub3QgcG9zc2libGUgdG8gYnVpbGQgYSBrZXJu
ZWwgbW9kdWxlDQo+PiB3aGljaCB1c2VzIG1lbS1yZXNlcnZhdGlvbiBBUEkgYXMgeGVuX3NjcnVi
X3BhZ2VzIHZhcmlhYmxlLCB3aGljaCBpcw0KPj4gY2hlY2tlZCBpbg0KPj4geGVubWVtX3Jlc2Vy
dmF0aW9uX3NjcnViX3BhZ2UsIGJlY2FtZSBhIGtlcm5lbCBtb2R1bGUgcGFyYW1ldGVyIGFuZCBp
cw0KPj4gbm93IG9ubHkNCj4+IGFjY2Vzc2libGUgZm9yIGJ1aWx0LWluIG1vZHVsZXM6DQo+Pg0K
Pj4gc3RhdGljIGlubGluZSB2b2lkIHhlbm1lbV9yZXNlcnZhdGlvbl9zY3J1Yl9wYWdlKHN0cnVj
dCBwYWdlICpwYWdlKQ0KPj4gXl5eXl5eXl5eXl5eXg0KPj4gew0KPj4gICDCoMKgwqAgaWYgKHhl
bl9zY3J1Yl9wYWdlcykNCj4+ICAgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eXl5eXl5eDQo+PiAg
IMKgwqDCoCDCoMKgwqAgY2xlYXJfaGlnaHBhZ2UocGFnZSk7DQo+PiB9DQo+Pg0KPj4gVGhpcyBy
ZXN1bHRzIGluIGxpbmstdGltZSB3YXJuaW5nOg0KPj4NCj4+ICAgwqDCoMKgIFdBUk5JTkc6ICJ4
ZW5fc2NydWJfcGFnZXMiIFt5b3VybW9kdWxlLmtvXSB1bmRlZmluZWQhDQo+Pg0KPj4gYW5kIHRo
dXMgbm90IGFsbG93aW5nIHRoZSBtb2R1bGUgdG8gcnVuLiBBdCB0aGUgbW9tZW50IEkgY2FuIG9u
bHkgc2VlIGENCj4+IHBvc3NpYmxlIGZpeA0KPj4gZm9yIHRoaXMgYnkgbWFraW5nIHRoZSBmb2xs
b3dpbmcgY2hhbmdlOg0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9tZW0tcmVzZXJ2
YXRpb24uYyBiL2RyaXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5jDQo+PiBpbmRleCAzNzgyY2Yw
NzAzMzguLjg1ZmVjZmVjNTBlMSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL21lbS1yZXNl
cnZhdGlvbi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi9tZW0tcmVzZXJ2YXRpb24uYw0KPj4gQEAg
LTE4LDYgKzE4LDcgQEANCj4+DQo+PiAgIMKgYm9vbCBfX3JlYWRfbW9zdGx5IHhlbl9zY3J1Yl9w
YWdlcyA9DQo+PiBJU19FTkFCTEVEKENPTkZJR19YRU5fU0NSVUJfUEFHRVNfREVGQVVMVCk7DQo+
PiAgIMKgY29yZV9wYXJhbSh4ZW5fc2NydWJfcGFnZXMsIHhlbl9zY3J1Yl9wYWdlcywgYm9vbCwg
MCk7DQo+PiArRVhQT1JUX1NZTUJPTCh4ZW5fc2NydWJfcGFnZXMpOw0KPj4NCj4+IGJ1dCB0aGlz
IGxvb2tzIGEgYml0IHVudXN1YWwgZm9yIHRoZSBrZXJuZWw/DQo+Pg0KPj4gSSBhbSBsb29raW5n
IGZvciBjb21tdW5pdHkgYWR2aWNlIGhlcmUgYW5kIGhlbHANCj4+DQo+PiBUaGFuayB5b3UsDQo+
PiBPbGVrc2FuZHINCj4+DQo+PiBbMV0NCj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTE5N2VjYjM4
MDJjMDQ0OTlkOGZmNGY4Y2IyOGY2ZWZhMDA4MDY3ZGINCj4gVGhlIGFsdGVybmF0aXZlIHdvdWxk
IGJlIHRvIHR1cm4geGVubWVtX3Jlc2VydmF0aW9uX3NjcnViX3BhZ2UgaW50byBhDQo+IHJlZ3Vs
YXIgZnVuY3Rpb24gKG5vdCBhIHN0YXRpYyBpbmxpbmUpPw0KWWVzLCBpdCBzZWVtcyB0aGVyZSBp
cyBubyBvdGhlciByZWFzb25hYmxlIHNvbHV0aW9uIHRvIHRoaXMsIGJ1dA0KYSByZWd1bGFyIGZ1
bmN0aW9uLiBJJ2xsIHNlbmQgYSBwYXRjaCBmb3IgdGhhdA0KDQpUaGFuayB5b3UsDQpPbGVrc2Fu
ZHI=
