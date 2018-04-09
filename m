Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238887-2-7147366840347741607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238887; b=QUfr/ddVgIlAT7l6y3WnoHyYJrgSJRY/TrLAIS51WFpzY52YJA
    yK2VQiuYTzFHlbbkbFC0K6Z24TZ6+sdMTmZdq3w5AyUaAsBK7dwF38zx1QsHSAJ7
    Qme76UX3Odv+KWyNfHBQxezjlWgSKuL+JeAh+wR/ie5lhuAutxaiiXQkDT47Sy2U
    QbHdTpIG3lsCjPv0S7GJzfXRwyhiin0xr/3RQbysawUsVQST3RfFGgfbbsj0DwaK
    qKmhm1+eKBKlZaEpwmcdAPOCTD9K7ggGrLO9bj1vZR+lW7eX8DCjdzG3ZjWUTc3M
    T2h0dGy0VHUDNwb/3FD5HqWnVNfi0Q3lwK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523238887; bh=wI0DUnIXrjy/ZEizONRDke04mRf/7s7fxUkYMQuf6qU=; b=
    BaZsY3gvFXJ/pTMiT1T1wWD2CF5ypsozPyOnQOsGBwWrL7U8+3XsQCRMuKdTdKuZ
    kexdnul/uFbl8vguxz9AZEGsnkPFkvvzYoxIgKxMDm1/y5/XO/4BFLoQct+2XtB+
    OYCPgCmLfg/diTcIYqfkhQnKEZE7W3MeXFBNvU2Hjg27CPEUbBmD4Zl/gb+MmQbE
    BxSNhcxnQXUV4gvKwa3Yk2bjbCzm/kPdu77RVheCCH4g2In6I7duFvFqQcim4/LT
    SkPd7LEBnMuU5hDOIWCixKtXUvvCl580w3XaXIkY7I99tRvAT7LYfb5F1KarO78D
    AHgrZuhl9r3YKSgWd6LVfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ye37RF+/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ye37RF+/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE7UwKICZicKv4fBymQ+QdSIG7K4cU+I5jg762+/D6DEY9hDVl8tWgW42dIpJfQqocDyEuTaBx5vGO5wehsVODaGLHKf6R9tHb21oouHBPlSRL3QdENr
    cMyaPCy6XrYz4iTtU0mdKlPXOanoSCGJCrDdh85kBuI7DEPPe2PkgnwaVq0YeQOLOmTtI7i8d34M/Myy2d2hwh09Sa8T8w2c84dTYWOvzyikIlOnoiIPgWMm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=f5JUautJF78rpD-wVU0A:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeDIAdM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:12 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932252AbeDIAdI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 231/293] watchdog: sp5100_tco: Fix watchdog
 disable bit
Thread-Topic: [PATCH AUTOSEL for 4.9 231/293] watchdog: sp5100_tco: Fix
 watchdog disable bit
Thread-Index: AQHTz5lSGqeIOkGlJEi51KMsyLVk/g==
Date: Mon, 9 Apr 2018 00:25:54 +0000
Message-ID: <20180409002239.163177-231-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:HQ8rb7b1A21vpJvroIrOWAC27pXaBmbIiir9B9v5Ezfs5kJ+wAO/Ofs383zK4m2Gpng9+yuOcnX2mv1n/EBx8/igb6Hh8UCJi/0ehXax8nrrW+2iAWcchuFXAhi1LFcorpTC9c9B9xCMCoUCnXHBRoJBpPc3AalqDb/XmKEiJm7S1Q0ZN0Q5AeuXnvE8sN/NYsm6N9ifWQOEnm5ZQGMSJ4HXKv2bTb7bLZiilOWQCbOErhUJZAoQbafI//uZxVDH;20:F5RmBnPMdCiS1oKjO4XSvIhWDDqSwHawElL7CUywDezupof2GGE2A5x3HUzgDFzGanXOyeXJ3RivFnRCwgq/aGZUDZFLEvB7r4dshExJ39Qec2g+D/OoOGI4biEdwEw4RZyF1SIB6SMrJ42oY25xRvUXW3N4ScxgWXvv+KGUuVs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1649a365-c13c-4b6a-9c12-08d59db17588
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09029A619E4DFDBE0AB62EC0FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GiySfBgCJ8qIekBtk3GBC6m74Dh095XE0VIJ+9dyJfXwDDX7iRKR9Du7ZJXVjlka8YAxW2335j8JI757aHaYRFJeU1tMhgF16s4jE/IvYZpfcYzJLLC5GMHXJcYiBLOC+JlbDaHGkAW5zpjMEfy+nkoHt8pFgyu6LkuseTlJxdSWSk6OcLayYL6p8ZlA2D8++gYD4v2dA853Hy8I64VNlFDed3Uxi/QF++by+LTFrnWL4l4gs63TpDdhw3M0br6xCER8TnnIgdmg7tXtnCHQ6b51jD2p6cFl4k7tRdqM3MHIf7J+/i4lQLhJzAFFZIBshVsDZ7uTv+pbpcCSfq86Ae41KCQ3g89CZquwriU1lTC/YnJ/wKLbRLCxwZdHEsCGwcwu+gCtQaQqawPe6wjwTAjZQq3aYOnwId7tkgzMPiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E153DDB1C4F72349B9917A26A1B6509C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1649a365-c13c-4b6a-9c12-08d59db17588
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:54.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
NTEwMF90Y28uaA0KaW5kZXggMmIyOGMwMGRhMGRmLi5kZmUyMGI4MWNlZDUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3NwNTEwMF90Y28uaA0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
cDUxMDBfdGNvLmgNCkBAIC01NCw3ICs1NCw3IEBADQogI2RlZmluZSBTQjgwMF9QTV9XQVRDSERP
R19DT05GSUcJMHg0Qw0KIA0KICNkZWZpbmUgU0I4MDBfUENJX1dBVENIRE9HX0RFQ09ERV9FTgko
MSA8PCAwKQ0KLSNkZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAyKQ0KKyNk
ZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAxKQ0KICNkZWZpbmUgU0I4MDBf
UE1fV0FUQ0hET0dfU0VDT05EX1JFUwkoMyA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlP
X0RFQ09ERV9FTgkoMSA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlPX1NFTAkJKDEgPDwg
MSkNCi0tIA0KMi4xNS4xDQo=
