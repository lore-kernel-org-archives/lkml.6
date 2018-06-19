Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A30C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39AD20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937603AbeFSKsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:48:02 -0400
Received: from mx01.eckelmann.de ([217.19.183.92]:50194 "EHLO
        mx01.eckelmann.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937215AbeFSKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:48:01 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 06:48:01 EDT
Received: from ex-srv1.eckelmann.group ([172.18.35.4]:11092 helo=smtp.eckelmann.de)
        by mx01.eckelmann.de with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <G.Schenk@eckelmann.de>)
        id 1fVE5f-0002M2-1l; Tue, 19 Jun 2018 12:42:23 +0200
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1034.26; Tue, 19 Jun 2018 12:42:20 +0200
Received: from EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6]) by
 EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6%3]) with mapi id
 15.01.1034.033; Tue, 19 Jun 2018 12:42:20 +0200
From:   "Schenk, Gavin" <G.Schenk@eckelmann.de>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] siox: treat type errors as status errors
Thread-Topic: [PATCH] siox: treat type errors as status errors
Thread-Index: AQHUB7FbWJxaFjGFjUKTSlbj4w49q6RnQ3qA
Date:   Tue, 19 Jun 2018 10:42:20 +0000
Message-ID: <ba3b6dcf3e8e767d95151bf4a5d2dc40b06ba45d.camel@eckelmann.de>
References: <20180619093854.24232-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180619093854.24232-1-u.kleine-koenig@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2-1 
x-originating-ip: [2a00:1f08:4007:1c00:3225:8822:4155:3859]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA0578E2624FB14EB5E71D97B5ECA47D@eckelmann.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgMjAxOC0wNi0xOSBhdCAxMTozOCArMDIwMCwgVXdl
IEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IFRoZSB0eXBlIGJpdHMgYXJlIHBh
cnQgb2YgdGhlIHBlci1kZXZpY2Ugc3RhdHVzIHdvcmQuIFNvIGl0J3MgbmF0
dXJhbCB0bw0KPiBjb25zaWRlciBhbiBlcnJvciBpbiB0aGUgdHlwZSBiaXRz
IGFzIGEgc3RhdHVzIGVycm9yIGluc3RlYWQgb2Ygb25seQ0KPiByZXN1bHRp
bmcgaW4gYW4gdW5zeW5jZWQgc3RhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJv
bml4LmRlPg0KQWNrZWQtYnk6IEdhdmluIFNjaGVuayA8Zy5zY2hlbmtAZWNr
ZWxtYW5uLmRlPg0KDQoNCkJlc3QgUmVnYXJkcw0KR2F2aW4gU2NoZW5rDQoK
LS0gCkVja2VsbWFubiBBRwpWb3JzdGFuZDogRGlwbC4tSW5nLiBQZXRlciBG
cmFua2VuYmFjaCAoU3ByZWNoZXIpIERpcGwuLVdpLi1JbmcuIFBoaWxpcHAg
RWNrZWxtYW5uCkRyLi1JbmcuIE1hcmNvIE3DvG5jaGhvZiBEci4tSW5nLiBG
cmFuayBVaGxlbWFubgpWb3JzaXR6ZW5kZXIgZGVzIEF1ZnNpY2h0c3JhdHM6
IEh1YmVydHVzIEcuIEtyb3NzYQpTdHYuIFZvcnNpdHplbmRlciBkZXMgQXVm
c2ljaHRzcmF0czogRHIuLUluZy4gR2VyZCBFY2tlbG1hbm4KU2l0eiBkZXIg
R2VzZWxsc2NoYWZ0OiBCZXJsaW5lciBTdHIuIDE2MSwgNjUyMDUgV2llc2Jh
ZGVuLCBBbXRzZ2VyaWNodCBXaWVzYmFkZW4gSFJCIDEyNjM2Cmh0dHA6Ly93
d3cuZWNrZWxtYW5uLmRlCg==
