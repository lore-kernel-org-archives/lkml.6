Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520121036-2-14117300130032791813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121036; b=FmN23Qqoc4CVxySYB+ROyU4vLCwRc+Ao5NP5o50YFKndHAU
    npeqV6fKE1FPka2fINSfuakP6Il8hxSii6i2u/RztmoNM779nPLA+OajzF/bueAF
    unBGQnHW0n4cM71i+4At/RsSlbm+q9yeSevzIHw1U0DiY0d9pArdKY4wmCF5qszS
    5gvCf9NxFb5On9p+/eRvP6lrn9DwBYtKs3inR8wItNwCXxM2wv5264XcXL86wkUd
    VOkqorSmLWT4N7J7ffOJllt11vyQsqKUra/KdxREas4uY+tqSmCc6bYzYVe23nSK
    WTzqfxqCTJ/VSufUqImAXpnNJ1qmNiImwwUOTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520121036; bh=uZhHO++kvzoFTDfCSHbc7PFH7gSRB7TqOXLvzE
    zcCI8=; b=CI+XPSGWOr5HJP1R8WJXeu5IXgQ5E1Sdig3YJT8FCTwmjMt3sHJJLP
    mHI++NdMfYrYx+d39RoUW75L6vuN+p9KsEDtKt4GgFQjKq2pW9i74uVSf1w3JNPB
    u2I6OYK4C8cg9agTSOvETiptWyVZkaE20etFkLJVFR6xanivsLxTq8e1K8TSyIxj
    x6u3DUPWQXdKkuFzGHsBZB7ximbOd/ojNC10ewntdZLxKoxZD6/l1K204lLosCFu
    5TESdpMyX3/JgfUvKYpPWgbkYkCyNvO9OjBrVpwmZ7JuiQQDLBwo0Zw+NXy+Dwzv
    rbNdZZVw2n2T37RfIXvp/iywejAzWu5Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Io0n4CVk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Io0n4CVk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeCCWdW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:22 -0500
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:47151
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934014AbeCCWdT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?Tmljb2xhaSBIw6Robmxl?= <nicolai.haehnle@amd.com>,
        zhoucm1 <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 086/219] drm/ttm: never add BO that failed to
 validate to the LRU list
Thread-Topic: [PATCH AUTOSEL for 4.9 086/219] drm/ttm: never add BO that
 failed to validate to the LRU list
Thread-Index: AQHTsz7+JlqwZ5DZqkGVsCOubfQKTA==
Date: Sat, 3 Mar 2018 22:28:45 +0000
Message-ID: <20180303222716.26640-86-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:7VcRw+4fpWkVodzVP3QoG30ZNLdk/MFUuiwdSJm5/tQMRsdbpFDuS0XjxCmfqdSOzIZmQPaysPjyD0KZliZthVJXGk6ON17i3k7AHQ6OYh9ATvS5CYpYcqSNa/yHCEj68/4FyLr7rtMA02m4qdup4BFdwy+c64UdPOh+OxZppSmSv9+lC/i2XJJw+al9+KEYxjFHF2Z7967+V7bRVwAOVeFRNV4PqOh+MtJPTbfHqn+X5GoN2Ld3hIsYO2V1iEXI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5396215d-5c3a-4f11-9a66-08d58156c2e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10361AB23D71843BB2E7FA4FFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(8666007)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: dwix3A7GTwgCeHqBZxK6y1rtNxVv0O9g3rkhdlh6B7zP5QlooEHYIhBoGebtFYgzR5xLEYeYTsJknhSpbpehYIt9zxZmuKrbQfeoVLUNB4uMsQojf0PK7bXsstm5ETnAqwgNKwck/q7GWjmxRmZBbkMT80GiS73s+TcHdQnwrys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <098C10856C861B44B1F1C1DE9407BAD1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5396215d-5c3a-4f11-9a66-08d58156c2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:45.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTmljb2xhaSBIw6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4NCg0KWyBVcHN0
cmVhbSBjb21taXQgYzJjMTM5Y2Y0MzViMTg5MzkyMDQ4MDBmYTcyYzUzYTcyMDdiZGQ2OCBdDQoN
CkZpeGVzIGEgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9uIGluIGFtZGdwdSB0aGF0IGxvb2tzIGFz
IGZvbGxvd3M6DQoNClRhc2sgMTogYXR0ZW1wdCB0dG1fYm9faW5pdCwgYnV0IHR0bV9ib192YWxp
ZGF0ZSBmYWlscw0KVGFzayAxOiBhZGQgQk8gdG8gZ2xvYmFsIGxpc3QgYW55d2F5DQpUYXNrIDI6
IGdyYWJzIGhvbGQgb2YgdGhlIEJPLCB3YWl0cyBvbiBpdHMgcmVzZXJ2YXRpb24gbG9jaw0KVGFz
ayAxOiByZWxlYXNlcyBpdHMgcmVmZXJlbmNlIG9mIHRoZSBCTzsgbmV2ZXIgZ2l2ZXMgdXAgdGhl
DQogICAgICAgIHJlc2VydmF0aW9uIGxvY2sNCg0KVGhlIHBhdGNoICJkcm0vYW1kZ3B1OiBmaXgg
YSBwb3RlbnRpYWwgZGVhZGxvY2sgaW4NCmFtZGdwdV9ib19jcmVhdGVfcmVzdHJpY3RlZCgpIiBh
dHRlbXB0cyB0byBmaXggdGhhdCBieSByZWxlYXNpbmcNCnRoZSByZXNlcnZhdGlvbiBsb2NrIGlu
IGFtZGdwdSBjb2RlOyB1bmZvcnR1bmF0ZWx5LCBpdCBpbnRyb2R1Y2VzDQphIHVzZS1hZnRlci1m
cmVlIHdoZW4gdGhpcyByYWNlIF9kb2Vzbid0XyBoYXBwZW4uDQoNClRoaXMgcGF0Y2ggc2hvdWxk
IGZpeCB0aGUgcmFjZSBwcm9wZXJseSBieSBuZXZlciBhZGRpbmcgdGhlIEJPDQp0byB0aGUgZ2xv
YmFsIGxpc3QgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpDYzogemhvdWNtMSA8ZGF2aWQxLnpob3VA
YW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IE5pY29sYWkgSMOkaG5sZSA8bmljb2xhaS5oYWVobmxl
QGFtZC5jb20+DQpUZXN0ZWQtYnk6IFNhbXVlbCBQaXRvaXNldCA8c2FtdWVsLnBpdG9pc2V0QGdt
YWlsLmNvbT4NClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1p
Y3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgMTIgKysr
KysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgYi9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9iby5jDQppbmRleCBkMDkyNzZlYzdlOTAuLjUyYTJhMWE3NTY4MiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX2JvLmMNCkBAIC0xMjA5LDE4ICsxMjA5LDIwIEBAIGludCB0dG1fYm9f
aW5pdChzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwNCiAJaWYgKGxpa2VseSghcmV0KSkNCiAJ
CXJldCA9IHR0bV9ib192YWxpZGF0ZShibywgcGxhY2VtZW50LCBpbnRlcnJ1cHRpYmxlLCBmYWxz
ZSk7DQogDQotCWlmICghcmVzdikgew0KKwlpZiAoIXJlc3YpDQogCQl0dG1fYm9fdW5yZXNlcnZl
KGJvKTsNCiANCi0JfSBlbHNlIGlmICghKGJvLT5tZW0ucGxhY2VtZW50ICYgVFRNX1BMX0ZMQUdf
Tk9fRVZJQ1QpKSB7DQorCWlmICh1bmxpa2VseShyZXQpKSB7DQorCQl0dG1fYm9fdW5yZWYoJmJv
KTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCisJaWYgKHJlc3YgJiYgIShiby0+bWVtLnBsYWNl
bWVudCAmIFRUTV9QTF9GTEFHX05PX0VWSUNUKSkgew0KIAkJc3Bpbl9sb2NrKCZiby0+Z2xvYi0+
bHJ1X2xvY2spOw0KIAkJdHRtX2JvX2FkZF90b19scnUoYm8pOw0KIAkJc3Bpbl91bmxvY2soJmJv
LT5nbG9iLT5scnVfbG9jayk7DQogCX0NCiANCi0JaWYgKHVubGlrZWx5KHJldCkpDQotCQl0dG1f
Ym9fdW5yZWYoJmJvKTsNCi0NCiAJcmV0dXJuIHJldDsNCiB9DQogRVhQT1JUX1NZTUJPTCh0dG1f
Ym9faW5pdCk7DQotLSANCjIuMTQuMQ0K
