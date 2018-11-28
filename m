Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D615820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615820832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeK1XW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:22:28 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:43894 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeK1XW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:22:28 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 2F7F867A7D0;
        Wed, 28 Nov 2018 13:20:57 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 13:20:56 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 13:20:56 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Index: AQHUdz2L3HigzaAOUUKXPQ4ku2nhHqVWAI6AgA8p0wA=
Date:   Wed, 28 Nov 2018 12:20:56 +0000
Message-ID: <c3811f92-a982-2fc0-f0df-f207c6ff120c@kontron.de>
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
 <20181118214721.1ede9fb6@xps13>
In-Reply-To: <20181118214721.1ede9fb6@xps13>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FBDD1E9DA66FB42A4730FBC7B4A9F41@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2F7F867A7D0.AEB70
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        peron.clem@gmail.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdcOobCwNCg0KT24gMTguMTEuMTggMjE6NDcsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+
IEhpIFNjaHJlbXBmLA0KPiANCj4gU2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBr
b250cm9uLkRlPiB3cm90ZSBvbiBUaHUsIDggTm92IDIwMTgNCj4gMDg6MzI6MTEgKzAwMDA6DQo+
IA0KPj4gQWRkIG1pbmltYWwgc3VwcG9ydCBmb3IgdGhlIFRvc2hpYmEgVEM1OENWRzJTMEggU1BJ
IE5BTkQgY2hpcC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmll
ZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+PiAtLS0NCj4gDQo+IFdpdGggIm10ZDogc3BpbmFu
ZDoiIGFzIHByZWZpeCwgYXBwbGllZCB0byBuYW5kL25leHQuDQoNCkNsw6ltZW50IHN1Z2dlc3Rl
ZCBzb21lIGZpeGVzL2ltcHJvdmVtZW50cyBmb3IgdGhpcyBwYXRjaC4gWW91IGNhbiBmaW5kIA0K
dGhlbSBpbiB0aGlzIHBhdGNoOiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEw
MDQ1MDEvLg0KDQpXaGVuIHRoZXNlIGNoYW5nZXMgYXJlIGFwcHJvdmVkLCB5b3UgY2FuIGRlY2lk
ZSBpZiB5b3UgYXBwbHkgdGhpcyBvbiB0b3AgDQpvZiB0aGUgaW5pdGlhbCBwYXRjaCBvciBpZiB5
b3UgY2FuL3dhbnQgdG8gc3F1YXNoIGJvdGggcGF0Y2hlcy4NCg0KVGhhbmtzLA0KRnJpZWRlcg==
