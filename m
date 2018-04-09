Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239522-2-15658498718170154366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239521; b=sXVcaHyoX0kPPTmvJrommXMqAvudJzc39h5mmOZabuBZ3MihoY
    TcgxzLFJbMA/f0qbeSb1rqTs9P/PclTcCxM4GWE7Or9zgtzc63e4fKF1rFxvPxd0
    t8VBYBUOBTbhs5/zZS8F0Dam2yIQZYy2yHExzSmlGJm+ku4ftQK7IS7K1qqsSAW+
    yyBK9THcJSPXhXkb9gZ2TRKQOzoX5/+rTyAJOovY84Ljw05KBhPPKSfsP/KcI9en
    MCPDIt7fdR3OGhDE3nqaNOJAGLPLm/SaqiERDGsUOLL/11YyFoV9vaNOrY5KP/NZ
    1bKSzfFnDl4gNC2y9rJUUhXZmpxcL5KHXKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523239521; bh=BSrMrAoI4w1IrqRIEQ1krHSCBPybrfZP/k4KPqBMczA=; b=
    B68zfjjIjn3XYLb5RlRXRQpw0VcvPJjG7yfUCtFz6JgRoUa5bdnp4Y+D90YTA/39
    P+4ycg1OZEEFS4q+a35FJ6O9ukN3KDjU/v9TiaUD9E0gzfpJU6MIvgOyRp3jGymm
    /CL5HbsncBySQaiPyClIleuRsMC51U1jWFQvPwxurSxR9JDjSUbvjvQZJ5L9lBQg
    aXSGhmGccRKTJednr51CBiD4HhzgWbyQAaf+pshjcdgOApsEVz7zh+cPTM9qTsw6
    hFgSVirvKFuY2khGhwwb8pKwDhMR2TlXFo82Ru2TfxxjMBS6BZoBUGZGn3qQGM8o
    Pf9+TH9bRru8amwQUqkIGQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I7oqWQCK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I7oqWQCK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJU7s0whCv/TKSyfDlgSazdXhdqBXri1p0oWN8FNBsvkeBUs7gy0FUFf3c5IAIcnCuCSenQooyxceC0kCwq3SyQeuPGGRUDHdQE0ENO2aHE4QCI40IFf
    +UT6Pvl380KRhvyYoIl+FqjPkLOICIhxT9NcRK5xWMOYklrBjPSlhp16vTiKQEynYazhL/lACLeGVYXeSP0u7lksX1gREfdtygJnRdGb5fM49wgHs73gQ8Zt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=AYdrOdEoAAAA:8 a=yPCof4ZbAAAA:8
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=wEQHMdzYEBxiOzsUMLkA:9 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=OGUpGO79hC_v-Tb66Uh5:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757752AbeDICFS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:05:18 -0400
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:22424
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756365AbeDIAb7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 185/293] Btrfs: always account pinned bytes
 when dropping a tree block ref
Thread-Topic: [PATCH AUTOSEL for 4.9 185/293] Btrfs: always account pinned
 bytes when dropping a tree block ref
Thread-Index: AQHTz5k9gbeVhVG9sUW2zjpR8HPFag==
Date: Mon, 9 Apr 2018 00:25:18 +0000
Message-ID: <20180409002239.163177-185-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:pjQQhGkYCrZDkObtgAyNFYTNdskouZrbmhfMzChLKbW841ymOdv9GpDZDdRotJ6elpO+GJAZTt8m2J5RadpENyqVRzxe/xK0vcl9JahOUlnI4oZr6uB0sQyW9x7y16faxIawKFpyd2hwfJKZHvIFD3zAn2EEB0INYVmhjMip0ix09HKvAlAezvdUsifihGksmaEtXSWsMjuSASBIkpPCsZ0oY/37uEvFkTrp0mQ3/6Z48/K/KQ0aMbStGvdmSqMI;20:3eHMdSvlyz7gj3lmmDywxNkbNZxXeaLpaS+iGtLREJq4RohqPQXxw+cG51eV110HsQ96fEJZtCP4+lQUEjSUNwM3quet0sf0oaupXbOfV0vmRescywoRvWBYQuzAyzfMfGTBHCuo0TfUViXW5yWTlzy3s0d7P1M5+/C5mPSv+14=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5c191b3-3f80-4a16-4956-08d59db14d62
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087005819CC428F708A52991FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(2900100001)(551934003)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DbAeUL4mOgGv18uIIP6pWcubiZ5IGYK9XgaEoFrrBy+GoRnDWIQVtkcsUiegmwDONauIQQsAeXWlzUPN3nPLObqBrL7kouvE9ZjffGdNwxizmoCqtWx5m0SKO9OqJuMm8h34HDMDE5s0tlx1J5eOFPX7cns6sljLAaCJHfRg9dUYeqXLOU/R8vd6WxkCkRwFe10qxmTBE/tPw5sb8g8fcappi0HCKYSMnFJoP05oy1EjBDhfqRMXyLK61LnghIABQ4zRZlLy/7dxNFw25ytzst0EsP+8vH+lWaeI7X72NH2nkZpxSsN9wY0mDo4tJ/t6sKoNiYIYFOTvpDrVvO08ZkYw6hQKa69uVnll4WmADflp/uRP4Jrr4WKsx8L530OIXQ5JdxgX6i+NhbQ6dZpQn3o/wpbZMUMa2V4pHyfHUg4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9AA50D6DAA21B498AEFBA124B2359FE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c191b3-3f80-4a16-4956-08d59db14d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:18.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
ZnMvZXh0ZW50LXRyZWUuYw0KaW5kZXggZjlkODc5MDNlZjQ4Li5mMjE1NjM3OWYyODYgMTAwNjQ0
DQotLS0gYS9mcy9idHJmcy9leHRlbnQtdHJlZS5jDQorKysgYi9mcy9idHJmcy9leHRlbnQtdHJl
ZS5jDQpAQCAtNzE4MSwxMCArNzE4MSw3IEBAIHZvaWQgYnRyZnNfZnJlZV90cmVlX2Jsb2NrKHN0
cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KIAkJQlVHX09OKHJldCk7IC8qIC1FTk9N
RU0gKi8NCiAJfQ0KIA0KLQlpZiAoIWxhc3RfcmVmKQ0KLQkJcmV0dXJuOw0KLQ0KLQlpZiAoYnRy
ZnNfaGVhZGVyX2dlbmVyYXRpb24oYnVmKSA9PSB0cmFucy0+dHJhbnNpZCkgew0KKwlpZiAobGFz
dF9yZWYgJiYgYnRyZnNfaGVhZGVyX2dlbmVyYXRpb24oYnVmKSA9PSB0cmFucy0+dHJhbnNpZCkg
ew0KIAkJc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwX2NhY2hlICpjYWNoZTsNCiANCiAJCWlmIChy
b290LT5yb290X2tleS5vYmplY3RpZCAhPSBCVFJGU19UUkVFX0xPR19PQkpFQ1RJRCkgew0KQEAg
LTcyMTUsMTEgKzcyMTIsMTMgQEAgb3V0Og0KIAkJCQkgYnRyZnNfaGVhZGVyX2xldmVsKGJ1Ziks
DQogCQkJCSByb290LT5yb290X2tleS5vYmplY3RpZCk7DQogDQotCS8qDQotCSAqIERlbGV0aW5n
IHRoZSBidWZmZXIsIGNsZWFyIHRoZSBjb3JydXB0IGZsYWcgc2luY2UgaXQgZG9lc24ndCBtYXR0
ZXINCi0JICogYW55bW9yZS4NCi0JICovDQotCWNsZWFyX2JpdChFWFRFTlRfQlVGRkVSX0NPUlJV
UFQsICZidWYtPmJmbGFncyk7DQorCWlmIChsYXN0X3JlZikgew0KKwkJLyoNCisJCSAqIERlbGV0
aW5nIHRoZSBidWZmZXIsIGNsZWFyIHRoZSBjb3JydXB0IGZsYWcgc2luY2UgaXQgZG9lc24ndA0K
KwkJICogbWF0dGVyIGFueW1vcmUuDQorCQkgKi8NCisJCWNsZWFyX2JpdChFWFRFTlRfQlVGRkVS
X0NPUlJVUFQsICZidWYtPmJmbGFncyk7DQorCX0NCiB9DQogDQogLyogQ2FuIHJldHVybiAtRU5P
TUVNICovDQotLSANCjIuMTUuMQ0K
