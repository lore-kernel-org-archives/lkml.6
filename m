Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60982C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLGKWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:22:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9639 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbeLGKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:22:33 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB7AG82o004599;
        Fri, 7 Dec 2018 11:21:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3w2s9gm8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Dec 2018 11:21:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F78C31;
        Fri,  7 Dec 2018 10:21:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E94F829C7;
        Fri,  7 Dec 2018 10:21:36 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Dec
 2018 11:21:38 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 7 Dec 2018 11:21:38 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe KERELLO <christophe.kerello@st.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        =?utf-8?B?TWlxdcOobCBSYXluYWw=?= <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [Linux-stm32] [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2
 NAND flash controller driver
Thread-Topic: [Linux-stm32] [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2
 NAND flash controller driver
Thread-Index: AQHUjgwhtEvU4O+eEki5+vhblXR4DaVzAGgA
Date:   Fri, 7 Dec 2018 10:21:38 +0000
Message-ID: <dafcda21-fceb-1577-7f1c-41f1009b99a7@st.com>
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
 <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com>
In-Reply-To: <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <078A5EA132870140BCEA3C0D522F978E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi83LzE4IDEwOjA2IEFNLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBIaSBDaHJpc3Rv
cGhlLA0KPg0KPiBPbiBUaHUsIE5vdiAyOSwgMjAxOCBhdCA1OjQyIFBNIENocmlzdG9waGUgS2Vy
ZWxsbw0KPiA8Y2hyaXN0b3BoZS5rZXJlbGxvQHN0LmNvbT4gd3JvdGU6DQo+DQo+PiArLyogRk1D
MiBDb250cm9sbGVyIFJlZ2lzdGVycyAqLw0KPj4gKyNkZWZpbmUgRk1DMl9CQ1IxICAgICAgICAg
ICAgICAgICAgICAgIDB4MA0KPj4gKyNkZWZpbmUgRk1DMl9QQ1IgICAgICAgICAgICAgICAgICAg
ICAgIDB4ODANCj4gKC4uLikNCj4+ICsvKiBSZWdpc3RlcjogRk1DMl9CQ1IxICovDQo+PiArI2Rl
ZmluZSBGTUMyX0JDUjFfRk1DMkVOICAgICAgICAgICAgICAgQklUKDMxKQ0KPiBXZWxsIHRoaXMg
bG9va3MgbGlrZSBhbiBlc3BlY2lhbGx5IGNsZXZlciByZWdpc3RlciBtYXAgYW5kIGEgc3BlY2lm
aWMgY2hvaWNlDQo+IG9mIGJpdCAzMSBpbiB0aGUgZmlzdCByZWdpc3RlciB0byBhY3RpdmF0ZSBG
TUMyLiBSZWdpc3RlcnMgMHgwNCB0aHJ1DQo+IDB4N2MgYXJlIGNvbXBsZXRlbHkgdW51c2VkIHNh
dmUgZm9yIG9uZSBiaXQuDQo+DQo+IEl0J3MgYWxtb3N0IGxpa2UgdGhpcyBpcyB0aGUgZ29vZCBv
bGQgRlNNQyBpbnRlZ3JhdGVkIGluIHBhcmFsbGVsIHdpdGggRk1DMiwNCj4gc28gdGhhdCBpZiB5
b3UgZG9uJ3Qgc2V0IGJpdCAzMSwgdGhpcyBiZWNvbWVzIHNvbWV0aGluZyB0aGF0IGNhbiBiZSB1
c2VkDQo+IHdpdGggZHJpdmVycy9tdGQvbmFuZC9yYXcvZnNtY19uYW5kLmMsIGFuZCBGTUMyIG1v
ZGUgaXMgYWN0aXZhdGVkDQo+IGJ5IHNldHRpbmcgdGhpcyBiaXQsIGFjdGl2YXRpbmcgYWxsIHRo
ZSBuZXcgcmVnaXN0ZXJzLg0KPg0KPiBJdCB3b3VsZG4ndCBzdXJwcmlzZSBtZSBnaXZlbiBob3cg
SFcgZGVzaWduZXJzIGxpa2UgdG8gd29yay4NCj4NCj4gSXMgdGhpcyB0aGUgY2FzZT8NCg0KTm8s
IGl0IGlzIHRoZSBzYW1lIHN0b3J5IHRoYW4gZm9yIHN0bWZ4IGRyaXZlciwgaXQgbG9va3MgdG8g
YmUgdGhlIHNhbWUgDQpmcm9tIHJlZ2lzdGVycw0KDQpwb2ludCBvZiB2aWV3IGJ1dCBpbnRlcm5h
bCBoYXJkd2FyZSBibG9jayBkZXNpZ24gaXMgY29tcGxldGVseSBkaWZmZXJlbnQuDQoNCj4NCj4g
SWYgdGhhdCBpcyB0aGUgY2FzZSBJIHRoaW5rIGl0IHNob3VsZCBhdCBsZWFzdCBiZSBtZW50aW9u
ZWQgaW4gY29tbWl0DQo+IGxvZ3MgYW5kIERUIGJpbmRpbmdzIGFuZCBwb3NzaWJseSBpbiBhIGNv
bW1lbnQgb24gdGhlIGRyaXZlcg0KPiBpdHNlbGYuDQo+DQo+IFlvdXJzLA0KPiBMaW51cyBXYWxs
ZWlqDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IExpbnV4LXN0bTMyIG1haWxpbmcgbGlzdA0KPiBMaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0
b3JtcmVwbHkuY29tDQo+IGh0dHBzOi8vc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbS9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXN0bTMy
