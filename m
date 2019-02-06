Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8744C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A792175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfBFPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:08:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:27468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbfBFPIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:08:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 07:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="124417225"
Received: from kmsmsx153.gar.corp.intel.com ([172.21.73.88])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2019 07:08:20 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.99]) by
 KMSMSX153.gar.corp.intel.com ([169.254.5.199]) with mapi id 14.03.0415.000;
 Wed, 6 Feb 2019 23:08:19 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUu4AgquesjEnW50+dl61NWIyu6qXRNN0AgAEpl4A=
Date:   Wed, 6 Feb 2019 15:08:18 +0000
Message-ID: <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
         <20190205212308.GA2816@amd>
In-Reply-To: <20190205212308.GA2816@amd>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.140.202]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A22E95B5717B7458C90F6EFD6E1727A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTA1IGF0IDIyOjIzICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IE9uIFN1biAyMDE5LTAyLTAzIDEzOjIwOjA3LCBIYXJyeSBQYW4gd3JvdGU6DQo+ID4gVGhpcyBw
YXRjaCBnaXZlcyB0aGUgcmVhZGVyIGFuIGludHVpdGl2ZSBtZXRyaWMgb2YgdGhlIHRpbWUgY29z
dCBieQ0KPiA+IHRoZSBrZXJuZWwgaXNzdWluZyBhIGZpbGVzeXN0ZW0gc3luYyBkdXJpbmcgc3Vz
cGVuZDsgYWx0aG91Z2gNCj4gPiBkZXZlbG9wZXINCj4gPiBjYW4gZ3Vlc3MgYnkgdGhlIHRpbWVz
dGFtcCBvZiBuZXh0IGxvZyBvciBlbmFibGUgdGhlIGZ0cmFjZSBwb3dlcg0KPiA+IGV2ZW50DQo+
ID4gZm9yIG1hbnVhbCBjYWxjdWxhdGlvbiwgdGhpcyBtYW5uZXIgaXMgZWFzaWVyIHRvIHJlYWQg
YW5kIGJlbmVmaXRzDQo+ID4gdGhlDQo+ID4gYXV0b21hdGljIHNjcmlwdC4NCj4gDQo+IERvIHdl
IHJlYWxseSBuZWVkIHRoaXMgZnVuY3Rpb25hbGl0eT8NCj4gDQo+IEFzIHlvdSBleHBsYWluZWQs
IGRldmVsb3BlcnMgY2FuIGFscmVhZHkgdXNlIG5leHQgdGltZXN0YW1wIG9yDQo+IGZ0cmFjZS4u
LiBhbmQgdGhpcyBpcyByZWFsbHkgbm90IHRoYXQgaW50ZXJlc3RpbmcgbnVtYmVyLg0KDQpUaGUg
YmFja2Ryb3AgaXMgc29tZSBzdHJlc3MgdGVzdCBzY3JpcHQgb2Ygc3VzcGVuZC9yZXN1bWUsIGxp
a2UgQ2hyb21lDQpPUywgaXMgZGVzaWduZWQgdG8gcHJvZ3JhbSBhbiBleHBlY3RlZCBSVEMgd2Fr
ZS1hbGFybSB0aGVuIGlzc3VlDQpzdXNwZW5kIGNvbW1hbmQsIHdoaWxlIGluIHJhcmUgY2FzZSAo
b3IgYnVnZ3kgc29mdHdhcmUpLCB0aGUgZmlsZXN5c3RlbQ0Kc3luYyBjb3VsZCBjb3N0IGxvbmdl
ciB0aW1lIGluIHNlY29uZHMsIHRoaXMgY29uc3VtZXMgdGhlIGFsYXJtIGJ1ZGdldA0KY2F1c2Vz
IHN1c3BlbmQgYWJvcnRpbmcsIGl0IGNvdWxkIGJlIGFic3RydXNlIHRvIHByb2R1Y3Rpb24gbGlu
ZQ0KZGV2ZWxvcGVycyB0byByZWFsaXplIGl0IGlzIG5vdCBhIHBsYXRmb3JtIGlzc3VlIGluIHRl
cm1zIG9mIGRyaXZlcnMNCnN1c3BlbmRpbmc7IGdpdmVuIGEgc3VjaCBtZXRyaWMgbWlnaHQgbWFr
ZSB0aGUgY29tbXVuaWNhdGlvbiBlYXNpZXIsDQp0aGlzIGlzIG15IGludHVpdGlvbi4NCg0KLUhh
cnJ5DQoNCg==
