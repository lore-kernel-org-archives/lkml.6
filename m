Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682916-2-18285294358593974032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682915; b=mjBsb6q1tvKzM6qZoNxwEHRVIDbCsQT6TF5+6vz42sOfDID
    sxY3+HoayI/szGSOLCUvyi452EzKZWa4WQPK0/7v/OyYZlFw5RGyvrCeS8dpzlC5
    vqgES5NEp5WGBr/xymsYH/TeOtpklEBshSuELDrrpXjBo4gAmpVsKxHFEP5tazUb
    JWu0CgiZQ4WIjk6D9dJhhi1y8BWGeMh0K9cs1rxWXPfP7CC4agleQ3HHIrib5JC/
    4GM0bfT0R6kmRHPrxmjB5rFnLkrkrCf8UnK/VgCojKBhEgITNg4oimYivn0Nq8Tr
    yLq3GBLmAhhv9BtlKeZBmDl54EyFkchEm1ieF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517682915; bh=z1eSnjsIinE6Ss0lI81NI2l+8vYkSJhDBrH/E5
    laIxc=; b=U5l01pJ2QyZ7po0ovmJILsYGuWWp0PNZ/oibh4MoirpbL4CqjpX6rn
    McnvrQy36dLac3BzmtzAl+t+CoSqD15aZj2Bqs0+h1uj+M+0BMrBn/DKifJfg5BJ
    lUzDP3Obut1qYHJ+41QCxUF86bslKjvsjyZd8VlpadM8hgtFF7fFHQNpsLsJncJw
    4t8sll3G3m+h+1IHsv66loH9jsVMb3UiK9wALsAt3DZA+mPHf1D7oyTChJ/RLihZ
    NFKDEOxxdGt96Jyf/kJayoxJvRV9mMIY9L6J2DuZLuzLbKM17ipgeYJA7SFcyFZE
    y+uQj2zKUjQR9/Lf4gVQdasfJE+MlJkw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJkWKKhE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJkWKKhE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeBCSfK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:10 -0500
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:34880
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752567AbeBCSDz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QW50b2luZSBUw6luYXJ0?=
        <antoine.tenart@free-electrons.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 056/110] crypto: inside-secure - free
 requests even if their handling failed
Thread-Topic: [PATCH AUTOSEL for 4.14 056/110] crypto: inside-secure - free
 requests even if their handling failed
Thread-Index: AQHTnRjvqqL7yWFZAECE/9WvRsU8+g==
Date: Sat, 3 Feb 2018 18:00:55 +0000
Message-ID: <20180203180015.29073-56-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:x7vPbY4LO/NNFh7Ym+hmCDtiTSG5kNMCKYCAp9LuxWhkPUStLd8Z0jSTSBbxLVwAu9lVF6HTcKxRvOwVEoEc4IIekuCibR7K2D0wZYgQmyfxC/giWpocqz4hx3ewGR4hvy2wXskmuGQVveUjNtTqNvJ0xeVeLUKcbIERNcDQ+nnOCkoFvhJpFa6AUKzw6+jkFzcWnucD9joKE50za5athmzzrJPReKqGe3bc6QkOBFO3vtsQ2IGgjwuvFLTtqdjvJjtdBSjYDESd3WFFGofkUYVfuJhV23kTXkRuXLOhOLpGlcmx6c+os/aSpMudp+zED03Em5h+MokRarxtdrKAaYV261wYwXa86kGFyPsQZCfC652mP4XU3OGpEOfO9iCR;5:9afi0gPgPesSPQb+Qdh1qxqeYuGG+gTquYJLV4MVl6MDNVfsXP73A3vCxVRwe8ytHyp1hazMgz3wBB/tlSbdEztUMgQwQRsQtD77+J0GMABrArIxKnY/+zxE9VfJmPbcA/KXo1GYCy9pJ7tQekfcEWD4RrmRT6trJ/F09Hx5Ygg=;24:1E/eWKKBzGnJlbz7VSHgDVd0FEg6JZbQJTDr+d442grVd4VSwzScL4B90dfqmpGg7oZ9fO3c9c0xbOuUbpw1Igbvo1YZMoLqk9To3Qdg2Eg=;7:cCvHWyjlEpCJjCueRa1FSt5M+voZB+4CwDAlDWwbmSdWM+Tsd9Hg2K7eLlIFi+XMIQk+w825cQhxTn9lVUuxp5snpAK9jzW3VRH0M4DGS6Tb9MV0Yy27SKL3rqV5Nkmj4EYLKxG22fyXV5hwJucOHRC0tsuVc4ask6irTdAd9KmyU3rny1w/OfqQ3TjrSJHjQwaw+2wmP5M79kLMHo7o7UcZQXpm/YedUi6QMikCAOILsm0K7MnjkR7w3g0Z5+oM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41f2d986-7854-4ee7-c186-08d56b302728
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092A76752F370DB3DEB1330FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jfWf2zbwjjRMkucBNQscCC3o+o43pyPG+o8y3RYuiXLdEVVQTLSxaBfwrtVW904PsE8UYUUuvqcm/sgrBt8ijw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <917B9F7345490A41A95A35A7B415A12D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2d986-7854-4ee7-c186-08d56b302728
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:55.4878
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
DQoNClsgVXBzdHJlYW0gY29tbWl0IDBhMDJkY2NhMTI2MjgwNTk1OTUwZjNlYTgwOWY3N2M5Y2Iw
YTIzNWMgXQ0KDQpUaGlzIHBhdGNoIGZyZWVzIHRoZSByZXF1ZXN0IHByaXZhdGUgZGF0YSBldmVu
IGlmIGl0cyBoYW5kbGluZyBmYWlsZWQsDQphcyBpdCB3b3VsZCBuZXZlciBiZSBmcmVlZCBvdGhl
cndpc2UuDQoNCkZpeGVzOiAxYjQ0YzVhNjBjMTMgKCJjcnlwdG86IGluc2lkZS1zZWN1cmUgLSBh
ZGQgU2FmZVhjZWwgRUlQMTk3IGNyeXB0byBlbmdpbmUgZHJpdmVyIikNClN1Z2dlc3RlZC1ieTog
T2ZlciBIZWlmZXR6IDxvZmVyaEBtYXJ2ZWxsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFudG9pbmUg
VGVuYXJ0IDxhbnRvaW5lLnRlbmFydEBmcmVlLWVsZWN0cm9ucy5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+DQpTaWduZWQtb2ZmLWJ5
OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2
ZXJzL2NyeXB0by9pbnNpZGUtc2VjdXJlL3NhZmV4Y2VsLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2luc2lkZS1z
ZWN1cmUvc2FmZXhjZWwuYyBiL2RyaXZlcnMvY3J5cHRvL2luc2lkZS1zZWN1cmUvc2FmZXhjZWwu
Yw0KaW5kZXggODliYTllODVjMGYzLi40YmNlZjc4YTA4YWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2NyeXB0by9pbnNpZGUtc2VjdXJlL3NhZmV4Y2VsLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2lu
c2lkZS1zZWN1cmUvc2FmZXhjZWwuYw0KQEAgLTYwNyw2ICs2MDcsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgc2FmZXhjZWxfaGFuZGxlX3Jlc3VsdF9kZXNjcmlwdG9yKHN0cnVjdCBzYWZleGNlbF9j
cnlwdG9fcHJpdg0KIAkJbmRlc2MgPSBjdHgtPmhhbmRsZV9yZXN1bHQocHJpdiwgcmluZywgc3Jl
cS0+cmVxLA0KIAkJCQkJICAgJnNob3VsZF9jb21wbGV0ZSwgJnJldCk7DQogCQlpZiAobmRlc2Mg
PCAwKSB7DQorCQkJa2ZyZWUoc3JlcSk7DQogCQkJZGV2X2Vycihwcml2LT5kZXYsICJmYWlsZWQg
dG8gaGFuZGxlIHJlc3VsdCAoJWQpIiwgbmRlc2MpOw0KIAkJCXJldHVybjsNCiAJCX0NCi0tIA0K
Mi4xMS4wDQo=
