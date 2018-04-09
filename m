Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238679-2-15632884585341577325
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
    1523238678; b=pBBFdJEmpbq1Ao0HKCu/gOJDOpaE434tS6PFJVDWFQQtZA2bx2
    j5T/Ck8A3D2y3Fwg6sBvTu4ddm7f8OSIL6UrKMRk5zjmPUsb+UGVjp3bv379v2Xd
    akIqZC95OXGbVl/cyd+FLvuzEYPtRzUs5N+EF1Ix7AydPTTBvo8N3Fo5HCLOvveZ
    vbk6d7TfK2CFe+HtrI6+WIdIwhOhZLsMI6REtkRIMc41Sp36V54TZEIXJH9gOsdF
    mAB756i6sFIb27bcvrG+wH5xYEWo90zHdsdwU5PqePgLUHVuMZkWAds3313kgZWU
    dAmY3PYfbwwsxCwvVlMEDtQgem4+Ck0XY3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523238678; bh=k/Fn81HBJfQWR1e2ELaBiTl5c/GOJpwC7UwFPKILFko=; b=
    YhVl7n2L4beUcyThEoV5MoI9cBFG6gDEr2X7dtY64v+AbL6RsSQyFHFP0gzGrUNV
    hmywLhRH3poUCwZayFxhTvnMOH6UeHyssfMMXQw02F/EYJVWW4e1jKNMz5e+j0TV
    CqAa0rHYpSkgSyQBkX9ZXzpgn+KxBs83OpKGa7nkD1j8LAMToOVwfGWf4vTy74x9
    CanQB4sUYciLJOduKIJD5dizx0iIPJLJiAkrx+Z1oNnwRe07wT+Ebm39FEz8Nm39
    9zEybxLdkaTJbcFkdLKbpCVHeqNQoxo4Jook6n6bNsSZgNxP0x+h3I2JbsZvI2Wy
    6tDguiAK8KHnhX3KHWsIcg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkZKY30l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkZKY30l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJessJFyicXxj03Z2NF97u4bcc1hT5dNvLDS2oFQV5/OiBFrZh0WuK03C2TmYcoaTS+wqHuXXjSHvtfEQY/BbTibS+PmChSbIeFckgj++TdxtnPjziJw
    U7SOOWQfBPus24/cUqqkiImT5tvg7DfcmbepGxw+UiUDxKuh1ryzvjSM6AtrU9AL6xwKIHNwT2bNeLw+VHopg/psrkeZfGhzxr5RdFZEJwSfMVu+3PHWMXvV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=jcNx0Mm0w_ZaHCl8CLIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757426AbeDIBu4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:50:56 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932342AbeDIAdv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 253/293] kvm: Map PFN-type memory regions as
 writable (if possible)
Thread-Topic: [PATCH AUTOSEL for 4.9 253/293] kvm: Map PFN-type memory regions
 as writable (if possible)
Thread-Index: AQHTz5lbKlXIaJKVx0iVnne1AVUENQ==
Date: Mon, 9 Apr 2018 00:26:09 +0000
Message-ID: <20180409002239.163177-253-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:rdhyfC9lL53sz3XYnjqyFwz0Ah6IvReX0wIL1VIU7sElkp+Xo9cn9IpYqOMKo18X3JvEKFmLXugikwNQo9ZX9+arycPRNtHin6rEIXC/2B33USmMBwxjuKWheimEXSsFAJNeUOp7wo9SisECIDXi1E5WvUx6K+jGCGYVuQLaCWaEJtZjwYrkaV2T8hq1N6n3c4WGRg487dNE+r3tkvcw5Am6QPbg5LYbG2g9jwc74WpJIqh6wl7hbokUNWNRtJPa;20:JeDHjsyCy/OG/R1pCvX0OG80rpEcxacZlCZm7l0PnhNj0LfHSwjqUPS8I56lRk4mePgtYSYsMcq6WumXlw1Yd6H/rBH6gkd2sSKeEaBX2J9QYKNlHWJ6dGsYbi0d2ukFXhHy0tL64LtTVubPTq6ucLpdjmCs3h4md9sWYptJT38=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 949a06a8-ee88-4df8-2d8d-08d59db18f83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806075BE626FD185706B414FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nGflfZbgzXEDwxyWZgmR+l4PqUGdJ95fDuwK9v6H4nE0Gv67va7/dVPOWwIC6N4+UMcY/GSS6G4fUdcNSC3ORDf80pLE+EPbFyFIAHrzGXiq0EXEfEZz1Hj8IGqgr2IHXU3uYJpep6xqi5Uynj55juzIMYu9v3h1zL4F9IGqpNUzYJmj0JSk1SqktBrExoYigIFFQWWVCfqtkgqHp6T/d54u1K/xUc9qYH4XmpSaIk9J9jbvf8zsJMhrxPJ/6nBmCQmFaR+zommw6YA8QoEDyDtGbeS0lAS8qGZlFET2ZIEYzCQTZgIBnTTws9Vm3fR3QYyrGqxlpvVdONuxdtn2/rKpUUU7yvmEQvOkTo7POJHe6+fCzBQaFPXSBi6Q/oe0Yb7FHu1oDmlIfjeUIJFTstYB+BoxTyNXn7Qs+zqM/2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9EAB1F93F7F054F9CCD73513A55941B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949a06a8-ee88-4df8-2d8d-08d59db18f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:09.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
a3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFpbi5jDQppbmRleCBlYWFlNzI1MmY2MGMu
LjRmMmEyZGY4NWIxZiAxMDA2NDQNCi0tLSBhL3ZpcnQva3ZtL2t2bV9tYWluLmMNCisrKyBiL3Zp
cnQva3ZtL2t2bV9tYWluLmMNCkBAIC0xNDY2LDcgKzE0NjYsOCBAQCBzdGF0aWMgYm9vbCB2bWFf
aXNfdmFsaWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIGJvb2wgd3JpdGVfZmF1bHQpDQog
DQogc3RhdGljIGludCBodmFfdG9fcGZuX3JlbWFwcGVkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIGFkZHIsIGJvb2wgKmFzeW5jLA0KLQkJCSAg
ICAgICBib29sIHdyaXRlX2ZhdWx0LCBrdm1fcGZuX3QgKnBfcGZuKQ0KKwkJCSAgICAgICBib29s
IHdyaXRlX2ZhdWx0LCBib29sICp3cml0YWJsZSwNCisJCQkgICAgICAga3ZtX3Bmbl90ICpwX3Bm
bikNCiB7DQogCXVuc2lnbmVkIGxvbmcgcGZuOw0KIAlpbnQgcjsNCkBAIC0xNDkyLDYgKzE0OTMs
OCBAQCBzdGF0aWMgaW50IGh2YV90b19wZm5fcmVtYXBwZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsDQogDQogCX0NCiANCisJaWYgKHdyaXRhYmxlKQ0KKwkJKndyaXRhYmxlID0gdHJ1ZTsN
CiANCiAJLyoNCiAJICogR2V0IGEgcmVmZXJlbmNlIGhlcmUgYmVjYXVzZSBjYWxsZXJzIG9mICpo
dmFfdG9fcGZuKiBhbmQNCkBAIC0xNTU3LDcgKzE1NjAsNyBAQCByZXRyeToNCiAJaWYgKHZtYSA9
PSBOVUxMKQ0KIAkJcGZuID0gS1ZNX1BGTl9FUlJfRkFVTFQ7DQogCWVsc2UgaWYgKHZtYS0+dm1f
ZmxhZ3MgJiAoVk1fSU8gfCBWTV9QRk5NQVApKSB7DQotCQlyID0gaHZhX3RvX3Bmbl9yZW1hcHBl
ZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgJnBmbik7DQorCQlyID0gaHZhX3RvX3Bm
bl9yZW1hcHBlZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgd3JpdGFibGUsICZwZm4p
Ow0KIAkJaWYgKHIgPT0gLUVBR0FJTikNCiAJCQlnb3RvIHJldHJ5Ow0KIAkJaWYgKHIgPCAwKQ0K
LS0gDQoyLjE1LjENCg==
