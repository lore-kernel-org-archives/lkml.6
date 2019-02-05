Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D81120844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfBEMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:49:36 -0500
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:14827 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:49:35 -0500
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by mgwym01.jp.fujitsu.com with smtp
         id 65d9_308a_c2ea1633_62f4_4e7c_a937_47d7db5c9ff8;
        Tue, 05 Feb 2019 21:49:31 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 6EDEBAC0120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Feb 2019 21:49:31 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 48E016924AC;
        Tue,  5 Feb 2019 21:49:30 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw15 ([10.0.194.54]) with mapi id 14.03.0415.000; Tue, 5 Feb 2019
 21:49:29 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Catalin Marinas' <catalin.marinas@arm.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUt/4CQp2oaDwKnkWlIUKhrVqG76XRLzTQ
Date:   Tue, 5 Feb 2019 12:49:28 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A30C360@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <20190129181032.GC224095@arrakis.emea.arm.com>
In-Reply-To: <20190129181032.GC224095@arrakis.emea.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBDYXRhbGluIE1hcmluYXMgW21haWx0bzpjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDMwLCAy
MDE5IDM6MTEgQU0NCj4gVG86IFpoYW5nLCBMZWkgDQo+IENjOiAnbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZyc7ICdNYXJrIFJ1dGxhbmQnOw0KPiAn
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnJzsgJ3dpbGwu
ZGVhY29uQGFybS5jb20nOw0KPiAnamFtZXMubW9yc2VAYXJtLmNvbScNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzFdIGFybTY0OiBBZGQgd29ya2Fy
b3VuZCBmb3IgRnVqaXRzdSBBNjRGWA0KPiBlcnJhdHVtIDAxMDAwMQ0KPiAN
Cj4gQ291bGQgeW91IHBsZWFzZSBjb3B5IHRoZSB3aG9sZSBkZXNjcmlwdGlv
biBmcm9tIHRoZSBjb3ZlciBsZXR0ZXIgdG8gdGhlDQo+IGFjdHVhbCBwYXRj
aCBhbmQgb25seSBzZW5kIG9uZSBlbWFpbCAoZnVsbCBkZXNjcmlwdGlvbiBh
cyBpbiBoZXJlDQo+IHRvZ2V0aGVyIHdpdGggdGhlIHBhdGNoKT8gSWYgd2Ug
Y29tbWl0IHRoaXMgdG8gdGhlIGtlcm5lbCwgaXQgd291bGQgYmUNCj4gdXNl
ZnVsIHRvIGhhdmUgdGhlIGluZm9ybWF0aW9uIGluIHRoZSBsb2cgZm9yIHJl
ZmVyZW5jZSBsYXRlciBvbi4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dl
c3Rpb24uIEkgd2lsbCBzZW5kIG9uZSBlbWFpbCB3aXRoIHdob2xlIGRlc2Ny
aXB0aW9uLg0KDQo+IFNvIHRoaXMgbG9va3MgbGlrZSBuZXcgaW5mb3JtYXRp
b24gb24gdGhlIGhhcmR3YXJlIGJlaGF2aW91ciBzaW5jZSB0aGUNCj4gdjIg
b2YgdGhlIHBhdGNoLiBDYW4gdGhpcyBmYXVsdCBvY2N1ciBmb3IgYW55IHR5
cGUgb2YgaW5zdHJ1Y3Rpb24NCj4gYWNjZXNzaW5nIHRoZSBtZW1vcnkgb3Ig
b25seSBmb3IgU1ZFIGluc3RydWN0aW9ucz8NCg0KVGhpcyBlcnJhdHVtIGlz
IHRoYXQgYW55IGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb24sIGluY2x1ZGluZyBB
cm12OCBhbmQgU1ZFLCANCmV4Y2VwdCBub24tZmF1bHQgYWNjZXNzIG1pZ2h0
IG9jY3VyIGEgc3B1cmlvdXMgZmF1bHQuDQoNCj4gSG93IGxpa2VseSBpcyBp
dCB0byB0cmlnZ2VyIHRoaXMgZXJyYXR1bT8gSW4gb3RoZXIgd29yZHMsIGFy
ZW4ndCB3ZQ0KPiBiZXR0ZXIgb2ZmIHdpdGggYSBzcHVyaW91cyBmYXVsdCB0
aGF0IHdlIGlnbm9yZSByYXRoZXIgdGhhbiB0b2dnbGluZyB0aGUNCj4gVENS
X0VMeC5ORkQxIGJpdD8NCg0KQWx0aG91Z2ggdGhlIGVycmF0dW0gb2NjdXJz
IGV4Y2VwdGlvbmFsbHkgcmFyZSwgdGhpcyBwYXRoIGlzIHJlcXVpcmVkIA0K
dG8gaGFuZGxlIHRoZSBpc3N1ZSBwb2ludGVkIG91dCBieSBKYW1lcyBhbmQg
TWFyayBpbjoNCiAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMS8yMi81
MzMsDQogIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEvMjIvNjQyLg0K
DQpBcyBKYW1lcyBhbmQgTWFyayBwb2ludGVkLCBpZiB0aGUgZXJyYXR1bSBv
Y2N1cnMgYXQgRUwxL0VMMiBiZWZvcmUgDQpzeXN0ZW0gcmVnaXN0ZXJzLCBF
TFIgYW5kIFNQU1IsIGFyZSBiYWNrZWQgdXAsIHRoZXNlIHJlZ2lzdGVycyB3
aWxsIA0KYmUgb3ZlcndyaXR0ZW4gYW5kIHdlIHdpbGwgbG9zZSB0aGF0IGlu
Zm9ybWF0aW9uLg0KDQpTbywgd2Ugc2V0IHRoZSBUQ1JfRUx4Lk5GRDE9MCBk
dXJpbmcgRUwxL0VMMi4NClBsZWFzZSBzZWUgdGhlIHN1cHBsZW1lbnRhbCBl
eHBsYW5hdGlvbiBpbiB0aGUgZW5kIG9mIHRoaXMgbWFpbC4NCg0KPiBUaGUg
cHJvYmxlbSBpcyB0aGF0IHRoaXMgYml0IG1heSBiZSBjYWNoZWQgaW4gdGhl
IFRMQiAoSSBoYXZlbid0IGNoZWNrZWQNCj4gdGhlIEFSTSBBUk0gYnV0IHRo
YXQncyB1c3VhbGx5IHRoZSBjYXNlIHdpdGggdGhlIFRDUl9FTHggYml0cyku
IElmDQo+IHRoYXQncyB0aGUgY2FzZSwgeW91IGNhbid0IGd1YXJhbnRlZSBh
IGNoYW5nZSB1bmxlc3MgeW91IGFsc28gcGVyZm9ybQ0KPiBhDQo+IFRMQkkg
Vk1BTEwuIEFyZ3VhYmx5LCBpZiBGdWppdHN1J3MgbWljcm9hcmNoaXRlY3R1
cmUgZG9lc24ndCBjYWNoZSB0aGUNCj4gTkZEIGJpdHMgaW4gdGhlIFRMQiwg
d2UgY291bGQgYXBwbHkgdGhlIHdvcmthcm91bmQgYnV0IEknZCByYXRoZXIg
aGF2ZQ0KPiB0aGUgc3B1cmlvdXMgdHJhcCBpZiBpdCdzIG5vdCB0b28gb2Z0
ZW4uDQoNCkl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gcGVyZm9ybSBhIFRMQkkg
Vk1BTEwgaW4gQTY0RlggbWljcm9hcmNoaXRlY3R1cmUgDQp0byBndWFyYW50
ZWUgYSBjaGFuZ2Ugb2YgVENSX0VMeC57TkZEMCxORkQxfS4gDQoNCj4gQ291
bGQgc3BlY3VsYXRpdmUgbG9hZHMgYWxzbyB0cmlnZ2VyIHRoaXM/IEFub3Ro
ZXIgb3B0aW9uIHdvdWxkIGJlIHRvDQo+IHRvZ2dsZSBpdCBkdXJpbmcga2Vy
bmVsX25lb25fYmVnaW4vZW5kICh3aXRoIHRoZSBjYXZlYXQgb2YgVExCSSBh
cw0KPiBtZW50aW9uZWQgYWJvdmUpLg0KDQpObywgYSBzcGVjdWxhdGl2ZSBs
b2FkIGRvZXMgbm90IHRyaWdnZXIgdGhpcyBlcnJhdHVtLiANCg0KSGVyZSBh
cmUgc3VwcGxlbWVudGFsIGV4cGxhbmF0aW9uczoNCg0KU2luY2UgdGhpcyBl
cnJhdHVtIG9jY3VycyBvbmx5IHdoZW4gVENSX0VMeC5ORkQxPTEsIA0Kd2Ug
a2VlcCBUQ1JfRUx4Lk5GRDE9MCBkdXJpbmcgRUwxL0VMMi4NCkJ5IGRvaW5n
IHNvLCB0aGUgZXJyYXR1bSBvY2N1cnMgb25seSBpbiBFTDAgYW5kIHRoZSAN
CnNwdXJpb3VzIHRyYXAgY2FuIGJlIGhhbmRsZWQgYnkgdGhlIGZhdWx0IGhh
bmRsZXIuDQoNClRvIGtlZXAgVENSX0VMeC5ORkQxPTAgaW4gRUwxL0VMMiwg
dGhlcmUgYXJlIHR3byBjcml0aWNhbCANCnNlY3Rpb25zIHRvIGFzc3VyZSB0
aGUgY29tcGxldGVuZXNzIG9mIHRoZSBpbXBsZW1lbnRhdGlvbi4NCk9uZSBp
cyB0aGUgdHJhbnNpdGlvbiBmcm9tIEVMMCB0byBFTDEvRUwyIGFuZCB0aGUg
b3RoZXIgDQppcyBmcm9tIEVMMS9FTDIgdG8gRUwwDQoNCkZvciB0aGUgZm9y
bWVyIGNhc2UsIEkgc2V0IFRDUl9FTHguTkZEMT0wIGF0IGNvZGVzIHRyYW1w
X21hcF9rZXJuZWwuIA0KQW5kIHRoZXJlIGlzIG5vIGxvYWQvc3RvcmUgaW5z
dHJ1Y3Rpb24gYmVmb3JlIHNldHRpbmcgDQpUQ1JfRUx4Lk5GRDE9MCBhdCBF
TDEvRUwyLCBzbyB1bmRlZmluZWQgZmF1bHQgd2lsbCBub3QgYmUgaGFwcGVu
ZWQuDQoNCkZvciB0aGUgbGF0dGVyIGNhc2UsIEkgc2V0IFRDUl9FTHguTkZE
MT0xIGF0IGNvZGVzIHRyYW1wX3VubWFwX2tlcm5lbC4gDQpBbmQgdGhlcmUg
aXMgbm8gbG9hZC9zdG9yZSBpbnN0cnVjdGlvbiBhZnRlciBzZXR0aW5nIA0K
VENSX0VMeC5ORkQxPTEgYXQgRUwxL0VMMiwgc28gdW5kZWZpbmVkIGZhdWx0
IHdpbGwgbm90IGJlIGhhcHBlbmVkLg0KDQpUbyBoYW5kbGUgdGhlIHNwdXJp
b3VzIGZhdWx0IGluIEVMMCwNCkkgcmVwbGFjZSB0aGUgZmF1bHQgaGFuZGxl
ciBmb3IgRGF0YSBhYm9ydCBERlNDPTBiMTExMTExIHdpdGggDQphIG5ldyBm
YXVsdCBoYW5kbGVyIHRvIGlnbm9yZSB0aGlzIHNwdXJpb3VzIGZhdWx0IGNh
dXNlZCBieSB0aGUgZXJyYXR1bS4NCg0KVGhhbmtzLA0KWmhhbmcgTGVpDQoN
Cg==
