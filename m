Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B8DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9B4218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAaTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:47:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:53727 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfAaTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:47:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 11:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="130538005"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2019 11:47:22 -0800
Received: from HASMSX110.ger.corp.intel.com (10.184.198.28) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 31 Jan 2019 11:47:22 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.55]) by
 HASMSX110.ger.corp.intel.com ([169.254.6.213]) with mapi id 14.03.0415.000;
 Thu, 31 Jan 2019 21:47:20 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: RE: Getting weird TPM error after rebasing my tree to
 security/next-general
Thread-Topic: Getting weird TPM error after rebasing my tree to
 security/next-general
Thread-Index: AQHUuWAtuzjHOvmUw0aX3ymhUWghKaXJaQyAgAARKoCAABj/gIAABFeAgAAAYICAAAUEAIAAKBgw
Date:   Thu, 31 Jan 2019 19:47:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA8DA75@hasmsx108.ger.corp.intel.com>
References: <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
 <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
In-Reply-To: <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjAzYWIzZTUtZGNjOC00ZDg3LTkzNmUtYzNjZDJiOGE5MzU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOTBqK2tPbytadFVHVlB0U3ZwbWdTOWNPUGtpSW0rN3NkcE9lcWg2WG5GTkFZQlY3VVFIbFlTZUVSZ0lDRXpxRSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.254.159.176]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAxMDo1MiBBTSBMaW51cyBUb3J2YWxkcyA8
dG9ydmFsZHNAbGludXgtDQo+IGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IEkgdGhp
bmsgd2hhdCBJIHNob3VsZCBkbyBpcyB0byBqdXN0IG1ha2UgIm1lbWNweV8qaW8oKSIgZG8gdGhl
ICJhbGlnbg0KPiA+IG5hdHVyYWxseSIgdGhpbmcuDQo+ID4NCj4gPiBMZXQgbWUgY29vayB1cCBh
IHBhdGNoIGZvciB5b3UgdG8gdGVzdC4NCj4gDQo+IERvZXMgdGhpcyB3b3JrIGZvciB5b3U/DQo+
IA0KPiBJIGhhdmVuJ3QgdGVzdGVkIGl0IGF0IGFsbCwgYnV0IEkgdmVyaWZpZWQgdGhhdCB0aGUg
Z2VuZXJhdGVkIGNvZGUgc2VlbXMgdG8gbWFrZQ0KPiBhdCBsZWFzdCBzb21lIGFtb3VudCBvZiBz
ZW5zZS4NCj4gDQo+ICAgICAgICAgICAgICAgIExpbnVzDQoNClNvIGRpZyBpbnRvIHRoZSBzcGVj
IGFuZCBJIHRoaW5rIHRoaXMgaXMgYSBiaXQgcmVsZXZhbnQuIA0KDQpUUE0gVENHIGFjY29yZGlu
ZyB0aGUgc3BlYyByZXF1aXJlcyB0aGF0IGFsbCBidWZmZXIgYWNjZXNzIGlzIGRvbmUgc2VxdWVu
dGlhbGx5IGZyb20gdGhlIHN0YXJ0IHRvIGVuZCBvZiB0aGUgcGF5bG9hZCwgDQpTaW1wbHkgSW4g
Y2FzZSBvZiBza2lwcGluZyBvciBnb2luZyBiYWNrIHRoZSB0cmFuc2FjdGlvbiBpcyBhYm9ydGVk
LiANClRoZSB3cml0ZSB0cmFuc2FjdGlvbnMgc2hvdWxkIGJlIDEgb3IgcG93ZXIgb2YgMi4gU28g
aW4gZ2VuZXJhbCA2IGJ5dGUgcmVhZCBzaG91bGQgbm90IHdvcmsuIEJ1dCBJJ20gc3VyZSBvdXIg
aHcgcmVhbGx5IG9iZXkgdGhpcyByZXN0cmljdGlvbi4NCg0KVGhhbmtzDQpUb21hcyANCg==
