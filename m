Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234272-2-4529812361722297030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234271; b=XTeJs13+nIYj6CCjVx/HSdcw348Cay/1rIoeNfDiyhOwsocMm1
    142Y7x+lOZRIzqaKPfeeAUdxIB3cLf/ZCutEJtvd3x6HqgmL2XGXLbrCrTMkfHGv
    pcG73FMtvGl/UzW52V4CwBRn8BReqTZfeY4ZyKwFuzb3JmKcilvN8+Jij6Td+l15
    frZLWEol0djAPo0lxJ0/XT4YwS4ESGI55+qlWPYg+YKoQZS3ZbUULqdj6Wfz17z2
    7soXD62yTpLc0MnhOxy9obZYSVWX5vxdWEPMpj7Nwpq8EIJvLghcjCO2gyY9pfvX
    e7paJA8vPl2MmYrGpBn6myxeCWu+gdr7j69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523234271; bh=IZXcWMIQZpZpU0ZyG399u6FY7VNot1nA8Y0EpSWmsaQ=; b=
    Xn3EnPyurRtqyesJh8GffuTLu7vs2FTy1mLcFG122v0IXupaUjUO/lyFAX2L7f7P
    f1gJdICFaOymGWm+bs4HqoPh/QJpwMbzIe9oV9Vm2gtMlq8waWWzez5wzX0E1jg9
    qSFFJGRvyemX950XB8+ci+wGbWvyLvo5/33qRE0dDS4/BuNuka2uR07PMXnQ7fCF
    2OvE5z6WfagUZdGtfRz9pufDTovNGOXH7+Ge6GWM4GVNW2iHB4R3HreHlkyBH0yt
    m9HsDXm1l1fEXK4k81Hlkx4xLpCuIMRou6qvs8twCeZ0MR3jz6bnU3dCbi637VcT
    9Vu7Q9v0i+7YSlLtMjK3HQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g4l7CcR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g4l7CcR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDmK0TZd6JFGyxlIZddtP9NN907B+OCSpeZCY2fQszCbvWLhJ/1bvjuJsJgiYHrb7/xUDQnsUxSBZMcNqCPthfvmOkDB/CUJL/H7Ibg5TQPii/uRDNd4
    jfj+9nXb5udXY81Hjwofp2/z1CavSzDLMSVoY7ulCzc0N7idtjOqKlvcYYdAe+fUGu7bJ3ZgxXN1i8F0S7PzcKn+XOSih/4A0toGT/myw1M6N77f84szVbWp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=AYdrOdEoAAAA:8 a=yPCof4ZbAAAA:8
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=wEQHMdzYEBxiOzsUMLkA:9 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=OGUpGO79hC_v-Tb66Uh5:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756168AbeDIAhn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:43 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755422AbeDIAhl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 092/162] Btrfs: always account pinned bytes
 when dropping a tree block ref
Thread-Topic: [PATCH AUTOSEL for 4.4 092/162] Btrfs: always account pinned
 bytes when dropping a tree block ref
Thread-Index: AQHTz5m8btwz92UiwEehnyryWNOvGA==
Date: Mon, 9 Apr 2018 00:28:51 +0000
Message-ID: <20180409002738.163941-92-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:ZOHaxShbIhX0X6rZhTiYdUBkiQ8WdYRhqtr3s7i345kKYaaYnoPDpz8e/4+zVPfZok6Jok2gtQ33ZmqLcDwCMzViVjWzE/Z4GXWVqFarlz4X1x5ezSUGQeY3VvBI7H7TpInbro5bVoIjX9Fk522Bj6kA+Es2JEdR1DlthzS6Fe0au67bA/7duUZ9Y4/7E6y0Cn/O9pwUZSGJbOBjYuchZlYbgaLVlnuMCoLiokC38EtGuPLP3sjQinGMwfWF6Gan;20:9uxh0FOw3UOyVJFKYq9Bg+w3kYx+UUrLtKP/ygn08JGXPO48J8k9P+D52mGG81zBOsW1pWyiuUMat07iefnRFwUav30+5bBbKSIqJn8Yvi2QUbqgOs1badFRnCh/ff37kZf2fP/bLVWyDXCTppbfH6nybIMBSA5wG3mTIfVH7ao=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01d2e1b9-5efb-446f-5b84-08d59db218f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031F841A582180AA7BC49A7FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(551934003)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uKGklANXDdkJh43F31hDVg3xtA0Pgb1lePkPlmZBZG3fhoGDURkporJfkhJtUdNIrngvwVF0B0KPd9ybj1yHgPRZinEMt5e4mU5e6+pVfV6PJhXNQprdSBvCJ+OAlqdpWAoreqEOjNOOMa4WDIhRqDO5lwFLnHtEYIICPbFlUb5UfKGtHERm3jrHzZrO1hncsir3y1qVtwnUZ+reZnxVJ4XmhH1I1WRshdwriwwN7cs4WXzv0Ylv90bYc0x+dE+S9YZ7+vEZ9J45s390yjBNg1adS3rJn8EAUy7YWRZLtL0s+kSO9FKqB+oB+TlzcdgQWKcZReAmzkABNw3XgN+2TOZbLqxsLYXJYN7nQVQJF8eTquzYseZVvqypoquzMAcr1KH6k6ukVZvrx1DXGB6l/dC+L0x4ad18TzSXNt3o+44=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EA1A6EB00501742AF7C1E43ED73F14E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d2e1b9-5efb-446f-5b84-08d59db218f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:51.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogT21hciBTYW5kb3ZhbCA8b3NhbmRvdkBmYi5jb20+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDBhMTZjN2Q3YWVjZmFlODk4NzE5N2U1MDExNmViZmMzMzhjYmUwYTIgXQ0KDQpDdXJyZW50bHks
IHdlIG9ubHkgaW5jcmVtZW50IHRvdGFsX2J5dGVzX3Bpbm5lZCBpbg0KYnRyZnNfZnJlZV90cmVl
X2Jsb2NrKCkgd2hlbiBkcm9wcGluZyB0aGUgbGFzdCByZWZlcmVuY2Ugb24gdGhlIGJsb2NrLg0K
SG93ZXZlciwgd2hlbiB0aGUgZGVsYXllZCByZWYgaXMgcnVuIGxhdGVyLCB3ZSB3aWxsIGRlY3Jl
bWVudA0KdG90YWxfYnl0ZXNfcGlubmVkIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCB3YXMgdGhl
IGxhc3QgcmVmZXJlbmNlIG9yDQpub3QuIFRoaXMgY2F1c2VzIHRoZSBjb3VudGVyIHRvIHVuZGVy
ZmxvdyB3aGVuIHRoZSByZWZlcmVuY2Ugd2UgZHJvcHBlZA0Kd2FzIG5vdCB0aGUgbGFzdCByZWZl
cmVuY2UuIEZpeCBpdCBieSBpbmNyZW1lbnRpbmcgdGhlIGNvdW50ZXINCnVuY29uZGl0aW9uYWxs
eSwgd2hpY2ggaXMgd2hhdCBidHJmc19mcmVlX2V4dGVudCgpIGRvZXMuIFRoaXMgbWFrZXMNCnRv
dGFsX2J5dGVzX3Bpbm5lZCBhbiBvdmVyZXN0aW1hdGUgd2hlbiByZWZlcmVuY2VzIHRvIHNoYXJl
ZCBleHRlbnRzIGFyZQ0KZHJvcHBlZCwgYnV0IGluIHRoZSB3b3JzdCBjYXNlIHRoaXMgd2lsbCBq
dXN0IG1ha2UgdXMgdHJ5IHRvIGNvbW1pdCB0aGUNCnRyYW5zYWN0aW9uIHRvIHRyeSB0byBmcmVl
IHVwIHNwYWNlIGFuZCBmaW5kIHdlIGRpZG4ndCBmcmVlIGVub3VnaC4NCg0KU2lnbmVkLW9mZi1i
eTogT21hciBTYW5kb3ZhbCA8b3NhbmRvdkBmYi5jb20+DQpUZXN0ZWQtYnk6IEhvbGdlciBIb2Zm
c3TDpHR0ZSA8aG9sZ2VyQGFwcGxpZWQtYXN5bmNocm9ueS5jb20+DQpSZXZpZXdlZC1ieTogTGl1
IEJvIDxiby5saS5saXVAb3JhY2xlLmNvbT4NClNpZ25lZC1vZmYtYnk6IERhdmlkIFN0ZXJiYSA8
ZHN0ZXJiYUBzdXNlLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIu
bGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGZzL2J0cmZzL2V4dGVudC10cmVlLmMgfCAxNyAr
KysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnQtdHJlZS5jIGIvZnMvYnRy
ZnMvZXh0ZW50LXRyZWUuYw0KaW5kZXggODc1ZTE3OWJiMmQ1Li4yZDU5YjM5MjcyMjMgMTAwNjQ0
DQotLS0gYS9mcy9idHJmcy9leHRlbnQtdHJlZS5jDQorKysgYi9mcy9idHJmcy9leHRlbnQtdHJl
ZS5jDQpAQCAtNjc3MCwxMCArNjc3MCw3IEBAIHZvaWQgYnRyZnNfZnJlZV90cmVlX2Jsb2NrKHN0
cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KIAkJQlVHX09OKHJldCk7IC8qIC1FTk9N
RU0gKi8NCiAJfQ0KIA0KLQlpZiAoIWxhc3RfcmVmKQ0KLQkJcmV0dXJuOw0KLQ0KLQlpZiAoYnRy
ZnNfaGVhZGVyX2dlbmVyYXRpb24oYnVmKSA9PSB0cmFucy0+dHJhbnNpZCkgew0KKwlpZiAobGFz
dF9yZWYgJiYgYnRyZnNfaGVhZGVyX2dlbmVyYXRpb24oYnVmKSA9PSB0cmFucy0+dHJhbnNpZCkg
ew0KIAkJc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwX2NhY2hlICpjYWNoZTsNCiANCiAJCWlmIChy
b290LT5yb290X2tleS5vYmplY3RpZCAhPSBCVFJGU19UUkVFX0xPR19PQkpFQ1RJRCkgew0KQEAg
LTY4MDQsMTEgKzY4MDEsMTMgQEAgb3V0Og0KIAkJCQkgYnRyZnNfaGVhZGVyX2xldmVsKGJ1Ziks
DQogCQkJCSByb290LT5yb290X2tleS5vYmplY3RpZCk7DQogDQotCS8qDQotCSAqIERlbGV0aW5n
IHRoZSBidWZmZXIsIGNsZWFyIHRoZSBjb3JydXB0IGZsYWcgc2luY2UgaXQgZG9lc24ndCBtYXR0
ZXINCi0JICogYW55bW9yZS4NCi0JICovDQotCWNsZWFyX2JpdChFWFRFTlRfQlVGRkVSX0NPUlJV
UFQsICZidWYtPmJmbGFncyk7DQorCWlmIChsYXN0X3JlZikgew0KKwkJLyoNCisJCSAqIERlbGV0
aW5nIHRoZSBidWZmZXIsIGNsZWFyIHRoZSBjb3JydXB0IGZsYWcgc2luY2UgaXQgZG9lc24ndA0K
KwkJICogbWF0dGVyIGFueW1vcmUuDQorCQkgKi8NCisJCWNsZWFyX2JpdChFWFRFTlRfQlVGRkVS
X0NPUlJVUFQsICZidWYtPmJmbGFncyk7DQorCX0NCiB9DQogDQogLyogQ2FuIHJldHVybiAtRU5P
TUVNICovDQotLSANCjIuMTUuMQ0K
