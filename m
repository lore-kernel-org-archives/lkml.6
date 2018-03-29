Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3590885-1522282344-2-2052466101926462569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522282343; b=obnjDzyfww+70dzXcZQW702D2qrQ43om63HSdNjhpzzxAFk
    XB/fV7isjNeRtBf9h+0qcxC7MGW1ysdoSgwzJVdFFg5eLN7PvzbNG3dwtsClBUdn
    vX3niI6HsIUTzvT2yNIzIMOuVeRfJ2lLUCJ/MD1oodMuJy25HEGFRr1Z2hzKfj8G
    Z695ISGW18cLjsED+4w/+iyNENklA4Omrr5l6gcIYaHmZAS2FvjB0P6MA/U8xVwK
    yg+0CGaUWoV/06nhpk1wclFnp/4KZKtIH/ReiLLjoIOPapFLv5K6NKjwlT0JsCgM
    GRJck4KaYXCY7Ar11zK8ay0j5ZXdEG0vvsSNABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1522282343; bh=tZcmRfTS6ijvcRDEr/vVnwxlWbufQxQmOmOozl
    bnJWc=; b=UmQzlw+wGtMmCDscSnwmtj86ADA/VaYB3bpIhND8cC9Td5gP5AtcVm
    TCe5c2wwamQs+wm5S4z9tMEH3fyV2x3Cq2NFj3epEP+hKv1Fef2BrwbEuBkSi8Z/
    QduWsRwzmfC2xfRPdKrpS+zE/fvqcj7KH0QyXA0i+Eu4dXlsndkFOu3yRBu6KuMi
    c1f9vw+D3+dsw55X4//Vu2i9KvCDygFHCetixJxT/5BJbjt96gSwifTYrAX8nzk/
    ZSFbmaULQ/IndYDXdQrNI9TCYbxIfl3uLkt2ZYvrXVP1++NAD3t/FrGUOVgijavW
    KOPq0Ubh6jT5KNSmXC6Z0MMIBiVzgJAg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=impinj.onmicrosoft.com header.i=@impinj.onmicrosoft.com header.b=fQAsric1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-impinj-com;
    dkim=permerror (syntax or domain error);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=impinj.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=impinj.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=impinj.onmicrosoft.com header.i=@impinj.onmicrosoft.com header.b=fQAsric1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-impinj-com;
    dkim=permerror (syntax or domain error);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=impinj.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=impinj.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfINzSiK5OwGW9FMynnwluuTDZpB6jQPoYQh9A1QhgTBak0ez+6SD2/ty8zYYxgMwq8khbw5GCvtBiBt36lu9jdRnTC54nofNWKKb9nDC0RG7/oH5nPZs
    fissc3KBZrHLcFFe1IWW992Iq9cu0Lvgle0IcwWJWzucIBgGw+7OyZ/IKxW4zdPLaZRzaFH9k5G9HP283r8UWiHjH8Trlke87OP4aTjNM91Y9cdRdCkWXNqN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=3__JM4gSSC0A:10 a=IATMpVkM7q4A:10
    a=mnh4nG2Pd10A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=T61J-ygrL8wA:10 a=voM4FWlXAAAA:8 a=zCH54m_U67Dmk6PPy7cA:9 a=QEXdDO2ut3YA:10
    a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeC2AMW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 20:12:22 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:8112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeC2AMU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 20:12:20 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Thread-Topic: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Thread-Index: AQHTxvKZmv6BIX/0UUiB/ib/Q5SvIg==
Date: Thu, 29 Mar 2018 00:12:18 +0000
Message-ID: <1522282337.10662.268.camel@impinj.com>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
In-Reply-To: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3610;7:/E0juJ73byidfpjA9pfoHwFbBTPMI1unOKMzq8xzQONW1a/pwB6fXVZmh6RAftiyGY8XegZVQhS1hL5pWjxJi2D8KECDfMdUAY9b/syTNTcbTehl92+B0UpLktI+ecozOMgyRYbBpGStC417PwZ1aQihuctPjhI06S/sy2jhH+aAwNaLslzh/x+CFWzlV/iB3MZ88h8BJ3IIbumL7w+pRDhZizneumLoTZRZZ9xMqTgt6urAwz/peDFjeZg58Uc0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2ca8211d-c284-418c-58a0-08d59509bbf6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3610;
x-ms-traffictypediagnostic: MWHPR0601MB3610:
x-microsoft-antispam-prvs: <MWHPR0601MB361053A1A56D71ABDEF0E7A0D3A20@MWHPR0601MB3610.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR0601MB3610;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3610;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(376002)(346002)(366004)(396003)(189003)(199004)(377424004)(478600001)(6506007)(59450400001)(76176011)(316002)(103116003)(54906003)(110136005)(68736007)(86362001)(966005)(2900100001)(99286004)(5660300001)(2201001)(6116002)(3846002)(106356001)(14454004)(105586002)(6306002)(6512007)(2906002)(36756003)(8666007)(186003)(53936002)(66066001)(6486002)(3660700001)(6436002)(26005)(4326008)(81166006)(81156014)(25786009)(486005)(2616005)(486005)(3280700002)(8936002)(476003)(446003)(11346002)(8676002)(6246003)(229853002)(2501003)(7416002)(5250100002)(102836004)(305945005)(7736002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3610;H:MWHPR0601MB3753.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jfYADbIVAOM5HZrgjv53uGPysaCXsyAJAF5pBnCsyZwT01HdCv8F2MdRAe2YCyRDJxV5ofIDuOE9e/+tdujD+VIukjK0iRgJG1aInlWfSprevW4tRXKIF7HMeCyN7NqKL9JST17vNlYVPg9w6tEZgdEt9ig5Yv42MImT0FqnzsCpagMhweHljdtV5TbbiYeLmiBAxEznm1gEqqRa6BxRBc63jXFwESgMgonphOLW/rskaJ7a8vddT7AlU/9S92z0dQKM6SQTLTOSQW2wX+sWkSwMqRv8HvGE+T+JjUmjjaE0acP3SA+MP/A+6UMXI7BqvrylbGKixW4I4qjbBTV/kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <461B783C949D6146BF2DE86F426EB4E5@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca8211d-c284-418c-58a0-08d59509bbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 00:12:18.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3610
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTI4IGF0IDIwOjE0ICswMTAwLCBCcnlhbiBPJ0Rvbm9naHVlIHdyb3Rl
Og0KPiBjb21taXQgMTc5YTUwMmY4YzQ2ICgicnRjOiBzbnZzOiBhZGQgRnJlZXNjYWxlIHJ0Yy1z
bnZzIGRyaXZlciIpIGludHJvZHVjZXMNCj4gdGhlIFNOVlMgUlRDIGRyaXZlciB3aXRoIGEgZnVu
Y3Rpb24gc252c19ydGNfZW5hYmxlKCkuDQo+IA0KPiBzbnZzX3J0Y19lbmFibGUoKSBjYW4gcmV0
dXJuIGFuIGVycm9yIG9uIHRoZSBlbmFibGUgcGF0aCBob3dldmVyIHRoaXMNCj4gZHJpdmVyIGRv
ZXMgbm90IGN1cnJlbnRseSB0cmFwIHRoYXQgZmFpbHVyZSBvbiB0aGUgcHJvYmUoKSBwYXRoIGFu
ZA0KPiBjb25zZXF1ZW50bHkgaWYgZW5hYmxpbmcgdGhlIFJUQyBmYWlscyB3ZSBlbmNvdW50ZXIg
YSBsYXRlciBlcnJvciBzcGlubmluZw0KPiBmb3JldmVyIGluIHJ0Y193cml0ZV9zeW5jX2xwKCku
DQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIGJ5IHBhcnNpbmcgdGhlIHJlc3VsdCBvZiBydGNfd3Jp
dGVfc3luY19scCgpIGFuZA0KPiBwcm9wYWdhdGluZyBib3RoIGluIHRoZSBwcm9iZSBhbmQgZWxz
ZXdoZXJlLiBJZiB0aGUgUlRDIGRvZXNuJ3Qgc3RhcnQgd2UNCj4gZG9uJ3QgcHJvY2VlZCBsb2Fk
aW5nIHRoZSBkcml2ZXIgYW5kIGRvbid0IGdldCBpbnRvIHRoaXMgbG9vcCBtZXNzIGxhdGVyDQo+
IG9uLg0KPiANCg0KSSBzZW50IGEgcGF0Y2ggYSBjb3VwbGUgd2Vla3MgYWdvIHRoYXQgYWRkcmVz
c2VkIGEgc2ltaWxhciBpc3N1ZSwgc2VlDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Bh
dGNoLzg4NzA5MC8NCg0KRG9lcyB0aGlzIGFsc28gZml4IHRoZSBwcm9ibGVtIHlvdSBzZWU/DQoN
CkkgdGhpbmsgd2hhdCB5b3UndmUgZG9uZSB3aWxsIHByZXZlbnQgdGhlIGRyaXZlciBmcm9tIGxv
YWRpbmcgaWYgdGhlDQpjbG9jayBpcyBub3Qgd29ya2luZywgYnV0IGlmIHRoZSBjbG9jayBkb2Vz
IG5vdCB0aWNrIHByb3Blcmx5IGFmdGVyDQpsb2FkaW5nLCB0aGVyZSBhcmUgc3RpbGwgcG9pbnRz
IChzbnZzX3J0Y19yZWFkX3RpbWUgZm9yIG9uZSkgdGhhdCB3aWxsDQpsb2NrIHVwIGluIHRoZSBr
ZXJuZWwu
