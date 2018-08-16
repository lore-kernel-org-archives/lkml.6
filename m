Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFBDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035AF20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035AF20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391150AbeHPN5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:57:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389136AbeHPN5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:57:32 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 877537CA6ACCA;
        Thu, 16 Aug 2018 18:59:41 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Thu, 16 Aug 2018 18:59:42 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.26]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0399.000;
 Thu, 16 Aug 2018 18:59:38 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Topic: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
Thread-Index: AQHUMHhu69J7qZINb0WTPExaubbbVKS4SOuAgAA6VQCABl4BAP//8QSAgAMd8CD//4ruAIAAwyzQ
Date:   Thu, 16 Aug 2018 10:59:38 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C9B33C7@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
 <678F3D1BB717D949B966B68EAEB446ED0C9B2CC0@dggemm526-mbx.china.huawei.com>
 <f4372b12-327c-ee51-76ae-2e2bc5cdceed@ti.com>
In-Reply-To: <f4372b12-327c-ee51-76ae-2e2bc5cdceed@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXI6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJvZ2VyIFF1
YWRyb3MgW21haWx0bzpyb2dlcnFAdGkuY29tXQ0KPlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTYs
IDIwMTggMzoxNyBQTQ0KPlRvOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29t
PjsgQWxhbiBTdGVybg0KPjxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPkNjOiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgbWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb207DQo+ZHJp
bmtjYXRAY2hyb21pdW0ub3JnOyBmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tOw0KPmRyYWtl
QGVuZGxlc3NtLmNvbTsgbWlrZS5sb29pam1hbnNAdG9waWMubmw7IGpvZUBwZXJjaGVzLmNvbTsN
Cj5saW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBodWI6IHRyeSBvbGQgZW51bWVyYXRpb24gc2No
ZW1lIGZpcnN0IGZvciBoaWdoDQo+c3BlZWQgZGV2aWNlcw0KPg0KPk9uIDE2LzA4LzE4IDA5OjIx
LCBaZW5ndGFvIChCKSB3cm90ZToNCj4+IEhpIGFsYW46DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQWxhbiBTdGVybiBbbWFpbHRvOnN0ZXJuQHJvd2xhbmQu
aGFydmFyZC5lZHVdDQo+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE0LCAyMDE4IDEwOjQwIFBN
DQo+Pj4gVG86IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+DQo+Pj4gQ2M6
IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUB0aS5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
ZzsNCj4+PiBtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbTsgZHJpbmtjYXRAY2hyb21pdW0u
b3JnOw0KPj4+IGZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb207IGRyYWtlQGVuZGxlc3NtLmNv
bTsNCj4+PiBtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubDsgam9lQHBlcmNoZXMuY29tOyBsaW51eC11
c2JAdmdlci5rZXJuZWwub3JnOw0KPj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+
PiBTdWJqZWN0OiBSRTogW1BBVENIXSB1c2I6IGh1YjogdHJ5IG9sZCBlbnVtZXJhdGlvbiBzY2hl
bWUgZmlyc3QgZm9yDQo+Pj4gaGlnaCBzcGVlZCBkZXZpY2VzDQo+Pj4NCj4+PiBPbiBUdWUsIDE0
IEF1ZyAyMDE4LCBaZW5ndGFvIChCKSB3cm90ZToNCj4+Pg0KPj4+PiBIaSBhbGFuOg0KPj4+Pg0K
Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IGxpbnV4LXVzYi1v
d25lckB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+IFttYWlsdG86bGludXgtdXNiLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEFsYW4gU3Rlcm4NCj4+Pj4+IFNlbnQ6IEZyaWRheSwg
QXVndXN0IDEwLCAyMDE4IDEwOjIwIFBNDQo+Pj4+PiBUbzogUm9nZXIgUXVhZHJvcyA8cm9nZXJx
QHRpLmNvbT4NCj4+Pj4+IENjOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29t
PjsNCj4+Pj4+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBtYXRoaWFzLm55bWFuQGxpbnV4
LmludGVsLmNvbTsNCj4+Pj4+IGRyaW5rY2F0QGNocm9taXVtLm9yZzsgZmVsaXBlLmJhbGJpQGxp
bnV4LmludGVsLmNvbTsNCj4+Pj4+IGRyYWtlQGVuZGxlc3NtLmNvbTsgbWlrZS5sb29pam1hbnNA
dG9waWMubmw7IGpvZUBwZXJjaGVzLmNvbTsNCj4+Pj4+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHVzYjogaHViOiB0cnkgb2xkIGVudW1lcmF0aW9uIHNjaGVtZSBmaXJzdCBmb3INCj4+Pj4+
IGhpZ2ggc3BlZWQgZGV2aWNlcw0KPj4+Pj4NCj4+Pj4+IE9uIEZyaSwgMTAgQXVnIDIwMTgsIFJv
Z2VyIFF1YWRyb3Mgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IEhpLA0KPj4+Pj4+DQo+Pj4+Pj4gT24g
MTAvMDgvMTggMTg6MDEsIFplbmcgVGFvIHdyb3RlOg0KPj4+Pj4+PiBUaGUgbmV3IHNjaGVtZSBp
cyByZXF1aXJlZCBqdXN0IHRvIHN1cHBvcnQgbGVnYWN5IGxvdyBhbmQNCj4+Pj4+Pj4gZnVsbC1z
cGVlZCBkZXZpY2VzLiBGb3IgaGlnaCBzcGVlZCBkZXZpY2VzLCBpdCB3aWxsIHNsb3dlciB0aGUN
Cj4+Pj4+Pj4gZW51bWVyYXRpb24NCj4+PiBzcGVlZC4NCj4+Pj4+Pj4gU28gaW4gdGhpcyBwYXRj
aCB3ZSB0cnkgdGhlICJvbGQiIGVudW1lcmF0aW9uIHNjaGVtZSBmaXJzdCBmb3INCj4+Pj4+Pj4g
aGlnaCBzcGVlZCBkZXZpY2VzLg0KPj4+Pj4+DQo+Pj4+Pj4gSG93IHNsb3cgZG9lcyBpdCBnZXQ/
IElzIGl0IHNpZ25pZmljYW50Pw0KPj4+Pj4+IERvIHdlIHJpc2sgYnJlYWtpbmcgZXhpc3Rpbmcg
SFMgZGV2aWNlcyB0aGF0IHdvcms/IEkgZG9uJ3QgdGhpbmsNCj4+Pj4+PiB3ZSBjYW4gYmUgc3Vy
ZSB0aWxsIHdlIHJ1biB0aGlzIHRocm91Z2ggdGVzdGluZy4NCj4+Pj4+DQo+Pj4+PiBJbmRlZWQu
ICBJIGFtIGV4dHJlbWVseSBza2VwdGljYWwgYWJvdXQgYSBwYXRjaCBsaWtlIHRoaXMsIHVubGVz
cw0KPj4+Pj4gc29tZWJvZHkgY2FuIHNob3cgdGhhdCBXaW5kb3dzIHVzZXMgdGhlICJvbGQiIHNj
aGVtZSBmb3INCj5oaWdoLXNwZWVkDQo+Pj4gZGV2aWNlcy4NCj4+Pj4NCj4+Pj4gWWVzLCB0aGlz
IGlzIHdoYXQgdGhlIHdpbmRvd3MgaGFzIGRvbmUsIHlvdSBjYW4gcmVmZXIgdG8NCj4+Pj4NCj5o
dHRwczovL2Jsb2dzLm1zZG4ubWljcm9zb2Z0LmNvbS91c2Jjb3JlYmxvZy8yMDEzLzA0LzExL3Vz
Yi0yLTEtMi0wLQ0KPj4+PiAxLSAxLWRldmljZS1lbnVtZXJhdGlvbi1jaGFuZ2VzLWluLXdpbmRv
d3MtOC8NCj4+Pg0KPj4+IEFuZCB0aGF0IGJsb2cgcG9zdCBpcyA1IHllYXJzIG9sZCENCj4+Pg0K
Pj4+IE9rYXksIEkgdGhpbmsgd2UgY2FuIGdvIGFoZWFkIGFuZCBtYWtlIHRoaXMgY2hhbmdlLiAg
SG93ZXZlciwgeW91DQo+Pj4gc2hvdWxkIHVwZGF0ZSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gdG8g
bWVudGlvbiB3aGF0IE1pY3Jvc29mdCBkaWQgaW4NCj4+PiBXaW5kb3dzIDggYW5kIHNheSB0aGF0
IHRoZSBuZXcgYmVoYXZpb3IgbWF0Y2hlcyB0aGVpcnMuDQo+Pj4NCj4+IE9rYXksIEkgd2lsbCB1
cGRhdGUgaXQgdGhlIGNoYW5nZSBsb2cgaW4gdjIuDQo+Pg0KPj4+IEFsc28sIGFzIFJvZ2VyIG1l
bnRpb25lZCwgeW91IHNob3VsZCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gdG8gc2F5DQo+Pj4g
dGhhdCB0aGUgb2xkX3NjaGVtZV9maXJzdCBtb2R1bGUgcGFyYW1ldGVyIG5vdyBhcHBsaWVzIG9u
bHkgdG8gbG93LQ0KPj4+IGFuZCBmdWxsLXNwZWVkIGRldmljZXMsIHNpbmNlIGhpZ2gtIGFuZCBT
dXBlclNwZWVkIGRldmljZXMgYWx3YXlzIHVzZQ0KPnRoZSBvbGQgc2NoZW1lIGZpcnN0Lg0KPj4+
DQo+Pg0KPj4gU2luY2Ugd2Ugc2hvdWxkIGhhdmUgZGVkaWNhdGVkIGVudW1lcmF0aW9uIGZsb3cg
Zm9yIFNTLCBISUdILCBsb3cgYW5kDQo+PiBmdWxsIHNwZWVkIGRldmljZXMsIFNvIEkgdGhpbmsg
dGhlIG9sZF9zY2hlbWVfZmlyc3QgYW5kIHVzZV9ib3RoX3NjaGVtZXMNCj5wYXJhbWV0ZXJzIHNo
b3VsZCBiZSByZW1vdmVkLg0KPj4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/DQo+DQo+SSB0
aGluayB3ZSBzaG91bGQgcmV0YWluIHRoZW0gYXMgc29tZSBob3N0IGNvbnRyb2xsZXJzIGNhbiBo
YXZlIGlzc3VlcyBhbmQNCj50aGVzZSBwYXJhbWV0ZXJzIGdpdmUgc29tZSBjb250cm9sIHRvIHN5
c3RlbSBpbnRlZ3JhdG9ycyB0byB3b3JrYXJvdW5kIGlmDQo+cmVxdWlyZWQuDQo+DQo+SSdtIGF3
YXJlIG9mIG9uZSBlcnJhdGEgWzFdIHRoYXQgcmVxdWlyZXMgdGhlIG9sZF9zY2hlbWVfZmlyc3Qg
dG8gYmUgc2V0IGluDQo+Y2VydGFpbiBjaXJjdW1zdGFuY2VzLg0KPg0KPlsxXSBodHRwOi8vd3d3
LnRpLmNvbS9saXQvZXIvc3ByejQyOWwvc3ByejQyOWwucGRmDQo+U2VjdGlvbiBpODk3DQoNCkkg
J2QgcmF0aGVyIHRvIHVzZSBhIHF1aXJrIHRvIHdvcmthcm91bmQuDQpBbmQgdGhlIG1haW4gaWRl
YSBpcyB0byBrZWVwIHRoZSBlbnVtZXJhdGlvbiBmbG93IGFzIHNpbXBsZSBhcyBwb3NzaWJsZS4N
Cg0KPg0KPi0tDQo+VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAy
MiwgMDAxODAgSGVsc2lua2kuDQo+WS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290
aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg==
