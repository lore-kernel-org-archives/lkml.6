Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E952AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54DE2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54DE2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeKNSxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:53:00 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:55862 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:53:00 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 31CEF6798D3;
        Wed, 14 Nov 2018 09:50:39 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 14 Nov
 2018 09:50:38 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Wed, 14 Nov 2018 09:50:38 +0100
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
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgA=
Date:   Wed, 14 Nov 2018 08:50:38 +0000
Message-ID: <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9825BF6EF2E204790D63444BD5D6864@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 31CEF6798D3.AD337
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

SGkgWW9nZXNoLA0KDQpPbiAxNC4xMS4xOCAwOTozOSwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNCj4gSGkgRnJpZWRlciwNCj4gDQo+IEkgaGF2ZSB0cmllZCB2NSB2ZXJzaW9uIG9mIHRoZSBw
YXRjaCBhbmQgaGF2ZSBvYnNlcnZlZCB0aGF0IFJlYWQgaXMgZmFpbGluZyBmb3IgQ1MxLg0KDQpU
aGFua3MgYSBsb3QgZm9yIGRvaW5nIHRoZSB0ZXN0LiBJIHJlYWxseSBhcHByZWNpYXRlIGl0Lg0K
DQo+IEluIG15IHRhcmdldCAyIGZsYXNoIGRldmljZXMgYXJlIGNvbm5lY3RlZCBvbiBzYW1lIGJ1
cyBpLmUuIEExIC0+IENTMCBhbmQgQTIgLT4gQ1MxLg0KPiANCj4gT24gaW5pdGlhbCBkZWJ1Z2dp
bmcsIEkgZmlndXJlZCB0aGF0IFJlYWQgaXMgZmFpbGluZyBmb3IgdGhlIEFIQiBtb2RlIGkuZS4g
aWYgSSBhdHRlbXB0IHRvIHJlYWQgZGF0YSBzaXplIGxlc3MgdGhhbiByeGZpZm8gcmVhZCBpcyB3
b3JraW5nIGZpbmUgd2l0aG91dCBhbnkgaXNzdWUuDQo+IA0KPiBGb3IgZGF0YSBzaXplIG1vcmUg
dGhhbiByeGZpZm8gUmVhZCBvdXQgZGF0YSBpcyBjb250ZW50IG9mIHNhbWUgcmVxdWVzdGVkIGFk
ZHJlc3Mgb2YgQ1MwLg0KPiAJbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQxIDB4ZjAwMDAwIDB4NzAg
cmVhZCAtLT4gRGF0YSBpcyBjb3JyZWN0DQo+IAltdGRfZGVidWcgcmVhZCAvZGV2L210ZDEgMHhm
MDAwMDAgMHgxMDAgcmVhZCAtLT4gRGF0YSBpcyBpbi1jb3JyZWN0IGFuZCBkYXRhIGNvbnRlbnQg
YXJlIG9mIHRoZSBhZGRyZXNzIDB4ZjAwMDAwIG9mIENTMCBjb25uZWN0ZWQgZmxhc2ggZGV2aWNl
Lg0KDQpPaywgSSB3aWxsIGhhdmUgYSBsb29rIGF0IHdoYXQgY291bGQgbWFrZSB0aGUgY2hpcCBz
ZWxlY3Rpb24gZmFpbCBpbiANCmNhc2Ugb2YgQUhCIHJlYWQuDQoNCj4gT24gdGhlIHNldHVwIHdo
ZXJlIHlvdSBoYXZlIGRvbmUgdGVzdGluZywgZGlkIEFIQiBtb2RlIHJlYWQgaXMgYmVpbmcgdmVy
aWZpZWQgZm9yIENTMT8NCg0KTm8sIEkgY3VycmVudGx5IGhhdmUgb25seSBoYXJkd2FyZSB3aXRo
IENTMCBjb25uZWN0ZWQuIFNvIEkgZGlkbid0IHRlc3QgDQp3aXRoIENTMS4NCg0KPiANCj4gSSBh
bSBkb2luZyBmdXJ0aGVyIGRlYnVnZ2luZyBvZiB0aGlzIGlzc3VlLg0KDQpUaGFua3MsDQpGcmll
ZGVy
