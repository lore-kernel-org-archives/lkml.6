Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A491C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465A92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfBST1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:27:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:7958 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfBST13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:27:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 11:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="117444927"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 11:27:28 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 11:27:28 -0800
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.212]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.186]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 11:27:28 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Thread-Topic: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Thread-Index: AQHUyHMdQ2Rh9wSW1Ee31ha6bhAF6aXneo+A
Date:   Tue, 19 Feb 2019 19:27:27 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5B76C3@FMSMSX126.amr.corp.intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
 <2e7fd7b3-9013-d05f-233b-9cd2110f3c73@linux.intel.com>
In-Reply-To: <2e7fd7b3-9013-d05f-233b-9cd2110f3c73@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzdiNjUxNWItMjY4ZC00NmJmLWIxY2ItYzBhZTZmOGRhMjNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2haMlNZemlsNW0zVkViSFFFN21CYkFqY2J5cmxRTkdLSGtyaXdYZk9yK1lBWGQ0SFwvUlhGTFwvZzV1VkFuTlpxIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQEAgLTQ2MSw3ICs0NjMsNyBAQCBzdGF0aWMgYm9vbCBtYXRjaF9sbGMoc3RydWN0IGNwdWlu
Zm9feDg2ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYgKm8pDQo+PiAgICAqLw0KPj4gICBzdGF0aWMg
Ym9vbCBtYXRjaF9kaWUoc3RydWN0IGNwdWluZm9feDg2ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYg
Km8pDQo+PiAgIHsNCj4+IC0JaWYgKGMtPj5waHlzX3Byb2NfaWQgPT0gby0+PnBoeXNfcHJvY19p
ZCkNCj4+ICsJaWYgKGMtPj5jcHVfZGllX2lkID09IG8tPj5jcHVfZGllX2lkKQ0KPj4gICAJCXJl
dHVybiB0cnVlOw0KPj4gICAJcmV0dXJuIGZhbHNlOw0KPj4gICB9DQoNCj4gU2hvdWxkbid0IHdl
IGNoZWNrIHRoZSB1bmlxdWVfZGllX2lkIGhlcmU/DQo+IERpZSBmcm9tIGRpZmZlcmVudCBwYWNr
YWdlIGNhbiBoYXZlIHRoZSBzYW1lIGNwdV9kaWVfaWQuDQoNCkdvb2QgY2F0Y2guDQpVcGRhdGVk
IHRoaXMgaHVuayBhcyBiZWxvdy4NCg0KVGhhbmtzIQ0KLUxlbg0KDQpAQCAtNDYxLDcgKzQ2Myw4
IEBAIHN0YXRpYyBib29sIG1hdGNoX2xsYyhzdHJ1Y3QgY3B1aW5mb194ODYgKmMsIHN0cnVjdCBj
cHVpbmZvX3g4NiAqbykNCiAgKi8NCiBzdGF0aWMgYm9vbCBtYXRjaF9kaWUoc3RydWN0IGNwdWlu
Zm9feDg2ICpjLCBzdHJ1Y3QgY3B1aW5mb194ODYgKm8pDQogew0KLSAgICAgICBpZiAoYy0+cGh5
c19wcm9jX2lkID09IG8tPnBoeXNfcHJvY19pZCkNCisgICAgICAgaWYgKChjLT5waHlzX3Byb2Nf
aWQgPT0gby0+cGh5c19wcm9jX2lkKSAmJg0KKyAgICAgICAgICAgICAgIChjLT5jcHVfZGllX2lk
ID09IG8tPmNwdV9kaWVfaWQpKQ0KICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KICAgICAg
ICByZXR1cm4gZmFsc2U7DQogfQ0KDQo=
