Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB742C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3A2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE3A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeK3OBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:01:02 -0500
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:63947 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbeK3OBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:01:02 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2018 08:57:16 EST
X-AuditID: 0a3808ce-4c9ff70000012663-75-5c00a1b6ee6e
Received: from xiaomi.com (cnbox7.mioffice.cn [10.237.8.147])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id A0.3B.09827.6B1A00C5; Fri, 30 Nov 2018 10:34:30 +0800 (HKT)
Received: from CNBOX5.mioffice.cn (10.237.8.145) by cnbox7.mioffice.cn
 (10.237.8.147) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 30 Nov
 2018 10:34:29 +0800
Received: from CNBOX5.mioffice.cn ([fe80::a441:9906:7f3d:1759]) by
 cnbox5.mioffice.cn ([fe80::a441:9906:7f3d:1759%12]) with mapi id
 15.00.1365.000; Fri, 30 Nov 2018 10:34:29 +0800
From:   =?gb2312?B?s8zR8w==?= <chengyang@xiaomi.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "d17103513@gmail.com" <d17103513@gmail.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: > [PATCH] Security: Handle hidepid option correctly
Thread-Topic: > [PATCH] Security: Handle hidepid option correctly
Thread-Index: AdSIUrWe0eC9m9UVRAeNHE6XCQ4Now==
Date:   Fri, 30 Nov 2018 02:34:28 +0000
Message-ID: <18d54cd3edbf4fd3a7c01962f41ead58@cnbox5.mioffice.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.235.66.235]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZjsu62hQwxBpe/SFlMb/SymLN+DZvF
        +s4bLBbTtkxgtHjX9JvFYvUmX4s9e0+yWFzeNYfN4njvASaL83+PszpweRx+857ZY+esu+we
        m1doeZyY8ZvF4/2+q2wem09Xe3zeJOex6clbpgCOKC6blNSczLLUIn27BK6MtTd+MhUsUK2Y
        /fMhcwPjEpUuRg4OCQETiWPvNLoYuTiEBLYySnx8c5YZwlnFKDFl7RZWCGc7o8SlRd/Zuxg5
        OdgEjCQmz+xlBbFFBGIkdm1ayQJSxCzwjUni6+UNYEXCAjYS7xY/hipylFi8+D2UrSfx4Mc8
        sBoWAVWJc/MfM4HYvEA1hz6cZwGxGQVkJaY9ug8WZxYQl5g7bRZYr4SAgMSSPeeZIWxRiZeP
        /0HFDSS2Lt3HAmErSqxceZsVoldLYl7Db6g5ihJTuh+yQ+wSlDg58wnLBEbRWUhWzELSMgtJ
        yywkLQsYWVYxSmbk56VnA3FxQWKuoV5uZn5aWmZyql5y3iZGUNRacJzbwTjhXeohRgEORiUe
        3g///kcLsSaWFVfmHmKU4GBWEuE918YQI8SbklhZlVqUH19UmpNafIhRmoNFSZxXZ+H9aCGB
        9MSS1OzU1ILUIpgsEwenVAPj1h8MC4VaJd/vOabZE/Rwu2OX38SJl8/zbe2MOLVEuqRqc7d6
        TKzJ4gWXD72Z/3bhzt/b1XKqexQdP128+pGzY0+Z19IW46dbNuy4/5R94o2nKbfKaqMZFy5l
        nqFWt2GurE75xCcvXijePHSX51dNK5NTWe6XNq1Mp5tN8/rN+LLKmDWlpk7PVmIpzkg01GIu
        Kk4EABDZmOfWAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVyZSBpcyBhbiBhcnRpY2xlIGlsbHVzdHJhdGVzIHRoZSBkZXRhaWxzLg0KaHR0cHM6Ly9tZWRp
dW0uY29tL0B0b3Bqb2hud3UvZnJvbS1hbmltZS1nYW1lLXRvLWFuZHJvaWQtc3lzdGVtLXNlY3Vy
aXR5LXZ1bG5lcmFiaWxpdHktOWI5NTVhMTgyZjIwDQoNCkFuZCBUaGVyZSBpcyBhIHNpbWlsYXIg
Zml4IG9uIGtlcm5lbC00LjQ6DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD05OTY2M2JlNzcyYzgyN2I4
ZjVmNTk0ZmU4N2ViNDgwN2JlMTk5NGU1DQoNClE6IE90aGVyIGZpbGVzeXN0ZW1zIHBhcnNlIHRo
ZSBvcHRpb25zIGZyb20gZmlsbF9zdXBlcigpLiAgSXMgcHJvYyBzcGVjaWFsIGluIHNvbWUgZmFz
aGlvbj8NCkE6IEFjY29yZGluZyB0byBteSByZXNlYXJjaCwgc3RhcnRfa2VybmVsIHdpbGwgY2Fs
bCBwcm9jX21vdW50IGZpcnN0LCBhbmQgaW5pdGlhbGl6ZSBzYi0+c19yb290IGJlZm9yZSBhbnkg
dXNlcnNwYWNlIHByb2Nlc3MgcnVucy4gSWYgb3RoZXJzIHdhbnQgdG8gbW91bnQgaXQsIGFsbCBv
cHRpb25zIHdpbGwgYmUgaWdub3JlZC4NCiAgICAgQU9TUCBjaGFuZ2UgaGVyZTogaHR0cHM6Ly9h
bmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2UuY29tL2MvcGxhdGZvcm0vc3lzdGVtL2NvcmUvKy8x
ODEzNDUvNC9pbml0L2luaXQuY3BwDQogICAgIEF0IGZpcnN0IEkgdGhvdWdoIHdlIHNob3VsZCBt
b3VudCBpdCB3aXRoIE1TX1JFTU9VTlQgZmxhZy4gQnV0IGtlcm5lbCB3aWxsIGNyYXNoIGlmIHdl
IGRpZCB0aGlzLg0KDQpROiAgV2h5IGlzIHRoaXMgY29uc2lkZXJlZCB0byBiZSBzZWN1cml0eSBz
ZW5zaXRpdmU/ICBJIGNhbiBndWVzcywgYnV0IEknZCBsaWtlIHRvIGtub3cgeW91ciByZWFzb25p
bmcuDQpBOiBTZWUgdGhlIGFydGljbGUgYWJvdmUuIEl0J3MgcGFydCBvZiBBbmRyb2lkIHNhbmJv
eC4NCg0KDQo+IFtQQVRDSF0gU2VjdXJpdHk6IEhhbmRsZSBoaWRlcGlkIG9wdGlvbiBjb3JyZWN0
bHkNCg0KV2h5IGlzIHRoaXMgY29uc2lkZXJlZCB0byBiZSBzZWN1cml0eSBzZW5zaXRpdmU/ICBJ
IGNhbiBndWVzcywgYnV0IEknZCBsaWtlIHRvIGtub3cgeW91ciByZWFzb25pbmcuDQoNCk9uIFRo
dSwgMjkgTm92IDIwMTggMTk6MDg6MjEgKzA4MDAgbWFpbHRvOmQxNzEwMzUxM0BnbWFpbC5jb20g
d3JvdGU6DQoNCj4gRnJvbTogQ2hlbmcgWWFuZyA8bWFpbHRvOmNoZW5neWFuZ0B4aWFvbWkuY29t
Pg0KPg0KPiBUaGUgcHJvY19wYXJzZV9vcHRpb25zKCkgY2FsbCBmcm9tIHByb2NfbW91bnQoKSBy
dW5zIG9ubHkgb25jZSBhdCBib290DQo+IHRpbWUuICBTbyBvbiBhbnkgbGF0ZXIgbW91bnQgYXR0
ZW1wdCwgYW55IG1vdW50IG9wdGlvbnMgYXJlIGlnbm9yZWQNCj4gYmVjYXVzZSAtPnNfcm9vdCBp
cyBhbHJlYWR5IGluaXRpYWxpemVkLg0KPiBBcyBhIGNvbnNlcXVlbmNlLCAibW91bnQgLW8gPG9w
dGlvbnM+IiB3aWxsIGlnbm9yZSB0aGUgb3B0aW9ucy4gIFRoZQ0KPiBvbmx5IHdheSB0byBjaGFu
Z2UgbW91bnQgb3B0aW9ucyBpcyAibW91bnQgLW8gcmVtb3VudCw8b3B0aW9ucz4iLg0KPiBUbyBm
aXggdGhpcywgcGFyc2UgdGhlIG1vdW50IG9wdGlvbnMgdW5jb25kaXRpb25hbGx5Lg0KPg0KPiAt
LS0gYS9mcy9wcm9jL2lub2RlLmMNCj4gKysrIGIvZnMvcHJvYy9pbm9kZS5jDQo+IEBAIC00OTMs
MTMgKzQ5Myw5IEBAIHN0cnVjdCBpbm9kZSAqcHJvY19nZXRfaW5vZGUoc3RydWN0IHN1cGVyX2Js
b2NrDQo+ICpzYiwgc3RydWN0IHByb2NfZGlyX2VudHJ5ICpkZSkNCj4NCj4gIGludCBwcm9jX2Zp
bGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzLCB2b2lkICpkYXRhLCBpbnQgc2lsZW50KSAg
ew0KPiAtc3RydWN0IHBpZF9uYW1lc3BhY2UgKm5zID0gZ2V0X3BpZF9ucyhzLT5zX2ZzX2luZm8p
Ow0KPiAgc3RydWN0IGlub2RlICpyb290X2lub2RlOw0KPiAgaW50IHJldDsNCj4NCj4gLWlmICgh
cHJvY19wYXJzZV9vcHRpb25zKGRhdGEsIG5zKSkNCj4gLXJldHVybiAtRUlOVkFMOw0KPiAtDQo+
ICAvKiBVc2VyIHNwYWNlIHdvdWxkIGJyZWFrIGlmIGV4ZWN1dGFibGVzIG9yIGRldmljZXMgYXBw
ZWFyIG9uIHByb2MgKi8NCj4gIHMtPnNfaWZsYWdzIHw9IFNCX0lfVVNFUk5TX1ZJU0lCTEUgfCBT
Ql9JX05PRVhFQyB8IFNCX0lfTk9ERVY7DQo+ICBzLT5zX2ZsYWdzIHw9IFNCX05PRElSQVRJTUUg
fCBTQl9OT1NVSUQgfCBTQl9OT0VYRUM7IGRpZmYgLS1naXQNCj4gYS9mcy9wcm9jL3Jvb3QuYyBi
L2ZzL3Byb2Mvcm9vdC5jIGluZGV4IGY0YjFhOWQuLmY1ZjNiZjMgMTAwNjQ0DQo+IC0tLSBhL2Zz
L3Byb2Mvcm9vdC5jDQo+ICsrKyBiL2ZzL3Byb2Mvcm9vdC5jDQo+IEBAIC05OCw2ICs5OCw5IEBA
IHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpwcm9jX21vdW50KHN0cnVjdCBmaWxlX3N5c3RlbV90eXBl
ICpmc190eXBlLA0KPiAgbnMgPSB0YXNrX2FjdGl2ZV9waWRfbnMoY3VycmVudCk7DQo+ICB9DQo+
DQo+ICtpZiAoIXByb2NfcGFyc2Vfb3B0aW9ucyhkYXRhLCBucykpDQo+ICtyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4gKw0KPiAgcmV0dXJuIG1vdW50X25zKGZzX3R5cGUsIGZsYWdzLCBkYXRh
LCBucywgbnMtPnVzZXJfbnMsDQo+IHByb2NfZmlsbF9zdXBlcik7ICB9DQoNCk90aGVyIGZpbGVz
eXN0ZW1zIHBhcnNlIHRoZSBvcHRpb25zIGZyb20gZmlsbF9zdXBlcigpLiAgSXMgcHJvYyBzcGVj
aWFsIGluIHNvbWUgZmFzaGlvbj8NCg0KIy8qKioqKiqxvtPKvP68sMbkuL28/rqs09DQocPXuavL
vrXEsaPD3NDFz6KjrL32z97T2reiy824+MnPw+a12Na31tDB0LP2tcS49sjLu/LIutfpoaO9+9a5
yM66zsbky/vIy9LUyM66ztDOyr3KudPDo6iw/MCotauyu8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4
tNbGoaK78smit6KjqbG+08q8/tbQtcTQxc+ioaPI57n7xPq07crVwcuxvtPKvP6jrMfrxPrBory0
tee7sLvy08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP6joSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0
dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3
aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRy
ZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwg
b3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5
IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0
ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioq
KiovIw0K
