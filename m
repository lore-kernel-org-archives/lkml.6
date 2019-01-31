Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114F920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfAaUHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:07:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:38537 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfAaUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:07:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="296282719"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2019 12:07:08 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 31 Jan 2019 12:07:08 -0800
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 31 Jan 2019 12:07:07 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.55]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.16]) with mapi id 14.03.0415.000;
 Thu, 31 Jan 2019 22:07:05 +0200
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
Thread-Index: AQHUuWAtuzjHOvmUw0aX3ymhUWghKaXJaQyAgAARKoCAABj/gIAABFeAgAAAYICAAAUEAIAAKBgwgAAIYLA=
Date:   Thu, 31 Jan 2019 20:07:04 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA8DA90@hasmsx108.ger.corp.intel.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2lua2xlciwgVG9tYXMN
Cj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMzEsIDIwMTkgMjE6NDcNCj4gVG86ICdMaW51cyBU
b3J2YWxkcycgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgSmFya2tvIFNha2tpbmVu
DQo+IDxqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogSmFzb24gR3VudGhv
cnBlIDxqZ2dAemllcGUuY2E+OyBKYW1lcyBCb3R0b21sZXkNCj4gPEphbWVzLkJvdHRvbWxleUBo
YW5zZW5wYXJ0bmVyc2hpcC5jb20+OyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnOyBMaW51eCBMaXN0IEtlcm5l
bCBNYWlsaW5nIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDog
UkU6IEdldHRpbmcgd2VpcmQgVFBNIGVycm9yIGFmdGVyIHJlYmFzaW5nIG15IHRyZWUgdG8gc2Vj
dXJpdHkvbmV4dC0NCj4gZ2VuZXJhbA0KPiANCj4gDQo+ID4NCj4gPiBPbiBUaHUsIEphbiAzMSwg
MjAxOSBhdCAxMDo1MiBBTSBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtDQo+ID4gZm91
bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgd2hhdCBJIHNob3VsZCBk
byBpcyB0byBqdXN0IG1ha2UgIm1lbWNweV8qaW8oKSIgZG8gdGhlDQo+ID4gPiAiYWxpZ24gbmF0
dXJhbGx5IiB0aGluZy4NCj4gPiA+DQo+ID4gPiBMZXQgbWUgY29vayB1cCBhIHBhdGNoIGZvciB5
b3UgdG8gdGVzdC4NCj4gPg0KPiA+IERvZXMgdGhpcyB3b3JrIGZvciB5b3U/DQo+ID4NCj4gPiBJ
IGhhdmVuJ3QgdGVzdGVkIGl0IGF0IGFsbCwgYnV0IEkgdmVyaWZpZWQgdGhhdCB0aGUgZ2VuZXJh
dGVkIGNvZGUNCj4gPiBzZWVtcyB0byBtYWtlIGF0IGxlYXN0IHNvbWUgYW1vdW50IG9mIHNlbnNl
Lg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgTGludXMNCj4gDQo+IFNvIGRpZyBpbnRvIHRoZSBz
cGVjIGFuZCBJIHRoaW5rIHRoaXMgaXMgYSBiaXQgcmVsZXZhbnQuDQo+IA0KPiBUUE0gVENHIGFj
Y29yZGluZyB0aGUgc3BlYyByZXF1aXJlcyB0aGF0IGFsbCBidWZmZXIgYWNjZXNzIGlzIGRvbmUg
c2VxdWVudGlhbGx5DQo+IGZyb20gdGhlIHN0YXJ0IHRvIGVuZCBvZiB0aGUgcGF5bG9hZCwgU2lt
cGx5IEluIGNhc2Ugb2Ygc2tpcHBpbmcgb3IgZ29pbmcgYmFjaw0KPiB0aGUgdHJhbnNhY3Rpb24g
aXMgYWJvcnRlZC4NCj4gVGhlIHdyaXRlIHRyYW5zYWN0aW9ucyBzaG91bGQgYmUgMSBvciBwb3dl
ciBvZiAyLiBTbyBpbiBnZW5lcmFsIDYgYnl0ZSByZWFkDQo+IHNob3VsZCBub3Qgd29yay4gQnV0
IEknbSBzdXJlIG91ciBodyByZWFsbHkgb2JleSB0aGlzIHJlc3RyaWN0aW9uLg0KDQpGb3IgYWxp
Z25tZW50IG9mIHJlZ2lzdGVyIGFjY2VzcyB0aGUgc3BlYyBzcGVjaWZpZXM6DQoNClNvbWUgaW5z
dGFudGlhdGluZyBoYXJkd2FyZSBtYXkgaGF2ZSBzaXplIGFuZCBhbGlnbm1lbnQgcmVzdHJpY3Rp
b25zIHdoZW4gYWNjZXNzaW5nIGFueSBvZiB0aGUgZmllbGRzIGluIHRoaXMgaW50ZXJmYWNlLiBT
b21lIGhhcmR3YXJlIG1heSByZXF1aXJlIGFjY2VzcyB0byBhbnkgb2YgZGF0YSB3aXRoaW4gYSBm
aWVsZCBvciBidWZmZXIgYmUgcGVyZm9ybWVkIGJ5IHJlYWRzIG9yIHdyaXRlcyB3aGljaCBhcmUg
bmF0dXJhbGx5IGFsaWduZWQuIEZvciB0aGlzIHJlYXNvbiwgc29mdHdhcmUgc2hvdWxkIGFjY2Vz
cyB0aGUgZmllbGRzIGFuZCBidWZmZXJzIGRlZmluZWQgaW4gdGhpcyBpbnRlcmZhY2UgdXNpbmcg
aW5zdHJ1Y3Rpb25zIHdoaWNoIGRvIG5vdCBjYXVzZSBhbiBhY2Nlc3MgdG8gY3Jvc3MgYW4gYWxp
Z25tZW50IGJvdW5kYXJ5IGFuZCBzaG91bGQgbm90IHVzZSBzdHJpbmcgbW92ZSBpbnN0cnVjdGlv
bnMNCg0KVGhpcyBpcyBmb3IgcmVnaXN0ZXIgYWRkcmVzcywgSSdtIG5vdCBzdXJlIHRoaXMgc3Bh
bnMgYWxzbyBmb3IgcmVxdWVzdCByZXNwb25zZSBidWZmZXIsIGJ1dCBmcm9tIHRoZSBiZWhhdmlv
ciBsb29rcyBsaWtlIGl0IGFwcGxpZXMgdGhlcmUgdHdvLg0KDQogDQpUaGFua3MNClRvbWFzDQo=
