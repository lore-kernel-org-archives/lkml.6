Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124671-2-7042781738341936304
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
    t=1520124670; b=I3eH4hlRiUwRJYsCvgthfofBq1FwM8IKqp295nsbQ9bYTJ2
    HyNas2ii11wU4263O2adh1x5ReKOyIHiQOWriYFdQR2lajGrBzKZb6AMAyMZz2SY
    ah0H1SfAqJnYLG/R8a5aKsk8OICbkHAC7ylpjX6Uf8ak77JOoTIWYVdjXAZSxL2T
    ikfdNmYvbR5WpIC8WyFBsdPZw06Qhc8xHe9SbhSW/1Qsrx0Ey7fJQrW5H3qcS2sy
    Vl+0SdhAJvjBi4LQ5I8iuE1/38dK8xW7GuVgOPwLug59WvU5lkzVmBAejRtSdVY0
    4cVS9px8ozYWrSDntBRkUSRjsqJ8dE3qrWRhMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124670; bh=pmv/COAYn8EKtP/pJwMV3RXxLtTLd45WGiMa0S
    yEhaU=; b=VLww5pNP4yJA5qDSLJwobJOHMZI9KicwXVIqtDs2AVfX64nvLdKq0q
    YF5aZU494TY3otQkvddM65Mp7FV/u0nSWTKCB+Jog+0QRm/Fa+/wP7X1abU5YbSm
    sjDBpZrwuTo7K6xKOZtC3PrlfYskV4HN6u8fCLD9h7kwzBlzVisgw8cUGpH5mdiw
    8dBFTIhVDLKUoSfeCiwpDvmA7H39EUxluww0Go6TdD+JK6kTXEnEiLbKW1V0Mr+2
    KezlBP/Tra3UtIKbrp113GYSJgTTix2t2JtXYtYRxKGvAhQMijov0bz/87++REjC
    g1EibnPeQHVe3xiI6MFiYgo20wiVYqhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egQAj8Co x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egQAj8Co x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbeCDAvD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:51:03 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:60008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752205AbeCCWYP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:15 -0500
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
Subject: [PATCH AUTOSEL for 4.15 003/102] drm/edid: set ELD connector type in
 drm_edid_to_eld()
Thread-Topic: [PATCH AUTOSEL for 4.15 003/102] drm/edid: set ELD connector
 type in drm_edid_to_eld()
Thread-Index: AQHTsz5aA+H4hrP7XUuNyxX4a6mkIQ==
Date: Sat, 3 Mar 2018 22:24:10 +0000
Message-ID: <20180303222318.26006-3-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:72dSWyWCl3HRxwL6LAno+PXQ4sYONxwsbzmZ+SRIhIlhDXxdB0XXty8tCdAy8LvEQweS9PKVkk3r/vRU/cmukVrovJDlLIAWhySifk2VtIL9D6EIaMHyvDOuMxb5z9vEpln+S/LVWV3p+KSFuSwUZi3lzryl0DnJ7vTGehc3VqS22gMhY0TYq6bvtkP1R/xexeWlrZb9kTVu+VJ4kOhp1xzYb2ED54YO12QZkPhUKw1IPAsPzVh0MOS/nWsApPZd
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10acbfca-2f2c-4b31-65e1-08d581557e3a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10363428D6675CEED24390B8FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644)(767451399110)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(39060400002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(8666007)(6306002)(2501003)(966005)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(7416002)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: aYoFzvT/irbF6vMxzSVwMQLC2uIZS+IQcmXUIx6usvtPpNkzMuvnxTaXIT8eSSOq6M6M7sDrfrLNUgi3L7OrgTZj6yG1JdgidTZTfj5sREebBHbOGF7o21SO16cTBB0bF96jSiseifbh67jZdJXTHloc9GqXFzwucZjFhBPKgbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E691D166B5F6E24D945C0C2C84EED923@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10acbfca-2f2c-4b31-65e1-08d581557e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:10.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
L2RybS9kcm1fZWRpZC5jDQppbmRleCAxNmZiNzZiYTY1MDkuLjk2YWZkYjRkM2VjZiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2VkaWQuYw0KQEAgLTM4NDMsOCArMzg0Myw3IEBAIEVYUE9SVF9TWU1CT0woZHJtX2VkaWRf
Z2V0X21vbml0b3JfbmFtZSk7DQogICogQGVkaWQ6IEVESUQgdG8gcGFyc2UNCiAgKg0KICAqIEZp
bGwgdGhlIEVMRCAoRURJRC1MaWtlIERhdGEpIGJ1ZmZlciBmb3IgcGFzc2luZyB0byB0aGUgYXVk
aW8gZHJpdmVyLiBUaGUNCi0gKiBDb25uX1R5cGUsIEhEQ1AgYW5kIFBvcnRfSUQgRUxEIGZpZWxk
cyBhcmUgbGVmdCBmb3IgdGhlIGdyYXBoaWNzIGRyaXZlciB0bw0KLSAqIGZpbGwgaW4uDQorICog
SERDUCBhbmQgUG9ydF9JRCBFTEQgZmllbGRzIGFyZSBsZWZ0IGZvciB0aGUgZ3JhcGhpY3MgZHJp
dmVyIHRvIGZpbGwgaW4uDQogICovDQogdm9pZCBkcm1fZWRpZF90b19lbGQoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3Rvciwgc3RydWN0IGVkaWQgKmVkaWQpDQogew0KQEAgLTM5MjUsNiAr
MzkyNCwxMiBAQCB2b2lkIGRybV9lZGlkX3RvX2VsZChzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29u
bmVjdG9yLCBzdHJ1Y3QgZWRpZCAqZWRpZCkNCiAJfQ0KIAllbGRbNV0gfD0gdG90YWxfc2FkX2Nv
dW50IDw8IDQ7DQogDQorCWlmIChjb25uZWN0b3ItPmNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RF
X0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCB8fA0KKwkgICAgY29ubmVjdG9yLT5jb25uZWN0b3JfdHlw
ZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KKwkJZWxkW0RSTV9FTERfU0FEX0NPVU5UX0NP
Tk5fVFlQRV0gfD0gRFJNX0VMRF9DT05OX1RZUEVfRFA7DQorCWVsc2UNCisJCWVsZFtEUk1fRUxE
X1NBRF9DT1VOVF9DT05OX1RZUEVdIHw9IERSTV9FTERfQ09OTl9UWVBFX0hETUk7DQorDQogCWVs
ZFtEUk1fRUxEX0JBU0VMSU5FX0VMRF9MRU5dID0NCiAJCURJVl9ST1VORF9VUChkcm1fZWxkX2Nh
bGNfYmFzZWxpbmVfYmxvY2tfc2l6ZShlbGQpLCA0KTsNCiANCi0tIA0KMi4xNC4xDQo=
