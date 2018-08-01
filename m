Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB28C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D0D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D0D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbeHAPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:13:19 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:51117 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbeHAPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:13:19 -0400
Received: from [192.168.20.11] (port=61607 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fkr9u-0000rB-1u; Wed, 01 Aug 2018 15:27:22 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 1 Aug
 2018 15:27:22 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Wed, 1 Aug 2018 15:27:22 +0200
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
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAovJrxAAAgVdAAAeBGhv//4AKA//++9KA=
Date:   Wed, 1 Aug 2018 13:27:22 +0000
Message-ID: <1ae1b19241734bfaacff082d241932f9@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
 <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
 <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
 <7feb4b8950b842469265672f4c7b381d@ZCOM03.mut-group.com>
In-Reply-To: <7feb4b8950b842469265672f4c7b381d@ZCOM03.mut-group.com>
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

PkFub3RoZXIgd2F5IHRvIHNwb3QgdGhlIHByb2JsZW0gd291bGQgYmUgdG8gYWRkIGEgY2hlY2sg
aW4gDQo+cHNrYl9leHBhbmRfaGVhZCgpDQo+DQoNCk1hbnkgdGhhbmtzIGZvciB0aGlzIGFkdmlj
ZS4gSW5kZWVkLCBieSBiYWNrcG9ydGluZyB0aGUgcHNrYl9leHBhbmRfaGVhZCAoYW5kIGJ1aWxk
X3NrYiBiZWNhdXNlIGl0IGRpZG4ndCBleGlzdCkgZnJvbSB0aGUgdmVyc2lvbiAzLjUuNyB0byAz
LjQuMTEzIGZpeGVzICg/KSB0aGUgaXNzdWUgZm9yIG5vdy4gV2Ugd2FudCB0byB0ZXN0IDMgb3Ig
NCBtYWNoaW5lcyBvdmVyIG5pZ2h0IGFuZCBzZWUgaWYgYW55IHByb2JsZW0gb2NjdXJzLiANCg0K
TGV0J3Mgc2VlIGlmIHdlIGNhbiBkbyB0aGUgc2FtZSBmb3Igb3VyIDIuNi4zOS4yIGtlcm5lbCAo
SSBndWVzcyB0aGF0IHdpbGwgYmUgcHVyZSBwYWluIPCfmIMgKS4NCg0KTWFueSB0aGFua3Mgc28g
ZmFyIGZvciB5b3VyIHN1cHBvcnQhIEkgd2lsbCByZXBvcnQgdG9tb3Jyb3cgKENFU1QpIGlmIHdl
IHN1Y2NlZWRlZC4NCg0KDQpNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8gV2l0aCBraW5kIHJl
Z2FyZHMNCg0KTWFyY2VsIEhlbGx3aWcNCkIuIFNjLiBJbmZvcm1hdGlrDQpFbnR3aWNrbGVyDQoN
Cm0tdS10wqBHbWJIDQpBbSBNYXJpZW5ob2YgMg0KMjI4ODAgV2VkZWwNCkdlcm1hbnkNCg0KUGhv
bmU6CSs0OSA0MTAzIDkzMDggLSA0NzQNCkZheDrCoMKgCSs0OSA0MTAzIDkzMDggLSA5OQ0KbWhl
bGx3aWdAbXV0LWdyb3VwLmNvbQ0KDQp3d3cubXV0LWdyb3VwLmNvbQ0KDQpHZXNjaMOkZnRzZsO8
aHJlcsKgKE1hbmFnaW5nIERpcmVjdG9yKTogRmFiaWFuIFBldGVycyBBbXRzZ2VyaWNodCBQaW5u
ZWJlcmcgKENvbW1lcmNpYWwgUmVnaXN0ZXIgTm8uKTogSFJCwqAxMDMwNCBQSSBVU3QtSWROci4g
KFZBVC1Oby4pOiBERTIyODI3NTM5MA0KV0VFRS1SZWctTnIuOiBERSA3MjI3MTgwOA0KDQoNCg==
