Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5325FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBDE218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfAYSU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:20:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:56235 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYSU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:20:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 10:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="128579543"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2019 10:20:57 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 25 Jan 2019 10:20:57 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.29]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.103]) with mapi id 14.03.0415.000;
 Fri, 25 Jan 2019 10:20:56 -0800
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Du, Fan" <fan.du@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like
 normal RAM
Thread-Topic: [PATCH 5/5] dax: "Hotplug" persistent memory for use like
 normal RAM
Thread-Index: AQHUtDuaPSwlBZZohUGBnBDlTaN4CqXAB7AAgAAELgCAAB+DgIAAlkyAgAARZIA=
Date:   Fri, 25 Jan 2019 18:20:56 +0000
Message-ID: <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
         <20190124231448.E102D18E@viggo.jf.intel.com>
         <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
         <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
         <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
         <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
In-Reply-To: <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.4 (3.30.4-1.fc29) 
x-originating-ip: [10.232.112.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E31B413D1FF149BE238966A26CD136@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMDEtMjUgYXQgMDk6MTggLTA4MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gT24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMTI6MjAgQU0gRHUsIEZhbiA8ZmFuLmR1QGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gRGFuDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgaW5zaWdodHMh
DQo+ID4gDQo+ID4gQ2FuIEkgc2F5LCB0aGUgVUNFIGlzIGRlbGl2ZXJlZCBmcm9tIGgvdyB0byBP
UyBpbiBhIHNpbmdsZSB3YXkgaW4NCj4gPiBjYXNlIG9mIG1hY2hpbmUNCj4gPiBjaGVjaywgb25s
eSBQTUVNL0RBWCBzdHVmZiBmaWx0ZXIgb3V0IFVDIGFkZHJlc3MgYW5kIG1hbmFnZWQgaW4gaXRz
DQo+ID4gb3duIHdheSBieQ0KPiA+IGJhZGJsb2NrcywgaWYgUE1FTS9EQVggZG9lc24ndCBkbyBz
bywgdGhlbiBjb21tb24gUkFTIHdvcmtmbG93IHdpbGwNCj4gPiBraWNrIGluLA0KPiA+IHJpZ2h0
Pw0KPiANCj4gVGhlIGNvbW1vbiBSQVMgd29ya2Zsb3cgYWx3YXlzIGtpY2tzIGluLCBpdCdzIGp1
c3QgdGhlIHBhZ2Ugc3RhdGUNCj4gcHJlc2VudGVkIGJ5IGEgREFYIG1hcHBpbmcgbmVlZHMgZGlz
dGluY3QgaGFuZGxpbmcuIE9uY2UgaXQgaXMNCj4gaG90LXBsdWdnZWQgaXQgbm8gbG9uZ2VyIG5l
ZWRzIHRvIGJlIHRyZWF0ZWQgZGlmZmVyZW50bHkgdGhhbiAiU3lzdGVtDQo+IFJBTSIuDQo+IA0K
PiA+IEFuZCBob3cgYWJvdXQgd2hlbiBBUlMgaXMgaW52b2x2ZWQgYnV0IG5vIG1hY2hpbmUgY2hl
Y2sgZmlyZWQgZm9yDQo+ID4gdGhlIGZ1bmN0aW9uDQo+ID4gb2YgdGhpcyBwYXRjaHNldD8NCj4g
DQo+IFRoZSBob3RwbHVnIGVmZmVjdGl2ZWx5IGRpc2Nvbm5lY3RzIHRoaXMgYWRkcmVzcyByYW5n
ZSBmcm9tIHRoZSBBUlMNCj4gcmVzdWx0cy4gVGhleSB3aWxsIHN0aWxsIGJlIHJlcG9ydGVkIGlu
IHRoZSBsaWJudmRpbW0gInJlZ2lvbiIgbGV2ZWwNCj4gYmFkYmxvY2tzIGluc3RhbmNlLCBidXQg
dGhlcmUncyBubyBzYWZlIC8gY29vcmRpbmF0ZWQgd2F5IHRvIGdvIGNsZWFyDQo+IHRob3NlIGVy
cm9ycyB3aXRob3V0IGFkZGl0aW9uYWwga2VybmVsIGVuYWJsaW5nLiBUaGVyZSBpcyBubyAiY2xl
YXINCj4gZXJyb3IiIHNlbWFudGljIGZvciAiU3lzdGVtIFJBTSIuDQo+IA0KUGVyaGFwcyBhcyBm
dXR1cmUgZW5hYmxpbmcsIHRoZSBrZXJuZWwgY2FuIGdvIHBlcmZvcm0gImNsZWFyIGVycm9yIiBm
b3INCm9mZmxpbmVkIHBhZ2VzLCBhbmQgbWFrZSB0aGVtIHVzYWJsZSBhZ2Fpbi4gQnV0IEknbSBu
b3Qgc3VyZSBob3cNCnByZXBhcmVkIG1tIGlzIHRvIHJlLWFjY2VwdCBwYWdlcyBwcmV2aW91c2x5
IG9mZmxpbmVkLg0K
