Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682240-2-12781056157479643436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682239; b=dM7PdQMMjx3n/X8igcFGU7W3TSZB1Fd3xXwCfeJ21/P7NbP
    BMZXiblxXu1UAgxIgyxDRUdS1BTyKQt9DDnDrvjs68bxoRyVVhoTbjMrDnJt62G9
    3tdFHO3gEC7k4Al7GLjcQutGGrTrN/14w8dn/9Ve02B3KvSQdMZBxQKson1UZX01
    vMaO/ZameOgZxUXzeNSuZWGH25vViv1gim1VY3d+tzGnbm4ro7UNxZgYNoh/FSxG
    lVed1zUl4+vDTEyPFhI0tWv8E3nYhQp3H/Bfmzu1Z0T8Y6ewqt+D5ZEYYveLsVDT
    Dwmdo4GnUns/VgxQ+c7UhVJnElTWwfJoL2WfhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517682239; bh=QXO5dXIQJnsaVYzlC5KF4Ib9FHloTjoUfphGX2
    NCEFk=; b=QiEWsISFC9P+UzoOkGCa/YLiBT+UMxiSYNSWmURqBziMFLKqQ3fLig
    EgbvcbWEBe60D50RxyW7fXBFoCHYcB29xTNsLKz/pryGo1+JSlX+dowvPydBFm7y
    1OgYICGT7Lrgs9ZJ0oDjl3JdfFs4FGV9G7BFCROKYE3gsHjvL5uPXHLTxYUOw168
    1mXz3OGI0uHh82KxC0fxcipFPxG71WCPcvOiRizFPiswYa5VoxsgAAR7Ukyaequc
    ldPhsW2Z54599vKCwHL4BUWvvawM4Sm+0YB4+Tg52qeqNO6BUfohd9nFTJ4Lok1f
    yffDTr6hy/1QfcaSWM9xEYbapqYq9htw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MkLrQg29 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MkLrQg29 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeBCSX4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:56 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753170AbeBCSGT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 38/52] NET: usb: qmi_wwan: add support for
 YUGA CLM920-NC5 PID 0x9625
Thread-Topic: [PATCH AUTOSEL for 4.9 38/52] NET: usb: qmi_wwan: add support
 for YUGA CLM920-NC5 PID 0x9625
Thread-Index: AQHTnRla7dkeJlYMcUWabbz4EBPW9g==
Date: Sat, 3 Feb 2018 18:03:54 +0000
Message-ID: <20180203180303.8490-38-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:hTNxsjBu859Vq5/lBtkDCyaiMfazwTjgttFvnjo2buKaymUIKjkhCjxcdj+wcAX8GC30hqmq6H73hrdVX3iAqsUoWnCQYQNoJjyf/hnYwmb7whhab91AFndZiIy8M5er7zsAUKWhlpiPdyvIu0JB9KE8S/sZH/wmnnlj0/S9YrdeNPc1G2nHCzy5OHhB7UOe8RyJ4t3PyyBq3w4To7oW98F+vOr6Flrjvh8ozzbUjlyfw+UAH6SJQWgs/3qOCfMN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 271b4e84-7139-4cea-c84d-08d56b309fcf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101254ECDA0421625424E833FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: zMk264laSqJP98165KKzpXBXcLldlijAghRzUMpQKNa5kGfFk7JGNXPdLaGk5rVBSf2yfGAFsaV9CyFrcguDkA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A6F4DD8DE85C044991274C242ED9B84@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271b4e84-7139-4cea-c84d-08d56b309fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:54.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU1ogTGluICjmnpfkuIrmmbopIDxzei5saW5AbW94YS5jb20+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IGJkMzBmZmM0MTRlNTUxOTRlZDYxNDlmYWQ2OWExNDU1NTBjYjdjMTggXQ0KDQpUaGlz
IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgUElEIDB4OTYyNSBvZiBZVUdBIENMTTkyMC1OQzUuDQoN
CllVR0EgQ0xNOTIwLU5DNSBuZWVkcyB0byBlbmFibGUgUU1JX1dXQU5fUVVJUktfRFRSIGJlZm9y
ZSBRTUkgb3BlcmF0aW9uLg0KDQpxbWljbGkgLWQgL2Rldi9jZGMtd2RtMCAtcCAtLWRtcy1nZXQt
cmV2aXNpb24NClsvZGV2L2NkYy13ZG0wXSBEZXZpY2UgcmV2aXNpb24gcmV0cmlldmVkOg0KICAg
ICAgICBSZXZpc2lvbjogJ0NMTTkyMF9OQzUtVjEgIDEgIFtPY3QgMjMgMjAxNiAxOTowMDowMF0n
DQoNClNpZ25lZC1vZmYtYnk6IFNaIExpbiAo5p6X5LiK5pm6KSA8c3oubGluQG1veGEuY29tPg0K
QWNrZWQtYnk6IEJqw7hybiBNb3JrIDxiam9ybkBtb3JrLm5vPg0KU2lnbmVkLW9mZi1ieTogRGF2
aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9uZXQv
dXNiL3FtaV93d2FuLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9xbWlfd3dhbi5jIGIvZHJpdmVycy9uZXQvdXNi
L3FtaV93d2FuLmMNCmluZGV4IGI5MTQ0NjdjYThkZi4uYTYzNjcwNDY3ZGMxIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9xbWlf
d3dhbi5jDQpAQCAtODA1LDYgKzgwNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2Rldmlj
ZV9pZCBwcm9kdWN0c1tdID0gew0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgwNWM2LCAweDkwODQsIDQp
fSwNCiAJe1FNSV9GSVhFRF9JTlRGKDB4MDVjNiwgMHg5MjBkLCAwKX0sDQogCXtRTUlfRklYRURf
SU5URigweDA1YzYsIDB4OTIwZCwgNSl9LA0KKwl7UU1JX1FVSVJLX1NFVF9EVFIoMHgwNWM2LCAw
eDk2MjUsIDQpfSwJLyogWVVHQSBDTE05MjAtTkM1ICovDQogCXtRTUlfRklYRURfSU5URigweDA4
NDYsIDB4NjhhMiwgOCl9LA0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgxMmQxLCAweDE0MGMsIDEpfSwJ
LyogSHVhd2VpIEUxNzMgKi8NCiAJe1FNSV9GSVhFRF9JTlRGKDB4MTJkMSwgMHgxNGFjLCAxKX0s
CS8qIEh1YXdlaSBFMTgyMCAqLw0KLS0gDQoyLjExLjANCg==
