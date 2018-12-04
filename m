Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCBDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786BC208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786BC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLDIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:20:08 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:36440 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLDIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:20:07 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 0828E67A896;
        Tue,  4 Dec 2018 09:20:04 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 4 Dec 2018
 09:20:03 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 4 Dec 2018 09:20:03 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Han Xu <han.xu@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUhjte86vILtO4B0icsbZQtceaAqVky10AgAHHZICAAARRAIAATYCAgAASHoCABoDZgIAAv4yA
Date:   Tue, 4 Dec 2018 08:20:03 +0000
Message-ID: <f12ea437-5fa5-7ca8-a5ba-b4cc1e9b38f7@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-4-git-send-email-frieder.schrempf@kontron.de>
 <3981845c-327a-bb14-2908-47dd443971bf@kontron.de>
 <VI1PR04MB572644A2AE3214356A62478799D20@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <f4c584e5-8930-bec3-0c4e-2216a89606b0@kontron.de>
 <AM6PR04MB496732760F72A0B5B5F4A5A997D20@AM6PR04MB4967.eurprd04.prod.outlook.com>
 <1389ab35-b015-cb5d-1ae9-c8309074a5f9@kontron.de>
 <AM6PR04MB49670EA07FC3C9FC8EF1AFB097AE0@AM6PR04MB4967.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49670EA07FC3C9FC8EF1AFB097AE0@AM6PR04MB4967.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C2714F5A2C98A4CBD04DE6E3244A864@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 0828E67A896.AF75C
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com, han.xu@nxp.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        prabhakar.kushwaha@nxp.com, richard@nod.at, shawnguo@kernel.org,
        yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFuLA0KDQpPbiAwMy4xMi4xOCAyMTo1NCwgSGFuIFh1IHdyb3RlOg0KWy4uLl0NCj4+Pg0K
Pj4+IEhpIFNjaHJlbXBmLCBJIGFtIHJldmlld2luZyBhbmQgdGVzdGluZyBvbiBzb21lIGkuTVgg
cGxhdGZvcm1zLCBwbGVhc2UNCj4+IGhvbGQgb24gZm9yIGEgd2hpbGUgZm9yIHRoZSByZXN1bHQu
DQo+Pg0KPj4gT2theSwgdGhhbmtzISBJJ20gbG9va2luZyBmb3J3YXJkIHRvIHNlZSB0aGUgcmVz
dWx0cy4NCj4gDQo+IEhpIFNjaHJlbXBmLCBJIGFtIGdvb2Qgd2l0aCB0aGUgcGF0Y2ggc2V0KHdp
dGggd2FybmluZyBmaXgpIGFuZCBpdCB3b3JrcyBmaW5lIG9uIGkuTVggcGxhdGZvcm1zLiBJIHdp
bGwgYWRkIHJldmlldyBhbmQgdGVzdCB0YWdzIGZvciBuZXh0IHZlcnNpb24uDQoNCk9rLCB0aGFu
a3MgZm9yIGRvaW5nIHRoZSB0ZXN0cy4gSSB3aWxsIHNlbmQgdGhlIG5leHQgdmVyc2lvbiBzb29u
Lg0KDQo+IEkgaGF2ZSBvbmUgcXVlc3Rpb25zIGFib3V0IHRoZSBERFIgbW9kZSBzdXBwb3J0LCBp
dCB0aGVyZSBhbnkgZnVydGhlciBwbGFucyBmb3IgRERSIG1vZGUgc3VwcG9ydCByYXRoZXIgdGhh
biBTRFIgb25seT8NCkkgZGlkbid0IGxvb2sgYXQgRERSIG1vZGUgc3VwcG9ydCB5ZXQuIEkgZ3Vl
c3Mgc29tZSBjaGFuZ2VzIGluIHRoZSBTUEkgDQpOT1IgYW5kIFNQSSBNRU0gbGF5ZXJzIGFyZSBu
ZWNlc3NhcnksIGJlZm9yZSB0aGUgY29udHJvbGxlciBkcml2ZXJzIGNhbiANCmltcGxlbWVudCBE
RFIgbW9kZSBzdXBwb3J0Lg0KDQpUaGFua3MsDQpGcmllZGVy
