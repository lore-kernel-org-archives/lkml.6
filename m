Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7745C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C73620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="uNkwx8E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C73620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeLMV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:58:06 -0500
Received: from mail-eopbgr70127.outbound.protection.outlook.com ([40.107.7.127]:6327
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbeLMV6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1Nn8AYkJIYhRvTSZKpXoWxcEXaaMpOPqNPg5XNJb4E=;
 b=uNkwx8E64YTKpH4D6ShOVkbmEuEyFTZpa6JbO70u5vmWuGgTxn6irl0mBV5AB5JFB6hIL7GyqChdsA0Yn/0XxxVu0KxvuXX7qUwLXDfPwgqbTcIOeIeEqAoEr5/Q7BfYl78YZdI04q9ji5NzoBmjc8aIZY7QyZ+RBvHcWISaNJ0=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3150.eurprd02.prod.outlook.com (10.170.236.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 13 Dec 2018 21:57:59 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%4]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 21:57:59 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Thread-Index: AQHUkyHaYCRg4X56iE+p6PFn52AIlqV9N4sA
Date:   Thu, 13 Dec 2018 21:57:59 +0000
Message-ID: <c987f09c-689f-7e89-d496-f53b0ab6c2c1@axentia.se>
References: <1544732352-6178-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732352-6178-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::20)
 To VI1PR02MB5119.eurprd02.prod.outlook.com (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3150;6:2rVhpwUWMyQm0OS/aEo8ff0QABzDmzXI+INV7TPcfos1UBlm5MUUnA1coxoA4Qzwvqx2PK/hvYx8LNSg49z0tMjr5lXpbfifj64F4L/ud2NixPvvUUY/H8t+0D/Hpc3bcdgxEHZiZzA1kMp2iRDr6uNdEnQj8bcMU5cSte0p8AelqVPfbYTwT1dluNT+/FNPyEGdwW3bRxsm/VIX8QG/DWPyYfTq0lLKrJmGk9joQr36KiZpgpPXW4UAN9FzJ1HfGGikwZYOJMOK+7NYaRugv8Soiyxdd83RT3kULZQqXwkvPZglRzQWu8Mg+pvFI+3ESpCibUmtOKwd0pcwRoTFaWwQQNLdDbrnP2TSbTx0vU1vChndv2kQgElvURkLcpV4DCbMeCDxDZ3YRQfhrnBECIqobVZ0ZSLRYVGXupnLQlQegp1mc1uxSUPwAR+mKljRKj3Qe6tMai+ueIilo5ynLw==;5:qB5ElikGqUDWldjrLoKo/wULWEnftUi7xZbTZ4u9/L/E1gaXhXQyqkHFMxINKyJpemExPwietTA8b23vwVpLC1pTSTSe/+SgWu19jscvrEWfzH1qKQ5RLmOOSU9cDT8QS45hB6XSvgUjIn9zJ6cYzRq5oHLWqXk8a6dVhCMnVp0=;7:yIZnKNNZadZu+0AJfrDh9V3n+3Sh35/YwN/8GJX4/csfVPATNVfetWRp8jfLckoWJeG5hhY8g3wUSchIcbF595rfQCoTEIvhEBBldzhWNVEnI0QV+2hrochvU2VQtnaKr+hshCSEh38F1U92LXHauQ==
x-ms-office365-filtering-correlation-id: c6d650ac-4768-4664-d5a1-08d661460bb5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3150;
x-ms-traffictypediagnostic: VI1PR02MB3150:
x-microsoft-antispam-prvs: <VI1PR02MB31507A4B583A06180B378D38BCA00@VI1PR02MB3150.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB3150;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB3150;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(366004)(396003)(376002)(346002)(199004)(189003)(97736004)(52116002)(316002)(446003)(86362001)(11346002)(2906002)(486006)(71200400001)(3846002)(76176011)(71190400001)(476003)(229853002)(6436002)(74482002)(8676002)(31696002)(36756003)(6116002)(65806001)(4001150100001)(256004)(25786009)(14444005)(53936002)(65956001)(4326008)(66066001)(2616005)(68736007)(81156014)(81166006)(58126008)(31686004)(65826007)(5660300001)(105586002)(6246003)(102836004)(186003)(7416002)(53546011)(6506007)(386003)(6486002)(305945005)(26005)(110136005)(64126003)(508600001)(14454004)(99286004)(8936002)(54906003)(106356001)(7736002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3150;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LZ3zkOKgsaSiSH69+K+oi6wa0ZdGXXfx6qNQStPvKskLXVvwAx2ZmfV5DvkVoDXkjHrYi1xuxMF5TcIc2baKL20dfZ7ebKLLqV8EaeIm8iYreNlxMPBpCt2TCzPm7deh+FupPjpFYOxQmV0+QsgI6vwvNg+SC+p8n0vTvR872ee1I99aBjoP23l5QguvgjSzoR8VEbKewD9BA6xmT13xYXVc/b5BcybFiUxCLwbUmHepMBp3uEITijHifXDfo5g+fZ3AgQh6dBpcwXM5EKXGFKgpScXRlYde34PH2xYy089q3TPjIXr2pF/qzoPyPEn7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C00546CA5CA0A845865B43034AF88AF6@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d650ac-4768-4664-d5a1-08d661460bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 21:57:59.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xMyAyMToxOSwgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiBEb2N1bWVudCBS
Wi9HMkUgKFI4QTc3NEMwKSBTb0MgYmluZGluZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJy
aXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4NCj4gLS0tDQo+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1zaF9tb2JpbGUudHh0IHwg
MyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L2kyYy1zaF9tb2JpbGUudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ky
Yy9pMmMtc2hfbW9iaWxlLnR4dA0KPiBpbmRleCBiYzg3NmI3Li4zZGZmODlmIDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1zaF9tb2JpbGUu
dHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLXNo
X21vYmlsZS50eHQNCj4gQEAgLTgsNiArOCw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAJ
CQktICJyZW5lc2FzLGlpYy1yOGE3NzQ0IiAoUlovRzFOKQ0KPiAgCQkJLSAicmVuZXNhcyxpaWMt
cjhhNzc0NSIgKFJaL0cxRSkNCj4gIAkJCS0gInJlbmVzYXMsaWljLXI4YTc3NGExIiAoUlovRzJN
KQ0KPiArCQkJLSAicmVuZXNhcyxpaWMtcjhhNzc0YzAiIChSWi9HMkUpDQo+ICAJCQktICJyZW5l
c2FzLGlpYy1yOGE3NzkwIiAoUi1DYXIgSDIpDQo+ICAJCQktICJyZW5lc2FzLGlpYy1yOGE3Nzkx
IiAoUi1DYXIgTTItVykNCj4gIAkJCS0gInJlbmVzYXMsaWljLXI4YTc3OTIiIChSLUNhciBWMkgp
DQo+IEBAIC0zMiw3ICszMyw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAJCQlXaGVuIGNv
bXBhdGlibGUgd2l0aCAicmVuZXNhcyxybW9iaWxlLWlpYyIgaXQgc2hvdWxkDQo+ICAJCQliZSB0
aGUgbGFzdCBjb21wYXRpYmlsaXR5IHN0cmluZyBsaXN0ZWQuDQo+ICANCj4gLQkJCVRoZSByOGE3
Nzk5MCAoUi1DYXIgRTMpIGNvbnRyb2xsZXIgaXMgbm90DQo+ICsJCQlUaGUgcjhhNzc5OTAgKFIt
Q2FyIEUzKSBhbmQgUlovRzJFIGNvbnRyb2xsZXJzIGFyZSBub3QNCg0KVGhlIHJlZmVyZW5jZXMg
dG8gdGhlc2UgdHdvIGNvbnRyb2xsZXJzIGRvIG5vdCBmb2xsb3cgdGhlIHNhbWUgc3R5bGUuDQpJ
J2QgZWl0aGVyIGRlbGV0ZSByOGE3Nzk5MCBhbmQgZ2V0ICJSLUNhciBFMyBhbmQgUlovRzJFIiBv
ciBhZGQNCnI4YTc3NGMwIGluIGZyb250IG9mIFJaL0cyRSAoYnJhY2tldGVkKSwgd2l0aCBhIHNs
aWdodCBwcmVmZXJlbmNlDQpmb3IgdGhlIGxhdHRlci4NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiAg
CQkJY29uc2lkZXJlZCBjb21wYXRpYmxlIHdpdGggInJlbmVzYXMscmNhci1nZW4zLWlpYyINCj4g
IAkJCW9yICJyZW5lc2FzLHJtb2JpbGUtaWljIiBkdWUgdG8gdGhlIGFic2VuY2Ugb2YNCj4gIAkJ
CWF1dG9tYXRpYyB0cmFuc21pc3Npb24gcmVnaXN0ZXJzLg0KPiANCg==
