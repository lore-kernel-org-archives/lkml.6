Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FB52089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FB52089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389385AbeKPUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:22:15 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:50556 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeKPUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:22:15 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4B2CC6533A3;
        Fri, 16 Nov 2018 11:10:33 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 16 Nov
 2018 11:10:32 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Fri, 16 Nov 2018 11:10:32 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgCAAAN+AIAAG+cAgAAGuQCAAUK+AIAAWaYAgAAZFwCAAA2lAIABBrMAgABDGICAAAFAgIAABrKA
Date:   Fri, 16 Nov 2018 10:10:32 +0000
Message-ID: <09c2b2ae-8266-4b3d-7e50-91324356bfc1@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
 <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
 <VI1PR04MB57265222E26C013D5D9C009B99DC0@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <3e9aa917-cf3a-cf0e-8516-4e73d30eb2a1@kontron.de>
 <20181115141252.52a5b32d@bbrezillon>
 <11f45245-efc4-f1cf-3ead-578a5ca4bf29@kontron.de>
 <VI1PR04MB572631414249F5941C1646D999DD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <2aa180a6-c369-0e84-b6a2-085b0a539695@kontron.de>
 <VI1PR04MB572687F21D67F3910DD3CF9F99DD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB572687F21D67F3910DD3CF9F99DD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D852A5F050889D41B3011D061CD9718B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4B2CC6533A3.AB11B
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMTEuMTggMTA6NDYsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+IEhpIEZyaWVk
ZXIsDQo+IA0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFNjaHJlbXBm
IEZyaWVkZXIgW21haWx0bzpmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uRGVdDQo+PiBTZW50OiBG
cmlkYXksIE5vdmVtYmVyIDE2LCAyMDE4IDM6MTIgUE0NCj4+IFRvOiBZb2dlc2ggTmFyYXlhbiBH
YXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4+IENjOiBCb3JpcyBCcmV6aWxsb24g
PGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgTWFyZWsgVmFzdXQgPG1hcmVrLnZh
c3V0QGdtYWlsLmNvbT47IE1hcmsNCj4+IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBIYW4g
WHUgPGhhbi54dUBueHAuY29tPjsNCj4+IGR3bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2Zv
cnBlYWNlQGdtYWlsLmNvbTsgcmljaGFyZEBub2QuYXQ7DQo+PiBtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tOyBEYXZpZCBXb2xmZSA8ZGF2aWQud29sZmVAbnhwLmNvbT47IEZhYmlvDQo+PiBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBQcmFiaGFrYXIgS3VzaHdhaGENCj4+IDxwcmFi
aGFrYXIua3VzaHdhaGFAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzLzldIHNw
aTogQWRkIGEgZHJpdmVyIGZvciB0aGUgRnJlZXNjYWxlL05YUCBRdWFkU1BJDQo+PiBjb250cm9s
bGVyDQo+Pg0KPj4gSGkgWW9nZXNoLA0KPj4NCj4+IE9uIDE2LjExLjE4IDA2OjQxLCBZb2dlc2gg
TmFyYXlhbiBHYXVyIHdyb3RlOg0KPj4+IEhpIEZyaWVkZXIsDQo+Pj4NCj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogU2NocmVtcGYgRnJpZWRlciBbbWFpbHRvOmZy
aWVkZXIuc2NocmVtcGZAa29udHJvbi5EZV0NCj4+Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDE1LCAyMDE4IDc6MzIgUE0NCj4+Pj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5h
cmF5YW4uZ2F1ckBueHAuY29tPg0KPj4+PiBDYzogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6
aWxsb25AYm9vdGxpbi5jb20+Ow0KPj4+PiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgTWFyZWsgVmFzdXQNCj4+Pj4gPG1hcmVrLnZhc3V0
QGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEhhbiBYdQ0KPj4+
PiA8aGFuLnh1QG54cC5jb20+OyBkd213MkBpbmZyYWRlYWQub3JnOw0KPj4gY29tcHV0ZXJzZm9y
cGVhY2VAZ21haWwuY29tOw0KPj4+PiByaWNoYXJkQG5vZC5hdDsgbWlxdWVsLnJheW5hbEBib290
bGluLmNvbTsgRGF2aWQgV29sZmUNCj4+Pj4gPGRhdmlkLndvbGZlQG54cC5jb20+OyBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPj4+PiBQcmFiaGFrYXIgS3VzaHdhaGEg
PHByYWJoYWthci5rdXNod2FoYUBueHAuY29tPjsNCj4+IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
Pj4+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgMy85XSBzcGk6IEFkZCBhIGRyaXZlciBmb3IgdGhlIEZyZWVzY2FsZS9OWFANCj4+Pj4g
UXVhZFNQSSBjb250cm9sbGVyDQo+Pj4+DQo+Pj4+IEhpIFlvZ2VzaCwNCj4+Pj4NCj4+Pj4gT24g
MTUuMTEuMTggMTQ6MTIsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4+Pj4+IE9uIFRodSwgMTUg
Tm92IDIwMTggMTE6NDM6MDUgKzAwMDANCj4+Pj4+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIu
c2NocmVtcGZAa29udHJvbi5EZT4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IE9uIDE1LjExLjE4IDA3
OjIyLCBZb2dlc2ggTmFyYXlhbiBHYXVyIHdyb3RlOg0KPj4+Pj4+PiBIaSBGcmllZGVyLA0KPj4+
Pj4+Pg0KPj4+Pj4+PiBXaXRoIGJlbG93IHBhdGNoIG9uIHRvcCBvZiB5b3VyIHY1LCBSZWFkL1dy
aXRlL0VyYXNlIG9uIENTMSBpcw0KPj4+Pj4+PiB3b3JraW5nDQo+Pj4+IGZpbmUgZm9yIG1lLg0K
Pj4+Pj4+DQo+Pj4+Pj4gT2ssIGFyZSB5b3Ugc3VyZSwgdGhhdCBBSEIgcmVhZCBpcyB3b3JraW5n
IHRvbyB3aXRoIHRoaXMgcGF0Y2g/DQo+Pj4+Pj4gWW91IGFyZSByZW1vdmluZyB0aGUgbWVtbWFw
X3BoeSBvZmZzZXQgZnJvbSBTRkFSIGFuZCB0aGUgU0ZYWEFEDQo+Pj4+Pj4gcmVnaXN0ZXIgdmFs
dWVzLg0KPj4+Pj4+DQo+Pj4+Pj4gSSBjYW4gdW5kZXJzdGFuZCB0aGF0IHNlbGVjdGlvbiBvZiB0
aGUgQ1MgYW5kIElQIGNvbW1hbmRzIHdpbGwgd29yaw0KPj4+Pj4+IGxpa2UgdGhpcywgYnV0IEkg
Y2FuJ3QgdW5kZXJzdGFuZCBob3cgQUhCIHJlYWQgc2hvdWxkIHdvcmsgd2l0aG91dA0KPj4+Pj4+
IHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIG1hcHBlZCBtZW1vcnkuDQo+Pj4+Pj4NCj4+Pj4+PiBJ
J20gYWZyYWlkIEkgc3RpbGwgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB0aGUgYmFja2dyb3VuZCBv
ZiB0aGVzZQ0KPj4+Pj4+IHRoaW5ncywNCj4+Pj4+DQo+Pj4+PiBTYW1lIGhlcmUuIFlvZ2VzaCwg
Y2FuIHlvdSBnaXZlIHVzIG1vcmUgZGV0YWlsIG9uIHdoeSB5b3UgZGVjaWRlZCB0bw0KPj4+Pj4g
ZHJvcCB0aGUgbWVtbWFwX3BoeSBvZmZzZXQ/DQo+Pj4+DQo+Pj4+IFlvdXIgY2hhbmdlcyBkbyBu
b3Qgd29yayBvbiBteSBzZXR1cCAoaS5NWDZVTCkuIEl0IGxvb2tzIGxpa2UgeW91cg0KPj4+PiBo
YXJkd2FyZSBpcyBkaWZmZXJlbnQuDQo+Pj4+DQo+Pj4+IEkgZm91bmQgdGhpcyBwYXRjaCBmb3Ig
TFMyMDgwQTogWzFdLiBUaGlzIHdvdWxkIGV4cGxhaW4gd2h5IHlvdSBuZWVkDQo+Pj4+IHRvIHJl
bW92ZSB0aGUgb2Zmc2V0IHRvIG1ha2UgaXQgd29yay4NCj4+Pj4NCj4+Pj4gVG8gdmVyaWZ5IHRo
aXMsIGNvdWxkIHlvdSBwbGVhc2UgdGVzdCB5b3VyIHNldHVwIHdpdGggdGhlIGN1cnJlbnQNCj4+
Pj4gc3BpLW5vciBkcml2ZXIgKGZzbF9xdWFkc3BpLmMpLiBJZiBvdXIgYXNzdW1wdGlvbnMgYXJl
IHJpZ2h0LCBpdA0KPj4+PiBzaG91bGQgb25seSB3b3JrIG9uIENTMCBhbmQgQ1MxIHdpdGggWzFd
IGFwcGxpZWQuDQo+Pj4+DQo+Pj4NCj4+PiBZZXMsIEkgbmVlZCB0byByZW1vdmUgdGhlIG9mZnNl
dCB0byBtYWtlIGl0IHdvcmsgYW5kIHRoaXMgaXMgcmVxdWlyZWQgZm9yIHRoZQ0KPj4gTlhQIExh
eWVyc2NhcGUtMi54IFNvQ3MgbGlrZSBMUzIwOHgvTHMxMDh4IGV0Yy4NCj4+Pg0KPj4+IEkgaGF2
ZSBtb2RpZmllZCB0aGUgcGF0Y2ggYW5kIGhhdmUgaW50cm9kdWNlZCBlbnRyeSBpbiBxdWlya3Mg
Zm9yIGxzMjA4MGEuIFdpdGgNCj4+IHRoaXMgUmVhZC9Xcml0ZS9FcmFzZSBhcmUgd29ya2luZyBm
b3IgbWUgZm9yIGJvdGggQ1MuDQo+Pg0KPj4gT2ssIHdoYXQgSSB3YXMgYXNraW5nIGZvciBpcyBh
IHRlc3Qgd2l0aCB0aGUgb3JpZ2luYWwsIHVubW9kaWZpZWQgU1BJIE5PUiBkcml2ZXIgaW4NCj4+
IG10ZC9zcGktbm9yL2ZzbC1xdWFkc3BpLmMuIFdlIG5lZWQgdGhpcyB0byBjb25maXJtIHRoYXQg
dGhlIHByb2JsZW0gaXMgcmVhbGx5DQo+PiB3aGF0IHdlIHRoaW5rLCBvciB0byBmaW5kIG91dCBp
ZiB3ZSBtaXNzZWQgc29tZXRoaW5nLg0KPj4NCj4+IENhbiB5b3UgcGxlYXNlIGRvIGEgcXVpY2sg
dGVzdD8gSWYgaXQgY29uZmlybXMgb3VyIGFzc3VtcHRpb25zLCBJIHdpbGwgc2VuZCBhIG5ldw0K
Pj4gdmVyc2lvbiB3aXRoIHRoZSBxdWlyayBhbmQgaG9wZWZ1bGx5IHdlIGNhbiB0aGVuIG1vdmUg
b24uDQo+Pg0KPiANCj4gWWVzLCBwcm9ibGVtIGV4aXN0IHdpdGggb3JpZ2luYWwgdW4tbW9kaWZp
ZWQgdXBzdHJlYWQgU1BJLU5PUiBkcml2ZXIgYWxzby4NCj4gQWN0dWFsbHksIGludGVybmFsbHkg
d2UgYXJlIG1haW50YWluaW5nIGRyaXZlciB3aXRoIHNvbWUgbG9jYWwgY2hhbmdlIGFuZCBvbmUg
b2YgdGhlIGNoYW5nZSBpcyByZWxhdGVkIHRvIHNhbWUgaS5lLiBtYWtpbmcgaGF2aW5nIG1hcF9h
ZGRyIGFzIDAgZm9yIGxheWVyc2NhcGUgY2hpcHMuDQo+IA0KPiBJIGhhdmUgdGVzdGVkLCB0aGF0
IGJ5IHJlbW92aW5nIHRoYXQgQ1MxIGFjY2VzcyBzaG93cyBlcnJvci4NCg0KT2ssIHRoYW5rIHlv
dSBmb3IgY2xhcmlmeWluZyB0aGlzIQ0KDQo+IA0KPiBQbGVhc2UgaW50ZWdyYXRlIHRoZXNlIGNo
YW5nZXMgaW4geW91ciBuZXh0IHZlcnNpb24uDQoNCk9rLg0KDQpUaGFua3MsDQpGcmllZGVy
