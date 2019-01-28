Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6857BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E192173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="SC7ZF59m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfA1Ogz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:36:55 -0500
Received: from mail-eopbgr150100.outbound.protection.outlook.com ([40.107.15.100]:57824
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1Ogw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJVpUuptmZGqG/S6GtVjuIEAvSEjzU8LT+9n7VZr01w=;
 b=SC7ZF59maMSGTagyh71kFJSHy3KIFOEwlXYMkHwy0jLti9tYmL1EOc/P7swv9QJVVuG/3M8iBybKvUXXIESJFHJEqiYOc4Bq1Mmz4DrKgwEWY2M3WvMxir/shwiftkS1Rq76q3t6czv6ZSd/oXioQMbkLwVVsgEmOX54XIIF3LE=
Received: from VI1PR0702MB3710.eurprd07.prod.outlook.com (52.134.3.144) by
 VI1PR0702MB3629.eurprd07.prod.outlook.com (52.134.1.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.5; Mon, 28 Jan 2019 14:36:50 +0000
Received: from VI1PR0702MB3710.eurprd07.prod.outlook.com
 ([fe80::95ff:2ede:57df:f1ba]) by VI1PR0702MB3710.eurprd07.prod.outlook.com
 ([fe80::95ff:2ede:57df:f1ba%2]) with mapi id 15.20.1580.014; Mon, 28 Jan 2019
 14:36:50 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     Paul Moore <pmoore@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
Thread-Topic: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
Thread-Index: AQHUtuRMqf59sA9YxEyiYKAWmGDXiKXEuzUAgAAEzAA=
Date:   Mon, 28 Jan 2019 14:36:49 +0000
Message-ID: <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com>
References: <20151208164237.15736.42955.stgit@localhost>
 <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
 <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-clientproxiedby: HE1PR09CA0078.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::22) To VI1PR0702MB3710.eurprd07.prod.outlook.com
 (2603:10a6:803:7::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0702MB3629;6:FDvqjMEU3uFLmQp1n8g02wHFVHs+DdctepAP6wTJZ1RA0jWMehQ9ZftWEfNnvcZI9VbjenzbMW04HeEO7wh4AY6WQjLtjr7tNqf418EjtUMdDWYxYHTTHPISZThUNBy72lIzs3fbCKDilnBHROBN5eks7d8Sl3/PnGCytryt11x06T+2NAlzJrFNEj7dT/nbddhUtCFuZv+Ym8mpCzB2WINFCqfj6LT3jLqvREP+Tj/veoYsB+hq/yL0FVvp5ZbNqQ9D0S5mNXuAhpUs3vqcHDkg3BV/zOZk64vjGMfLHzVAgUUs4Eq7OkNYrjNOoC5n5jCtGVQn8HKhgdUcvjps5YKhMvYb5OnkV8BRpNrdh5k63rzpIoxDGHH9fd0BsW0YWtqJSPCQrnjCekxXxCVZMYuWs6m3H7M75iveSybMNXBd92ibo+XpY27jtc4B/1+gGHhRGjz86c1ZhGgXQMQL5g==;5:FWVsXjtGqMReN57I7VIcC9ZnBZ+SYUTyW9Abd96gA36tipLkbFG5uYSNiMutiMq1NNjmxltXhY5c3+thkmvIOBmSRav5OvBXN4QM1/VBhnXBpnDhHkUrWduJP7/ZtqpNf3PGNnJkiuax4YKg83yrw5462YDTk/y9qCHhZeFDhlooRNcXajnRkVV6Bzr3/RMP6Pl0C/aCHalM87TnLqw3xA==;7:Y9Qb66OGP/F1UD6yUNQ2w5Dnr9hXYZKkCj1lkdUas7BrPaqEAwf34GxHioht1+/XKvMKS3eP24Vbpa8pFwsW9ZsXfMuZk26lOt5EOzjmmQSYDWfwQ0fT0eS3wWzp//Us90T4a0HS/D9WCugKQoPf3Q==
x-ms-office365-filtering-correlation-id: 3dcbb810-d3b7-457f-07d2-08d6852e099f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:VI1PR0702MB3629;
x-ms-traffictypediagnostic: VI1PR0702MB3629:
x-microsoft-antispam-prvs: <VI1PR0702MB3629D86AC8EDE4634F75890D88960@VI1PR0702MB3629.eurprd07.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(2906002)(6246003)(478600001)(4326008)(58126008)(68736007)(52116002)(54906003)(105586002)(316002)(106356001)(65956001)(66066001)(53936002)(486006)(31686004)(65806001)(6506007)(386003)(53546011)(102836004)(76176011)(6512007)(186003)(26005)(305945005)(7736002)(3846002)(6116002)(446003)(71190400001)(71200400001)(86362001)(25786009)(8676002)(11346002)(99286004)(229853002)(14454004)(31696002)(6486002)(36756003)(81156014)(6436002)(81166006)(6916009)(8936002)(14444005)(256004)(97736004)(64126003)(65826007)(476003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0702MB3629;H:VI1PR0702MB3710.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KedWexE69fpCHkf5rAYHY3zozSNnCitmUrUv85kEal1d9ZMqbOMyImdV9/SblOe5N6goiiJzBG0KIll8EmOtzzF3GJ+YhOcBzbcTt84+qfS+AjmplsnSNSmhdFbDa0NWxepwM0V7th0FQErghyF49Z+xdZ4/JHDhdB/MQjNvjASwOrAgvL2IYp4z7yBzgBpRhFVe4BOvzZ35rBq0TMWtj64tFSonFB/htiVmYeKO/VrESEDXGbBjPGWGFmeqPCOJ/C1HVYa/DiAoR+DyJBHNhuUICqaapTTUndKUVme+T751O4dysw1wJmmD+hE+ijZVZOVQmUsbb5VjsYu10r5ZYCKlsy7gLIAJl7KKgaYbWuYqt7WeHE2CXDoKPpdQL38mOZH6QCD4Q3OBOaUSnFTQjlBmb/tuiTNQ+IdA0KGxhTQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3E955090B485642AD790503C3C35D2F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcbb810-d3b7-457f-07d2-08d6852e099f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 14:36:48.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0702MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGF1bCwNCg0KT24gMjgvMDEvMjAxOSAxNToxOSwgUGF1bCBNb29yZSB3cm90ZToNCj4+
PiB0aW1lIGFsc28gZW5hYmxlcyBzeXNjYWxsIGF1ZGl0aW5nOyB0aGlzIHBhdGNoIHNpbXBsaWZp
ZXMgdGhlIEtjb25maWcNCj4+PiBtZW51cyBieSByZW1vdmluZyB0aGUgb3B0aW9uIHRvIGRpc2Fi
bGUgc3lzY2FsbCBhdWRpdGluZyB3aGVuIGF1ZGl0DQo+Pj4gaXMgc2VsZWN0ZWQgYW5kIHRoZSB0
YXJnZXQgYXJjaCBzdXBwb3J0cyBpdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBhdWwgTW9v
cmUgPHBtb29yZUByZWRoYXQuY29tPg0KPj4gdGhpcyBwYXRjaCBpcyByZXNwb25zaWJsZSBmb3Ig
bWFzc2l2ZSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiBmb3IgdGhvc2UNCj4+IHdobyB1c2VkIG9u
bHkgQ09ORklHX1NFQ1VSSVRZX0FQUEFSTU9SLg0KPj4NCj4+IEFuZCB0aGUgbnVtYmVycyBhcmUs
IHRha2UgdGhlIGZvbGxvd2luZyB0ZXN0IGZvciBpbnN0YW5jZToNCj4+DQo+PiBkZCBpZj0vZGV2
L3plcm8gb2Y9L2Rldi9udWxsIGNvdW50PTJNDQo+Pg0KPj4gQVJNNjQ6ICAgICAgNTAwTUIvcyAt
PiAzNTBNQi9zDQo+PiBBUk06ICAgICAgICA0MDBNQi9zIC0+IDMwME1CL3MNCj4gSGkgdGhlcmUu
DQo+IA0KPiBPdXQgb2YgY3VyaW9zaXR5LCB3aGF0IGtlcm5lbC9kaXN0cmlidXRpb24gYXJlIHlv
dSBydW5uaW5nLCBvciBpcyB0aGlzDQo+IGEgY3VzdG9tIGtlcm5lbCBjb21waWxlPyAgQ2FuIHlv
dSBhbHNvIHNoYXJlIHRoZSBvdXRwdXQgb2YgJ2F1ZGl0Y3RsDQoNClRoaXMgdGVzdCB3YXMgY2Fy
cmllZCBvdXQgd2l0aCBMaW51eCA0LjkuIEN1c3RvbSBidWlsdC4NCg0KPiAtbCcgZnJvbSB5b3Vy
IHN5c3RlbT8gIFRoZSBnZW5lcmFsIGFwcHJvYWNoIHRha2VuIGJ5IGV2ZXJ5b25lIHRvDQo+IHR1
cm4tb2ZmIHRoZSBwZXItc3lzY2FsbCBhdWRpdCBvdmVyaGVhZCBpcyB0byBhZGQgdGhlICItYSBu
ZXZlcix0YXNrIg0KPiBydWxlIHRvIHRoZWlyIGF1ZGl0IGNvbmZpZ3VyYXRpb246DQo+IA0KPiAg
IyBhdWRpdGN0bCAtYSBuZXZlcix0YXNrDQo+IA0KPiBJZiB5b3UgYXJlIHVzaW5nIEZlZG9yYS9D
ZW50T1MvUkhFTCwgb3IgYSBzaW1pbGFybHkgY29uZmlndXJlZCBzeXN0ZW0sDQoNClRoaXMgaXMg
YW4gZW1iZWRkZWQgZGlzdHJpYnV0aW9uLiBXZSBhcmUgbm90IHVzaW5nIGF1ZGl0Y3RsIG9yIGFu
eSBvdGhlcg0KYXVkaXQtcmVsYXRlZCB1c2VyLXNwYWNlIHBhY2thZ2VzLg0KDQo+IHlvdSBjYW4g
ZmluZCB0aGlzIGNvbmZpZ3VyYXRpb24gaW4gdGhlIC9ldGMvYXVkaXQvYXVkaXQucnVsZXMgZmls
ZSAoYmUNCj4gd2FybmVkLCB0aGF0IGZpbGUgaXMgYXV0b21hdGljYWxseSBnZW5lcmF0ZWQgYmFz
ZWQgb24NCj4gL2V0Yy9hdWRpdC9ydWxlcy5kKS4NCg0KSSBzdXBwb3NlIGluIHRoaXMgY2FzZSBy
dWxlIGxpc3QgbXVzdCBiZSBlbXB0eS4gSXMgdGhlcmUgYSB3YXkgdG8gY2hlY2sNCnRoaXMgd2l0
aG91dCBleHRyYSB1c2VyLXNwYWNlIHBhY2thZ2VzPw0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFs
ZXhhbmRlciBTdmVyZGxpbi4NCg==
