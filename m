Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F55C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C9206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72C9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbeKMXzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:55:18 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:47816 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbeKMXzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:55:17 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 1EB52501CFBA;
        Tue, 13 Nov 2018 14:56:54 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 13 Nov
 2018 14:56:53 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Tue, 13 Nov 2018 14:56:53 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "Han Xu" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Frieder Schrempf" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v4 01/10] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUdqhYSMF1H5PFG0CzH9jp+FBhraVNVheAgABdS4A=
Date:   Tue, 13 Nov 2018 13:56:53 +0000
Message-ID: <134abbb1-57fb-0450-3087-8d28609c36b3@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-2-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB57269B88E1A064F6429D410999C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57269B88E1A064F6429D410999C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <907125CF1118794283A47AA55D5C04EE@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 1EB52501CFBA.AA2BB
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com,
        frieder.schrempf@exceet.de, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAxMy4xMS4xOCAwOToyMiwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNClsuLi5dDQo+PiArDQo+PiArc3RhdGljIHZvaWQgZnNsX3FzcGlfcmVhZF9haGIoc3RydWN0
IGZzbF9xc3BpICpxLCBjb25zdCBzdHJ1Y3QNCj4+ICtzcGlfbWVtX29wICpvcCkgew0KPj4gKwkv
Kg0KPj4gKwkgKiBXZSB3YW50IHRvIGF2b2lkIG5lZWRpbmcgdG8gaW52YWxpZGF0ZSB0aGUgY2Fj
aGUgYnkgaXNzdWVpbmcNCj4+ICsJICogYSByZXNldCB0byB0aGUgQUhCIGFuZCBTZXJpYWwgRmxh
c2ggZG9tYWluLCBhcyB0aGlzIG5lZWRzDQo+PiArCSAqIHRpbWUuIFNvIHdlIGNoYW5nZSB0aGUg
YWRkcmVzcyBvbiBlYWNoIHJlYWQgdG8gdHJpZ2dlciBhbg0KPj4gKwkgKiBhY3R1YWwgcmVhZCBv
cGVyYXRpb24gb24gdGhlIGZsYXNoLiBUaGUgYWN0dWFsIGFkZHJlc3MgZm9yDQo+PiArCSAqIHRo
ZSBmbGFzaCBtZW1vcnkgaXMgc2V0IGJ5IHByb2dyYW1taW5nIHRoZSBMVVQuDQo+PiArCSAqLw0K
PiBBcyBkaXNjdXNzZWQgcHJldmlvdXNseSwgcGxlYXNlIGdvIGF3YXkgd2l0aCB0aGlzIGhhY2sg
YW5kIHVzZSBBSEIgYnVzIGludmFsaWRhdGlvbiBtZXRob2Qgd2l0aCBzbWFsbGVyIHRpbWVvdXQg
dmFsdWUuDQo+IA0KPiBJIHdvdWxkIHN0YXJ0IGRvaW5nIHZhbGlkYXRpb24gb2YgdGhpcyBwYXRj
aCBzZXJpZXMgZnJvbSBuZXh0IHZlcnNpb24gb253YXJkLiBBcyB5b3UgaGF2ZSBtZW50aW9uZWQg
aW4gb3RoZXIgbWFpbCBkaXNjdXNzaW9uIGFib3V0IGlzc3VlIGluIHRoZSBicmVhayBjb25kaXRp
b24gZm9yIGZ1bmN0aW9uICBmc2xfcXNwaV9yZWFkbF9wb2xsX3RvdXQoKS4NCg0KVGhhbmsgeW91
IGZvciB5b3VyIGNvbW1lbnRzLiBJIGp1c3Qgc2VudCB2NSB3aXRoIHNvbWUgZml4ZXMsIGluY2x1
ZGluZyANCmZpeGVkIGZzbF9xc3BpX3JlYWRsX3BvbGxfdG91dCgpLg0KDQpJIGFsc28gcmVtb3Zl
ZCB0aGUgaGFjayBhYm92ZSBhbmQgSSdtIHByb3Blcmx5IHJlc2V0dGluZyB0aGUgQUhCIGRvbWFp
biANCm5vdy4gSSdtIHVzaW5nIGEgMXVzIGRlbGF5IGp1c3QgbGlrZSBpbiB0aGUgb2xkIGRyaXZl
ci4gSW4gbXkgdGVzdHMgdGhlIA0KcGVyZm9ybWFuY2UgaW1wYWN0IHdhcyB2ZXJ5IHNtYWxsICh+
MiUpIGFuZCBpdCBkaWRuJ3QgZ2V0IGJldHRlciB3aGVuIA0KdXNpbmcgbmRlbGF5Lg0KDQpUaGFu
a3MsDQpGcmllZGVy
