Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233386-2-2007996157266624269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233385; b=YjX66v1K0Nz9/kLLIJEnnlVxHEfsKbMGV0ORC14nOdg+PGEFKF
    BaEIVXoeUrMhT4FAQNPazptA8i3zXkW2MWmWBcmgT5C2UF4LhkjGNnLV7mxXvKA4
    QTlOWGrYyQLpgDdL3ASnU4cxC04kbyVByArLId8NM0Z1sH5Dqcy0Z5twrFzOlZ8w
    ZelR/O1Zw4YAwlPmw3Nq0JXj7jOFId62kwIB5tKjAYoQFEMkPSDxmp879RF6u0pR
    pJ13hOOUXbZIwRRlGZR+fD0IzRKjZejOUcE0OfQwINysRq4/0r7AIdJPu3EXbeAJ
    aDd0jxHLWZ3CvbEcjGSv89plAiNcvpj62fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523233385; bh=w6ggzqsSifYUItn8DxFz1dke6KeIBE94EDrLTuIIpIc=; b=
    Ullutm0AwfQqJtBePF6PRjDlRw0ABNFFqOcEJCWLhNC59lUqDvgD8dRCcBfHIrDp
    r1lKEardB+N5r795Se77aQsgvw+CA1RW7NVpt003QMmSGuaufH+ZHpX+X2bO2H+G
    X1HSsIt3FrHyHl7rSTmVRWsBXIop+x3m7fnj5KHBpT8M4/YRg4un7NUyBTDkGRv1
    rnQ1vKwcVWQuh7v0XjbuuJG9cZVqgN+xWUYQcisLqZ7AtTG3iL+XveLWzLSsBxE+
    uKUQnYe/zNGmPzG1T72yPNoJPWySS9fhF4/rKbQxRmuwKMSNm4CyQrHVxI7ZeSKc
    EOXH7rHXW1Hm3uoZbJfuFg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kIkeP6kZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kIkeP6kZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMvuw4GmUABSZ1LfMl65ndsQoFHg7WmmFrgcQjbyMwQy2V1DYFGMvsydUJyW84+8SpgNio4HiwAxUFKRHEXaDxH33xMapNCTnYdmkCs9xGNAUy3uhxmf
    /3DtcFVEOjVU936D7klqLaCEnSczL6//jNfIDYS2ZxZjVA+F7vcsTVuFMkhsCTVRTtOwu7FZFTdfxh3mMyEZLpKl7/guyWQbN/VHSURxu+sZQ473dTVR2rvU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tBb2bbeoAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=fGZEGPJtKAgip5Mm1HkA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeDIAXB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:01 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754739AbeDIAWw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 035/161] ubifs: Fix uninitialized variable in
 search_dh_cookie()
Thread-Topic: [PATCH AUTOSEL for 4.14 035/161] ubifs: Fix uninitialized
 variable in search_dh_cookie()
Thread-Index: AQHTz5iGYk9lYtYwYUOjEgf3qmmNiA==
Date: Mon, 9 Apr 2018 00:20:12 +0000
Message-ID: <20180409001936.162706-35-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:b6JWXzoek3pFzL7pmTgeCMmwXcqpBZ56t7hfKfEqYPs0OkHHT/Bl7EQepEoXY0clT1L6P1JtSTgrZe8DM4rerW7HurUfyIAcDCXn237rc8CULugAqdJT7NnIG4bMdF9avSPj7rMcqa2cY0oYkxLgB1XdOyNheMYQ5fztUjI5iK8h4jvlHkmC5N9VKDOYRikxPAPvJErDED4hzuC/NFKlK8wKOhWwk6gfm0F1x1KYG12yX9qLi0csqJC4MgodeuSL;20:7pu1pGvWXVpqEmv3vewLxDCOmkYIYfGLZLscGnRAS26dedYb0/w2aJvdhgHOGEYNya9UAlSkP1X3jlWm4bHX89Ly3J4a6bKGdObnaA0/3tnmvVS66+SlaGY29ZHfYiP+6C8Qd5VT1iBUJjkGwJpDeZRYviRdh7TsrZ8Q+BF8IvU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c79b214c-6e1c-43c8-7b12-08d59db00519
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966574C906AB692FE3281C8FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: phsxbLoLnyRVQKlPGwU/PdP0Gkphx9emUpph8dgr8V7Icl5S5SQYTRPBzDJPQGBzl5H0Ut4Ickei2678Wk1ryZcZaoes93GdME56b2BR33TXSkpyVQtKGJPtlYdUtWnn1M5GXBK4KJiN3Lmnwxo2fyitInDE6IPUqEim1nY0vsWG2ywOCUPR+iE74h46sQT6jnTDbrzxJKiTgR92FeyEEUGComQQc0pbexaLrMCl93tmtLxh/FuE5CR8K8HbXZGqKN4t61GjdzYULy8E8qKTtzCYnBZRAsb7TFfOariu+4wpE+jhRNEueYKwmk9evdSZsHWEz3b9hhmG2v4NFfbmQlDM7+rV8XqXeMSm5SN1zqanYD2kY85xzlV43puOiDJqY2w+3qFpR9D8pVsICqiR6zEeEeYBg0pdF8jscEBcJ5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <28D56674CF184E42AE6C421BACDCE0F5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79b214c-6e1c-43c8-7b12-08d59db00519
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:12.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgYzg3NzE1NGQzMDdmNGE5MWUwYjViODViNzU1MzU3MTNkYWI5NDVhZSBdDQoN
CmZzL3ViaWZzL3RuYy5jOiBJbiBmdW5jdGlvbiDigJhzZWFyY2hfZGhfY29va2ll4oCZOg0KZnMv
dWJpZnMvdG5jLmM6MTg5Mzogd2FybmluZzog4oCYZXJy4oCZIGlzIHVzZWQgdW5pbml0aWFsaXpl
ZCBpbiB0aGlzIGZ1bmN0aW9uDQoNCkluZGVlZCwgZXJyIGlzIGFsd2F5cyB1c2VkIHVuaW5pdGlh
bGl6ZWQuDQoNCkFjY29yZGluZyB0byBhbiBvcmlnaW5hbCByZXZpZXcgY29tbWVudCBmcm9tIEh5
dW5jaHVsLCBhY2tub3dsZWRnZWQgYnkNClJpY2hhcmQsIGVyciBzaG91bGQgYmUgaW5pdGlhbGl6
ZWQgdG8gLUVOT0VOVCB0byBhdm9pZCB0aGUgZmlyc3QgY2FsbCB0bw0KdG5jX25leHQoKS4gIEJ1
dCB3ZSBjYW4gYWNoaWV2ZSB0aGUgc2FtZSBieSByZW9yZGVyaW5nIHRoZSBjb2RlLg0KDQpGaXhl
czogNzgxZjY3NWUyZDdlICgidWJpZnM6IEZpeCB1bmxpbmsgY29kZSB3cnQuIGRvdWJsZSBoYXNo
IGxvb2t1cHMiKQ0KUmVwb3J0ZWQtYnk6IEh5dW5jaHVsIExlZSA8aHljLmxlZUBnbWFpbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4NClNp
Z25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4N
Ci0tLQ0KIGZzL3ViaWZzL3RuYy5jIHwgMjEgKysrKysrKy0tLS0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9mcy91Ymlmcy90bmMuYyBiL2ZzL3ViaWZzL3RuYy5jDQppbmRleCAwYTIxM2RjYmEyYTEuLmJh
M2QwZTBmODYxNSAxMDA2NDQNCi0tLSBhL2ZzL3ViaWZzL3RuYy5jDQorKysgYi9mcy91Ymlmcy90
bmMuYw0KQEAgLTE4OTAsMzUgKzE4OTAsMjggQEAgc3RhdGljIGludCBzZWFyY2hfZGhfY29va2ll
KHN0cnVjdCB1Ymlmc19pbmZvICpjLCBjb25zdCB1bmlvbiB1Ymlmc19rZXkgKmtleSwNCiAJdW5p
b24gdWJpZnNfa2V5ICpka2V5Ow0KIA0KIAlmb3IgKDs7KSB7DQotCQlpZiAoIWVycikgew0KLQkJ
CWVyciA9IHRuY19uZXh0KGMsICZ6bm9kZSwgbik7DQotCQkJaWYgKGVycikNCi0JCQkJZ290byBv
dXQ7DQotCQl9DQotDQogCQl6YnIgPSAmem5vZGUtPnpicmFuY2hbKm5dOw0KIAkJZGtleSA9ICZ6
YnItPmtleTsNCiANCiAJCWlmIChrZXlfaW51bShjLCBka2V5KSAhPSBrZXlfaW51bShjLCBrZXkp
IHx8DQogCQkgICAga2V5X3R5cGUoYywgZGtleSkgIT0ga2V5X3R5cGUoYywga2V5KSkgew0KLQkJ
CWVyciA9IC1FTk9FTlQ7DQotCQkJZ290byBvdXQ7DQorCQkJcmV0dXJuIC1FTk9FTlQ7DQogCQl9
DQogDQogCQllcnIgPSB0bmNfcmVhZF9oYXNoZWRfbm9kZShjLCB6YnIsIGRlbnQpOw0KIAkJaWYg
KGVycikNCi0JCQlnb3RvIG91dDsNCisJCQlyZXR1cm4gZXJyOw0KIA0KIAkJaWYgKGtleV9oYXNo
KGMsIGtleSkgPT0ga2V5X2hhc2goYywgZGtleSkgJiYNCiAJCSAgICBsZTMyX3RvX2NwdShkZW50
LT5jb29raWUpID09IGNvb2tpZSkgew0KIAkJCSp6biA9IHpub2RlOw0KLQkJCWdvdG8gb3V0Ow0K
KwkJCXJldHVybiAwOw0KIAkJfQ0KLQl9DQotDQotb3V0Og0KIA0KLQlyZXR1cm4gZXJyOw0KKwkJ
ZXJyID0gdG5jX25leHQoYywgJnpub2RlLCBuKTsNCisJCWlmIChlcnIpDQorCQkJcmV0dXJuIGVy
cjsNCisJfQ0KIH0NCiANCiBzdGF0aWMgaW50IGRvX2xvb2t1cF9kaChzdHJ1Y3QgdWJpZnNfaW5m
byAqYywgY29uc3QgdW5pb24gdWJpZnNfa2V5ICprZXksDQotLSANCjIuMTUuMQ0K
