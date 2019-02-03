Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2DB2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfBCGFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 01:05:04 -0500
Received: from smtpext4.darkmatter.ae ([185.180.84.5]:54270 "EHLO
        smtpext4.darkmatter.ae" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBCGFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 01:05:04 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2019 01:05:01 EST
IronPort-PHdr: =?us-ascii?q?9a23=3AQUEUHxMgKHp+e4FIvnMl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0K/j9rsbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzdb7fc9wHX2pMRsZfWTJcDIOg?=
 =?us-ascii?q?YYUBDOQBPedXoIbhvFYOqAeyBQu2Ce/z1jNFhHn71rA63eQ7FgHG2RQtEdcQv3?=
 =?us-ascii?q?TJqtX5Lb4cWv2vwqbS1zXDbO5d1DD45ofWbxAhp+iAU6tqfcTL00YvDQDFg06N?=
 =?us-ascii?q?poP/JTOV1eENvHKH7+p8S+2vkXQrpBtvrTW2wMonl4rHhpoNx1zZ6Sl12pg5Kc?=
 =?us-ascii?q?O3RUJhfNKoCp9duz2CO4drXs8uWX9ktDg1x7Ecu5O2czIGxZA7yxPZdveJaZKH?=
 =?us-ascii?q?4gj5W+aUOTp4gXVld6+hiBuq6kigz/H8VtGz0FZXsipJitnMuW4J1xzU8sWHSe?=
 =?us-ascii?q?Vy/0e62TqWyQ/S5f1ELV4umaXGMZEh2L0wlp8JvkTfAi/5hl/2gLWMeUo64uSo?=
 =?us-ascii?q?6uLnbav6ppKEKoN4lhvyProwlsGwG+g0LxICUmyH9eik0b3s50z5QLFEjv0sla?=
 =?us-ascii?q?nZtYjXK8EFqa6kBQ9Zy58t5wylATi8ytQYnmIKI09fdxKdjIjpPkvBIOzkDfih?=
 =?us-ascii?q?mVSgii1kyO7eMr37HprNNmTDkKvmfbtl805T1hYzws5F559PCrEBPejzWkvvu9?=
 =?us-ascii?q?3YFR85NAK0w/rpCdpnzIMRR3iDDbOeMKPXqVWI/P4gI/GQZI8JvzbwM/cl5+Tw?=
 =?us-ascii?q?gn82ml8dfbKk3Z8WaHC+A/RnLEuZYX3xgtcHDGgFpBY+TO3tiF2ESzJTYGyyX6?=
 =?us-ascii?q?0k7DEhFI2mFZvDRpyqgLGZxii3BIZWaXpGClCWC3jpeZ+LW+sXZSKJOMBhlycE?=
 =?us-ascii?q?VaWnS48uzx2hqAj6y79/JOrO5iIYrY7j1MRy5+DLjx4z9SF0D9+d022XSmF5hX?=
 =?us-ascii?q?gISCUz3KBkvEx9zFiD3bJkjPxfENxZ/+lJXRsiNZ7A0+x6DMj/WgfbcdePSVam?=
 =?us-ascii?q?RMipDi8rTt4s2dMOeF1wG864gRDGxCqqHrkVl7ORCJMo9aLc2mD7J9xhxHbeyK?=
 =?us-ascii?q?khk14mT9NVNWG8mq5/9xLcB5bNk0WYl6elb6Ac0TXW9GiZyGqOp1xYUAh/Uanf?=
 =?us-ascii?q?QX8fYU7Wp8zj5kzeV7+uFagnMgxZxM6cMKdKbMfmjU9cS/flN9TTeHmxlH21BR?=
 =?us-ascii?q?aT27OMaoXqd38B0yXaDUgOixoT8mqeNQgiGiehpHrTDD51FVLreUzj6ul/pWig?=
 =?us-ascii?q?Tk8p1AGFcVdt2Kay+h4QnfacUe8c3qoYuCc9rDV5BFK939PQC9qdqAttZaZcbs?=
 =?us-ascii?q?0n4FdBy23ZsxdwPoKvL698nF4SaQd3sF301xVxFIpAldImrHQwzAp9euqk1wYL?=
 =?us-ascii?q?cjqe3Jb8N6eObHLa5xmqcLPQ1RfV19PcsvMK4fI5rVnupljvDWI5+nB8zt9alX?=
 =?us-ascii?q?Cb48OOREAdS5/+UUYf8xl8uqHUZTQ764rI1Hpqd66uvXWKj90zCeQmyj6kftFC?=
 =?us-ascii?q?IK2DCQn+GtEbAM7oL/YlzRzhJAoJIO1I3K4pJcerZuCB1rK0Nfxt2jmhiC4PtJ?=
 =?us-ascii?q?hwzk+W3yphUOrFzo0Cze2H1xGKETz7iQHl+or1goRNbyA6BXekxG7vA4sbLvlw?=
 =?us-ascii?q?ZoICA3aGONCsy5N1gJu7CFBC81v2JF4b3oqOMSKbdV+1iS5dyEJShjqfkDG75z?=
 =?us-ascii?q?B9iTIsp7aD0TaIyum0J0lPAXJCWGQ31QSkGoOzld1PGRHwNwU=3D?=
X-IPAS-Result: =?us-ascii?q?A2kDAAAwgVZc/1oB4AphAxoBAQEBAQIBAQEBBwIBAQEBgVE?=
 =?us-ascii?q?FAQEBAQsBhBQKg3mIGo1+g1CUP4F7DAGBd4J1AheDHTQJDQEDAQEBAQEBAgEBA?=
 =?us-ascii?q?QGBEYI6KQGCZwEBAQECASMEUhACAQYCDQQDAQIBKgICAjAdCAIEAQ0FCAaDFYF?=
 =?us-ascii?q?5jECbYXwzGgKJeA+CfogmgzMmgn9JNYUYCQELG4JCglcCiVcGGIIDhBeBeJBrB?=
 =?us-ascii?q?wKERI1uIYFshUGDKwOCVYFvgXCBNS2JdpE1AgICAgkCFIFGYYEuTYNfgigXjh5?=
 =?us-ascii?q?yjFwEgSqBHwEB?=
X-IronPort-AV: E=Sophos;i="5.56,555,1539633600"; 
   d="scan'208,223";a="1359610"
Received: from unknown (HELO keys-ext2.darkmatter.ae) ([10.224.1.90])
  by ADMSS-00-D-002-DATA2-KDC.darkmatter.uae with ESMTP/TLS/DES-CBC3-SHA; 03 Feb 2019 09:54:53 +0400
Received: from ForcepointDLP ([10.224.1.90])
  by keys-ext2.darkmatter.ae (PGP Universal service);
  Sun, 03 Feb 2019 09:54:52 +0400
X-PGP-Universal: processed;
        by keys-ext2.darkmatter.ae on Sun, 03 Feb 2019 09:54:52 +0400
Received: from PassiveEmail (PassiveEmail [127.0.0.1])
        by PassiveEmail.localdomain (Service) with ESMTP id 0B501180009A;
        Sun,  3 Feb 2019 09:52:41 +0400 (GST)
Received: from email.darkmatter.ae (unknown [10.224.74.12])
        by PassiveEmail.localdomain (Service) with ESMTP id E7C3C1800098;
        Sun,  3 Feb 2019 09:52:40 +0400 (GST)
Received: from ADKDCSVMC001.darkmatter.uae (10.224.74.11) by
 ADKDCSVMC002.darkmatter.uae (10.224.74.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Sun, 3 Feb 2019 09:54:51 +0400
Received: from ADKDCSVMC001.darkmatter.uae ([::1]) by
 ADKDCSVMC001.darkmatter.uae ([fe80::58c5:b1df:29a1:fe6f%18]) with mapi id
 15.01.1531.010; Sun, 3 Feb 2019 09:54:51 +0400
From:   Keun-O Park <Keun-O.Park@darkmatter.ae>
To:     "maninder1.s@samsung.com" <maninder1.s@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter@hurleysoftware.com" <peter@hurleysoftware.com>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "AMIT SAHRAWAT" <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Ayush Mittal <ayush.m@samsung.com>
Subject: Re: race between flush_to_ldisc and pty_cleanup
Thread-Topic: race between flush_to_ldisc and pty_cleanup
Thread-Index: AQHUujgrtYRy6+Ptu0W2Q4s+Xo32DQ==
Date:   Sun, 3 Feb 2019 05:54:51 +0000
Message-ID: <7668b2ad75e044d38b17f6ce32845dfb@darkmatter.ae>
References: <20190201142642.GB3211@kroah.com>
 <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
 <CGME20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
 <20190201143747epcms5p579d523f0458736dcaaf55dec453cf6b9@epcms5p5>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.224.74.90]
x-exclaimer-md-config: 77ff947c-8af8-48f1-8d81-f67dcf75dbee
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/mixed;
        boundary="_002_7668b2ad75e044d38b17f6ce32845dfbdarkmatterae_"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_7668b2ad75e044d38b17f6ce32845dfbdarkmatterae_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCjAyLzAxLzIwMTkgMDc6MzEgUE3sl5AgTWFuaW5kZXIgU2luZ2gg7J20KOqwgCkg7JO0
IOq4gDoNCj4gSGksDQo+DQo+PiBPbiBGcmksIEZlYiAwMSwgMjAxOSBhdCAwNzowMzoyNlBNICsw
NTMwLCBNYW5pbmRlciBTaW5naCB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+DQo+Pj4gVGhlcmUg
aXMgc29tZSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIHR0eV9wb3J0X3B1dCBhbmQgZmx1c2hfdG9f
bGRpc2MNCj4+PiB3aGljaCBsZWFkIHRvIHVzZSBhZnRlciBmcmVlIGNhc2U6DQo+Pj4gKEtlcm5l
bCA0LjEpDQo+Pj4NCj4+PiBbMTQwMy41MTMwXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdp
bmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgNmI2YjZiODMNCj4+PiAuLi4NCj4+PiAuLi4N
Cj4+PiAuLi4NCj4+Pg0KPj4+IFsxNDAzLjUxMzJdIFs8YzAzNmE2NWM+XSAobGRzZW1fZG93bl9y
ZWFkX3RyeWxvY2spIGZyb20gWzxjMDM2N2RiND5dICh0dHlfbGRpc2NfcmVmKzB4MjQvMHg2MCkN
Cj4+PiBbMTQwMy41MTMyXSBbPGMwMzY3ZDkwPl0gKHR0eV9sZGlzY19yZWYpIGZyb20gWzxjMDM2
OTBjYz5dIChmbHVzaF90b19sZGlzYysweDZjLzB4MjFjKQ0KPj4+IFsxNDAzLjUxMzJdICByNTpk
YmNkNGE4NCByNDowMDAwMDAwMA0KPj4+IFsxNDAzLjUxMzJdIFs8YzAzNjkwNjA+XSAoZmx1c2hf
dG9fbGRpc2MpIGZyb20gWzxjMDA0OWYxOD5dIChwcm9jZXNzX29uZV93b3JrKzB4MjE0LzB4NTcw
KQ0KPj4+IFsxNDAzLjUxMzJdICByMTA6MDAwMDAwMDAgcjk6ZGRhYjAwMDAgcjg6ZTNkNmUwMDAg
cjc6MDAwMDAwMDAgcjY6ZTQ1M2Y3NDAgcjU6Y2IzN2I3ODANCj4+PiBbMTQwMy41MTMyXSAgcjQ6
ZGJjZDRhODQNCj4+PiBbMTQwMy41MTMyXSBbPGMwMDQ5ZDA0Pl0gKHByb2Nlc3Nfb25lX3dvcmsp
IGZyb20gWzxjMDA0YTJkND5dICh3b3JrZXJfdGhyZWFkKzB4NjAvMHg1ODApDQo+Pj4gWzE0MDMu
NTEzMl0gIHIxMDplNDUzZjc0MCByOTpkZGFiMDAwMCByODplNDUzZjc2NCByNzowMDAwMDA4OCBy
NjplNDUzZjc0MCByNTpjYjM3Yjc5OA0KPj4+IFsxNDAzLjUxMzJdICByNDpjYjM3Yjc4MA0KPj4+
IFsxNDAzLjUxMzJdIFs8YzAwNGEyNzQ+XSAod29ya2VyX3RocmVhZCkgZnJvbSBbPGMwMDUwMjJj
Pl0gKGt0aHJlYWQrMHhlYy8weDEwNCkNCj4+PiBbMTQwMy41MTMyXSAgcjEwOjAwMDAwMDAwIHI5
OjAwMDAwMDAwIHI4OjAwMDAwMDAwIHI3OmMwMDRhMjc0IHI2OmNiMzdiNzgwIHI1OmQ4YTNmYzgw
DQo+Pj4gWzE0MDMuNTEzMl0gIHI0OjAwMDAwMDAwDQo+Pj4gWzE0MDMuNTEzMl0gWzxjMDA1MDE0
MD5dIChrdGhyZWFkKSBmcm9tIFs8YzAwMTA3ZDg+XSAocmV0X2Zyb21fZm9yaysweDE0LzB4M2Mp
DQo+Pj4NCj4+Pg0KPj4+IGZvciBjaGVja2luZyBmdXJ0aGVyIHdlIGVudGVyZWQgc29tZSBkZWJ1
ZyBwcmludHMgYW5kIGFkZGVkIGRlbGF5IGluIGZsdXNoX3RvX2xkaXNjIHRvIHJlcHJvZHVjZQ0K
Pj4+IGFuZCBzZWVtcyB0aGVyZSBpcyBzb21lIGlzc3VlIHdpdGggd29ya3F1ZXVlIGltcGxlbWVu
dGF0aW9uIG9mIFRUWToNCj4+Pg0KPj4+IGJvb2wgdHR5X2J1ZmZlcl9jYW5jZWxfd29yayhzdHJ1
Y3QgdHR5X3BvcnQgKnBvcnQpDQo+Pj4gew0KPj4+ICAgICAgICAgYm9vbCByZXQ7DQo+Pj4gICAg
ICAgICByZXQgPSBjYW5jZWxfd29ya19zeW5jKCZwb3J0LT5idWYud29yayk7IC8vIENoZWNrIHJl
dHVybiB2YWx1ZSBvZiBjYW5jZWxfd29ya19zeW5jDQo+Pj4gICAgICAgICBwcl9lbWVyZygiV29y
ayBjYW5jZWxsZWQgaXMgMHgleCAlcFMgJWRcbiIsICh1bnNpZ25lZCBpbnQpJnBvcnQtPmJ1Zi53
b3JrLCAodm9pZCAqKV9SRVRfSVBfLCByZXQpOw0KPj4+ICAgICAgICAgcmV0dXJuIHJldDsNCj4+
PiB9DQo+Pj4NCj4+PiBzdGF0aWMgdm9pZCBmbHVzaF90b19sZGlzYyhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspDQo+Pj4gew0KPj4+IC4uLg0KPj4+ICAgICAgICAgbWRlbGF5KDEwMCk7ICAgLy8g
QWRkZWQgRGVsYXkgdG8gcmVwcm9kdWNlIHJhY2UNCj4+Pg0KPj4+ICAgICAgICAgaWYgKGZsYWdf
d29ya19jYW5jZWwpIHsNCj4+PiAgICAgICAgICAgICAgICAgcHJfZW1lcmcoInNjaGVkdWxlZCB3
b3JrIGFmdGVyIHN0b3BwaW5nIHdvcmsgJXhcbiIsICh1bnNpZ25lZCBpbnQpd29yayk7DQo+Pj4N
Cj4+PiAuLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4gc3RhdGljIHZvaWQgcHR5X2NsZWFudXAoc3RydWN0
IHR0eV9zdHJ1Y3QgKnR0eSkNCj4+PiB7DQo+Pj4gLi4uDQo+Pj4gICAgICAgICBmbGFnX3dvcmtf
Y2FuY2VsID0gMTsNCj4+PiAgICAgICAgICAgICAgICAgLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4NCj4+
PiBbMTQwMy40MTU4XVdvcmsgY2FuY2VsbGVkIGlzIGRiY2Q0YTg0IHR0eV9wb3J0X2Rlc3Ryb3kr
MHgxYy8weDZjICAwICAgICAgIC8vIFNpbmNlIHJldHVybiBpcyAwIHNvIG5vIHdvcmsgaXMgcGVu
ZGluZw0KPj4+DQo+Pj4gWzE0MDMuNTEyOV0gc2NoZWR1bGVkIHdvcmsgYWZ0ZXIgc3RvcHBpbmcg
d29yayBkYmNkNGE4NCAgICAvLyBTdGlsbCBzYW1lIHdvcmsgaXMgc2NoZWR1bGVkIGFmdGVyIGNh
bmNlbGxlZA0KPj4+IFsxNDAzLjUxMzBdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyBy
ZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyA2YjZiNmI4MyAgIC8vIEtlcm5lbCBPT1BzIG9jY3Vy
ZWQgYmVjYXVzZSBvZiB1c2UgYWZ0ZXIgZnJlZQ0KPj4gT2ssIGFmdGVyIG15IGluaXRpYWwgInVz
ZSBhIG5ld2VyIGtlcm5lbCIgY29tbWVudCwgdGhpcyByZWFsbHkgZG9lcyBsb29rDQo+PiBzdHJh
bmdlLiAgVGhlcmUgaGFzIGFsc28gYmVlbiBhIGxvdCBvZiB3b3JrcXVldWUgZml4ZXMgYW5kIHJl
d29yayBzaW5jZQ0KPj4gNC4xLCBhbmQgdGhhdCBtaWdodCBiZSB0aGUgdGhpbmcgdGhhdCBmaXhl
cyB0aGlzIGlzc3VlIGhlcmUuDQo+Pg0KPj4gSG93ZXZlciwgYXJlIHlvdSBzdXJlIHlvdSBhcmUg
bm90IGp1c3QgY2FsbGluZyBmbHVzaF90b19sZGlzYygpIGRpcmVjdGx5DQo+PiB0aHJvdWdoIHNv
bWUgY29kZXBhdGggc29tZWhvdz8gIElmIHlvdSBsb29rIGF0IHRoZSBzdGFjayBpbiB0aGUNCj4g
WWVzLCB0aGVyZSBpcyBubyBjYWxsIHBhdGggZm9yIGZsdXNoX3RvX2Rpc2MgZGlyZWN0bHkuIEl0
IGlzIGFsbCBhbGlnbmVkIHdpdGgga2VybmVsIDQuMS4NCj4NCj4NCj4+IHByX2VtZXJnKCkgbWVz
c2FnZSwgd2hlcmUgZGlkIGl0IGNvbWUgZnJvbT8gIEZyb20gdGhlIHNhbWUgd29ya3F1ZXVlDQo+
PiB0aGF0IHlvdSBhbHJlYWR5IHN0b3BwZWQ/DQo+IFdlIGFkZGVkIGRlYnVnIHByaW50cyB0byBj
aGVjayAid29yayIgaW4gcHR5X2NsZWFudXAoKSAmIGZsdXNoX3RvX2xkaXNjDQo+DQo+PiBUZXN0
aW5nIG9uIGEgbmV3ZXIga2VybmVsIHdvdWxkIGJlIGdyZWF0LCBpZiBwb3NzaWJsZS4NCj4gV2Ug
YXJlIGZhY2luZyBpdCBoYXJkLCBidXQgY3VycmVudGx5IHdlIGhhdmUgNC4xIGFuZCBhYmxlIHRv
IHJlcHJvZHVjZSBvbiB0aGF0Lg0KPiBOb3QgcmVhbGx5IHBvc3NpYmxlIHRvIGhhdmUgdGhlIGxh
dGVzdCBrZXJuZWwgb24gdGhlIHNhbWUgdGFyZ2V0IGFuZCBtYXkgYmUgcmVwcm9kdWNlIHRoZSBz
YW1lIHJhY2UuDQo+IFRyaWVkIHRvIHRyYWNrIGZvciBjaGFuZ2VzIGluIHRoZSBvdGhlciBzdGFi
bGUgYnJhbmNoZXMsIGJ1dCBubyBjaGFuZ2UgbG9va3MgcmVhbGx5IHJlbGV2YW50IGZvciB0aGlz
IHJhY2UuDQo+IEkgbWlnaHQgYmUgd3JvbmcsIHBsZWFzZSBoZWxwIGlmIHRoZXJlIGlzIGFueSBj
b21taXQgcmVsYXRlZCB3aXRoIHRoaXMuDQpQbGVhc2UgZmluZCAmIHJldmlldyB0aGUgYXR0YWNo
ZWQgcGF0Y2ggZm9yIHRoaXMgaXNzdWUuDQoNCkkgdGhpbmsgdGhlIHR0eSB3aGljaCBjYWxsZWQg
cHR5X2NsZWFudXAgbWF5IGJlIGRpZmZlcmVudCBmcm9tIHRoZSB0dHkNCndoaWNoIGNhbGxlZCBm
bHVzaF90b19sZGlzYy4NClBsZWFzZSBjaGVjayBpZiB0aG9zZSB0d28gYXJlIHNhbWUgb3IgZGlm
ZmVyZW50LiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYQ0Kd29ya3F1ZXVlIHByb2JsZW0uDQpUaGFu
a3MuDQoNCkJlc3QgUmVnYXJkcywNClNhaGFyYQ0KDQo+DQo+PiB0aGFua3MsDQo+Pg0KPj4gZ3Jl
ZyBrLWgNCj4gT3VyIGluaXRpYWwgZGVidWdnaW5nIGRpcmVjdGlvbiB3YXMgd2l0aCAidHR5IiBi
dXQgbG9va3Mgc29tZSBpc3N1ZSBpbiB3b3JrcXVldWUuDQo+IEFsc28sIHRoZSBtb3N0IHN1cnBy
aXNpbmcgbG9va3MgdG8gYmUgdGhlIENBTkNFTCBhbmQgRkxVU0ggdG8gYmUgb2NjdXJpbmcgb24g
dGhlIHNhbWUgQ09SRSBpbiBzZXF1ZW5jZS4NCj4gU28sIGlmIHRoZSBDQU5DRUwgcmVhbGx5IHdv
cmtlZCBob3cgY2FuIHRoZSBmbHVzaF90b19sZGlzYyBiZSBzY2hlZHVsZWQuDQo+DQo+IFRoYW5r
cywNCj4gTWFuaW5kZXIgU2luZ2gNCj4NCg0KDQoNCktldW4tTyBQYXJrIHwgUHJpbmNpcGFsIFNv
ZnR3YXJlIEVuZ2luZWVyDQpUZWw6ICs5NzEgMiA0MTcgMTQxNyB8IE1vYjogKzk3MSA1NSAyNjAg
NzM0Mw0KS2V1bi1PLlBhcmtAZGFya21hdHRlci5hZQ0KDQpUaGUgaW5mb3JtYXRpb24gdHJhbnNt
aXR0ZWQsIGluY2x1ZGluZyBhdHRhY2htZW50cywgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBl
cnNvbihzKSBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkIGFuZCBtYXkgY29udGFp
biBjb25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgbWF0ZXJpYWwuIEFueSByZXZpZXcsIHJl
dHJhbnNtaXNzaW9uLCBkaXNzZW1pbmF0aW9uIG9yIG90aGVyIHVzZSBvZiwgb3IgdGFraW5nIG9m
IGFueSBhY3Rpb24gaW4gcmVsaWFuY2UgdXBvbiB0aGlzIGluZm9ybWF0aW9uIGJ5IHBlcnNvbnMg
b3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHByb2hpYml0
ZWQuIElmIHlvdSByZWNlaXZlZCB0aGlzIGluIGVycm9yLCBwbGVhc2UgY29udGFjdCB0aGUgc2Vu
ZGVyIGFuZCBkZXN0cm95IGFueSBjb3BpZXMgb2YgdGhpcyBpbmZvcm1hdGlvbi4NCg0KDQoNCg0K
DQoNCg0KDQo=

--_002_7668b2ad75e044d38b17f6ce32845dfbdarkmatterae_
Content-Type: text/x-patch;
	name="0001-tty-pty-Fix-race-condition-between-release_one_tty-a.patch"
Content-Description: 0001-tty-pty-Fix-race-condition-between-release_one_tty-a.patch
Content-Disposition: attachment;
	filename="0001-tty-pty-Fix-race-condition-between-release_one_tty-a.patch";
	size=2171; creation-date="Sun, 03 Feb 2019 05:54:51 GMT";
	modification-date="Sun, 03 Feb 2019 05:54:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzYTY1ZWMwMWY4ODQ5YzNlMTEyNjc3OTRiOWQxYzcwZWYzMmQxM2UzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWhhcmEgPGtldW4tby5wYXJrQGRhcmttYXR0ZXIuYWU+CkRh
dGU6IFN1biwgMyBGZWIgMjAxOSAwOToyNzoyOCArMDQwMApTdWJqZWN0OiBbUEFUQ0hdIHR0eTog
cHR5OiBGaXggcmFjZSBjb25kaXRpb24gYmV0d2VlbiByZWxlYXNlX29uZV90dHkgYW5kCiBwdHlf
d3JpdGUKCkVzcGVjaWFsbHkgd2hlbiBhIGxpbmtlZCB0dHkgaXMgdXNlZCBzdWNoIGFzIHB0eSwg
dGhlIGxpbmtlZCB0dHkKcG9ydCdzIGJ1ZiB3b3JrcyBoYXZlIG5vdCBiZWVuIGNhbmNlbGxlZCB3
aGlsZSBtYXN0ZXIgdHR5IHBvcnQncwpidWYgd29yayBoYXMgYmVlbiBjYW5jZWxsZWQuIFNpbmNl
IHJlbGVhc2Vfb25lX3R0eSBhbmQgZmx1c2hfdG9fbGRpc2MKcnVuIGluIHdvcmtxdWV1ZSB0aHJl
YWRzIHNlcGFyYXRlbHksIHdoZW4gcHR5X2NsZWFudXAgaGFwcGVucyBhbmQKbGluayB0dHkgcG9y
dCBpcyBmcmVlZCwgZmx1c2hfdG9fbGRpc2MgdHJpZXMgdG8gYWNjZXNzIGZyZWVkIHBvcnQKYW5k
IHBvcnQtPml0dHksIGV2ZW50dWFsbHkgaXQgY2F1c2VzIGEgcGFuaWMuClRoaXMgcGF0Y2ggdXRp
bGl6ZXMgdGhlIG1hZ2ljIHZhbHVlIHdpdGggaG9sZGluZyB0aGUgdHR5X211dGV4IHRvCmNoZWNr
IGlmIHRoZSB0dHktPmxpbmsgaXMgdmFsaWQuCgpGaXhlczogMmIwMjJhYjc1NDJkICgicHR5OiBj
YW5jZWwgcHR5IHNsYXZlIHBvcnQgYnVmJ3Mgd29yayBpbiB0dHlfcmVsZWFzZSIpClNpZ25lZC1v
ZmYtYnk6IFNhaGFyYSA8a2V1bi1vLnBhcmtAZGFya21hdHRlci5hZT4KLS0tCiBkcml2ZXJzL3R0
eS9wdHkuYyAgICB8IDcgKysrKysrKwogZHJpdmVycy90dHkvdHR5X2lvLmMgfCAzICsrKwogMiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkv
cHR5LmMgYi9kcml2ZXJzL3R0eS9wdHkuYwppbmRleCAwMDA5OWE4NC4uZWY3MjAzMSAxMDA2NDQK
LS0tIGEvZHJpdmVycy90dHkvcHR5LmMKKysrIGIvZHJpdmVycy90dHkvcHR5LmMKQEAgLTExNiw2
ICsxMTYsMTIgQEAgc3RhdGljIGludCBwdHlfd3JpdGUoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwg
Y29uc3QgdW5zaWduZWQgY2hhciAqYnVmLCBpbnQgYykKIAlpZiAodHR5LT5zdG9wcGVkKQogCQly
ZXR1cm4gMDsKIAorCW11dGV4X2xvY2soJnR0eV9tdXRleCk7CisJaWYgKHRvLT5tYWdpYyAhPSBU
VFlfTUFHSUMpIHsKKwkJbXV0ZXhfdW5sb2NrKCZ0dHlfbXV0ZXgpOworCQlyZXR1cm4gLUVJTzsK
Kwl9CisKIAlpZiAoYyA+IDApIHsKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJnRvLT5wb3J0LT5sb2Nr
LCBmbGFncyk7CiAJCS8qIFN0dWZmIHRoZSBkYXRhIGludG8gdGhlIGlucHV0IHF1ZXVlIG9mIHRo
ZSBvdGhlciBlbmQgKi8KQEAgLTEyNSw2ICsxMzEsNyBAQCBzdGF0aWMgaW50IHB0eV93cml0ZShz
dHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBjb25zdCB1bnNpZ25lZCBjaGFyICpidWYsIGludCBjKQog
CQkJdHR5X2ZsaXBfYnVmZmVyX3B1c2godG8tPnBvcnQpOwogCQlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ0by0+cG9ydC0+bG9jaywgZmxhZ3MpOwogCX0KKwltdXRleF91bmxvY2soJnR0eV9tdXRl
eCk7CiAJcmV0dXJuIGM7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3R0eV9pby5jIGIv
ZHJpdmVycy90dHkvdHR5X2lvLmMKaW5kZXggMjNjNmZkMi4uNmM0YTIwNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvdHR5X2lvLmMKKysrIGIvZHJpdmVycy90dHkvdHR5X2lvLmMKQEAgLTE0NDYs
MTAgKzE0NDYsMTMgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9vbmVfdHR5KHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKIAlzdHJ1Y3QgdHR5X2RyaXZlciAqZHJpdmVyID0gdHR5LT5kcml2ZXI7CiAJ
c3RydWN0IG1vZHVsZSAqb3duZXIgPSBkcml2ZXItPm93bmVyOwogCisJbXV0ZXhfbG9jaygmdHR5
X211dGV4KTsKIAlpZiAodHR5LT5vcHMtPmNsZWFudXApCiAJCXR0eS0+b3BzLT5jbGVhbnVwKHR0
eSk7CiAKIAl0dHktPm1hZ2ljID0gMDsKKwltdXRleF91bmxvY2soJnR0eV9tdXRleCk7CisKIAl0
dHlfZHJpdmVyX2tyZWZfcHV0KGRyaXZlcik7CiAJbW9kdWxlX3B1dChvd25lcik7CiAKLS0gCjIu
Ny40Cgo=

--_002_7668b2ad75e044d38b17f6ce32845dfbdarkmatterae_--
