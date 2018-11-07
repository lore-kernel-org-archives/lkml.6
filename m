Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6156C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718F82086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718F82086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKHCH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:07:26 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:53404 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeKHCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:07:26 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 185AA1C75740;
        Wed,  7 Nov 2018 17:36:14 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 7 Nov 2018
 17:36:13 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Wed, 7 Nov 2018 17:36:13 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Olof Johansson <olof@lixom.net>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Eric Anholt <eric@anholt.net>, Stefan Agner <stefan@agner.ch>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "yannick.fertre@st.com" <yannick.fertre@st.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Thread-Topic: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Thread-Index: AQHUdqh4fJ7CTSTis0KZzqRTstzHg6VEbX+AgAAEaoA=
Date:   Wed, 7 Nov 2018 16:36:13 +0000
Message-ID: <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
In-Reply-To: <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3E8513E95EB0141883D08AD67B99E63@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 185AA1C75740.AD0DC
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: alexandre.torgue@st.com, arnd@arndb.de,
        boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, eric@anholt.net, fabio.estevam@nxp.com,
        frieder.schrempf@exceet.de, geert+renesas@glider.be, han.xu@nxp.com,
        horms+renesas@verge.net.au, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, olof@lixom.net,
        prabhakar.kushwaha@nxp.com, richard@nod.at, s.hauer@pengutronix.de,
        shawnguo@kernel.org, stefan.wahren@i2se.com, stefan@agner.ch,
        tony@atomide.com, yannick.fertre@st.com, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KT24gMDcuMTEuMTggMTc6MjAsIE9sb2YgSm9oYW5zc29uIHdyb3RlOg0KPiBP
biBXZWQsIE5vdiA3LCAyMDE4IGF0IDY6NDQgQU0gRnJpZWRlciBTY2hyZW1wZg0KPiA8ZnJpZWRl
ci5zY2hyZW1wZkBrb250cm9uLmRlPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJl
bXBmIDxmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZT4NCj4+DQo+PiBUaGUgbmV3IGRyaXZlciBh
dCBzcGkvc3BpLWZzbC1xc3BpLmMgcmVwbGFjZXMgdGhlIG9sZCBTUEkgTk9SIGRyaXZlcg0KPj4g
YXQgbXRkL2ZzbC1xdWFkc3BpLmMuIFN3aXRjaCB0byB0aGUgbmV3IGRyaXZlciBpbiB0aGUgZGVm
Y29uZmlncy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVy
LnNjaHJlbXBmQGV4Y2VldC5kZT4NCj4gDQo+IEhpIEZyaWVkZXIsDQo+IA0KPiBUaGlzIHBhdGNo
IGlzIHBhcnQgb2YgYSBzZXJpZXMgdGhhdCBJIGRpZG4ndCBzZWUgdGhlIHJlc3Qgb2YsIGJ1dCBp
bg0KPiBnZW5lcmFsIHdlIHByZWZlciB0byBtZXJnZSB0aGVzZSB0aHJvdWdoIGFybS1zb2MgZXZl
biBpZiB0aGUgZHJpdmVyDQo+IGdvZXMgaW4gdGhyb3VnaCBhbm90aGVyIHRyZWUuIFRoZSB3YXkg
d2UnZCBwcmVmZXIgdG8gaGFuZGxlIGl0IGlzIHRoYXQNCj4gb25jZSB0aGUgZHJpdmVyIGxhbmRz
LCB3ZSdsbCB0YWtlIHRoZSBjb25maWcgb3B0aW9uIGNoYW5nZSB0byB0dXJuIGl0DQo+IG9uLiBU
byBhdm9pZCBvdXIgYnJhbmNoZXMgdG8gYnJlYWsgdW50aWwgYm90aCBzaWRlcyBoYXZlIGxhbmRl
ZCwgaXQNCj4gbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8ga2VlcCBib3RoIGRyaXZlcnMgb24gZm9y
IGEgc2hvcnQgd2hpbGUgKG9uZQ0KPiByZWxlYXNlKS4NCj4gDQo+IFNvLCBJJ20gbm90IGdvaW5n
IHRvIGFjayB0aGlzIHNpbmNlIHdlIGF2b2lkIHRha2luZyBkZWZjb25maWcgY2hhbmdlcw0KPiB0
aHJvdWdoIGRyaXZlciB0cmVlcyAodGhlc2UgdHdvIGRlZmNvbmZpZ3MgdGVuZCB0byBjaHVybiBh
IGxvdCBhbmQgd2UNCj4gZG9uJ3Qgd2FudCB0byBjcmVhdGUgbWVyZ2UgY29uZmxpY3RzIHdoZXJl
IHdlIGRvbid0IGhhdmUgdG8pLCBidXQNCj4gd2UnbGwgYmUgaGFwcHkgdG8gcGljayBpdCB1cCB3
aGVuIHRoZSB0aW1lIGNvbWVzLg0KDQpPaywgdGhhbmsgeW91IGZvciBleHBsYWluaW5nIHRoZSBj
b21tb24gcHJhY3RpY2UuIEkgd2lsbCBkcm9wIHRoZSBjb25maWcgDQpjaGFuZ2VzIGZvciB0aGUg
bmV4dCB2ZXJzaW9uIGFuZCBzZW5kIGl0IHNlcGFyYXRlbHkgd2hlbiB0aGUgdGltZSBpcyByZWFk
eS4NCg0KQm90aCB0aGUgb2xkIGRyaXZlciBhbmQgdGhlIG5ldyBvbmUgdXNlIHRoZSBzYW1lIGNv
bXBhdGlibGUgc3RyaW5ncyBmb3IgDQpwcm9iaW5nLiBXb3VsZG4ndCB0aGF0IGNhdXNlIHByb2Js
ZW1zIGlmIGJvdGggZHJpdmVycyBhcmUgZW5hYmxlZCBmb3IgYSANCndoaWxlLCBvciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPw0KDQpUaGFua3MsDQpGcmllZGVyDQoNCj4gDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiAtT2xvZg0KPiA=
