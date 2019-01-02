Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14311218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfABPbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:31:42 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:30150 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729559AbfABPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:31:41 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id DD/48-09202-A59DC2C5; Wed, 02 Jan 2019 15:31:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRWlGSWpSXmKPExsVy8IPnUd2omzo
  xBrM/aVhMffiEzeLZrb1MFs2L17NZXN41h81i+7dHbBZzlp5gsZj7ZSqzA7vH76OP2T12zrrL
  7rFpVSebx6HDHYwe++euYff4vEkugC2KNTMvKb8igTXjzfXTrAV3+SrubDrH1sB4hK+LkYtDS
  GApo8SO0/dZuxg5OdgEDCXmvXnP2MXIwSEioCsx5ycTSA2zwDEmiZ9TZjKB1AgLBEtsOfuQHc
  QWEQiRmLDtHCOE7STxtv0L2BwWARWJtmv3wGxegQCJ6wu2MEIse8socfDfITaQBKdAoMTMea/
  ABjEKyEp8aVzNDGIzC4hL3HoyH2yZhICAxJI955khbFGJl4//sULY8hJ31yyBqrGXeH3vHQvI
  0RIC+hJ9jcUQYUOJVdMOsEDY5hL7pt5kAilhFtCUWL9LH2KTosSUbohXeAUEJU7OfMIygVF8F
  pIjZiF0zELSMQtJxwJGllWMFklFmekZJbmJmTm6hgYGuoaGRrqGlkBsYa6XWKWbqJdaqlueWl
  yia6iXWF6sV1yZm5yTopeXWrKJERjnKQUHdu9gfN+VfohRkoNJSZR31SmdGCG+pPyUyozE4oz
  4otKc1OJDjDIcHEoSvDdvAOUEi1LTUyvSMnOACQcmLcHBoyTCa3cdKM1bXJCYW5yZDpE6xajL
  ceVM5wxmIZa8/LxUKXHeaJAZAiBFGaV5cCNgye8So6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJ
  WHe9yCreDLzSuA2vQI6ggnoCBMJsCNKEhFSUg2MPbWVVRtE5icdcwieY1w7pfLvvLs2ERZnLp
  g63n2U+c2W6eXXNKF5sbvLLiozKDC5Sl45nvesvHJiuC9b0rKO1m8r9nLFFiT7Byxpddg3NTe
  i5vsNFt7Vcy41ay56IhW+i9FV7e9dC8bo2NkKDm1SH1IePbO0jnN60Hx3jXL91N87Vi8or/mp
  xFKckWioxVxUnAgAVjcpi3kDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-19.tower-262.messagelabs.com!1546443098!831404!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13206 invoked from network); 2 Jan 2019 15:31:38 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-19.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 2 Jan 2019 15:31:38 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.193]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Wed,
 2 Jan 2019 15:31:37 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH] regmap: regmap-irq: silently ignore unsupported type
 settings
Thread-Topic: [PATCH] regmap: regmap-irq: silently ignore unsupported type
 settings
Thread-Index: AQHUn2eRGEaG3Adhikys+xUg2f+AdKWZO0oAgAF24YCAAWWCAA==
Date:   Wed, 2 Jan 2019 15:31:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70221795DAD@SW-EX-MBX02.diasemi.com>
References: <20181227084443.GA23991@localhost.localdomain>
 <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
 <20181231191428.GM1846@sirena.org.uk>
 <CAMuHMdXi60ZnVMgAxTnBr2ydvhcFzVbooosc+O+gC4q0-0_sEA@mail.gmail.com>
In-Reply-To: <CAMuHMdXi60ZnVMgAxTnBr2ydvhcFzVbooosc+O+gC4q0-0_sEA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.87]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 02/01/2019 12:52:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDAxIEphbnVhcnkgMjAxOSBAMTc6MzYsIEdlZXJ0IFV5dHRlcmhvZXZl
biB3cm90ZToNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSByZWdtYXA6IHJlZ21hcC1pcnE6IHNp
bGVudGx5IGlnbm9yZSB1bnN1cHBvcnRlZCB0eXBlIHNldHRpbmdzDQo+IE9uIE1vbiwgRGVjIDMx
LCAyMDE4IGF0IDg6MTQgUE0gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPiB3cm90ZToN
Cj4gPiBPbiBTYXQsIERlYyAyOSwgMjAxOCBhdCAxMjoxMzozMlBNICswMTAwLCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6DQo+ID4gPiA+IEdlZXJ0LCBkbyB5b3Uga25vdyBpZiBhbnlvbmUgdm91
bGQgdG8gdGVzdCB0aGlzPw0KPiA+DQo+ID4gPiBUaGFua3MsIHRoYXQgc2VlbXMgdG8gZml4IHRo
ZSBpc3N1ZSB3aXRoIGRhOTA2My1ydGMuDQo+ID4NCj4gPiA+IEkgZG9uJ3Qga25vdyBob3cgdG8g
dHJpZ2dlciBhbiBhY3R1YWwgaW50ZXJydXB0LCB0aG91Z2guDQo+ID4NCj4gPiBJZiBpdCdzIGEg
UlRDIGRvZXMgaXQgaGF2ZSBhbiBhbGFybSB5b3UgY2FuIHNldD8NCj4gDQo+IFRoYXQncyB3aGF0
IEkgaGFkIGV4cGVjdGVkLCB0b28sIGJ1dCB0aGVyZSBpcyBubyBhbGFybSBmaWxlIHVuZGVyDQo+
IC9zeXMvY2xhc3MvcnRjLy4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gR2VlcnQN
Cg0KVG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgREE5MDYzIFJUQyBJIGFtIHVzZSBpb2N0bCBmdW5j
dGlvbiBjYWxscw0KDQogLSBSVENfU0VUX1RJTUUNCiAtIFJUQ19SRF9USU1FDQogLSBSVENfQUxN
X1NFVA0KIC0gUlRDX0FMTV9SRUFEDQogLSBSVENfQUlFX09ODQogLSBSVENfQUlFX09GRg0KDQot
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcnRjLnR4dA0KLSBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydGMNCg0KQWx0aG91Z2ggSSBkb24ndCB1c2UgdGhlIHRl
c3QgcHJvZ3JhbXMgZm91bmQgaW4gTGludXgsIHRoZSBpb2N0bCBjYWxscyBJDQptYWtlIGFyZSBz
aG93biBpbiB0aGUgTGludXggc2VsZnRlc3RzLiBJIGJlbGlldmUgdGhhdCBBbGV4YW5kcmUgQmVs
bG9uaQ0KdXBkYXRlZCB0aGUgUlRDIHRlc3RzIHJlY2VudGx5IC0tIGJ1dCBJIGFtIG5vdCB1cCB0
byBkYXRlIHdpdGggdGhlIGxhdGVzdC4NCg0KZ2l0IHNob3cgZDhkYTg2NjVlOGUzNGMxNGY5YjIw
ZmUzZjIxZGZmMjliMjRjYmYwMjp0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydGMvcnRjdGVzdC5j
DQoNClJlZ2FyZHMsDQpTdGV2ZQ0KDQoNCg==
