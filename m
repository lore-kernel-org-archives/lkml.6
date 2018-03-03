Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120744-2-10672810102434163304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120743; b=C3zNpMUwtiGxxQbXkqM/it5wKUbkrLhMeqCOSgcslGiD0Dn
    +Ja4eWBK+nb5Am55hY8y/QKSBDNuK57itbELeIhN6KThuYv1+FjPcpW29yZr0/MP
    xhdmkMIBIsA7lyBSgud/ABj5ga3D+ZrTumlzK/TszJ9Uz9jFutO1PWyNAfg0MQN/
    dVcycVGvFGuAf7U9gOyucMourpAwT3KZ73JgQPuOPuIcpLX+L1EnsaFrpJskJK7N
    cubejRK1rRGqO6aZlMgCD9L4ciSZLxmU/WaVWAPKGhhzwiux0u8RDYmj07USk1f/
    duxxncPvpaOiN/dXIRxyNISo+t2uVNk1hUT1tvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120743; bh=+CZicOZshMpuoSVxwfPrAuFXVkZFd5PWpHOScG
    lNw8g=; b=LGxx6Kyb1bj/WeV9RrpPtHGMG9/K1n8hQQBSHO70UAL+m+Ng65IpNJ
    V9g1Wf01866kjipkhWJr+OxdK4wcljF002VXEpBagHI24oh+VyUkrNpJe3kVFY/G
    WsX+yug+M8D86dZ6UP6W1PMjLpIS8DAuWl45OK9RBdvGwqU5Bj/pxi25gFUEiGdA
    rDi5r0GXloghgTC7i4zMWyO60t13qxG/QgqGmpDKZTJwQ656LV+4PVQ/v9PfexiV
    27kYm2yCN8GnoOA5JoL2K63cBCOkcuTNrpCEOJLUBKDr93+rL0P7BLc9OO9eFJE2
    kc9JhkolGi6g80KubyInY4FxvI1wbfKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S9UzdTXp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S9UzdTXp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934281AbeCCXpE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:45:04 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:36491
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934163AbeCCWeL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 108/219] ARM: dts: koelsch: Correct clock
 frequency of X2 DU clock input
Thread-Topic: [PATCH AUTOSEL for 4.9 108/219] ARM: dts: koelsch: Correct clock
 frequency of X2 DU clock input
Thread-Index: AQHTsz8FUluiOu/1oky60pnBsfFd3w==
Date: Sat, 3 Mar 2018 22:28:58 +0000
Message-ID: <20180303222716.26640-108-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:EOUjiSMnjQWRmNigt5a1rMCm6Xsrknx6TNQqP4mi12rxYFkAP7tngCNnaxgRMAqQ/juba41DM9W75Z9Rcr5wCASZqZO3E5hsl4Gej/O8sruIoIaYVgqF8ndnrR3aCsBhPWMOFvz9h4nZ6royTT6DEFaOPx5PdE3Ohljsl0xwSGeH8+NBBNFXDoUEnrH+YRQZurWk5VZZJO0Le7pazoaYmnuxJV3TfMolx3UOEs/eFS6F+aHQ/0QyHQQ5IdGKIy3pV4P6y84991h420NHZFimwNWopW9fkFTBIL9a8XUFPDAFEjlsMM8wXu4HaK3HcB9MaR+z2YoXGSHTfOklCVVwd0gNCIYUQLDi5ojzLkDDQlmVu7KXBySrlnsLRCe9JiLs;5:m9A/FiG65UJyQvWR/xQIK0r7EcwmxBShGwCh/Nkkbzg5ZVrDxqi9EDxYOkq7L5OHqCzFBhzmcPLcTurO6f8vJb0Q2iyEQnyrpVGBWk+Y3Pyi7KZWdmUiTNN8J6MGIMVXr1abtks3RQPl5QX4b3eNHuHC5kCrefmgCFZLxnXO1oY=;24:NCTLmkpNq4cqHlGSQkvqAnVRS+aV/ZS+6snlDBEe5Ry18sSpspU08uP1meLg23dHnvVy8kFe2dFRtjKoe9uSAKkLms430QJI4OKQE5lUEQQ=;7:oXh/x/5qwKxjTrjZKDzCBI8v3oWFF3KAtJVCII+MxhPZw+kiJlCDxRPzfRjl/y+EV7L80JoBhEXEUfq4ytauRchiIRQpUcBMfFIcQYqP2Yrvn6RYflbYF/gl4uqh/gcNlNx+wJJPrrijilAZjsFlod9i7HJPBEccAQdVQ28oKBGesjhiYl6iuwnaMWJcbgzasqYVsLywpKWH3x/Nnj+T9U/xNzRHTI5Kyt82G5GhlgBCVp8bQ1R27e2L848n2iwZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01929817-4c7f-4adb-6567-08d58156ded4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10658512AA6418546E72CCD2FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GRMBILd7g5Wc/U+qNPPO/HrpZyVtdpHeVc8oQ3m5u2pD73UGV/Bwv+5f+GoCSiLUA9Q1eHukv6vsuRFQDoQpaM6Ncr/8hl2YaUNZSM2a/NATCWbqoHpwDrVMeZRQNVwdSx4rO8Tske1rjUnmrHEhF4BZd6gy/KdSIehUUKJZezE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <90A16C4E53731E4FBE962A7CE529C5EC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01929817-4c7f-4adb-6567-08d58156ded4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:58.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCg0KWyBV
cHN0cmVhbSBjb21taXQgZWJmMDZhZjU1Yzc1OTRlZDFmYzE4NDY5YTVjZGRmOTExYzQwZTY4NyBd
DQoNClRoZSBYMiBjcnlzdGFsIG9zY2lsbGF0b3Igb24gdGhlIEtvZWxzY2ggZGV2ZWxvcG1lbnQg
Ym9hcmQgcHJvdmlkZXMgYQ0KNzQuMjUgTUh6IGNsb2NrLCBub3QgYSAxNDguNSBNSHogY2xvY2su
DQoNCkZpeGVzOiBjZDIxY2I0NmUxNGFhZTNhICgiQVJNOiBzaG1vYmlsZToga29lbHNjaDogQWRk
IERVIGV4dGVybmFsIHBpeGVsIGNsb2NrcyB0byBEVCIpDQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KQWNrZWQtYnk6IExhdXJlbnQg
UGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NClRlc3RlZC1ieTog
TmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+
DQpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQu
Y29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc5MS1rb2Vsc2NoLmR0cyB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMgYi9hcmNoL2FybS9i
b290L2R0cy9yOGE3NzkxLWtvZWxzY2guZHRzDQppbmRleCBmOGE3ZDA5MGZkMDEuLjEyODQxZTli
YWI5OCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMN
CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3OTEta29lbHNjaC5kdHMNCkBAIC0yNzksNyAr
Mjc5LDcgQEANCiAJeDJfY2xrOiB4Mi1jbG9jayB7DQogCQljb21wYXRpYmxlID0gImZpeGVkLWNs
b2NrIjsNCiAJCSNjbG9jay1jZWxscyA9IDwwPjsNCi0JCWNsb2NrLWZyZXF1ZW5jeSA9IDwxNDg1
MDAwMDA+Ow0KKwkJY2xvY2stZnJlcXVlbmN5ID0gPDc0MjUwMDAwPjsNCiAJfTsNCiANCiAJeDEz
X2NsazogeDEzLWNsb2NrIHsNCi0tIA0KMi4xNC4xDQo=
