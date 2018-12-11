Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2489120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2489120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeLKBRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:17:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:1235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbeLKBQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="282552266"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2018 17:16:14 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Dec 2018 17:16:14 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Dec 2018 17:16:13 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.59]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 09:16:11 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Topic: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Index: AdSQSf5rRH8ZTwaTR0Kl+UXxB6vgiP//fUMA//93HeCAAJABgIAAP2cA//572zA=
Date:   Tue, 11 Dec 2018 01:16:10 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
In-Reply-To: <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDFhYWRhZWItYTFiZC00ODUzLTlhYTAtMGEyYWZlMjViZTZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSlFcL2FnSXRpV0dmZlg3UFJRMDl0Sm5iZkE4cVM3clVGTUk3WkN2ZzVmMmpTQytPQmhaZmFhbjVTTUJWc3ZkaDkifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGV0c3VvIEhhbmRhIFtt
YWlsdG86cGVuZ3Vpbi1rZXJuZWxAaS1sb3ZlLnNha3VyYS5uZS5qcF0NCj4gU2VudDogTW9uZGF5
LCBEZWNlbWJlciAxMCwgMjAxOCA1OjU5IFBNDQo+IFRvOiBTZXJnZXkgU2Vub3poYXRza3kgPHNl
cmdleS5zZW5vemhhdHNreS53b3JrQGdtYWlsLmNvbT47IExpdSwNCj4gQ2h1YW5zaGVuZyA8Y2h1
YW5zaGVuZy5saXVAaW50ZWwuY29tPg0KPiBDYzogYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsg
cG1sYWRla0BzdXNlLmNvbTsNCj4gc2VyZ2V5LnNlbm96aGF0c2t5QGdtYWlsLmNvbTsgcm9zdGVk
dEBnb29kbWlzLm9yZzsgZHZ5dWtvdkBnb29nbGUuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGtlcm5lbC9odW5nX3Rhc2suYzogZm9y
Y2UgaWdub3JlX2xvZ2xldmVsIGJlZm9yZSBwYW5pYw0KPiANCj4gT24gMjAxOC8xMi8xMCAxNTox
MSwgU2VyZ2V5IFNlbm96aGF0c2t5IHdyb3RlOg0KPiA+IE9uICgxMi8xMC8xOCAwNTo1OCksIExp
dSwgQ2h1YW5zaGVuZyB3cm90ZToNCj4gPj4+IE9uICgxMi8xMC8xOCAwNTo0MCksIExpdSwgQ2h1
YW5zaGVuZyB3cm90ZToNCj4gPj4+PiBAQCAtMTMwLDYgKzEzMCwxMyBAQCBzdGF0aWMgdm9pZCBj
aGVja19odW5nX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0DQo+ID4+Pj4gKnQsDQo+ID4+PiB1bnNp
Z25lZCBsb25nIHRpbWVvdXQpDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgaW5pdF91
dHNuYW1lKCktPnZlcnNpb24pOw0KPiA+Pj4+ICAgICAgICAgICAgICAgICBwcl9lcnIoIlwiZWNo
byAwID4gL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzXCIiDQo+ID4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIiBkaXNhYmxlcyB0aGlzIG1lc3NhZ2UuXG4iKTsNCj4g
Pj4+PiArICAgICAgICAgICAgICAgLyogV2hlbiBzeXNjdGxfaHVuZ190YXNrX3BhbmljIGlzIHNl
dCwgd2UgaGF2ZSB0byBmb3JjZQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgKiBpZ25vcmVfbG9n
bGV2ZWwgdG8gZ2V0IHJlYWxseSB1c2VmdWwgaHVuZyB0YXNrDQo+ID4+Pj4gKyAgICAgICAgICAg
ICAgICAqIGluZm9ybWF0aW9uLg0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgKi8NCj4gPj4+PiAr
ICAgICAgICAgICAgICAgaWYgKHN5c2N0bF9odW5nX3Rhc2tfcGFuaWMgJiYgIWlnbm9yZV9sb2ds
ZXZlbCkNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBpZ25vcmVfbG9nbGV2ZWwgPSB0
cnVlOw0KPiA+Pj4NCj4gPj4+IAkJY29uc29sZV92ZXJib3NlKCk/DQo+ID4+DQo+ID4+IFRoYW5r
cyBTZXJnZXksIGl0IGlzIHJlYWxseSBteSBuZWVkLiBJIHdpbGwgcHJlcGFyZSBmb3IgYSBuZXcg
dmVyc2lvbg0KPiA+PiBvZiBwYXRjaDopDQo+ID4NCj4gPiBMZXQncyB3YWl0IGZvciBwZW9wbGUg
dG8gdGFrZSBhIGxvb2sgYXQgdGhpcyBwYXRjaCBmaXJzdC4NCj4gDQo+IFNob3VsZG4ndCBjb25z
b2xlX3ZlcmJvc2UoKSBiZSBjYWxsZWQgbGlrZQ0KPiANCj4gLSAgICBpZiAoIXN5c2N0bF9odW5n
X3Rhc2tfd2FybmluZ3MgJiYgIXN5c2N0bF9odW5nX3Rhc2tfcGFuaWMpDQo+ICsgICAgaWYgKHN5
c2N0bF9odW5nX3Rhc2tfcGFuaWMpDQo+ICsgICAgICAgIGNvbnNvbGVfdmVyYm9zZSgpOw0KPiAr
ICAgIGVsc2UgaWYgKCFzeXNjdGxfaHVuZ190YXNrX3dhcm5pbmdzKQ0KPiAgICAgICAgICByZXR1
cm47DQo+IA0KPiBvcg0KPiANCj4gLSAgICBpZiAoIXN5c2N0bF9odW5nX3Rhc2tfd2FybmluZ3Mg
JiYgIXN5c2N0bF9odW5nX3Rhc2tfcGFuaWMpDQo+IC0gICAgICAgIHJldHVybjsNCj4gKyAgICBp
ZiAoc3lzY3RsX2h1bmdfdGFza19wYW5pYykNCj4gKyAgICAgICAgY29uc29sZV92ZXJib3NlKCk7
DQo+IA0KPiBvcg0KPiANCj4gLSAgICBpZiAoIXN5c2N0bF9odW5nX3Rhc2tfd2FybmluZ3MgJiYg
IXN5c2N0bF9odW5nX3Rhc2tfcGFuaWMpDQo+IC0gICAgICAgIHJldHVybjsNCj4gKyAgICBpZiAo
c3lzY3RsX2h1bmdfdGFza19wYW5pYykgew0KPiArICAgICAgICBjb25zb2xlX3ZlcmJvc2UoKTsN
Cj4gKyAgICAgICAgaHVuZ190YXNrX3Nob3dfbG9jayA9IHRydWU7DQo+ICsgICAgICAgIGh1bmdf
dGFza19jYWxsX3BhbmljID0gdHJ1ZTsNCj4gKyAgICB9DQo+ICguLi5zbmlwcGVkLi4uKQ0KPiAt
ICAgIGlmIChzeXNjdGxfaHVuZ190YXNrX3BhbmljKSB7DQo+IC0gICAgICAgIGh1bmdfdGFza19z
aG93X2xvY2sgPSB0cnVlOw0KPiAtICAgICAgICBodW5nX3Rhc2tfY2FsbF9wYW5pYyA9IHRydWU7
DQo+IC0gICAgfQ0KVGhhbmtzIFRldHN1bywgSSBwcmVmZXIgdGhpcyBvcHRpb24sIHdoaWNoIG1h
a2VzIGNvZGUgbW9yZSByZWFkYWJsZS4NCg0KPiANCj4gc28gdGhhdCBzeXNjdGxfaHVuZ190YXNr
X3dhcm5pbmdzID09IDAgJiYgc3lzY3RsX2h1bmdfdGFza19wYW5pYyA9PSAxIHdpbGwNCj4gY2Fs
bCBkZWJ1Z19zaG93X2FsbF9sb2NrcygpIGFuZCB0cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlKCkg
d2l0aCB2ZXJib3NlIGxldmVsPw0KTW9yZSB0aG91Z2h0cyBpbiB0aGlzIGNvbmRpdGlvbiBvZiBz
eXNjdGxfaHVuZ190YXNrX3dhcm5pbmdzID09IDAgJiYgc3lzY3RsX2h1bmdfdGFza19wYW5pYyA9
PSAxLA0KaW4gdGhpcyBjYXNlLCBkZWJ1Z19zaG93X2FsbF9sb2NrcygpIG1heSBub3Qgb3V0cHV0
IHVzZWZ1bCBpbmZvcm1hdGlvbiBpZiBMT0NLIERFQlVHIGNvbmZpZyBpcyBub3QgZW5hYmxlZC4N
CnRyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoKSB3aWxsIG5vdCBzaG93IHRoZSBodW5nIHRhc2sg
Zm9yIGRlYnVnZ2luZyBlaXRoZXIuDQoNCldlIG1heSBlbmhhbmNlIGl0IGJ5Og0KLSAgICAgICBp
ZiAoc3lzY3RsX2h1bmdfdGFza193YXJuaW5ncykgew0KKyAgICAgICBpZiAoc3lzY3RsX2h1bmdf
dGFza19wYW5pYyB8fCBzeXNjdGxfaHVuZ190YXNrX3dhcm5pbmdzKSB7DQogICAgICAgICAgICAg
ICAgaWYgKHN5c2N0bF9odW5nX3Rhc2tfd2FybmluZ3MgPiAwKQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgc3lzY3RsX2h1bmdfdGFza193YXJuaW5ncy0tOw0K
