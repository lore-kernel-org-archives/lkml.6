Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118265-2-9012890516955063489
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
    t=1520118264; b=PBTAlKBEjtJs9PJh839oJSkJvCkBH7+1eBgEELk/Vdnas6q
    bdJGe/jcVAKFung8LJg9n6XdbdiDeN8nkIh0xXvJhom7GLVkMk0JOA/TIjt0BlXt
    IOkwBYtS0Rs6FSCz5Tvu1GWbdMa5C/TKN4X/p6kY7ctNHha2nAl8e/xjkRBX/6ku
    hiwKEmymve646C1P1I+RTtS/EHPdjdAe4XB7/MsPuTpcC8HDR+kyvcEhgQO2gJmm
    IwctFdRcCzjbAC7m9JsVJz23Fhe84AhK8poUiyCd9WGj8mMvG4pr1LeU3TM50Sb6
    v+R+GTySisEDQudSQ5F7mvalcSJ83fNe66DRbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520118264; bh=xFc+7Dt65l1JBmT8QzO7U2cQ1TSYxKh11MlRyy
    1zwTw=; b=u4aeNIZXEwJyw8TD77NYaCyOZMZPROtKP4ZVJOE43T6oTIPQ+/tYMh
    NQNJwMs+8HWQ5sIh4MMTLe3P06o7UH+ydXnnUprRGYzgm+g+HY+ZAfmpEuK+uJna
    09YTlfa5P0jnfa7gpSprlQfsGN7ATgS2eeusCYzKANqqi28H1CFLliQWdo2TohO2
    no6aLZMMiTFslFZizqCXEOkuqPke/4PY+JVTqmYminhcnrloBqlPF9x2C9yQJY/G
    UXR9kpAj2A2Xo6utJPPCJe9XVRM6E3g6AcigORWXxPN+51x0a+JS+snf/VusxEFh
    sQK9DkySSrc97r6t+CkAoFVnQdrtjwGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uh17mzvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uh17mzvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934567AbeCCXED (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:04:03 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935219AbeCCWkP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:15 -0500
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
Subject: [PATCH AUTOSEL for 4.4 084/115] drm/edid: set ELD connector type in
 drm_edid_to_eld()
Thread-Topic: [PATCH AUTOSEL for 4.4 084/115] drm/edid: set ELD connector type
 in drm_edid_to_eld()
Thread-Index: AQHTsz9mkalnUr+8skiL0/p2xWfWAw==
Date: Sat, 3 Mar 2018 22:31:40 +0000
Message-ID: <20180303223010.27106-84-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:Bb+5DWeZoy4dVq6Kyw/hqzAv8E8fSarTUT8APelzOAc4Xj3F3sm0nwP67XiwGUi68ValLck+bGpYf+bCvjE6ylRC3PggwEN3hY9M9+z0ieIrvh0GRv+Vmr4lxhwR1nlAx2IhshpDijAuTq4vIjNLVEq44l4Fr2u1bhqNgm/5pkrpp95CeSNwkTLOmWMhdcV/g+k4/hLfsc6SfBM8eiEEZGpHZx5tznwPZyaI5mqtwaov4xvaZoG0QLohn8XRI0z8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c40ca72a-ea4f-41d4-3608-08d58157b821
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103380C554D1726C9645B041FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644)(767451399110)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(8666007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(7416002)(66066001)(14454004)(39060400002)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: x7+5+d3a8SVIswaRyW/tfFL0phhsL3PqLEpxB45Mj3yxRx5975OIvV+2drH9EMMkK+NQdssXJewo1xsy6tIeunl5ocxjchGDGCptCuyq0Z9sAgxQvPvMwS9isbkZmjReNU5pNNPosiBLrIPam/6QNtXDdEoinsLEypkOzPyUgBU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39F8B6D622CDA4C92C6197B78F074EE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40ca72a-ea4f-41d4-3608-08d58157b821
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:40.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
L2RybS9kcm1fZWRpZC5jDQppbmRleCBjNjQxZWQ5NDcwZTEuLjcyNGY3Y2Y1MjI1MyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2VkaWQuYw0KQEAgLTMyMTksOCArMzIxOSw3IEBAIG1vbml0b3JfbmFtZShzdHJ1Y3QgZGV0
YWlsZWRfdGltaW5nICp0LCB2b2lkICpkYXRhKQ0KICAqIEBlZGlkOiBFRElEIHRvIHBhcnNlDQog
ICoNCiAgKiBGaWxsIHRoZSBFTEQgKEVESUQtTGlrZSBEYXRhKSBidWZmZXIgZm9yIHBhc3Npbmcg
dG8gdGhlIGF1ZGlvIGRyaXZlci4gVGhlDQotICogQ29ubl9UeXBlLCBIRENQIGFuZCBQb3J0X0lE
IEVMRCBmaWVsZHMgYXJlIGxlZnQgZm9yIHRoZSBncmFwaGljcyBkcml2ZXIgdG8NCi0gKiBmaWxs
IGluLg0KKyAqIEhEQ1AgYW5kIFBvcnRfSUQgRUxEIGZpZWxkcyBhcmUgbGVmdCBmb3IgdGhlIGdy
YXBoaWNzIGRyaXZlciB0byBmaWxsIGluLg0KICAqLw0KIHZvaWQgZHJtX2VkaWRfdG9fZWxkKHN0
cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsIHN0cnVjdCBlZGlkICplZGlkKQ0KIHsNCkBA
IC0zMjkzLDYgKzMyOTIsMTIgQEAgdm9pZCBkcm1fZWRpZF90b19lbGQoc3RydWN0IGRybV9jb25u
ZWN0b3IgKmNvbm5lY3Rvciwgc3RydWN0IGVkaWQgKmVkaWQpDQogCX0NCiAJZWxkWzVdIHw9IHNh
ZF9jb3VudCA8PCA0Ow0KIA0KKwlpZiAoY29ubmVjdG9yLT5jb25uZWN0b3JfdHlwZSA9PSBEUk1f
TU9ERV9DT05ORUNUT1JfRGlzcGxheVBvcnQgfHwNCisJICAgIGNvbm5lY3Rvci0+Y29ubmVjdG9y
X3R5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkNCisJCWVsZFtEUk1fRUxEX1NBRF9DT1VO
VF9DT05OX1RZUEVdIHw9IERSTV9FTERfQ09OTl9UWVBFX0RQOw0KKwllbHNlDQorCQllbGRbRFJN
X0VMRF9TQURfQ09VTlRfQ09OTl9UWVBFXSB8PSBEUk1fRUxEX0NPTk5fVFlQRV9IRE1JOw0KKw0K
IAllbGRbRFJNX0VMRF9CQVNFTElORV9FTERfTEVOXSA9DQogCQlESVZfUk9VTkRfVVAoZHJtX2Vs
ZF9jYWxjX2Jhc2VsaW5lX2Jsb2NrX3NpemUoZWxkKSwgNCk7DQogDQotLSANCjIuMTQuMQ0K
