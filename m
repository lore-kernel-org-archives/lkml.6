Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2515DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1B2214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1B2214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeHBMxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:53:30 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:44330 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbeHBMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:53:30 -0400
Received: from [192.168.20.11] (port=24073 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1flBNP-0003N2-2x; Thu, 02 Aug 2018 13:02:39 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 2 Aug
 2018 13:02:39 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Thu, 2 Aug 2018 13:02:39 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAovJrxAAAgVdAAAeBGhv//4AKA//++9KD//k2VMA==
Date:   Thu, 2 Aug 2018 11:02:39 +0000
Message-ID: <c54e9eee0add4f04b0ce61a1ae2c3f04@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
 <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
 <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
 <7feb4b8950b842469265672f4c7b381d@ZCOM03.mut-group.com>
 <1ae1b19241734bfaacff082d241932f9@ZCOM03.mut-group.com>
In-Reply-To: <1ae1b19241734bfaacff082d241932f9@ZCOM03.mut-group.com>
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

SGkgZXZlcnlvbmUsDQoNCkkgZGlkIHRocmVlIHRoaW5ncyB0aGF0IGV2ZW5pbmcuDQoqIEkgY3Jl
YXRlZCBhIHNtYWxsIGR0cyBmaWxlLCBzbyBJIGNvdWxkIGJvb3QgYSAzLjUuNyBrZXJuZWwuDQoq
IFBvcnRlZCB0aGUgcHNrYl9leHBhbmRfaGVhZCBmcm9tIDMuNS43IHRvIDMuNC4xMTMNCiogUG9y
dGVkIHRoZSB3aG9sZSBza2J1Zi57YyxofSBmaWxlIGZyb20gMy41LjcgdG8gMy40LjExMw0KDQpT
YWRseSBlbm91Z2ggdGhlIHNlY29uZCBhbmQgdGhpcmQgb25lIHBhbmlja2VkIGFzIHdlbGwsIGJ1
dCBpbnRlcmVzdGluZ2x5IG5vdCB0aGUgZmlyc3Qgb25lICgzLjUuNyB3aXRoIGEgc2ltcGxlIGR0
cyBmaWxlKS4gTm93IHRoZSBxdWVzdGlvbiBpczogSXMgc29tZXRoaW5nIGNoYW5nZWQgb3V0c2lk
ZSBvZiB0aGUgc2tidWYgKG1heWJlIGluIHVkcC57YyxofT8pIG9yIGlzIGl0IGJlY2F1c2UgdGhl
IGR0cyB1c2VzIGEgZGlmZmVyZW50IGFwcHJvYWNoIG9mIHRhbGtpbmcgdG8gdGhlIE1BQyBvZiB0
aGUgbHBjMzI1MD8NCg0KSSBtYXkgdHJ5IGEgbW9yZSByZWNlbnQga2VybmVsIHdpdGggYSBkdHMg
ZmlsZSAobWF5YmUgYSA0LngueCBvbmUpLCBidXQgSSB0aGluayB0aGF0IHdpbGwgYmUgaW1wb3Nz
aWJsZSB0byBiYWNrcG9ydCBhIHBhdGNoIGZvciBvdXIgMi42IGtlcm5lbCA6KA0KDQpJZiBhbnli
b2R5IGhhcyBhbnkgbW9yZSBpZGVhcyBhYm91dCB3aHkgdGhlIGR0cyBrZXJuZWwgZG9lcyBub3Qg
cGFuaWMsIHlvdSdyZSB2ZXJ5IHdlbGNvbWUuDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4g
LyBXaXRoIGtpbmQgcmVnYXJkcw0KDQpNYXJjZWwgSGVsbHdpZw0KQi4gU2MuIEluZm9ybWF0aWsN
CkVudHdpY2tsZXINCg0KbS11LXTCoEdtYkgNCkFtIE1hcmllbmhvZiAyDQoyMjg4MCBXZWRlbA0K
R2VybWFueQ0KDQpQaG9uZToJKzQ5IDQxMDMgOTMwOCAtIDQ3NA0KRmF4OsKgwqAJKzQ5IDQxMDMg
OTMwOCAtIDk5DQptaGVsbHdpZ0BtdXQtZ3JvdXAuY29tDQoNCnd3dy5tdXQtZ3JvdXAuY29tDQoN
Ckdlc2Now6RmdHNmw7xocmVywqAoTWFuYWdpbmcgRGlyZWN0b3IpOiBGYWJpYW4gUGV0ZXJzDQpB
bXRzZ2VyaWNodCBQaW5uZWJlcmcgKENvbW1lcmNpYWwgUmVnaXN0ZXIgTm8uKTogSFJCwqAxMDMw
NCBQSQ0KVVN0LUlkTnIuIChWQVQtTm8uKTogREUyMjgyNzUzOTANCldFRUUtUmVnLU5yLjogREUg
NzIyNzE4MDgNCg0KDQo=
