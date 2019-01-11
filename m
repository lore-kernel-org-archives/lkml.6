Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C15C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C4820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfAKKjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:39:37 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:27408 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728596AbfAKKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:39:36 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id FA/1D-31049-562783C5; Fri, 11 Jan 2019 10:39:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRWlGSWpSXmKPExsVy8+3OTbopRRY
  xBu9eGlosuXiV3aL93TJ2i8u75rBZHFt9hc2BxWPemmqP6fN+Mnl83iQXwBzFmpmXlF+RwJrR
  /3Ure8Fq5YpTn6eyNjB+UOpi5OIQEpjNKHHv7GamLkZODjYBGYnfz2+yg9giAsoSBw+3sIHYz
  AIREu2bp4LVCAt4Ssxa9JgRosZLov3PIyjbSqKv6zCYzSKgKtHX/g2snlfAWuLFpmvMILaQQJ
  rEhcOXWUBsTgE9iaNf/4DVMAqISXw/tYYJYpe4xK0n88FsCQEBiSV7zjND2KISLx//Y+1i5AC
  yFSRWtylAhA0lVk07wAJhS0u86VnHBmGbShy+eZgFpJxZQFNi/S59iOnmEhePnoT6SlFiSvdD
  dogrBSVOznzCMoFRfBaSI2YhdM9C0j0LSfcsJN0LGFlXMVokFWWmZ5TkJmbm6BoaGOgaGhrpG
  loaA7GZXmKVbqJeaqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZg/KYUHDyyg3HDivRDjJIcTE
  qivCk2FjFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHjZC4BygkWp6akVaZk5wEQCk5bg4FES4b0
  OkuYtLkjMLc5Mh0idYtTleHvw+VxmIZa8/LxUKXFe3kKgIgGQoozSPLgRsKR2iVFWSpiXkYGB
  QYinILUoN7MEVf4VozgHo5Iwrx7IKp7MvBK4Ta+AjmACOiL4mznIESWJCCmpBkbOdLHFOt1yO
  o+4Pnt5PvxY9tLvK0vnfZFf+nrpIlrFMV/uOfwpj93alf3pbtXSVRYFk2qNtyyc7Jzg/jRNZd
  Hbgw+25jKcr/a67TdPiGetTNyr7mO/925Z9GmT5CrhuTeT6qcsX81eY3rd8OPCgMhX7x7typE
  +efp6pd3W5X+amH5/ni+tkj1DiaU4I9FQi7moOBEAGExfUmUDAAA=
X-Env-Sender: Oliver.Rohe@wago.com
X-Msg-Ref: server-3.tower-262.messagelabs.com!1547203172!1314394!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21552 invoked from network); 11 Jan 2019 10:39:32 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-3.tower-262.messagelabs.com with AES128-SHA encrypted SMTP; 11 Jan 2019 10:39:32 -0000
Received: from SVEX01006.wago.local ([10.1.101.122]) by SVEX01005.wago.local
 ([169.254.1.23]) with mapi id 14.03.0415.000; Fri, 11 Jan 2019 11:39:32 +0100
From:   <Oliver.Rohe@wago.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Thread-Topic: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Thread-Index: AQHUqAprCBGfFZN+P06IC9NgtvqzIqWpyZMAgAAJcQA=
Date:   Fri, 11 Jan 2019 10:39:30 +0000
Message-ID: <ffd4cd8c-b6f6-8462-bf4c-f93141b9b97a@wago.com>
References: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
 <20190111100542.GA2547@piout.net>
In-Reply-To: <20190111100542.GA2547@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.101.133]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
x-pp-proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDA2BD1D5C85454DABA8FD1236E5D71E@WAGO.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpPbiAxMS4wMS4xOSAxMTowNSwgQWxleGFuZHJlIEJlbGxvbmkgd3Jv
dGU6DQo+IEhlbGxvLA0KPiANCj4gT24gMDkvMDEvMjAxOSAxMDo1OTo0MCswMDAwLCBPbGl2ZXIu
Um9oZUB3YWdvLmNvbSB3cm90ZToNCj4+IFRoZSBSaWNvaCBjaGlwcyBoYXZlIHNsaWdodGx5IGRp
ZmZlcmVudCByZWdpc3RlciBsYXlvdXRzDQo+PiBhbmQgdGhlIHIyMjIxIGNoaXAgdXNlcyBiaXQg
NSBhcyB0aGUgb3NjaWxsYXRvciBoYWx0IHNlbnNvciBiaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogT2xpdmUgUm9oZSA8b2xpdmVyLnJvaGVAd2Fnby5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L3J0Yy9ydGMtcnM1YzM3Mi5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1yczVjMzcyLmMgYi9kcml2ZXJzL3J0
Yy9ydGMtcnM1YzM3Mi5jDQo+PiBpbmRleCBjNTAzODMyLi5mZjM1ZGNlIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ydGMvcnRjLXJzNWMzNzIuYw0KPj4gKysrIGIvZHJpdmVycy9ydGMvcnRjLXJz
NWMzNzIuYw0KPj4gQEAgLTUyLDggKzUyLDggQEANCj4+ICAjCWRlZmluZSBSUzVDX0NUUkwxX0NU
NAkJKDQgPDwgMCkJLyogMSBIeiBsZXZlbCBpcnEgKi8NCj4+ICAjZGVmaW5lIFJTNUNfUkVHX0NU
UkwyCQkxNQ0KPj4gICMJZGVmaW5lIFJTNUMzNzJfQ1RSTDJfMjQJCSgxIDw8IDUpDQo+PiAtIwlk
ZWZpbmUgUjIwMjVfQ1RSTDJfWFNUCQkoMSA8PCA1KQ0KPj4gLSMJZGVmaW5lIFJTNUNfQ1RSTDJf
WFNUUAkJKDEgPDwgNCkJLyogb25seSBpZiAhUjIwMjVTL0QgKi8NCj4+ICsjCWRlZmluZSBSMngy
eF9DVFJMMl9YU1RQCQkoMSA8PCA1KQkvKiBvbmx5IGlmIFIyeDJ4ICovDQo+IA0KPiBJIHdvdWxk
bid0IHJlbmFtZSB0aGF0IGRlZmluZSBhcyBsYXRlciBvbiwgaXQgbWF5IGJlIHVzZWQgZm9yIFJU
Q3MgdGhhdA0KPiBkb2Vzbid0IG1hdGNoIFIyeDJ4IChhcyBpcyB0aGUgY2FzZSBmb3IgUlY1QzM4
N19DVFJMMV8yNCBmb3IgZXhhbXBsZSkuDQo+IHRoZSBiaXQgZG9lc24ndCBldmVuIGhhdmUgdGhl
IHNhbWUgbWVhbmluZyBvbiBSMjAyNSBhbmQgUjIyMjEuDQpZZXMsIGJ1dCBSMjAyNSBhbmQgUjIy
MjEgaGF2ZSBhIGZldyByZWdpc3RlcnMgaW4gY29tbW9uIChQT04sIFZERVQpLiBUaGUgbWVhbmlu
Zw0Kb2YgWFNUIGFuZCBYU1RQIEkgdGhpbmsgYXJlIHRoZSBzYW1lLCBldmVuIHRob3VnaCB0aGV5
IGhhdmUgZmxpcHBlZCBsb2dpYy4NCj4gDQo+PiArIwlkZWZpbmUgUlM1Q19DVFJMMl9YU1RQCQko
MSA8PCA0KQkvKiBvbmx5IGlmICFSMngyeCAqLw0KPj4gICMJZGVmaW5lIFJTNUNfQ1RSTDJfQ1RG
RwkJKDEgPDwgMikNCj4+ICAjCWRlZmluZSBSUzVDX0NUUkwyX0FBRkcJCSgxIDw8IDEpCS8qIG9y
IFdBRkcgKi8NCj4+ICAjCWRlZmluZSBSUzVDX0NUUkwyX0JBRkcJCSgxIDw8IDApCS8qIG9yIERB
RkcgKi8NCj4+IEBAIC01MTksMjAgKzUxOSwzMCBAQCBzdGF0aWMgaW50IHJzNWNfb3NjaWxsYXRv
cl9zZXR1cChzdHJ1Y3QgcnM1YzM3MiAqcnM1YzM3MikNCj4+ICAJdW5zaWduZWQgY2hhciBidWZb
Ml07DQo+PiAgCWludCBhZGRyLCBpLCByZXQgPSAwOw0KPj4gIA0KPj4gLQlpZiAocnM1YzM3Mi0+
dHlwZSA9PSBydGNfcjIwMjVzZCkgew0KPj4gLQkJaWYgKHJzNWMzNzItPnJlZ3NbUlM1Q19SRUdf
Q1RSTDJdICYgUjIwMjVfQ1RSTDJfWFNUKQ0KPj4gKwlhZGRyICAgPSBSUzVDX0FERFIoUlM1Q19S
RUdfQ1RSTDEpOw0KPj4gKwlidWZbMF0gPSByczVjMzcyLT5yZWdzW1JTNUNfUkVHX0NUUkwxXTsN
Cj4+ICsJYnVmWzFdID0gcnM1YzM3Mi0+cmVnc1tSUzVDX1JFR19DVFJMMl07DQo+PiArDQo+PiAr
CS8qIGhhbmRsZSB4c3RwIGJpdCAqLw0KPj4gKwlzd2l0Y2ggKHJzNWMzNzItPnR5cGUpIHsNCj4+
ICsJY2FzZSBydGNfcjIwMjVzZDoNCj4+ICsJCWlmIChidWZbMV0gJiBSMngyeF9DVFJMMl9YU1RQ
KQ0KPj4gIAkJCXJldHVybiByZXQ7DQo+PiAtCQlyczVjMzcyLT5yZWdzW1JTNUNfUkVHX0NUUkwy
XSB8PSBSMjAyNV9DVFJMMl9YU1Q7DQo+PiAtCX0gZWxzZSB7DQo+PiAtCQlpZiAoIShyczVjMzcy
LT5yZWdzW1JTNUNfUkVHX0NUUkwyXSAmIFJTNUNfQ1RSTDJfWFNUUCkpDQo+PiArCQlyczVjMzcy
LT5yZWdzW1JTNUNfUkVHX0NUUkwyXSB8PSBSMngyeF9DVFJMMl9YU1RQOw0KPj4gKwkJYnJlYWs7
DQo+PiArCWNhc2UgcnRjX3IyMjIxdGw6DQo+PiArCQlpZiAoIShidWZbMV0gJiBSMngyeF9DVFJM
Ml9YU1RQKSkNCj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gKwkJcnM1YzM3Mi0+cmVnc1tSUzVDX1JF
R19DVFJMMl0gJj0gflIyeDJ4X0NUUkwyX1hTVFA7DQo+PiArCQlicmVhazsNCj4+ICsNCj4+ICsJ
ZGVmYXVsdDoNCj4+ICsJCWlmICghKGJ1ZlsxXSAmIFJTNUNfQ1RSTDJfWFNUUCkpDQo+PiAgCQkJ
cmV0dXJuIHJldDsNCj4+ICAJCXJzNWMzNzItPnJlZ3NbUlM1Q19SRUdfQ1RSTDJdICY9IH5SUzVD
X0NUUkwyX1hTVFA7DQo+PiArCQlicmVhazsNCj4+ICAJfQ0KPj4gIA0KPiANCj4gTm90ZSB0aGF0
IHRoaXMgaXMgYWN0dWFsbHkgcXVpdGUgYmFkIHRvIHJlc3RhcnQgdGhlIG9zY2lsbGF0b3Igb24g
cHJvYmUuDQo+IFRoZSBiZXN0IHdvdWxkIGJlIHRvIGRvIHRoYXQgb25seSBpbiByczVjMzcyX3J0
Y19zZXRfdGltZSBvbmNlIHlvdSBrbm93DQo+IHRoZSBzZXQgdGltZSBpcyBnb29kLiB0aGVuIHlv
dSBjYW4gcmV0dXJuIC1FSU5WQUwgZnJvbQ0KPiByczVjMzcyX3J0Y19yZWFkX3RpbWUgd2hlbiB5
b3Uga25vdyB0aGUgb3NjaWxsYXRvciBpcyBzdG9wcGVkIHNvDQo+IHVzZXJzcGFjZSBrbm93IHRo
ZSBSVEMgdGltZSBpcyBiYWQuIFRoaXMgY291bGQgYmUgZG9uZSBhcyBhIGZvbGx3IHVwDQo+IHBh
dGNoLg0KWWVzLCBJIGFncmVlLiBJIGhhdmUgYW5vdGhlciBwYXRjaCB0aGF0IGRvZXMgZXhhY3Rs
eSB3aGF0IHlvdSBzdWdnZXN0LiBXZSByZXNldA0KdGhlIGRpZmZlcmVudCBiaXRzIChYU1RQLCBQ
T04sIFZERVQpIGluIHNldCB0aW1lIGFuZCByZXR1cm4gYW4gZXJyb3IgaW4gcmVhZA0KdGltZSBp
ZiB0aGUgeHN0cCBiaXQgaXMgc2V0LiBJIHdpbGwgc2VuZCBpdCB0byB5b3UuDQoNCj4gVGhlcmUg
aXMgYWxzbyBtb3JlIHdvcmsgbmVlZGVkIHRvIGNsZWFuIHVwIHRoYXQgZHJpdmVyIGlmIHlvdSBo
YXZlIHRpbWUNCj4gYW5kIGFyZSB3aWxsaW5nIHRvLg0KWWVzIHN1cmUuIFdpdGggc29tZSBoZWxw
LCBvciBleGFtcGxlcyBmcm9tIHlvdSBndXlzIEkgY2FuIGRvIHRoYXQu
