Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C712C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32E22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32E22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbeKPAJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:09:54 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:38068 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeKPAJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:09:54 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 5B4F66798ED;
        Thu, 15 Nov 2018 15:01:43 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 15 Nov
 2018 15:01:43 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Thu, 15 Nov 2018 15:01:43 +0100
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
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgCAAAN+AIAAG+cAgAAGuQCAAUK+AIAAWaYAgAAZFwCAAA2lAA==
Date:   Thu, 15 Nov 2018 14:01:42 +0000
Message-ID: <11f45245-efc4-f1cf-3ead-578a5ca4bf29@kontron.de>
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
In-Reply-To: <20181115141252.52a5b32d@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AFC4BC7E3BC2943BFE1E80638A5616A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5B4F66798ED.AC578
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

SGkgWW9nZXNoLA0KDQpPbiAxNS4xMS4xOCAxNDoxMiwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0K
PiBPbiBUaHUsIDE1IE5vdiAyMDE4IDExOjQzOjA1ICswMDAwDQo+IFNjaHJlbXBmIEZyaWVkZXIg
PGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5EZT4gd3JvdGU6DQo+IA0KPj4gT24gMTUuMTEuMTgg
MDc6MjIsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+Pj4gSGkgRnJpZWRlciwNCj4+Pg0K
Pj4+IFdpdGggYmVsb3cgcGF0Y2ggb24gdG9wIG9mIHlvdXIgdjUsIFJlYWQvV3JpdGUvRXJhc2Ug
b24gQ1MxIGlzIHdvcmtpbmcgZmluZSBmb3IgbWUuDQo+Pg0KPj4gT2ssIGFyZSB5b3Ugc3VyZSwg
dGhhdCBBSEIgcmVhZCBpcyB3b3JraW5nIHRvbyB3aXRoIHRoaXMgcGF0Y2g/DQo+PiBZb3UgYXJl
IHJlbW92aW5nIHRoZSBtZW1tYXBfcGh5IG9mZnNldCBmcm9tIFNGQVIgYW5kIHRoZSBTRlhYQUQg
cmVnaXN0ZXINCj4+IHZhbHVlcy4NCj4+DQo+PiBJIGNhbiB1bmRlcnN0YW5kIHRoYXQgc2VsZWN0
aW9uIG9mIHRoZSBDUyBhbmQgSVAgY29tbWFuZHMgd2lsbCB3b3JrIGxpa2UNCj4+IHRoaXMsIGJ1
dCBJIGNhbid0IHVuZGVyc3RhbmQgaG93IEFIQiByZWFkIHNob3VsZCB3b3JrIHdpdGhvdXQgdGhl
IGJhc2UNCj4+IGFkZHJlc3Mgb2YgdGhlIG1hcHBlZCBtZW1vcnkuDQo+Pg0KPj4gSSdtIGFmcmFp
ZCBJIHN0aWxsIGRvbid0IGZ1bGx5IHVuZGVyc3RhbmQgdGhlIGJhY2tncm91bmQgb2YgdGhlc2UN
Cj4+IHRoaW5ncywNCj4gDQo+IFNhbWUgaGVyZS4gWW9nZXNoLCBjYW4geW91IGdpdmUgdXMgbW9y
ZSBkZXRhaWwgb24gd2h5IHlvdSBkZWNpZGVkIHRvDQo+IGRyb3AgdGhlIG1lbW1hcF9waHkgb2Zm
c2V0Pw0KDQpZb3VyIGNoYW5nZXMgZG8gbm90IHdvcmsgb24gbXkgc2V0dXAgKGkuTVg2VUwpLiBJ
dCBsb29rcyBsaWtlIHlvdXIgDQpoYXJkd2FyZSBpcyBkaWZmZXJlbnQuDQoNCkkgZm91bmQgdGhp
cyBwYXRjaCBmb3IgTFMyMDgwQTogWzFdLiBUaGlzIHdvdWxkIGV4cGxhaW4gd2h5IHlvdSBuZWVk
IHRvIA0KcmVtb3ZlIHRoZSBvZmZzZXQgdG8gbWFrZSBpdCB3b3JrLg0KDQpUbyB2ZXJpZnkgdGhp
cywgY291bGQgeW91IHBsZWFzZSB0ZXN0IHlvdXIgc2V0dXAgd2l0aCB0aGUgY3VycmVudCANCnNw
aS1ub3IgZHJpdmVyIChmc2xfcXVhZHNwaS5jKS4gSWYgb3VyIGFzc3VtcHRpb25zIGFyZSByaWdo
dCwgaXQgc2hvdWxkIA0Kb25seSB3b3JrIG9uIENTMCBhbmQgQ1MxIHdpdGggWzFdIGFwcGxpZWQu
DQoNClRoYW5rcywNCkZyaWVkZXINCg0KWzFdOiBodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cGF0Y2gvNjYwMzY0Lw==
