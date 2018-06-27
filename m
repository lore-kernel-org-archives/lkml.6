Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC982637F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC982637F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeF0Evk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:51:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:55959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeF0Evi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:51:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 21:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,277,1526367600"; 
   d="scan'208";a="61702742"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2018 21:51:28 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 26 Jun 2018 21:51:28 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.50]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.196]) with mapi id 14.03.0319.002;
 Tue, 26 Jun 2018 21:51:28 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: RE: [PATCH] efi: Free existing memory map before installing new
 memory map
Thread-Topic: [PATCH] efi: Free existing memory map before installing new
 memory map
Thread-Index: AQHUDPc2R4ZR/m4foUijQgjP6VqzEKRyvjQAgADFEhA=
Date:   Wed, 27 Jun 2018 04:51:27 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4605BA0F@ORSMSX111.amr.corp.intel.com>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu-_tQsYMUMp4NGrEkRrbFGJvE=vJVciaO6TEAC_u5bmfQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-_tQsYMUMp4NGrEkRrbFGJvE=vJVciaO6TEAC_u5bmfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODc1Zjc2ZWItMWQ5Yy00YWZjLWJiMWEtMGRjZTA4OWNiNmE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicWQ5V3h6a0ZrdTMyd1wvNzFrOE1ncHB1c2NXaHh6MDlmdUZpRlJmR2l6VmdJMWxwXC9ieTM4RnpON2tMZ3JkVUFQIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgICAgICAgLyogRnJlZSB0aGUgbWVtb3J5IGFsbG9jYXRlZCB0byB0aGUgZXhpc3Rpbmcg
bWVtb3J5IG1hcCAqLw0KPiA+ICsgICAgICAgZWZpX21lbW1hcF9mcmVlKGVmaS5tZW1tYXAucGh5
c19tYXAsIGVmaS5tZW1tYXAubnJfbWFwLA0KPiA+ICsgZWZpLm1lbW1hcC5sYXRlKTsNCj4gPiAr
DQo+ID4gICAgICAgICBkYXRhLnBoeXNfbWFwID0gYWRkcjsNCj4gPiAgICAgICAgIGRhdGEuc2l6
ZSA9IGVmaS5tZW1tYXAuZGVzY19zaXplICogbnJfbWFwOw0KPiA+ICAgICAgICAgZGF0YS5kZXNj
X3ZlcnNpb24gPSBlZmkubWVtbWFwLmRlc2NfdmVyc2lvbjsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+
ID4NCj4gDQo+IElmIG9ubHkgaXQgd2VyZSBzbyBzaW1wbGUgOi0pDQo+IA0KPiBBdCB0aGlzIHBv
aW50LCBlZmkubWVtbWFwLnBoeXNfbWFwIGNvdWxkIHBvaW50IHRvIG1lbW9yeSB0aGF0IHdhcyBh
bGxvY2F0ZWQNCj4gZWFybHksIGFsbG9jYXRlZCBsYXRlIG9yIHNpbXBseSBwYXNzZWQgdG8gdGhl
IE9TIGF0IGJvb3QgdGltZSBieSB0aGUgc3R1YiAoaW4NCj4gd2hpY2ggY2FzZSBpdCB3YXMgbWVt
YmxvY2tfcmVzZXJ2ZSgpZCBidXQgbm90IG1lbWJsb2NrX2FsbG9jKClkLCBhbmQgaXQNCj4gc2hv
dWxkIG5vdCBiZSBmcmVlZCkNCj4gDQoNClllcywgY29tcGxldGVseSBhZ3JlZSB0aGF0IHRoZXJl
IGNvdWxkIGJlIHRocmVlIHR5cGVzIG9mIGFsbG9jYXRpb25zIGZvciBtZW1tYXAuIA0KSSB0aG91
Z2h0LCANCmVmaV9tZW1tYXBfZnJlZShlZmkubWVtbWFwLnBoeXNfbWFwLCBlZmkubWVtbWFwLm5y
X21hcCwgZWZpLm1lbW1hcC5sYXRlKTsNCg0Kc2hvdWxkIHdvcmsgYmVjYXVzZSB0aGUgcHJldmlv
dXMgdHlwZSBvZiBhbGxvY2F0aW9uIHNob3VsZCBoYXZlIGJlZW4gcmVjb3JkZWQgaW4gZWZpLm1l
bW1hcC5sYXRlLg0KQnV0LCBub3cgSSBzZWUgdGhpcyB3aWxsIGZhaWwgZm9yIG1lbWJsb2NrX3Jl
c2VydmVkKCkgbWVtb3J5IGJlY2F1c2UgaXQgd2lsbCBiZSBtaXN0YWtlbiB0byANCm1lbWJsb2Nr
X2FsbG9jZWQoKSAoSSBhc3N1bWVkIGJvdGggYXJlIGFsbW9zdCBzaW1pbGFyIDooKS4NCg0KPiBT
byBvbmx5IGFsbG9jYXRpb25zIG1hZGUgd2l0aCBlZmlfbWVtbWFwX2FsbG9jKCkgc2hvdWxkIGJl
IGZyZWVkIGhlcmUuDQoNCk1ha2VzIHNlbnNlIGFuZCBJIHRoaW5rIHRoYXQgYWxzbyBtZWFucyBl
ZmlfbWVtbWFwX2ZyZWUoKSBzaG91bGQgYmUgY2FsbGVkIGZyb20gZnVuY3Rpb24gDQp0aGF0IGNh
bGxlZCBlZmlfbWVtbWFwX2FsbG9jKCkgYW5kIG5vdCBlZmlfbWVtbWFwX2luc3RhbGwoKS4NCg0K
PiBJJ20gbm90IHN1cmUgL2hvdy8gd2Ugc2hvdWxkIGtlZXAgdHJhY2sgb2YgdGhhdDogcGVyaGFw
cyBpdCBpcyBzaW1wbHkgYSBtYXR0ZXIgb2YNCj4gcmVwbGFjaW5nIHRoZSBib29sZWFuICdsYXRl
JyB3aXRoIGFuIGVudW0gdGhhdCBkZXNjcmliZXMgd2hlcmUgdGhlIG1lbW9yeQ0KPiBjYW1lIGZy
b20gdGhhdCBwaHlzX21hcCBwb2ludHMgdG8uDQoNCkkgZGlkIHRyeSBjaGFuZ2luZyBib29sZWFu
IGxhdGUgdG8gZW51bSBhbmQgaXQgc2VlbXMgdG8gYmUgd29ya2luZyBmaW5lLiBJIHdpbGwgZG8g
bW9yZSANCnRlc3RpbmcvY2xlYW4gdXAgYW5kIHdpbGwgc3VibWl0IGEgcGF0Y2ggZm9yIHJldmll
dy4NCg0KQWxzbywgY291bGQgeW91IHBsZWFzZSBjbGFyaWZ5IGlmIHRoZXJlIGlzIGFueSBzcGVj
aWZpYyByZWFzb24gd2h5IG1lbW9yeSBhbGxvY2F0ZWQgDQp1c2luZyBtZW1ibG9ja19yZXNlcnZl
KCkgc2hvdWxkbid0IGJlIGZyZWVkLiBJIG1lYW4sIG5vdCB3aXRoIG1lbWJsb2NrX2ZyZWUoKSBi
dXQgSSANCnRoaW5rIHdlIGNvdWxkIG1ha2UgaXQgX2F2YWlsYWJsZV8gdXNpbmcgZnJlZV9ib290
bWVtKCkgKG9yIHNvbWV0aGluZyBzaW1pbGFyLCBwbGVhc2UgDQpjb3JyZWN0IG1lIGlmIHRoaXMg
aXMgbm90IHRoZSByaWdodCBBUEkpLiBJZiB3ZSBhbGxvY2F0ZSBhbmQgaW5zdGFsbCBhIG5ldyBt
ZW1vcnkgbWFwIChhcyANCmluIGNhc2Ugd2l0aCBlZmlfZmFrZV9tZW1tYXAoKSksIEkgdGhpbmsg
d2Ugc2hvdWxkIGZyZWUgdGhlIG1lbW9yeSB1c2VkIGJ5IG1lbW9yeSBtYXAgDQpvcmlnaW5hbGx5
IHBhc3NlZCBieSBFRkkgc3R1YiwgYmVjYXVzZSwgYXQgYW55IHBvaW50IG9mIHRpbWUgdGhlcmUg
c2hvdWxkIG9ubHkgYmUgb25lIGFjdGl2ZSANCm1lbW9yeSBtYXAuIElmIHdlIGRvbid0IGZyZWUg
dGhlIG9yaWdpbmFsIG1lbW9yeSBtYXAgcGFzc2VkIGJ5IEVGSSBzdHViLCB3ZSB3aWxsIGJlIGhh
dmluZw0KdHdvIGFuZCBoZW5jZSB3aWxsIGJlIGxlYWtpbmcgbWVtb3J5Lg0KDQpSZWdhcmRzLA0K
U2FpDQo=
