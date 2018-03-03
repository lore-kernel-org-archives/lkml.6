Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120280-2-5318123921261874450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120280; b=KkYJ++64bVHuGMoniV8ldeW2ZaRvDXLCNx4KNJJVppTgY1N
    ZzDaUHQtTNHKouGOWLDEOee4y2Kty8TUQQ8ojJ5FNLl1CaebjUjPDsXzSxIPd5cr
    vfwuarGcNLlKcgZ7X358zui6LG5DOenh2KiGSwEwu/9L5U4RHCJR8EUksFa07U26
    Q2CmhZosqtKxh8dPGXiVn2wiIRv6PhK7AAJz7MsYcX3mUhfwfUKTIODfQPNhFhHp
    3B65+w1BvsgUCN74W4Ucq/aqAYIbIryQYGzIeo9hFFfI1b6vK6Qo6Q28ap5+pXlG
    HgnJV9JghGsfj7Dpg5tEfM5ATdI4D73dPa9Szpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120280; bh=hUKCincDlG1qxFj07X4Nl+KFR1zXLSjFrIixhC
    yBrJM=; b=weXdFQsoDT6I5PJVRVlBPE2T9Hvw9NkAOfdWGvn6709q8mYPxe32Tt
    wKwjR2aFt6nvNK6oK2nN/Nf+L/xx/wK1OLPdjFxXiIisTfz0fUT7u1x9kqktfkwX
    IqR4wiuYvuGdA7gjzMHEQjpk2kV7cjN/k5ElRn0oGWIrP+nJ08eRmERzSQM8Wfo5
    pw1vrTAla36W0shAtGCQqNu/ORrVQ2XCuxe3/IyoWXm62AGipjrPrbQx5v+qkoED
    1yozyUUHZK6fDmbNATnaGz6ssXgEtq6h2KJ08eEe8KYRh6hvbL1Z9Hh/e7l/4Qp3
    v0Vd+ekJ6c0r0+mnVWLVhhTTXolQiFog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UADWBZ9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UADWBZ9F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeCCWfO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:14 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934326AbeCCWfI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 142/219] regulator: isl9305: fix array size
Thread-Topic: [PATCH AUTOSEL for 4.9 142/219] regulator: isl9305: fix array
 size
Thread-Index: AQHTsz8RaZVAYnXfJUSYhE4JXHRZAw==
Date: Sat, 3 Mar 2018 22:29:18 +0000
Message-ID: <20180303222716.26640-142-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:O0/NXktM5Mf39LRbViMZ5C4txYOsdjOi8in5NfUxai/UXajG49PLds9o6scbSKvHIJfpu+TvCJdwFSKEFo2QCLgeTtf4HdMkOeEpoxguIu6FUbrLrvsyvahdBzKq0Xp7wCp08QVmL8vY5M5U8I7DsMdLGZNe5frmuWlVlf0n0WzUvxpjU2KT+ITdT3tu/rsQyU45nLw5zAQKEggxCyBHACuQhYqtjyQxvVOBpnAFIMARv3KpzhlnT88J0nav0XoGrQNzWuOL8acLZxa+lLVUOWcjAr6M4KoUhHyG20WDicFVaLm5EjaWDsrL+568QrMJl0m17pdbgm5PB/hcQ5J0emuA4/zmwFnmVfP+17xuo/E=;5:TfCTJJpaklreAh/7yHhfVef4AQe3roLSkGdZR4RXL0QIh4iyjcC2Q65ZUmMZng9s5H+piLn6mL2Dpnegfr+fKzVf2hCtJU0c5KDcB+s1dvFOCxU6dun4o6IbNpjT060krm72AhJiCUnjk1fjeNX0J4aS4zq+38bIwAh4otTh+c8=;24:7/WYtAK1s9mo1D16hK+6YWuDsB8ajQPiaTNmpJrvA8UmIAD9QyQffbfzdXuE7Md314YGkPRWKGRd7jgJgpS2JKbaWCz8heTZr6xL0R21VFw=;7:1nwUgxn/i6Ao1GLAtrBDYnnie7C12Yx3h/QzgDU/JX9utKtaHOOAnWOWGZazw3wnyw/3uA1WhaCwPBPLUUuU6Evw6Iyuyhe2aRM6ruz98/H5XKgILhZ9iabHFq4aZe5NPPqe/I3GNr+xT+uGBxXdZhfRnBk6Lp3B49HGiajOmmuO1BqfOuvdPUjqQlHTZQWQdKYs+qAF9J3RiXB3rLZBENaI8oG7oxo0p0dpYqEEP5vtkHOrliZ8HBaiFQ7dn5N8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca01b916-f8aa-47f3-0495-08d58156fe48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924808D323095CA2125AFE0FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(184751874519063)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(8656006)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="utf-8"
Content-ID: <106E71785E06474DA9AA70F23752EDF2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca01b916-f8aa-47f3-0495-08d58156fe48
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:19.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBsYXBvc3RlLm5ldD4NCg0KWyBV
cHN0cmVhbSBjb21taXQgMGMwOGFhZjg3MzE3NGM5NWU2NzRjZjIxZmZjZDA0MWM1ODlkMmU1YiBd
DQoNCklTTDkzMDVfTUFYX1JFR1VMQVRPUiBpcyB0aGUgbGFzdCBpbmRleCB1c2VkIHRvIGFjY2Vz
cyB0aGUgaW5pdF9kYXRhW10NCmFycmF5LCBzbyB3ZSBuZWVkIHRvIGFkZCBvbmUgdG8gdGhpcyBs
YXN0IGluZGV4IHRvIG9idGFpbiB0aGUgbmVjZXNzYXJ5DQphcnJheSBzaXplLg0KDQpUaGlzIGZp
eGVzIHRoZSBmb2xsb3dpbmcgc21hdGNoIGVycm9yOg0KDQogIGRyaXZlcnMvcmVndWxhdG9yL2lz
bDkzMDUuYzoxNjAgaXNsOTMwNV9pMmNfcHJvYmUoKSBlcnJvcjogYnVmZmVyIG92ZXJmbG93ICdw
ZGF0YS0+aW5pdF9kYXRhJyAzIDw9IDMNCg0KRml4ZXM6IGRlYzM4YjVjZTZhOWVkYjQgKCJyZWd1
bGF0b3I6IGlzbDkzMDU6IEFkZCBJbnRlcnNpbCBJU0w5MzA1L0ggZHJpdmVyIikNClNpZ25lZC1v
ZmYtYnk6IFZpbmNlbnQgU3RlaGzDqSA8dmluY2VudC5zdGVobGVAbGFwb3N0ZS5uZXQ+DQpDYzog
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogTWFyayBCcm93
biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhh
bmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL2lzbDkzMDUuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaXNsOTMwNS5oDQppbmRleCAx
NDE5MTMzZmE2OWUuLjRhYzFhMDcwYWYwYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9pc2w5MzA1LmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmgNCkBAIC0yNCw3ICsyNCw3IEBADQogc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGE7
DQogDQogc3RydWN0IGlzbDkzMDVfcGRhdGEgew0KLQlzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0
YSAqaW5pdF9kYXRhW0lTTDkzMDVfTUFYX1JFR1VMQVRPUl07DQorCXN0cnVjdCByZWd1bGF0b3Jf
aW5pdF9kYXRhICppbml0X2RhdGFbSVNMOTMwNV9NQVhfUkVHVUxBVE9SICsgMV07DQogfTsNCiAN
CiAjZW5kaWYNCi0tIA0KMi4xNC4xDQo=
