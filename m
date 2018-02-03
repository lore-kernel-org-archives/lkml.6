Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682049-2-1988059533023297207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682048; b=hipJU0pYkx3C9MGEXo0zzH0YwzaOcUbf9GPrBVoUvzytvb4
    ANiVzD0iSvzFEdir59zDfch4a9x0lmQLtXkii5owuIvst7eHUOOFs3465wmOLCjw
    q1nm7B6Y9tWxmU/aAzNcw5FHHIwI6/dr2AF5zxR86UqZUywK87NdXLHPNMN/HkSY
    LHK564R1Ohqq6+zc24KeuxwDGNTG/mik8elPCAmS30UQ2LHU+HMat3xvV8vSoVIU
    oCUrSZ3NeQddeAC6tOGv7nGNX1wDrTi5n0rIqhHnfvGHZ1CPPtcdpn8BH40VwsEQ
    dvj5gJRz8A4AQZVHMBy82JQqqDuZxv7VQFGDChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517682048; bh=EbZXzwB2Rpn7hdPJUwDAQ/Ys8xk7KTyozdvMnH
    hmQgs=; b=uCk0WHBXQkOirnDfC6JVatdfc7H39FpLIGgH9AkPbOzDKV0/NghgWd
    UPqdS1ND3ZOY0sN9tHbt8K5tGolPJ2QLYtUAmGGw6waXJEXUCqlwvtKU4VAuqpPX
    WMdfgIR6ZljAvjR51wghytDvPZjEUItN2uldRCYkKxlKq1R+lbi/ub/ZKR2D53FF
    gG4zBDmcqb1pXn0iqoOQQyzfKJsOlQzIcLYUutAdxzvsQKv0Ptgskpy1yKOAWFB8
    0+GB902FXdMc6cZsCIVEJF28FtMhkGmg+5sFMK5KlCXmLHloMGqRpnkh4yoF1/T4
    RTGqnFYwCKRq3U3JkQOrZ/YZ0ZQfJKZA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BNDPzU19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BNDPzU19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbeBCSUk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:40 -0500
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:45036
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753002AbeBCSGe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xiongwei Song <sxwjean@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 22/32] drm/ttm: check the return value of
 kzalloc
Thread-Topic: [PATCH AUTOSEL for 4.4 22/32] drm/ttm: check the return value of
 kzalloc
Thread-Index: AQHTnRlzAkTEsswwak2zhXe/KFdIQw==
Date: Sat, 3 Feb 2018 18:04:36 +0000
Message-ID: <20180203180413.7438-22-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:CMuVp11AKFO3g/Lm2waI8Elqb5onZazlsReXJCGCXVTVhds4rWXCm1kqxsJG/pWGDGocSfU01EW5+mNgB1zR8KZKR1CfspLESLh32rUtOM/FTM12rHPsd3hM1ZfsqN7fZPIkGrH7hKSWCA7KQOtrRfZPOa00cecYzJo9zjwy5Pn83z4Wgvh+AmJBjTXJ4mIYbaPAMuOZQ7ClAEExYrPf53EI0aP1AthE7/vRBEciCKKRGiUMjs1EBQ8zhOmdm3zk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a38fbc9f-8ba2-4246-3379-08d56b30c59d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB100958FD696FD8EB5CC19B62FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(39060400002)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(8666007)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: WGtG0aJ9dg6Y30V9xYDDlRrOlgb9IPm4NDSJHjcjgquBCUDYhS3LWLC7xZEghDBka8ojV4ztz4ujv3txU0Qr3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ABF4CA53CA35844A059B0FD97F272EB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38fbc9f-8ba2-4246-3379-08d56b30c59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:36.0339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogWGlvbmd3ZWkgU29uZyA8c3h3amVhbkBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDE5ZDg1OWE3MjA1YmM1OWZmYzM4MzAzZWIyNWFlMzk0ZjYxZDIxZGMgXQ0KDQpJbiB0aGUg
ZnVuY3Rpb24gdHRtX3BhZ2VfYWxsb2NfaW5pdCwga3phbGxvYyBjYWxsIGlzIG1hZGUgZm9yIHZh
cmlhYmxlDQpfbWFuYWdlciwgd2UgbmVlZCB0byBjaGVjayBpdHMgcmV0dXJuIHZhbHVlLCBpdCBt
YXkgcmV0dXJuIE5VTEwuDQoNClNpZ25lZC1vZmYtYnk6IFhpb25nd2VpIFNvbmcgPHN4d2plYW5A
Z21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5A
bWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
YyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9wYWdlX2FsbG9jLmMNCmluZGV4IDVkOGRmZTAyN2IzMC4uNzVkNTFlYzk4ZTA2IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMNCkBAIC04MTgsNiArODE4LDggQEAg
aW50IHR0bV9wYWdlX2FsbG9jX2luaXQoc3RydWN0IHR0bV9tZW1fZ2xvYmFsICpnbG9iLCB1bnNp
Z25lZCBtYXhfcGFnZXMpDQogCXByX2luZm8oIkluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvclxu
Iik7DQogDQogCV9tYW5hZ2VyID0ga3phbGxvYyhzaXplb2YoKl9tYW5hZ2VyKSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghX21hbmFnZXIpDQorCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJdHRtX3BhZ2Vf
cG9vbF9pbml0X2xvY2tlZCgmX21hbmFnZXItPndjX3Bvb2wsIEdGUF9ISUdIVVNFUiwgIndjIik7
DQogDQotLSANCjIuMTEuMA0K
