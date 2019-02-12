Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C86C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4742120844
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBLAkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:40:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:32657 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfBLAkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:40:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 16:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="114160018"
Received: from kmsmsx156.gar.corp.intel.com ([172.21.138.133])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2019 16:40:40 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.107]) by
 KMSMSX156.gar.corp.intel.com ([169.254.1.240]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 08:40:39 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUu4AgquesjEnW50+dl61NWIyu6qXRNN0AgAEpl4CAABL+gIAIaJGA
Date:   Tue, 12 Feb 2019 00:40:38 +0000
Message-ID: <e09b1e8f534686fe199a887e311136281fa1ce30.camel@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
         <20190205212308.GA2816@amd>
         <fb17e68f94236b1dd02419ebe01c9f76f6fe2259.camel@intel.com>
         <20190206161612.GA7868@amd>
In-Reply-To: <20190206161612.GA7868@amd>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.146.166]
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B31DB717DF8548AF6144A4A3E01E2B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSSdkIHJhdGhlciBlZHVjYXRlIG90aGVyIGRldmVsb3BlcnMgdGhhdCB0aGlzIG1heSBo
YXBwZW4uIGRtZXNnDQo+IHRpbWVzdGFtcHMgc2hvdWxkIGFscmVhZHkgbWFrZSBpdCBlYXN5IHRv
IHNlZS4NCj4gDQo+IEFuZCBhY3R1YWxseS4uLiBpZiB5b3UgZG8gInRpbWUgc3luYyIgaW4gdXNl
cnNwYWNlIGp1c3QgYmVmb3JlDQo+IHByb2dyYW1pbmcgdGhlIFJUQyBhbmQgc3VzcGVuZGluZywg
dGhpcyB3aG9sZSBpc3N1ZSBzaG91bGQgZ28gYXdheS4NCj4gDQo+IA0KSSBhZ3JlZSB3LyB5b3Ug
b24gYm90aCBjb21tZW50cyBiYXNpY2FsbHkuDQoNClRoYWQgc2FpZCwgd2hlbiBpdCBjb21lcyB0
byBkbWVzZywgcmVhZGVycyB3b3VsZCBndWVzcyBieSBjdXJyZW50DQppbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgcHJvZ3JhbSwgdGhlIHR3byBsaW5lcyBvZiBwcl9pbmZvIGFuZCBwbV9wcl9kYmcNCmFy
ZSBjb250cm9sbGVkIGJ5IGNvbXBpbGF0aW9uIGZsYWdzIGFzIHdlbGwgYXMgcHJpbnRrIHJ1bi1s
ZXZlbCwgSQ0KdGhpbmsgdGhlIGluZm9ybWF0aW9uIGlzIGVub3VnaCB3aGlsZSBpdCBpcyBub3Qg
Z3VhcmFudGVlZCBmb3IgdGhpcw0Kc3ViamVjdC4NCg0KQW5vdGhlciByZWFzb24gaXMsIG1vbnRo
cyBhZ28gSSB3b3JrZWQgb24gbXkgY29tbXVuaXR5IHRvIGlsbHVzdHJhdGUNCnRoaXMgb2RkLCBh
ZGRpbmcgJ3N5bmMnIHBvbGljeSBpbiB0aGUgdXNlcnNwYWNlIHNjcmlwdCBbMV0gbWl0aWdhdGVk
DQp0aGUgbG9uZ2VyIHN5bmMgKGlzc3VlZCBieSBrZXJuZWwpIGluIHN1c3BlbmRpbmcsIGhvd2V2
ZXIgSSByZWFsaXplZA0KdGhlcmUgaXMgc3RpbGwgcmFyZSBjYXNlIGJlY2F1c2UgdGhlIHVzZXJz
cGFjZSBzeW5jIGlzIGJlZm9yZSB0aGUNCnByb2Nlc3NlcyBmcmVlemUsIHRoZSBzY3JpcHQgaXMg
cG90ZW50aWFsbHkgY29tcGV0aW5nIHcvIG90aGVyIGhpZ2gNCmxvYWRpbmcgdGFza3Mgd2hpY2gg
bWVhbnMgdGhlcmUgaXMgc3RpbGwgYSBzbWFsbCB3aW5kb3cgKHN5bmMgLT4NCnByb2dyYW0gYWxh
cm0gLT4gc3VzcGVuZCB1bnRpbCBmcmVlemUpIHRoYXQgY291bGQgZ2VuZXJhdGUgc3VjaCBvZGQu
DQoNClNob3J0IHJlY2FwIHRoaXMgdG9waWMgaXMgdHJ5aW5nIHRvIGdpdmUgYSBjbGVhciBpbmRp
Y2F0aW9uIGFzIHNpbXBsZQ0KbWVjaGFuaXNtIGZvciB0aGUgcGxhdGZvcm0gYW5kIE9TIGRldmVs
b3BlcnMgd2hvIG1heSBjb25jZXJuIHRoZQ0Kc3VzcGVuZGluZyB0aW1lIHcvIHNvbWUgc29ydCBv
ZiB0aW1lIGNvbnN0cmFpbjsgZ2l2ZW4gYSBjbGVhciBtZXRyaWMgaXQNCmFsbG93cyBkZXZlbG9w
ZXJzIHRvIGhhdmUgYW4gZWFzaWVyIHRyaWFnZSBzdWNoIGhhcmQtdG8tcmVwcm9kdWNlIGlzc3Vl
DQpzaGFsbCBnbyB0byB2aXJ0dWFsIG1lbW9yeS9maWxlc3lzdGVtIHJhdGhlciB0aGFuIGV4YW1p
bmUgd2hldGhlciB0aGVyZQ0KaXMgbG9uZ2VyIGNvc3Qgb24gZWFjaCBQTSBzdWItc3RhdGUgYWxv
bmcgdy8gdGhlIGRldmljZSBjYWxsYmFja3MNCnRocm91Z2ggYSBsb25nIHN1c3BlbmRpbmcgbG9n
Lg0KDQpMYXN0bHksIEkgdW5kZXJzdGFuZCB0aGlzIGRhdGEgbWlnaHQgbm90IHNvIGludGVyZXN0
aW5nIHRvIGtlcm5lbA0KZGV2ZWxvcGVyczsgc29tZWhvdyBteSByb2xlIGlzIHNpdHRpbmcgaW4g
YmV0d2VlbiB0cnlpbmcgdG8gYnJpZGdlDQprZXJuZWwgYW5kIE9TIGRldmVsb3BlcnMsIEkgZnVs
bHkgcmVzcGVjdCByZXZpZXdlcnMnIGNvbW1lbnRzIGFuZA0KanVzdGlmaWNhdGlvbi4NCg0KDQpT
aW5jZXJlbHksDQpIYXJyeSANCg0KWzFdIA0KaHR0cHM6Ly9jaHJvbWl1bS1yZXZpZXcuZ29vZ2xl
c291cmNlLmNvbS9jL2Nocm9taXVtb3MvcGxhdGZvcm0yLysvNDU4NTYwLzE0L3Bvd2VyX21hbmFn
ZXIvdG9vbHMvc3VzcGVuZF9zdHJlc3NfdGVzdCMyMDINCihBcG9sb2dpemUgbG9uZyBVUkwgYW5k
IGNvbnRleHQgYXMgcmVmZXJlbmNlKQ0K
