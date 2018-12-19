Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB682C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397521850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeLSHuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:50:22 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:51724 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeLSHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:50:22 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 3E92A67956D;
        Wed, 19 Dec 2018 08:50:18 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 19 Dec
 2018 08:50:17 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 19 Dec 2018 08:50:17 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Topic: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Index: AQHUlfUoWBvAkgSJkE+oWdptakv0L6WFokmA
Date:   Wed, 19 Dec 2018 07:50:17 +0000
Message-ID: <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
References: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
In-Reply-To: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FA4A9911B66D41B1A43A6085DE32D1@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 3E92A67956D.AC3E7
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBsaW51eC1ydC11c2Vycw0KDQpPbiAxNy4xMi4xOCAxMTo0MiwgRnJpZWRlciBTY2hyZW1wZiB3
cm90ZToNCj4gSGksDQo+IA0KPiBJIGhhdmUgdHJpZWQgdG8gYm9vdCBhIDQuMTQtS2VybmVsIHdp
dGggdGhlIFJULXBhdGNoZXMgYW5kIA0KPiBQUkVFTVBUX1JUX0ZVTEwgb24gYW4gaS5NWDZVTCBi
b2FyZC4gVW5mb3J0dW5hdGVseSB0aGUgYm9vdCBzdGFsbHMgYXQgDQo+IHNvbWUgcG9pbnQgYW5k
IG5ldmVyIGZpbmlzaGVzLg0KPiANCj4gSSBkaWQgc29tZSBiaXNlY3RpbmcgYW5kIGZvdW5kIG91
dCwgdGhhdCByZXZlcnRpbmcgdGhpcyBjaGFuZ2U6IFsxXSwgDQo+IG1ha2VzIHRoZSBib2FyZCBi
b290IGNvcnJlY3RseS4NCj4gDQo+IENhbiBhbnlvbmUgaGVscCB0byBjb21lIHVwIHdpdGggYSBw
cm9wZXIgZml4IGZvciB0aGlzPw0KPiANCj4gVGhhbmtzLA0KPiBGcmllZGVyDQo+IA0KPiBbMV06
IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ydC9s
aW51eC1zdGFibGUtcnQuZ2l0L2NvbW1pdC8/aD12NC4xNC1ydCZpZD01NjY4NGQyMWY3ZjgzNDFm
N2E1ZWQxNDMzNzE0MTEyZjQ5Mjk0NTkwIA0KPiA=
