Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245805-2-16584779716646386897
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
    1523245805; b=BFh4d072c99kKPdomIlycop8qD316Se6VZ7ecL/DQxm6gyOmCT
    IeKq69DypQUWvwmwUiKPu+gASMlZvaLCP0IKC+ekD/uVRGNNbUGygYQqdgJrRtqH
    E7UWwpo7cr8pYmBTBqrUBIHcKJF//GDFXoadkNUVLDB16HcnUjwKV0gfP5GUqmim
    ilXn5+62wNHNnvZoqSJN9e8YKIfVRaWBXk5cnLFiWp+qub+i/xdtxKv+A09TQvKD
    0KLnGQSNhlQMQEj2+aX7OH7cz6iEJHTzBZi4mmTztHqyL/gm7BFEnzRCA2EGT7DQ
    5QunogZi3PX2KMjU2dJwyzbS9Tpif0pxxUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523245805; bh=XSPNm5cW044QiP/JTTVtIeqMdngqTvtlpl7a7sAshsA=; b=
    Z77++v7TC29f7i9f8IATKZtMLi9R9v6w4WahgIljJkcQDktpeMo+3NH9EF26tJJV
    CpTeGK6PuiK+A90leceZc6OY29MmqqXhcJQvvCqMqzAqdGBhLqvvPozfAXeCf0M7
    r9/mjNKr4Aa4q386CKJVMnezVZ6e66wKQ+selwSahFH1YP28/ITQYjvJt7F2XJNV
    Mi29lw0zBEG8i4ygD8/rkPSeZWWW4xkUOk8D0HR6RIl1G9shOeI51iS5DfbZBQCo
    ue5P2vglDu7aM5SrrWTYxndGOcuAv76N+1BMdNd278MNnd/PlRhtAUa/p0KVCF4p
    RLKzbzgEq5Vn0WkHKmAwxg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1LPtH5g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n1LPtH5g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPYQz0i0ptg14JizwsxwR2gS0PkVLM3UT23JIBkAHU+5J1HTZCkKpU6uJF13m9BT2b8Abr6J29AOREuOqtfDkbDSUe06y0NJxzxrXUMfvCFRJYzJ3QS
    5Ep4AKlteltWJTxSJoXVJCgFcTSc95l5xep5LBEB+B/LIxS+dHyWKd2G3BZY1A8gbmhKX2vjhBZ2dlsNTLsy47zWS0/+sW3xtywCrh4MUKs9c6sqaCuPGmQQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=jcNx0Mm0w_ZaHCl8CLIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDIDtf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:49:35 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754059AbeDIATa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 113/189] kvm: Map PFN-type memory regions as
 writable (if possible)
Thread-Topic: [PATCH AUTOSEL for 4.15 113/189] kvm: Map PFN-type memory
 regions as writable (if possible)
Thread-Index: AQHTz5hALtN0vF3+mEaxPFeibnUJqQ==
Date: Mon, 9 Apr 2018 00:18:15 +0000
Message-ID: <20180409001637.162453-113-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:aeXy7qOmF5R/o3unlemUtPjO+ulpTikNfJFwNMvs9UfUR7R7jiKv8F0telgd5blk37/JL+X3HAKbWxswpUIFSOm8ACCUcIxLnzd9lOxPV0OVBq16++Ex4zhmUGw28oYpchw0zdmqmvhBZ7bAxP1TAj7qIyjVxNSMmRoXkb2wms0YClEg1MzANMp9DAuNJuaPDZZfwbbOXPIhk2IwWWLMdzLRD2VSURbqW50sqRvJ4Sr9qWJCNHxHRQlgyogv5bQ0;20:9KFiaakmDfTaYjysEsWZYWz3qutvTgTz6RGQ/WdSVSkQ/NKct6QUgsWflVDaEWYYWi1GWGdmcKbF2YL8cexypy9+D3dYXXwzg3UmOQUZCV1Nmnr+1sDnKSRqH52g4/5e9ezL6cHD6Lq3TEPU8p3kPCgU0YiiXq2gbSFgE+4OPVg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e981af0-ba24-487e-2340-08d59daf8dda
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726A5A0D7AE4BB9C29AE8E3FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(575784001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rdoZsAt+H1c9A0U3zfxgrio6r9mnVFJq7qxmAP4QazyXQNFC8y8434na+6OuNEt3HXhXgRDWkuEybxzi/olGiUm+mtLEMTEvjVtgP1K0ALwLhuwcGEb+MEflLPNH6Hb7ijjrVeK8zd4H0ZNrNmCs5ZiO/IhSf2gufRDSMECfS0vQ+ZP8qQ9+IHzvvrFjs0D83t2ZbC1HvHaeU+RTFvdh5lcA3I+6w2EdthZiU8mKRM8Ex5231G0V896jCtGosubmnUZFUBvq5jUcziLEegDmJqZrONN7OEjxoiIJGxgb3jRAJYRqoNAsnSWtACJywVYyDLqVcG0iuUfbAtuZ9oXxb6yalvt2oCgFqnAQWtuiTacAusWatG6E1G+0IMsjBt/uMVoZ8xMY1W8J+G+xEGSFCOji4V0CmCK5HzF07FbIm1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <263EB0FD930EA34692ED17E74B9646D1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e981af0-ba24-487e-2340-08d59daf8dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:15.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
a3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFpbi5jDQppbmRleCBlNTM2OTc3ZTdiNmQu
LjIzNGQwM2FiY2I3NSAxMDA2NDQNCi0tLSBhL3ZpcnQva3ZtL2t2bV9tYWluLmMNCisrKyBiL3Zp
cnQva3ZtL2t2bV9tYWluLmMNCkBAIC0xNDMzLDcgKzE0MzMsOCBAQCBzdGF0aWMgYm9vbCB2bWFf
aXNfdmFsaWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIGJvb2wgd3JpdGVfZmF1bHQpDQog
DQogc3RhdGljIGludCBodmFfdG9fcGZuX3JlbWFwcGVkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIGFkZHIsIGJvb2wgKmFzeW5jLA0KLQkJCSAg
ICAgICBib29sIHdyaXRlX2ZhdWx0LCBrdm1fcGZuX3QgKnBfcGZuKQ0KKwkJCSAgICAgICBib29s
IHdyaXRlX2ZhdWx0LCBib29sICp3cml0YWJsZSwNCisJCQkgICAgICAga3ZtX3Bmbl90ICpwX3Bm
bikNCiB7DQogCXVuc2lnbmVkIGxvbmcgcGZuOw0KIAlpbnQgcjsNCkBAIC0xNDU5LDYgKzE0NjAs
OCBAQCBzdGF0aWMgaW50IGh2YV90b19wZm5fcmVtYXBwZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsDQogDQogCX0NCiANCisJaWYgKHdyaXRhYmxlKQ0KKwkJKndyaXRhYmxlID0gdHJ1ZTsN
CiANCiAJLyoNCiAJICogR2V0IGEgcmVmZXJlbmNlIGhlcmUgYmVjYXVzZSBjYWxsZXJzIG9mICpo
dmFfdG9fcGZuKiBhbmQNCkBAIC0xNTI0LDcgKzE1MjcsNyBAQCByZXRyeToNCiAJaWYgKHZtYSA9
PSBOVUxMKQ0KIAkJcGZuID0gS1ZNX1BGTl9FUlJfRkFVTFQ7DQogCWVsc2UgaWYgKHZtYS0+dm1f
ZmxhZ3MgJiAoVk1fSU8gfCBWTV9QRk5NQVApKSB7DQotCQlyID0gaHZhX3RvX3Bmbl9yZW1hcHBl
ZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgJnBmbik7DQorCQlyID0gaHZhX3RvX3Bm
bl9yZW1hcHBlZCh2bWEsIGFkZHIsIGFzeW5jLCB3cml0ZV9mYXVsdCwgd3JpdGFibGUsICZwZm4p
Ow0KIAkJaWYgKHIgPT0gLUVBR0FJTikNCiAJCQlnb3RvIHJldHJ5Ow0KIAkJaWYgKHIgPCAwKQ0K
LS0gDQoyLjE1LjENCg==
