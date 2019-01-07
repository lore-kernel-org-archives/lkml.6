Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCF12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfAGDyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:54:53 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44451 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfAGDyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:54:53 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x073s1L9006272, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x073s1L9006272
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 7 Jan 2019 11:54:01 +0800
Received: from RTITEXH01.realtek.com.tw (172.21.6.62) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 7 Jan 2019 11:54:01 +0800
Received: from RTITMBSVM03.realtek.com.tw ([fe80::e1fe:b2c1:57ec:f8e1]) by
 RTITEXH01.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Mon, 7 Jan 2019
 11:53:59 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Mark Lord <mlord@pobox.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
CC:     Ansis Atteka <aatteka@nicira.com>,
        David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Ryankao <ryankao@realtek.com>
Subject: RE: r8152: data corruption in various scenarios
Thread-Topic: r8152: data corruption in various scenarios
Thread-Index: AQHUpQD6011CtINiskOD0W/vTF7lIKWiF+GAgAAhRICAAAD+AIAA8qXQ
Date:   Mon, 7 Jan 2019 03:53:59 +0000
Message-ID: <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
In-Reply-To: <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.214]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9uZGF5LCBKYW51YXJ5IDA3LCAyMDE5IDU6MTcgQU0NClsuLi5dDQo+PiBUaGlzIGlzIHByb2Jh
Ymx5IGFuIHhIQyBidWcuIEEgc2ltaWxhciBpc3N1ZSBpcyBmaXhlZCBieSBjb21taXQgOWRhNWEx
MDkyYjEzDQo+PiAoInhoY2k6IEJhZCBFdGhlcm5ldCBwZXJmb3JtYW5jZSBwbHVnZ2VkIGluIEFT
TTEwNDJBIGhvc3TigJ0pLiANCj4+DQo+Pj4gSSBqdXN0IGdvdCB0aGF0IGV4YWN0IG1lc3NhZ2Ug
YWJvdmUsIHdpdGggdGhlIHI4MTUyIGluIG15IDEtZGF5IG9sZCBXRDE1IGRvY2ssDQo+Pj4gd2l0
aCB0aGUgVEIxNiAid29ya2Fyb3VuZCIgZW5hYmxlZCBpbiBMaW51eCBrZXJuZWwgNC4yMC4wLg0K
Pj4NCj4+IElzIHRoZSB4SEMgV0QxNSBjb25uZWN0ZWQgYW4gQVNNZWRpYSBvbmU/DQo+IA0KPiBJ
IGRvbid0IGtub3cuICBJICp0aGluayogaXQgaWRlbnRpZmllcyBhcyBhIERTTDYzNDAgKHNlZSBi
ZWxvdykuDQo+IA0KDQpBY2NvcmRpbmcgdG8gb3VyIHJlY29yZCwgaXQgaXMgcmVsYXRpdmUgdG8g
dGhlIGFzbWVkaWEuDQoNCkJlc3QgUmVnYXJkcywNCkhheWVzDQoNCg0K
