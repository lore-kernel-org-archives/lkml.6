Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497959-2-1171353378288760589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497958; b=HhlWf6mMgALQItAZwUH3vPrPKJZnQTlsvAk6qbgnEpAu9Al
    b0TE4ICkgxpCphqqmPY10WLk9HFrgh+CqeMhuPhDa4VRo6aI1Cgn9Qd1kOj+SIrN
    59vWJkCDjXF7d0BZuBzlP80Nay2wHIzjjMpINvz3GwwKCZ5RWZfdUxzr6rU3JZk2
    nNViKVbG0aTZWX3Y/I2R5rafIYx6CtFmFQ7tUQ/l4VI5ETyacgBlaohvD2SU/Ag5
    Ls46FJOICMHqMq0WVTprKApq4RRfIHQwM6ym6iZER4lLDDM77o2qGwxa7rcUoqMf
    T91LRquy9Gc3K237oM19FsMYForQOe2FoK2qR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521497958; bh=loQo/uB3IM8bqtHHzyGIEU8hkMwkeaFtTcamLw
    r3wFc=; b=X5EBG8dle7/fkXn04ZJSsYtCqaY7owafgjYPUa+uX4OjGDy8aZKX9B
    hZziE64xyfSGboVJYWbRZDu4U2ESkV7AmBt+6ypNtWMOugVG4pDH7w41Qij6Od+w
    AiekeF3l0lluewMhix7QZQ2h5LZRaXxXpPBgmkSRJ8IgxrkL1pAOmfw+il5xAZi5
    Gmy/2tA43NGwvG+ugUDPX2cd93giDYmQk+yJw15EaEFZqigdRS6caH+ESqsAD6dp
    kj1cnwqOjGhiayx5/ZVFTfvT+2SqreD1pLNWeDrLTZ8C1V1T0kcHSTRNGC3I2AMA
    mdGs/WP3vMs+orUFoZucTd+nYG2beDKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c0un4YN5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudelieegnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c0un4YN5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudelieegnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972371AbeCSWSd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:18:33 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:7883
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933721AbeCSPtn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lukas Wunner <lukas@wunner.de>,
        =?utf-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 099/124] Bluetooth: hci_bcm: Mandate presence
 of shutdown and device wake GPIO
Thread-Topic: [PATCH AUTOSEL for 4.15 099/124] Bluetooth: hci_bcm: Mandate
 presence of shutdown and device wake GPIO
Thread-Index: AQHTv5nGgcRW6Nn+lESBhriVrmjozA==
Date: Mon, 19 Mar 2018 15:48:50 +0000
Message-ID: <20180319154645.11350-99-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:KMLLSFq/hf25ypI+BKJCPXlAHbxjSvAOJ8teWgAAOP5vnRsnFI4e9i6j2IjZbjTlOjtxwebxcjM3FfcCjzKGVMdkm3te4UoaEOJlqIS/LrFw8oxn8yGTlrXejU2XDVdwAkoEHoBOs+G1Wf2oRrMkjZz0Iem7KHniMOHUNrsjh9PoHNgryE8+KBGDeA+06GwEzo0dzNrm/5UWdCPaFtd2lukaV/flTgBJINAud+OPfxk+6nC2gYs8mgO1jw89qtkT;20:a1urkWWyyKO+xKQa41R8YsUWTapQoEgaPQMxLjM92tyXNYgmlPoTQIoPhkMfrFPjHjxxOZbsw8jSis2XZM2RIxGqXqUR9bC54o1EDWY0LtzruGFFrIGmMUcdBIzg2gQQ4TzaoEawV9O0BKonlD01HM2dVt2PgI9R8E6XQh93AKE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bbee6b0-1d92-413b-84e1-08d58db106e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919A861E3D7A25B2CBB379AFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(39060400002)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JhBiBYZgp1NdklR69p0on8j3kTcTB3KNy5ny66+wdTeYV7YpbcLs7YkRKKFLRmUVk0Fiw6/L639A1CvJvDWyRDgf6ndzMVjFzfSCQmbrIITB6OU19/rF5beXquaptYwTxltjm4xD656QfVeeLGu/Q1FEZ7aWbHzNamJNBW1tNLDpF3ZNYrMapjPJIfQ4keLrG0BaN1mMNuUD+H1B4a3+KNW65GfENZD4NiXooO6yyME+YTpRmii3LK0A9ksWagcTLRBJt+s6Y+oxDctFm1tThM6RUJH97ek07koaGYq/1eD5EqwvEScLSFTuQvkbL4wf1lWPHh5WduoMkDa2xrxgIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <784D2BCA4A7F4145851F0C31F8F932DA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbee6b0-1d92-413b-84e1-08d58db106e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:50.8873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+DQoNClsgVXBzdHJlYW0gY29tbWl0
IDNlODFhNGNhNTFhMTE3MjI1MzA3OGNhN2FiZDZhOTEwNDBiOGZjZjQgXQ0KDQpDb21taXQgMDM5
NWZmYzFlZTA1ICgiQmx1ZXRvb3RoOiBoY2lfYmNtOiBBZGQgUE0gZm9yIEJDTSBkZXZpY2VzIikN
CmFtZW5kZWQgdGhpcyBkcml2ZXIgdG8gcmVxdWVzdCBhIHNodXRkb3duIGFuZCBkZXZpY2Ugd2Fr
ZSBHUElPIG9uIHByb2JlLA0KYnV0IG1hbmRhdGVkIHRoYXQgb25seSBvbmUgb2YgdGhlbSBuZWVk
IHRvIGJlIHByZXNlbnQ6DQoNCgkvKiBNYWtlIHN1cmUgYXQtbGVhc3Qgb25lIG9mIHRoZSBHUElP
IGlzIGRlZmluZWQgYW5kIHRoYXQNCgkgKiBhIG5hbWUgaXMgc3BlY2lmaWVkIGZvciB0aGlzIGlu
c3RhbmNlDQoJICovDQoJaWYgKCghZGV2LT5kZXZpY2Vfd2FrZXVwICYmICFkZXYtPnNodXRkb3du
KSB8fCAhZGV2LT5uYW1lKSB7DQoJCWRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgcGxhdGZv
cm0gZGF0YVxuIik7DQoJCXJldHVybiAtRUlOVkFMOw0KCX0NCg0KSG93ZXZlciB0aGUgc2FtZSBj
b21taXQgYWRkZWQgYSBjYWxsIHRvIGJjbV9ncGlvX3NldF9wb3dlcigpIHRvIHRoZQ0KLT5wcm9i
ZSBob29rLCB3aGljaCB1bmNvbmRpdGlvbmFsbHkgYWNjZXNzZXMgKmJvdGgqIEdQSU9zLiAgTHVj
a2lseSwNCnRoZSByZXN1bHRpbmcgTlVMTCBwb2ludGVyIGRlcmVmIHdhcyBuZXZlciByZXBvcnRl
ZCwgc3VnZ2VzdGluZyB0aGVyZSdzDQpubyBtYWNoaW5lIHdoZXJlIGVpdGhlciBHUElPIGlzIG1p
c3NpbmcuDQoNCkNvbW1pdCA4YTkyMDU2ODM3ZmQgKCJCbHVldG9vdGg6IGhjaV9iY206IEFkZCAo
cnVudGltZSlwbSBzdXBwb3J0IHRvIHRoZQ0Kc2VyZGV2IGRyaXZlciIpIHJlbW92ZWQgdGhlIGNo
ZWNrIHdoZXRoZXIgYXQgbGVhc3Qgb25lIG9mIHRoZSBHUElPcyBpcw0KcHJlc2VudCB3aXRob3V0
IHNwZWNpZnlpbmcgYSByZWFzb24uDQoNCkJlY2F1c2UgY29tbWl0IDYyYWFlZmE3ZDAzOCAoIkJs
dWV0b290aDogaGNpX2JjbTogaW1wcm92ZSB1c2Ugb2YgZ3Bpb3MNCkFQSSIpIHJlZmFjdG9yZWQg
dGhlIGRyaXZlciB0byB1c2UgZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoKSBpbnN0ZWFkIG9mDQpk
ZXZtX2dwaW9kX2dldCgpLCBvbmUgaXMgbm93IHRlbXB0ZWQgdG8gYmVsaWV2ZSB0aGF0IHRoZSBk
cml2ZXIgZG9lc24ndA0KcmVxdWlyZSAqYW55KiBvZiB0aGUgdHdvIEdQSU9zLg0KDQpXaGljaCBp
cyB3cm9uZywgdGhlIGRyaXZlciBzdGlsbCByZXF1aXJlcyBib3RoIEdQSU9zIHRvIGF2b2lkIGEg
TlVMTA0KcG9pbnRlciBkZXJlZi4gIFRvIHRoaXMgZW5kLCBlc3RhYmxpc2ggdGhlIHN0YXR1cyBx
dW8gYW50ZSBhbmQgcmVxdWVzdA0KdGhlIEdQSU9zIHdpdGggZGV2bV9ncGlvZF9nZXQoKSBhZ2Fp
bi4gIEJhaWwgb3V0IG9mIC0+cHJvYmUgaWYgZWl0aGVyDQpvZiB0aGVtIGlzIG1pc3NpbmcuDQoN
Ck9kZGx5IGVub3VnaCwgd2hlcmVhcyBiY21fZ3Bpb19zZXRfcG93ZXIoKSBhY2Nlc3NlcyB0aGUg
ZGV2aWNlIHdha2UgcGluDQp1bmNvbmRpdGlvbmFsbHksIGJjbV9zdXNwZW5kX2RldmljZSgpIGFu
ZCBiY21fcmVzdW1lX2RldmljZSgpIGRvIGNoZWNrDQpmb3IgaXRzIHByZXNlbmNlIGJlZm9yZSBh
Y2Nlc3NpbmcgaXQuICBUaG9zZSBjaGVja3MgYXJlIHN1cGVyZmx1b3VzLA0Kc28gcmVtb3ZlIHRo
ZW0uDQoNCkNjOiBGcsOpZMOpcmljIERhbmlzIDxmcmVkZXJpYy5kYW5pcy5vc3NAZ21haWwuY29t
Pg0KQ2M6IExvaWMgUG91bGFpbiA8bG9pYy5wb3VsYWluQGxpbmFyby5vcmc+DQpDYzogSGFucyBk
ZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCkNjOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz4NClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEx1a2FzIFd1bm5lciA8
bHVrYXNAd3VubmVyLmRlPg0KU2lnbmVkLW9mZi1ieTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxA
aG9sdG1hbm4ub3JnPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZp
bkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9ibHVldG9vdGgvaGNpX2JjbS5jIHwgMjQg
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMTUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9oY2lf
YmNtLmMgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtLmMNCmluZGV4IDcwN2MyZDFiODRjNy4u
YjhlZWFjNGU2ZjM1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX2JjbS5jDQor
KysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtLmMNCkBAIC01NzcsMTEgKzU3Nyw5IEBAIHN0
YXRpYyBpbnQgYmNtX3N1c3BlbmRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJfQ0KIA0K
IAkvKiBTdXNwZW5kIHRoZSBkZXZpY2UgKi8NCi0JaWYgKGJkZXYtPmRldmljZV93YWtldXApIHsN
Ci0JCWdwaW9kX3NldF92YWx1ZShiZGV2LT5kZXZpY2Vfd2FrZXVwLCBmYWxzZSk7DQotCQlidF9k
ZXZfZGJnKGJkZXYsICJzdXNwZW5kLCBkZWxheWluZyAxNSBtcyIpOw0KLQkJbWRlbGF5KDE1KTsN
Ci0JfQ0KKwlncGlvZF9zZXRfdmFsdWUoYmRldi0+ZGV2aWNlX3dha2V1cCwgZmFsc2UpOw0KKwli
dF9kZXZfZGJnKGJkZXYsICJzdXNwZW5kLCBkZWxheWluZyAxNSBtcyIpOw0KKwltZGVsYXkoMTUp
Ow0KIA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtNTkyLDExICs1OTAsOSBAQCBzdGF0aWMgaW50IGJj
bV9yZXN1bWVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCiANCiAJYnRfZGV2X2RiZyhiZGV2
LCAiIik7DQogDQotCWlmIChiZGV2LT5kZXZpY2Vfd2FrZXVwKSB7DQotCQlncGlvZF9zZXRfdmFs
dWUoYmRldi0+ZGV2aWNlX3dha2V1cCwgdHJ1ZSk7DQotCQlidF9kZXZfZGJnKGJkZXYsICJyZXN1
bWUsIGRlbGF5aW5nIDE1IG1zIik7DQotCQltZGVsYXkoMTUpOw0KLQl9DQorCWdwaW9kX3NldF92
YWx1ZShiZGV2LT5kZXZpY2Vfd2FrZXVwLCB0cnVlKTsNCisJYnRfZGV2X2RiZyhiZGV2LCAicmVz
dW1lLCBkZWxheWluZyAxNSBtcyIpOw0KKwltZGVsYXkoMTUpOw0KIA0KIAkvKiBXaGVuIHRoaXMg
ZXhlY3V0ZXMsIHRoZSBkZXZpY2UgaGFzIHdva2VuIHVwIGFscmVhZHkgKi8NCiAJaWYgKGJkZXYt
PmlzX3N1c3BlbmRlZCAmJiBiZGV2LT5odSkgew0KQEAgLTc3OSwxNCArNzc1LDEyIEBAIHN0YXRp
YyBpbnQgYmNtX2dldF9yZXNvdXJjZXMoc3RydWN0IGJjbV9kZXZpY2UgKmRldikNCiANCiAJZGV2
LT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LT5kZXYsIE5VTEwpOw0KIA0KLQlkZXYtPmRldmljZV93
YWtldXAgPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYtPmRldiwNCi0JCQkJCQkgICAgICJk
ZXZpY2Utd2FrZXVwIiwNCi0JCQkJCQkgICAgIEdQSU9EX09VVF9MT1cpOw0KKwlkZXYtPmRldmlj
ZV93YWtldXAgPSBkZXZtX2dwaW9kX2dldChkZXYtPmRldiwgImRldmljZS13YWtldXAiLA0KKwkJ
CQkJICAgIEdQSU9EX09VVF9MT1cpOw0KIAlpZiAoSVNfRVJSKGRldi0+ZGV2aWNlX3dha2V1cCkp
DQogCQlyZXR1cm4gUFRSX0VSUihkZXYtPmRldmljZV93YWtldXApOw0KIA0KLQlkZXYtPnNodXRk
b3duID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LT5kZXYsICJzaHV0ZG93biIsDQotCQkJ
CQkJR1BJT0RfT1VUX0xPVyk7DQorCWRldi0+c2h1dGRvd24gPSBkZXZtX2dwaW9kX2dldChkZXYt
PmRldiwgInNodXRkb3duIiwgR1BJT0RfT1VUX0xPVyk7DQogCWlmIChJU19FUlIoZGV2LT5zaHV0
ZG93bikpDQogCQlyZXR1cm4gUFRSX0VSUihkZXYtPnNodXRkb3duKTsNCiANCi0tIA0KMi4xNC4x
DQo=
