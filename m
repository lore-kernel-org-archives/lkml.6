Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D475720664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D475720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeJaGsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:48:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:41971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbeJaGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:48:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 14:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="103909753"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 14:53:28 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 14:53:21 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.34]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 14:53:21 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: RE: [Patch v4 13/18] security: Update security level of a process
 when modifying its dumpability
Thread-Topic: [Patch v4 13/18] security: Update security level of a process
 when modifying its dumpability
Thread-Index: AQHUcIX1hxicXgbmAEOLDSitei16taU4PnJAgACFdgD//42oYA==
Date:   Tue, 30 Oct 2018 21:53:20 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732148DCEC@ORSMSX110.amr.corp.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <e8b6b10e15653b3b2c5727e935f75142e441f834.1540923609.git.tim.c.chen@linux.intel.com>
 <99FC4B6EFCEFD44486C35F4C281DC6732148DC65@ORSMSX110.amr.corp.intel.com>
 <f63e412c-d768-9f47-7a47-953a15db5850@linux.intel.com>
In-Reply-To: <f63e412c-d768-9f47-7a47-953a15db5850@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjYwZDQ1MDEtNjgyNi00YTA2LWJhMDEtYzRiNTdmMzM0NTQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaWg5MXYyakdrd3ZhV25XNkhKV3ZxTnRPRURqeEhcL2RNOFRpS3J2VHRhQjlmWDVWbDBTQ0lqcFhYRmc5dHZuTUoifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gQ2hlbiBbbWFpbHRvOnRp
bS5jLmNoZW5AbGludXguaW50ZWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMwLCAy
MDE4IDI6MzEgUE0NCj4gVG86IFNjaGF1ZmxlciwgQ2FzZXkgPGNhc2V5LnNjaGF1ZmxlckBpbnRl
bC5jb20+OyBKaXJpIEtvc2luYQ0KPiA8amlrb3NAa2VybmVsLm9yZz47IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYNCj4gPGpwb2ltYm9l
QHJlZGhhdC5jb20+OyBBbmRyZWEgQXJjYW5nZWxpIDxhYXJjYW5nZUByZWRoYXQuY29tPjsgRGF2
aWQNCj4gV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az47IEFuZGkgS2xlZW4gPGFrQGxpbnV4
LmludGVsLmNvbT47DQo+IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgTWFs
bGljaywgQXNpdCBLDQo+IDxhc2l0LmsubWFsbGlja0BpbnRlbC5jb20+OyBBcmphbiB2YW4gZGUg
VmVuIDxhcmphbkBsaW51eC5pbnRlbC5jb20+OyBKb24NCj4gTWFzdGVycyA8amNtQHJlZGhhdC5j
b20+OyBXYWltYW4gTG9uZyA8bG9uZ21hbjkzOTRAZ21haWwuY29tPjsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LW1vZHVsZSA8
bGludXgtDQo+IHNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbUGF0Y2ggdjQgMTMvMThdIHNlY3VyaXR5OiBVcGRhdGUgc2VjdXJpdHkgbGV2ZWwgb2YgYSBw
cm9jZXNzIHdoZW4NCj4gbW9kaWZ5aW5nIGl0cyBkdW1wYWJpbGl0eQ0KPiANCj4gT24gMTAvMzAv
MjAxOCAwMTo1NyBQTSwgU2NoYXVmbGVyLCBDYXNleSB3cm90ZToNCj4gDQo+ID4NCj4gPiBUaGlz
IGlzbid0IGFuIExTTSBob29rIGFuZCBoZW5jZSBkb2VzIG5vdCBiZWxvbmcgaW4gdGhpcyBmaWxl
Lg0KPiA+IGFyY2hfc2V0X3NlY3VyaXR5KCkgaXNuJ3QgZGVzY3JpcHRpdmUsIGFuZCBpcyBpbiBm
YWN0IGEgYmFkIGNob2ljZQ0KPiA+IGFzIHRhc2tfc3RydWN0IGhhcyBhIGZpZWxkICJzZWN1cml0
eSIuIFRoaXMgZnVuY3Rpb24gaGFzIG5vdGhpbmcNCj4gPiB0byBkbyB3aXRoIHRoZSB0YXNrLT5z
ZWN1cml0eSBmaWVsZCwgd2hpY2ggaXMgd2hhdCBJIHdvdWxkIGV4cGVjdA0KPiA+IGJhc2VkIG9u
IHRoZSBuYW1lLg0KPiA+DQo+IA0KPiBXaGF0IGZpbGUgd2lsbCBiZSBhIGxvZ2ljYWwgcGxhY2Ug
Zm9yIHRoaXMgZnVuY3Rpb24/DQoNCmtlcm5lbC9jcHUuYyA/IFlvdSdyZSB3b3JraW5nIHdpdGgg
Q1BVIGxvY2FsaXplZCBtaXRpZ2F0aW9ucywgcmlnaHQ/DQoNCllvdSBkb24ndCB3YW50IGl0IHVu
ZGVyIHNlY3VyaXR5LyBhcyB0aGF0J3MgYWxsIHN1cHBvc2VkIHRvDQpiZSBiaXRzIG9mIHRoZSBM
U00gaW5mcmFzdHJ1Y3R1cmUuDQoNCj4gPj4gKw0KPiA+PiAraW50IHVwZGF0ZV9wcm9jZXNzX3Nl
Y3VyaXR5KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaykNCj4gPg0KPiA+IEFnYWluLCB0aGlzIGlz
bid0IGFuIExTTSBob29rIGFuZCBkb2VzIG5vdCBiZWxvbmcgaW4gdGhpcyBmaWxlLg0KPiA+IEFs
c28gYWdhaW4sICJzZWN1cml0eSIgaXNuJ3QgZGVzY3JpcHRpdmUgaW4gdGhlIG5hbWUuDQo+ID4N
Cj4gDQo+IFRoYW5rcy4NCj4gDQo+IFRpbQ0K
