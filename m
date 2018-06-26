Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8159B26B5E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8159B26B5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFZQV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:21:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:44157 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbeFZQV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:21:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 09:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="60317244"
Received: from kmsmsx155.gar.corp.intel.com ([172.21.73.106])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2018 09:21:24 -0700
Received: from pgsmsx111.gar.corp.intel.com ([169.254.2.7]) by
 KMSMSX155.gar.corp.intel.com ([169.254.15.164]) with mapi id 14.03.0319.002;
 Wed, 27 Jun 2018 00:21:23 +0800
From:   "Yeh, Andy" <andy.yeh@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "Chiang, AlanX" <alanx.chiang@intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Add a property in at24.c
Thread-Topic: [PATCH v2 0/2] Add a property in at24.c
Thread-Index: AQHUDRYjtzqZh4hexEe0TZs+N0CMt6RxoeQAgABMRgCAAAYIgIAADTsAgAAB/4CAACZvgIAAjp8A
Date:   Tue, 26 Jun 2018 16:21:21 +0000
Deferred-Delivery: Tue, 26 Jun 2018 16:20:44 +0000
Message-ID: <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
         <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
         <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
         <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
         <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
 <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
In-Reply-To: <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWQ5ZjFhMDAtMzkzMS00NDE4LTkzZDYtNjM1M2E5YWYwODAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkNIMjR4R0FhNnN1cndVWmJxVVlDSXExR0RrZFgzSWs0SytjWFZReE1nN0h3OVhGNm9PaDdNXC8xMGRNQlc4VU4ifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjYsIDIwMTggMTE6NDggUE0NCj4gVG86IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xA
YmdkZXYucGw+DQo+IENjOiBDaGlhbmcsIEFsYW5YIDxhbGFueC5jaGlhbmdAaW50ZWwuY29tPjsg
bGludXgtaTJjIDxsaW51eC0NCj4gaTJjQHZnZXIua2VybmVsLm9yZz47IFllaCwgQW5keSA8YW5k
eS55ZWhAaW50ZWwuY29tPjsgU2FrYXJpIEFpbHVzDQo+IDxzYWthcmkuYWlsdXNAbGludXguaW50
ZWwuY29tPjsgTWFuaSwgUmFqbW9oYW4gPHJham1vaGFuLm1hbmlAaW50ZWwuY29tPjsNCj4gQW5k
eSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcNCj4g
PHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+
OyBBcm5kDQo+IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3Qg
PGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDAvMl0gQWRkIGEgcHJvcGVydHkgaW4gYXQyNC5jDQo+IA0KPiBPbiBUdWUsIDIwMTgtMDYt
MjYgYXQgMTU6MzAgKzAyMDAsIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6DQo+ID4gMjAxOC0w
Ni0yNiAxNToyMyBHTVQrMDI6MDAgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbg0KPiA+IHRlbC5jb20+Og0KPiA+ID4gT24gVHVlLCAyMDE4LTA2LTI2IGF0IDE0
OjM2ICswMjAwLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOg0KPiA+ID4gPiAyMDE4LTA2LTI2
IDE0OjE0IEdNVCswMjowMCBBbmR5IFNoZXZjaGVua28NCj4gPiA+ID4gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT46DQo+ID4gPiA+ID4gT24gVHVlLCAyMDE4LTA2LTI2IGF0IDA5
OjQxICswMjAwLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOg0KPiA+ID4gPiA+ID4gV2hhdCBp
cyB5b3VyIHVzZSBjYXNlIGV4YWN0bHk/IERvIHlvdSBoYXZlIGFuIEVFUFJPTSBtb2RlbA0KPiA+
ID4gPiA+ID4gdGhhdCdzIG5vdCB5ZXQgc3VwcG9ydGVkIGV4cGxpY2l0bHkgaW4gdGhlIGRyaXZl
cj8gV2h5IHdvdWxkDQo+ID4gPiA+ID4gPiB5b3UgbmVlZCB0aGlzIG9wdGlvbj8NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IFRoZSBjdXJyZW50IGF0MjQgZHJpdmVyIGhhcyBubyBhZGRyZXNzIHdpZHRo
IHN1cHBvcnQsICB0aHVzLA0KPiA+ID4gPiA+IHJldXNpbmcgc2FtZQ0KPiA+ID4gPiA+IChhbGxv
Y2F0ZWQpIElEcyAobm9uLURUIGNhc2UpIGlzIGhhcmQuDQo+ID4gPg0KPiA+ID4gXl5eXl4NCj4g
PiA+DQo+ID4gPiA+IEV2ZXJ5IHN1cHBvcnRlZCBjb21wYXRpYmxlIGhhcyB0aGUgd2lkdGggYWxy
ZWFkeSBzcGVjaWZpZWQgaW4gaXRzDQo+ID4gPiA+IGNvcnJlc3BvbmRpbmcgY2hpcCBkYXRhLg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiBQbGVhc2UsIHJlYWQgYWdhaW4gY2FyZWZ1bGx5IHdoYXQgSSB3
cm90ZSBiZWZvcmUuDQo+ID4gPg0KPiA+DQo+ID4gT2sgbWFrZXMgc2Vuc2UgaW4gdGhhdCBjYXNl
LiBDb3VsZCB5b3UganVzdCBwb2ludCBtZSB0b3dhcmRzIGFuDQo+ID4gZXhhbXBsZSBtb2RlbCB3
aGljaCBoYXMgdGhlIGFkZHJlc3Mgd2lkdGggZGlmZmVyZW50IHRoYW4gdGhlIGRlZmF1bHQNCj4g
PiBmb3IgaXRzIHR5cGU/DQo+IA0KPiBBRkFJSywgaXQncyBhIGNvbXBhbmlvbiBkZXZpY2UgaW5z
aWRlIHRoZSBjYW1lcmEgdm9pY2UgY29pbCBJQywgaS5lLg0KPiBET05HV09PTiBEVzk3MTQuDQo+
IA0KDQpOb3BlLCBhY3R1YWxseSBpdCBpcyBEVzk4MDcgaW5zdGVhZCwgd2hpY2ggaXMgdXNlZCBv
biBhIFNhbXN1bmcgQ2hyb21lYm9vay4NCg0KPiAtLQ0KPiBBbmR5IFNoZXZjaGVua28gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gSW50ZWwgRmlubGFuZCBPeQ0K
