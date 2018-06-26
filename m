Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A086626CDF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A086626CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeFZQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:32:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:24565 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbeFZQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:32:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 09:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="53059056"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 09:31:59 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 26 Jun 2018 09:31:59 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.182]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.60]) with mapi id 14.03.0319.002;
 Tue, 26 Jun 2018 09:31:59 -0700
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     "Yeh, Andy" <andy.yeh@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "Chiang, AlanX" <alanx.chiang@intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Add a property in at24.c
Thread-Topic: [PATCH v2 0/2] Add a property in at24.c
Thread-Index: AQHUDRYXMnb142b64kG/kM3W+BoTU6RynVkAgABMRgCAAAYIgIAADTsAgAAB/4CAACZwgIAACUuA//+MfdA=
Date:   Tue, 26 Jun 2018 16:31:58 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59813CA31B@fmsmsx124.amr.corp.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
         <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
         <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
         <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
         <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
 <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
 <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
In-Reply-To: <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWQ5ZjFhMDAtMzkzMS00NDE4LTkzZDYtNjM1M2E5YWYwODAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkNIMjR4R0FhNnN1cndVWmJxVVlDSXExR0RrZFgzSWs0SytjWFZReE1nN0h3OVhGNm9PaDdNXC8xMGRNQlc4VU4ifQ==
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydG9zeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZZWgs
IEFuZHkNCj4gU2VudDogVHVlc2RheSwgSnVuZSAyNiwgMjAxOCA5OjIxIEFNDQo+IFRvOiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IEJhcnRvc3oN
Cj4gR29sYXN6ZXdza2kgPGJyZ2xAYmdkZXYucGw+DQo+IENjOiBDaGlhbmcsIEFsYW5YIDxhbGFu
eC5jaGlhbmdAaW50ZWwuY29tPjsgbGludXgtaTJjIDxsaW51eC0NCj4gaTJjQHZnZXIua2VybmVs
Lm9yZz47IFNha2FyaSBBaWx1cyA8c2FrYXJpLmFpbHVzQGxpbnV4LmludGVsLmNvbT47IE1hbmks
DQo+IFJham1vaGFuIDxyYWptb2hhbi5tYW5pQGludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbw0K
PiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBNYXJrDQo+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQXJuZCBCZXJn
bWFubiA8YXJuZEBhcm5kYi5kZT47IEdyZWcNCj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDAvMl0gQWRkIGEg
cHJvcGVydHkgaW4gYXQyNC5jDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIFttYWlsdG86YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjYsIDIwMTggMTE6NDggUE0NCj4g
PiBUbzogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gPiBDYzogQ2hpYW5n
LCBBbGFuWCA8YWxhbnguY2hpYW5nQGludGVsLmNvbT47IGxpbnV4LWkyYyA8bGludXgtDQo+ID4g
aTJjQHZnZXIua2VybmVsLm9yZz47IFllaCwgQW5keSA8YW5keS55ZWhAaW50ZWwuY29tPjsgU2Fr
YXJpIEFpbHVzDQo+ID4gPHNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5jb20+OyBNYW5pLCBSYWpt
b2hhbg0KPiA+IDxyYWptb2hhbi5tYW5pQGludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA+
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVs
Lm9yZz47IE1hcmsNCj4gPiBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+OyBHcmVnDQo+ID4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+ID4gPGxpbnV4
LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC8y
XSBBZGQgYSBwcm9wZXJ0eSBpbiBhdDI0LmMNCj4gPg0KPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBh
dCAxNTozMCArMDIwMCwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gPiA+IDIwMTgtMDYt
MjYgMTU6MjMgR01UKzAyOjAwIEFuZHkgU2hldmNoZW5rbw0KPiA+IDxhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbg0KPiA+ID4gdGVsLmNvbT46DQo+ID4gPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBh
dCAxNDozNiArMDIwMCwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gPiA+ID4gPiAyMDE4
LTA2LTI2IDE0OjE0IEdNVCswMjowMCBBbmR5IFNoZXZjaGVua28NCj4gPiA+ID4gPiA8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjoNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAxOC0w
Ni0yNiBhdCAwOTo0MSArMDIwMCwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gV2hhdCBpcyB5b3VyIHVzZSBjYXNlIGV4YWN0bHk/IERvIHlvdSBoYXZlIGFuIEVFUFJP
TSBtb2RlbA0KPiA+ID4gPiA+ID4gPiB0aGF0J3Mgbm90IHlldCBzdXBwb3J0ZWQgZXhwbGljaXRs
eSBpbiB0aGUgZHJpdmVyPyBXaHkgd291bGQNCj4gPiA+ID4gPiA+ID4geW91IG5lZWQgdGhpcyBv
cHRpb24/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIGN1cnJlbnQgYXQyNCBkcml2ZXIg
aGFzIG5vIGFkZHJlc3Mgd2lkdGggc3VwcG9ydCwgIHRodXMsDQo+ID4gPiA+ID4gPiByZXVzaW5n
IHNhbWUNCj4gPiA+ID4gPiA+IChhbGxvY2F0ZWQpIElEcyAobm9uLURUIGNhc2UpIGlzIGhhcmQu
DQo+ID4gPiA+DQo+ID4gPiA+IF5eXl5eDQo+ID4gPiA+DQo+ID4gPiA+ID4gRXZlcnkgc3VwcG9y
dGVkIGNvbXBhdGlibGUgaGFzIHRoZSB3aWR0aCBhbHJlYWR5IHNwZWNpZmllZCBpbg0KPiA+ID4g
PiA+IGl0cyBjb3JyZXNwb25kaW5nIGNoaXAgZGF0YS4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gUGxlYXNlLCByZWFkIGFnYWluIGNhcmVmdWxseSB3aGF0IEkgd3JvdGUgYmVmb3JlLg0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IE9rIG1ha2VzIHNlbnNlIGluIHRoYXQgY2FzZS4gQ291bGQgeW91
IGp1c3QgcG9pbnQgbWUgdG93YXJkcyBhbg0KPiA+ID4gZXhhbXBsZSBtb2RlbCB3aGljaCBoYXMg
dGhlIGFkZHJlc3Mgd2lkdGggZGlmZmVyZW50IHRoYW4gdGhlIGRlZmF1bHQNCj4gPiA+IGZvciBp
dHMgdHlwZT8NCj4gPg0KPiA+IEFGQUlLLCBpdCdzIGEgY29tcGFuaW9uIGRldmljZSBpbnNpZGUg
dGhlIGNhbWVyYSB2b2ljZSBjb2lsIElDLCBpLmUuDQo+ID4gRE9OR1dPT04gRFc5NzE0Lg0KPiA+
DQo+IA0KPiBOb3BlLCBhY3R1YWxseSBpdCBpcyBEVzk4MDcgaW5zdGVhZCwgd2hpY2ggaXMgdXNl
ZCBvbiBhIFNhbXN1bmcgQ2hyb21lYm9vay4NCg0KTTI0QzY0UyBpcyBvbmUgZXhhbXBsZSwgd2hl
cmUgcmV1c2luZyBzYW1lIGlkIChub24tRFQgY2FzZSkgaXMgbm90IHBvc3NpYmxlLA0Kc2luY2Ug
dGhpcyBtb2RlbCB1c2VzIDE2IGJpdHMgYXMgYWRkcmVzcyB3aWR0aCwgYXMgdGhlIGRyaXZlciBz
dXBwb3J0cyBvbmx5DQo4IGJpdHMgYWRkcmVzcyB3aWR0aCBhcyBkZWZhdWx0Lg0KDQpUaGFua3MN
ClJhag0K
