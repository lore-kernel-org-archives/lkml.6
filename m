Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3598244-1526435851-2-12072319699197893091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IN'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526435850; b=NDJU7hXGIzlWVU0URIYbYG9pHaHuUt8NcI2SXt3Ab0XzinSRNV
    HTRfstdWi93i2DZnn5DaKsecLFnM4cVATGmHv/hlpu0P/2H1AMpjVIl/dtspe5D1
    eeLKo/ZKopw1xSILYMVv6Kti8lMIa2FNnMuJdYJovT8EByUD2eT8SAGxDObU/2Jm
    XoETzxYqkIvcc8nK0K9xnPD4xS2PlfaLFYzN3kvTyZ9hy1jo5V5wO1KSoGER0mF8
    +nVEOWKavc2J1BVKaYSB1LCAYdF0cf5CK96yAMwmNstsU+LTORjDOppKJEOcdhTG
    ph9cvvF3UmU2J1vnYlt58aRESuQb00Sjr7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1526435850; bh=A6e7o/IPEC
    aB9fnHKx6Scj3XvNC0fY8fy9l/q8mzYkg=; b=XnjIEPesjPeKeYEqPcDuH+79hP
    9o9e6NTEYKiIEeUUEQHXO04POzHMmTyDgr1F5eRir3qWKKhSaiL4lYXF329VKF7C
    RB+xJs+W6bqj7ZedWm4qwsplTmEa+JVXJWn/fqPl5kVNlC3888pAIzk0Em0WIWNX
    rAuxosfhJ7awvL6gCjjXjv3G2GNKReHzdMTmRr9qBgRSSupbhhKd6MEEX0hsJP+Y
    cqJzBbduuE/S81BBG5W4hX4e6e5eNAjyMewP50Srt4sE0I7mKNeYomItT0YV5bkY
    4e+7qsoPgJ8nXTCrjlbGvvSVcQRceuSuQckmgJWtVzQu6HxNM4aYWa64yCBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=nxp.com header.i=@nxp.com header.b=RHsvH4b/ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=nxp.com header.i=@nxp.com header.b=RHsvH4b/ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNcsaKby4isHbBknS1XbiLYsQ60EJARTwGwkfsjwip6ovQFwy7QWLFQAexBaTYAYrCXYouGbC7/X00P09BwTek7JGNh5Y1a4jMg3pH/nHrsq+xS/c4X/
    RFQyNx7ZCGqLwCcJXU7XctUIrChJJ+e1TAcZryBpySa28WK47rlCcYDawvuj8M6POG4gKAuPQHkWaQUKd7rrRzHI9E0pY5YXA0LVB3dZCvkA34tPxq8XKo1Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=qcm6Q_k2ZJkA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=dw2S5ISiLjYA:10 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
    a=j4e_FN_Bv2zboy8PRJwA:9 a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22
    a=ST-jHhOKWsTCqRlWije3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeEPB5U (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 21:57:20 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:25505
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751853AbeEPB5R (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 15 May 2018 21:57:17 -0400
From: Andy Duan <fugang.duan@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS ETHERNET DRIVERS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Thread-Topic: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Thread-Index: AQHT7KhckrcQU1+QCEiHJzVCv7H036QxmLAw
Date: Wed, 16 May 2018 01:57:11 +0000
Message-ID: <AM4PR0401MB22607213548ADBDA1FE8ADA6FF920@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2212;7:oEE8kTOBelTftfjHRcDj5w+PLb1tqZK7I5FA4VI7F303CXh16Hfb8TrX7NyWkDL/LIKz+SqWxBwRg7FBpiuxBlL9A7q6vpRd4R1mTIajEuG0++CVgwSc34iMa/6cx64yOL7y1Fs2K4IRq/6l2WkQOD+qk4VEXwJxq48D0m44FIf43v2J6BjZGIFKmVFfwZwov3EqL+281pGVViVBgp80QGvdw7bnNvErdgKHjA5i/2iPPFqKVD4hM5LfLo4Ap4Bj
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2212;
x-ms-traffictypediagnostic: AM4PR0401MB2212:
x-microsoft-antispam-prvs: <AM4PR0401MB22126954247ECC19156F9D32FF920@AM4PR0401MB2212.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2212;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2212;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(486006)(2501003)(11346002)(5250100002)(476003)(6116002)(54906003)(3846002)(110136005)(2906002)(3660700001)(3280700002)(316002)(6436002)(33656002)(105586002)(106356001)(68736007)(229853002)(66066001)(7736002)(305945005)(8676002)(81156014)(8936002)(81166006)(446003)(39060400002)(2900100001)(7416002)(97736004)(6506007)(478600001)(99286004)(6246003)(25786009)(76176011)(7696005)(4326008)(102836004)(575784001)(55016002)(86362001)(186003)(14454004)(5660300001)(53936002)(9686003)(26005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2212;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JMOUZkjdWmTLl2ZSsM62l7kAyBHXPZFR9MkHN5Z5f89Sanob6lIfLg63Bpm7UQat1yPsc2u8Hkof5aLVKDEH3NviNHdwldNW31QIQBZe+EsCm6Y4B5QTPIhzalUdiOuW2QWVfw9L7ZZDQTW9F64B6hcYLldPO+yKFaIADPa0AbKjvAsNLR406mvbF/ByEx+S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 546b7701-65c2-4df4-4c4e-08d5bad05707
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b7701-65c2-4df4-4c4e-08d5bad05707
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 01:57:11.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2212
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+IFNlbnQ6IDIwMTjl
ubQ15pyIMTbml6UgNzo1Ng0KPiBBIG51bWJlciBvZiBkcml2ZXJzIGhhdmUgdGhlIGZvbGxvd2lu
ZyBwYXR0ZXJuOg0KPiANCj4gaWYgKG5wKQ0KPiAJb2ZfbWRpb2J1c19yZWdpc3RlcigpDQo+IGVs
c2UNCj4gCW1kaW9idXNfcmVnaXN0ZXIoKQ0KPiANCj4gd2hpY2ggdGhlIGltcGxlbWVudGF0aW9u
IG9mIG9mX21kaW9idXNfcmVnaXN0ZXIoKSBub3cgdGFrZXMgY2FyZSBvZi4NCj4gUmVtb3ZlIHRo
YXQgcGF0dGVybiBpbiBkcml2ZXJzIHRoYXQgc3RyaWN0bHkgYWRoZXJlIHRvIGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQoN
CkZvciBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYzoNCg0KUmV2aWV3
ZWQtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L2RzYS9iY21fc2YyLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKy0tLS0t
LQ0KPiAgZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9jaGlwLmMgICAgICAgICAgICAgICAgICB8
ICA1ICstLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jICAg
ICAgICAgIHwgMTIgKysrLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZmVjX21haW4uYyAgICAgICAgIHwgIDggKystLS0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvbXZtZGlvLmMgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVuZXNhcy9zaF9ldGguYyAgICAgICAgICAgICB8IDExICsrKy0tLS0tLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWRpby5jIHwg
IDUgKy0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2RhdmluY2lfbWRpby5jICAgICAg
ICAgICAgfCAgOCArKystLS0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L21kaW8tZ3Bpby5jICAgICAg
ICAgICAgICAgICAgICAgICB8ICA2ICstLS0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L21kaW8tbXNj
Yy1taWltLmMgICAgICAgICAgICAgICAgICB8ICA2ICstLS0tLQ0KPiAgZHJpdmVycy9uZXQvdXNi
L2xhbjc4eHguYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrLS0tLS0NCj4gIDExIGZp
bGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDYxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9iY21fc2YyLmMgYi9kcml2ZXJzL25ldC9kc2EvYmNt
X3NmMi5jIGluZGV4DQo+IGFjNjIxZjQ0MjM3YS4uMDJlODk4MjUxOWNlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9kc2EvYmNtX3NmMi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9iY21f
c2YyLmMNCj4gQEAgLTQ1MCwxMiArNDUwLDggQEAgc3RhdGljIGludCBiY21fc2YyX21kaW9fcmVn
aXN0ZXIoc3RydWN0IGRzYV9zd2l0Y2gNCj4gKmRzKQ0KPiAgCXByaXYtPnNsYXZlX21paV9idXMt
PnBhcmVudCA9IGRzLT5kZXYtPnBhcmVudDsNCj4gIAlwcml2LT5zbGF2ZV9taWlfYnVzLT5waHlf
bWFzayA9IH5wcml2LT5pbmRpcl9waHlfbWFzazsNCj4gDQo+IC0JaWYgKGRuKQ0KPiAtCQllcnIg
PSBvZl9tZGlvYnVzX3JlZ2lzdGVyKHByaXYtPnNsYXZlX21paV9idXMsIGRuKTsNCj4gLQllbHNl
DQo+IC0JCWVyciA9IG1kaW9idXNfcmVnaXN0ZXIocHJpdi0+c2xhdmVfbWlpX2J1cyk7DQo+IC0N
Cj4gLQlpZiAoZXJyKQ0KPiArCWVyciA9IG9mX21kaW9idXNfcmVnaXN0ZXIocHJpdi0+c2xhdmVf
bWlpX2J1cywgZG4pOw0KPiArCWlmIChlcnIgJiYgZG4pDQo+ICAJCW9mX25vZGVfcHV0KGRuKTsN
Cj4gDQo+ICAJcmV0dXJuIGVycjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9tdjg4
ZTZ4eHgvY2hpcC5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9jaGlwLmMNCj4gaW5k
ZXggYjIzYzExZDlmNGIyLi4yYmIzZjAzZWUxY2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgv
Y2hpcC5jDQo+IEBAIC0yNDU0LDEwICsyNDU0LDcgQEAgc3RhdGljIGludCBtdjg4ZTZ4eHhfbWRp
b19yZWdpc3RlcihzdHJ1Y3QNCj4gbXY4OGU2eHh4X2NoaXAgKmNoaXAsDQo+ICAJCQlyZXR1cm4g
ZXJyOw0KPiAgCX0NCj4gDQo+IC0JaWYgKG5wKQ0KPiAtCQllcnIgPSBvZl9tZGlvYnVzX3JlZ2lz
dGVyKGJ1cywgbnApOw0KPiAtCWVsc2UNCj4gLQkJZXJyID0gbWRpb2J1c19yZWdpc3RlcihidXMp
Ow0KPiArCWVyciA9IG9mX21kaW9idXNfcmVnaXN0ZXIoYnVzLCBucCk7DQo+ICAJaWYgKGVycikg
ew0KPiAgCQlkZXZfZXJyKGNoaXAtPmRldiwgIkNhbm5vdCByZWdpc3RlciBNRElPIGJ1cyAoJWQp
XG4iLCBlcnIpOw0KPiAgCQltdjg4ZTZ4eHhfZzJfaXJxX21kaW9fZnJlZShjaGlwLCBidXMpOyBk
aWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gaW5kZXggYjRj
OTI2ODEwMGJiLi4zZTkzZGY1ZDRlM2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2Fk
ZW5jZS9tYWNiX21haW4uYw0KPiBAQCAtNTkxLDE2ICs1OTEsMTAgQEAgc3RhdGljIGludCBtYWNi
X21paV9pbml0KHN0cnVjdCBtYWNiICpicCkNCj4gIAlkZXZfc2V0X2RydmRhdGEoJmJwLT5kZXYt
PmRldiwgYnAtPm1paV9idXMpOw0KPiANCj4gIAlucCA9IGJwLT5wZGV2LT5kZXYub2Zfbm9kZTsN
Cj4gKwlpZiAocGRhdGEpDQo+ICsJCWJwLT5taWlfYnVzLT5waHlfbWFzayA9IHBkYXRhLT5waHlf
bWFzazsNCj4gDQo+IC0JaWYgKG5wKSB7DQo+IC0JCWVyciA9IG9mX21kaW9idXNfcmVnaXN0ZXIo
YnAtPm1paV9idXMsIG5wKTsNCj4gLQl9IGVsc2Ugew0KPiAtCQlpZiAocGRhdGEpDQo+IC0JCQli
cC0+bWlpX2J1cy0+cGh5X21hc2sgPSBwZGF0YS0+cGh5X21hc2s7DQo+IC0NCj4gLQkJZXJyID0g
bWRpb2J1c19yZWdpc3RlcihicC0+bWlpX2J1cyk7DQo+IC0JfQ0KPiAtDQo+ICsJZXJyID0gb2Zf
bWRpb2J1c19yZWdpc3RlcihicC0+bWlpX2J1cywgbnApOw0KPiAgCWlmIChlcnIpDQo+ICAJCWdv
dG8gZXJyX291dF9mcmVlX21kaW9idXM7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRleCBkNDYwNGJjOGViNWIuLmYzZTQzZGIwZDZjYiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAg
LTIwNTIsMTMgKzIwNTIsOSBAQCBzdGF0aWMgaW50IGZlY19lbmV0X21paV9pbml0KHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJZmVwLT5taWlfYnVzLT5wYXJlbnQgPSAmcGRl
di0+ZGV2Ow0KPiANCj4gIAlub2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUocGRldi0+ZGV2Lm9m
X25vZGUsICJtZGlvIik7DQo+IC0JaWYgKG5vZGUpIHsNCj4gLQkJZXJyID0gb2ZfbWRpb2J1c19y
ZWdpc3RlcihmZXAtPm1paV9idXMsIG5vZGUpOw0KPiArCWVyciA9IG9mX21kaW9idXNfcmVnaXN0
ZXIoZmVwLT5taWlfYnVzLCBub2RlKTsNCj4gKwlpZiAobm9kZSkNCj4gIAkJb2Zfbm9kZV9wdXQo
bm9kZSk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJZXJyID0gbWRpb2J1c19yZWdpc3RlcihmZXAtPm1p
aV9idXMpOw0KPiAtCX0NCj4gLQ0KPiAgCWlmIChlcnIpDQo+ICAJCWdvdG8gZXJyX291dF9mcmVl
X21kaW9idXM7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9tdm1kaW8uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvbXZtZGlvLmMNCj4g
aW5kZXggMDQ5NTQ4N2Y3YjQyLi5jNWRhYzZiZDJiZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvbXZtZGlvLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9tdm1kaW8uYw0KPiBAQCAtMzQ4LDEwICszNDgsNyBAQCBzdGF0aWMgaW50IG9y
aW9uX21kaW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJZ290
byBvdXRfbWRpbzsNCj4gIAl9DQo+IA0KPiAtCWlmIChwZGV2LT5kZXYub2Zfbm9kZSkNCj4gLQkJ
cmV0ID0gb2ZfbWRpb2J1c19yZWdpc3RlcihidXMsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gLQll
bHNlDQo+IC0JCXJldCA9IG1kaW9idXNfcmVnaXN0ZXIoYnVzKTsNCj4gKwlyZXQgPSBvZl9tZGlv
YnVzX3JlZ2lzdGVyKGJ1cywgcGRldi0+ZGV2Lm9mX25vZGUpOw0KPiAgCWlmIChyZXQgPCAwKSB7
DQo+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbm5vdCByZWdpc3RlciBNRElPIGJ1cyAoJWQp
XG4iLCByZXQpOw0KPiAgCQlnb3RvIG91dF9tZGlvOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVuZXNhcy9zaF9ldGguYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Jl
bmVzYXMvc2hfZXRoLmMNCj4gaW5kZXggNTk3MGQ5ZTVkZGYxLi44ZGQ0MWUwOGE2YzYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVzYXMvc2hfZXRoLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9zaF9ldGguYw0KPiBAQCAtMzAyNSwxNSArMzAy
NSwxMCBAQCBzdGF0aWMgaW50IHNoX21kaW9faW5pdChzdHJ1Y3Qgc2hfZXRoX3ByaXZhdGUNCj4g
Km1kcCwNCj4gIAkJIHBkZXYtPm5hbWUsIHBkZXYtPmlkKTsNCj4gDQo+ICAJLyogcmVnaXN0ZXIg
TURJTyBidXMgKi8NCj4gLQlpZiAoZGV2LT5vZl9ub2RlKSB7DQo+IC0JCXJldCA9IG9mX21kaW9i
dXNfcmVnaXN0ZXIobWRwLT5taWlfYnVzLCBkZXYtPm9mX25vZGUpOw0KPiAtCX0gZWxzZSB7DQo+
IC0JCWlmIChwZC0+cGh5X2lycSA+IDApDQo+IC0JCQltZHAtPm1paV9idXMtPmlycVtwZC0+cGh5
XSA9IHBkLT5waHlfaXJxOw0KPiAtDQo+IC0JCXJldCA9IG1kaW9idXNfcmVnaXN0ZXIobWRwLT5t
aWlfYnVzKTsNCj4gLQl9DQo+ICsJaWYgKHBkLT5waHlfaXJxID4gMCkNCj4gKwkJbWRwLT5taWlf
YnVzLT5pcnFbcGQtPnBoeV0gPSBwZC0+cGh5X2lycTsNCj4gDQo+ICsJcmV0ID0gb2ZfbWRpb2J1
c19yZWdpc3RlcihtZHAtPm1paV9idXMsIGRldi0+b2Zfbm9kZSk7DQo+ICAJaWYgKHJldCkNCj4g
IAkJZ290byBvdXRfZnJlZV9idXM7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21kaW8uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tZGlvLmMNCj4gaW5kZXggZjVmMzdiZmExZDU4Li41
ZGYxYTYwOGU1NjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL3N0bW1hY19tZGlvLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNy
by9zdG1tYWMvc3RtbWFjX21kaW8uYw0KPiBAQCAtMjMzLDEwICsyMzMsNyBAQCBpbnQgc3RtbWFj
X21kaW9fcmVnaXN0ZXIoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJbmV3X2J1cy0+cGh5
X21hc2sgPSBtZGlvX2J1c19kYXRhLT5waHlfbWFzazsNCj4gIAluZXdfYnVzLT5wYXJlbnQgPSBw
cml2LT5kZXZpY2U7DQo+IA0KPiAtCWlmIChtZGlvX25vZGUpDQo+IC0JCWVyciA9IG9mX21kaW9i
dXNfcmVnaXN0ZXIobmV3X2J1cywgbWRpb19ub2RlKTsNCj4gLQllbHNlDQo+IC0JCWVyciA9IG1k
aW9idXNfcmVnaXN0ZXIobmV3X2J1cyk7DQo+ICsJZXJyID0gb2ZfbWRpb2J1c19yZWdpc3Rlcihu
ZXdfYnVzLCBtZGlvX25vZGUpOw0KPiAgCWlmIChlcnIgIT0gMCkgew0KPiAgCQlkZXZfZXJyKGRl
diwgIkNhbm5vdCByZWdpc3RlciB0aGUgTURJTyBidXNcbiIpOw0KPiAgCQlnb3RvIGJ1c19yZWdp
c3Rlcl9mYWlsOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvZGF2aW5j
aV9tZGlvLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9kYXZpbmNpX21kaW8uYw0KPiBp
bmRleCA5OGExYzk3ZmI5NWUuLjhhYzcyODMxYWYwNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvdGkvZGF2aW5jaV9tZGlvLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvdGkvZGF2aW5jaV9tZGlvLmMNCj4gQEAgLTQyOSwxMiArNDI5LDEwIEBAIHN0YXRpYyBpbnQg
ZGF2aW5jaV9tZGlvX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
ICogZGVmaW5lZCB0byBzdXBwb3J0IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBEVHMgd2hp
Y2ggYXNzdW1lIHRoYXQNCj4gIAkgKiBEYXZpbmNpIE1ESU8gd2lsbCBhbHdheXMgc2NhbiB0aGUg
YnVzIGZvciBQSFlzIGRldGVjdGlvbi4NCj4gIAkgKi8NCj4gLQlpZiAoZGV2LT5vZl9ub2RlICYm
IG9mX2dldF9jaGlsZF9jb3VudChkZXYtPm9mX25vZGUpKSB7DQo+ICsJaWYgKGRldi0+b2Zfbm9k
ZSAmJiBvZl9nZXRfY2hpbGRfY291bnQoZGV2LT5vZl9ub2RlKSkNCj4gIAkJZGF0YS0+c2tpcF9z
Y2FuID0gdHJ1ZTsNCj4gLQkJcmV0ID0gb2ZfbWRpb2J1c19yZWdpc3RlcihkYXRhLT5idXMsIGRl
di0+b2Zfbm9kZSk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJcmV0ID0gbWRpb2J1c19yZWdpc3Rlcihk
YXRhLT5idXMpOw0KPiAtCX0NCj4gKw0KPiArCXJldCA9IG9mX21kaW9idXNfcmVnaXN0ZXIoZGF0
YS0+YnVzLCBkZXYtPm9mX25vZGUpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gYmFpbF9vdXQ7
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21kaW8tZ3Bpby5jIGIvZHJpdmVy
cy9uZXQvcGh5L21kaW8tZ3Bpby5jIGluZGV4DQo+IGI1MDEyMjE4MTllMS4uNGU0YzhkYWY0NGMz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWRpby1ncGlvLmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvcGh5L21kaW8tZ3Bpby5jDQo+IEBAIC0xNzksMTEgKzE3OSw3IEBAIHN0YXRpYyBp
bnQgbWRpb19ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJ
aWYgKCFuZXdfYnVzKQ0KPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gDQo+IC0JaWYgKHBkZXYtPmRl
di5vZl9ub2RlKQ0KPiAtCQlyZXQgPSBvZl9tZGlvYnVzX3JlZ2lzdGVyKG5ld19idXMsIHBkZXYt
PmRldi5vZl9ub2RlKTsNCj4gLQllbHNlDQo+IC0JCXJldCA9IG1kaW9idXNfcmVnaXN0ZXIobmV3
X2J1cyk7DQo+IC0NCj4gKwlyZXQgPSBvZl9tZGlvYnVzX3JlZ2lzdGVyKG5ld19idXMsIHBkZXYt
PmRldi5vZl9ub2RlKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQltZGlvX2dwaW9fYnVzX2RlaW5pdCgm
cGRldi0+ZGV2KTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWRpby1tc2Nj
LW1paW0uYw0KPiBiL2RyaXZlcnMvbmV0L3BoeS9tZGlvLW1zY2MtbWlpbS5jDQo+IGluZGV4IDhj
Njg5Y2NmZGJjYS4uYmFkYmM5OWJlZGQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9waHkv
bWRpby1tc2NjLW1paW0uYw0KPiArKysgYi9kcml2ZXJzL25ldC9waHkvbWRpby1tc2NjLW1paW0u
Yw0KPiBAQCAtMTUxLDExICsxNTEsNyBAQCBzdGF0aWMgaW50IG1zY2NfbWlpbV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQl9DQo+ICAJfQ0KPiANCj4gLQlpZiAo
cGRldi0+ZGV2Lm9mX25vZGUpDQo+IC0JCXJldCA9IG9mX21kaW9idXNfcmVnaXN0ZXIoYnVzLCBw
ZGV2LT5kZXYub2Zfbm9kZSk7DQo+IC0JZWxzZQ0KPiAtCQlyZXQgPSBtZGlvYnVzX3JlZ2lzdGVy
KGJ1cyk7DQo+IC0NCj4gKwlyZXQgPSBvZl9tZGlvYnVzX3JlZ2lzdGVyKGJ1cywgcGRldi0+ZGV2
Lm9mX25vZGUpOw0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwg
IkNhbm5vdCByZWdpc3RlciBNRElPIGJ1cyAoJWQpXG4iLCByZXQpOw0KPiAgCQlyZXR1cm4gcmV0
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYyBiL2RyaXZlcnMvbmV0
L3VzYi9sYW43OHh4LmMgaW5kZXgNCj4gOTE3NjE0MzY3MDlhLi44ZGZmODdlYzZkOTkgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
dXNiL2xhbjc4eHguYw0KPiBAQCAtMTg0MywxMiArMTg0Myw5IEBAIHN0YXRpYyBpbnQgbGFuNzh4
eF9tZGlvX2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpkZXYpDQo+ICAJfQ0KPiANCj4gIAlu
b2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUoZGV2LT51ZGV2LT5kZXYub2Zfbm9kZSwgIm1kaW8i
KTsNCj4gLQlpZiAobm9kZSkgew0KPiAtCQlyZXQgPSBvZl9tZGlvYnVzX3JlZ2lzdGVyKGRldi0+
bWRpb2J1cywgbm9kZSk7DQo+ICsJcmV0ID0gb2ZfbWRpb2J1c19yZWdpc3RlcihkZXYtPm1kaW9i
dXMsIG5vZGUpOw0KPiArCWlmIChub2RlKQ0KPiAgCQlvZl9ub2RlX3B1dChub2RlKTsNCj4gLQl9
IGVsc2Ugew0KPiAtCQlyZXQgPSBtZGlvYnVzX3JlZ2lzdGVyKGRldi0+bWRpb2J1cyk7DQo+IC0J
fQ0KPiAgCWlmIChyZXQpIHsNCj4gIAkJbmV0ZGV2X2VycihkZXYtPm5ldCwgImNhbid0IHJlZ2lz
dGVyIE1ESU8gYnVzXG4iKTsNCj4gIAkJZ290byBleGl0MTsNCj4gLS0NCj4gMi4xNC4xDQoNCg==
