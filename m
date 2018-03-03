Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120045-2-10575586843196362629
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
    t=1520120044; b=NKyF/gmSygIsJZ66F8ghE6Jqq0gO2dq40FliUtAi1RBC/fM
    Ot0qv4ajz0eAzCHOuUDaPUzo5gnm0ZVs4yBCExJOdnbiQOlFSv1HPRKD5W3iGLaq
    1u083W2DYeoT9XSviyk+O7N50ZJGX13EYt/BLl0BT4VlYU6p5KSh52mQmovuCoLh
    hr4F41mr6wPjTeg1FrJVVENxgghqRwGdMIxqR2T64x7H0StkEf3Jt2dRTwYfZ56k
    /CgSWgm5YtUBhOWy3/oOCHj7AM6wVEFMEUxXIJ9ftO4DeH39xD2dsEt3Funa2PKL
    F2vrWjWDP+dNp3f59KIfWbiA6C3L/EVyBev3fcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120044; bh=sDXSrGVRf517sRix1ox11FQGoOZdtRHC1dDlP9
    PkFAU=; b=pwuajmdDm41uIsMQNmvB5XhNZmCzNmFSf/bvi09EvnM8f2NFjHKHtV
    o1F2XIDeORWcSWFduLflZd801TuiV+j/iaKmy1+1xMs04c/i2RpTeoJqx4Ns3c1O
    PYanoLEi34neWLAOZOe6twBv6JKrcis1zRxoaV5/mysriZnp00/FRq9uUW07W/NK
    bIwVl90oDSls4Q97SCAxd/hSQlYGJZ0RGJCQof85fCUts98qYoWjvLBENeJRbwAL
    NyEw3LbzYJtFn/hxOjnXXlQaMeOB5aipeKQwHj6b4Do4KRGRMUvPWbw5qY7q5n9B
    PsO2P04dwV+9MoYOZh+DkI8mb3rgP1yQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lmYplGVw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lmYplGVw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeCCXdf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:33:35 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934095AbeCCWgG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:06 -0500
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
Subject: [PATCH AUTOSEL for 4.9 171/219] drm/edid: set ELD connector type in
 drm_edid_to_eld()
Thread-Topic: [PATCH AUTOSEL for 4.9 171/219] drm/edid: set ELD connector type
 in drm_edid_to_eld()
Thread-Index: AQHTsz8cnq9cG6nTFkCTiUJvHNGwOQ==
Date: Sat, 3 Mar 2018 22:29:37 +0000
Message-ID: <20180303222716.26640-171-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:vW/EZycUn+QrwPxdq4SiS5NYotMyxePAzE6PXJ8UQOkWVdnUhnmc3717/n9fYv8sRNAy4pyp67yrS46Lkpq9NAKs9Ufuyyy9YVDkuQjigy99dQuPu8Wqn7crjWD7mTMo+R5CweTuth3magdung/mN9WTZlA/kMTnibA9GfA2DWPswopH+JyqBXI66UP1imUtawvdTfbX5TKEt32JGm5sLGEKG9qnDFbQ5ghLfsXS4Uz3WihF0B4A0lynJ/6qthnZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46583e92-365c-4524-a2d5-08d581572637
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020AE4EAC13359DB8B4B876FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644)(767451399110)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(8666007)(6436002)(5250100002)(99286004)(3846002)(39060400002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(6306002)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(966005)(110136005)(59450400001)(7416002)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PK+ez4xugvlkLdNMRwVAPMIOevRdPfyWe5eNry4k9aCP2mpQvwdCy9g9z6kuVrES4s8S7JRCyy9alSEfO7nn4M6htLHjJ9z44ENrotlqqcqAePEkMNhEsz8WIaIF8rvNAon9Am+Q3u3KT+YoapePpH/DgOGqNbOh88wuUErTcdo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <259C8A3E51D1E244BF0436A56140E32E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46583e92-365c-4524-a2d5-08d581572637
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:37.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
L2RybS9kcm1fZWRpZC5jDQppbmRleCBjNmIyODFhYTc2MmYuLjZiMzFlMDQ3NDI3MSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2VkaWQuYw0KQEAgLTMzNDcsOCArMzM0Nyw3IEBAIEVYUE9SVF9TWU1CT0woZHJtX2VkaWRf
Z2V0X21vbml0b3JfbmFtZSk7DQogICogQGVkaWQ6IEVESUQgdG8gcGFyc2UNCiAgKg0KICAqIEZp
bGwgdGhlIEVMRCAoRURJRC1MaWtlIERhdGEpIGJ1ZmZlciBmb3IgcGFzc2luZyB0byB0aGUgYXVk
aW8gZHJpdmVyLiBUaGUNCi0gKiBDb25uX1R5cGUsIEhEQ1AgYW5kIFBvcnRfSUQgRUxEIGZpZWxk
cyBhcmUgbGVmdCBmb3IgdGhlIGdyYXBoaWNzIGRyaXZlciB0bw0KLSAqIGZpbGwgaW4uDQorICog
SERDUCBhbmQgUG9ydF9JRCBFTEQgZmllbGRzIGFyZSBsZWZ0IGZvciB0aGUgZ3JhcGhpY3MgZHJp
dmVyIHRvIGZpbGwgaW4uDQogICovDQogdm9pZCBkcm1fZWRpZF90b19lbGQoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3Rvciwgc3RydWN0IGVkaWQgKmVkaWQpDQogew0KQEAgLTM0MjYsNiAr
MzQyNSwxMiBAQCB2b2lkIGRybV9lZGlkX3RvX2VsZChzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29u
bmVjdG9yLCBzdHJ1Y3QgZWRpZCAqZWRpZCkNCiAJfQ0KIAllbGRbNV0gfD0gdG90YWxfc2FkX2Nv
dW50IDw8IDQ7DQogDQorCWlmIChjb25uZWN0b3ItPmNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RF
X0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCB8fA0KKwkgICAgY29ubmVjdG9yLT5jb25uZWN0b3JfdHlw
ZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KKwkJZWxkW0RSTV9FTERfU0FEX0NPVU5UX0NP
Tk5fVFlQRV0gfD0gRFJNX0VMRF9DT05OX1RZUEVfRFA7DQorCWVsc2UNCisJCWVsZFtEUk1fRUxE
X1NBRF9DT1VOVF9DT05OX1RZUEVdIHw9IERSTV9FTERfQ09OTl9UWVBFX0hETUk7DQorDQogCWVs
ZFtEUk1fRUxEX0JBU0VMSU5FX0VMRF9MRU5dID0NCiAJCURJVl9ST1VORF9VUChkcm1fZWxkX2Nh
bGNfYmFzZWxpbmVfYmxvY2tfc2l6ZShlbGQpLCA0KTsNCiANCi0tIA0KMi4xNC4xDQo=
