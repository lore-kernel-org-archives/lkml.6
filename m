Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B6DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2E320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbeLQKmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:42:10 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:47096 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeLQKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:42:10 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 407B367A658
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:42:08 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 17 Dec
 2018 11:42:07 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 17 Dec 2018 11:42:07 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Topic: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Index: AQHUlfUoWBvAkgSJkE+oWdptakv0Lw==
Date:   Mon, 17 Dec 2018 10:42:07 +0000
Message-ID: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DF9071B5AC20A468762196811215C6E@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 407B367A658.AA143
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkgaGF2ZSB0cmllZCB0byBib290IGEgNC4xNC1LZXJuZWwgd2l0aCB0aGUgUlQtcGF0
Y2hlcyBhbmQgDQpQUkVFTVBUX1JUX0ZVTEwgb24gYW4gaS5NWDZVTCBib2FyZC4gVW5mb3J0dW5h
dGVseSB0aGUgYm9vdCBzdGFsbHMgYXQgDQpzb21lIHBvaW50IGFuZCBuZXZlciBmaW5pc2hlcy4N
Cg0KSSBkaWQgc29tZSBiaXNlY3RpbmcgYW5kIGZvdW5kIG91dCwgdGhhdCByZXZlcnRpbmcgdGhp
cyBjaGFuZ2U6IFsxXSwgDQptYWtlcyB0aGUgYm9hcmQgYm9vdCBjb3JyZWN0bHkuDQoNCkNhbiBh
bnlvbmUgaGVscCB0byBjb21lIHVwIHdpdGggYSBwcm9wZXIgZml4IGZvciB0aGlzPw0KDQpUaGFu
a3MsDQpGcmllZGVyDQoNClsxXTogDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9ydC9saW51eC1zdGFibGUtcnQuZ2l0L2NvbW1pdC8/aD12NC4xNC1ydCZp
ZD01NjY4NGQyMWY3ZjgzNDFmN2E1ZWQxNDMzNzE0MTEyZjQ5Mjk0NTkw
