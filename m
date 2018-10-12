Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB6C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6835F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="C8zzMXaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6835F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeJLRGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:06:37 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com ([40.107.6.110]:36551
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbeJLRGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAMf4Y4X3XxB4mV5rqPMVBIwtQsbLVeqipMBL/gmZ/8=;
 b=C8zzMXaSDmns57P3gJMjb00Wb+w9PmFaBZlkK4xmI4u/gUyqFet2HmG7p9+7Qzz4/TybjVgBhsoAJk8e5hgg56FMIZwHabS159sJRq30dOxyTiqP1aflwyAv+V01L5D1K9x9mZMEtY/Dc+zmBjWO8z6JxEMVPSj/jd5/2PUw14U=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1968.eurprd05.prod.outlook.com (10.166.45.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 09:34:58 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 09:34:58 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "ricardo.ribalda@gmail.com" <ricardo.ribalda@gmail.com>
Subject: Re: REGRESSION: [PATCH v5 3/3] gpiolib: Show correct direction from
 the beginning
Thread-Topic: REGRESSION: [PATCH v5 3/3] gpiolib: Show correct direction from
 the beginning
Thread-Index: AQHUYgoNoMD92TQrMUShrDSw1Tr4Y6UbUk0AgAAHSgA=
Date:   Fri, 12 Oct 2018 09:34:58 +0000
Message-ID: <1539336896.30485.15.camel@toradex.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
         <20181005065300.22882-3-ricardo.ribalda@gmail.com>
         <1539334839.30485.9.camel@toradex.com>
         <CACRpkdY89b-hy_aoBiZXX6KqyJrZd0fX9-XCGcF9XjPBy6Lwrw@mail.gmail.com>
In-Reply-To: <CACRpkdY89b-hy_aoBiZXX6KqyJrZd0fX9-XCGcF9XjPBy6Lwrw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1968;6:KPmLCQw1crnpGVaML0F9kCI+/mV+HeQk+il/Va8mGh/i9+DXS25qGoRRa/yv+r+QZEyJ5xAmEfXfzsqU+aGpMNSYyhy3vdoQtnuSBHSK3pCIrNh091Qh6CwaiwRyn0eIoSzlJavCd0+rBPs6GvR9HM0RrkTGixuPZzkez4tXo/UdaqDq6JEJO8YNK8+1mUbiV3TH/yInXCB8NE4jtnG/myZ7x/rfsC4Sr+uQxYX3r3Crd08dMflOgeq06C7jI/50sXEnkVK9XngmZ4/C+L0uhTNuHpYIPtKJvKULhWDVPXz21fB1B4HptK3TrqCBoXtYwOA8JdAyHY7yCfLYL16ESWqEXe91uVx9yoNH1UDi6V/BMq1zbMGefq3bFIvEjlEIVD1j0ZYEtILwqHA7eOHzE4vWgoQHbrwRpclI7F6kYe7GJ4btkB4o3YGUGpmtuqbFLAg0+UBk7HYAIrjgpKWYxQ==;5:Pj2KSQPgwncQrI9Oz+sX3EVgqv4WeD8wmVzDWhxSfV+fWS1YawOF/oDG0hcrWcmvgPSj421cSnLNJyBzcXX1JE0kLeUCiFd7Xi9QNpg8QrgTqdmEq2XmcXIf3ng82pa/sW03BLDZxRoxm+8PZBia830tuSE2w3kD4CwzHPlZsww=;7:OB0eqHo6F3TdM4ctfnG54kqZAE4GyC385SQJU5Rq9yJipc28nzBF1VOjtylxhoTYX8H5ZmAJkJqIxU5MzNkQl24FEz+KdLt0AixjT2zNXI+AGgkAiCaEOl2WuCsQfsah9KUQYK1PiT21CZIydJgf/n7RXGpAZSkEPsYnrzgrRP6j8S3ICkkwnVZrzY2BJ61BWc1XypJw7KknPQGEITUE1XjB6kUJ7c0yQQ3+l7ZU7curfWwmq3bbuYe1IBqem6SY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: beb81670-7d5c-4a0c-0598-08d63025fa37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1968;
x-ms-traffictypediagnostic: VI1PR0501MB1968:
x-microsoft-antispam-prvs: <VI1PR0501MB1968E6E12DD338FF8A15C682FBE20@VI1PR0501MB1968.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR0501MB1968;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1968;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(366004)(396003)(346002)(136003)(199004)(189003)(2501003)(5250100002)(93886005)(316002)(229853002)(966005)(14454004)(6916009)(44832011)(486006)(105586002)(11346002)(446003)(476003)(106356001)(2616005)(2906002)(6246003)(71190400001)(71200400001)(53936002)(5640700003)(26005)(6306002)(186003)(6436002)(6486002)(4001150100001)(3846002)(2900100001)(103116003)(2351001)(6116002)(102836004)(6512007)(97736004)(7736002)(305945005)(8936002)(54906003)(36756003)(6506007)(53546011)(86362001)(4326008)(81156014)(81166006)(76176011)(8676002)(99286004)(68736007)(5660300001)(66066001)(478600001)(25786009)(39060400002)(256004)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1968;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nw6bV2X26n/L+cAhR2fzvpB/tq555VyVIpdOVVQN6CeKQccwWOK8TlOYX2AQ/gF170I2iyCubcERCO6WGRFFUM7LuMz0NiSwB/EcCQ8emw653kzgOqdQIjraDM/RbIOZ8jbwJpXt3ZQ3vwPAbtMUYWPKezVbcCXN+fxqyvbQei2MLvN/YDWSsmffvIn0rW7+HmVnO8kHda1cUIFJvnC72yssD4UTT/jnO6w/rJN2B0HgnIyLFcU6ZRqMhCVniwOFQdWJSNrdlj08zaV2ZOSS2Q0SS5L3kyGqtxSnQms2MNv2PAp/+Vr0xVI1nXOWbY2U2MTv9aksqFLrcMHke6kYtiNytpTwHj65ZtMONdwNfaQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC9C64F44777494CAE5386B9A46949F6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb81670-7d5c-4a0c-0598-08d63025fa37
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 09:34:58.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDExOjA4ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBGcmksIE9jdCAxMiwgMjAxOCBhdCAxMTowMCBBTSBNYXJjZWwgWmlzd2lsZXINCj4gPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTEwLTA1
IGF0IDA4OjUzICswMjAwLCBSaWNhcmRvIFJpYmFsZGEgRGVsZ2FkbyB3cm90ZToNCj4gPiA+IEN1
cnJlbnQgY29kZSBhc3N1bWVzIHRoYXQgdGhlIGRpcmVjdGlvbiBpcyBpbnB1dCBpZg0KPiA+ID4g
ZGlyZWN0aW9uX2lucHV0DQo+ID4gPiBmdW5jdGlvbiBpcyBzZXQuDQo+ID4gPiBUaGlzIG1pZ2h0
IG5vdCBiZSB0aGUgY2FzZSBvbiBHUElPcyB3aXRoIHByb2dyYW1tYWJsZSBkaXJlY3Rpb24uDQo+
ID4gDQo+ID4gVW5mb3J0dW5hdGVseSwgdGhpcyBicmVha3MgYXQgbGVhc3QgQXBhbGlzIFQzMCBh
bmQgQXBhbGlzIFRLMS4NCj4gPiBFbmFibGluZw0KPiA+IGVhcmx5Y29uIHJldmVhbHMgdGhlIGZv
bGxvd2luZzoNCj4gDQo+IERvZXMgdGhpcyAoanVzdCBhcHBsaWVkKSBwYXRjaCBmaXggdGhlIGlz
c3VlPw0KPiBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1rZXJuZWwmbT0xNTM5MzI0NzA0MTIw
MTMmdz0yDQoNClllcywgdGhhdCBjdXRzIGl0LiBUaGFua3MhDQoNCj4gWW91cnMsDQo+IExpbnVz
IFdhbGxlaWo=
