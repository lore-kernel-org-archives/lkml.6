Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681251-2-10462948140705255112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681250; b=MgWiIDW+Tz36rnOzRUDzKcGqrXDTJqZid9sXB2n8jt3ioho
    0JyqTC0O6RJhxnmdHOPGQ3CRI8TFhnLgg8aRfbj0l1nDPD2V/BF/vsJny+4nhxMn
    khGASW159Ttn9kpgjrhcNjNwPfT6UIUk1oRMFKVQ3MvIsip544NbSxgNqzZ9OeFq
    sYMp8ssvplsWHxzoHdQJDyaHUnfRuvFjXlTkVyvRiDcT+fghsYXPKwPBa4o6wAii
    V0k77KxYpUfk0Qk8/PJ9Sb9+3DlFUqMybbd0TwuZBTUEqomxhioVqFmxdgvSfNpK
    V8zx0hJ7k/cwQ9mVAgl04n58Pzl2o39UVZ5IYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517681250; bh=y+/0A39MZkTtOizI7+p8otSRFHc4SypZLOTzuc
    R51mk=; b=MfZVaBmLKSLYQTJt/ZNIMBYDCbHBFQi+/VQU2BBfCaAzsmUC7gR4T0
    TMizWiLa/6fSJ92cx7ltTbPpRJHWcKkvSPKhq/pKXq7eIXhzHjdCKCi3gNS55M5p
    UraO4nBjM5HSJObcMuudjne+Rshm03DJFyfRAbIrJQWA1jm/Vt/bo/vNRTZrf86r
    vARmYJQa93a9xwnvILa8vQ/URO3anldA9HkVoCVWB7mKV+C3kNSEXmxh7/esx8ms
    XhJEUGAHlNqSyuAKQb9L6Wa4Wbz2irrxAHpdKamw/3XPkq4d96nebo/Y5yNE6bIQ
    MsRFGHqj4ipLFCn6v7zQjagGBx1MVGzQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JBNkIxxO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JBNkIxxO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeBCSHY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:24 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:64103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753229AbeBCSFZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniele Palmas <dnlplm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 03/52] net: usb: qmi_wwan: add Telit ME910 PID
 0x1101 support
Thread-Topic: [PATCH AUTOSEL for 4.9 03/52] net: usb: qmi_wwan: add Telit
 ME910 PID 0x1101 support
Thread-Index: AQHTnRlORJmDxb04UU2K11twMaytzg==
Date: Sat, 3 Feb 2018 18:03:33 +0000
Message-ID: <20180203180303.8490-3-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:6SGYHdyPfMAWtYqsZVP+8PQTlM60JdJnW6+QF1KVA8sRa2pUo2hBtSzkmeQ6NuK0559syhdLlHuzYKJylskwQaHpcd9+FaWi7NEl0wIn9FJN9Chu2cVsW2DCTq5yU4VHzYnGWbn9rbUVVlT7OyH1wklaN8a3TeyyQgvk2j0fjLba5wJ3aKNppdn+9aXjnYuewCXEV2tnqTVOwA+oSA9t3DqyzMDjKIXYItLDEONQyDgQwVSbJMHweV8bhjfmdi10
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8a4fd69-be52-43d5-b3ee-08d56b3070f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993F5E1CC90067E4EBF0D5FFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Hn7rJsVtmHXwc3pIv9Jcuiyw2PHaRuK9UxgoERq4FXZGRSqytU1EtkD02kliwxJ5hAwumkAVwld1Lnfx2IxkVg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DB3ABFD9595954D8D762A57492222EE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a4fd69-be52-43d5-b3ee-08d56b3070f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:33.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGM2NDdjMGQ2MmM4MmViM2RkZjc4YTBkOGIzZDU4ODE5ZDlmNTUyYWEgXQ0KDQpUaGlzIHBh
dGNoIGFkZHMgc3VwcG9ydCBmb3IgVGVsaXQgTUU5MTAgUElEIDB4MTEwMS4NCg0KU2lnbmVkLW9m
Zi1ieTogRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+DQpBY2tlZC1ieTogQmrDuHJu
IE1vcmsgPGJqb3JuQG1vcmsubm8+DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVy
LmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL25ldC91c2IvcW1pX3d3YW4uYyB8
IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdXNiL3FtaV93d2FuLmMgYi9kcml2ZXJzL25ldC91c2IvcW1pX3d3YW4uYw0KaW5k
ZXggZGI2NWQ5YWQ0NDg4Li5iOTE0NDY3Y2E4ZGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC91
c2IvcW1pX3d3YW4uYw0KKysrIGIvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCkBAIC05MTQs
NiArOTE0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkIHByb2R1Y3RzW10g
PSB7DQogCXtRTUlfRklYRURfSU5URigweDIzNTcsIDB4OTAwMCwgNCl9LAkvKiBUUC1MSU5LIE1B
MjYwICovDQogCXtRTUlfUVVJUktfU0VUX0RUUigweDFiYzcsIDB4MTA0MCwgMil9LAkvKiBUZWxp
dCBMRTkyMkEgKi8NCiAJe1FNSV9GSVhFRF9JTlRGKDB4MWJjNywgMHgxMTAwLCAzKX0sCS8qIFRl
bGl0IE1FOTEwICovDQorCXtRTUlfRklYRURfSU5URigweDFiYzcsIDB4MTEwMSwgMyl9LAkvKiBU
ZWxpdCBNRTkxMCBkdWFsIG1vZGVtICovDQogCXtRTUlfRklYRURfSU5URigweDFiYzcsIDB4MTIw
MCwgNSl9LAkvKiBUZWxpdCBMRTkyMCAqLw0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgxYmM3LCAweDEy
MDEsIDIpfSwJLyogVGVsaXQgTEU5MjAgKi8NCiAJe1FNSV9GSVhFRF9JTlRGKDB4MWM5ZSwgMHg5
YjAxLCAzKX0sCS8qIFhTIFN0aWNrIFcxMDAtMiBmcm9tIDRHIFN5c3RlbXMgKi8NCi0tIA0KMi4x
MS4wDQo=
