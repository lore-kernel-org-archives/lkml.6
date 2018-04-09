Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238159-2-17140278827588094029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238158; b=ZNRF1KwaXULx8dv/t8t49aZlvSIPy6uYC/8sX0Vcu//Lm8zCZc
    Oa7gsdQwV8rRMSwD50NARAW2CHiG8qY36OjrZvnNf1Fyc7PE8ZYB50ST73Ir6rpG
    rXwb4Hdx1U1boeQojEUmQStexho8XLBzjcR9cuiITBFHDoUlt1qL8oN8saSFSba3
    m4QtwagKQV2nMmqJa6Fi3ND4v9gDCyf7jwoeu9lJDb+pUmZ0FCao1R9yYJxG1IAM
    75ngYrQ0uB9lW/HdjFWTOtW1rQugJVszxQX/hDzquSv8OG/5NY1XVFzB8niUcFfI
    9f8BUvr7wVtzZXnobRqFZZkS0nu0WlB8kJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523238158; bh=sSZFYyPPVzYE6WAxwZ9LDSIflzMjllljpeklset2hEg=; b=
    wDvP3jcCFBkcbBPVQAJFeMQDWjs9PEG22hG7eTEmvUeVqYo+APzjvtyGTsgMogzX
    MJXKTEw4zkWqjD2DFwrCl1QPMDhdsaxYIBBJf1YYFv3ClOOQGK63h6GD7vQ8lOrR
    CTiivRwETVqLjzh2451K3WJS6fkBgucgT+OOuuZxUPcwVY2CSJkYdg5UwmngQ7Wy
    GBvDYlKMXZf3ra0El8UYMdnU+s5ftpTQ7zo1JYsuM/jexWvXHTtX1F/5945JgAqz
    4IwJti7WjyV0GeRSjOXLtdh8aADWd+5Ge9S56IoW52UeXhCxX2yCM/mz4jrvaV4P
    cHOKP2x+QRtLzrqSJptMwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BLpla4ls x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BLpla4ls x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdUgDO6qzRw6aJ61WAucRSdKc0lwjue/q1nIzQmADubuxxwnu+fGifQ9HivPW8yNGamH0A12j1WCNu2RyH4qbiCAkMYMMlBdCoaFni3ozsmkdQq89hM
    w9hUMA14ISOzpCDIOjtuwK2jmjFkr6frXaIbJEkMunJDrmH7wVrgtVnEceHBJtzGP+Zn+cHTZHugLwrkJr1LAeiF0xw3OWYACeBBw2diLC6Sn6mEGzvcs1Xg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xNf9USuDAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=sxJ8H8CxQL1NTQ068MsA:9 a=30ZkFZvo4na4A1Mk:21 a=DFrggTE8_v1Xu4bR:21
    a=QEXdDO2ut3YA:10 a=SEwjQc04WA-l_NiBhQ7s:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeDIBmV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:42:21 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932527AbeDIAes (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Malaterre <malat@debian.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 286/293] net: Extra '_get' in declaration of
 arch_get_platform_mac_address
Thread-Topic: [PATCH AUTOSEL for 4.9 286/293] net: Extra '_get' in declaration
 of arch_get_platform_mac_address
Thread-Index: AQHTz5lt2em5Psx0yUGjARo6FN2H1w==
Date: Mon, 9 Apr 2018 00:26:39 +0000
Message-ID: <20180409002239.163177-286-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:KTsjqzAprbdA6kxL4vY/X1yqQcI4Nq/1G38oSQchxmm6LvRcsRJo6EJ54iOaziTAL1X8UwG+QajRmY/6HkzQAe9kDZsCmTFW0ns9+5GifQM8j8W7zVuPp0aK0KaGEe6eN7bWrzDhocueENLqZyle0cxpwc6vws9XeJ0sF5YTatuHIgdTrValVigQXcYLaQ9ic/T7+08KNKF5VQLE5nq6TmWq3aaW987L36L2L9qHwMD1ulSx4Amnf8dwhoEszAmA;20:CG4QqNzra7efR/vVTYMFY8T+Jj+OhFG1lg+y7fcdV4JspdQIffWne4NTBAvS2sBBWvL7KR8OVbquihdFT8qw/yntiOB+zxUKF1ng1CtmfqiSqUgTaImZl0iFL5V/84C3f8nf3s+mCnRi6cFqputzDe3NLL9DDGrSLDK0vo9Eyek=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c637623e-b66a-4d56-9978-08d59db1b0b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806DD240952A3FE793508F2FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XTPd+BQm4Fps1YJHYP4qN1fu19U1813bh5e/i+HEOPM21a5vH51bIYmrDnfMMWahkV9TdR5HXmAHtu+zcggd9//MnTtfZP0da6PsDHz9cVFf4aTED4yBfZWZaytqihSAw8NoZX6qpaD8XB7E36O60rT7bpenscZfQ4w9Jn6Hj8uABPwD/ekw649cxqt6im4461uzFnvPNCSrZ7PESYWL9Cha3Gsgb9RD8Iy7vH3D95vw2Hvh8vg2ZqhRRM/aldIOACEpZ3fqMBzZMIXCFOmmwy18rfcYjS08bIgnlIH+T/+GOxensE+8Rgtvz4++LSx1kLLKitqTrJpiUMTqKtYT4l9zbNJFS/2z9aQ9XCusOIJ9X+/DmjdppVsYYU9VeVGLN7nzSGuEGCwkS+AKYwqbsDokr7Kva/tSCnBxkY3Rex8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <10687E6ECBFC4B4092936B50C74CA0FA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c637623e-b66a-4d56-9978-08d59db1b0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:39.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWF0aGlldSBNYWxhdGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IGU3Mjg3ODljNTJhZmNjYzEyNzVjYmExZGQ4MTJmMDNhYmUxNmVhM2MgXQ0KDQpJbiBj
b21taXQgYzdmNWQxMDU0OTVhICgibmV0OiBBZGQgZXRoX3BsYXRmb3JtX2dldF9tYWNfYWRkcmVz
cygpIGhlbHBlci4iKSwNCnR3byBkZWNsYXJhdGlvbnMgd2VyZSBhZGRlZDoNCg0KICBpbnQgZXRo
X3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU4ICptYWNfYWRk
cik7DQogIHVuc2lnbmVkIGNoYXIgKmFyY2hfZ2V0X3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcyh2
b2lkKTsNCg0KQW4gZXh0cmEgJ19nZXQnIHdhcyBpbnRyb2R1Y2VkIGluIGFyY2hfZ2V0X3BsYXRm
b3JtX2dldF9tYWNfYWRkcmVzcywgcmVtb3ZlDQppdC4gRml4IGNvbXBpbGUgd2FybmluZyB1c2lu
ZyBXPTE6DQoNCiAgQ0MgICAgICBuZXQvZXRoZXJuZXQvZXRoLm8NCm5ldC9ldGhlcm5ldC9ldGgu
Yzo1MjM6MjQ6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYYXJjaF9nZXRf
cGxhdGZvcm1fbWFjX2FkZHJlc3PigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KIHVuc2lnbmVk
IGNoYXIgKiBfX3dlYWsgYXJjaF9nZXRfcGxhdGZvcm1fbWFjX2FkZHJlc3Modm9pZCkNCiAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQogIEFSICAg
ICAgbmV0L2V0aGVybmV0L2J1aWx0LWluLm8NCg0KU2lnbmVkLW9mZi1ieTogTWF0aGlldSBNYWxh
dGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNl
LmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNlLmggYi9pbmNsdWRlL2xp
bnV4L2V0aGVyZGV2aWNlLmgNCmluZGV4IDZmZWM5ZTgxYmQ3MC4uYTNhNDdiMWJkYTkxIDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L2V0aGVyZGV2aWNlLmgNCkBAIC0zMSw3ICszMSw3IEBADQogI2lmZGVmIF9fS0VSTkVMX18NCiBz
dHJ1Y3QgZGV2aWNlOw0KIGludCBldGhfcGxhdGZvcm1fZ2V0X21hY19hZGRyZXNzKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdTggKm1hY19hZGRyKTsNCi11bnNpZ25lZCBjaGFyICphcmNoX2dldF9wbGF0
Zm9ybV9nZXRfbWFjX2FkZHJlc3Modm9pZCk7DQordW5zaWduZWQgY2hhciAqYXJjaF9nZXRfcGxh
dGZvcm1fbWFjX2FkZHJlc3Modm9pZCk7DQogdTMyIGV0aF9nZXRfaGVhZGxlbih2b2lkICpkYXRh
LCB1bnNpZ25lZCBpbnQgbWF4X2xlbik7DQogX19iZTE2IGV0aF90eXBlX3RyYW5zKHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpOw0KIGV4dGVybiBjb25zdCBzdHJ1
Y3QgaGVhZGVyX29wcyBldGhfaGVhZGVyX29wczsNCi0tIA0KMi4xNS4xDQo=
