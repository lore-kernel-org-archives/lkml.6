Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F31C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225320871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C225320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeFTFtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:49:39 -0400
Received: from mx01.eckelmann.de ([217.19.183.92]:56402 "EHLO
        mx01.eckelmann.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTFti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:49:38 -0400
Received: from ex-srv1.eckelmann.group ([172.18.35.4]:51123 helo=smtp.eckelmann.de)
        by mx01.eckelmann.de with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <G.Schenk@eckelmann.de>)
        id 1fVVzq-0002oA-0a; Wed, 20 Jun 2018 07:49:34 +0200
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1034.26; Wed, 20 Jun 2018 07:49:31 +0200
Received: from EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6]) by
 EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6%3]) with mapi id
 15.01.1034.033; Wed, 20 Jun 2018 07:49:31 +0200
From:   "Schenk, Gavin" <G.Schenk@eckelmann.de>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [Customers.Eckelmann] [PATCH] locking/rwsem: Fix
 up_read_non_owner() warning with DEBUG_RWSEMS
Thread-Topic: [Customers.Eckelmann] [PATCH] locking/rwsem: Fix
 up_read_non_owner() warning with DEBUG_RWSEMS
Thread-Index: AQHUCFGcJgF0+20i5k27fUV46ZNYGaRogr6A
Date:   Wed, 20 Jun 2018 05:49:30 +0000
Message-ID: <052d9796f814fc5d6625ac7fcd00dc37b0f11da1.camel@eckelmann.de>
References: <1527168398-4291-1-git-send-email-longman@redhat.com>
         <ba5a8266-b475-0f80-50eb-1ed39ffa6d2a@redhat.com>
In-Reply-To: <ba5a8266-b475-0f80-50eb-1ed39ffa6d2a@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2-1 
x-originating-ip: [2a00:1f08:4007:1c00:3225:8822:4155:3859]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F628779770F9FC4B8D7BC7E4CC0C87E3@eckelmann.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAxOC0wNi0yMCBhdCAwNzowOSArMDgwMCwgV2FpbWFuIExvbmcgd3Jv
dGU6DQo+IE9uIDA1LzI0LzIwMTggMDk6MjYgUE0sIFdhaW1hbiBMb25nIHdyb3RlOg0KPiA+IEl0
IHdhcyBmb3VuZCB0aGF0IHRoZSB1c2Ugb2YgdXBfcmVhZF9ub25fb3duZXIoKSBpbiBORlMgd2Fz
IGNhdXNpbmcNCj4gPiB0aGUgZm9sbG93aW5nIHdhcm5pbmcgd2hlbiBERUJVR19SV1NFTVMgd2Fz
IGNvbmZpZ3VyZWQuDQo+ID4gDQo+ID4gICBERUJVR19MT0NLU19XQVJOX09OKHNlbS0+b3duZXIg
IT0gKChzdHJ1Y3QgdGFza19zdHJ1Y3QgKikoMVVMIDw8IDApKSkNCj4gPiANCj4gPiBMb29raW5n
IGludG8gdGhlIHJ3c2VtLmMgZmlsZSwgaXQgd2FzIGRpc2NvdmVyZWQgdGhhdCB0aGUgY29ycmVz
cG9uZGluZw0KPiA+IGRvd25fcmVhZF9ub25fb3duZXIoKSBmdW5jdGlvbiB3YXMgbm90IHNldHRp
bmcgdGhlIG93bmVyIGZpZWxkIHByb3Blcmx5Lg0KPiA+IFRoaXMgaXMgZml4ZWQgbm93LCBhbmQg
dGhlIHdhcm5pbmcgc2hvdWxkIGJlIGdvbmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2Fp
bWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4NClRlc3RlZC1ieTogR2F2aW4gU2NoZW5rIDxn
LnNjaGVua0BlY2tlbG1hbm4uZGU+DQoNClRoaXMgZml4ZXMgbXkgcmVwcm9kdWNpYmxlIGxvY2tp
bmcgc3BsYXQgd2hlbiBib290aW5nIHdpdGggbmZzcm9vdCBhbmQgY2hhbmdpbmcgcGFzc3dvcmQu
IFRoYW5rIHlvdSENCg0KUmVnYXJkcw0KR2F2aW4gU2NoZW5rDQo=
