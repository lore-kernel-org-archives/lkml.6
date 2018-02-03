Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683539-2-5614379824727808765
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
    t=1517683538; b=QYwwdrtrGmIdWvx0z9uw07lsMS7HKbwitlEY8M17wnbMTf2
    iowba0lWdDdVr4cfdqeKONPCfJqYvEbcLT26hWN0Qsc49Ost1ttYEQ0rq5G4G6uO
    ona7J1JZNEBhTGJiGp54FusrC++eJkQKuUKXB+kYpQfmfzNpGdi0jskbLxUNtp0e
    rYZb/VMsphwba4q12ct1bps1FHKHMe2bOXa0pDZKBwElWBYRy44QVu+iiSQeEKbJ
    ut3KWyQ4R6uGoz9TM66Hv8HyO2X7vXEZRTtYQk92TtIcLYD82QwEKqT5Czhfi1Od
    QsoeIdYp4JtLKL7mohhMPKOplruJ9zolmMh2IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517683538; bh=/q/BxG44+aHsqghHTyw/htg3jPJC10PnQuNuCf
    zGdMs=; b=A3V+QipgzD4SAwyRjjd32mVvCqtQzT0Y2GmYYji0k7qmzG933BFRDP
    cZxrdeUBVntjzHwKK1/O0TEapQ+3qbRywTEnbT2WMf8Bw4s1+T2jjNGItdm6Gv+m
    6jiH+k/dSeai7l9PkOk2/u/1pg41EqfXkxenOO6N8zJDwO11bsZ2Xw4YETYls61G
    PTrtxA11AzR+UIqJlziFaxyz9oI1ZIts15lPP0Zwd2dLucK8LoEXgE5N6oY7W5NJ
    lrfw85JWQq3Rk0epcZoSpgSckfY0JgDcufKF3/nZpL3dHvvIuRWpVSGrEbQ1PdbM
    IkHhOQwQDHYx2jTWZxy2a8ayM1CTuqBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PfiBMUWj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PfiBMUWj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbeBCSpg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:36 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753064AbeBCSCl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xiongwei Song <sxwjean@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 080/110] drm/ttm: check the return value of
 kzalloc
Thread-Topic: [PATCH AUTOSEL for 4.14 080/110] drm/ttm: check the return value
 of kzalloc
Thread-Index: AQHTnRj+oPnDhnINe0iGKn32iPa+LQ==
Date: Sat, 3 Feb 2018 18:01:20 +0000
Message-ID: <20180203180015.29073-80-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:9P3fjf9f2z350rXWD1I0XMMphjoiDjqCV+/vcW+UJYFcGvjnLrFApPlxgliA0U/tZNpuZTDkyZM8M2V/4rjhkL4f2da5b4/EDtr29+InyeFP3zw+ExF+Ctvt0J9VlMk5I29Bnjw3JqFnCME/H4I9/ZBKWg7C9owAdAHR35EMIYQEyjs2+ZyAtj0J1jGqptv50yusUzv5fvqEjy2TDqVXpVZMHwyD36yu18qG9W1Uouj/YXTS7FhKkRBMVvc0eO5z
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dd97f5d-33e2-4826-81af-08d56b303fc8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10417EF53B20613A2E6F03BBFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(39060400002)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(8666007)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: GqaDYbI90LLmmFNrq2ged4EGtjFyrtZAIeF7k8RsPEgQsm9M0jO+E4ijlvMssSbZooRnqivWgaydJyu8yCghBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0B41BAA0040C44AB2101BC929B43B0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd97f5d-33e2-4826-81af-08d56b303fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:20.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
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
dHRtL3R0bV9wYWdlX2FsbG9jLmMNCmluZGV4IDg3MTU5OTgyNjc3My4uOTFmOTI2M2YzYzNiIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMNCkBAIC04MjEsNiArODIxLDggQEAg
aW50IHR0bV9wYWdlX2FsbG9jX2luaXQoc3RydWN0IHR0bV9tZW1fZ2xvYmFsICpnbG9iLCB1bnNp
Z25lZCBtYXhfcGFnZXMpDQogCXByX2luZm8oIkluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvclxu
Iik7DQogDQogCV9tYW5hZ2VyID0ga3phbGxvYyhzaXplb2YoKl9tYW5hZ2VyKSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghX21hbmFnZXIpDQorCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJdHRtX3BhZ2Vf
cG9vbF9pbml0X2xvY2tlZCgmX21hbmFnZXItPndjX3Bvb2wsIEdGUF9ISUdIVVNFUiwgIndjIik7
DQogDQotLSANCjIuMTEuMA0K
