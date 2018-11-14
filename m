Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78084C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463EF214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463EF214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeKNTFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:05:36 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:60370 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:05:36 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id B945D67A090;
        Wed, 14 Nov 2018 10:03:09 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 14 Nov
 2018 10:03:09 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Wed, 14 Nov 2018 10:03:09 +0100
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
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgCAAAN+AA==
Date:   Wed, 14 Nov 2018 09:03:09 +0000
Message-ID: <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
In-Reply-To: <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <12895E4EB0F7AD4789A6187064E7B09A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: B945D67A090.ABFE6
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

SGkgWW9nZXNoLA0KDQpPbiAxNC4xMS4xOCAwOTo1MCwgRnJpZWRlciBTY2hyZW1wZiB3cm90ZToN
Cj4gSGkgWW9nZXNoLA0KPiANCj4gT24gMTQuMTEuMTggMDk6MzksIFlvZ2VzaCBOYXJheWFuIEdh
dXIgd3JvdGU6DQo+PiBIaSBGcmllZGVyLA0KPj4NCj4+IEkgaGF2ZSB0cmllZCB2NSB2ZXJzaW9u
IG9mIHRoZSBwYXRjaCBhbmQgaGF2ZSBvYnNlcnZlZCB0aGF0IFJlYWQgaXMgDQo+PiBmYWlsaW5n
IGZvciBDUzEuDQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIGRvaW5nIHRoZSB0ZXN0LiBJIHJlYWxs
eSBhcHByZWNpYXRlIGl0Lg0KPiANCj4+IEluIG15IHRhcmdldCAyIGZsYXNoIGRldmljZXMgYXJl
IGNvbm5lY3RlZCBvbiBzYW1lIGJ1cyBpLmUuIEExIC0+IENTMCANCj4+IGFuZCBBMiAtPiBDUzEu
DQo+Pg0KPj4gT24gaW5pdGlhbCBkZWJ1Z2dpbmcsIEkgZmlndXJlZCB0aGF0IFJlYWQgaXMgZmFp
bGluZyBmb3IgdGhlIEFIQiBtb2RlIA0KPj4gaS5lLiBpZiBJIGF0dGVtcHQgdG8gcmVhZCBkYXRh
IHNpemUgbGVzcyB0aGFuIHJ4ZmlmbyByZWFkIGlzIHdvcmtpbmcgDQo+PiBmaW5lIHdpdGhvdXQg
YW55IGlzc3VlLg0KPj4NCj4+IEZvciBkYXRhIHNpemUgbW9yZSB0aGFuIHJ4ZmlmbyBSZWFkIG91
dCBkYXRhIGlzIGNvbnRlbnQgb2Ygc2FtZSANCj4+IHJlcXVlc3RlZCBhZGRyZXNzIG9mIENTMC4N
Cj4+IMKgwqDCoMKgbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQxIDB4ZjAwMDAwIDB4NzAgcmVhZCAt
LT4gRGF0YSBpcyBjb3JyZWN0DQo+PiDCoMKgwqDCoG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMSAw
eGYwMDAwMCAweDEwMCByZWFkIC0tPiBEYXRhIGlzIA0KPj4gaW4tY29ycmVjdCBhbmQgZGF0YSBj
b250ZW50IGFyZSBvZiB0aGUgYWRkcmVzcyAweGYwMDAwMCBvZiBDUzAgDQo+PiBjb25uZWN0ZWQg
Zmxhc2ggZGV2aWNlLg0KPiANCj4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3aGF0IGNvdWxk
IG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4gDQo+IGNhc2Ugb2YgQUhCIHJlYWQuDQoN
CkNvdWxkIHlvdSB0cnkgd2l0aCB0aGlzIGNoYW5nZSBhcHBsaWVkOg0KDQpAQCAtNTAzLDcgKzUw
Myw3IEBAIHN0YXRpYyB2b2lkIGZzbF9xc3BpX3NlbGVjdF9tZW0oc3RydWN0IGZzbF9xc3BpICpx
LCANCnN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogICAgICAgICAgICAgICAgICAgICAgICAgbWFw
X2FkZHIgPSBxLT5tZW1tYXBfcGh5Ow0KICAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAg
ICAgICAgICAgICAgICAgbWFwX2FkZHIgPSBxLT5tZW1tYXBfcGh5ICsNCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMiAqIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9i
dWZfc2l6ZTsNCg0KICAgICAgICAgICAgICAgICBxc3BpX3dyaXRlbChxLCBtYXBfYWRkciwgcS0+
aW9iYXNlICsgUVVBRFNQSV9TRkExQUQgKyANCihpICogNCkpOw0KICAgICAgICAgfQ0KDQo+IA0K
Pj4gT24gdGhlIHNldHVwIHdoZXJlIHlvdSBoYXZlIGRvbmUgdGVzdGluZywgZGlkIEFIQiBtb2Rl
IHJlYWQgaXMgYmVpbmcgDQo+PiB2ZXJpZmllZCBmb3IgQ1MxPw0KPiANCj4gTm8sIEkgY3VycmVu
dGx5IGhhdmUgb25seSBoYXJkd2FyZSB3aXRoIENTMCBjb25uZWN0ZWQuIFNvIEkgZGlkbid0IHRl
c3QgDQo+IHdpdGggQ1MxLg0KPiANCj4+DQo+PiBJIGFtIGRvaW5nIGZ1cnRoZXIgZGVidWdnaW5n
IG9mIHRoaXMgaXNzdWUuDQo+IA0KPiBUaGFua3MsDQo+IEZyaWVkZXI=
