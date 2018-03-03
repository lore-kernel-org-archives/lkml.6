Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118695-2-12714774675992458722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118695; b=erRGmxt9kqkRNacbWY/IbubjaCyWySx7Zwcr9n6VuXPYb/P
    jEZ/PAeeVZ/owfvrJKg2RRW2xBtDRoNli2ZijvtmVtc9LBgSnpTuVFPq9Y2lRs7F
    lZwTTIWhnUDmWTSgVeL3WSqrfObb2GMU50DQBdBsyWqkNKukKIjyK9ewHJ+lJcaJ
    IU3Hhf+FzStS7rPWox0aqwEa9p0WiuC75n/qkjhDO//FdpDcgKPSDIKDRG27ebKL
    UwdBTTwUnfUTnxaJM3oLT+Oyjv51IckriAJFT1G7IlEH2K6OM6TaK/jmWhbd5Z+7
    A7QH9Pa3QBvHpNZyGpTR6Rxyq3m2GXFVba63Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520118695; bh=NAl6GIszOVYYYkyCq374scWDpMSfwTLy26Bfo4
    GKI68=; b=ZSBmAqt34saOCqbouY4ecJvgscMDJ42TPQ7yeHw8Cd+hyeZJMi7/Y9
    IzZVw+cSe0Sp6tT/gQlHBQ/54Z2P68si7FfXhkjb43q2edbahqWo2DR6spFpn64w
    TH6Ov6jOEC2jqS1JuwcMpFLlcBT0PmCUbLw/pteKoRj0zRGzdbnPOyPlKK8d4NkK
    H7SiuGLv7ARkASt+g7cbhtgRCU6xG9rWj3S6MPcTq1o3nIlgYH19GNp6eozCdSAX
    gT7di0/USzVDt13WvOc0dTvxu2l6HRWA8t6iOfGhLgFT8JmMc8HZtN+PwwHL4CDH
    L8akjhro1SQ+fOYSIhtSZO1CRa6SqWTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fGEBqHsb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fGEBqHsb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbeCCXLE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:11:04 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934571AbeCCWjW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 052/115] ARM: dts: koelsch: Correct clock
 frequency of X2 DU clock input
Thread-Topic: [PATCH AUTOSEL for 4.4 052/115] ARM: dts: koelsch: Correct clock
 frequency of X2 DU clock input
Thread-Index: AQHTsz9Zs6mVycVPXU+Jqs9bb+nzsQ==
Date: Sat, 3 Mar 2018 22:31:18 +0000
Message-ID: <20180303223010.27106-52-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:osX9+yVCj8wQzSwpXnuY5TVHlZ2Y9gRPId1JLgQQaY4wXqDdlwnb5wiwttXZC26gKqQILcPfp/3VXe6H0xrKUQZGrZf66OLxeng+vlugnLMYyGdopsj175hD94W63sFzyqSscjzc9wCvgpQPRNvsi7o3O7mFjwYgiNgtIukOYXKqGhvnViA9Saq3QDi40wvRHZdyH45HYSS0X7wYP6Lrr+cbW0rPzKA7wGje6DjrA/G1nZj3bufMC/3vyYJkf3R9H13hvR77yTFdPd+LozmkXO6otfvy/u+qfsOrd0ONXaMEMK3buJaV3V54x2kgWjlPp8XKvSPfNYA5hPZRGzAR+6DWwXuarQakJb+BvblR3ytkeZ1x6rl+UL1UnpRlPzF/;5:o93aNc9qhGcALNDie/CLOvTE/phxa9sg7lxLHMfstm65Xf80K2yhNMD+Fnu7ioBIV4jiuePPUF4SdEDt3kllLp9a7r3jvTqZs7ENINMj9aeGbQ/Dt9b2OvzL54RdMJhHcuQervOLpaUfr5kiprHQ8PFZXGbUXTAvuwNJn3lZFOk=;24:TZRFMp/8BpnNnnkBval3FdeOFimT1VJxz+Ln4KsHPXpJu1TaJZrJ3FJe2XxXTT86YEUW2iemifUAYCiaJTyOcyz9KPax1F3gcwdY08NogoU=;7:Ly4BSX0/1kVZCo9FZ+jS32oBht5WOABvbW8QggPs3+f0pn6NnVGUKCP5LaxSzcJ2vJ8VVev5iHbd2CrmcpFcJwQUVIFl4v/LSGSqlNlKtKGoGUzGP3F80s9DUC/B5/leu3VKxfaUVA3yvX+GnmsR371e4gqxxMq7tNIx48KbtG3yIJFJEgAXEB0TBV/zt5qTRAGE1nI4ANexlaiawvE166nVhLdfu4gj/4v6R89zR25PsKZXpgH4zjy1VynoSt+G
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 255ed946-00b7-45d6-7af7-08d58157996c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113C69C6C6E6B841A89B693FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: CVefC7zAuipsIhbT4BjR7Kbt2gJBYzDg5xX+YWoVlhYr9kWxtNRfIhACQ/CgdArLgdB0BDFJxWMHiUftTpppikqMnU21kqpjb9TdrFFYib0+9cLZXkw+6PhBOfs40Du9UMVB1zv8RnNICanWT8TIUXWFyUJ/aLtcP657vYidPKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD0282CF410BA8478C84519367339CD5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255ed946-00b7-45d6-7af7-08d58157996c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:18.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCg0KWyBV
cHN0cmVhbSBjb21taXQgZWJmMDZhZjU1Yzc1OTRlZDFmYzE4NDY5YTVjZGRmOTExYzQwZTY4NyBd
DQoNClRoZSBYMiBjcnlzdGFsIG9zY2lsbGF0b3Igb24gdGhlIEtvZWxzY2ggZGV2ZWxvcG1lbnQg
Ym9hcmQgcHJvdmlkZXMgYQ0KNzQuMjUgTUh6IGNsb2NrLCBub3QgYSAxNDguNSBNSHogY2xvY2su
DQoNCkZpeGVzOiBjZDIxY2I0NmUxNGFhZTNhICgiQVJNOiBzaG1vYmlsZToga29lbHNjaDogQWRk
IERVIGV4dGVybmFsIHBpeGVsIGNsb2NrcyB0byBEVCIpDQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KQWNrZWQtYnk6IExhdXJlbnQg
UGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NClRlc3RlZC1ieTog
TmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+
DQpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQu
Y29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc5MS1rb2Vsc2NoLmR0cyB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMgYi9hcmNoL2FybS9i
b290L2R0cy9yOGE3NzkxLWtvZWxzY2guZHRzDQppbmRleCBmYzQ0ZWEzNjFhNGIuLjYyZWFlMzE1
YWYxZiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMN
CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMNCkBAIC0yODAsNyAr
MjgwLDcgQEANCiAJeDJfY2xrOiB4Mi1jbG9jayB7DQogCQljb21wYXRpYmxlID0gImZpeGVkLWNs
b2NrIjsNCiAJCSNjbG9jay1jZWxscyA9IDwwPjsNCi0JCWNsb2NrLWZyZXF1ZW5jeSA9IDwxNDg1
MDAwMDA+Ow0KKwkJY2xvY2stZnJlcXVlbmN5ID0gPDc0MjUwMDAwPjsNCiAJfTsNCiANCiAJeDEz
X2NsazogeDEzLWNsb2NrIHsNCi0tIA0KMi4xNC4xDQo=
