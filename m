Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4674BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA122419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeKLVRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:17:21 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:52090 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeKLVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:17:20 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id D77F52C78683;
        Mon, 12 Nov 2018 12:24:22 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 12 Nov
 2018 12:24:22 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Mon, 12 Nov 2018 12:24:22 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Olof Johansson <olof@lixom.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
Thread-Index: AQHUdqh4fJ7CTSTis0KZzqRTstzHg6VEbX+AgAAEaoCAAQvXgIAGbi2AgAACtwCAAAfLgA==
Date:   Mon, 12 Nov 2018 11:24:22 +0000
Message-ID: <7c379ee9-a9e7-e0a5-14a5-9074d6a964e7@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
 <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
 <20181108093451.08dfe63e@bbrezillon>
 <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
 <20181112115628.68a84b92@bbrezillon>
In-Reply-To: <20181112115628.68a84b92@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <A38A91B4A7427142ACB8A24A9DCCAE0F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D77F52C78683.AB857
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

T24gMTIuMTEuMTggMTE6NTYsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gTW9uLCAxMiBO
b3YgMjAxOCAxMDo0Njo0NSArMDAwMA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uRGU+IHdyb3RlOg0KPiANCj4+IE9uIDA4LjExLjE4IDA5OjM0LCBCb3JpcyBC
cmV6aWxsb24gd3JvdGU6DQo+Pj4gT24gV2VkLCA3IE5vdiAyMDE4IDE2OjM2OjEzICswMDAwDQo+
Pj4gU2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLkRlPiB3cm90ZToN
Cj4+PiAgICANCj4+Pj4gSGkgT2xvZiwNCj4+Pj4NCj4+Pj4gT24gMDcuMTEuMTggMTc6MjAsIE9s
b2YgSm9oYW5zc29uIHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBOb3YgNywgMjAxOCBhdCA2OjQ0IEFN
IEZyaWVkZXIgU2NocmVtcGYNCj4+Pj4+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+IHdy
b3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hy
ZW1wZkBleGNlZXQuZGU+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgbmV3IGRyaXZlciBhdCBzcGkvc3Bp
LWZzbC1xc3BpLmMgcmVwbGFjZXMgdGhlIG9sZCBTUEkgTk9SIGRyaXZlcg0KPj4+Pj4+IGF0IG10
ZC9mc2wtcXVhZHNwaS5jLiBTd2l0Y2ggdG8gdGhlIG5ldyBkcml2ZXIgaW4gdGhlIGRlZmNvbmZp
Z3MuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmll
ZGVyLnNjaHJlbXBmQGV4Y2VldC5kZT4NCj4+Pj4+DQo+Pj4+PiBIaSBGcmllZGVyLA0KPj4+Pj4N
Cj4+Pj4+IFRoaXMgcGF0Y2ggaXMgcGFydCBvZiBhIHNlcmllcyB0aGF0IEkgZGlkbid0IHNlZSB0
aGUgcmVzdCBvZiwgYnV0IGluDQo+Pj4+PiBnZW5lcmFsIHdlIHByZWZlciB0byBtZXJnZSB0aGVz
ZSB0aHJvdWdoIGFybS1zb2MgZXZlbiBpZiB0aGUgZHJpdmVyDQo+Pj4+PiBnb2VzIGluIHRocm91
Z2ggYW5vdGhlciB0cmVlLiBUaGUgd2F5IHdlJ2QgcHJlZmVyIHRvIGhhbmRsZSBpdCBpcyB0aGF0
DQo+Pj4+PiBvbmNlIHRoZSBkcml2ZXIgbGFuZHMsIHdlJ2xsIHRha2UgdGhlIGNvbmZpZyBvcHRp
b24gY2hhbmdlIHRvIHR1cm4gaXQNCj4+Pj4+IG9uLiBUbyBhdm9pZCBvdXIgYnJhbmNoZXMgdG8g
YnJlYWsgdW50aWwgYm90aCBzaWRlcyBoYXZlIGxhbmRlZCwgaXQNCj4+Pj4+IG1pZ2h0IGJlIGEg
Z29vZCBpZGVhIHRvIGtlZXAgYm90aCBkcml2ZXJzIG9uIGZvciBhIHNob3J0IHdoaWxlIChvbmUN
Cj4+Pj4+IHJlbGVhc2UpLg0KPj4+Pj4NCj4+Pj4+IFNvLCBJJ20gbm90IGdvaW5nIHRvIGFjayB0
aGlzIHNpbmNlIHdlIGF2b2lkIHRha2luZyBkZWZjb25maWcgY2hhbmdlcw0KPj4+Pj4gdGhyb3Vn
aCBkcml2ZXIgdHJlZXMgKHRoZXNlIHR3byBkZWZjb25maWdzIHRlbmQgdG8gY2h1cm4gYSBsb3Qg
YW5kIHdlDQo+Pj4+PiBkb24ndCB3YW50IHRvIGNyZWF0ZSBtZXJnZSBjb25mbGljdHMgd2hlcmUg
d2UgZG9uJ3QgaGF2ZSB0byksIGJ1dA0KPj4+Pj4gd2UnbGwgYmUgaGFwcHkgdG8gcGljayBpdCB1
cCB3aGVuIHRoZSB0aW1lIGNvbWVzLg0KPj4+Pg0KPj4+PiBPaywgdGhhbmsgeW91IGZvciBleHBs
YWluaW5nIHRoZSBjb21tb24gcHJhY3RpY2UuIEkgd2lsbCBkcm9wIHRoZSBjb25maWcNCj4+Pj4g
Y2hhbmdlcyBmb3IgdGhlIG5leHQgdmVyc2lvbiBhbmQgc2VuZCBpdCBzZXBhcmF0ZWx5IHdoZW4g
dGhlIHRpbWUgaXMgcmVhZHkuDQo+Pj4+DQo+Pj4+IEJvdGggdGhlIG9sZCBkcml2ZXIgYW5kIHRo
ZSBuZXcgb25lIHVzZSB0aGUgc2FtZSBjb21wYXRpYmxlIHN0cmluZ3MgZm9yDQo+Pj4+IHByb2Jp
bmcuIFdvdWxkbid0IHRoYXQgY2F1c2UgcHJvYmxlbXMgaWYgYm90aCBkcml2ZXJzIGFyZSBlbmFi
bGVkIGZvciBhDQo+Pj4+IHdoaWxlLCBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPj4+DQo+
Pj4gT3IgbWF5YmUgd2Ugc2hvdWxkIG5vdCBpbnRyb2R1Y2UgYSBuZXcgS2NvbmZpZyBvcHRpb24g
YW5kIGp1c3QgcmV1c2UNCj4+PiB0aGUgb2xkIG9uZS4gSXQgcHJvYmFibHkgcmVxdWlyZXMgcmUt
b3JkZXJpbmcgcGF0Y2hlcyBhIGJpdCAocGF0Y2ggMQ0KPj4+IHNob3VsZCBiZSBtb3ZlZCBhZnRl
ciBwYXRjaCA1KS4gVGhlbiB5b3UgaGF2ZSAyIGNob2ljZXM6DQo+Pj4NCj4+PiAxLyBtZXJnZSBw
YXRjaCAxIGFuZCA2IHNvIHRoYXQgdGhlIG5ldyBkcml2ZXIgZWZmZWN0aXZlbHkgcmVwbGFjZXMg
dGhlDQo+Pj4gICAgICBvbGQgb25lIGJ1dCB1c2VzIHRoZSBzYW1lIEtjb25maWcgb3B0aW9uDQo+
Pj4gMi8gcmVtb3ZlIHRoZSBhYmlsaXR5IHRvIGNvbXBpbGUgdGhlIG9sZCBkcml2ZXIgd2hlbiB0
aGUgbmV3IG9uZSBpcw0KPj4+ICAgICAgaW50cm9kdWNlZDogcmVtb3ZlIHRoZSBsaW5lIGZyb20g
ZHJpdmVycy9tdGQvc3BpLW5vciBNYWtlZmlsZSBhbmQNCj4+PiAgICAgIG1vdmUgdGhlIEtjb25m
aWcgZW50cnkgZnJvbSBkcml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgdG8NCj4+PiAgICAgIGRy
aXZlcnMvc3BpL0tjb25maWcuIEFuZCByZW1vdmUgdGhlIG9sZCBjb2RlIGluIGEgc2VwYXJhdGUg
cGF0Y2gNCj4+Pg0KPj4+IEknbSBmaW5lIGVpdGhlciB3YXksIGJ1dCBvcHRpb24gIzIgd2lsbCBw
cm9iYWJseSBtYWtlIHRoZSBwYXRjaA0KPj4+IGludHJvZHVjaW5nIHRoZSBuZXcgZHJpdmVyIGJp
Z2dlciBhbmQgaHVydCByZWFkYWJpbGl0eS4NCj4+DQo+PiBJIHRoaW5rIGhhdmluZyBib3RoIGRy
aXZlcnMgaW4gdGhlIHRyZWUgZm9yIGEgd2hpbGUgd291bGRuJ3QgYmUgc28gYmFkLg0KPj4gU28g
aWYgYW55IGNvbXBhdGliaWxpdHkgaXNzdWVzIGNvbWUgdXAgd2l0aCB0aGUgbmV3IGRyaXZlciwg
cGVvcGxlIGNhbg0KPj4gc3RpbGwgdXNlIHRoZSBvbGQgb25lLg0KPiANCj4gRXhjZXB0IHRoYXQn
cyBub3Qgd2hhdCBoYXBwZW5zIGluIHByYWN0aWNlLiBCZWxpZXZlIG1lLCBJIHRyaWVkIHRoaXMN
Cj4gYXBwcm9hY2ggc2V2ZXJhbCB0aW1lcywgYW5kIHBlb3BsZSBrZWVwIHVzaW5nIHRoZSBvbGQg
ZHJpdmVyIHVudGlsDQo+IHRoZXkncmUgZm9yY2VkIHRvIHN3aXRjaCB0byB0aGUgbmV3IG9uZS4g
U28geW91IGFjdHVhbGx5IGRvbid0IGFkZHJlc3MNCj4gdGhlIHByb2JsZW0sIHlvdSBqdXN0IGRl
bGF5IGl0IGEgYml0LCBhbmQgeW91J2xsIGhhdmUgdG8gZml4DQo+IHJlZ3Jlc3Npb25zIGFueXdh
eS4NCg0KT2ssIEkgc2VlLg0KDQo+PiBUaGVyZWZvcmUgSSB0aGluayBJIHdpbGwgZHJvcCB0aGUg
cGF0Y2hlcyB0aGF0IGNoYW5nZSB0aGUgZGVmY29uZmlnIGFuZA0KPj4gcmVtb3ZlIHRoZSBvbGQg
ZHJpdmVyIGNvZGUgYW5kIGtlZXAgdGhlIGRpZmZlcmVudCBLY29uZmlnIG9wdGlvbnMuIEFuZA0K
Pj4gbWF5YmUgYWRkIGFuIGV4Y2x1c2l2ZSBkZXBlbmRlbmN5IGluIEtjb25maWcsIHNvIGJvdGgg
ZHJpdmVycyBjYW4gbm90IGJlDQo+PiBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUuDQo+Pg0KPj4g
RG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQo+IA0KPiBJJ2QgcmVhbGx5IHByZWZlciB0byBoYXZlIHRo
ZSByZW1vdmFsIG9mIHRoZSBvbGQgZHJpdmVyIGluIHRoZSBzYW1lDQo+IHJlbGVhc2UgdGhlIG5l
dyBkcml2ZXIgaXMgaW50cm9kdWNlZCBidXQgaWYgdGhhdCdzIG5vdCBwb3NzaWJsZSwgbGV0J3MN
Cj4gaGF2ZSBhIGNsZWFyIHBsYW4sIGxpa2UgImludHJvZHVjZSBuZXcgZHJpdmVyIGluIHJlbGVh
c2UgWCwgcmVtb3ZlIHRoZQ0KPiBvbGQgb25lIGluIHJlbGVhc2UgWCsxIi4NCg0KV2UgY2FuIGRv
IGl0IGFzIHlvdSBzdWdnZXN0ZWQuIEkgd2lsbCB0aGluayBhYm91dCB3aGV0aGVyIHRvIHVzZSBv
cHRpb24gDQojMSBvciAjMi4NCldpdGggIzEgd2Ugd2lsbCBoYXZlIHRoZSByZW1vdmFsIG9mIHRo
ZSBvbGQgZHJpdmVyIGFuZCBhZGRpbmcgdGhlIG5ldyANCmRyaXZlciBpbiBvbmUgc2luZ2xlIHBh
dGNoLg0KV2l0aCAjMiB3ZSB3aWxsIGhhdmUgdGhlIGRpc2FibGluZyBvZiB0aGUgb2xkIGRyaXZl
ciB2aWEgTWFrZWZpbGUgaW4gdGhlIA0Kc2FtZSBwYXRjaCB0aGF0cyBhZGRpbmcgdGhlIG5ldyBk
cml2ZXIu
