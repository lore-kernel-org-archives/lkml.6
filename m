Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790900-1524760209-2-5334442294429746820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524760207; b=FfingAmOr8CfXcI9Vf06sKzBtL29KzKdp9kxKlrwW/1XR6/Q1V
    m+CONyU6Ss8Tjkk0yKGJ7QEM5BwCepGXkUouXU16aZdPpF2pUz6bhDuo9LCKps4u
    /vjxF9bnIqXPmtHYCUVEYzdJGxFfEdkuRGzBG2AI+7PNtv1DGEqDxEqn0JFgN+6z
    29h5AhOvyL22DQnCAS5Z80gQr7YbIuoJL1jQ11Qm1pPoxI4bSdR+8zh+6wPTeosx
    rWq9WB/Nkd/Eg4O825YcXK0ktnmon/htq4yU5fGr1imoWiOEL6RrqBQf9O5IHeD+
    iJR8VVGxf4M0CHeyT+DXAzsgh8H7GlPEI3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524760207; bh=5UIUYWTdMEje+BE5IBJ2bGTYatx0GwtQMPrRNcChMLY=; b=
    i3Q9LW27r5oWL+sq39dB6KKWNR1vZ/ltoYdqx9xF7iN5pzwgYKjvxZfXCOQmqXJ9
    CcH6JrSOsaEKra4+jFg1HyjLlEp2vZVeDiCIiKfRwvNI42boj9o/D9mOEwjFpgJ0
    yTYkYkO4pTVVoxnDSUTufNFH2pvXiOgHckb4h3OPpE0e7LBVeqxBM5dwYpzZbsAG
    3h371FIUZ0cr/XdIcNSe0L25/rpt4aEuwyWfXM0XfusLty7Ur4cxSL2jPOMCV9C1
    TG1XIZTBEl+uFGZaJGyJmapI6PdBJk2ZTxxsDG0rh0QhS8/1+3+cjmQMSiYqyCy8
    u3v4XHJD1TtQl5Yj2IW5gA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFI7tD277Hx9z5Oe3pVtjvWNMhV9iYoyfhoeuuSoCJnNBs8iZXBp9zkj+r/2sQR2HCP2dFuKVvlGX3e6O+27l7deKoqEPkJ8GvYTLOT+qvorEwLFn2p3
    6/O7oNHLMukqVhgrxz4uqdDpoNLvnXFu4ffq0F4wnP9w0ZOTQxQMN784KLMcXN4vy0RjMlk2GTh8NMorEvFhKTj5xbjWzqWCzl9iUpqwvL4/VB+3rYRFE+O1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VtQtJH8w3oYA:10 a=hkdB2cgs02UA:10
    a=TQVxmOB8j98A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=YTl16nNC1dadZHocRmEA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756670AbeDZQ3w (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 12:29:52 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:57566 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeDZQ3t (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 12:29:49 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "Hocko, Michal" <MHocko@suse.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Thread-Topic: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Thread-Index: AQHT3XFOK+nexkbX406FiURX1p6mcqQTPGiA
Date: Thu, 26 Apr 2018 16:29:45 +0000
Message-ID: <1524760125.2693.468.camel@hpe.com>
References: <1524755647-18695-1-git-send-email-joro@8bytes.org>
In-Reply-To: <1524755647-18695-1-git-send-email-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1138;7:vf0/CZ63QY3R1yZAreILrJ2Y8qpkcpjV7zKgAd5JwgRj6Fr2SkySr3OQRWhiMA6yLTjHLVJ8xX3gVGnNZeTAtrmAC78Fr5mo28hvvPMxIEBY7Go0kH6b7od0SJgQLS5ymr6T0xtq0i+pSYau1FKTYHw3embfoSUMVxEh823JjI2EdstqyVHOBxKbxbHOJUkNdYrwSgjscv9lHNsPHrmUz1oJHhN1bsC20vDK/0RJin+8ILWBcjwV88V/1TLPKPlG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1138;
x-ms-traffictypediagnostic: AT5PR8401MB1138:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB1138C90308BA02A59DF1D7CA828E0@AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AT5PR8401MB1138;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1138;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(377424004)(189003)(199004)(2501003)(2900100001)(81166006)(81156014)(25786009)(4326008)(66066001)(446003)(5250100002)(11346002)(8676002)(2616005)(8936002)(5660300001)(7736002)(305945005)(6486002)(229853002)(7416002)(575784001)(86362001)(2201001)(36756003)(3280700002)(3660700001)(6512007)(6246003)(486006)(476003)(14454004)(53936002)(76176011)(105586002)(97736004)(26005)(6116002)(6436002)(54906003)(110136005)(316002)(6506007)(99286004)(106356001)(102836004)(186003)(478600001)(2906002)(103116003)(68736007)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1138;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uVSH7h+dYK5AATpbTIGhBg/DUodQNqSL7SisNX+beNPH5aDJaEAujAQF3v3A3yYKblgbs4w7kVY7p//XEzHP+JR7LYRsAtH9H34sHX1Dbv9i2tw/4ZD/ey3bQ1K5TCZ8ZgLWqcseHUxbw3YPKSx5N5D2NaH2KqmU5koy9kjFEiA7xAiLjHxnZkbOEx29xBg9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <650764995B565945A8C5DDF6D1BFB08E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61bc0d8e-7207-473a-343a-08d5ab92ebed
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc0d8e-7207-473a-343a-08d5ab92ebed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 16:29:45.3048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1138
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTI2IGF0IDE3OjE0ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEZyb206IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gVGhpcyByZXZlcnRz
IGNvbW1pdCAyOGVlOTBmZTYwNDhmYTdiN2NlYWViODgzMWMwZTRlNDU0YTRjZjg5Lg0KPiANCj4g
VGhpcyBjb21taXQgaXMgYnJva2VuIGZvciB4ODYsIGFzIGl0IHVubWFwcyB0aGUgUFRFIGFuZCBQ
TUQNCj4gcGFnZXMgYW5kIGltbWVkaWF0bHkgZnJlZXMgdGhlbSB3aXRob3V0IGRvaW5nIGEgVExC
IGZsdXNoLg0KPiANCj4gRnVydGhlciB0aGlzIGxhY2tzIHN5bmNocm9uaXphdGlvbiB3aXRoIG90
aGVyIHBhZ2UtdGFibGVzIGluDQo+IHRoZSBzeXN0ZW0gd2hlbiB0aGUgUE1EIHBhZ2VzIGFyZSBu
b3Qgc2hhcmVkIGJldHdlZW4NCj4gbW1fc3RydWN0cy4NCj4gDQo+IE9uIHg4Ni0zMiB3aXRoIFBB
RSBhbmQgUFRJIHBhdGNoZXMgb24tdG9wIHRoaXMgcGF0Y2gNCj4gdHJpZ2dlcnMgdGhlIEJVR19P
TiBpbiB2bWFsbG9jX3N5bmNfb25lKCkgYmVjYXVzZSB0aGUga2VybmVsDQo+IGFuZCB0aGUgcHJv
Y2VzcyBwYWdlLXRhYmxlIHdlcmUgbm90IHN5bmNocm9uaXplZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KDQpJIGRvIG5vdCBhZ3JlZSB3aXRo
IHRoZSBjb21tZW50cyBhbmQgdGhpcyByZXZlcnQuICBMZXQncyBkaXNjdXNzIGZ1cnRoZXINCm9u
IHRoZSBvcmlnaW5hbCB0aHJlYWQuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
