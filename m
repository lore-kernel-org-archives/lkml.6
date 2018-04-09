Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244112-2-4070464494574205479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244111; b=w348Ga94pcxO8covrOBh394RI0QTXKnEyfY6eirdYj02lmt31k
    pmtude4HP+tLqmE0faH0G7fWlkhHOk4K0AtzMrf9g+HAYpqGXWk1xrNIYZWa2kmc
    1Izkp1v/Qh8fNFfSZtZ1SrPgTCcXb491xrb5mXIaexVg6t0wcMRCh0q9cQxlrvaV
    FVlG3tbMV62lPNHaYRRjsjQjKSOk3Xg7IOFWIkhS0cwcfDYe9N5AmwwS/BmPy4j6
    ZGxo691Omm8zQSNqUGxAJH7SNaN7pSxZXjSTMsXabQ988RzH2ZfNdT2NfoYA+fCD
    HSuEapmTN8EaT5q6jZhgTp8OIcP7k2ym4uVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523244111; bh=0Yu0n37Xgq1EGNYJt0eBxeU7qpHF0Nu+wW9jbFkq04I=; b=
    W4Aj1wRyqYKJiDaBfEWRagA8E1CHD1JKT0pyLS/OtzXnv4uTlLE1FEkfgi8D+GpA
    Ka87VHTVFiwaJ74Ilxgx0yWutUyjWUY8W6vbkYLullZ61dETjLHdNRzPqfy1cMGL
    gr9qLdXodSsDPpwqIWMlAf5ojXIbY9tgMOS+aTw3/JTRP6jdh/2va7OcOKFuIiHh
    Sq3NZ6lZoybknWnVWSPWAU+09KGoRokMqdSlWHwVauS82YWBGdTNY+RYhJtSA/1u
    db3B/2TQyv7zNhoiFx/JH+50LrVdvL2Nx88IwVgRct7JRBtwji4nabFjyWavmvHA
    stxN/TYBqXvwQiXFhx95dQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FQHD57MU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FQHD57MU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDAYzps1INTNgLlJMCQxI85luOUJatCh6ptdua/Btjqg6VdAf5rsWuoGNrED2KKRDEyH+Mabr69e/oeZ2wG8eVtNSzSczUcJnh3soXtKCYbfwecENBOf
    d0rO9kPyI4asWehdvzcmsclQ6ve9JosHFC1MsZaKBEwU+mlAFzL+4YAhZ8gPrkEGDPYkFhZTv86KlXuV1OyhVhj/u2uN0uEyxE0sTZRhI35ljiX0tEvgft6D
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=f5JUautJF78rpD-wVU0A:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeDIDVf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:21:35 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754763AbeDIAW5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 045/161] watchdog: sp5100_tco: Fix watchdog
 disable bit
Thread-Topic: [PATCH AUTOSEL for 4.14 045/161] watchdog: sp5100_tco: Fix
 watchdog disable bit
Thread-Index: AQHTz5iMXpqjMmp/OESSOVUKzjt9yw==
Date: Mon, 9 Apr 2018 00:20:22 +0000
Message-ID: <20180409001936.162706-45-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:pQkVSNsCLWKONCAB9XabWy9G2MXIsaG3VLAlQ1SHOlJFpbn7KFy873f1MB5aE7wGh0uaigIATrFkdEYZbfkQhyAWDnsqEhHbDvYEa2WWDqOQcr2G2bluXl73916sYFGavKeEgmKcebSNFSGUTRhZrhSSZ63NH2d/WLVQniYS0wMtuC1awe2jskmdlyUfCkGuPkd8FQBdcmm5MKWAlACoK93JL9476JTYpFvmIxsjzHxMsIxu+oeYcZ7OXOLM6hky;20:0bboaBMNWW9+PQCsLXl1MU/zymfGS0k/8bOBYodA4KAdOhtwF8JrMsnXg42k7kVwcIezeZNKQ3qMX755XnTdiZJQ62mDh3MnpwrdrMrjVhrYwmekjlt/jesf7EOJwiKwtlJg14qXAqKkKVRJwOiQHZZwgIBisSABBIQHeh9HHWQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe0202a0-fab8-46c0-d49e-08d59db00940
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014AAF70EEBE392193684B5FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XFXxKjh6xByxSac+GKxyk4uCLC2ZMNC//wVBDX7j+/VCyRuNMdXt+w3gewc5ZnHkKbdOcN98b/dOHp3OUiYbOfKtPBjZziehA/nz+2HEp5jjrKCJ8o6FiabwPgk97ZSO1XNpckdRNklVoN92Z62atVyndlMK+FZtaHcSZL742S/cbMRrATw/DjsbgufCME/h9Lf8OqzlJdFkCwgv9fWbbZ2mwRicTOE7KoCxlmWKRWU7HxKBt1R7FrYRDa9jDt8KI1hMjn0DIw/BbTbO7+25BroeePZeYDxMp8qB4r5kXpo67lVOdfWhoM5X3GCN62yCaDQaNa2Km3UrnQs+wWaSFOUXVfHjsGw/5Fnoktg2/WiMiIrKcPd+gp7JwTfuQ2tIwCl4riwItVEartU628vAHKJx3mIJ0IHcqR2do+ITeH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <30BFB6D8E4472640A95162403E680C35@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0202a0-fab8-46c0-d49e-08d59db00940
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:22.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBmNTQxYzA5ZWJmYzYxNjk3YjU4NmIzOGM5ZWJhZjRiNzBkZWZiMjc4IF0NCg0KQWNjb3Jk
aW5nIHRvIGFsbCBwdWJsaXNoZWQgaW5mb3JtYXRpb24sIHRoZSB3YXRjaGRvZyBkaXNhYmxlIGJp
dCBmb3IgU0I4MDANCmNvbXBhdGlibGUgY29udHJvbGxlcnMgaXMgYml0IDEgb2YgUE0gcmVnaXN0
ZXIgMHg0OCwgbm90IGJpdCAyLiBGb3IgdGhlDQptb3N0IHBhcnQgdGhhdCBkb2Vzbid0IG1hdHRl
ciBpbiBwcmFjdGljZSwgc2luY2UgdGhlIGJpdCBoYXMgdG8gYmUgY2xlYXJlZA0KdG8gZW5hYmxl
IHdhdGNoZG9nIGFkZHJlc3MgZGVjb2RpbmcsIHdoaWNoIGlzIHRoZSBkZWZhdWx0IHNldHRpbmcs
IGJ1dCBpdA0Kc3RpbGwgbmVlZHMgdG8gYmUgZml4ZWQuDQoNCkNjOiBab2x0w6FuIELDtnN6w7Zy
bcOpbnlpIDx6Ym9zem9yQHByLmh1Pg0KU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pg0KU2lnbmVkLW9mZi1ieTogV2ltIFZhbiBTZWJyb2VjayA8d2ltQGln
dWFuYS5iZT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWlj
cm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvd2F0Y2hkb2cvc3A1MTAwX3Rjby5oIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy93YXRjaGRvZy9zcDUxMDBfdGNvLmggYi9kcml2ZXJzL3dhdGNoZG9nL3Nw
NTEwMF90Y28uaA0KaW5kZXggMWFmNGRlZTcxMzM3Li4wZTI0MmQxMTEwY2UgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3NwNTEwMF90Y28uaA0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
cDUxMDBfdGNvLmgNCkBAIC01NSw3ICs1NSw3IEBADQogI2RlZmluZSBTQjgwMF9QTV9XQVRDSERP
R19DT05GSUcJMHg0Qw0KIA0KICNkZWZpbmUgU0I4MDBfUENJX1dBVENIRE9HX0RFQ09ERV9FTgko
MSA8PCAwKQ0KLSNkZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAyKQ0KKyNk
ZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAxKQ0KICNkZWZpbmUgU0I4MDBf
UE1fV0FUQ0hET0dfU0VDT05EX1JFUwkoMyA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlP
X0RFQ09ERV9FTgkoMSA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlPX1NFTAkJKDEgPDwg
MSkNCi0tIA0KMi4xNS4xDQo=
