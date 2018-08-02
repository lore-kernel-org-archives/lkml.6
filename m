Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB69C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E492151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E492151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeHBPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:48:51 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:34326 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:48:51 -0400
Received: from [192.168.20.11] (port=42440 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1flE6R-0008JY-1k; Thu, 02 Aug 2018 15:57:19 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 2 Aug
 2018 15:57:19 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Thu, 2 Aug 2018 15:57:19 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AQHUKmKKylxOxyzCQIq96qKkvZ0yzqSseIWA
Date:   Thu, 2 Aug 2018 13:57:19 +0000
Message-ID: <18341daf5b2c458db8e30299d6cddafc@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
 <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
In-Reply-To: <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
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

Pj4gVGhlcmUgYXJlIGFjdHVhbGx5IDIgZmF1bHRzLCBkaWZmaWN1bHQgdG8gcXVpY2tseSBzb3J0
IG91dCB0aGUgbWVyZ2VkIHRyYWNlYmFja3MuDQo+PiBZb3UgYXJlIGFsc28gcnVubmluZyBhIHJh
dGhlciBvbGQga2VybmVsOiBMaW51eCB2ZXJzaW9uIDMuNC4xMTMuDQo+PiANCj4+IEl0IG1heSB3
ZWxsIGJlIHRoYXQgd2hpY2hldmVyIGV0aGVybmV0IGRyaXZlciBnZW5lcmF0ZWQgdGhlIG1pc2Fs
aWduZWQgDQo+PiBmcmFtZSBoYXMgc2luY2UgYmVlbiBmaXhlZC4NCj4NCj5BIG1pc2FsaWduIGZy
YW1lIGRyaXZlciBwcm9ibGVtIHdvdWxkIGhhdmUgZmF1bHRlZCBlYXJsaWVyIGluIElQIHN0YWNr
LCBtdWNoIGJlZm9yZSB3ZSBwZXJmb3JtIHRoZSBjb3B5IHRvIHVzZXIgc3BhY2UgaW4gdWRwX3Jl
Y3Ztc2coKQ0KPg0KDQpKRllJOiB3ZSBhcmUgdGFsa2luZyBhYm91dCB0aGUgbHBjX2V0aCBkcml2
ZXJbMF0gIzU3YzEwYjYgLCB3aGljaCBpcyBub3QgdGhlIG5ld2VzdCwgYnV0IGFsbCBuZXdlciBk
aWQgbm90IGZpeCBhIG1ham9yIHByb2JsZW0gKGF0IGxlYXN0IHRoZSBjb21taXQgbWVzc2FnZXMg
YXJlIG5vdCBzY3JlYW1pbmc6IFdBUk5JTkcsIFVOQUxJR05FRCBNRU1PUlkhKS4gSXMgdGhlcmUg
YSBkaWFncmFtL2RvY3VtZW50IGhvdyBhIGlwIHBhY2tldCB0cmF2ZWxzIGRvd24gdGhlIGNvZGU/
IEZyb20gdGhlIE1BQy9waHkgZHJpdmVyIHRvIHVkcF9yZWN2bXNnPyBJdCdzIG5vdCB0aGF0IG9i
dmlvdXMgZm9yIG1lLCBidXQgbWF5YmUgaXQgaXMgc29tZXRoaW5nIEkgY2FuIHdvcmsgd2l0aC4N
Cg0KDQpbMF06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3YzLjQuMTEzL3NvdXJj
ZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9ueHAvbHBjX2V0aC5jDQoNClJlZ2FyZHMsDQpNYXJjZWwN
Cg==
