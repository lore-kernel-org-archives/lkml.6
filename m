Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123406-2-6738384449518377635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123403; b=GQlS9d9vyaSAPfwJAahqSzjyB0vVpLftQ0VkyGBAajhYT4Y
    pIdFz9ucCiSXwYqwE0cm73FZQsP71pJkZT9+F5QPZfFda0PE7foqgl98Jt3/GuMw
    xS/przWg1Y1hevnU7Qptra+bs8VRo+46SJInNxT1SIYQAU0zjIAJAKXlTzj4jLUj
    OVtzXPBZdZh9cCDUjQ8zt1knCUo6t7f5URXrl1RdVx9ZEA3J8w3snjWZ78mQMofS
    h33kATpsgHNXXxTosn6N0yxbH32abaOmqFq5bXPjHLyMuEjtQ1lmb2OHTfGN/p+H
    RdP8BJFh4Ujg+cUDiCh5Y+US81GuxrHE36eRmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-id:content-transfer-encoding:mime-version
    :sender:list-id; s=arctest; t=1520123403; bh=yMp0ou4pvkynA+fotgI
    L26xqsCgN5tNN+2tzXzWQYtM=; b=f9USjmoYMJNcRRA0/7PfYKaKyf/D6nQnQLC
    UjnDpe6h7+SvqlS4H6QDGFlXXxUIAK8piSgmn4CuDCpV4pjSPQioU+bk9GUSh04l
    bjpXXhOuzR1EdGx2FDy8RDIx5PO10upaSXA418nNvIiDZ2j9hmOZCdO6fwVjiMbo
    6UyatyGs67PjA4HAS1WTqNx/QmqfKyQHEtVYLXH2GwiOOH2F/GpTUVMepv4bXsKW
    VBpZ0XSRhAZrcOPJLEk4O3/7infAC9PXYGcw021C84y4LNJFHQoKOl/Q9TesAOEw
    1PZg+jhNWXCaUKIuIuvA3pMXMMNL+zCtem/abucpTIJvEteKJ8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Op100e+g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Op100e+g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeCDA3r (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:29:47 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933055AbeCCW2F (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jani Nikula <jani.nikula@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mark Yao <mark.yao@rock-chips.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 01/84] drm/edid: set ELD connector type in
 drm_edid_to_eld()
Thread-Topic: [PATCH AUTOSEL for 4.14 01/84] drm/edid: set ELD connector type
 in drm_edid_to_eld()
Thread-Index: AQHTsz6bQ9H5eSk6fEWbZkUXHenDLg==
Date: Sat, 3 Mar 2018 22:26:00 +0000
Message-ID: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:b1XX7Ft5NItrKcn6Gd0p/eDZDaeLc4s9jL7VoR11YDZRXdAPq3nP/AELalb4SDmLVfOkhNu/apyWnejBx20oBkt1u79vpS09iXfbgxpOUT2tdeKWHKnT59B5wxx9Mew8IpJ2yYGZd/FarVetqDa+VjSe17GJRghdjoVp24tKHn1AEhM59PseH+Dh7buD09rtITopOCfkqXR/RgjhsPoAH3S0/Butt4/x35VyK0lSKHGJZh/OiB+HczcAGT33+C6Q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91803d2c-d33b-4b3b-3d20-08d581560336
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB066CD228CBE3A2A75585C2FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644)(767451399110)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(7416002)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(966005)(7736002)(66066001)(39060400002)(54906003)(8666007)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(6306002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YjwQ6GjKBM5O/bLz/qrwhmy47Dg3VMaFppDl8KIsfF2gZCgUQoRWX/bXl8IwqMcOVFkoxp67GNDHJCKKTyncFWkqUuMQbZ8RkzQhwZ6OYy4K3S+2vVFQTCvszqy2ipq/Qqs7I3moNrQFL7pUyiDV8fARga2BzThx6lytr6XQBBw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7799C23F1C4DDF4B9CF703DD0B15690B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91803d2c-d33b-4b3b-3d20-08d581560336
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:00.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGludGVsLmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgMWQxYzM2NjUwNzUyYjdmYjgxY2VlNTE1YTliYmE0MTMxY2FjNGI3YyBdDQoNClNpbmNl
IGRybV9lZGlkX3RvX2VsZCgpIGtub3dzIHRoZSBjb25uZWN0b3IgdHlwZSwgd2UgY2FuIHNldCB0
aGUgdHlwZSBpbg0KRUxEIHdoaWxlIGF0IGl0LiBNb3N0IGNvbm5lY3RvcnMgdGhpcyBnZXRzIGNh
bGxlZCBvbiBhcmUgbm90IERQDQplbmNvZGVycywgYW5kIHdpdGggdGhlIEhETUkgdHlwZSBiZWlu
ZyAwLCB0aGlzIGRvZXMgbm90IGNoYW5nZSBiZWhhdmlvdXINCmZvciBub24tRFAuDQoNCkZvciBp
OTE1IGhhdmluZyB0aGlzIGluIHBsYWNlIGVhcmxpZXIgd291bGQgaGF2ZSBzYXZlZCBhIGNvbnNp
ZGVyYWJsZQ0KYW1vdW50IG9mIGRlYnVnZ2luZyB0aGF0IGxlYWQgdG8gdGhlIGZpeCAyZDhmNjMy
OTdiOWYgKCJkcm0vaTkxNTogYWx3YXlzDQp1cGRhdGUgRUxEIGNvbm5lY3RvciB0eXBlIGFmdGVy
IGdldCBtb2RlcyIpLiBJIGRvbid0IHNlZSBvdGhlciBkcml2ZXJzLA0KZXZlbiB0aGUgb25lcyBj
YWxsaW5nIGRybV9lZGlkX3RvX2VsZCgpIG9uIERQIGNvbm5lY3RvcnMsIHNldHRpbmcgdGhlDQpj
b25uZWN0b3IgdHlwZSBpbiBFTEQuDQoNCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KQ2M6IEFyY2hpdCBUYW5lamEgPGFyY2hpdHRAY29kZWF1cm9yYS5vcmc+DQpDYzogQW5k
cnplaiBIYWpkYSA8YS5oYWpkYUBzYW1zdW5nLmNvbT4NCkNjOiBSdXNzZWxsIEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az4NCkNjOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KQ2M6IFBo
aWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQpDYzogQmVuIFNrZWdncyA8YnNr
ZWdnc0ByZWRoYXQuY29tPg0KQ2M6IE1hcmsgWWFvIDxtYXJrLnlhb0Byb2NrLWNoaXBzLmNvbT4N
CkNjOiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4NCkNj
OiBWaW5jZW50IEFicmlvdSA8dmluY2VudC5hYnJpb3VAc3QuY29tPg0KQ2M6IFRoaWVycnkgUmVk
aW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+DQpDYzogRXJpYyBBbmhvbHQgPGVyaWNAYW5o
b2x0Lm5ldD4NClJldmlld2VkLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGlu
dXguaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCkFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29t
Pg0KU2lnbmVkLW9mZi1ieTogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGludGVsLmNvbT4NCkxp
bms6IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC9tc2dpZC9kNTI3YjMx
NjE5NTI4YzQ3N2MyYzEzNmYyNWNkZjExOGJjMGNmYzFkLjE1MDk1NDU2NDEuZ2l0Lmphbmkubmlr
dWxhQGludGVsLmNvbQ0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZp
bkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMgfCA5ICsr
KysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9kcm1fZWRpZC5jDQppbmRleCBkNTJjOTc1OGQ4Y2YuLjFmMWZkMzEzOWM1YiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2VkaWQuYw0KQEAgLTM4MjMsOCArMzgyMyw3IEBAIEVYUE9SVF9TWU1CT0woZHJtX2VkaWRf
Z2V0X21vbml0b3JfbmFtZSk7DQogICogQGVkaWQ6IEVESUQgdG8gcGFyc2UNCiAgKg0KICAqIEZp
bGwgdGhlIEVMRCAoRURJRC1MaWtlIERhdGEpIGJ1ZmZlciBmb3IgcGFzc2luZyB0byB0aGUgYXVk
aW8gZHJpdmVyLiBUaGUNCi0gKiBDb25uX1R5cGUsIEhEQ1AgYW5kIFBvcnRfSUQgRUxEIGZpZWxk
cyBhcmUgbGVmdCBmb3IgdGhlIGdyYXBoaWNzIGRyaXZlciB0bw0KLSAqIGZpbGwgaW4uDQorICog
SERDUCBhbmQgUG9ydF9JRCBFTEQgZmllbGRzIGFyZSBsZWZ0IGZvciB0aGUgZ3JhcGhpY3MgZHJp
dmVyIHRvIGZpbGwgaW4uDQogICovDQogdm9pZCBkcm1fZWRpZF90b19lbGQoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3Rvciwgc3RydWN0IGVkaWQgKmVkaWQpDQogew0KQEAgLTM5MDUsNiAr
MzkwNCwxMiBAQCB2b2lkIGRybV9lZGlkX3RvX2VsZChzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29u
bmVjdG9yLCBzdHJ1Y3QgZWRpZCAqZWRpZCkNCiAJfQ0KIAllbGRbNV0gfD0gdG90YWxfc2FkX2Nv
dW50IDw8IDQ7DQogDQorCWlmIChjb25uZWN0b3ItPmNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RF
X0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCB8fA0KKwkgICAgY29ubmVjdG9yLT5jb25uZWN0b3JfdHlw
ZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KKwkJZWxkW0RSTV9FTERfU0FEX0NPVU5UX0NP
Tk5fVFlQRV0gfD0gRFJNX0VMRF9DT05OX1RZUEVfRFA7DQorCWVsc2UNCisJCWVsZFtEUk1fRUxE
X1NBRF9DT1VOVF9DT05OX1RZUEVdIHw9IERSTV9FTERfQ09OTl9UWVBFX0hETUk7DQorDQogCWVs
ZFtEUk1fRUxEX0JBU0VMSU5FX0VMRF9MRU5dID0NCiAJCURJVl9ST1VORF9VUChkcm1fZWxkX2Nh
bGNfYmFzZWxpbmVfYmxvY2tfc2l6ZShlbGQpLCA0KTsNCiANCi0tIA0KMi4xNC4xDQo=
