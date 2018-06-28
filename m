Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7C22510
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F7C22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967345AbeF1WOQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:14:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:61026 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966165AbeF1WOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:14:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 15:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="70844496"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2018 15:13:56 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 28 Jun 2018 15:13:55 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.150]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.202]) with mapi id 14.03.0319.002;
 Thu, 28 Jun 2018 15:13:55 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?utf-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: small dmesg regression in kernel 4.17.3
Thread-Topic: small dmesg regression in kernel 4.17.3
Thread-Index: AQHUDXdECkakmC0QWk2YYx3JQkkCHqR00vWAgAFqwbA=
Date:   Thu, 28 Jun 2018 22:13:54 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
 <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
In-Reply-To: <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjk2MWJiZGQtY2QxNC00ZGRmLTlkYWYtMWYwOTY0MmUzZTVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2pPNUREdHRMWjZzd3ROVUlXZWJZbmdHU0doN051aEFyZjFRbXlrUk4zdjFmazB6TklQckRsM0Q4anphVE9oMiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IFttYWlsdG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBK
dW5lIDI3LCAyMDE4IDEwOjI5IEFNDQo+IFRvOiBUb3JhbGYgRsO2cnN0ZXIgPHRvcmFsZi5mb2Vy
c3RlckBnbXguZGU+OyBTY2htYXVzcywgRXJpaw0KPiA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+
DQo+IENjOiBBQ1BJIERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IEtlcm5lbCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBzbWFsbCBkbWVzZyByZWdyZXNzaW9uIGluIGtlcm5lbCA0LjE3LjMNCj4gDQo+
ICtDYzogRXJpaw0KPiANCj4gT24gVHVlLCBKdW4gMjYsIDIwMTggYXQgODo1NyBQTSwgVG9yYWxm
IEbDtnJzdGVyIDx0b3JhbGYuZm9lcnN0ZXJAZ214LmRlPg0KPiB3cm90ZToNCj4gPiBUaGUgYXR0
YWNoZWQgZG1lc2cgY29udGFpbnMgbm9uIHByaW50YWJsZSBjaGFycyAweDAxIDMzIGFyb3VuZCAi
QUNQSQ0KPiA+IEJJT1MgRXJyb3IgKGJ1Zyk6IENvdWxkIG5vdCByZXNvbHZlIiB3aGljaCBpcyBh
IG5ldyBpc3N1ZSBjb21wYXJlZCB0bw0KPiA+IHRoZSBkbWVzZyBvZiA0LjE3LjINCj4gPg0KPiA+
IFN5c3RlbSBpcyBhIHN0YWJsZSBoYXJkZW5lZCBHZW50b28gTGludXggYXQgYSBUaGlua1BhZCBU
NDQwcy4NCj4gDQo+IEkgYmV0IHRoZSBiZWxvdyBjb21taXQgbWFrZXMgdGhpcy4NCj4gDQo+IGNv
bW1pdCAyZTc4OTM1ZDFlMjdkMzE5NTVhZDJkYWQ0YWJlNmM0NTNjZjY2OWZkDQo+IEF1dGhvcjog
RXJpayBTY2htYXVzcyA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+DQo+IERhdGU6ICAgRnJpIEp1
biAxIDEyOjA2OjQzIDIwMTggLTA3MDANCj4gDQo+ICAgIEFDUElDQTogQU1MIHBhcnNlcjogYXR0
ZW1wdCB0byBjb250aW51ZSBsb2FkaW5nIHRhYmxlIGFmdGVyIGVycm9yDQo+IA0KPiANCkhpIEFu
ZHksDQoNCj4gU28sIGl0IGRvZXMgYWRkIGxlYWRpbmcgJ1xuJyB3aGljaCBmbHVzaGVzIGJ1ZmZl
cnMgZm9sbG93ZWQgYnkgcHJpbnRpbmcgdGhlDQo+IG1lc3NhZ2UgeW91IHNlZS4gQnV0LCBJJ20g
Z3Vlc3Npbmcgbm93LCBrZXJuZWwgYWRkcyBhIGRlZmF1bHQgbGV2ZWwgc2luY2UgaXQncw0KPiBn
b2luZyB0byBkbWVzZyB3aGljaCB5b3UgY2FuIHNlZSBhcyB1bnByaW50YWJsZSBzeW1ib2xzLg0K
DQpXaGF0IGRvIHlvdSBtZWFuIGJ5IGEgZGVmYXVsdCBsZXZlbD8NCg0KPiBQZXJzb25hbGx5IEkn
bSBub3QgYSBmYW4gb2YgbGVhZGluZyAnXG4nOnMgc2luY2UgaXQgYnJpbmdzIG1vcmUgcGFpbiB0
aGFuIGZpeGluZw0KPiBzb21ldGhpbmcuIEl0IGhhcyBzcGVjaWFsIG1lYW5pbmcgKGZsdXNoaW5n
IGJ1ZmZlcnMpIGFuZCBtYW55IGRldmVsb3BlcnMgZm9yZ2V0DQo+IHRoaXMuDQoNClRoaXMgbGVh
ZGluZyAnXG4nIG1hZGUgaXQgaW4gTGludXgga2VybmVsIHVuaW50ZW50aW9uYWxseS4gSXQgd2Fz
IG9yaWdpbmFsbHkgaW50ZW5kZWQgYXMgYSBjaGFuZ2UgZm9yIGFjcGlleGVjIGFuZCBpdCBtYWtl
cyB0aGUgZG1lc2cgbG9vayBzdHJhbmdlLiBJJ2xsIHNlbmQgb3V0IGEgZml4Lg0KDQpUaGFua3Mg
Zm9yIHJlcG9ydGluZyBpdCwNCg0KRXJpaw0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMs
DQo+IEFuZHkgU2hldmNoZW5rbw0K
