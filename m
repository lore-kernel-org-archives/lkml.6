Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244974-2-14149967391681804937
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
    1523244973; b=uUjAZU/PFPFUbdSHiDTad6DCoH+8wyJ/VRLOxosBFV3VIkKGJ5
    zcj0SG3WSj+eVJdS+SkoTIHh9k/WZ5j5LpjZ8ePEYJr550zOkX1rNChc2KSzxzvX
    PEetaP389IjTQv+Gn8mzLO0bEwKyqMBBinc/spGrc74Hh+lnP7VesFkntMmD2iDc
    /Mkp+PbyWKWsb9ORvZVrN3zo7om6sIS6DMu8kU7nz2+0Uym2pplZ/ls8KfLnvyxV
    CTPzwzqPEsSF5XE1LYqldg6OKeVQdIl1o/ROj25f2PB7lwAIFYzTr2qOAFP05Dzd
    L9gZiZn7JEUlBmBFiRqs6yC8neTx7ItDZd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523244973; bh=HH4/f200EHZO2zCza4IrxWaQal8QAp3ZnqnOlgQYBSI=; b=
    Wkb+6xXcyLcGLCEdsKoFyz+6Y5UqaVkxpbWK9x0CsypgwWxMEjk0bhUNxyhkGyeb
    C1fpXcUCHynrwbjcJ9I2SYvfe65NkgLb/kFL0ydToiJGx/Bk/IKIMEX6xJOZPulw
    GQNsK7dwX6UGBQqR2IZWd6noQUIKBgHx8x0ISj9pAZLILCFzNelJZe7yN/csAueK
    6h7SLcv6JuHZcaqE/bpYANYpVk0DGrnGtuTlrT5e+wps7W1Atzjp7n9HptG+p4//
    JHlzBZ2dj/eql4pfvzOdFF+gA6zywzznFodiYOkTP7gkEYos8mEpdL4YtVZr5qdl
    yledIdUfmUkcvy9gHciqKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkwQrxib x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkwQrxib x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBv8L+1x3vp9j8morH9TMmKOngv2/Oq0s6KV0vR8Jin5NjRlgUidCS8gvzXFJfGK+fhsg0PLLwbGxqfVCw9Xqz2Yhh31b/0mjrGX+sHF7CHoz34OB6Ky
    N9UfYv3kfcJbA+tHv8GS/ug7lRkD5n2pX6IuxWMbY+0S2PeUamWhm7vLjXpTkEP/n+0SNjJMI9JQ6p9FF/l9rp0nTrjC7qXeAW8GZA5BBXaWMkLOpk7ZAhXT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xNf9USuDAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=sxJ8H8CxQL1NTQ068MsA:9 a=30ZkFZvo4na4A1Mk:21 a=BnIe54PldabHeH3R:21
    a=QEXdDO2ut3YA:10 a=SEwjQc04WA-l_NiBhQ7s:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeDIDfo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:35:44 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeDIAVP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Malaterre <malat@debian.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 171/189] net: Extra '_get' in declaration of
 arch_get_platform_mac_address
Thread-Topic: [PATCH AUTOSEL for 4.15 171/189] net: Extra '_get' in
 declaration of arch_get_platform_mac_address
Thread-Index: AQHTz5heopiJfU3RyEKlLkIX6tCjKQ==
Date: Mon, 9 Apr 2018 00:19:04 +0000
Message-ID: <20180409001637.162453-171-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:AB9igOpVxsNbsuXYBulYxGuBZiYyN1qEETbtwJ+4aL3oJR9RjmRJ4NOlPZqwjFLdalFgykqJ412lF1Q1O6eeMzCp8q3FXOkc/Vy51Ewl6h9uaecT3l46vCjN8CAi6+l7nKYgyU0U/8Hu9S6pTofDCZoSjfkcPg/nvNqZOwu278JYtw6+1P0vcLIolUY7xVeEw3l6tSdcLFDsybGCwnAktCA46cVvPmxlvhWgzuece27aqgw1mhHfje3IWDj49USQ;20:pQi6ZGa4zjljZ5lgPQXzuQzH0XEaGppheYH53r0zNG7CZmCRPL12n8NnfptePo34Ksiks+pmisNvbix9x4Sa3yuXaz4CXWPJ4MD9dcf59ZKnFgdzInsP3Iq6Z/WjNScI2NQJHzH7mREdg+HRvCp4pYuv9GDezC5dsu/DMEG9ufM=
X-MS-Office365-Filtering-Correlation-Id: 13f486aa-3739-4e5f-eefe-08d59dafcbf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125690DE8468296BD7AF82EFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rHANg2FJqZXC2r/9TiovTreUo8HLtfq+cNguAKIZCizydW+W7RtcBOVMFwV5sJRRadJnjgovcXIWgYbaOm4ENz1Ef+bHJd8VolCTBtn/rKezAN6P3/btLlzi1e7kwiZVPwKE3Z3v093xC0OAWfAFS7lw+6eQw60OelYjTaW0kETWmJmkS2OmG/xlfjBP31C6KNPEr8F6LY4//9XNsUXKOJ2Q7Dz1eMCKBSyjc219rz3dd7uPQEQFJlE85ilHIsxbiAFCDE+hb0TvjNLhgIbb6RRXKJi1hKWj5BubzQGafltqvtx6ka9eeGyVtWO2t5C/zNSH/nsP7GRG9xMgKqx/659Z7HFpMoFlIUuIOvWEwvo5m4LMQtNdc/ztap4L02hzs6BM9kLct0dYcUCHLywIZFsXUbfSaqjr3pmglMXUeuQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C5FF5C6294A494287B57C8F97F97059@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f486aa-3739-4e5f-eefe-08d59dafcbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:04.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
bnV4L2V0aGVyZGV2aWNlLmgNCmluZGV4IDI2M2RiY2FkMjJmYy4uNzk1NjM4NDBjMjk1IDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L2V0aGVyZGV2aWNlLmgNCkBAIC0zMSw3ICszMSw3IEBADQogI2lmZGVmIF9fS0VSTkVMX18NCiBz
dHJ1Y3QgZGV2aWNlOw0KIGludCBldGhfcGxhdGZvcm1fZ2V0X21hY19hZGRyZXNzKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdTggKm1hY19hZGRyKTsNCi11bnNpZ25lZCBjaGFyICphcmNoX2dldF9wbGF0
Zm9ybV9nZXRfbWFjX2FkZHJlc3Modm9pZCk7DQordW5zaWduZWQgY2hhciAqYXJjaF9nZXRfcGxh
dGZvcm1fbWFjX2FkZHJlc3Modm9pZCk7DQogdTMyIGV0aF9nZXRfaGVhZGxlbih2b2lkICpkYXRh
LCB1bnNpZ25lZCBpbnQgbWF4X2xlbik7DQogX19iZTE2IGV0aF90eXBlX3RyYW5zKHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpOw0KIGV4dGVybiBjb25zdCBzdHJ1
Y3QgaGVhZGVyX29wcyBldGhfaGVhZGVyX29wczsNCi0tIA0KMi4xNS4xDQo=
