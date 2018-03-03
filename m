Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123553-2-17435649070540702739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES caenro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123552; b=vkcT35EbtT8XNYUb0uG2E8ecuqrbBCupJBnPxDjOo8RKXjS
    nK6I+4G7+qT5+Z+ei6g2+MGzQhjygmrIo3/NmOLovVP2dtKbv4166t0XgzOdEID7
    fqAy/MK4HNm3Tw6gVsuBzyRbxab3BIN2GPnWkm/awyL9axv+rYNWs3dPp6IPZBm1
    gvBvdv47+/vQ7Eri5RQjWe+0TntE/yAA9+r6vAx7KgpdTa2JF1XweY1HECopSQc5
    pNO51rcLvs+0k5SMFFaoPbrRgFIGT67vi2jWz5VZJdZucmEz+0p4CCzVrAbXCSU/
    OeSJXtsn9is2uDtN/hac1BrM8kREO/EITcvybCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520123552; bh=UUGZmZh8lsSycLhmQd9GWX48RJ77Fe/pIZZQdh
    6cfpw=; b=XZ1gdcx4HDJzDEpev4STWWklDCCRwwc4GLKseD4Y1Bh9eBGGzYUJEN
    gR+gIUMV8JehUe0kzY2mUtVoZiBBrPpRCM4+utJm6MF5k+LkDfuhL2CVAVhH2qPl
    vSqi39f9k2yF+SDVJDF1APHvPNxBm5SiUbjSM4bo5ioCf0MzQR1d+a+pf0gybNoe
    FFdkGs8PD64zujvT8Ksx8YYCmc+XEE23SjNTBnoMf0gLFNPpRQNkP4EhK/FpYxr0
    2JF0rm9hSDu6zOdkU6w9TGeY4WH6FgekCfpNeqTv28T4KDojY7GgX7IRZ4Lbh46C
    QzgKTsqHwzcDS2r+cBTPpIs5q4zZfNXg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HS8Wa5dZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HS8Wa5dZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCDAcN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:32:13 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933011AbeCCW1w (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 093/102] crypto: caam/qi - use correct print
 specifier for size_t
Thread-Topic: [PATCH AUTOSEL for 4.15 093/102] crypto: caam/qi - use correct
 print specifier for size_t
Thread-Index: AQHTsz555bWPmzbse0+WDqxVmWo2aQ==
Date: Sat, 3 Mar 2018 22:25:03 +0000
Message-ID: <20180303222318.26006-93-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:Xfvaz0Vk/ZqxoXhS66zLtKI8hytEhwmJaauKH/bL5hg8T6XQkj3xtMglQY8R7LQTg50Twcxx7LcTJtRF3jnv06KJcLniP1i1uyQ8Gc8lyTjWoKxEIDVHNUBQsLqGYmXTQxNGx+Z61ZH6PXAyFjbWFhs7pzajvBDm1WzQDbGhn5HBmB/9u12oxiBRX75z6yXj30jl6YPlWjGVzVRkk5O1jWCTvTRLduOHoRVrTLFfRL8OXlERVvcWYG8T85kY0Q3xOv1NIORvgea0lqB4kX1bKviJRKod9DJXn4ZOZ5QOE6voWmL6R4AFJcFp6AmrEhXw7zbuX61yKHOMWDgSYo8woXIh/tDZSj5cztoR1O2TvRv6w/u24b/RM5TtudZbci9M;5:1WV1t0Ss5ITUUZd14PhhS07QQnBw476gx+RAkD5QILHkn5rAgRfE4BDyr3uHCTKg0itZpiBEivhDeF4phC5rp7EpAuDpE/vn/ltH/pre0cyLjKCgwGm61Fs8nOsvIDw8BBZg9tvwqzK31gO7egIOfYvlcQB653Yhj5XgespCIZA=;24:C0buNuBEfozFzs3mdc9O0OFBV3saW6uh4QvM0kN6MWjjzO/Uxi2Py5jLj8F0CnfCxErSBKnCxEWh4DZnzz+4S9jL7jqDwsQKfy5fIXUSzXQ=;7:lm8blKI9Zjq+gvfySVg0Y9Lh3pwdCao6EK/CYIAvxoJ4d3TWl5P2BNU/SPtrEWb4fM3ANjZndITeqL4J5rmtZEYd50LOyiBe6Z5kErIXVGxkLEfYodisnMGNt3vh3p2u0pF0MTwtztDcdix9AFo2jHC8Nfjy8er/7s+LoVdXaehilOpeBFcef40pYahvnwR3jLfqmy7qM3xFfH4PAWnPL3M77cDHJMW+1k7DFVCQN4UVugtTdMTxyX2HEN67yw+w
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1984c918-af72-4350-b179-08d58155ffff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB068537F3ABC4997E0661B6FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(8656006)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ssL8GK9TpgztmbPAnL07ibkE9GAwZHOTMJhtImZeL3aWAkDwi9e9UgFTpXp3BhgyJ9XgUK9o1Mpk0xwR96HH8RgZ/R3Www+WNCkbNR8fiF2bTSPeG6YsL36+tVCutXolHLXnXtEer7jCvttL1pJecSHAPz4Y7QuKGKBx/PZ7Pv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A038D1B31E40E44EA5ADEBC3F25336DF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1984c918-af72-4350-b179-08d58155ffff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:03.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IDlkYjA5ZTNiYWQ2NTM5M2RjMjNiMDI3OWJlYjdmMzc1NGQ3NzA2NWMgXQ0KDQpGaXgg
YmVsb3cgd2FybmluZ3Mgb24gQVJNdjcgYnkgdXNpbmcgJXp1IGZvciBwcmludGluZyBzaXplX3Qg
dmFsdWVzOg0KDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzogSW4gZnVuY3Rpb24g
YWVhZF9lZGVzY19hbGxvYzoNCmRyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjQxNzox
Nzogd2FybmluZzogZm9ybWF0ICVsdSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgbG9uZyB1bnNp
Z25lZCBpbnQsIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIHVuc2lnbmVkIGludCBbLVdmb3JtYXQ9
XQ0KICAgc2l6ZW9mKHN0cnVjdCBxbV9zZ19lbnRyeSkpDQogICAgICAgICAgICAgICAgIF4NCmRy
aXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjY3MjoxNjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIENBQU1fUUlfTUFYX0FFQURfU0cNCiAgICBxbV9zZ19lbnRzLCBDQUFNX1FJX01B
WF9BRUFEX1NHKTsNCiAgICAgICAgICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1h
bGdfcWkuYzogSW4gZnVuY3Rpb24gYWJsa2NpcGhlcl9lZGVzY19hbGxvYzoNCmRyaXZlcnMvY3J5
cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjQ0MDoxNzogd2FybmluZzogZm9ybWF0ICVsdSBleHBlY3Rz
IGFyZ3VtZW50IG9mIHR5cGUgbG9uZyB1bnNpZ25lZCBpbnQsIGJ1dCBhcmd1bWVudCA0IGhhcyB0
eXBlIHVuc2lnbmVkIGludCBbLVdmb3JtYXQ9XQ0KICAgc2l6ZW9mKHN0cnVjdCBxbV9zZ19lbnRy
eSkpDQogICAgICAgICAgICAgICAgIF4NCmRyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5j
OjkwOToxNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIENBQU1fUUlfTUFYX0FCTEtDSVBI
RVJfU0cNCiAgICBxbV9zZ19lbnRzLCBDQUFNX1FJX01BWF9BQkxLQ0lQSEVSX1NHKTsNCiAgICAg
ICAgICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzogSW4gZnVuY3Rp
b24gYWJsa2NpcGhlcl9naXZfZWRlc2NfYWxsb2M6DQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1h
bGdfcWkuYzo0NDA6MTc6IHdhcm5pbmc6IGZvcm1hdCAlbHUgZXhwZWN0cyBhcmd1bWVudCBvZiB0
eXBlIGxvbmcgdW5zaWduZWQgaW50LCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSB1bnNpZ25lZCBp
bnQgWy1XZm9ybWF0PV0NCiAgIHNpemVvZihzdHJ1Y3QgcW1fc2dfZW50cnkpKQ0KICAgICAgICAg
ICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzoxMDYyOjE2OiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRw0KICAgIHFt
X3NnX2VudHMsIENBQU1fUUlfTUFYX0FCTEtDSVBIRVJfU0cpOw0KICAgICAgICAgICAgICAgIF4N
Cg0KRml4ZXM6IGViOWJhMzdkYzE1YSAoImNyeXB0bzogY2FhbS9xaSAtIGhhbmRsZSBsYXJnZSBu
dW1iZXIgb2YgUy9HcyBjYXNlIikNClNpZ25lZC1vZmYtYnk6IEhvcmlhIEdlYW50xIMgPGhvcmlh
LmdlYW50YUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogSGVyYmVydCBYdSA8aGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5s
ZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxnX3Fp
LmMgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYyBi
L2RyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jDQppbmRleCBmOWYwOGZjZTQzNTYuLmFk
MTRiNjlhMDUyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5j
DQorKysgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYw0KQEAgLTY2OCw3ICs2Njgs
NyBAQCBzdGF0aWMgc3RydWN0IGFlYWRfZWRlc2MgKmFlYWRfZWRlc2NfYWxsb2Moc3RydWN0IGFl
YWRfcmVxdWVzdCAqcmVxLA0KIAlxbV9zZ19lbnRzID0gMSArICEhaXZzaXplICsgbWFwcGVkX3Ny
Y19uZW50cyArDQogCQkgICAgIChtYXBwZWRfZHN0X25lbnRzID4gMSA/IG1hcHBlZF9kc3RfbmVu
dHMgOiAwKTsNCiAJaWYgKHVubGlrZWx5KHFtX3NnX2VudHMgPiBDQUFNX1FJX01BWF9BRUFEX1NH
KSkgew0KLQkJZGV2X2VycihxaWRldiwgIkluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAl
bHVcbiIsDQorCQlkZXZfZXJyKHFpZGV2LCAiSW5zdWZmaWNpZW50IFMvRyBlbnRyaWVzOiAlZCA+
ICV6dVxuIiwNCiAJCQlxbV9zZ19lbnRzLCBDQUFNX1FJX01BWF9BRUFEX1NHKTsNCiAJCWNhYW1f
dW5tYXAocWlkZXYsIHJlcS0+c3JjLCByZXEtPmRzdCwgc3JjX25lbnRzLCBkc3RfbmVudHMsDQog
CQkJICAgaXZfZG1hLCBpdnNpemUsIG9wX3R5cGUsIDAsIDApOw0KQEAgLTkwNSw3ICs5MDUsNyBA
QCBzdGF0aWMgc3RydWN0IGFibGtjaXBoZXJfZWRlc2MgKmFibGtjaXBoZXJfZWRlc2NfYWxsb2Mo
c3RydWN0IGFibGtjaXBoZXJfcmVxdWVzdA0KIA0KIAlxbV9zZ19lbnRzICs9IG1hcHBlZF9kc3Rf
bmVudHMgPiAxID8gbWFwcGVkX2RzdF9uZW50cyA6IDA7DQogCWlmICh1bmxpa2VseShxbV9zZ19l
bnRzID4gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRykpIHsNCi0JCWRldl9lcnIocWlkZXYsICJJ
bnN1ZmZpY2llbnQgUy9HIGVudHJpZXM6ICVkID4gJWx1XG4iLA0KKwkJZGV2X2VycihxaWRldiwg
Ikluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAlenVcbiIsDQogCQkJcW1fc2dfZW50cywg
Q0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRyk7DQogCQljYWFtX3VubWFwKHFpZGV2LCByZXEtPnNy
YywgcmVxLT5kc3QsIHNyY19uZW50cywgZHN0X25lbnRzLA0KIAkJCSAgIGl2X2RtYSwgaXZzaXpl
LCBvcF90eXBlLCAwLCAwKTsNCkBAIC0xMDU4LDcgKzEwNTgsNyBAQCBzdGF0aWMgc3RydWN0IGFi
bGtjaXBoZXJfZWRlc2MgKmFibGtjaXBoZXJfZ2l2X2VkZXNjX2FsbG9jKA0KIAl9DQogDQogCWlm
ICh1bmxpa2VseShxbV9zZ19lbnRzID4gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRykpIHsNCi0J
CWRldl9lcnIocWlkZXYsICJJbnN1ZmZpY2llbnQgUy9HIGVudHJpZXM6ICVkID4gJWx1XG4iLA0K
KwkJZGV2X2VycihxaWRldiwgIkluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAlenVcbiIs
DQogCQkJcW1fc2dfZW50cywgQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRyk7DQogCQljYWFtX3Vu
bWFwKHFpZGV2LCByZXEtPnNyYywgcmVxLT5kc3QsIHNyY19uZW50cywgZHN0X25lbnRzLA0KIAkJ
CSAgIGl2X2RtYSwgaXZzaXplLCBHSVZFTkNSWVBULCAwLCAwKTsNCi0tIA0KMi4xNC4xDQo=
