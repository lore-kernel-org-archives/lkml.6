Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C69C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9220321855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LLIkxxTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfAXODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:03:44 -0500
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:25366
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728307AbfAXODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ozLnO2R9sfXiwWsXlIZAQOLG0Oy/7E+3ka+32cu6+A=;
 b=LLIkxxTb+/I3x4GYy2ShxUKplncM/vBQ/lky5K/aNloiNACYAi7HuEB7ew4yMIsdCSKY3M0o8j0DWj55VtzB0WYrW+d8QJje6PO2Cw6S1Xl2HA0xIyXhiKhug8ZFTi3AgUfdaa9hYPOL8SNVvBpsd4lJRMw3i+FAlk8fFowBIOQ=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2480.eurprd05.prod.outlook.com (10.168.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 24 Jan 2019 14:03:38 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::edef:e9d3:e4e3:e7c3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::edef:e9d3:e4e3:e7c3%2]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 14:03:38 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "zhang.run@zte.com.cn" <zhang.run@zte.com.cn>
CC:     "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>,
        "lynxis@fe80.eu" <lynxis@fe80.eu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] net: usb: asix: ax88772_bind return error when hw_reset
 fail
Thread-Topic: [PATCH] net: usb: asix: ax88772_bind return error when hw_reset
 fail
Thread-Index: AQHUs6iNVEi1ybrApE++/wmfQx3PMKW+c+KA
Date:   Thu, 24 Jan 2019 14:03:38 +0000
Message-ID: <2233b8499110f3b2afcaf44f7f6ee820f7e0b36e.camel@toradex.com>
References: <1548308929-7727-1-git-send-email-zhang.run@zte.com.cn>
In-Reply-To: <1548308929-7727-1-git-send-email-zhang.run@zte.com.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2480;6:ZM4yeoZ+0AeS9jNXGHzqwVXMyC3whpmuN1b1KGmM41XLhv3PvJFPVZ+Vj5kRh0qz5D39Uumw21+X7vEmb5hpUuGoRDafRY5m3gzN+iRCk3LINJgpG2Dt/LdpaxhiLO//YiFVrJ01f/riBc7nLuYCDme8juiKQELdgbcmG1Cim+M6lYclrhTT7Y3esNvSsTzY5RBluS2j7XmRplJ25TaMheeDSeOA8U8ELCd8AxeIURc9OJ2QmxhM+vsAYup/RaojS1j9GTKioC7kNCjw9VW2IhgMRSWXswrSMd1pPuULcn53tcAMfh8SDD0lbJzt6Q9aMwYfLONJhlpwTTzauyebuNuw29Ebv/ZBZ10ncwA7ONtcUf+ty8+NiVUXsY3n8upm/hkZ3PyOA3w2CtjxMRF+k3zhv1Mx3intdFrKQWkBfoV1Lc+0phXXIWLs/uTCL7SUCETxEQLvXpL8e6lsiq+5SQ==;5:BdNVyRp3I0rq5K+Leu3aGI9h6A2/nv51W2QS5tNPaO4wnh3tTN8ub3ot13K+cHdbmQL9GRKX2t7PGg5oOAWQROo4X75uud6HfTRKknAclNdBXS8aExhw0R6olg5xehCCceg/jhn+S5mkNNNw9bMMhfHX8lUNdK+XUtOq8aDdVnmiphQctr8/XEe71mEAcTdKlCWbFbTq108nVooeUjcxkA==;7:E4m7lUFdL7NQcHwq1TVEMoxlSBiOXBS0s1i+VjFyoRkuKYgNWhSjFaEEZhg8gCijPycJeT88E8G8T4Tlp6MCahflsx60K6VUMwSmrdr7aAcCfOWgsE7zp+Wz1CQJCmftLgEn6jFv3QLvT9PcItErEA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d219ebbf-b09f-4dcc-e913-08d68204bcfe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2480;
x-ms-traffictypediagnostic: VI1PR0501MB2480:
x-microsoft-antispam-prvs: <VI1PR0501MB2480B419BDBDF1A8231E4DFCFB9A0@VI1PR0501MB2480.eurprd05.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39850400004)(366004)(396003)(376002)(189003)(199004)(229853002)(6512007)(2616005)(71190400001)(476003)(76176011)(2501003)(86362001)(316002)(110136005)(81166006)(53936002)(446003)(81156014)(106356001)(11346002)(8676002)(44832011)(6116002)(3846002)(66066001)(8936002)(486006)(25786009)(36756003)(68736007)(105586002)(71200400001)(6506007)(99286004)(6486002)(2906002)(4326008)(102836004)(97736004)(14444005)(186003)(14454004)(256004)(478600001)(118296001)(54906003)(6246003)(6436002)(305945005)(26005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2480;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7VJZlOL33t1seEbGbVitF2k6+WCw5BIIfdPUxBiw0Fz772XaQFCdvSi07udMzcSvd7mCKxGJ8AcqFmhYsyFuwIB5mN0Pa/Vp7j7tE2KKUSzFCKDnRoc6PxeliwznrEr9HC0OwGziLfSagCNEBfhgLL1iCIfnUA7spsB/3owu4on+mEtOCROK2Dkfwj6NIu45Src8E2JPlhCoSFbKxRE+pUOw1oGIzyi/MJlwY1xOeh4efUf8PqL2uzJCEEF+ZIYUey6LKcb5CmXpDvfHNniFXrXVMzltyrt/G0QpzE2t+ZurbLWdNcu/PcHWJej3VefQ7hV4fqyxKiud1ejaoL09uu7wk/XNXxAI0Q3vPAWo0basAxTzu0/uaNJp5G+JDzSv11T55XWv52I9n0JqJrgGPvqx2hNdBjYB1fLIksXyWRo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B49EDCCA2BAF3F4DAB245A057CB24AD8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d219ebbf-b09f-4dcc-e913-08d68204bcfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 14:03:38.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAxLTI0IGF0IDEzOjQ4ICswODAwLCBaaGFuZyBSdW4gd3JvdGU6DQo+IFRo
ZSBheDg4NzcyX2JpbmQoKSBzaG91bGQgcmV0dXJuIGVycm9yIGNvZGUgaW1tZWRpYXRlbHkgd2hl
biB0aGUgUEhZDQo+IHdhcyBub3QgcmVzZXQgcHJvcGVybHkgdGhyb3VnaCBheDg4NzcyYV9od19y
ZXNldCgpLg0KPiBPdGhlcndpc2UsIFRoZSBhc2l4X2dldF9waHlpZCgpIHdpbGwgYmxvY2sgd2hl
biBnZXQgdGhlIFBIWSANCj4gSWRlbnRpZmllciBmcm9tIHRoZSBQSFlTSUQxIE1JSSByZWdpc3Rl
cnMgdGhyb3VnaCBhc2l4X21kaW9fcmVhZCgpIA0KPiBkdWUgdG8gdGhlIFBIWSBpc24ndCByZWFk
eS4gRnVydGhlcm1vcmUsIGl0IHdpbGwgcHJvZHVjZSBhIGxvdCBvZiANCj4gZXJyb3IgbWVzc2Fn
ZSBjYXVzZSBzeXN0ZW0gY3Jhc2guQXMgZm9sbG93czoNCj4gYXNpeCAxLTE6MS4wICh1bm5hbWVk
IG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogRmFpbGVkIHRvIHdyaXRlDQo+ICByZWcgaW5k
ZXggMHgwMDAwOiAtNzENCj4gYXNpeCAxLTE6MS4wICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmlu
aXRpYWxpemVkKTogRmFpbGVkIHRvIHNlbmQNCj4gIHNvZnR3YXJlIHJlc2V0OiBmZmZmZmZiOQ0K
PiBhc2l4IDEtMToxLjAgKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBGYWls
ZWQgdG8gd3JpdGUNCj4gIHJlZyBpbmRleCAweDAwMDA6IC03MQ0KPiBhc2l4IDEtMToxLjAgKHVu
bmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBGYWlsZWQgdG8gZW5hYmxlDQo+ICBz
b2Z0d2FyZSBNSUkgYWNjZXNzDQo+IGFzaXggMS0xOjEuMCAodW5uYW1lZCBuZXRfZGV2aWNlKSAo
dW5pbml0aWFsaXplZCk6IEZhaWxlZCB0byByZWFkDQo+ICByZWcgaW5kZXggMHgwMDAwOiAtNzEN
Cj4gYXNpeCAxLTE6MS4wICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogRmFp
bGVkIHRvIHdyaXRlDQo+ICByZWcgaW5kZXggMHgwMDAwOiAtNzENCj4gYXNpeCAxLTE6MS4wICh1
bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogRmFpbGVkIHRvIGVuYWJsZQ0KPiAg
c29mdHdhcmUgTUlJIGFjY2Vzcw0KPiBhc2l4IDEtMToxLjAgKHVubmFtZWQgbmV0X2RldmljZSkg
KHVuaW5pdGlhbGl6ZWQpOiBGYWlsZWQgdG8gcmVhZA0KPiAgcmVnIGluZGV4IDB4MDAwMDogLTcx
DQo+IC4uLiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFJ1biA8emhhbmcucnVuQHp0ZS5j
b20uY24+DQo+IFJldmlld2VkLWJ5OiBZYW5nIFdlaSA8eWFuZy53ZWk5QHp0ZS5jb20uY24+DQoN
ClRlc3RlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMgfCA5ICsrKysrKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMNCj4gYi9kcml2
ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMNCj4gaW5kZXggYjY1NGYwNS4uM2Q5Mzk5MyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvdXNiL2FzaXhfZGV2aWNlcy5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3VzYi9hc2l4X2RldmljZXMuYw0KPiBAQCAtNzM5LDggKzczOSwxMyBAQCBzdGF0aWMg
aW50IGF4ODg3NzJfYmluZChzdHJ1Y3QgdXNibmV0ICpkZXYsDQo+IHN0cnVjdCB1c2JfaW50ZXJm
YWNlICppbnRmKQ0KPiAgCWFzaXhfcmVhZF9jbWQoZGV2LCBBWF9DTURfU1RBVE1OR1NUU19SRUcs
IDAsIDAsIDEsICZjaGlwY29kZSwNCj4gMCk7DQo+ICAJY2hpcGNvZGUgJj0gQVhfQ0hJUENPREVf
TUFTSzsNCj4gIA0KPiAtCShjaGlwY29kZSA9PSBBWF9BWDg4NzcyX0NISVBDT0RFKSA/IGF4ODg3
NzJfaHdfcmVzZXQoZGV2LCAwKSA6DQo+IC0JCQkJCSAgICBheDg4NzcyYV9od19yZXNldChkZXYs
IDApOw0KPiArCXJldCA9IChjaGlwY29kZSA9PSBBWF9BWDg4NzcyX0NISVBDT0RFKSA/IGF4ODg3
NzJfaHdfcmVzZXQoZGV2LA0KPiAwKSA6DQo+ICsJCQkJCQkgIGF4ODg3NzJhX2h3X3Jlc2V0KGRl
dg0KPiAsIDApOw0KPiArDQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJbmV0ZGV2X2RiZyhkZXYt
Pm5ldCwgIkZhaWxlZCB0byByZXNldCBBWDg4NzcyOiAlZFxuIiwNCj4gcmV0KTsNCj4gKwkJcmV0
dXJuIHJldDsNCj4gKwl9DQo+ICANCj4gIAkvKiBSZWFkIFBIWUlEIHJlZ2lzdGVyICpBRlRFUiog
dGhlIFBIWSB3YXMgcmVzZXQgcHJvcGVybHkgKi8NCj4gIAlwaHlpZCA9IGFzaXhfZ2V0X3BoeWlk
KGRldik7DQo=
