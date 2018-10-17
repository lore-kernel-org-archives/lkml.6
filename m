Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69489ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F7214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F7214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJQSp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:45:58 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:61029 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbeJQSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:45:57 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 14/27-08839-60417CB5; Wed, 17 Oct 2018 10:50:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG/XYuO4qT45zsU1JqUJh1psvME2G
  GBC2i0qCohPRMT260HW2XUusP04qcFhpdbKkzcl00kEpJh4bzUmmFUGJiF7ylqGXCIssy2vGk
  2X8/3ud5v+f54CUQaREeTLBZZtbIMXoF7oO6prd3UJjsaVJk9/l19MxApZiucIfQ9p5ejC6/f
  hHQo/3NItrhqkXpiTYnoF87y3Dafb4d0PXjUyJ6+M5nMT0yeAHf4qsueUmpG23vxeqbTeMi9b
  veJlzd2nYOqCs6E9XfXpSgaveD0ATiIKbjNBlZKZh2pliT+Ss8qyOvBcsFdeFW4ENIyVsAljf
  YMSvwJnBSBSs+fQFWQBAykoJlP0S8ByGdKLQ+a0Z5TwB5CJ5uHRDxLCOT4ZSjERc4Hs5ND857
  UHIlHGq+Ms8SMgFO5pZiQtgsgN1PHiK84E0mwrF7nWKeARkCv56qmZ8jpBz2j9jnAyBJwqqmb
  kTgQDg+/BsTeDl8PHsXFzgOTn6YQgWOgEPDQ0BgFay+0vJ3HgOv3R0T8x9DyNWw1hkhRK2Alw
  oHxUJPf9h5bQQtBnLbkha2fxu2JRu2JRuVAK0GtMaoS9eaDYxOT6kiIymVKoqKptZvUDI5lEb
  JWqhUljMbGY+oZI6blKZsQ6o+Tcmx5gfAcxNpRzFlA7DdTm8FQYRIESi5+v1JktRPk5GWrWVM
  2mSjRc+aWsEyglBASZH0aZLU38ims1mHdXrPYS3IkPBVyCQWXpaYMhmDSZcuSF0giuh5UVCKE
  Gc/vilFpCiXwbHBcslb3kryVq2FW3xo4UhfgZDgAAnw8vKS+mayRoPO/L8+AeQEUARISvhXfH
  WceTFvwlNF5KmyLbadr2Jm/knBuYDwzx/dFNcXX1+5anzMr6sTW9P1atvmrUGuvSfwRnBgbex
  G576+/Hc72h05IWFUZHIUUv8an3XoU87Ehyb/pAp3TgUOxPgUVe2pdOUUR/S83X/PXpdnvyxr
  cTx/FPq8YKzhSIooqSZa5Q67n2iw3K6/kcNVOXfJjyFzta52x+6TCtSkZVThiNHE/AE2R0pEn
  wMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-11.tower-239.messagelabs.com!1539773445!308654!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10024 invoked from network); 17 Oct 2018 10:50:45 -0000
Received: from unknown (HELO sw-ex-cashub02.diasemi.com) (193.240.73.197)
  by server-11.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 17 Oct 2018 10:50:45 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.108]) by
 sw-ex-cashub02.diasemi.com ([10.20.16.142]) with mapi id 14.03.0382.000; Wed,
 17 Oct 2018 11:50:45 +0100
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Linux PM list" <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access
 during system suspend
Thread-Topic: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access
 during system suspend
Thread-Index: AQHUYhXnLkN7Q/V/6kGq9xgKC5zdxKUjJhXg///4kwCAABKUQA==
Date:   Wed, 17 Oct 2018 10:50:44 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C4CD09D@SW-EX-MBX02.diasemi.com>
References: <20181012072017.10765-1-geert+renesas@glider.be>
 <20181012072017.10765-4-geert+renesas@glider.be>
 <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
 <CAMuHMdWEzDenwgT8gkK7+_rEyjeVBCKrLaML5sMRkiZkzJN8jg@mail.gmail.com>
In-Reply-To: <CAMuHMdWEzDenwgT8gkK7+_rEyjeVBCKrLaML5sMRkiZkzJN8jg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 17/10/2018 08:22:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDE3IE9jdG9iZXIgMjAxOCAxMDoxNCBHZWVydCBVeXR0ZXJob2V2ZW4g
d3JvdGU6DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIHRoZXJtYWw6IGRhOTA2Mi82
MTogUHJldmVudCBoYXJkd2FyZSBhY2Nlc3MgZHVyaW5nDQo+IHN5c3RlbSBzdXNwZW5kDQo+IA0K
PiBIaSBTdGV2ZSwNCj4gDQo+IE9uIFdlZCwgT2N0IDE3LCAyMDE4IGF0IDEwOjU3IEFNIFN0ZXZl
IFR3aXNzIHdyb3RlOg0KPiA+IE9uIDEyIE9jdG9iZXIgMjAxOCAwODoyMCBHZWVydCBVeXR0ZXJo
b2V2ZW4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMy8zXSB0aGVybWFsOiBkYTkw
NjIvNjE6IFByZXZlbnQgaGFyZHdhcmUgYWNjZXNzIGR1cmluZw0KPiA+ID4gc3lzdGVtIHN1c3Bl
bmQNCj4gPiA+DQo+ID4gPiBUaGUgd29ya3F1ZXVlIHVzZWQgZm9yIG1vbml0b3JpbmcgdGhlIGhh
cmR3YXJlIG1heSBydW4gd2hpbGUgdGhlIGRldmljZQ0KPiA+ID4gaXMgYWxyZWFkeSBzdXNwZW5k
ZWQuICBGaXggdGhpcyBieSB1c2luZyB0aGUgZnJlZXphYmxlIHN5c3RlbSB3b3JrcXVldWUNCj4g
PiA+IGluc3RlYWQsIGNmci4gY29tbWl0IDUxZTIwZDBlM2E2MGNmNDYgKCJ0aGVybWFsOiBQcmV2
ZW50IHBvbGxpbmcgZnJvbQ0KPiA+ID4gaGFwcGVuaW5nIGR1cmluZyBzeXN0ZW0gc3VzcGVuZCIp
Lg0KPiA+DQo+ID4gTXkgdGhpbmtpbmcgd2FzOiAgdGhpcyBkZXZpY2UgaXMgYSBQTUlDIGFuZCBp
dCB3aWxsIHBvd2VyIHRoZSBzeXN0ZW0uIFNvIHdoZW4NCj4gPiB0aGUgZGV2aWNlIGlzIHR1cm5l
ZCBvZmYsIHRoZSBTL1cgd2lsbCBhbHNvIG5vdCBiZSBydW5uaW5nLg0KPiA+DQo+ID4gQWx0aG91
Z2ggbXkgYXNzdW1wdGlvbiBvbmx5IHdvcmtzIGlmIHRoZSBQTUlDIGRldmljZSBpcyB0aGUgcHJp
bWFyeSBzeXN0ZW0NCj4gPiBwb3dlciAtLSB0aGlzIGhhcyBhbHdheXMgYmVlbiB0aGUgY2FzZSBz
byBmYXIuIEFuZCBhbHRob3VnaCBJIGRvbid0IGhhdmUgYW55DQo+ID4gZXZpZGVuY2UgdGhpcyB3
aWxsIGNoYW5nZSwgaXQgbWF5IGJlY29tZSB1bnRydWUgaW4gdGhlIGZ1dHVyZSBvZiBjb3Vyc2Uu
DQo+IA0KPiBUaGlzIGlzIG5vdCBhYm91dCBwb3dlcmluZyBvZmYgdGhlIHN5c3RlbSwgYnV0IGFi
b3V0IHN1c3BlbmRpbmcgdGhlIHN5c3RlbSwNCj4gd2hpY2ggc3VzcGVuZHMgYWxsIGRyaXZlcnMu
DQo+IA0KPiBUaGUgaXNzdWUgaXMgdGhhdCB0aGUgbm9ybWFsIHdvcmtxdWV1ZSBtYXkgcnVuIHdo
aWxlIHRoZSBzeXN0ZW0gaXMgYmVpbmcNCj4gc3VzcGVuZGVkLiAgQWNjZXNzaW5nIHRoZSBEQTkw
NjIgbWF5IG9yIG1heSBub3Qgd29yayBhdCB0aGF0IHRpbWUsDQo+IGRlcGVuZGluZyBvbiB0aGUg
aTJjIGNvbnRyb2xsZXIgYmVpbmcgdXNhYmxlIG9yIG5vdC4NCg0KSSBzZWUgbm93LiBZZXMuDQoN
Cj4gDQo+IER1ZSB0byB0aGUgREE5MDYyIGJlaW5nIGFuIGkyYyBkZXZpY2UsIEkgYWdyZWUgdGhp
cyBpcyBkaWZmZXJlbnQgdGhhbg0KPiBmb3IgcmNhci10aGVybWFsLCB3aGVyZSB0aGUgcmNhci10
aGVybWFsIGRldmljZSBpdHNlbGYgY2Fubm90IGJlDQo+IGFjY2Vzc2VkIGJlY2F1c2UgaXQgaXMg
c3VzcGVuZGVkLg0KPiANCj4gPiA+IEZpeGVzOiA2MDg1NjdhYWMzMjA2YWU4ICgidGhlcm1hbDog
ZGE5MDYyLzYxOiBUaGVybWFsIGp1bmN0aW9uIHRlbXBlcmF0dXJlDQo+ID4gPiBtb25pdG9yaW5n
IGRyaXZlciIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4gLS0tDQo+ID4gPiBVbnRlc3RlZCBkdWUgdG8gbGFj
ayBvZiBoYXJkd2FyZS4NCj4gPg0KPiA+IFNvLCBJIGhhdmUgbm90IGJlZW4gYWJsZSB0byBtYWtl
IGFueSB0aW1lIHRvIHRlc3QgdGhpcyBwYXRjaCB5ZXQgLS0gYW5kIHdpdGgNCj4gPiBjdXJyZW50
IHdvcmtsb2FkcyB0aGlzIG1pZ2h0IHRha2UgYSBiaXQgb2YgdGltZSBiZWZvcmUgSSBnZXQgdG8g
aXQuDQo+IA0KPiBUaGUgbWFpbiB0aGluZyB0byB0ZXN0IGlzIHdoYXQgaGFwcGVucyB3aGVuIGRh
OTA2Ml90aGVybWFsX3BvbGxfb24oKSBpcw0KPiBjYWxsZWQgd2hpbGUgdGhlIGkyYyBjb250cm9s
bGVyIGlzIGFscmVhZHkgc3VzcGVuZGVkLCBhbmQgd2hldGhlciB0aGF0DQo+IGlzIG1pdGlnYXRl
ZCBieSBteSBwYXRjaC4NCj4gTG9va2luZyBhdCB0aGUgZnVuY3Rpb24sIEkgZ3Vlc3MgaXQgc3Rh
cnRzIHNwZXdpbmcgZXJyb3IgbWVzc2FnZXMsIGFuZA0KPiB3aWxsIGNvbnRpbnVlIHRyaWdnZXJp
bmcgaXRzZWxmLCBieSB2aXJ0dWUgb2YgZW5hYmxpbmcgdGhlIGludGVycnVwdCBhZ2FpbiwNCj4g
d2l0aG91dCBoYXZpbmcgYmVlbiBhYmxlIHRvIGRpc2FibGUgaXRzIGNhdXNlLg0KDQpXZSBoYXZl
IGRlZmluaXRlbHkgc2VlbiBzaW1pbGFyIHRoaW5ncyBsaWtlIHRoaXMgYmVmb3JlLCBleGFjdGx5
IGFzIHlvdSBkZXNjcmliZWQNCndoZW4gZ29pbmcgaW50byBzdXNwZW5kIGFuZCB0aGUgSTJDIGNv
bnRyb2xsZXIgZGlzYXBwZWFycy4gDQpUaGVyZSB3aWxsIGJlIGEgd2luZG93IG9mIG9wcG9ydHVu
aXR5IGZvciB0aGlzIHRvIGhhcHBlbi4gDQoNCkkgaGF2ZSBzdGlsbCBub3QgdGVzdGVkLCBidXQ6
DQoNCkFja2VkLWJ5OiBTdGV2ZSBUd2lzcyA8c3R3aXNzLm9wZW5zb3VyY2VAZGlhc2VtaS5jb20+
DQoNCkkgd2lsbCBtYWtlIHRpbWUgdG8gdGVzdCB5b3VyIGNoYW5nZXMuDQoNClJlZ2FyZHMsDQpT
dGV2ZQ0KDQo+IA0KPiA+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL2RhOTA2Mi10aGVybWFsLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9kYTkwNjItdGhlcm1hbC5jDQo+ID4gPiBAQCAt
MTA2LDcgKzEwNiw3IEBAIHN0YXRpYyB2b2lkIGRhOTA2Ml90aGVybWFsX3BvbGxfb24oc3RydWN0
DQo+IHdvcmtfc3RydWN0DQo+ID4gPiAqd29yaykNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVEhFUk1BTF9FVkVOVF9VTlNQRUNJRklFRCk7DQo+ID4gPg0K
PiA+ID4gICAgICAgICAgICAgICBkZWxheSA9IG1zZWNzX3RvX2ppZmZpZXModGhlcm1hbC0+em9u
ZS0+cGFzc2l2ZV9kZWxheSk7DQo+ID4gPiAtICAgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmdGhlcm1hbC0+d29yaywgZGVsYXkpOw0KPiA+ID4gKyAgICAgICAgICAgICBxdWV1ZV9k
ZWxheWVkX3dvcmsoc3lzdGVtX2ZyZWV6YWJsZV93cSwgJnRoZXJtYWwtPndvcmssDQo+ID4gPiBk
ZWxheSk7DQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ICAgICAgIH0NCj4gPiA+
DQo+ID4gPiBAQCAtMTI1LDcgKzEyNSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkYTkwNjJfdGhl
cm1hbF9pcnFfaGFuZGxlcihpbnQgaXJxLA0KPiA+ID4gdm9pZCAqZGF0YSkNCj4gPiA+ICAgICAg
IHN0cnVjdCBkYTkwNjJfdGhlcm1hbCAqdGhlcm1hbCA9IGRhdGE7DQo+ID4gPg0KPiA+ID4gICAg
ICAgZGlzYWJsZV9pcnFfbm9zeW5jKHRoZXJtYWwtPmlycSk7DQo+ID4gPiAtICAgICBzY2hlZHVs
ZV9kZWxheWVkX3dvcmsoJnRoZXJtYWwtPndvcmssIDApOw0KPiA+ID4gKyAgICAgcXVldWVfZGVs
YXllZF93b3JrKHN5c3RlbV9mcmVlemFibGVfd3EsICZ0aGVybWFsLT53b3JrLCAwKTsNCj4gPiA+
DQo+ID4gPiAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gPiAgfQ0KPiANCj4gR3J7b2V0
amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4g
LS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQg
aWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0
aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0K
PiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIi
IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0gTGludXMgVG9ydmFsZHMNCg==
