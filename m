Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C575C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059720818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfBFGdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:33:44 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:45069 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfBFGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:33:43 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id AC/72-02885-4CF7A5C5; Wed, 06 Feb 2019 06:33:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRWlGSWpSXmKPExsVy8+3OTbqH66N
  iDJZv07NYcvEqu0X7u2XsFpd3zWGzOLb6CpsDi8e8NdUe0+f9ZPL4vEkugDmKNTMvKb8igTVj
  8b2LzAVzFCuW/Z3B3MD4RKGLkYtDSOApo8SSGSeYIJyfjBKdSz+zQDizGCU2TPnE2sXIycEmI
  CPx+/lNdhBbREBZ4uDhFjYQm1kgQqJ981QmEFtYIFbi8amnbBA1cRLTLk5mgrCtJE79/s0CYr
  MIqEhM+bkcrIZXwFri/7RrzCC2kECGxIeTR8BqOAX0JY5eXgUWZxQQk/h+ag0TxC5xiVtP5oP
  ZEgICEkv2nGeGsEUlXj7+xwphK0jMWfKLDcI2lFg17QALhC0t8aZnHVTcVOLwzcNAcQ6gmZoS
  63fpQ4w3l5iy/DUrhK0oMaX7ITvEmYISJ2c+YYE4U1Fi6c11UCdoSjxYvhlqpL3E9PdXoc6xk
  Tj0txVu1eqPd1gmMMrNQvLBLITNs5BsnoVk8ywkmxcwsq5itEwqykzPKMlNzMzRNTQw0DU0NN
  Y10jUyttRLrNJN1Est1U1OzSspSgTK6iWWF+sVV+Ym56To5aWWbGIEppuUQqb3Oxjvt6cfYpT
  kYFIS5dUpi4oR4kvKT6nMSCzOiC8qzUktPsQow8GhJMG7vBIoJ1iUmp5akZaZA0x8MGkJDh4l
  Ed4pdUBp3uKCxNzizHSI1ClGXY63B5/PZRZiycvPS5US551RDFQkAFKUUZoHNwKWhC8xykoJ8
  zIyMDAI8RSkFuVmlqDKv2IU52BUEuYVAFnFk5lXArfpFdARTEBH5OlEgBxRkoiQkmpgnMstvV
  3r4ObPQtluqbGqM32f3dQpDLqdtNkvdHa03UKpH0cEblrxMZz9vyj5gtcN71fJbi9Pz7KzK52
  lp2lX0twfYC/yc7O97a/zDgIvzXf7nPNN2V+WtVS2M1bm27qX6/QnmWw6bXX/+R/Lx0sqD1f1
  nDql+++J7sLoy33XruS/sr9yxS/igBJLcUaioRZzUXEiAJRn6yK9AwAA
X-Env-Sender: Oliver.Rohe@wago.com
X-Msg-Ref: server-27.tower-223.messagelabs.com!1549434819!894083!2
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8537 invoked from network); 6 Feb 2019 06:33:39 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-27.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 6 Feb 2019 06:33:39 -0000
Received: from SVEX01009.wago.local (10.1.103.227) by SVEX01010.wago.local
 (10.1.103.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 6 Feb 2019
 07:33:39 +0100
Received: from SVEX01005.wago.local (10.1.101.121) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3 via Frontend
 Transport; Wed, 6 Feb 2019 07:33:39 +0100
Received: from SVEX01006.wago.local ([10.1.101.122]) by SVEX01005.wago.local
 ([169.254.1.23]) with mapi id 14.03.0415.000; Wed, 6 Feb 2019 07:33:39 +0100
From:   <Oliver.Rohe@wago.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Thread-Topic: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Thread-Index: AQHUqa+/rXqeQIxzX0+LFpkiw+8xxaXR1vwAgACQqgA=
Date:   Wed, 6 Feb 2019 06:33:39 +0000
Message-ID: <0b5372eb-a921-44e9-2bed-2f7582f64329@wago.com>
References: <1547212521-14871-1-git-send-email-oliver.rohe@wago.com>
 <20190205215552.GH24598@piout.net>
In-Reply-To: <20190205215552.GH24598@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.103.228]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
x-pp-proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AE10625E093AA4D9C4745094B10CAE1@WAGO.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: SVEX01010.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 3501de6a-633d-491f-8a4a-2b9665cb6ea9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQp0aGFua3MgYSBsb3QhIQ0KDQpPbiAwNS4wMi4xOSAyMjo1NSwgQWxl
eGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gMTEvMDEvMjAxOSAxMzoxNToz
OSswMDAwLCBPbGl2ZXIuUm9oZUB3YWdvLmNvbSB3cm90ZToNCj4+IFdoZW4gdGhlIG9zY2lsbGF0
b3Igb2YgdGhlIHJ0YyBnZXRzIGludGVycnVwdGVkLA0KPj4gZS5nLiBkdWUgdG8gYW4gZW1wdHkg
YmF0dGVyeSwgcmVhZGluZyBmcm9tIHRoZSBydGMgd2lsbCBub3cgcmV0dXJuIGFuIGVycm9yDQo+
PiBhbmQgdGhlIG9zY2lsbGF0b3IgYml0IHdpbGwgYmUgY2xlYXJlZCwgb25jZSB0aGUgcnRjIGlz
IHN1Y2Nlc3NmdWxseSByZXNldC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgUm9oZSA8
b2xpdmVyLnJvaGVAd2Fnby5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3J0Yy9ydGMtcnM1YzM3
Mi5jIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLXJzNWMzNzIuYyBiL2RyaXZlcnMvcnRj
L3J0Yy1yczVjMzcyLmMNCj4+IGluZGV4IGZmMzVkY2UuLjkxZDE0NzUgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3J0Yy9ydGMtcnM1YzM3Mi5jDQo+PiArKysgYi9kcml2ZXJzL3J0Yy9ydGMtcnM1
YzM3Mi5jDQo+PiBAQCAtNTIsOCArNTIsMTAgQEANCj4+ICAjCWRlZmluZSBSUzVDX0NUUkwxX0NU
NAkJKDQgPDwgMCkJLyogMSBIeiBsZXZlbCBpcnEgKi8NCj4+ICAjZGVmaW5lIFJTNUNfUkVHX0NU
UkwyCQkxNQ0KPj4gICMJZGVmaW5lIFJTNUMzNzJfQ1RSTDJfMjQJCSgxIDw8IDUpDQo+PiAtIwlk
ZWZpbmUgUjJ4MnhfQ1RSTDJfWFNUUAkJKDEgPDwgNSkJLyogb25seSBpZiBSMngyeCAqLw0KPj4g
LSMJZGVmaW5lIFJTNUNfQ1RSTDJfWFNUUAkJKDEgPDwgNCkJLyogb25seSBpZiAhUjJ4MnggKi8N
Cj4+ICsjCWRlZmluZSBSUzVDX0NUUkwyX1hTVFAgICAgICAgICAgKDEgPDwgNCkgICAgICAgIC8q
IG9ubHkgaWYgIVIyeDJ4ICovDQo+IA0KPiBUaGlzIHNob3VsZCBwcm9iYWJseSB1c2UgdGFicyBp
bnN0ZWFkIG9mIHNwYWNlcw0KOikNCg0KPj4gKyMJZGVmaW5lIFIyeDJ4X0NUUkwyX1ZERVQJCSgx
IDw8IDYpCS8qIG9ubHkgaWYgIFIyeDJ4ICovDQo+PiArIwlkZWZpbmUgUjJ4MnhfQ1RSTDJfWFNU
UAkJKDEgPDwgNSkJLyogb25seSBpZiAgUjJ4MnggKi8NCj4+ICsjCWRlZmluZSBSMngyeF9DVFJM
Ml9QT04JCSgxIDw8IDQpCS8qIG9ubHkgaWYgIFIyeDJ4ICovDQo+PiAgIwlkZWZpbmUgUlM1Q19D
VFJMMl9DVEZHCQkoMSA8PCAyKQ0KPj4gICMJZGVmaW5lIFJTNUNfQ1RSTDJfQUFGRwkJKDEgPDwg
MSkJLyogb3IgV0FGRyAqLw0KPj4gICMJZGVmaW5lIFJTNUNfQ1RSTDJfQkFGRwkJKDEgPDwgMCkJ
Lyogb3IgREFGRyAqLw0KPj4gQEAgLTIxMiwxMCArMjE0LDMxIEBAIHN0YXRpYyBpbnQgcnM1YzM3
Ml9ydGNfcmVhZF90aW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkN
Cj4+ICAJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsNCj4+
ICAJc3RydWN0IHJzNWMzNzIJKnJzNWMgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsNCj4+
ICAJaW50CQlzdGF0dXMgPSByczVjX2dldF9yZWdzKHJzNWMpOw0KPj4gKwl1bnNpZ25lZCBjaGFy
IGN0cmwyID0gcnM1Yy0+cmVnc1tSUzVDX1JFR19DVFJMMl07DQo+PiAgDQo+PiAgCWlmIChzdGF0
dXMgPCAwKQ0KPj4gIAkJcmV0dXJuIHN0YXR1czsNCj4+ICANCj4+ICsJc3dpdGNoIChyczVjLT50
eXBlKSB7DQo+PiArCWNhc2UgcnRjX3IyMDI1c2Q6DQo+PiArCWNhc2UgcnRjX3IyMjIxdGw6DQo+
PiArCQlpZiAoY3RybDIgJiBSMngyeF9DVFJMMl9WREVUKQ0KPj4gKwkJCWRldl93YXJuKCZjbGll
bnQtPmRldiwgInJ0YyBiYXR0ZXJ5IHZvbHRhZ2UgZHJvcCBiZWxvdyB0aHJlc2hvbGQgZGV0ZWN0
ZWQuXG4iKTsNCj4gDQo+IFZERVQgZG9lc24ndCBtZWFuIGFueXRoaW5nIHNwZWNpZmljIHJlZ2Fy
ZGluZyB0aW1la2VlcGluZyBzbyBJIHdvdWxkbid0IHdhcm4gaGVyZS4NCg0KVkRFVCBtZWFucyBp
biBjYXNlIHRoZSBjaGlwIGlzIHBvd2VyZWQgYnkgYSBiYXR0ZXJ5LCB0aGF0IGlzIGFib3V0IHRv
IGRpZSBzb21ldGltZSBzb29uLCBpdCBnaXZlcyB5b3UgaGVhZHMgdXAuDQo+IA0KPj4gKwkJaWYg
KGN0cmwyICYgUjJ4MnhfQ1RSTDJfUE9OKQ0KPj4gKwkJCWRldl93YXJuKCZjbGllbnQtPmRldiwg
InJ0YyBiYXR0ZXJ5IHZvbHRhZ2UgZHJvcCB0byB6ZXJvIGRldGVjdGVkLlxuIik7DQo+IA0KPiBZ
b3Ugc2hvdWxkIHJldHVybiAtRUlOVkFMIGRpcmVjdGx5IGhlcmUNCg0KVGhlIFBPTiBpbXBsaWVz
IHRoZSBYU1RQIGJpdCwgc28gSSBvbmx5IHJldHVybiBmcm9tIHRoZXJlLCBqdXN0IHRvIHByaW50
IGFsbCB0aGUgd2FybmluZyBtZXNzYWdlcywgYnV0IEkgY2FuIHJldHVybiBkaXJlY3RseSBmcm9t
IGhlcmUgaWYgeW91IHdhbnQuDQo+IA0KPj4gKwkJaWYgKChyczVjLT50eXBlID09IHJ0Y19yMjAy
NXNkICYmICEoY3RybDIgJiBSMngyeF9DVFJMMl9YU1RQKSkgfHwNCj4+ICsJCSAgICAocnM1Yy0+
dHlwZSA9PSBydGNfcjIyMjF0bCAmJiAgKGN0cmwyICYgUjJ4MnhfQ1RSTDJfWFNUUCkpKSB7DQo+
PiArCQkJZGV2X3dhcm4oJmNsaWVudC0+ZGV2LCAicnRjIG9zY2lsbGF0b3IgaW50ZXJydXB0aW9u
IGRldGVjdGVkLiBQbGVhc2UgcmVzZXQgdGhlIHJ0YyBjbG9jay5cbiIpOw0KPj4gKwkJCXJldHVy
biAtRUlPOw0KPiANCj4gLUVJTlZBTCBpcyB0aGUgY29ycmVjdCBlcnJvciBjb2RlIGhlcmUuDQoN
Ck9rDQo+IA0KPj4gKwkJfQ0KPj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlpZiAo
Y3RybDIgJiBSUzVDX0NUUkwyX1hTVFApIHsNCj4+ICsJCQlkZXZfd2FybigmY2xpZW50LT5kZXYs
ICJydGMgb3NjaWxsYXRvciBpbnRlcnJ1cHRpb24gZGV0ZWN0ZWQuIFBsZWFzZSByZXNldCB0aGUg
cnRjIGNsb2NrLlxuIik7DQo+PiArCQkJcmV0dXJuIC1FSU87DQo+IA0KPiBhbmQgaGVyZS4NCg0K
T0sNCj4gDQo+IA==
