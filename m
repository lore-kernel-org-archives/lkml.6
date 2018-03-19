Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497902-2-16253212355040250422
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
    t=1521497901; b=SUQVmLDL/1BHdAbS2pfHRI0BUjDiSm1eNZ5weTqo203RTDe
    Qg9wq5eY4EH+AbzDdHL1Vrg4Uprm+YxJSXULWdtMTWJM0CiBFgiAhmU+o12IZdLf
    nVcdhvTKdqQtGbuvliQZiQdw6u+4F/1YWOo3gk/INtP/ebE1/PMV/N0GFU1LuFxL
    bwtyETxEgUvdqhJlF7eL2Pehe/sgtdOAxulDSVwayGknCw/K0xfvJbkbeabr21kz
    tCGpQ1xoZbWMX4IrYo15S28H6nsmr+705OrUJd6Pf7F6cvdvtiE68VlP3q2b0U72
    039a6a2QKBoCGHoPUHGIRjtH9qH+1oN0pc5UaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521497901; bh=PZ8GOgC23qphzL2HGDG99OlOgZEFWGRH/xY+gt
    hJIfQ=; b=sAT9aROkc/Q5ypbuplNyg+AKxF4fCpS6Fa2R45VCqv2dBoRf2cp4qW
    aKAZRWjl+/xgateQHwn+rMcohaXhcAVQPSm07n4V9bzK3i+unUdiiLlpbcBhFZ1z
    d6MKSRXhHehch0avS0R9rdWgOZawSMMJQ6nrs5arX4JdSsha8MLSQME2mgFa2413
    pLrS5vSV9vv4bnyoUw3OttFLnD9mIVQRPYLRN2sqjxV6tiNmTNoeYye8cZxbLfab
    8NOA8WNZzTkH5P2LmgBoQMUphWq65pvMjCeYsFf7uek9eWYIm1WedWi5UsoEpdQd
    hrC0vmPWkbYXv/ZQqo5oKgEeAxUuCVPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UxrSLdWw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehjeehnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UxrSLdWw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehjeehnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972210AbeCSWRV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:17:21 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:7883
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933985AbeCSPtt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?Um9uYWxkIFRzY2hhbMOkcg==?= <ronald@innovation.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 100/124] Bluetooth: hci_bcm: Validate IRQ
 before using it
Thread-Topic: [PATCH AUTOSEL for 4.15 100/124] Bluetooth: hci_bcm: Validate
 IRQ before using it
Thread-Index: AQHTv5nHIDv3fJyLV0aMvSmRe0XLZA==
Date: Mon, 19 Mar 2018 15:48:51 +0000
Message-ID: <20180319154645.11350-100-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:R8jd3bksdKehJ4JajWKSxtS+JCO++uMZTXS78C7ZQHjxlPxA5jMQdvdqY7jnnDSIxDHWeP9YnoqidB7xvrSVqGx6ZMesmjjEvAAMWenLZbDzzvvPJBsTdkOm1NPbbePYbRen8N0XhmILRzaP2Ri6e3hdI4/afzayqlAFRnUxd2xyXR5l79iyd1642AIhsaob82GOCx5jTe5JWsrC4NGKK2Mq9pk5zUNzrs8OfQ1qnL5hfPAwNg8ttjlJVWXcZCdh;20:qqM0dgIT7e3kOY4CstlbikBbTPZ7gp7CGu9nrNnTViLiBv7qiHWP/cCcS/qFWHh6BTB+ecjyMV4a9qNX71HAwTt53PNk+lrMQEMfNEXI+Io2/GFVU0GetVdTFmCdiY6l4r9yAtnSeqMm7gDfDlwWrvDwjmtXlnQoCJlxF9n3AQ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ba7ecc-de14-4422-2a73-08d58db1073e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09199FCB1D73AB5A97084CBDFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(15650500001)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(5890100001)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CFEK+0Odvw5Pq8bI4Xv3YDN1cgb1OMsPhqYRtSUM6smy4XP0ddfHN889r3pQFQzPA/5CB9jBXv2LH/7g5YYUcMUVqbab8ihJnOwBIqic4LGrb436sN7lfI3W12fXbUgHBdvKLDbgoW6309Gmij5e7vLrFueB1kAws2ZyKHQrZEHhcxPHIHKcSxJqVVxSF8v/Nk6kmPxXz5wGSrl8C4dpumxh7zvw7N6wj2DuZl++ngsI7vgvECt/J+oXPh47uLmN34HapjdrRbbi9x0e/K4O7y9uhLvIO8JVvgdYlwvsj64tOC3aWBt3eMfldt2LYa++m7m/rqrBdhAP7L+yJyu91Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D5CEE6FB7AD964DA1F1C2958B3A6CB2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba7ecc-de14-4422-2a73-08d58db1073e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:51.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogUm9uYWxkIFRzY2hhbMOkciA8cm9uYWxkQGlubm92YXRpb24uY2g+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDRhNTlmMWZhYjkxZTk0NDVlMzRjNjlkOGU0NDAxYTBkNmJkYmU5MTQgXQ0KDQpU
aGUgLT5jbG9zZSwgLT5zdXNwZW5kIGFuZCAtPnJlc3VtZSBob29rcyBhc3N1bWUgcHJlc2VuY2Ug
b2YgYSB2YWxpZCBJUlENCmlmIHRoZSBkZXZpY2UgaXMgd2FrZXVwIGNhcGFibGUuICBIb3dldmVy
IGl0J3MgZW50aXJlbHkgcG9zc2libGUgdGhhdA0Kd2FrZXVwIHdhcyBlbmFibGVkIGJ5IHNvbWUg
b3RoZXIgZW50aXR5IGJlc2lkZXMgdGhpcyBkcml2ZXIgYW5kIGluIHRoaXMNCmNhc2UgdGhlIHVz
ZXIgd2lsbCBnZXQgYSBXQVJOIHNwbGF0IGlmIG5vIHZhbGlkIElSUSB3YXMgZm91bmQuICBBdm9p
ZCBieQ0KY2hlY2tpbmcgaWYgdGhlIElSUSBpcyB2YWxpZCwgaS5lLiA+IDAuDQoNCkNhc2UgaW4g
cG9pbnQ6ICBPbiByZWNlbnQgTWFjQm9vayBQcm9zLCB0aGUgQmx1ZXRvb3RoIGRldmljZSBsYWNr
cyBhbg0KSVJRIChiZWNhdXNlIGhvc3Qgd2FrZXVwIGlzIGhhbmRsZWQgYnkgdGhlIFNNQywgaW5k
ZXBlbmRlbnRseSBvZiB0aGUNCm9wZXJhdGluZyBzeXN0ZW0pLCBidXQgaXQgZG9lcyBwb3NzZXNz
IGEgX1BSVyBtZXRob2QgKHdoaWNoIHNwZWNpZmllcw0KdGhlIFNNQydzIEdQRSBhcyB3YWtlIGV2
ZW50KS4gIFRoZSBBQ1BJIGNvcmUgdGhlcmVmb3JlIGF1dG9tYXRpY2FsbHkNCm1hcmtzIHRoZSBw
aHlzaWNhbCBCbHVldG9vdGggZGV2aWNlIHdha2V1cCBjYXBhYmxlIHVwb24gYmluZGluZyBpdCB0
bw0KaXRzIEFDUEkgY29tcGFuaW9uOg0KDQpkZXZpY2Vfc2V0X3dha2V1cF9jYXBhYmxlKzB4OTYv
MHhiMA0KYWNwaV9iaW5kX29uZSsweDI4YS8weDMxMA0KYWNwaV9wbGF0Zm9ybV9ub3RpZnkrMHgy
MC8weGEwDQpkZXZpY2VfYWRkKzB4MjE1LzB4NjkwDQpzZXJkZXZfZGV2aWNlX2FkZCsweDU3LzB4
ZjANCmFjcGlfc2VyZGV2X2FkZF9kZXZpY2UrMHhjOS8weDExMA0KYWNwaV9uc193YWxrX25hbWVz
cGFjZSsweDEzMS8weDI4MA0KYWNwaV93YWxrX25hbWVzcGFjZSsweGY1LzB4MTNkDQpzZXJkZXZf
Y29udHJvbGxlcl9hZGQrMHg2Zi8weDExMA0Kc2VyZGV2X3R0eV9wb3J0X3JlZ2lzdGVyKzB4OTgv
MHhmMA0KdHR5X3BvcnRfcmVnaXN0ZXJfZGV2aWNlX2F0dHJfc2VyZGV2KzB4M2EvMHg3MA0KdWFy
dF9hZGRfb25lX3BvcnQrMHgyNjgvMHg1MDANCnNlcmlhbDgyNTBfcmVnaXN0ZXJfODI1MF9wb3J0
KzB4MzJlLzB4NDkwDQpkdzgyNTBfcHJvYmUrMHg0NmMvMHg3MjANCnBsYXRmb3JtX2Rydl9wcm9i
ZSsweDM1LzB4OTANCmRyaXZlcl9wcm9iZV9kZXZpY2UrMHgzMDAvMHg0NTANCmJ1c19mb3JfZWFj
aF9kcnYrMHg2Ny8weGIwDQpfX2RldmljZV9hdHRhY2grMHhkZS8weDE2MA0KYnVzX3Byb2JlX2Rl
dmljZSsweDljLzB4YjANCmRldmljZV9hZGQrMHg0NDgvMHg2OTANCnBsYXRmb3JtX2RldmljZV9h
ZGQrMHgxMGUvMHgyNjANCm1mZF9hZGRfZGV2aWNlKzB4MzkyLzB4NGMwDQptZmRfYWRkX2Rldmlj
ZXMrMHhiMS8weDExMA0KaW50ZWxfbHBzc19wcm9iZSsweDJhOS8weDYxMCBbaW50ZWxfbHBzc10N
CmludGVsX2xwc3NfcGNpX3Byb2JlKzB4N2EvMHhhOCBbaW50ZWxfbHBzc19wY2ldDQoNClJldmll
d2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4NClNpZ25lZC1vZmYtYnk6IFJvbmFsZCBUc2NoYWzDpHIgPHJvbmFsZEBpbm5vdmF0aW9uLmNo
Pg0KW2x1a2FzOiBmaXggdXAgLT5zdXNwZW5kIGFuZCAtPnJlc3VtZSBhcyB3ZWxsLCBhZGQgY29t
bWl0IG1lc3NhZ2VdDQpTaWduZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5k
ZT4NClNpZ25lZC1vZmYtYnk6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY20uYyB8IDYgKysrLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY20uYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY20u
Yw0KaW5kZXggYjhlZWFjNGU2ZjM1Li41NzM1OWU4Y2JhN2UgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2JsdWV0b290aC9oY2lfYmNtLmMNCisrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY20uYw0K
QEAgLTM3OSw3ICszNzksNyBAQCBzdGF0aWMgaW50IGJjbV9jbG9zZShzdHJ1Y3QgaGNpX3VhcnQg
Kmh1KQ0KIAkJcG1fcnVudGltZV9kaXNhYmxlKGJkZXYtPmRldik7DQogCQlwbV9ydW50aW1lX3Nl
dF9zdXNwZW5kZWQoYmRldi0+ZGV2KTsNCiANCi0JCWlmIChkZXZpY2VfY2FuX3dha2V1cChiZGV2
LT5kZXYpKSB7DQorCQlpZiAoYmRldi0+aXJxID4gMCkgew0KIAkJCWRldm1fZnJlZV9pcnEoYmRl
di0+ZGV2LCBiZGV2LT5pcnEsIGJkZXYpOw0KIAkJCWRldmljZV9pbml0X3dha2V1cChiZGV2LT5k
ZXYsIGZhbHNlKTsNCiAJCX0NCkBAIC02MjgsNyArNjI4LDcgQEAgc3RhdGljIGludCBiY21fc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCWlmIChwbV9ydW50aW1lX2FjdGl2ZShkZXYpKQ0K
IAkJYmNtX3N1c3BlbmRfZGV2aWNlKGRldik7DQogDQotCWlmIChkZXZpY2VfbWF5X3dha2V1cChk
ZXYpKSB7DQorCWlmIChkZXZpY2VfbWF5X3dha2V1cChkZXYpICYmIGJkZXYtPmlycSA+IDApIHsN
CiAJCWVycm9yID0gZW5hYmxlX2lycV93YWtlKGJkZXYtPmlycSk7DQogCQlpZiAoIWVycm9yKQ0K
IAkJCWJ0X2Rldl9kYmcoYmRldiwgIkJDTSBpcnE6IGVuYWJsZWQiKTsNCkBAIC02NTgsNyArNjU4
LDcgQEAgc3RhdGljIGludCBiY21fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJaWYgKCFi
ZGV2LT5odSkNCiAJCWdvdG8gdW5sb2NrOw0KIA0KLQlpZiAoZGV2aWNlX21heV93YWtldXAoZGV2
KSkgew0KKwlpZiAoZGV2aWNlX21heV93YWtldXAoZGV2KSAmJiBiZGV2LT5pcnEgPiAwKSB7DQog
CQlkaXNhYmxlX2lycV93YWtlKGJkZXYtPmlycSk7DQogCQlidF9kZXZfZGJnKGJkZXYsICJCQ00g
aXJxOiBkaXNhYmxlZCIpOw0KIAl9DQotLSANCjIuMTQuMQ0K
