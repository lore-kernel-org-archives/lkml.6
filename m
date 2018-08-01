Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B757C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DC420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbeHAHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:39:26 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:59442 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733303AbeHAHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:39:26 -0400
Received: from [192.168.20.11] (port=12401 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fkk6T-0004PA-1e; Wed, 01 Aug 2018 07:55:21 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 1 Aug
 2018 07:55:20 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Wed, 1 Aug 2018 07:55:20 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzv//7rwA//78udA=
Date:   Wed, 1 Aug 2018 05:55:20 +0000
Message-ID: <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
In-Reply-To: <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.21.69]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMzEsIDIwMTggYXQgMTU6MzY6MDVQTSArMDAwMCBBbmRyZXcgTHVubiB3cm90
ZToNCg0KPiBJcyB0aGlzIG1haW5saW5lIDMuNC4xMTMsIG9yIExQQyB2ZXJzaW9uPw0KTWFpbmxp
bmUsIGFmYWlrIHRoZXJlIGlzIG5vIG5ld2VyIHZlcnNpb24gb2YgdGhlIGxwYyBrZXJuZWwgYW5k
IHRoZSBscGMgZHJpdmVyIGFyZSB1cHN0cmVhbSBzaW5jZSAzLjQgKGhlbmNlIHRoZSAzLjQuMTEz
IGtlcm5lbCB2ZXJzaW9uIHdlIHRyaWVkKS4NCg0KPiBIb3cgbXVjaCB3b3JrIGlzIGludm9sdmVk
IGluIHRlc3RpbmcgYSBuZXdlciBrZXJuZWwuIFlvdSBhcmUgbm90IGdvaW5nIHRvIGdldCB0b28g
bXVjaCBoZWxwIGZyb20gdGhlIGNvbW11bml0eSB3aXRoIHN1Y2ggYW4gb2xkIGtlcm5lbC4gSWYg
eW91IGNhbiByZXByb2R1Y2UgaXQgd2l0aCBhIG1vZGVybiBkYXkga2VybmVsLCB0aGVuIHBlb3Bs
ZSBhcmUgbW9yZSBsaWtlbHkgdG8gaGVscC4NCg0KV2UgaGF2ZW4ndCB0cmllZCBhbnkgbmV3ZXIg
dmVyc2lvbiwgYmVjYXVzZSBEVFMgaXMgbWFuZGF0b3J5IHNpbmNlIDMuNSBhZmFpaz8gV2UgaGFk
bid0IHRoZSB0aW1lIHRvIGxvb2sgaW50bywgYWx0aG91Z2ggaXQgbG9va3MgcHJldHR5IHN0cmFp
Z2h0IGZvcndhcmQuDQoNCj4+IEtlcm5lbCBvb3BzOg0KPj4gWyAxMTI1LjA5MDAwMF0gVW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCANCj4+IGFkZHJlc3Mg
YzE0ZmU2M2EgWyAxMTI1LjEwMDAwMF0gcGdkID0gYzE0ZDgwMDAgWyAxMTI1LjEwMDAwMF0gDQo+
PiBbYzE0ZmU2M2FdICpwZ2Q9ODE0MDA0MWUoYmFkKSBbIDExMjUuMTAwMDAwXSBJbnRlcm5hbCBl
cnJvcjogT29wczogMSANCj4+IFsjMV0gUFJFRU1QVCBBUk0gWyAxMTI1LjEwMDAwMF0gTW9kdWxl
cyBsaW5rZWQgaW46DQo+PiBbIDExMjUuMTAwMDAwXSBDUFU6IDAgICAgTm90IHRhaW50ZWQgICgz
LjQuMTEzLjcgIzEpDQo+PiBbIDExMjUuMTAwMDAwXSBQQyBpcyBhdCB1ZHBfcmVjdm1zZysweDI4
NC8weDMzYyBbIDExMjUuMTAwMDAwXSBMUiBpcyANCj4+IGF0IDB4MA0KPiBMUiA9PSAwIGlzIHN1
c3BpY2lvdXMuIEl0IHNob3VsZCBjb250YWluIHRoZSByZXR1cm4gYWRkcmVzcywgaW5ldF9yZWN2
bXNnKzB4MzgvMHg0Yy4gVGhhdCBpcyBhc3N1bWluZyB0aGUgY2FsbGluZyBjb252ZW50aW9uIGlz
IHRoZSBzYW1lIGZvciB0aGlzIG9sZCBrZXJuZWwgYXMgdG9kYXlzIGtlcm5lbHMgb24gQVJNLg0K
DQpJIHdpbGwgZG8gYSBsaXR0bGUgZGVidWdnaW5nIHdoeSBMUiBpcyAwIGhlcmUuIE1heWJlIHRo
YXQncyB0aGUgY2x1ZS4NCg0KPiBDb3VsZCB5b3UgcHJvZHVjZSBuZXQvaXB2NC91ZHAubHN0IGZv
ciB0aGlzIGV4YWN0IGtlcm5lbCBidWlsZD8NCg0KU3VyZTogaHR0cHM6Ly9naXN0LmdpdGh1Yi5j
b20vaGVsbG93NTU0LzZiMTFjNmMwODI3ZDVkYjgwYTdlNjZmNzFmNTYzNmZmI2ZpbGUtbmV0X3Vp
cHY0X3VkcC1sc3QNCg0KPiBBbnkgaWRlYSBob3cgeW91IGNvdWxkIGdldCBmaWxlOmxpbmUgaW5m
b3JtYXRpb24gPw0KPiAoIGxpa2UgOiB1ZHBfc2V0c29ja29wdCsweDYyLzB4YTAgbmV0L2lwdjQv
dWRwLmM6MjUwMiApDQoNCls8YzAyMjhhZGM+XSAodWRwX3JlY3Ztc2crMHgyODQvMHgzM2MpIGZy
b20gWzxjMDIzMDZlMD5dIChpbmV0X3JlY3Ztc2crMHgzOC8weDRjKTogbmV0L2lwdjQvdWRwLmM6
MTIzNA0KWzxjMDIzMDZlMD5dIChpbmV0X3JlY3Ztc2crMHgzOC8weDRjKSBmcm9tIFs8YzAxZDJj
Mzg+XSAoc29ja19yZWN2bXNnKzB4YTgvMHhjYyk6IGluY2x1ZGUvbGludXgvZmlsZS5oOjI1DQpb
PGMwMWQyYzM4Pl0gKHNvY2tfcmVjdm1zZysweGE4LzB4Y2MpIGZyb20gWzxjMDFkM2ZhYz5dIChf
X19zeXNfcmVjdm1zZy5wYXJ0LjQrMHhlMC8weDFiYyk6IG5ldC9zb2NrZXQuYzo3NTENCls8YzAx
ZDNmYWM+XSAoX19fc3lzX3JlY3Ztc2cucGFydC40KzB4ZTAvMHgxYmMpIGZyb20gWzxjMDFkNGZi
Yz5dIChfX3N5c19yZWN2bXNnKzB4NTAvMHg4MCk6IG5ldC9zb2NrZXQuYzoyMTkzDQpbPGMwMWQ0
ZmJjPl0gKF9fc3lzX3JlY3Ztc2crMHg1MC8weDgwKSBmcm9tIFs8YzAwMGRmZTA+XSAocmV0X2Zh
c3Rfc3lzY2FsbCsweDAvMHgyYyk6IGluY2x1ZGUvbGludXgvZmlsZS5oOjI1IChmcm9tIGFyY2gv
YXJtL2tlcm5lbC9lbnRyeS1jb21tb24uUzozNCkNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjMuNC4xMTMvc291cmNlIDopDQoNCg0KTWFueSB0aGFua3MgZm9yIHRoZSBhbnN3
ZXIsIEkgaG9wZSBJIGNvdWxkIGFuc3dlciB5b3VyIHF1ZXN0aW9ucy4NCg0KDQpNaXQgZnJldW5k
bGljaGVuIEdyw7zDn2VuIC8gV2l0aCBraW5kIHJlZ2FyZHMNCg0KTWFyY2VsIEhlbGx3aWcNCkIu
IFNjLiBJbmZvcm1hdGlrDQpFbnR3aWNrbGVyDQoNCm0tdS10wqBHbWJIDQpBbSBNYXJpZW5ob2Yg
Mg0KMjI4ODAgV2VkZWwNCkdlcm1hbnkNCg0KUGhvbmU6CSs0OSA0MTAzIDkzMDggLSA0NzQNCkZh
eDrCoMKgCSs0OSA0MTAzIDkzMDggLSA5OQ0KbWhlbGx3aWdAbXV0LWdyb3VwLmNvbQ0KDQp3d3cu
bXV0LWdyb3VwLmNvbQ0KDQpHZXNjaMOkZnRzZsO8aHJlcsKgKE1hbmFnaW5nIERpcmVjdG9yKTog
RmFiaWFuIFBldGVycw0KQW10c2dlcmljaHQgUGlubmViZXJnIChDb21tZXJjaWFsIFJlZ2lzdGVy
IE5vLik6IEhSQsKgMTAzMDQgUEkNClVTdC1JZE5yLiAoVkFULU5vLik6IERFMjI4Mjc1MzkwDQpX
RUVFLVJlZy1Oci46IERFIDcyMjcxODA4DQoNCg0K
