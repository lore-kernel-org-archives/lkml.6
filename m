Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118A3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fRY42E8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118A3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeIQHUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 03:20:42 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:23744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeIQHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 03:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VL+b68sGhyuetPZcR7foSUjhWACjlBJmBBaP+UKygw=;
 b=fRY42E8j0sBw6nBOHY4jYDVaDGr5KA3nFy6+e7RrIGu5CvAyRVu0cvvd6/Q+Eezl0UA4SqbjEq4AWjfouZDtzPhAWsayx9UmLw0dMnhAeV5TCzzH7wHUwInBdeC+wGTQ+rWaQuXJ+HNYrvS5t58ijauzYI+oc299GOF9b04oYEE=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2814.eurprd04.prod.outlook.com (10.172.255.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 01:55:35 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849%6]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 01:55:35 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     zhong jiang <zhongjiang@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: remove redundant null pointer check before
 of_node_put
Thread-Topic: [PATCH] net: ethernet: remove redundant null pointer check
 before of_node_put
Thread-Index: AQHUTcDTnGaz8e8rPUKLGm6KS5jxX6Tztp+g
Date:   Mon, 17 Sep 2018 01:55:35 +0000
Message-ID: <VI1PR0402MB3600930E36B28B7328937013FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1537103622-63482-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537103622-63482-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2814;6:/jIleh2LZdwQGcxinQFwpLhDfOwx+gBg0ULArY5LFEfRnwG0+LjBfx64QjUKh5cn/c4abg4gM/OmA3HG+iKEFK20MIsrBTNoQLeRyTGHArkFpW0lK3p9TbJCr1daj2j4p9ezxU2R7wXFv7aK7v2YBUlnEOavH0xcdB+fiDqmhDzyd+9kE8N+1bC2OHQFPvzRTt+3Asc9v5WMgPxjNdZIBjGsico8lZ3Pro7rMv7qPPt+kJhg0motavw1AF8Eu7Cyo6O1xqMerI1TBDLrWV2OkmF6j4WmdTj0OSLmOuEiyOijbi/lBtQdN4WGyvSd9OkD7AaXOXAwTWKyFSo4CzS2TuZ2YmF+zgSXeC/Xmhr6ShbhWY9QxGGQiesoJG+o/LdM7YkB+wIh01gyD1NGC870vCqxebLHfauV8V6yHC4H2Ohx4nGi6G+20Nq+95Yd++sR73TzBeQUaV6MsY8oa1RSrQ==;5:cfVXmGLN1iisesGOzBxpqAz1am+xgBv3zpU38eoqzvXfGD/JAxLnjT/onVGC4UU7enHLYch+LLHWWuucMhHl4i+YbUO3RT9D9+lMl9yuNtV0F4l8W3ZwI/WlhjGfOSpo0sqjK9yE83AJEitI5vkHhG5s1zzklteNrLtF/YLwGHc=;7:65RLL2LN/oB7jMO1UZDaBtLwqGuFhH48jTZrNKzIJ0Gbfi08k3j2q1hf31gPyfmnyeqWGoMYYyN383WaAQdcvgYtnD4nXBaXGrlKyDV3jqS5iFs8hyk1HFNUq1tZOyXGUFYZwhKNirbAPJgxz1d1DfUPP/38Tc2z6kF00N5/sfpM5p/LUeF4qV7KWgVKuFbIlH4TsxZiypfwL+gz2DldDD+krWm72tI+uS612qVfRuN27/HRk0wQiKOSfhnRk0Mv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e13a4e74-febd-4d09-b1ff-08d61c40a8b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2814;
x-ms-traffictypediagnostic: VI1PR0402MB2814:
x-microsoft-antispam-prvs: <VI1PR0402MB2814623C6709E3ED9B5032E9FF1E0@VI1PR0402MB2814.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR0402MB2814;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2814;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(5660300001)(81166006)(81156014)(486006)(8676002)(7736002)(305945005)(74316002)(2900100001)(68736007)(106356001)(105586002)(66066001)(8936002)(54906003)(7696005)(99286004)(33656002)(316002)(110136005)(229853002)(2906002)(76176011)(14454004)(97736004)(3846002)(6506007)(102836004)(53936002)(86362001)(26005)(6246003)(186003)(6116002)(55016002)(9686003)(6436002)(4326008)(14444005)(5250100002)(2501003)(256004)(476003)(25786009)(478600001)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2814;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /lINN3IwakqqKje4riKSTXeoD4Kv80G1qAKLvxpgAYTNvsWY4fsqe1EBUkClTIDVJmDlZ/iN62DOdlY9uEtsPJ/Xz+nXFRjH8tlmZDQTfa0NxKEnCgU05eKM/Qf3ez3l/LI/sNTcUo0D3b392cpJYO/xLcgyu36N2sIGvhtf5i23/rt2hhun0NICpfW4FfYpZUQq3MNB5n8Wh+qUvxBfHf8DoC331CBDD90j+MfKtRTpo64t28HNxuDSdrZXlh3jUp2aJENN7IFuIUmhPfY1dcxS4JR6Tw3MWEPpfhHHA4Flo+9Nj+hNuDGRoHZDrQwKoXhG4ILpwJsNx+n5eE4HZlT9FEkE4z0TBLgI0EVS21o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13a4e74-febd-4d09-b1ff-08d61c40a8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 01:55:35.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogemhvbmcgamlhbmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4gU2VudDogMjAxOMTqOdTC
MTbI1SAyMToxNA0KPiBvZl9ub2RlX3B1dCBoYXMgdGFrZW4gdGhlIG51bGwgcGludGVyIGNoZWNr
IGludG8gYWNjb3VudC4gU28gaXQgaXMgc2FmZSB0bw0KPiByZW1vdmUgdGhlIGR1cGxpY2F0ZWQg
Y2hlY2sgYmVmb3JlIG9mX25vZGVfcHV0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogemhvbmcgamlh
bmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdh
bmcuZHVhbkBueHAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gaW5kZXggMjcwODI5Ny4uNjdkNmM5ZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTIwNTUsOCArMjA1NSw3IEBA
IHN0YXRpYyBpbnQgZmVjX2VuZXRfbWlpX2luaXQoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gDQo+ICAJbm9kZSA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKHBkZXYtPmRldi5vZl9u
b2RlLCAibWRpbyIpOw0KPiAgCWVyciA9IG9mX21kaW9idXNfcmVnaXN0ZXIoZmVwLT5taWlfYnVz
LCBub2RlKTsNCj4gLQlpZiAobm9kZSkNCj4gLQkJb2Zfbm9kZV9wdXQobm9kZSk7DQo+ICsJb2Zf
bm9kZV9wdXQobm9kZSk7DQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBlcnJfb3V0X2ZyZWVfbWRp
b2J1czsNCj4gDQo+IC0tDQo+IDEuNy4xMi40DQoNCg==
