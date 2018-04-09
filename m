Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234187-2-9296455776605403452
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
    1523234187; b=TvA/CakICjDz4fKuL+r9NG0e0wei95EPm9s21aK7HMgw/IJHcH
    41cKWfMaFLjrQgSftZzNuNw2QmRbsrvNS4qKBuLHQBxq2UOCriIWsZqw7CgtDEMp
    j25+IkPTAPZdc+xwoJbHal46Q+zGOSH9sTxAliLP94u2QLQ6VFrSCPn+oz+cvhKo
    x1zXnv7PjioyLrd5cSIUc3QN0Yb+5O1hMQDD57BPsNo4VvwPSjMqj0b2HDNeL0EY
    8t1nSMXlyXq+UxAbyiMqxeo5DEqtotaR90faMkzZ49RfkSq3VBDiz0HyGs9g6G5d
    0mtNXqvNLIsYumFLABdmumxDlD3wiC1BEqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523234187; bh=vTAhVyZPH14QfUM2iDlDRhPY8m2/kDTyrKcg5sor8hE=; b=
    qcpShqXV0kIYYudIDohRWEeeU63XglAcQMYqI1bl1dOu8DXEHwuqXDJSCq953n+P
    OdEwohWQuOoNxMaST5ILszaPnC5kRvGjJxbelW1vQtq8q1dd8A/6NUT7tjKJKYr7
    w6qHJptAuBK5dtAyUvCbiqno9qu/7miYGJttxYvKYIZxAcz8ESXO3ChQWDdVP1Hp
    1VQQVbcqCjys2JttUudLWsJeBruOmHnMR67HZYx5ZJJMoOqQXl+wtXrnmFTzGeqc
    10GYjbjpnbKhP9KzD+gYaX8PxDp5V4STKlpl0oXR2HxWV4UxFM5IEey3t90+t7aV
    r3g3C2d0HtK0+YLx6gy4pQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lOiOIPhg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lOiOIPhg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFqo3MeY8CgZsW11Sb1hR9j5v4fKDtFV2rP/MF6aUiInvzNsIE9JWU6YsYQOa+hConaBKdf3ZOB6lrDKFr7LSxwTU20IF5UavVj14Vr3rK4B2Lx6QmnO
    NTPpZ8++fFiItW2XU9eVuY3O2uNWUat4jfMqnGwZa1G6T5qBmtdg4p0lB9zXOkbyWkniUZIc29Eg74QDOVbkhgW1nKy6Mlu9HEGYNsa5g0FgvUo9cT4VhHmp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=DfNHnWVPAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=NNxdam4jXssEnxCv9nYA:9 a=MLcyE3zIsjVxBJJr:21
    a=Qn9xUNJF3qNZQCoP:21 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeDIAgS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:18 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756694AbeDIAgN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kai Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 056/162] platform/x86: dell-laptop: Fix bogus
 keyboard backlight sysfs interface
Thread-Topic: [PATCH AUTOSEL for 4.4 056/162] platform/x86: dell-laptop: Fix
 bogus keyboard backlight sysfs interface
Thread-Index: AQHTz5mrt4lHNKcR2Euml7/mo0ONzg==
Date: Mon, 9 Apr 2018 00:28:23 +0000
Message-ID: <20180409002738.163941-56-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Ca2mTFSVoMLQDqEba5Ei4/EOyQJlfo7SmJQsLMLrJlwsyrmzdNHGwcKd9QlsxKVHnXS0vXhgII1TT3CSR7V/ylPYmcKgtYwyBwM6mqCsFX81RG4QIyWQd2d3QpHS2GMo5sGcrs54EgceBXv/WWhSfUGgO8ZeZB9dHCqHy+q+H8oiLmJSrgCUEwKDsD25tL2ZypEFXlD55KjLXkNmQCgCghc7v3qPlgFmSQYxZNhMRyz/GNiPC5M1KUg0jip+POEE;20:pdV1tvJW+BHFEi2uNv1irpzuJ/ceC3ft/LWqS5UwpZV/yYQpjlZDKpOyZcY/NfzQaLePfw1daQf+NpVcOSEotSJKQDBH5rms2vklnJ6qhn43ypGC5r2T+aXi+UdWvnFpKNC5SdPQwTzPviZjzP2MJ/p8EXJ7c/FDQWZKhHnoGv0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58304722-b0b6-4f1f-c9f3-08d59db1e42b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10152ED7D1BD3897797079A9FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158)(198206253151910)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vI2DTN7J8TeoQl4i1+6QEawuCikUTkxlZ2xKcoRc7Y3Qhn5GJkeV/4leCeyEwzxaN2LoxfG/daSrEeSsHvJrq3JJjW3xV7GrtJ7DLelujtJm6y9cr/KEkIxQK4jDQ9ouif+SJsk6NAlVI+682UzPPlJLIq/LHiC3eKL3t7bW+Mfxm+0J9NP3lkWyRxCSpwfIqJyCiL9DfiGTSEWiOHOtlbWsRjFw/V81l09R/9C8426XYiGbCXzD/UR5JuHuuU3F7Iqja0GLYVHzi0iQZbPuxsGAIbnio60DZM5nDDc+unJGsxt7N4+JTZMeKR+U4q24wa+jQsleIS+m4LQD6ltB/OlSdsLaRpThIpXBpIcpqKGJJvY0fdYTh1aTKr8CgDil3Xj+tiUTILSEh/dnFeOUvZDHAYywAxk+1Cg14knhaLk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <005460F09713FE4089642DE8F41EF609@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58304722-b0b6-4f1f-c9f3-08d59db1e42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:23.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogS2FpIEhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCAxYjFmZmM1N2ExYjJlZGY1OGU4MDNlNDYzOTgwYjMyNjc2NWEyMzdmIF0N
Cg0KRGVsbCBMYXRpdHVkZSAzMTYwIGRvZXMgbm90IGhhdmUga2V5Ym9hcmQgYmFja2xpZ2h0LCBi
dXQgdGhlcmUgaXMgYQ0Kc3lzZnMgaW50ZXJmYWNlIGZvciBpdCwgd2hpY2ggZG9lcyBub3RoaW5n
IGF0IGFsbC4NCg0KS0JEX0xFRF9PTl9UT0tFTiBpcyB0aGUgb25seSB0b2tlbiBjYW4gYmUgZm91
bmQuIFNpbmNlIGl0IGRvZXNuJ3QgaGF2ZQ0KS0JEX0xFRF9PRkZfVE9LRU4gb3IgS0JEX0xFRF9B
VVRPXypfVE9LRU4sIGl0IHNob3VsZCBiZSBzYWZlIHRvIGFzc3VtZQ0KYXQgbGVhc3QgdHdvIHRv
a2VucyBzaG91bGQgYmUgcHJlc2VudCB0byBzdXBwb3J0IGtleWJvYXJkIGJhY2tsaWdodC4NCk5v
dCBhbGwgbW9kZWxzIGhhdmUgT04gdG9rZW4gLSB0aGV5IG1heSBoYXZlIG11bHRpcGxlIEFVVE8g
dG9rZW5zIGluc3RlYWQuDQoNCk1vZGVscyB3aGljaCBkbyBub3QgdXNlIFNNQklPUyB0b2tlbiB0
byBjb250cm9sIGtleWJvYXJkIGJhY2tsaWdodCwgYWxzbw0KaGF2ZSB0aGlzIGlzc3VlLiBCcmln
aHRuZXNzIGxldmVsIGlzIDAgb24gdGhlc2UgbW9kZWxzLiBWZXJpZmllZCBvbiBEZWxsDQpJbnNw
aXJvbiAzNTY1Lg0KDQpSZXBvcnRzIGtleWJvYXJkIGJhY2tsaWdodCBpcyBzdXBwb3J0ZWQgb25s
eSB3aGVuIGF0IGxlYXN0IHR3byBtb2RlcyBhcmUNCnByZXNlbnQuDQoNClNpZ25lZC1vZmYtYnk6
IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NClJldmlld2VkLWJ5
OiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0K
IGRyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMgfCA2ICsrKysrLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9k
ZWxsLWxhcHRvcC5jDQppbmRleCBhYWVlYWU4MWUzYTkuLmM2ZTVjYTJiOGFlOSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCisrKyBiL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCkBAIC0xNjA4LDcgKzE2MDgsMTEgQEAgc3RhdGljIHZv
aWQga2JkX2luaXQodm9pZCkNCiAJcmV0ID0ga2JkX2luaXRfaW5mbygpOw0KIAlrYmRfaW5pdF90
b2tlbnMoKTsNCiANCi0JaWYgKGtiZF90b2tlbl9iaXRzICE9IDAgfHwgcmV0ID09IDApDQorCS8q
DQorCSAqIE9ubHkgc3VwcG9ydHMga2V5Ym9hcmQgYmFja2xpZ2h0IHdoZW4gaXQgaGFzIGF0IGxl
YXN0IHR3byBtb2Rlcy4NCisJICovDQorCWlmICgocmV0ID09IDAgJiYgKGtiZF9pbmZvLmxldmVs
cyAhPSAwIHx8IGtiZF9tb2RlX2xldmVsc19jb3VudCA+PSAyKSkNCisJICAgIHx8IGtiZF9nZXRf
dmFsaWRfdG9rZW5fY291bnRzKCkgPj0gMikNCiAJCWtiZF9sZWRfcHJlc2VudCA9IHRydWU7DQog
fQ0KIA0KLS0gDQoyLjE1LjENCg==
