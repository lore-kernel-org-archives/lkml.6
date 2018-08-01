Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C07EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97D420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97D420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeHANQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:16:26 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:59952 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbeHANQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:16:26 -0400
Received: from [192.168.20.11] (port=49130 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fkpLJ-0005wK-2Y; Wed, 01 Aug 2018 13:31:01 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 1 Aug
 2018 13:31:01 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Wed, 1 Aug 2018 13:31:01 +0200
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
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAqvTNOAAAfmqA=
Date:   Wed, 1 Aug 2018 11:31:01 +0000
Message-ID: <7feb4b8950b842469265672f4c7b381d@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
 <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
 <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
In-Reply-To: <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
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

PiBJIHN1c3BlY3QgdGhlIGZvbGxvd2luZyBwYXRjaCBteSBuZWVkIHRvIGJlIGJhY2twb3J0ZWQs
IHBsZWFzZSBNYXJjZWwgZ2l0IGl0IGEgdHJ5Lg0KPg0KDQpUaGUgcGF0Y2ggaXMgYWxyZWFkeSBp
biAzLjQuMTEzIHdoaWNoIHN0aWxsIGhhcyB0aGUgcHJvYmxlbSAodGhhdCB2ZXJzaW9uIGlzIGZy
b20gT2N0b2JlciAyMDE2LCBzbyBub3QgdGhhdCBhbmNpZW50LCBidXQgb2xkIPCfmIogKQ0KDQo+
QW5vdGhlciB3YXkgdG8gc3BvdCB0aGUgcHJvYmxlbSB3b3VsZCBiZSB0byBhZGQgYSBjaGVjayBp
biBwc2tiX2V4cGFuZF9oZWFkKCkNCj4NCg0KSSdsbCB0cnkgdGhhdC4gTW9yZSBzdWdnZXN0aW9u
cyBhcmUgd2VsY29tZS4NCg0KVGhhbmtzIGZvciB5b3VyIGVuZ2FnZW1lbnQhDQoNCg0KTWl0IGZy
ZXVuZGxpY2hlbiBHcsO8w59lbiAvIFdpdGgga2luZCByZWdhcmRzDQoNCk1hcmNlbCBIZWxsd2ln
DQpCLiBTYy4gSW5mb3JtYXRpaw0KRW50d2lja2xlcg0KDQptLXUtdMKgR21iSA0KQW0gTWFyaWVu
aG9mIDINCjIyODgwIFdlZGVsDQpHZXJtYW55DQoNClBob25lOgkrNDkgNDEwMyA5MzA4IC0gNDc0
DQpGYXg6wqDCoAkrNDkgNDEwMyA5MzA4IC0gOTkNCm1oZWxsd2lnQG11dC1ncm91cC5jb20NCg0K
d3d3Lm11dC1ncm91cC5jb20NCg0KR2VzY2jDpGZ0c2bDvGhyZXLCoChNYW5hZ2luZyBEaXJlY3Rv
cik6IEZhYmlhbiBQZXRlcnMNCkFtdHNnZXJpY2h0IFBpbm5lYmVyZyAoQ29tbWVyY2lhbCBSZWdp
c3RlciBOby4pOiBIUkLCoDEwMzA0IFBJDQpVU3QtSWROci4gKFZBVC1Oby4pOiBERTIyODI3NTM5
MA0KV0VFRS1SZWctTnIuOiBERSA3MjI3MTgwOA0KDQoNCg==
