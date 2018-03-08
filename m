Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492347-2-11836669282013729614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492346; b=djDLupQY9HKDk3TH40746aBkoSoZ1JOvU3kCMEMp7CsZ1dW
    638PIFHW/E1nxhWqrzKmFIF2buY8SYy9VZoEAQ9m+c33exucakQXmIDuMpe6Dz6/
    XLOnwFVkblgk8RR36wZ3BzXsSdinZhL5C4NkgTBVKq6XxsPCw/EygXjiFB2Kqxm/
    f83YxtySziQZi8jkfwzGdN85Bolj8ZlJDhC/I42UZdtY3i78A1viGGPUq+ipGIwn
    Vr6WrvIRSQ5gj5yqNzBTRXn28h8kUBcHBYppdxnfntoukufPXnEp62PdtwM/czDT
    ebGkcy3RPs0k+RRL5OyINja8NmM6jTtgWzs7K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520492346; bh=UVhXlncJnz17TYe0n9HRJUcs3eoIorzbd6WS0n
    AC67s=; b=QYPmxh8Ty7IABYZHDn9Vn06qDyEiqOsrEs8S10NWF8uHY4gIatFskj
    RGaXZqPZVWxWIQwkJ5lrWZ6+P/Dl61rp0EQlZ3uil9eh5B2vmXUQxF8xhIv/jX8z
    lFRstHavnbwyIWXs0BTnAoK7xV76id3WggmBGYd98lRVxeMpHetK3iYIl9M+9LCC
    9NMB84KvcDjBu/W0eGdqcWGAGMLDHjjEp48jrH1gNYKWtnaLzagluHBOPJK+jpQi
    KaK48Ou6c3p6FgJ2YEvWVi4Mc33hzfhHvitT9JB0y3qYkNfnj0VWRhPqhYFEsKXm
    c07uXfhVeiYJs3XtgfcU+hrFZFTBNiVQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2tZTA0s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2tZTA0s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeCHG6U (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:58:20 -0500
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:4352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935050AbeCHE5Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 58/78] dt-bindings: display: panel: Fix
 compatible string for Toshiba LT089AC29000
Thread-Topic: [PATCH AUTOSEL for 4.15 58/78] dt-bindings: display: panel: Fix
 compatible string for Toshiba LT089AC29000
Thread-Index: AQHTtpnQQlPe7QSSNECjMEdShMhz+g==
Date: Thu, 8 Mar 2018 04:56:26 +0000
Message-ID: <20180308045525.7662-58-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:PByQTm0MiMATSdie8rekT6HvHRRBEV2WmPH9A0rp2ASDH4CMDPXUEn/9+SwGSm7iCijyJplelC5IX7nkymCWAzEGgDpr6y4OM0gWG2wljz3340J8wi3Id/OHWt1BZzgNp5r9pZ6DYXx2xorwD9loZpscYx3hVW4vGcpqc0AnWlc069/onioNyJWZle1nvTrdBEd+Y9SHElt6bYRzwLvX320udWD8OuOcizgEpIAIqwaENpAEuIQmQmq0j1GpT+BZ;20:BdS5N9Ze2v2OGiyLS6qjzLcG0DePgLIuYnuWmC28s3rdPZRZh9B1Nca8aBSFNM0hnfHItEzKgLJ7lTo9EfrHGFB1zY1xPfZhh7zKzzFb6/3MZeXPh4P7VRd3rwUxPZI0FpSIJKCESRW11GG5PLANTF8duYyR9AG1Y6Zctp3CB4U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fef0bbf6-0763-4667-c906-08d584b11078
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103212BAD8D23C8AA3F62969FBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(248736688235697);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(575784001)(59450400001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rVoyRjXKqtY3UUXRHEhuWAxSgLBfxIhApWZ8GtZpmKjNSQKSRWiqyt2NaF5cKg9LceNWeWmrO04mSKojOkI0qRvnuhmBJhHMS3yDcv5UZcbHpiX74g9Zy1k/fA2Hw/CqQY/KiHPd1+eK5PF+PoR2+HsCVXb59Vnms0+pUqq7+7LdT/s/lBy+k06ngtd+MLbDDkq/KOvylR3nBnfRoFCRBehQtTi7X84fQr2a2J+4uYDLD4W9FTm5C7LxnS1XwuU9mVGsNbYHeewZ1L2OzmMunhfopfTEKd17rkP+P/VR2UiPTl2+pYvGLq77PEt16f1EVlUr4Eetep4V3F9yPnJW8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3447D2CB90A13C408F77301A0DC4A950@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0bbf6-0763-4667-c906-08d584b11078
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:26.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm9uYXRoYW4gTmV1c2Now6RmZXIgPGoubmV1c2NoYWVmZXJAZ214Lm5ldD4NCg0KWyBV
cHN0cmVhbSBjb21taXQgODFlZTZmMWVmOWIxZTkzYjJkYzBhNzcyMTFlOTgwOWZmYmViN2VjYiBd
DQoNClRoZSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhpcyBwYW5lbCB3YXMgc3BlY2lmaWVkIGFz
DQp0b3NoaWJhLGx0MDg5YWMyOTAwMC50eHQuIEkgYmVsaWV2ZSB0aGlzIGlzIGEgbWlzdGFrZS4N
Cg0KRml4ZXM6IDA2ZTczM2U0MWY4NyAoImRybS9wYW5lbDogc2ltcGxlOiBhZGQgVG9zaGliYSBM
VDA4OUFDMTkwMDAiKQ0KQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0K
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gTmV1c2Now6RmZXIgPGoubmV1c2NoYWVmZXJAZ214Lm5l
dD4NCkFja2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NClNpZ25l
ZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBT
YXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3Rvc2hpYmEsbHQwODlhYzI5MDAwLnR4dCAg
ICAgICAgICB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL3Rvc2hpYmEsbHQwODlhYzI5MDAwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3Rvc2hpYmEsbHQwODlhYzI5MDAwLnR4dA0K
aW5kZXggNGMwY2FhZjI0NmM5Li44OTgyNjExNjYyOGMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC90b3NoaWJhLGx0MDg5YWMyOTAw
MC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3Bh
bmVsL3Rvc2hpYmEsbHQwODlhYzI5MDAwLnR4dA0KQEAgLTEsNyArMSw3IEBADQogVG9zaGliYSA4
LjkiIFdYR0EgKDEyODB4NzY4KSBURlQgTENEIHBhbmVsDQogDQogUmVxdWlyZWQgcHJvcGVydGll
czoNCi0tIGNvbXBhdGlibGU6IHNob3VsZCBiZSAidG9zaGliYSxsdDA4OWFjMjkwMDAudHh0Ig0K
Ky0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJ0b3NoaWJhLGx0MDg5YWMyOTAwMCINCiAtIHBvd2Vy
LXN1cHBseTogYXMgc3BlY2lmaWVkIGluIHRoZSBiYXNlIGJpbmRpbmcNCiANCiBUaGlzIGJpbmRp
bmcgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBzaW1wbGUtcGFuZWwgYmluZGluZywgd2hpY2ggaXMg
c3BlY2lmaWVkDQotLSANCjIuMTQuMQ0K
