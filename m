Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488828-2-17990473829572461495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488828; b=caSHLSjhM8ZHyaUfxlfopLMBz61ZdLrJ5S9xOfL9e3oqKmc
    uLiYGQJVTU6OlgKsdD/eBW+oNue7jTurN5xW4/07kM0hnUbMJKMLY6gLkZh+OBKt
    Sh8mXj2pObnuFUDgzov4PwxdJAAECVlyPAEQ3QHJtz0U7MwM06+DUwCd9v1vktDC
    LEZpPLhsUcOXt4CfZ5gWqeafO3Tue+mBoqOLs9v/KSc2kty48gAESaybziyUzU/H
    Oj9gjIC5+bL95lae6jZUanNHa8xIpFsP2WlAlvPipQclCqP8D/0UJ9Njg3f2mhQH
    dAyrU3eVjlUNvPCZKceLzWs/OlG7RhZPyaHxI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520488828; bh=RTe1PoiaIWOxjLeKvYuMmPY076wA14Hkr6wet1
    o7/H0=; b=pj+Cu8tHtT9yemeFvxR5w25FbEVKCvyHk9WyoloSc5mFu/+EyISq/8
    Cn8fZVOELSP02vdMovO2kgkdHEJNDivncYFyOHhZFDLGABwkjrtCBnEcFfPPqf99
    5lvFDzNixLv+wmpFM87Z4rnbPjukE0wwwH3OmuK3FVq8PRNf75ZmkxV+UUE3XTIF
    NSdYQOsgS9L2tO4xRFXORMN/opIuemHKLgdeS/ACIRs8Rplyd9oFSBXVdTomg7Ju
    syMr/ucdxhQoHU57kVipg3MElo3N2nuLamoA9VzpyTifKThwxC7W3EHK8Gn3uK2Z
    aLCWDAnJ6mlW9F0cJ+U2dcdlt68bqbFw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cDD3fp+d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cDD3fp+d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965689AbeCHFDQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:16 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965335AbeCHFDO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 129/190] power: supply: isp1704: Fix unchecked
 return value of devm_kzalloc
Thread-Topic: [PATCH AUTOSEL for 4.9 129/190] power: supply: isp1704: Fix
 unchecked return value of devm_kzalloc
Thread-Index: AQHTtppI9CObU1FV/kelGioWVFvfaA==
Date: Thu, 8 Mar 2018 04:59:48 +0000
Message-ID: <20180308045810.8041-129-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Xkzubw1tIdfWjGoxMDZ0KY4CLEJEnteFZ/f/083ECbJnZBhGTyb5nntZeuPBWBoiWO1hKQ5DTe4xScbMGdNEPKqM/yLjyGUhiPgngASMJfzlP68l09D4f3MjFEE/4p11sQ0Ea6OdX9/ec37uU1imtLQaiALYS8hHwckZHIIaHjyABnKK3OdRHo4ltT2HXlK1zeUP24ne2tS3r/Ov1xHp0I3LqBfI5sEoGeQQPQ5VuR29Zb6Q69VBzxOkf5hrWd4A;20:g2VlR2foFRwhSUgvWAnC2q8XBSPJXIJM3fcGPaDhqmgGRCnZ0EV+K5az8iIrLU4hZYJt3i2zjrjahYeoB32Z8G3euF9r/tZab+qfDLpGqaP1lBYZgfaSgjk+Y0L4D0MiZFRgA5/ruapU6XozotwzGr41ryPHbHH17xfldxvEk5s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 614fc694-34ee-453c-47cd-08d584b1e4f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013D4A841E318791A4D9F32FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: O27iaRo6L7Hxs+83hgmX+IX3YKZZqj01C2CX7VBmPQjgMA5qC/kI41xtJfc0KbOpPaeNBVyOVTTMHrJlR1np6jUQSx3V1uGLGQKMegSaFeEQ9q3gwvw+xThfV3V8OT6sRnAi+tkHtZJIyUwDgSZCEUD/nvA6p6aF28yR2fNkSBO7dU2Rb162vVSunZFSGP1YdFQTcbDG8izs8tw/+msJ5Q/d7JH+PzFx4VUhQKY1nHqNH3zqaDVTeEjBeVa26iGVBO7r7cyZWGE/eJAq+9yAQhn57p7RXbZTLGg7UwmJmuKLl/6vLpiq72K6pEMhC6z3qRI3qDlZA/rD7nka3xVThA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19F4F08297E414593F770B9A9EB0794@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614fc694-34ee-453c-47cd-08d584b1e4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:48.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDhiMjA4Mzk5ODhmMWVkNWU1MzRiMjcwZjM3NzY3MDliNjQwZGM3ZTAgXQ0KDQpGdW5jdGlvbiBk
ZXZtX2t6YWxsb2MoKSB3aWxsIHJldHVybiBhIE5VTEwgcG9pbnRlci4gSG93ZXZlciwgaW4gZnVu
Y3Rpb24NCmlzcDE3MDRfY2hhcmdlcl9wcm9iZSgpLCB0aGUgcmV0dXJuIHZhbHVlIG9mIGRldm1f
a3phbGxvYygpIGlzIGRpcmVjdGx5DQp1c2VkIHdpdGhvdXQgdmFsaWRhdGlvbi4gVGhpcyBtYXkg
cmVzdWx0IGluIGEgYmFkIG1lbW9yeSBhY2Nlc3MgYnVnLg0KDQpGaXhlczogMzRhMTA5NjEwZTJh
ICgiaXNwMTcwNF9jaGFyZ2VyOiBBZGQgRFQgc3VwcG9ydCIpDQpTaWduZWQtb2ZmLWJ5OiBQYW4g
QmlhbiA8YmlhbnBhbjIwMTZAMTYzLmNvbT4NClJldmlld2VkLWJ5OiBQYWxpIFJvaMOhciA8cGFs
aS5yb2hhckBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gUmVpY2hlbCA8c2Vi
YXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvLnVrPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2
aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9wb3dlci9z
dXBwbHkvaXNwMTcwNF9jaGFyZ2VyLmMgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9pc3AxNzA0X2No
YXJnZXIuYyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2lzcDE3MDRfY2hhcmdlci5jDQppbmRleCA0
Y2Q2ODk5Yjk2MWUuLjk1YWY1ZjMwNTgzOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcG93ZXIvc3Vw
cGx5L2lzcDE3MDRfY2hhcmdlci5jDQorKysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9pc3AxNzA0
X2NoYXJnZXIuYw0KQEAgLTQxOCw2ICs0MTgsMTAgQEAgc3RhdGljIGludCBpc3AxNzA0X2NoYXJn
ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJCXBkYXRhID0gZGV2
bV9remFsbG9jKCZwZGV2LT5kZXYsDQogCQkJc2l6ZW9mKHN0cnVjdCBpc3AxNzA0X2NoYXJnZXJf
ZGF0YSksIEdGUF9LRVJORUwpOw0KKwkJaWYgKCFwZGF0YSkgew0KKwkJCXJldCA9IC1FTk9NRU07
DQorCQkJZ290byBmYWlsMDsNCisJCX0NCiAJCXBkYXRhLT5lbmFibGVfZ3BpbyA9IGdwaW87DQog
DQogCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiaW5pdCBncGlvICVkXG4iLCBwZGF0YS0+ZW5hYmxl
X2dwaW8pOw0KLS0gDQoyLjE0LjENCg==
