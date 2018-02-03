Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682884-2-13620751355169234440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682884; b=u4cfHe4yHbeBzoAp+p4tgL/KkYCuApY3FK+fqZt8N7qg4CC
    OsGA5vDNQvzr4Djwqx+IetdWZYCAYAPNzyM6mga1It89omH0m074GUAVuJ+cFnXB
    nNhWGXxkTg38iHUx62LpnKc/k0gYVTPyWD2d+fXwQ2V1LDnOQHJkJF/lzb+ap2O9
    8NxqXc68yotlCMR/kyp07qqgly9Zjq3gnw/FSI4bz67OLg31APpX/mQ5MSmoCPj4
    wCg0moFoHJIKjvlz8R/PWj6X2PAYW+hEnwHZu4ZZs9OC07iuTVKQUTydMylkvrQn
    5tanPh6WeBOaANoIgWCuQ9atzZKRoGcITFHMmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517682884; bh=tqVBj47PxHnZCKQt/3amH/TISs+HkhjXHORSSq
    jJRjQ=; b=koEoresd0IhgMVbqNJyxQ52YFqDgvyuENx1RhGzZOrOMpN/Emyh/uO
    2BgnQU+G7liQXbt2JRwuRVCB55f70qVU3kWaccPVSO9KmelZrHI1MR1GEC1tgnty
    oIytkQhec1iFm6z9sBkEWPb3rCtKGjv4GMpx8/rvU8SuL608jl3YEQPa2rHkF4C8
    QfufsEuG3EuPsm8fD6HKMr/nevtTRSvV5usF2sd3iSXgAsY2HLg9TveCO0UgTvcd
    PKCCIl/4Zm6gng7zW76GbHABD4YOXxc39ksqUSO9i11FO6+feQstshpnDo5pH+vn
    r7UYWi+mC1jXoxGBwPBQH3RYdIQ76CBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=USnZBK9z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=USnZBK9z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeBCSej (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:39 -0500
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:19232
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753303AbeBCSEP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QW50b2luZSBUw6luYXJ0?=
        <antoine.tenart@free-electrons.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 057/110] crypto: inside-secure - fix request
 allocations in invalidation path
Thread-Topic: [PATCH AUTOSEL for 4.14 057/110] crypto: inside-secure - fix
 request allocations in invalidation path
Thread-Index: AQHTnRjwtnhusJ90LUuQi/f6SqzZcg==
Date: Sat, 3 Feb 2018 18:00:55 +0000
Message-ID: <20180203180015.29073-57-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:sEuQBrL85KE2HGfJgn/ReCW78LkfxLc12tttIqM4EXU6R5uCBkee6WjrLSX4n2yQwxOXu/Eoqntly70SVsy0ubCb5UyPoN6G/eDlT7p+y+It4va50c2PCT3sHKpYJQEhvIKuKI+yE7MmeBFUZU4kjeUNS6A6xNKSdB2hxzY69XEM1jmas0elGojTPCYveQvfO5NhVhFg42/9P8ZRZG0QkcymkU7VjRcFBPQvrnv+M/jm5lX/c5tnzUgIIaE9CUyX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1343942b-8cb7-4bb7-5c37-08d56b302764
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10920964BA1A0D251C5DD506FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: PG8KLfm43nsHmRqlSk2jONVp6wx9HH+wOrEROXsf8w5kzO76GlQ/dcF5xF2+OuQAWgPMql+G9cwZZ9lhqAs4ZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC22637DF500E34E94E339A7805E13BC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1343942b-8cb7-4bb7-5c37-08d56b302764
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:55.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQW50b2luZSBUw6luYXJ0IDxhbnRvaW5lLnRlbmFydEBmcmVlLWVsZWN0cm9ucy5jb20+
DQoNClsgVXBzdHJlYW0gY29tbWl0IDdjYWQyZmFiZDU2OTFkYmIxNzc2Mjg3N2Q0ZTdmMjM2ZmU0
YmMxODEgXQ0KDQpUaGlzIHBhdGNoIG1ha2VzIHVzZSBvZiB0aGUgU0tDSVBIRVJfUkVRVUVTVF9P
Tl9TVEFDSyBhbmQNCkFIQVNIX1JFUVVFU1RfT05fU1RBQ0sgaGVscGVycyB0byBhbGxvY2F0ZSBl
bm91Z2ggbWVtb3J5IHRvIGNvbnRhaW4gYm90aA0KdGhlIGNyeXB0byByZXF1ZXN0IHN0cnVjdHVy
ZXMgYW5kIHRoZWlyIGVtYmVkZGVkIGNvbnRleHQgKF9fY3R4KS4NCg0KRml4ZXM6IDFiNDRjNWE2
MGMxMyAoImNyeXB0bzogaW5zaWRlLXNlY3VyZSAtIGFkZCBTYWZlWGNlbCBFSVAxOTcgY3J5cHRv
IGVuZ2luZSBkcml2ZXIiKQ0KU3VnZ2VzdGVkLWJ5OiBPZmVyIEhlaWZldHogPG9mZXJoQG1hcnZl
bGwuY29tPg0KU2lnbmVkLW9mZi1ieTogQW50b2luZSBUZW5hcnQgPGFudG9pbmUudGVuYXJ0QGZy
ZWUtZWxlY3Ryb25zLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29u
ZG9yLmFwYW5hLm9yZy5hdT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIu
bGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvY3J5cHRvL2luc2lkZS1zZWN1cmUv
c2FmZXhjZWxfY2lwaGVyLmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQogZHJpdmVycy9jcnlwdG8v
aW5zaWRlLXNlY3VyZS9zYWZleGNlbF9oYXNoLmMgICB8IDE0ICsrKysrKystLS0tLS0tDQogMiBm
aWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3J5cHRvL2luc2lkZS1zZWN1cmUvc2FmZXhjZWxfY2lwaGVyLmMgYi9k
cml2ZXJzL2NyeXB0by9pbnNpZGUtc2VjdXJlL3NhZmV4Y2VsX2NpcGhlci5jDQppbmRleCA5ZWEy
NDg2OGQ4NjAuLmZjYzBhNjA2ZDc0OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2luc2lk
ZS1zZWN1cmUvc2FmZXhjZWxfY2lwaGVyLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2luc2lkZS1z
ZWN1cmUvc2FmZXhjZWxfY2lwaGVyLmMNCkBAIC00MjIsMjUgKzQyMiwyNSBAQCBzdGF0aWMgaW50
IHNhZmV4Y2VsX2NpcGhlcl9leGl0X2ludihzdHJ1Y3QgY3J5cHRvX3RmbSAqdGZtKQ0KIHsNCiAJ
c3RydWN0IHNhZmV4Y2VsX2NpcGhlcl9jdHggKmN0eCA9IGNyeXB0b190Zm1fY3R4KHRmbSk7DQog
CXN0cnVjdCBzYWZleGNlbF9jcnlwdG9fcHJpdiAqcHJpdiA9IGN0eC0+cHJpdjsNCi0Jc3RydWN0
IHNrY2lwaGVyX3JlcXVlc3QgcmVxOw0KLQlzdHJ1Y3Qgc2FmZXhjZWxfY2lwaGVyX3JlcSAqc3Jl
cSA9IHNrY2lwaGVyX3JlcXVlc3RfY3R4KCZyZXEpOw0KKwlTS0NJUEhFUl9SRVFVRVNUX09OX1NU
QUNLKHJlcSwgX19jcnlwdG9fc2tjaXBoZXJfY2FzdCh0Zm0pKTsNCisJc3RydWN0IHNhZmV4Y2Vs
X2NpcGhlcl9yZXEgKnNyZXEgPSBza2NpcGhlcl9yZXF1ZXN0X2N0eChyZXEpOw0KIAlzdHJ1Y3Qg
c2FmZXhjZWxfaW52X3Jlc3VsdCByZXN1bHQgPSB7fTsNCiAJaW50IHJpbmcgPSBjdHgtPmJhc2Uu
cmluZzsNCiANCi0JbWVtc2V0KCZyZXEsIDAsIHNpemVvZihzdHJ1Y3Qgc2tjaXBoZXJfcmVxdWVz
dCkpOw0KKwltZW1zZXQocmVxLCAwLCBzaXplb2Yoc3RydWN0IHNrY2lwaGVyX3JlcXVlc3QpKTsN
CiANCiAJLyogY3JlYXRlIGludmFsaWRhdGlvbiByZXF1ZXN0ICovDQogCWluaXRfY29tcGxldGlv
bigmcmVzdWx0LmNvbXBsZXRpb24pOw0KLQlza2NpcGhlcl9yZXF1ZXN0X3NldF9jYWxsYmFjaygm
cmVxLCBDUllQVE9fVEZNX1JFUV9NQVlfQkFDS0xPRywNCi0JCQkJCXNhZmV4Y2VsX2ludl9jb21w
bGV0ZSwgJnJlc3VsdCk7DQorCXNrY2lwaGVyX3JlcXVlc3Rfc2V0X2NhbGxiYWNrKHJlcSwgQ1JZ
UFRPX1RGTV9SRVFfTUFZX0JBQ0tMT0csDQorCQkJCSAgICAgIHNhZmV4Y2VsX2ludl9jb21wbGV0
ZSwgJnJlc3VsdCk7DQogDQotCXNrY2lwaGVyX3JlcXVlc3Rfc2V0X3RmbSgmcmVxLCBfX2NyeXB0
b19za2NpcGhlcl9jYXN0KHRmbSkpOw0KLQljdHggPSBjcnlwdG9fdGZtX2N0eChyZXEuYmFzZS50
Zm0pOw0KKwlza2NpcGhlcl9yZXF1ZXN0X3NldF90Zm0ocmVxLCBfX2NyeXB0b19za2NpcGhlcl9j
YXN0KHRmbSkpOw0KKwljdHggPSBjcnlwdG9fdGZtX2N0eChyZXEtPmJhc2UudGZtKTsNCiAJY3R4
LT5iYXNlLmV4aXRfaW52ID0gdHJ1ZTsNCiAJc3JlcS0+bmVlZHNfaW52ID0gdHJ1ZTsNCiANCiAJ
c3Bpbl9sb2NrX2JoKCZwcml2LT5yaW5nW3JpbmddLnF1ZXVlX2xvY2spOw0KLQljcnlwdG9fZW5x
dWV1ZV9yZXF1ZXN0KCZwcml2LT5yaW5nW3JpbmddLnF1ZXVlLCAmcmVxLmJhc2UpOw0KKwljcnlw
dG9fZW5xdWV1ZV9yZXF1ZXN0KCZwcml2LT5yaW5nW3JpbmddLnF1ZXVlLCAmcmVxLT5iYXNlKTsN
CiAJc3Bpbl91bmxvY2tfYmgoJnByaXYtPnJpbmdbcmluZ10ucXVldWVfbG9jayk7DQogDQogCWlm
ICghcHJpdi0+cmluZ1tyaW5nXS5uZWVkX2RlcXVldWUpDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
cnlwdG8vaW5zaWRlLXNlY3VyZS9zYWZleGNlbF9oYXNoLmMgYi9kcml2ZXJzL2NyeXB0by9pbnNp
ZGUtc2VjdXJlL3NhZmV4Y2VsX2hhc2guYw0KaW5kZXggNjE2MzNiOWE3NDlkLi5kNjI2YWE0ODVh
NzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by9pbnNpZGUtc2VjdXJlL3NhZmV4Y2VsX2hh
c2guYw0KKysrIGIvZHJpdmVycy9jcnlwdG8vaW5zaWRlLXNlY3VyZS9zYWZleGNlbF9oYXNoLmMN
CkBAIC00NzAsMjUgKzQ3MCwyNSBAQCBzdGF0aWMgaW50IHNhZmV4Y2VsX2FoYXNoX2V4aXRfaW52
KHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0pDQogew0KIAlzdHJ1Y3Qgc2FmZXhjZWxfYWhhc2hfY3R4
ICpjdHggPSBjcnlwdG9fdGZtX2N0eCh0Zm0pOw0KIAlzdHJ1Y3Qgc2FmZXhjZWxfY3J5cHRvX3By
aXYgKnByaXYgPSBjdHgtPnByaXY7DQotCXN0cnVjdCBhaGFzaF9yZXF1ZXN0IHJlcTsNCi0Jc3Ry
dWN0IHNhZmV4Y2VsX2FoYXNoX3JlcSAqcmN0eCA9IGFoYXNoX3JlcXVlc3RfY3R4KCZyZXEpOw0K
KwlBSEFTSF9SRVFVRVNUX09OX1NUQUNLKHJlcSwgX19jcnlwdG9fYWhhc2hfY2FzdCh0Zm0pKTsN
CisJc3RydWN0IHNhZmV4Y2VsX2FoYXNoX3JlcSAqcmN0eCA9IGFoYXNoX3JlcXVlc3RfY3R4KHJl
cSk7DQogCXN0cnVjdCBzYWZleGNlbF9pbnZfcmVzdWx0IHJlc3VsdCA9IHt9Ow0KIAlpbnQgcmlu
ZyA9IGN0eC0+YmFzZS5yaW5nOw0KIA0KLQltZW1zZXQoJnJlcSwgMCwgc2l6ZW9mKHN0cnVjdCBh
aGFzaF9yZXF1ZXN0KSk7DQorCW1lbXNldChyZXEsIDAsIHNpemVvZihzdHJ1Y3QgYWhhc2hfcmVx
dWVzdCkpOw0KIA0KIAkvKiBjcmVhdGUgaW52YWxpZGF0aW9uIHJlcXVlc3QgKi8NCiAJaW5pdF9j
b21wbGV0aW9uKCZyZXN1bHQuY29tcGxldGlvbik7DQotCWFoYXNoX3JlcXVlc3Rfc2V0X2NhbGxi
YWNrKCZyZXEsIENSWVBUT19URk1fUkVRX01BWV9CQUNLTE9HLA0KKwlhaGFzaF9yZXF1ZXN0X3Nl
dF9jYWxsYmFjayhyZXEsIENSWVBUT19URk1fUkVRX01BWV9CQUNLTE9HLA0KIAkJCQkgICBzYWZl
eGNlbF9pbnZfY29tcGxldGUsICZyZXN1bHQpOw0KIA0KLQlhaGFzaF9yZXF1ZXN0X3NldF90Zm0o
JnJlcSwgX19jcnlwdG9fYWhhc2hfY2FzdCh0Zm0pKTsNCi0JY3R4ID0gY3J5cHRvX3RmbV9jdHgo
cmVxLmJhc2UudGZtKTsNCisJYWhhc2hfcmVxdWVzdF9zZXRfdGZtKHJlcSwgX19jcnlwdG9fYWhh
c2hfY2FzdCh0Zm0pKTsNCisJY3R4ID0gY3J5cHRvX3RmbV9jdHgocmVxLT5iYXNlLnRmbSk7DQog
CWN0eC0+YmFzZS5leGl0X2ludiA9IHRydWU7DQogCXJjdHgtPm5lZWRzX2ludiA9IHRydWU7DQog
DQogCXNwaW5fbG9ja19iaCgmcHJpdi0+cmluZ1tyaW5nXS5xdWV1ZV9sb2NrKTsNCi0JY3J5cHRv
X2VucXVldWVfcmVxdWVzdCgmcHJpdi0+cmluZ1tyaW5nXS5xdWV1ZSwgJnJlcS5iYXNlKTsNCisJ
Y3J5cHRvX2VucXVldWVfcmVxdWVzdCgmcHJpdi0+cmluZ1tyaW5nXS5xdWV1ZSwgJnJlcS0+YmFz
ZSk7DQogCXNwaW5fdW5sb2NrX2JoKCZwcml2LT5yaW5nW3JpbmddLnF1ZXVlX2xvY2spOw0KIA0K
IAlpZiAoIXByaXYtPnJpbmdbcmluZ10ubmVlZF9kZXF1ZXVlKQ0KLS0gDQoyLjExLjANCg==
