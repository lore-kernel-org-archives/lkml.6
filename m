Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493220-2-16985207252340340206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493220; b=RkOlXoM0/EYBnBusoHOYX4/Z+xZ0YHuLRhF4WyM6T6vwel1
    Isi/B0PZ1v1Cydfl2OIJfrfULW3/3EJ0ddlG0MmsFZpns42fZmy1tx1ULgBFt3XA
    7tqzWI8FQY7S+JfAz380QB6sXm/ea/Ig21qD4/6Sf/mFKStzt5gKUyY+dbeo49qO
    KiBn/OvF7HTt1/qzslMzQ/M54OF97MkHwmgE+10W33e3j7sphcLpPmw8ymeJyTh7
    QuVa2EvoueW3JfxpGfZn3EKmARiKI8u2uvdAGx6sQr1vvmVsSqEbBmX3HQSMPWBt
    I20XsMr37+mcvKXV67MnjtUpY8bx8Zx0W4by7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520493220; bh=q62X3s6TLEEEeAnOnuTGr30XUf1ewqEgHQHMsa
    o4tPI=; b=Rr+YDanMT8P165C9vqRYMtE9PoebpfyVLLjv45qJ9U1m/0MhpOtvW8
    9caN2ZYMGhXiWB3xjs4lGpaJw02g2CHVU0iAyzhJGDM01qxTTV9HxWyxQPRw5oBI
    LNlA+2RI2gGMylEl41Vs+e3XtX3UmaYFqbCrCAbqkN9QmfnupE//8wsBg8ZwNyos
    f+Btz598Fe7WEg9EW6HhAPHvBiEHpmNkEWapdjw17SGzYnelH01XdPacR3xerstp
    eRwAyhRPVMj5v90Npnp9ym9X71Jj6gz0IkQIKBI0fKNnz57bIMpkh0aM7ruaQd7p
    D2NQ7cHGN9FGmdAw2vGJvmk58ckVxvXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhH2Ld30 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhH2Ld30 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeCHHNh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:13:37 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754621AbeCHE4D (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pixel Ding <Pixel.Ding@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 02/78] drm/amdgpu: use polling mem to set
 SDMA3 wptr for VF
Thread-Topic: [PATCH AUTOSEL for 4.15 02/78] drm/amdgpu: use polling mem to
 set SDMA3 wptr for VF
Thread-Index: AQHTtpnBF2+QcuDY8kCX+Ce2w00yrQ==
Date: Thu, 8 Mar 2018 04:56:01 +0000
Message-ID: <20180308045525.7662-2-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:5AoW0hjvRlFZFpeIGEd6mivMfRB4amRsrmpaMj9cauSt90M8QMKM5WewvFkBAl8isUSCz53Wi1SQEK5hktJj0SZ99LCRowTZADMd0jG6Z7N4XUWBrkG9Dl/PPD/ewvELtzDcbAORB4/ITfPJeM5r8X2RCr95c4cen87CFjvpIkzisrZnC/zRi9c5ArnajcdArhwjEE5KZ/9Wh4Jpw1DxRgkXnp9ZUGOaKQwDjx+QxzUTXkcZ0YNnk2CNIqN7x7UQ;20:QyG2ijOy4Ew6ciCQhL8UM3TjXmHXeVn6aEmen72BzVa6zG7xLAB6pT5Cv0yop+OcXjGeVb+6cBDmYdaqVApMWiEm7DcyO50ncBMrJT6GDMYOSAQOwWF5uV9PgX5Gvxf9wCf9jxA4AbVip64V+A3Mwhs5txVVLJCa+Bh6N6/iy5s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b987b7f-b51d-45b4-322e-08d584b0e3d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902E7E056D4A5BE9CFD8E46FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(8666007)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(21314002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ogPSDAMSQVmudlbVs0D+M2/r4OQHKbHr8waAxSdI9AG09gg0D73YabYIfAOZhsCeEBY6bNwqG8sIrTJzYUWBMTJBlsIya6ZU1PwkOa37fuc3XJm0eSVUtn5sR2AfZgo35sqizs/9A6WY/P7IjwfvYKOwoFlxPinQ4R3J7MQo+vPG0NpzzZeQJ1obNE++rL/+ZjsjezldVpkipughidqxgO/BlAb4FLQS7axDyP/EZW9eCEly0qN55P1Frqp5qlVTAp5neb/FQUllxn8PBO0FQbLjdd6F/RRLoZQrGH3LQNms/K6nl2ZctkLOA4U2/6YbdIUITF+NtVEIMsp2154HVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EB4EA0C76590C4F8BBEC91CE1617FB3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b987b7f-b51d-45b4-322e-08d584b0e3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:01.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUGl4ZWwgRGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCAyZmZlMzFkZWIyNzU3OWUyZjJjOTQ0NGUwMWY0ZDhhYmYzODVkMTQ1IF0NCg0KT24gVG9uZ2Eg
VkYsIHRoZXJlJ3JlIDIgc291cmNlcyB1cGRhdGluZyB3cHRyIHJlZ2lzdGVycyBmb3INCnNkbWEz
OiAxKSBwb2xsaW5nIG1lbSBhbmQgMikgZG9vcmJlbGwuIFdoZW4gZG9vcmJlbGwgYW5kIHBvbGxp
bmcNCm1lbSBhcmUgYm90aCBlbmFibGVkIG9uIHNkbWEzLCB0aGVyZSB3aWxsIGJlIGNvbGxpc2lv
biBoaXQgaW4NCm9jY2FzaW9uIGJldHdlZW4gdGhvc2UgdHdvIHNvdXJjZXMgd2hlbiB1Y29kZSBh
bmQgaC93IGFyZSBkb2luZw0KdGhlIHVwZGF0aW5nIG9uIHdwdHIgcmVnaXN0ZXIgaW4gcGFyYWxs
ZWwuIElzc3VlIGRvZXNuJ3QgaGFwcGVuDQpvbiBDUCBHRlgvQ29tcHV0ZSBzaW5jZSBDUCBkcm9w
cyBhbGwgZG9vcmJlbGwgd3JpdGVzIHdoZW4gVkYgaXMNCmluYWN0aXZlLiBTbyBlbmFibGUgcG9s
bGluZyBtZW0gYW5kIGRvbid0IHVzZSBkb29yYmVsbCBmb3IgU0RNQTMuDQoNClNpZ25lZC1vZmYt
Ynk6IFBpeGVsIERpbmcgPFBpeGVsLkRpbmdAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBNb25rIExp
dSA8bW9uay5saXVAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5oIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djNfMC5jICAgfCAyNyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3JpbmcuaA0KaW5kZXggYjE4YzJiOTY2OTFmLi41MjJhODc0MmE2MGIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oDQpAQCAtMTg3LDYg
KzE4Nyw3IEBAIHN0cnVjdCBhbWRncHVfcmluZyB7DQogCXVpbnQ2NF90ICAgICAgICAgICAgICAg
IGVvcF9ncHVfYWRkcjsNCiAJdTMyCQkJZG9vcmJlbGxfaW5kZXg7DQogCWJvb2wJCQl1c2VfZG9v
cmJlbGw7DQorCWJvb2wJCQl1c2VfcG9sbG1lbTsNCiAJdW5zaWduZWQJCXdwdHJfb2ZmczsNCiAJ
dW5zaWduZWQJCWZlbmNlX29mZnM7DQogCXVpbnQ2NF90CQljdXJyZW50X2N0eDsNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjNfMC5jDQppbmRleCA2ZDA2ZjhlYjY1OWYuLmNjNGZjMmU0
M2I3YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjNfMC5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYw0KQEAgLTM1NSw3
ICszNTUsNyBAQCBzdGF0aWMgdWludDY0X3Qgc2RtYV92M18wX3JpbmdfZ2V0X3dwdHIoc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKQ0KIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmct
PmFkZXY7DQogCXUzMiB3cHRyOw0KIA0KLQlpZiAocmluZy0+dXNlX2Rvb3JiZWxsKSB7DQorCWlm
IChyaW5nLT51c2VfZG9vcmJlbGwgfHwgcmluZy0+dXNlX3BvbGxtZW0pIHsNCiAJCS8qIFhYWCBj
aGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8NCiAJCXdwdHIgPSByaW5nLT5h
ZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdID4+IDI7DQogCX0gZWxzZSB7DQpAQCAtMzgwLDEw
ICszODAsMTMgQEAgc3RhdGljIHZvaWQgc2RtYV92M18wX3Jpbmdfc2V0X3dwdHIoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKQ0KIA0KIAlpZiAocmluZy0+dXNlX2Rvb3JiZWxsKSB7DQogCQl1MzIg
KndiID0gKHUzMiAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdOw0KLQ0KIAkJLyogWFhY
IGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLw0KIAkJV1JJVEVfT05DRSgq
d2IsIChsb3dlcl8zMl9iaXRzKHJpbmctPndwdHIpIDw8IDIpKTsNCiAJCVdET09SQkVMTDMyKHJp
bmctPmRvb3JiZWxsX2luZGV4LCBsb3dlcl8zMl9iaXRzKHJpbmctPndwdHIpIDw8IDIpOw0KKwl9
IGVsc2UgaWYgKHJpbmctPnVzZV9wb2xsbWVtKSB7DQorCQl1MzIgKndiID0gKHUzMiAqKSZhZGV2
LT53Yi53YltyaW5nLT53cHRyX29mZnNdOw0KKw0KKwkJV1JJVEVfT05DRSgqd2IsIChsb3dlcl8z
Ml9iaXRzKHJpbmctPndwdHIpIDw8IDIpKTsNCiAJfSBlbHNlIHsNCiAJCWludCBtZSA9IChyaW5n
ID09ICZyaW5nLT5hZGV2LT5zZG1hLmluc3RhbmNlWzBdLnJpbmcpID8gMCA6IDE7DQogDQpAQCAt
NzE4LDEwICs3MjEsMTQgQEAgc3RhdGljIGludCBzZG1hX3YzXzBfZ2Z4X3Jlc3VtZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCiAJCVdSRUczMihtbVNETUEwX0dGWF9SQl9XUFRSX1BPTExf
QUREUl9ISSArIHNkbWFfb2Zmc2V0c1tpXSwNCiAJCSAgICAgICB1cHBlcl8zMl9iaXRzKHdwdHJf
Z3B1X2FkZHIpKTsNCiAJCXdwdHJfcG9sbF9jbnRsID0gUlJFRzMyKG1tU0RNQTBfR0ZYX1JCX1dQ
VFJfUE9MTF9DTlRMICsgc2RtYV9vZmZzZXRzW2ldKTsNCi0JCWlmIChhbWRncHVfc3Jpb3ZfdmYo
YWRldikpDQotCQkJd3B0cl9wb2xsX2NudGwgPSBSRUdfU0VUX0ZJRUxEKHdwdHJfcG9sbF9jbnRs
LCBTRE1BMF9HRlhfUkJfV1BUUl9QT0xMX0NOVEwsIEYzMl9QT0xMX0VOQUJMRSwgMSk7DQorCQlp
ZiAocmluZy0+dXNlX3BvbGxtZW0pDQorCQkJd3B0cl9wb2xsX2NudGwgPSBSRUdfU0VUX0ZJRUxE
KHdwdHJfcG9sbF9jbnRsLA0KKwkJCQkJCSAgICAgICBTRE1BMF9HRlhfUkJfV1BUUl9QT0xMX0NO
VEwsDQorCQkJCQkJICAgICAgIEVOQUJMRSwgMSk7DQogCQllbHNlDQotCQkJd3B0cl9wb2xsX2Nu
dGwgPSBSRUdfU0VUX0ZJRUxEKHdwdHJfcG9sbF9jbnRsLCBTRE1BMF9HRlhfUkJfV1BUUl9QT0xM
X0NOVEwsIEYzMl9QT0xMX0VOQUJMRSwgMCk7DQorCQkJd3B0cl9wb2xsX2NudGwgPSBSRUdfU0VU
X0ZJRUxEKHdwdHJfcG9sbF9jbnRsLA0KKwkJCQkJCSAgICAgICBTRE1BMF9HRlhfUkJfV1BUUl9Q
T0xMX0NOVEwsDQorCQkJCQkJICAgICAgIEVOQUJMRSwgMCk7DQogCQlXUkVHMzIobW1TRE1BMF9H
RlhfUkJfV1BUUl9QT0xMX0NOVEwgKyBzZG1hX29mZnNldHNbaV0sIHdwdHJfcG9sbF9jbnRsKTsN
CiANCiAJCS8qIGVuYWJsZSBETUEgUkIgKi8NCkBAIC0xMjAzLDkgKzEyMTAsMTMgQEAgc3RhdGlj
IGludCBzZG1hX3YzXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQogCWZvciAoaSA9IDA7IGkgPCBh
ZGV2LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykgew0KIAkJcmluZyA9ICZhZGV2LT5zZG1hLmlu
c3RhbmNlW2ldLnJpbmc7DQogCQlyaW5nLT5yaW5nX29iaiA9IE5VTEw7DQotCQlyaW5nLT51c2Vf
ZG9vcmJlbGwgPSB0cnVlOw0KLQkJcmluZy0+ZG9vcmJlbGxfaW5kZXggPSAoaSA9PSAwKSA/DQot
CQkJQU1ER1BVX0RPT1JCRUxMX3NETUFfRU5HSU5FMCA6IEFNREdQVV9ET09SQkVMTF9zRE1BX0VO
R0lORTE7DQorCQlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KKwkJCXJpbmctPnVzZV9k
b29yYmVsbCA9IHRydWU7DQorCQkJcmluZy0+ZG9vcmJlbGxfaW5kZXggPSAoaSA9PSAwKSA/DQor
CQkJCUFNREdQVV9ET09SQkVMTF9zRE1BX0VOR0lORTAgOiBBTURHUFVfRE9PUkJFTExfc0RNQV9F
TkdJTkUxOw0KKwkJfSBlbHNlIHsNCisJCQlyaW5nLT51c2VfcG9sbG1lbSA9IHRydWU7DQorCQl9
DQogDQogCQlzcHJpbnRmKHJpbmctPm5hbWUsICJzZG1hJWQiLCBpKTsNCiAJCXIgPSBhbWRncHVf
cmluZ19pbml0KGFkZXYsIHJpbmcsIDEwMjQsDQotLSANCjIuMTQuMQ0K
