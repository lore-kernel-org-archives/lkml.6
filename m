Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243256-2-6314993234107392606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243255; b=EIzmUYdw08MWKAuoqXaCwmxbPWAeBZFLo+sa9S5CMbtJqcF17K
    19ZSVgmQeeEHIYLLnt5Z50BbcQME094xe6aHLe3OfuUMunvxeRdHba7E0stPt98x
    VBJItKHRqGPdXbaCAvsji0y9fn9PdMYpyiRfiikUEUMHbnD9U2AV9SQ9KMEUIyG8
    56qUyB0V0nrBHpizJ5/UZrm9U9U6UCR9r8WuuN9FO4qqvfrv6SqdnwPqzo83CAPw
    T4DHysIa5qDDPcQWw3z6ZcOtReFsUfKV1S5sr/XwtVEVuiefHHrdiWeS1tMCRbxj
    ac1esQC0dJV4dp+r4+/+5jebBtL0EEzuVdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523243255; bh=/WTg2dW+/aNkEqCvDdHBZstkf8J9ckl7MZ9QTdzLUP8=; b=
    cAQcQtdIEB/A9IUdgQOnY5bqSBMgd/Q2K/V0Sd254zEIBQvI11EX+2PcnyNo371Q
    UhK/xeFX8PbItpoUxIo3mm0DTsXu34GPSl5MglTpbSW60cgJUtTc04+tlpF4tBXN
    yHT+J9pqa44R4o1ALkGgmZ38pQZWEC59b3Bu8p1ZNR2VoaKuSfvu0hYWkNmVTyNA
    Xu3qvwWZOSr3HVmeUWNU0LwQwQoCvu+KSE7FdGa3owiXNflfbYD2BO4Lzt8wlUaQ
    GHwIhF7zpFVx7UvPnJ0dWCjNwd0/aciZTLSRO8kLEscG0ZVf/w+AnGbvISlKWnsJ
    nlYqkGTRusZz4Klj6cLbcw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Za+/yWgb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Za+/yWgb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN2pPP/Vcg3MaPhf9PEjyq83buEKAI/CQZSzdtMeGKhAJomTkMbWMCVgg98Eb07j9l1xrpUyU9rbdBmMQ5ZDA9XXSZlpXB9IE+nbZ1t/sos9YYy2aylu
    LilqKO0evtAjhEOkFHkO6FBhzk/gG8P87DOuQSWxwECSwa+KroxUHInWdkSny4G9yW9tvomng45R6JlVOuNgHrIyJvKV+4SE7uJWesw+2btzrcqIwaID29Pm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=jcNx0Mm0w_ZaHCl8CLIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeDIDGm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:06:42 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932085AbeDIAYi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 093/161] kvm: Map PFN-type memory regions as
 writable (if possible)
Thread-Topic: [PATCH AUTOSEL for 4.14 093/161] kvm: Map PFN-type memory
 regions as writable (if possible)
Thread-Index: AQHTz5iltL14TsN+50Sd4FBQvJgq+A==
Date: Mon, 9 Apr 2018 00:21:04 +0000
Message-ID: <20180409001936.162706-93-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:FXcVMPkDHLz+s607s0sOcnd2iJpkXpqQuHoEhuVOU1NPK9qK3n93r5/q7OWu1k1oy4u6n1ynxW6d+4XT0Zq3rMrinz/q6I098jC+i4T0KiuqCI0sUvb6JM/tzy4dck7C/xoqTR7UVOwvgyr+pmtEQF8tjg+ptRcWz2tBMJ22rF64fSQQ57kGmaDVmZ/QFJQ2sJYhl1WHJS0IqIbn6/EVUjfiI9MehbCJgzcF96+uaHQICed8DCo/dTGc/8uZj4TP;20:ryXVQO+3CgwEc96dvJ1wwzPEJCyFCC9Zn44Y9I8Vqk3nY5W4LP1O/uPPNN4uqsT6ol6freFLz7MhB4eoBPvSlHHpOrWImSKqc81Tjp+2NVAxt25pe4HxBhu+Te1dBoglIIthmITYurl03dtsp+lmc/9go/kK6zTWRsJkIVDKjtw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50e85e47-796f-4e75-6af5-08d59db0451e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984DD86A96C091B743B20DDFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(575784001)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bnGBplKApcaaE4vgQutru76bDEf7zOPAz75+oEOVQu7BcxmlhaYOfuSYVswEjSeH9SuIvZFmzD4U6zbjHCqS7dfzML7ZQw4vbAsoLHPe1tCiKwYOf+9DdqGMupc7sV9nHgKKM6BAlqK+xoxixy15RyxbUg96/v1acJdHBjeAJNSMGtUvLckyZWnAbImvTQTyyGLhmrFpKy1GnbtBpz3wjyHR0hiXnbp2YFRiy9sdWZFTop/20dzWtsyssL2wkRlZek6JStlwm6hrGnLzAMK075uJ5t2bSfAK1a/OVNPPvwpySOhod+x4HIWbinqNhYE+G3czyrl8xU/o5Lhqgc5wbY3NdwG2LL1n8dKcrG5O4MnFZEgDfrgwQr7FWEROELxCkKa0HS7k96AltH/XZ6tGl4NcenO5lrsUCvV45pmBxts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <881A07353CB62F478AFCEA706861C670@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e85e47-796f-4e75-6af5-08d59db0451e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:04.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2FyaW1BbGxhaCBBaG1lZCA8a2FyYWhtZWRAYW1hem9uLmRlPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCBhMzQwYjNlMjI5YjI0YTU2ZjFjN2Y1ODI2YjE1YTNhZjBmNGIxM2U1IF0NCg0KRm9y
IEVQVC12aW9sYXRpb25zIHRoYXQgYXJlIHRyaWdnZXJlZCBieSBhIHJlYWQsIHRoZSBwYWdlcyBh
cmUgYWxzbyBtYXBwZWQgd2l0aA0Kd3JpdGUgcGVybWlzc2lvbnMgKGlmIHRoZWlyIG1lbW9yeSBy
ZWdpb24gaXMgYWxzbyB3cml0YWJsZSkuIFRoYXQgd291bGQgYXZvaWQNCmdldHRpbmcgeWV0IGFu
b3RoZXIgZmF1bHQgb24gdGhlIHNhbWUgcGFnZSB3aGVuIGEgd3JpdGUgb2NjdXJzLg0KDQpUaGlz
IG9wdGltaXphdGlvbiBvbmx5IGhhcHBlbnMgd2hlbiB5b3UgaGF2ZSBhICJzdHJ1Y3QgcGFnZSIg
YmFja2luZyB0aGUgbWVtb3J5DQpyZWdpb24uIFNvIGFsc28gZW5hYmxlIGl0IGZvciBtZW1vcnkg
cmVnaW9ucyB0aGF0IGRvIG5vdCBoYXZlIGEgInN0cnVjdCBwYWdlIi4NCg0KQ2M6IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFy
QHJlZGhhdC5jb20+DQpDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IEthcmltQWxsYWggQWhtZWQgPGthcmFobWVk
QGFtYXpvbi5kZT4NClJldmlld2VkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPg0KU2lnbmVkLW9mZi1ieTogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5j
b20+DQotLS0NCiB2aXJ0L2t2bS9rdm1fbWFpbi5jIHwgNyArKysrKy0tDQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3ZpcnQv
a3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFpbi5jDQppbmRleCBkODFhZjI2M2Y1MGIu
LjRmMzVmMGRmZTY4MSAxMDA2NDQNCi0tLSBhL3ZpcnQva3ZtL2t2bV9tYWluLmMNCisrKyBiL3Zp
cnQva3ZtL2t2bV9tYWluLmMNCkBAIC0xNDM0LDcgKzE0MzQsOCBAQCBzdGF0aWMgYm9vbCB2bWFf
aXNfdmFsaWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIGJvb2wgd3JpdGVfZmF1bHQpDQog
DQogc3RhdGljIGludCBodmFfdG9fcGZuX3JlbWFwcGVkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIGFkZHIsIGJvb2wgKmFzeW5jLA0KLQkJCSAg
ICAgICBib29sIHdyaXRlX2ZhdWx0LCBrdm1fcGZuX3QgKnBfcGZuKQ0KKwkJCSAgICAgICBib29s
IHdyaXRlX2ZhdWx0LCBib29sICp3cml0YWJsZSwNCisJCQkgICAgICAga3ZtX3Bmbl90ICpwX3Bm
bikNCiB7DQogCXVuc2lnbmVkIGxvbmcgcGZuOw0KIAlpbnQgcjsNCkBAIC0xNDYwLDYgKzE0NjEs
OCBAQCBzdGF0aWMgaW50IGh2YV90b19wZm5fcmVtYXBwZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsDQogDQogCX0NCiANCisJaWYgKHdyaXRhYmxlKQ0KKwkJKndyaXRhYmxlID0gdHJ1ZTsN
CiANCiAJLyoNCiAJICogR2V0IGEgcmVmZXJlbmNlIGhlcmUgYmVjYXVzZSBjYWxsZXJzIG9mICpo
dmFfdG9fcGZuKiBhbmQNCkBAIC0xNTI1LDcgKzE1MjgsNyBAQCByZXRyeToNCiAJaWYgKHZtYSA9
PSBOVUxMKQ0KIAkJcGZuID0gS1ZNX1BGTl9FUlJfRkFVTFQ7DQogCWVsc2UgaWYgKHZtYS0+dm1f
ZmxhZ3MgJiAoVk1fSU8gfCBWTV9QRk5NQVApKSB7DQotCQlyID0gaHZhX3RvX3Bmbl9yZW1hcHBl
ZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgJnBmbik7DQorCQlyID0gaHZhX3RvX3Bm
bl9yZW1hcHBlZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgd3JpdGFibGUsICZwZm4p
Ow0KIAkJaWYgKHIgPT0gLUVBR0FJTikNCiAJCQlnb3RvIHJldHJ5Ow0KIAkJaWYgKHIgPCAwKQ0K
LS0gDQoyLjE1LjENCg==
