Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E72C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D692089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Qq+JEyqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D692089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeGIEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:20:09 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:52431 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbeGIEUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1531110008; x=1562646008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRMMk9KBIc6Bwm/p3IPDZuQCzNfzDsEpyxIepiyLc4M=;
  b=Qq+JEyqaasqhR4ZaqdMy3x+YWn8sUooFCW1EcQw7KQ/iL9nBy7BfrJci
   WjXHLhPzEz+7IhrsY76nxO7Decf0EQxPzDjFu5R7WMvys+EelN1ZR7cGl
   hmSyuwMgO0ucR3skcDUJGMkFuEfsSnvUNX/oWyel1lNraLqto1xlQG89t
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GnBABL4UJbmGOa6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMffoENKAqDcJQ4ggeDOIR+jnYLhGwCF4IXITcVAQIBAQIBAQI?=
 =?us-ascii?q?BAQIQAQEBAQEGDQsGKS+CNSKCYQEBAQEDIxFFDAQCAQgRBAEBAQICIwMCAgIfJ?=
 =?us-ascii?q?QEICAIEAQ0FCIJNS4FoAxWpDoIchwsNgS6BOoELh2OCFYEPgw+CVoIIgx2CVQK?=
 =?us-ascii?q?ZJCsHAowZgwONZYsHhwmBV4F1cIM5gjKOIG8BjjWBGgEB?=
X-IPAS-Result: =?us-ascii?q?A2GnBABL4UJbmGOa6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?ffoENKAqDcJQ4ggeDOIR+jnYLhGwCF4IXITcVAQIBAQIBAQIBAQIQAQEBAQEGD?=
 =?us-ascii?q?QsGKS+CNSKCYQEBAQEDIxFFDAQCAQgRBAEBAQICIwMCAgIfJQEICAIEAQ0FCIJ?=
 =?us-ascii?q?NS4FoAxWpDoIchwsNgS6BOoELh2OCFYEPgw+CVoIIgx2CVQKZJCsHAowZgwONZ?=
 =?us-ascii?q?YsHhwmBV4F1cIM5gjKOIG8BjjWBGgEB?=
Received: from esa6.dell-outbound2.iphmx.com ([68.232.154.99])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:20:05 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 10:20:05 +0600
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.51,328,1526360400"; 
   d="scan'208";a="185272063"
X-DLP:  DLP_GlobalPCIDSS
To:     <yehezkelshb@gmail.com>, <mika.westerberg@linux.intel.com>
CC:     <lukas@wunner.de>, <linux-kernel@vger.kernel.org>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <rjw@rjwysocki.net>, <christian@kellner.me>
Subject: RE: [PATCH 5/5] thunderbolt: Add support for runtime PM
Thread-Topic: [PATCH 5/5] thunderbolt: Add support for runtime PM
Thread-Index: AQHUBvSh0DpHmQ7fvEm9yd0KB5UyA6SEtMKAgACshgCAACh1AIAA4EoA
Date:   Mon, 9 Jul 2018 04:20:00 +0000
Message-ID: <ce53ea53a51b41dca92c5f5978c45cf1@ausx13mpc120.AMER.DELL.COM>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
 <20180707211401.GA13111@wunner.de> <20180708073130.GR2534@lahna.fi.intel.com>
 <CA+CmpXvaE63kBreCMMw_+QwMb811Rjx7B1z5==cY9nQ39J_Ukw@mail.gmail.com>
In-Reply-To: <CA+CmpXvaE63kBreCMMw_+QwMb811Rjx7B1z5==cY9nQ39J_Ukw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZZWhlemtlbCBCZXJuYXQgW21h
aWx0bzp5ZWhlemtlbHNoYkBnbWFpbC5jb21dDQo+IFNlbnQ6IFN1bmRheSwgSnVseSA4LCAyMDE4
IDI6NTYgQU0NCj4gVG86IE1pa2EgV2VzdGVyYmVyZw0KPiBDYzogbHVrYXNAd3VubmVyLmRlOyBM
S01MOyBBbmRyZWFzIE5vZXZlcjsgbWljaGFlbC5qYW1ldEBpbnRlbC5jb207DQo+IHJqd0Byand5
c29ja2kubmV0OyBjaHJpc3RpYW5Aa2VsbG5lci5tZTsgTGltb25jaWVsbG8sIE1hcmlvDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSB0aHVuZGVyYm9sdDogQWRkIHN1cHBvcnQgZm9yIHJ1bnRp
bWUgUE0NCj4gDQo+IE9uIFN1biwgSnVsIDgsIDIwMTggYXQgMTA6MzEgQU0gTWlrYSBXZXN0ZXJi
ZXJnDQo+IDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IE9uIFNhdCwgSnVsIDA3LCAyMDE4IGF0IDExOjE0OjAxUE0gKzAyMDAsIEx1a2FzIFd1bm5lciB3
cm90ZToNCj4gPiA+DQo+ID4gPiBCZWNhdXNlIEknbSBmYWlybHkgY2VydGFpbiB0aGF0DQo+ID4g
PiBJIGRvIG5vdCBnZXQgYSBQTUUgZm9yIHRoZSBMaWdodCBSaWRnZSBpbiBteSBNYWNCb29rIFBy
bywgYnV0IEknbGwgdGVzdA0KPiA+ID4gdGhpcyBvbmNlIG1vcmUgYW5kIG1vZGlmeSBuZWdvdGlh
dGVfb3NfY29udHJvbCgpIHRvIGdyYW50IFBNRSBjb250cm9sDQo+ID4gPiB0byB0aGUgT1MuDQo+
ID4NCj4gPiBJIHRoaW5rIGluIGNhc2Ugb2YgQXBwbGUgaGFyZHdhcmUsIHRoZXkgaGFuZGxlIHRo
ZSBpbiBzb21lIGRpZmZlcmVudA0KPiA+IG1lYW5zIHRoYW4gUE1FIChwb3NzaWJseSBwYXJ0IG9m
IGNoaXBzZXQgZHJpdmVyIG9yIEFDUEkgbWV0aG9kL2V2ZW50KS4NCj4gDQo+IEluIGFkZGl0aW9u
IHRvIHdoYXQgYWxyZWFkeSBtZW50aW9uZWQsIG1hbnkgdGhpbmdzIGhhdmUgY2hhbmdlZCBhcm91
bmQgcG93ZXINCj4gbWFuYWdlbWVudCBkdXJpbmcgQWxwaW5lIFJpZGdlIGRldmVsb3BtZW50LCBz
b21lIG9mIHRoZW0gY2FtZSBsYXRlciBhcyBGVw0KPiB1cGRhdGVzIChhbmQgQklPUyBjaGFuZ2Vz
KS4gQ29tcGFyaW5nIEFscGluZSByaWRnZSB0byBMaWdodCBSaWRnZSBoZXJlIGlzDQo+IGNvbXBh
cmluZyBvcmFuZ2VzIHRvLCB3ZWxsLCBBcHBsZXMuDQoNCkluIHByYWN0aWNlIEkgZG9uJ3QgYW50
aWNpcGF0ZSBhbnlvbmUgaW4gdGhlIGluZHVzdHJ5IG91dHNpZGUgb2YgQXBwbGUgd2lyaW5nIHVw
IFRCVA0Kd2l0aCBSVEQzIHVubGVzcyBpdCdzIGF0IGxlYXN0IEFscGluZSBSaWRnZSBvciBuZXdl
ci4NCg==
