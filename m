Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B649C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A738E27B4E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A738E27B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeF2G1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:27:32 -0400
Received: from mx01.eckelmann.de ([217.19.183.92]:42177 "EHLO
        mx01.eckelmann.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeF2G1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:27:30 -0400
Received: from ex-srv1.eckelmann.group ([172.18.35.4]:19877 helo=smtp.eckelmann.de)
        by mx01.eckelmann.de with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <G.Schenk@eckelmann.de>)
        id 1fYmsP-0008HE-2T; Fri, 29 Jun 2018 08:27:25 +0200
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1034.26; Fri, 29 Jun 2018 08:27:22 +0200
Received: from EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6]) by
 EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6%3]) with mapi id
 15.01.1034.033; Fri, 29 Jun 2018 08:27:22 +0200
From:   "Schenk, Gavin" <G.Schenk@eckelmann.de>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] siox: don't create a thread without starting it
Thread-Topic: [PATCH] siox: don't create a thread without starting it
Thread-Index: AQHUDrW2M6/o8ED1IEe0vCaNLPxcLqR2pYWA
Date:   Fri, 29 Jun 2018 06:27:22 +0000
Message-ID: <5c1f29b492420c62404edd72fe10af94b3e113d0.camel@eckelmann.de>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
         <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2-1 
x-originating-ip: [2a00:1f08:4007:1c00:3225:8822:4155:3859]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB81EF058CFE1A4CBD8D978675BA7350@eckelmann.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTI4IGF0IDA5OjU3ICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gV2hlbiBhIHNpb3ggbWFzdGVyIGRldmljZSBpcyByZWdpc3RlcmVkIGEga3RocmVhZCBp
cyBjcmVhdGVkIHRoYXQgaXMNCj4gb25seSBzdGFydGVkIHdoZW4gdHJpZ2dlcmVkIGJ5IHVzZXJz
cGFjZS4gU28gdGhpcyB0aHJlYWQgbWlnaHQgYmUgaW4NCj4gVEFTS19VTklOVEVSUlVQVElCTEUg
c3RhdGUgZm9yIGxvbmcgYW5kIHRyaWdnZXIgYSB3YXJuaW5nDQo+IA0KPiAJWyAgMjQxLjEzMDQ2
NV0gSU5GTzogdGFzayBzaW94LTA6NjI2IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25k
cy4NCj4gDQo+IHdpdGggdGhlIHJlc3BlY3RpdmUgZGVidWcgc2V0dGluZ3MgZW5hYmxlZC4gSXQg
bWlnaHQgYmUgcmlnaHQgdG8gcHV0IGFuDQo+IHVuc3RhcnRlZCB0aHJlYWQgdG8gVEFTS19JRExF
IChpbiBrZXJuZWwva3RocmVhZC5jOmt0aHJlYWQoKSkgaW5zdGVhZCwNCj4gYnV0IGluZGVwZW5k
YW50IG9mIHRoaXMgZGlzY3Vzc2lvbiBpdCBpcyBjbGVhbmVyIGZvcg0KPiBzaW94X21hc3Rlcl9y
ZWdpc3RlcigpIHRvIHN0YXJ0IHRoZSB0aHJlYWQgaW1tZWRpYXRlbHkuIFRoZSBlZmZlY3QgaXMN
Cj4gdGhhdCBpdCBlbnRlcnMgaXRzIG93biB3YWl0aW5nIHN0YXRlIGFuZCB0aGVuIHN0YXlzIGlu
IHN0YXRlIFRBU0tfSURMRQ0KPiB3aGljaCBkb2Vzbid0IHRyaWdnZXIgdGhlIGFib3ZlIHdhcm5p
bmcuDQo+IA0KPiBBcyBzaW94X3BvbGxfdGhyZWFkKCkgdXNlcyBzb21lIHZhcmlhYmxlcyBvZiB0
aGUgZGV2aWNlIHRoZQ0KPiBpbml0aWFsaXNhdGlvbiBvZiB0aGVzZSBpcyBtb3ZlZCBiZWZvcmUg
dGhyZWFkIGNyZWF0aW9uLg0KPiANCj4gQWNrZWQtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkg
PHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5p
ZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCkFja2VkLWJ5OiBHYXZp
biBTY2hlbmsgPGcuc2NoZW5rQGVja2VsbWFubi5kZQ0KDQpJIHRlc3RlZCB0aGF0IHRoaXMgd2Fy
bmluZyBpcyBnb25lIHdpdGggdGhpcyBwYXRjaC4NCg0KUmVnYXJkcw0KR2F2aW4gU2NoZW5rDQo=
