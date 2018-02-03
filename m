Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682427-2-1119295208822340553
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
    t=1517682426; b=DuNC+ieaxtMtGKP53xhpyHS58FpLF4cggBrLGN4f7qSPpFL
    XP02oGICgHZVQFPmLEINjjy39qhR/COS1XUmlD554miQ39gsp8ue5KXLJgjwO8Wz
    8g/GOV+qYg/o9p80ncPW7UKZ+J9iLaktb3HSS5xWb5/WKEzfAqvGCzV1+zQE3h30
    M+NICU4gwL0Xfj5XgYH1F1u85+F1r9no0Xhh6Id4GLtkFFijJL8KVzzcHfHG1na/
    +Wm/RMEgTHVL9jXqzLlyxrfjWkXIiy63LIAo/c0tFMf8LnNpYBM8GVWHOHy6WmtU
    qORlmo6lgqMmmrDvJj5xHE/J9W9AMZzNHCQUqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517682426; bh=VADV3jTTkpYQlvh0/TUtWxEb9i3R6bzHhLdOrV
    1In/I=; b=rTi5Ow6PzgY1TXY/ek4PVh0CMNUow3nW0lFbsqGQAlL7KqomHL/E0e
    4yhvWuGuZZWtHbAzeSHRluXKgKRCoLwAftbn6pwemtgQrSNqlv0jwSIuGuv5szti
    z43wdzHGycjLIN3qaT40Svp8PN1fF0xY6nb3BN+VzlyXsnRo4+BhwusRgE/i9KIe
    iHFbFsAqFLU/1gWXwM/NdAO+RNMcp+vjBY1I4pce9qcVadcvsf+W+JYJNnetYoYF
    dD56scwv0Oo3To3AtBpD16/Ok7OsOh/1o58uHdPlMH3HhiMW6+Hw1rNwCNyc6+1O
    v28IBDgAVj57qvKKZ6kW57zrCle2P93A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P9TwUzhr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P9TwUzhr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeBCSXn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:43 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753445AbeBCSGV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xiongwei Song <sxwjean@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 39/52] drm/ttm: check the return value of
 kzalloc
Thread-Topic: [PATCH AUTOSEL for 4.9 39/52] drm/ttm: check the return value of
 kzalloc
Thread-Index: AQHTnRlbGwoW4XoHVE2q4qVHkK38Bw==
Date: Sat, 3 Feb 2018 18:03:55 +0000
Message-ID: <20180203180303.8490-39-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:M8lhfajyAUdmDdMtmI2qsq43iH2Tf+Z+IiRpjOKvBX5LnJjJjwRdG6KTsTZr73jvJKp+y89iXwfuPMHYz1Zxbu0Iqi5pqGoWcZt1tf6nHPzuX23z7wuveMRi8SnSCs31y9DZMu72zu09MXLK/nxmnRRi55GmeOAsIsRK0gH61InfiW2BmVXXT71zPTlGFwVRDEL5xs+i5ciSHkgc3GOjupA+9Tg3NLNsSiBFcGw1ZaYeH892NTUMFOZeJKgBNMWY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da6e5e9d-7ff3-4254-4ed6-08d56b30a017
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101267988E4760C4E73DCE23FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(39060400002)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(8666007)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2QAyuAlCKlhBZs7ZTojvxvNAkJ+W38roxOumL1YVAD0HFQ2t+5dYaaAA7Hud/fSBSbYRBZFq9cboIW3i8/a5Xw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40C05E08E247E045BAA1403F265FE821@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e5e9d-7ff3-4254-4ed6-08d56b30a017
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:55.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
dHRtL3R0bV9wYWdlX2FsbG9jLmMNCmluZGV4IGRkZDZiYWRkMGVlZS4uYzc1NmIyYjdmNWRjIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMNCkBAIC04MTgsNiArODE4LDggQEAg
aW50IHR0bV9wYWdlX2FsbG9jX2luaXQoc3RydWN0IHR0bV9tZW1fZ2xvYmFsICpnbG9iLCB1bnNp
Z25lZCBtYXhfcGFnZXMpDQogCXByX2luZm8oIkluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvclxu
Iik7DQogDQogCV9tYW5hZ2VyID0ga3phbGxvYyhzaXplb2YoKl9tYW5hZ2VyKSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghX21hbmFnZXIpDQorCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJdHRtX3BhZ2Vf
cG9vbF9pbml0X2xvY2tlZCgmX21hbmFnZXItPndjX3Bvb2wsIEdGUF9ISUdIVVNFUiwgIndjIik7
DQogDQotLSANCjIuMTEuMA0K
