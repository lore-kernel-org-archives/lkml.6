Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124349-2-71088708907130230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124349; b=aGdHg/QgJcQTf73MBq+jcHeIIYrthZcIC1JVfChOUicJhW1
    PThYmBBIs0skahjBoyUynMnHwhyEeiUuiW0jD7et19KPpS/ukzoYSQOIrVCvULek
    jn3tBnA2QimU91McakEHiAfK8S9DQHvfSA4TnjWpGKmXsw3KHYL0vL/i5tjkkolE
    u+qc7wcvGSlC38B6sBd2229VcbyPCaibjWKkFXPoyIi/z23NSQJyqCYT/4cHlHp0
    IJ6Tg0I7So/lvO1VbZ1HPK42uQAtOOnsMI0GbveKeDWFb5d4fCgihii9doRVB69m
    UGLnCBzC2E6PVkxlPXfWouFOr0FUQn0KRRzi+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124349; bh=S8mp8CnXZV6B4zUV+MBebHErUez4QlMjFxtDJt
    yVz/Q=; b=aRcKkVt0o3CMxcb2q/O7PW9j3MyOCpRlvHy4i3zzqgOelCUMqsQvg5
    ESqBaUSuMlSq9frL6jzjY1D3Q/TZ83+FJf32ffJvTnAKhH2DaVfmofBwFHOESuyQ
    qqj7faoHVSqHt0OArUf/4OjWv0V+GXME63ASXNLWu0F0jNJoz2wgQIGKO8drxlpm
    Vf3Tqf/GkNWPNsUE/rNuLCSGSAOm4EwczGxGTCpYhmwoPcMqpgp0K6n8LEJdr+WE
    ESl0L2LRAKwNou27M3vEYDIvD+fDDxRx6nwZZGS2fixr45SOfBg3HEjrW7PyAH3A
    doSTUUIeNmYgeTJTyxy8ojzc+giqFZXw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=edHbWKj3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=edHbWKj3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeCCWZZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:25:25 -0500
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:13182
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbeCCWZX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Keith Packard <keithp@keithp.com>,
        Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 027/102] drm/vblank: Fix vblank timestamp
 debugs
Thread-Topic: [PATCH AUTOSEL for 4.15 027/102] drm/vblank: Fix vblank
 timestamp debugs
Thread-Index: AQHTsz5iwVLpeW0YGkmICD0C8oMRGA==
Date: Sat, 3 Mar 2018 22:24:25 +0000
Message-ID: <20180303222318.26006-27-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:zkU2f4Kph9PUbmQZkj/R/t7dpqiNK0e9S0pZDQqMVQlkq9SCJLB+IJjbJ651gnSJhwmel9aPOkVnEhcVEIjz0C20kk15wjrd5Qi1EyND8TZWMk7cVe5VCEQ3nQqcet9GewBoaHwzQMjEtWhP/tj7WnwEHNixOEGwcwRz2qUVLY7T5WbUDt0H96Qa7SPVt/qk2hVs3GJklr0fSncJ7fTYGcxScrhazxSfaaDiRiLeteu/gNWy8uVAN6eUvnE+wG9P
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebf22e11-ad6d-405d-a1f4-08d581559400
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353FB0D67A69FBE2B00F6D9FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(966005)(8676002)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(6306002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jFNQJlptw5pqbK3SJNIOHJcJFY3110fOm5Sdx1siBw+9IImlZKtdqCuGsGR1nyv7IeMKZsGt8tTNr36vlL9nI/sNUJTdqrAQJmuQ7NjGYXpElMdA9veUsdUGTmtGldZO/tqyrGAFdF7bBbVOj/yk28d31Rmwn+L9U26qKcjEk2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D767CB498A34414DAC00AEA09365B566@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf22e11-ad6d-405d-a1f4-08d581559400
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:25.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4NCg0K
WyBVcHN0cmVhbSBjb21taXQgYmNiZWMzMWNlNTAwZmUwMzZmNzVhMTliY2E1YzczYmZhNmRkNDIw
YiBdDQoNCldlJ3JlIGN1cnJlbnRseSBjYWxsaW5nIGt0aW1lX3RvX3RpbWVzcGVjNjQoKSBvbiBz
dGFjayBnYXJiYWdlDQpoZW5jZSB0aGUgZGVidWcgb3V0cHV0IGZvciB2YmxhbmsgdGltZXN0YW1w
cyBhbHNvIGNvbnRhaW5zIGdhcmJhZ2UuDQpMZXQncyBhc3Npbmcgc29tZXRoaW5nIHRvIHRoZSBr
dGltZV90IGZpcnN0IGJlZm9yZSB3ZSBnbyBjb252ZXJ0aW5nDQppdCB0byBhIHRpbWVzcGVjLg0K
DQpXaGlsZSBhdCBpdCBtaWNyby1vcHRpbWl6ZSB0aGUga3RpbWVfdG9fdGltZXNwZWM2NCgpIGNh
bGxzIGF3YXkNCndoZW4gdmJsYW5rIGRlYnVnZ2luZyBpc24ndCBlbmFibGVkLg0KDQpGaXhlczog
Njc2ODBkM2MwNDY0ICgiZHJtOiB2Ymxhbms6IHVzZSBrdGltZV90IGluc3RlYWQgb2YgdGltZXZh
bCIpDQpDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCkNjOiBLZWl0aCBQYWNrYXJk
IDxrZWl0aHBAa2VpdGhwLmNvbT4NCkNjOiBTZWFuIFBhdWwgPHNlYW5wYXVsQGNocm9taXVtLm9y
Zz4NCkNjOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTog
VmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4NCkxpbms6IGh0
dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC9tc2dpZC8yMDE3MTExMzE1MDIx
MC4xMTMxMS0xLXZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tDQpBY2tlZC1ieTogQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4
YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fdmJs
YW5rLmMgfCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV92Ymxh
bmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMNCmluZGV4IDM3MTdiM2RmMzRhNC4u
MzJkOWJjZjViZTdmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYw0KQEAgLTY2MywxNCArNjYzLDE2IEBA
IGJvb2wgZHJtX2NhbGNfdmJsdGltZXN0YW1wX2Zyb21fc2Nhbm91dHBvcyhzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LA0KIAlkZWx0YV9ucyA9IGRpdl9zNjQoMTAwMDAwMExMICogKHZwb3MgKiBtb2Rl
LT5jcnRjX2h0b3RhbCArIGhwb3MpLA0KIAkJCSAgIG1vZGUtPmNydGNfY2xvY2spOw0KIA0KLQkv
KiBzYXZlIHRoaXMgb25seSBmb3IgZGVidWdnaW5nIHB1cnBvc2VzICovDQotCXRzX2V0aW1lID0g
a3RpbWVfdG9fdGltZXNwZWM2NChldGltZSk7DQotCXRzX3ZibGFua190aW1lID0ga3RpbWVfdG9f
dGltZXNwZWM2NCgqdmJsYW5rX3RpbWUpOw0KIAkvKiBTdWJ0cmFjdCB0aW1lIGRlbHRhIGZyb20g
cmF3IHRpbWVzdGFtcCB0byBnZXQgZmluYWwNCiAJICogdmJsYW5rX3RpbWUgdGltZXN0YW1wIGZv
ciBlbmQgb2YgdmJsYW5rLg0KIAkgKi8NCi0JZXRpbWUgPSBrdGltZV9zdWJfbnMoZXRpbWUsIGRl
bHRhX25zKTsNCi0JKnZibGFua190aW1lID0gZXRpbWU7DQorCSp2YmxhbmtfdGltZSA9IGt0aW1l
X3N1Yl9ucyhldGltZSwgZGVsdGFfbnMpOw0KKw0KKwlpZiAoKGRybV9kZWJ1ZyAmIERSTV9VVF9W
QkwpID09IDApDQorCQlyZXR1cm4gdHJ1ZTsNCisNCisJdHNfZXRpbWUgPSBrdGltZV90b190aW1l
c3BlYzY0KGV0aW1lKTsNCisJdHNfdmJsYW5rX3RpbWUgPSBrdGltZV90b190aW1lc3BlYzY0KCp2
YmxhbmtfdGltZSk7DQogDQogCURSTV9ERUJVR19WQkwoImNydGMgJXUgOiB2IHAoJWQsJWQpQCAl
bGxkLiUwNmxkIC0+ICVsbGQuJTA2bGQgW2UgJWQgdXMsICVkIHJlcF1cbiIsDQogCQkgICAgICBw
aXBlLCBocG9zLCB2cG9zLA0KLS0gDQoyLjE0LjENCg==
