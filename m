Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFEA223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFEA223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeKNVJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:09:56 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:36468 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeKNVJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:09:55 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7DDCF60B9F5E;
        Wed, 14 Nov 2018 12:07:05 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 14 Nov
 2018 12:07:05 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Wed, 14 Nov 2018 12:07:05 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgCAAAN+AIAAG+cAgAAGuQA=
Date:   Wed, 14 Nov 2018 11:07:04 +0000
Message-ID: <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
 <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <89687489640DA44EB6C07997A23F0A96@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7DDCF60B9F5E.AD138
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

DQoNCk9uIDE0LjExLjE4IDExOjQzLCBZb2dlc2ggTmFyYXlhbiBHYXVyIHdyb3RlOg0KPiBIaSBG
cmllZGVyLA0KPiANCj4gWy4uXQ0KPj4+DQo+Pj4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3
aGF0IGNvdWxkIG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4NCj4+PiBjYXNlIG9mIEFI
QiByZWFkLg0KPj4NCj4+IENvdWxkIHlvdSB0cnkgd2l0aCB0aGlzIGNoYW5nZSBhcHBsaWVkOg0K
Pj4NCj4+IEBAIC01MDMsNyArNTAzLDcgQEAgc3RhdGljIHZvaWQgZnNsX3FzcGlfc2VsZWN0X21l
bShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdA0KPj4gc3BpX2RldmljZSAqc3BpKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBtYXBfYWRkciA9IHEtPm1lbW1hcF9waHk7DQo+PiAgICAg
ICAgICAgICAgICAgICBlbHNlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9hZGRy
ID0gcS0+bWVtbWFwX3BoeSArDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDIgKiBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZTsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcS0+ZGV2dHlwZV9kYXRhLT5haGJfYnVmX3NpemU7DQo+Pg0KPj4g
ICAgICAgICAgICAgICAgICAgcXNwaV93cml0ZWwocSwgbWFwX2FkZHIsIHEtPmlvYmFzZSArIFFV
QURTUElfU0ZBMUFEICsNCj4+IChpICogNCkpOw0KPj4gICAgICAgICAgIH0NCj4+DQo+IA0KPiBJ
IGhhdmUgdHJpZWQgYWJvdmUgY2hhbmdlIGFuZCBhbHNvIGhhdmUgZG9uZSBmZXcgbW9yZSBjaGFu
Z2VzIGJ1dCBzdGlsbCBBSEIgcmVhZCBmb3IgQ1MxIGlzIGZhbGxpbmcuDQoNCk1heWJlIENTMSBp
cyBub3Qgc2VsZWN0ZWQgYmVjYXVzZSB3ZSByZXVzZSB0aGUgc2FtZSBtZW1vcnkgb2Zmc2V0IGFz
IGZvciANCkNTMC4gQ2FuIHlvdSB0cnkgd2l0aCBhIGZpeGVkIG1hcHBpbmcgZm9yIGFsbCBmb3Vy
IENTIGxpbmVzLCBsaWtlIHRoaXM6IA0KaHR0cHM6Ly9wYXN0ZS5lZS9wL21Zd2pQPw0KDQpUaGFu
a3MsDQpGcmllZGVy
